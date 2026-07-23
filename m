Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B78C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0EAB607D5;
	Thu, 23 Jul 2026 09:38:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTlEPUQ_XMT1; Thu, 23 Jul 2026 09:38:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B84766079A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799536;
	bh=w4g71JhDTz0cf6QwrwKAkCib4IoEymoWfKAnu3Gjxr0=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kMbxLV7rBw3Cx3qmRS/Q38L0dTEFIg1JYYCX0M5ViCFtczYSDhn676c5SR2l8w6NI
	 diBolFifevfhqN2ZMLXmX83b+/7BwMu3uFx0nzAPOdjbdBny6mIYuylhCW6nocez6H
	 IhdYdI44+Vb3aV7uturkFlabNoPuyMHwuejhXSVjOEXkoNPMpBHQ1LLeFrqpyzsJK6
	 h8gonfcscaub2dt8A3iJ2r4yxgGNOgREDmg+yMoRfklGkMYvm2jgzvqSmXUV88DSIF
	 QtOXHgcZ7LQwaM7FD4A27H3qV/hMlSj+f+7/kFVx4xitLYQHzM6X8+S9T9uS+gjWwO
	 mVWTM/9QwId6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B84766079A;
	Thu, 23 Jul 2026 09:38:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D077596C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C16FF40363
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6kbV-1WDKt3K for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E288F40026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E288F40026
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E288F40026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYoXuafBaK+wNJ35RwvzP2OaPqrohhatDPIqDJkKTRzhYBGh+h2OpLTrPbU6Ym1IFwAN0/NAqPgu0lelmGm1VqpZVK1ORhduYG2YxYV8a1v6BI6g3GAsBejm5RRzmWpGDR4dsMbAocLntkRLIo+mQLly99pugLYjoTQCj6DcB8lNpHtwpDh7rUtL540cEy08tZKV5ZIqirtTtHYazL7hG+1Lao3VthHj+iFJRjWa1xDnCsYMsBpSDcKkyCy71TA+GqInblyW3pioo9LrGhqPbkmIT8GahFyQvmdQzLCKs6Fne/uGY3IAKqYPsn6ACwySYrDdHW8cC4/tqBDofWdRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4g71JhDTz0cf6QwrwKAkCib4IoEymoWfKAnu3Gjxr0=;
 b=ka6cHk8sDwk9Q5VHLDAvWJH1ADEebpKOnowcdV8A0h0wraCmXHta8ButMnxEP07rsEAX1i6av48XcojDOKXgttOeQSLk9HmtYe+5zbneHD/JfYlMG4jS/Unvum8OozOaG/2g90/3d/NntQ0u9TnnsfYAiKyBNieNctnDL2nvTYFoKZieth1Y8V5fOTQS6O3KT/I2+SVA9y+uHYVpwWFAxkAdVclH9TV59edlbXnl9+RCit4UdB2Flm4I7UXOJGOP6J/SS1w/P8yXPf8atkGWHrQQ5djMsaAAs8m+heVOxlShHAUudJJvG/sRzziv1p2U8X9Sw91Yg4NZGlQQtNNjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:36 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 1/7] binman: openssl: refactor creation of Distinguished
 Name section from dict
