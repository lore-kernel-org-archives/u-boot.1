Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73395C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF50383845;
	Tue, 27 May 2025 15:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Av+qLuga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8C6830AF; Tue, 27 May 2025 15:24:39 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DABB8309C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0owT7ipX5og0iyJfj4s9bjgPETWBaYJEZSBjNEzaVaJlizzTG33Nelqp6dnCol9Qo2bQZDP9U2MD5rkscCxw8jq/FfbGR/inL7nqRSbx4ZBfXk2vbWcoeokhe7MJBD7Ai54TSVGavZx85bUGfm6j+7xJjsT+5BNgADNGaMyuIFjFmwM31sDZKcY9lvPeFizoM1jvLSP4ZCC6e4E+8+pM7LW648yfNTmXurT0w1CgOielKqwU4AFG+ZY/YLqa2jqQBEtRUqn//yqnT2pueLz5BkU0q5v0rMRKgx4ichJPJtw3xkcbsg7nhBXxverIqrxnJAoI0E7BBOYvCuLk7P3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Y2pS43JaU9M+2CFKMm5HIEsON4R71Uu/Ivz0J2fvg=;
 b=A48kkNtGPr/N26zuklBm8weGACt9LrmuHMd9ixuYvKn5BzwiJzUssNweamnTtWmoPgLua965FHJ50Trx14i0h96MRHfPQ0KDIOwRtVo85jGuoyf2Xa9uWkRhq+kc30dJ47/czDzlu6D+5hVjROFF9YMKCA+MywAgikzKt82t0X9BwqzDddp7wGiEAioYgH0u5yoPuiGni8I7HELIJO2wO6FdSsZcJ5P/ELGhNTvVBjw6zfnUkr1nNAdshpU77EOxfyhb2080rWNCAYmb72xOo+/4ZTCKh3OYGU9npXD4fnvB17Zo/MChpAzUasQArIYDPCK/PGcN6N3r5vmR70UxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Y2pS43JaU9M+2CFKMm5HIEsON4R71Uu/Ivz0J2fvg=;
 b=Av+qLugaRlcEfHfUd/jnoH5nFTSCxRSTYJd1X+a5CdU5TR5iHuM9X2mGRqtURVfY/v7lavDTlSmOJUeiJKpSV7Voy3doNG2x9oos2qoFvVfR4xA97Ih9Y75izUWZ4noHt5vccX8p35NteoQ2AeaukmjQTdd73n4KP3orsDyUDJ4CMW4PVShiWjIOU6qzpJUxIKp0RLr4SQcvF4iuFDXm/xFQywqyldzDHevgABixNQ3bXlkmRyGN9wFI3N8Md2GrcZJ+gZRs4raDGuOg33aP+bkaOlGtfkbu1bEkzcAMc2vaRsdzdx485G2JQ0IJz+M1sZxYJr/xKwfHlWgp1HaLuA==
