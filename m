Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D926BC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D35588665;
	Fri, 24 May 2024 13:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jH5P8CTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACE3885C5; Fri, 24 May 2024 13:23:33 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBAD883DF
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6cayf+DtJPwDEwFk8X9COlxMVVCvYSGXtZmLefFlMvBrD5NT+LbeenDBhfvshsx3h1liBCCV9crn1nu7aFIfx55U+CcLAFDYKMLQQ24kwZ4LiI3lWt1+v4SXe2mwKn3dv4W2PWVc/ITCaEQt4KX39R3Opmb0ityIkLC3IHzEiepT3oo9efs3N7XiwobTcZ+/i9HCsxlGMOTm3gPeTkVyV5nk6vB+I21Tm+AW88m2zmGGLbV88er0Z/Ia6fuPx1JybiKIwdwuQWZbPQWv87Bn+iN4jm80xsZpeaXJat+JiEu7tnuMMcOzb3MpU8XJOYveONLLpDubnyltRrsSX1s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnnBkTSsGCbnnQks60Sfhs9230kTLvwBxmD3QlGgVGs=;
 b=TaqSf2rJrjGjvvI/ELG3D1pf0ma4rzXbVKhcqgdHan2o4Qgtv4c2plCiBj6kRnx8YHBGHCjeZhxvb00h+hQ5rvykLdgXrY2PR2Hr26a6E7M+ldZM1xfdhEoVdUjZ3KVbWk6i7Rz5PouC932JRKYp9tWh3f2wfKOLVxYGXRx58hIukCl81tOvjt63pafFLJ/1xr/q39e+Q8+yRQnS7OGu4Tvj/WF98fHgvFIj4DwaNtPVkidOgzuZnZzNeEu/hPP9JEDz3gSYEu/LN/LNo8OrttKOxr2+Iasf9iCaX20Y2ehE8ch4DAr8YJp9sRGQlCaG96C2NiXEC+fFe9QYHAp+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnnBkTSsGCbnnQks60Sfhs9230kTLvwBxmD3QlGgVGs=;
 b=jH5P8CTFinLrPFXYOnIAeZsbIRd2gHIgZTOEST+sQ6uW7RBohQ+LIkNV+w53/CRexyQnuXHgPglM/dzUIUq47JWbwBfzU575OhDRQaWaX0rM0rzbDOEWYzQa9MyXH2YY0y2eLE20GMZbtORAWvfN7AkK1gc6ncuoeM/7Sc89e5SV+9/KuVZnps46QLxJp7IwpeuN136W7P6tG7AJ2VIRtJCTYo9gsYUBo/JbtHjSk7hXhwUnFDXGtgELJiAkVZ3EQ5/002IJCtspGyCY2dx13GV1u1NxD25KPdq9pCs3q8OuhUgnqRvRmTQhOrjMgnaQ9Jcb0TPr9XDKKg2mEvPC9Q==