Date: Thu, 23 Jul 2026 11:38:23 +0200
Message-ID: <20260723093830.3132465-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 70eb150f-fa7e-4de6-6e84-08dee89e2b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3SMF3ACiH5a79/QMORaJsWg/60sUOa4/6AdzgOZqL5Lg5ZoxStbfuzMR0/598kAiCafRKn1tOPYevrg3qkumHURFMkdcZXRbdse1n0NmtNALeKNBgs5gFtTx8RkA0JzbdYN2vkSEJEO7cGjHe46XyQ2zi/9mWSanQ94c2fehYF7u/gZj/99FZqeAbih7aVhP0gk5s7UONgcTy5KVMRVV2AkpTFP5aqscJ7fTsxcG3jvnYb0zt80aP1fkq4enxc9uHKSxLyQM7PoB6DQFEINOUWqSUPbwIQmij61q9qpoi4owfjTk2rcDeQ7cnu/UuXr5Jfa8z+o+UeTpH2uJyfr28RxMNLVFaXHlhsPfAj37oatNBBKti2pdFxYUiJFAcff6YlMTfYHhVMbP2mm+kSrI7lvj+AjNrMOE/VCdHUAsLY6U3ybXr1JZlEMNLPdK9Nek6RWBW7G0qdTPOPzGUisTwtC1KzVfA9r4i9Vn4A3tobU42qfkMG16Nn+wPoPbjiRLOHU5ZsvcFJZdnTfgjWAcbltYII+VKYrcqrLSeef8uWfpKgJuoQwvlJqqWiPk1Pbwahu+vjZtnAUB4seOvtYyeNTihyA0GOeYIaykuo6egFT9D8WnsRlpH9I5i6+lNQEjMm6bPgUHXLPU0wBFEI6ZlKN34xRi97D0roHQU+rJ4hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr/NfH7oJie135LGmLO80qof6j/kAXsePGMGEV0RXcnKK2ut+cJzIqD4k5PI?=
 =?us-ascii?Q?b0IfpMSTByTvNQyRWM2xhiWdBZoJlJ6C9mXP4ch3igP/sJS4OA1GyOzBey4p?=
 =?us-ascii?Q?VK3DCdjWZmqyNfrvgGRfLdVNG7ic7S8hEHySMnGQW0IGzHsEDNYMZQDfnsHN?=
 =?us-ascii?Q?jSEcT6uFKo31RiecSfnlsYoq3pD8vQL6mkJiGfRErxkbA6iB6fT/vAX/+FL0?=
 =?us-ascii?Q?55cVn3Z+uaWfDC5V9HTpQVTeO5k5Z8NpzV1QtLcQr0KVUfotRMQSbigbwEnq?=
 =?us-ascii?Q?jdQ7IRb2z9ZNNob8rtasOXoxWiTPWEYZVr8809b8T9J+fAn9ooAmPXyFq4SO?=
 =?us-ascii?Q?7bbdGTZQ8ftvqUxiWGvqGMSVsc9HXBqWk8nmwXuJJFknE7eiuqGxjxYbSaoY?=
 =?us-ascii?Q?5JYznZUbsyuiqb6fFySwmKsiWzMj5+tzeaZJR7BQejVPEhM6pYga2E411xZB?=
 =?us-ascii?Q?MMtHelds0FB5OmYpTn3/JlpML7Kga7XWyxuOwNE/aepefWUfLMJDb+CmDIrA?=
 =?us-ascii?Q?7drG2jEyobzCBOkswcDXihd/9DGPF+R4RjPXNpiKCayk6KTYgV07+KdHGEh0?=
 =?us-ascii?Q?DmWl8cFujYFvHg5WHQisIWVzPGtD49tnv01l4AD6aMcxhLy62c5bZaSlcih+?=
 =?us-ascii?Q?x4Dxfo/Xi+1tJ/Jp6/9pPbX+lahu2j5i5tN7r+Mn9Q3Pn7R1lPh5Q0oiwQCS?=
 =?us-ascii?Q?fhRBzhUN/TE6ghgg06HCjk/VpxcK84JAThmzY2nkYZr962o3aKj+DOggbt0p?=
 =?us-ascii?Q?5U593ARlGlmBH86+r2fXKyBIu7sOXqxH9H8SNxTuCdJa635+khG6mTAKu8n+?=
 =?us-ascii?Q?intwtwrtTMRknMVMT7Y/uZufiZHPJHLQdFmkNLXYLKqHFlMvwNNpmBlUlXC9?=
 =?us-ascii?Q?fLiSBLSDvA9VYI6qsdJxbRPHg9JcJhMtmFYC6yvvTN884ZBt9cGdbdJacAJf?=
 =?us-ascii?Q?I61jwfErk4SVtvpedEBh8hSHr6YetZND+u6+uhhtkOtKubii9kST19jI7MKW?=
 =?us-ascii?Q?A0Jjmfb0O6oMy8ucEzX9SsK2oJFbS3F7ZUcT5K9WIuYrC/5xO6TBP+hK1JtE?=
 =?us-ascii?Q?5yttKK4ilxqiDVBs2/rk2600ILad9S/KOlLpJGbk+Hqxwnntnih8IyxaZ7d6?=
 =?us-ascii?Q?SGJ+O8VaPZpxR6/WPnNvOeIIwISJtQkZ0xZ7fOoslNMiYeIlEtd6qAMpjcDR?=
 =?us-ascii?Q?7dXQ63if6AOdK+PI3J4a85AazDIu7DDmLlGlTXUqIMWKXt1ZwOd0YSGDa6Nl?=
 =?us-ascii?Q?aGSjSnUvloPPTVez0p4SSA6D2mTEtYV0LmQ5ZX3RFrkwvKyN1JE3kmEGkuaz?=
 =?us-ascii?Q?XSFezlmBaFnjjGA9z/XQKTG+BmjF946FzsjQFjOe6eCvYfmCcy/qNP4VDEV5?=
 =?us-ascii?Q?I/SAClzxykR0XgOHgAZw6hTmeyiP3g1MD4IpnR3CADU5vqIuKmyAHcpeT9fy?=
 =?us-ascii?Q?nbZnQe6VVGL1GVfyNbUVdoIT2H7QloTSPlGdAvwSnvpNqc69++K+v/zcIpFH?=
 =?us-ascii?Q?xaCnfXvT++AJ4Xk2bjhtwGMf96QmUA87NQJUsBx/WDOlMgj0bISsASiRB+be?=
 =?us-ascii?Q?LgWlgSb/McGISlQAZPauIln+s4R7O/+sW9lRnqblIDwutCQpoSQkRoh+Vfcq?=
 =?us-ascii?Q?bsG+1sWjZ/iZt4zZdzEXopgwEX3E257WuDCNdVMTDRImyCzlgkm6V6PlP3Xl?=
 =?us-ascii?Q?j3KY2WOWelG3S/KufSALRmRTeD87ecta0bwd2hckGFUVD/45yiVUWcRnLCIp?=
 =?us-ascii?Q?XuBh7rSkxd8Xr+VywFn5U8E/kOke65A=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eb150f-fa7e-4de6-6e84-08dee89e2b01
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:35.9051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUF9SdeSUrHpKlPlHcwtq+umQnLyIHce6zp8AhHuO4hrUuBLMEym96tqODLRVX6jsGO/SwPjdw7Px9YKVMHcZ2K9OhexveDvHhhmrZ4pyNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4g71JhDTz0cf6QwrwKAkCib4IoEymoWfKAnu3Gjxr0=;
 b=Hd2pyVEsrN0qzdx+bt8RAP0azZCy/6joRgorFsyOa3BrM4MhmMSRgrFVzj0x6cSUktMmUyARGhU6RTaV2+0ZUBXkURoo2fX2IDNZUm5g1J3+92nVfjiY3BbZegeYS6I15peqDy1hnoe3mBDCcOgcUvutpPBCMKapLAl5q2Dn/d8=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=Hd2pyVEs
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Instead of manually expanding the req_dist_name_dict, create a helper
function for creating a config section from any dict. That will also
automatically allow other fields to be emitted.