Received: from PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::12)
 by DB8P195MB0743.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 13:24:33 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::b7) by PR1P264CA0025.outlook.office365.com
 (2603:10a6:102:19f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 27 May 2025 13:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:11 +0200
Subject: [PATCH RFC v2 3/8] tools: binman: mark optional missing blobs as
 absent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-3-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=2332;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=hZDxdIsRIPCqCfjpYs4RSkZ1n6m9AgjHemeGIT8z6XM=;
 b=wW57RhJtDT45MUvyoGwZV2m6uKLSq978THGJrLymvns/45WcCIdG2mHPxzfbR+GiclMiRqk0P
 tJ6HV14oQt2CPXHYHFxKBj0aBSJ67VamOkLNA0+buUaNXHgT21qw/S6
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB8P195MB0743:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d469f5-8447-4a3d-57b9-08dd9d21d1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTQrZ3Y3bS90c1paY1RqUUVKTDNORXVOS3p1Zkh0dEpNdzFpa0NlNmY3UWI1?=
 =?utf-8?B?amJ3ZlBQYWNhRGxQaVlqeEhXejVqVlBXOHlqcjRnV3hBOXRYeEJLY1ZrNVFF?=
 =?utf-8?B?cWxocVYxVnZrMWU5OE5aRlFBcCtBMEkyK0VST1ZvaC96M3l6YUREdWxjTmRM?=
 =?utf-8?B?VCtNZUIrSmdSWGxWbHRjRjY2ekpqV3B0WDhGRjZpTUVWaHBGbFJ4VjZEenBV?=
 =?utf-8?B?dXJLZEEvcFFJTk02Q2dBSDNGRHp5SXBIOGZSaFRQWmc2bkF1NzYrVGV3bjkw?=
 =?utf-8?B?V1ROKzkvT1RiMWtFVGJyUzlteFFPQlhKcy9oM3AyU1JoMUpWdEIyamMwZlRY?=
 =?utf-8?B?SDBJQzdpN3p2UUN5NU9QRkxHTEpIZE1xeXp4VEVIOTl4VUlVYTFFUWVuN213?=
 =?utf-8?B?OHlvbUxXQnFOUUV1YmIrd3VXQzBDMWpycWxHWkdDQmVlU3FsbWc2MHNpQjdT?=
 =?utf-8?B?RmFnbkpBbEZVaHZrVFgrakE1REZyOVpRVHQza2p2OURhYjRFTkUwQjN2TG9z?=
 =?utf-8?B?K2JieS9nOWZkbWJ2eG9yZUFRZVkramNjaHlPUEZpb1VDNnlUWkFUa08raFdv?=
 =?utf-8?B?QkxyWEFtYmxrUCtJVVloaTN2OFlDNnA4NHZUdCtDZ2doRzA3MGdKT0ZrcmJJ?=
 =?utf-8?B?K0RlVGkzL2tzNmhvS250di9SVGpIaGl4MVBqblp5RzFrM3k0NCtnUld5VHVX?=
 =?utf-8?B?NnZXTUhpU1ZYVmQya1dWaDNDT21KM3lsVzcxYm9WeW1wY3FpTTZmN1hkUko4?=
 =?utf-8?B?Q3ZCWCt5djB6QzNSV0dyOS8vU20wZzhta2NDR2lYU3hUV1UxN0ZrVUd0aDk1?=
 =?utf-8?B?TWZvbkptUWtpYm56TGVpZkkyV3F1T01mcjZQb25NWm9BQ0JLOWJOK2c0c2o1?=
 =?utf-8?B?aCs1L1ZhTEpCK2czbkdlMWQ0VlpQaFhsMW9MNDliUFJWSzZ6bDQ4MWdwWXk3?=
 =?utf-8?B?NHdWZGxhRU5DTjRqWmhNVTI3M001SVgvd2FoTVRHSUFPNTlRUFdaQU5PbDRP?=
 =?utf-8?B?RWZDczg3bXdGbzV3alZTY2JOYTdmSHV6WjVMOWF1d092YmE1dzYzTHU0NGJ1?=
 =?utf-8?B?TkVlWUxmU0V5RGQ5ZEdCSUdJUmFlYW5CQXAzdEpnb2w2c3E2OWhmTEJUMkQz?=
 =?utf-8?B?emlPSDFjLytxTWZMRDA3dUlocWdacDhtMll6UU1XNUdSN0J0Tm1yV2dJZVFt?=
 =?utf-8?B?ZnRFS3BtR1hEdkR0UGw2OGN6S3RHVC92dlkyUzN0c2lhdmdNYTFSbUtvKy9J?=
 =?utf-8?B?ekhUZ2pIS1VZNFkrT0FjYlRUamsxZTU4RHpmR2tTZktiZlAxcVJNQi9aSVdE?=
 =?utf-8?B?YUdxS01RdnhSV2htTWdjdGRMeTRDbzV6dGlHR0FPRG0wS3kyMjJ4bk5pOVlH?=
 =?utf-8?B?M3JnYzNrL3YxNHVQUi84K2xoVXljSi9wdlZGT0tEemkxQ1RPV3RqM3B1UUxQ?=
 =?utf-8?B?MEtLWWM1WENEdnlKSlVCemhGYTVLZFFRZTFjZlhMTjVQbEJhdjNWMGVZWHZ1?=
 =?utf-8?B?bkJiUE8xaDMzNmNzOWxYR2xLZlVDRDZrcVRDK21aQ0FUMVd0MHlBS3VqL0NH?=
 =?utf-8?B?cVcwZlFQUVExd2F3TlZRSGZwTW0ydlR6OUVYM2xBbTBOR2oxSitva0hnUzR4?=
 =?utf-8?B?SExRYy9yb0lKcW1CLzhmWFh2YzQwdS94SmhOUHNvejQ1MVR3cVNGNkNaaFRy?=
 =?utf-8?B?Y0FNd1hFVmpIak1LZWpuRnVNWGhHWEViOWtESm9XZTNkYjlscXBxVC93THFX?=
 =?utf-8?B?UVQrNGRaQUJhUi9OdFFVU1A5TGpyUXlqQzdNeTkxc3k5SS9jR1ZwOEpnN0Qx?=
 =?utf-8?B?M3U3QUREWU1rVy9lQjlMSmljQm5JWjBmSjNGQ2IzeVdoZWpzcFdrYTJqL0hR?=
 =?utf-8?B?cWREN2FMTjhMZmlMU3kzc3YxQUxBbEFGdWJ2UTNmb04wSW44MVFrbGhKNzJB?=
 =?utf-8?B?QWQxV3dBNXBrMGh6V2tDaSt6UDgwSisxbHI2UEVIaDg0T0o5R0doTHNUcWxM?=
 =?utf-8?B?K2cvTWNYdGJZUXc2NEJrVnpsV05hMUMxSVBUWU1JL0dsTytmbHlqdFBSY2xo?=
 =?utf-8?Q?aJ5dgf?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:33.5240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d469f5-8447-4a3d-57b9-08dd9d21d1ca
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0743
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

Optional blobs should mark themselves as absent to avoid being packed
into an image.
Extend the documentation of this behaviour. Although the documentation
implied this before, the "optional" property had not been explained
properly before.
Note that the intended behaviour is the same, this patch just documents
it.
The actual behaviour will change as now absent entries are no longer
packed into an image. The image map will also reflect this.
As a result, the CheckForProblems() function will no longer alert on
optional (blob) entries. This is because the missing optional images
were removed before CheckForProblems is called.
This, as well, is intended behaviour.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/binman.rst    | 7 +++++++
 tools/binman/etype/blob.py | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 84b1331df5c006f72167016b7f33de73f4a269fa..392e507d449c75eeba4431fe2db01d820bce8f61 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1143,6 +1143,13 @@ Optional entries
 
 Some entries need to exist only if certain conditions are met. For example, an
 entry may want to appear in the image only if a file has a particular format.
+Also, the ``optional`` property may be used to mark entries as optional::
+
+    tee-os {
+        filename = "tee.bin";
+        optional;
+    };
+
 Obviously the entry must exist in the image description for it to be processed
 at all, so a way needs to be found to have the entry remove itself.
 
diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
index 970fae91cd9b2a31b3f31d2ecdb77e27a89d69fb..acd9ae34074e4b4b9792b107cc80514dfdd88b3b 100644
--- a/tools/binman/etype/blob.py
+++ b/tools/binman/etype/blob.py
@@ -52,6 +52,8 @@ class Entry_blob(Entry):
                 fake_size = self.assume_size
             self._pathname = self.check_fake_fname(self._filename, fake_size)
             self.missing = True
+            if self.optional:
+                self.mark_absent("missing but optional")
             if not self.faked:
                 content_size = 0
                 if self.assume_size: # Ensure we get test coverage on next line

-- 
2.43.0

