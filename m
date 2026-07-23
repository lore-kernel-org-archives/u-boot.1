Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207E9C531CD
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFA0E80EC9;
	Thu, 23 Jul 2026 09:38:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijj7KhwwkawV; Thu, 23 Jul 2026 09:38:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 232E880EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799535;
	bh=HPq7Hmnqpe/kQk14GWluVijmS5HN0q9q9zQTbQr2pRY=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Y3v6Rf0GkfeggIy2LsT/T+pVZHMX4NUpo3SeBS82h74zZx3U/0ALI1+EJ5YQp/6Mr
	 55yAzCcBjHNNMghTMWBvL1G5OauqR3y1TGtlsxK5MIDNNUfITxydAsumek1LoaIPFj
	 C04WSWbJ2NjIL9EVe2vpagsWEwm8btQ5TrX7EgiWGdOrzF3YhiuX8KmbKy2G5h1MV1
	 +4VX/cXndam/hfH7g6g07T1fFxmcJZic0StwBDAk5dESvK8m6l7AUCFWB78FW2KPO4
	 c9GInvtRovVkURCkzR60EmdBs4kWlEFoptnsY/zbnqJqCoSwBNGnk1ybA/mx2S9a+6
	 Klwgak29kVw0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232E880EE0;
	Thu, 23 Jul 2026 09:38:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DBFCEB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F9824025C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cc4eP4DHBLmb for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 33F324027D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33F324027D
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33F324027D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4WCFlMNouiT2vstDjdhAshxF4DtphdDLJxWjgUUN6T64HAYAatesl9KZAkJrgjizMx8yE6ssqH61DLf/S5yxR61c8Ix5JUPya44oqkEQs3aPDzF/1JCD4tovar0byyQErL5FFhF2/+EM2K54PZxzRbfaHB5OxIFDG9n3ArMWszX4zH6K+9hgd1m1qrFMxRnjbADAm87mxqosy9oeffYfNTV0iKeXaL2Xdnsw1iWmd/iVj9aTCcSVaTvaIkEM9Ne7D3utegzP71QdIo5ABjlAoSva0NWvrhvwvK2LDqUwRASAtEuwB6FHihAifX/8U2d5z7+u13EaK+01wuA7V7yHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPq7Hmnqpe/kQk14GWluVijmS5HN0q9q9zQTbQr2pRY=;
 b=VO8WdeSQrHXC3JVv+klTetZqMDmEofIiNUj/uBDbeUFNF0TzKMw8uhdl+rSRuiQ2GKTe86VP+4Ukl4Dh8R/sdKmwpJ1D5pcsKB2LOX3wsUsWbytODRZZP/WThOpi9QF2mRjcrKyV22yHKsqC4IN/qSO+XHwIF33GAFj/f5MS9qfc/8G/h14HGSm/Az81MhHaxvadCz/FLviTOLReo1DwmHPUAxUVFjp2hThvF2VMggV5vxcsN9Spk70hw5iPY0hNfrvdsMaTdEDeKk+FhDPUc26+sf0VMHdTdIzNSxpe+Qzyh1/VarvfAkOqcC74R3yMYiBRuLpEx1R8DaZm6UOtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:39 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:39 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 3/7] binman: x509: fix CN emitted for basic x509
 certificates