Received: from GVAP278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::12)
 by PAZP264MB2702.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 11:23:27 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::8f) by GVAP278CA0002.outlook.office365.com
 (2603:10a6:710:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 11:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Fri, 24 May 2024 11:23:27 +0000
Received: from sahess08-ThinkPad-T580.softathome.com (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id E70E3200DA;
 Fri, 24 May 2024 13:23:26 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 2/3] tools: binman: Add a property to pass a key directory to
 mkimage
Date: Fri, 24 May 2024 13:23:19 +0200
Message-Id: <20240524112320.103304-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
References: <20240524112320.103304-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PAZP264MB2702:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e9404a60-018e-43a3-f2a8-08dc7be3eec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQa6o057Omw23nEUmLR2C6o4jp5zYJk3zNbtSTp0KhFO4Cy6WtIfXwwNRDrU?=
 =?us-ascii?Q?lCJ58vhavpi4o9EX+a21jG9TcH6301Ihf6LNyuQPEsJNh8HmDKOfwavP+dmW?=
 =?us-ascii?Q?0zgO4CygX4uTWU3DypYyj4Um/fI2ezg6Jm4UBK7erhS7JdFvHxqmwRfzJJ3M?=
 =?us-ascii?Q?TtywvEcRh0PNF32Iw7rf7Nanbzkl0Qu3VZEpbd8Hj6WBmWOrUYYM1kwsO9AY?=
 =?us-ascii?Q?2piTztf6JGWxkzMkufT/VW2zg8dtammcazHR4qhTPxDOjIx+68HG5MYQzHnh?=
 =?us-ascii?Q?O+QSq01+rkYdOimSWz9kQL69pnJ2xl0IVQ49du6QpgKVdVr/d92DQ3dvF74y?=
 =?us-ascii?Q?Su3KNT9R+78dzU+DiT7fhTHmD6/ZYc87CB9HtoC6CjVjXiBTXmJUiLnkxFH0?=
 =?us-ascii?Q?pjaFHiLBthjJF3aSUy8A+aWgc14XXtWVMHiGmnxG/tLAXmJdsI7+j5fB7R3L?=
 =?us-ascii?Q?wO1gqYZ8tH/IhxL/iJZNifOHbDQ2ktD6NV/rbLoX8ZGe2EFuuwsKbo20KPTd?=
 =?us-ascii?Q?1kFYHnXVXYzNQoG7RbKw9WdiQt94374xGARn6DSAPYYK/ckx4/cxOix2MzUp?=
 =?us-ascii?Q?ijC8O47tWXooAgjAO4da5q8Zl2CWE4KewDTkLv/gKJUCj5Y6+iYDs7KV57Iw?=
 =?us-ascii?Q?OVxTTbJSI0BeGJU9v9wBfCIOuMSZTF+vQrQpOfwp9wx54LV3u9d+tqEsyJ3Y?=
 =?us-ascii?Q?aIaw1J6AanAtacYuEFP2UYxz5AOXodeSKZRqQDvxetRnXdQTKOMGuZ4Vif18?=
 =?us-ascii?Q?iSzGhCc3qyiS9swXLxFl6EI2TfV+J/0ytcOwh9uQQfAuANoGQm0DY6wbnOGr?=
 =?us-ascii?Q?7gxYklGL4KlKp5sjbQsx6ce3OAuoE/Pb0MR0S+hISwFmzTdRwzUt2yt8Z6uB?=
 =?us-ascii?Q?F6oJaum1+5voDXv9bufOPsd/c6xVDD94YiVB9AGAFqNg4Ukgi27uJ+knQP9X?=
 =?us-ascii?Q?K3bwl9EnH5qqsF4drOf94iBrhAH7fQM6Cg0KhYGDHIQG2dPxhumzM61CWWwG?=
 =?us-ascii?Q?1nJtbwae7vLuySj+iuOfBKH2VL61keQRHBdemBWbMAQqSFlAdRv6IZRJF2r9?=
 =?us-ascii?Q?XImbULdI+d+cRQSAaM+288zQ1LGrJX4BOA+O211BkQ8vzRsZWNbylTnYBGjq?=
 =?us-ascii?Q?voQHJhUg+MJZfQighINAY2DIpC0kusyErL7kzxfErGeJ78v8pLPZQrUoa6Z+?=
 =?us-ascii?Q?w01a2j377MPvb/TzcnDWD+r90TY4SN8B38D6uDLBMWxkGbYj673KcgXzxrjb?=
 =?us-ascii?Q?Q1W73m3gwDhgN+z9DxEoqt02PsD1ZUcx25gvKDQgXUcsWVPE5Bh74Gu6pynn?=
 =?us-ascii?Q?h8w3TqAVDfHaNH21oOtwy5w8yQ6GJ6zZAgwZoaa04ooJsyob1HioKqTLDqAt?=
 =?us-ascii?Q?rC6wm+eQt1Jtc2Xvsw5sOx/cJdtY?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 11:23:27.2714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9404a60-018e-43a3-f2a8-08dc7be3eec0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2702
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The property 'fit,keys-directory' can be added to the configuration file
passed to binman to specify a directory where keys are stored and can be
used by mkimage to sign and cipher data.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/btool/mkimage.py | 5 ++++-
 tools/binman/etype/fit.py     | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 39a4c8c1432..dbcf8daac30 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
 
     # pylint: disable=R0913
     def run(self, reset_timestamp=False, output_fname=None, external=False,
-            pad=None, align=None):
+            pad=None, align=None, keys_dir=None):
         """Run mkimage
 
         Args:
@@ -34,6 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
                 other things to be easily added later, if required, such as
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
+            keys_dir: directory where keys are stored
             version: True to get the mkimage version
         """
         args = []
@@ -45,6 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-B', f'{align:x}']
         if reset_timestamp:
             args.append('-t')
+        if keys_dir:
+            args += ['-k', keys_dir]
         if output_fname:
             args += ['-F', output_fname]
         return self.run_cmd(*args)
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 2c14b15b03c..08fc08ec767 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -460,6 +460,9 @@ class Entry_fit(Entry_section):
         align = self._fit_props.get('fit,align')
         if align is not None:
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
+        keys_dir = self._fit_props.get('fit,keys-directory')
+        if keys_dir is not None:
+            args.update({'keys_dir': keys_dir.value})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():
-- 
2.25.1