We can allow a field with multiple values, e.g. "OU" -> ["First OU", "Second OU"],
and encode that in the config file using

  1.OU = First OU
  2.OU = Second OU

as documented in 'man 5 config'.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/binman/btool/openssl.py | 58 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..84413428e1e 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -36,6 +36,28 @@ class Bintoolopenssl(bintool.Bintool):
             name, 'openssl cryptography toolkit',
             version_regex=r'OpenSSL (.*) \(', version_args='version')
 
+    @staticmethod
+    def dict_to_config_section(section_name, data):
+        """Generate a section for an openssl config file from key-value pairs
+
+        Args:
+            section_name: The name of the section
+            data: dict containing key-value pairs
+
+        Returns:
+            A multi-line string containing the section definition.
+
+        Each key must be a string, each value can be a string or a list of strings.
+        """
+        sec = f'[ {section_name} ]\n'
+        for field, value in data.items():
+            if isinstance(value, str):
+                sec += f'{field:22s} = {value}\n'
+            elif isinstance(value, list):
+                for i, s in enumerate(value):
+                    sec += f'{i+1}.{field:20s} = {s}\n'
+        return sec
+
     def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
                   config_fname):
         """Create a certificate
@@ -92,8 +114,7 @@ imageSize              = INTEGER:{len(indata)}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             firewall_cert_data (dict):
               - auth_in_place (int): The Priv ID for copying as the
                 specific host in firewall protected region
@@ -114,14 +135,7 @@ x509_extensions        = v3_ca
 prompt                 = no
 dirstring_type         = nobmp
 
-[ req_distinguished_name ]
-C                      = {req_dist_name_dict['C']}
-ST                     = {req_dist_name_dict['ST']}
-L                      = {req_dist_name_dict['L']}
-O                      = {req_dist_name_dict['O']}
-OU                     = {req_dist_name_dict['OU']}
-CN                     = {req_dist_name_dict['CN']}
-emailAddress           = {req_dist_name_dict['emailAddress']}
+{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}
 
 [ v3_ca ]
 basicConstraints       = CA:true
@@ -163,8 +177,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             cert_type (int): Certification type
             bootcore (int): Booting core
             bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
@@ -184,14 +197,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
  prompt                 = no
  dirstring_type         = nobmp
 
- [ req_distinguished_name ]
-C                      = {req_dist_name_dict['C']}
-ST                     = {req_dist_name_dict['ST']}
-L                      = {req_dist_name_dict['L']}
-O                      = {req_dist_name_dict['O']}
-OU                     = {req_dist_name_dict['OU']}
-CN                     = {req_dist_name_dict['CN']}
-emailAddress           = {req_dist_name_dict['emailAddress']}
+{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}
 
  [ v3_ca ]
  basicConstraints = CA:true
@@ -252,8 +258,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             cert_type (int): Certification type
             bootcore (int): Booting core
             load_addr (int): Load address of image
@@ -274,14 +279,7 @@ x509_extensions        = v3_ca
 prompt                 = no
 dirstring_type         = nobmp
 
-[ req_distinguished_name ]
-C                      = {req_dist_name_dict['C']}
-ST                     = {req_dist_name_dict['ST']}
-L                      = {req_dist_name_dict['L']}
-O                      = {req_dist_name_dict['O']}
-OU                     = {req_dist_name_dict['OU']}
-CN                     = {req_dist_name_dict['CN']}
-emailAddress           = {req_dist_name_dict['emailAddress']}
+{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}
 
 [ v3_ca ]
 basicConstraints = CA:true
-- 
2.55.0