Date: Thu, 23 Jul 2026 11:38:25 +0200
Message-ID: <20260723093830.3132465-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 484be047-2be1-4219-287a-08dee89e2ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: yChWQOO/rsvZjqPjs+AO4VELkL9wf0Dfy6NZ2AkPdm8VS87tLywQAGLJAtCUtIMrw21+uItiNJwxpsjSb0q8c/Mzv2QNRY66sjQpehaFbIqIAS6VG2NGlQwXwJNIarZSEPuI6LH16rJAYj70tnD6G40d8AGdCEaspXixhw/oM6ok2SN0CzItGyCi2+6iB0sAVSyTDj+6BhtuO3TeEHE4NiUolt6Qeui4HDDCBnhdAOm9ROPiMuj9ytTFAkOOM/1mRBVkw/TdQ7QNgYXNlWZC1Y1kQwPNL6jUHm6F4PK7Z496c8HwlexXKSRrl6q/j/7w/zRRXr66y449BDLnEaGZDFa/CG08zd1QR7du79ltz2ZPCm2bFKA/p/O2dyojhDkwPnDAiVXLGMgVusXG5+kIPvZRVRuhVvfSHg8J78OU2+wcZGylDHmL8KzkBVj8x3mz7MG4AWRyitcXQ+/qOAo5EV2RSQYuXHVKxEAiehDbq2rZ6Y7h+igf5UIdEgQvkhYXlHEGEF4QZl8f8DO7d5F7zh5TW4Bfn2DlbUCXj5fjv8M5YNrnJjTimH9LQL0BaycgHk05Gc4uarPicslkAIb5cTQHL4BgkFWtmWMLGH/Yywk9rahU8VpWSVyjNS1Vofbt5ntvgErADYEH9TUkQEL58HgrQvZokhuN1dK0FoYK6Vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SS7lVZrXWfGZ9gWNdV9O/WR7Dnce9YWe930NL0Abg2STt09Hj4hWuvakjXJ7?=
 =?us-ascii?Q?HRMaJ7C70dMCvM8mTuVjmi2TIvLDaQmUdtGW6wTqQbZD14jbuIFQ6hO1bB21?=
 =?us-ascii?Q?lz/dNQDHfd1rtFnZ2VLDumkTbLhGoyKm//RPE4nWLpljATl9thwkvQ70CirJ?=
 =?us-ascii?Q?8y/x8/liV6Fv8SW+lFQQWyV8kAKoEi5jK8uAl2+7QMXEc2AXgevBXSBDJtyx?=
 =?us-ascii?Q?/thwsSEJqMuZ3GpcbdcWtQMDwq/XSH+oG21WT3zzjBRMBpYNquAQ1Xfodd9n?=
 =?us-ascii?Q?SX0yjCRqfM8zKLQAbH2HsrXiRDomwlf8GO72r+wOEqqjy6PJJdFHR2XdZH+M?=
 =?us-ascii?Q?DEmfOnWp1XYYKoKNSRN2vrg/2Dr5t0rGOTwlgZ08AUwNemkIXdUOvtwLSzNv?=
 =?us-ascii?Q?McHwr/lrBH6dJRNRUbiOsRa5DOblnTXnr2zp7IYPC+r6bPXPpRk/qsTNSGDQ?=
 =?us-ascii?Q?Z5WDCj+hqsk4fkFW4b6jdMubFDBd3XODlv6qruIzdqutfuSznO5Jn8T4Fg0N?=
 =?us-ascii?Q?XHsR+jzyeATZcLImjKIjK0qioWm96uwkSzl4ozjdV7e34JPKj9uNfSeOmRwJ?=
 =?us-ascii?Q?Ut7fn6Ud1tCx9M+5PRvoir/WRpOmqjNDyJgeVBEznpvNwxCSyQcu1Kxh0Tit?=
 =?us-ascii?Q?CDIgZcaOq0gOCHuOLEtcey3CtgzUtqnlWP2k+4VJsayzjqvNoxZDxZcxxkQg?=
 =?us-ascii?Q?BX+wjJ74Pt7eafNaeyMArPNH2gNY/NQNhzVmm+o+cXox/yHjxQNGEDzipvW6?=
 =?us-ascii?Q?twAAHYLFn7HajKcGStvcwxkrykelJAvSc8sqtzBcYWGAJt1QWUfbVDkzKfU8?=
 =?us-ascii?Q?ZhH9YXVbz1zqj7aEbnPZudGM7vcAWENLbsqi3RN7l8SXvGeHnmf63NfKZPR9?=
 =?us-ascii?Q?sRGL0vKaBtJkF1WCBijDMdxUSQCJ2RLQBK5YNZomiRWJrBBQfMurUNVqSoTD?=
 =?us-ascii?Q?7IqYBxrShFtzpCVbhSjac0ByY4AnUu6CBTEUHEB/lZw1cIxjCMH2yGmq2TmO?=
 =?us-ascii?Q?/NBt2hgRz3lc4F4hbild1kTF02z6BfsBD9tLKAg3C75ebuPjZuyf4BjiP0FU?=
 =?us-ascii?Q?pC5DduAS+WaFi6KVNqk5JBUZscL2WYXKQNj58aElNiF/W6wTK/yrkcU7g9KN?=
 =?us-ascii?Q?jH5NxEHf1YpaWsh10032ltbpGPpUn0LAoaxZtGsnJzrJelIpe3yyYLXPGvjn?=
 =?us-ascii?Q?JXfgslwRmn+VndV//X3eK0jcElliRQ4YIJevZYCm5/iLMv8nbOVKvwHdXi3E?=
 =?us-ascii?Q?pRppBPw/+8mNf5A7JAMdfG8RnaCTxTDCe43NHQL0Sdf3168eEkplGrG8dr+X?=
 =?us-ascii?Q?BCaRK0WRK6TWcjd9bzFaLnqVjUlIXauSlSE++X7oy5827CCyICS1oVNxxeSE?=
 =?us-ascii?Q?VU47nYO9MrC536L2hdryl6+mXWBvoX4KV3vB2mHdh5d9WGySiZnVgFntvqXZ?=
 =?us-ascii?Q?XntCcqNRQ7yOqHNHxpKpKshwx2IC45r1NRXvpAZWsI+RXVOU5pGPHpeh6Bob?=
 =?us-ascii?Q?2dnyftd1k/tqytFthNTgIGwT5i11VZdeECR1Jg1V64+Rr4Xf0u4AfaQM5359?=
 =?us-ascii?Q?scj3tJvxeNlx4i8MLVn1yRWv1xEBzVFoF2+ayR0UJTESE22p82MNTFGD7rKX?=
 =?us-ascii?Q?Exn7TlwPstOY7447mq2Dr0Nmp1kkM4v5eI9XGpNdYuayUF7afEqvOYwx2Bme?=
 =?us-ascii?Q?GZtDeYwXPcXVGPlT+zSxl/1r5ThfYAGSm9aDWjCfHUCbxTyC7nQanWKC6kYT?=
 =?us-ascii?Q?EhEhpisHfO5raoQ4E63qV7iRk2lAfFw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 484be047-2be1-4219-287a-08dee89e2ce1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:39.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgxtFW8o/fIcSZPf8FlE74X/XNRbVW/Th05+RiRrscC4PqfrqOdaiSZD/zMNcHOijTzBhwn0kEmBpTHHG/caBQVACf3dilwO1vVhMktaIFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPq7Hmnqpe/kQk14GWluVijmS5HN0q9q9zQTbQr2pRY=;
 b=ckh3LRy4PtCs1/2LYKHZ0q+mTDU8q/vmnuuqDz5try4HjQpBZZPiFxuxOtk00UIsOuD1n0B630NCAZm5BDjLAvNw8YrinlYF6hCmqGSzwn7Lwa6zJrhlqhjM/aVOlFx5FTKdxzAIv1sDeKpz7xNHp1/nw/w8SXeV8QonDoaNSyQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=ckh3LRy4
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

I'm pretty sure it was never the intention to emit the output
filename (cert_fname) as the value of the CN distinguished name.

The cert-ca property was parsed from the dts node, stored in
._cert_ca, passed on as the cn argument to x509_cert(), but then not
used at all.

Now that we always read a distinguished-name subnode if present, use
that method instead.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/binman/btool/openssl.py            | 10 +++++-----
 tools/binman/etype/x509_cert.py          |  3 +--
 tools/binman/test/security/x509_cert.dts |  5 ++++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index 84413428e1e..dd471b4b562 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -58,15 +58,16 @@ class Bintoolopenssl(bintool.Bintool):
                     sec += f'{i+1}.{field:20s} = {s}\n'
         return sec
 
-    def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
-                  config_fname):
+    def x509_cert(self, cert_fname, input_fname, key_fname, req_dist_name_dict,
+                  revision, config_fname):
         """Create a certificate
 
         Args:
             cert_fname (str): Filename of certificate to create
             input_fname (str): Filename containing data to sign
             key_fname (str): Filename of .pem file
-            cn (str): Common name
+            req_dist_name_dict (dict): Contents of req_distinguished_name section
+                                       in generated openssl config file
             revision (int): Revision number
             config_fname (str): Filename to write fconfig into
 
@@ -82,8 +83,7 @@ x509_extensions        = v3_ca
 prompt                 = no
 dirstring_type         = nobmp
 
-[ req_distinguished_name ]
-CN                     = {cert_fname}
+{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}
 
 [ v3_ca ]
 basicConstraints       = CA:true
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 2d017b81456..ac2752ad640 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -64,7 +64,6 @@ class Entry_x509_cert(Entry_collection):
 
     def ReadNode(self):
         super().ReadNode()
-        self._cert_ca = fdt_util.GetString(self._node, 'cert-ca')
         self._cert_rev = fdt_util.GetInt(self._node, 'cert-revision-int', 0)
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
@@ -109,7 +108,7 @@ class Entry_x509_cert(Entry_collection):
                 cert_fname=output_fname,
                 input_fname=input_fname,
                 key_fname=self.key_fname,
-                cn=self._cert_ca,
+                req_dist_name_dict=self.req_dist_name,
                 revision=self._cert_rev,
                 config_fname=config_fname)
         elif type == 'sysfw':
diff --git a/tools/binman/test/security/x509_cert.dts b/tools/binman/test/security/x509_cert.dts
index 71238172717..ded0c2013c2 100644
--- a/tools/binman/test/security/x509_cert.dts
+++ b/tools/binman/test/security/x509_cert.dts
@@ -8,9 +8,12 @@
 
 	binman {
 		x509-cert {
-			cert-ca = "IOT2050 Firmware Signature";
 			cert-revision-int = <0>;
 			content = <&u_boot>;
+
+			distinguished-name {
+				CN = "IOT2050 Firmware Signature";
+			};
 		};
 
 		u_boot: u-boot {
-- 
2.55.0

