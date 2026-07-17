Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45266C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B5C84E6A;
	Fri, 17 Jul 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NSKSUnkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0620E84E61; Fri, 17 Jul 2026 15:58:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8FF84E5B
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXQsm4MRcWeaEhh4eBXEKcoFRgjZVQBDIjPZcA0xak8hd1XUD13bV0eVfKvDoAywOy09/tML8Ypv3RvBeUzK1bPrxy8qlB1ErNaMZ1Z7tS78/2lSrKZRotZJvTJFh9tOyL5p0phmhNfsewMY+dmavMSQBg8Y8zuT/Xr4S6TCy6DR5L8zd6lmYddZSKVmY+Jy8lIuZoyUU5SDuykxheJx8GohocTjx5b/u+tCRRcz7njoQNLWtl7e86piS2wCQO+GWHF2X+Nf7uN8x7OCTIOsajENn0TTnJK7p1KUYEXHBN4AWhMbrL4QwMW/Q9ULjBLe6yht5obiIZEcJHHe5zMxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ursbWYBEAaPfvXnQDkDvZyrqk59Hnwa6uDdzerQ4xIg=;
 b=kxqUvnLbo/zIcDwunf6YRMVr3r8fBl1IfOLAfb5v0Vz1a6JVFznCvkvePD0DuJXwluxXHMyrn0j0BfHYZYnZBWA0NVJvXYXhPqnTtSCa/1p2rTZdkZDBr+mLgnKW00iTH5UOPCnLN15nkg2qyNTrKNIhxcLtV8h+14p4neNyObl0Jc7MIvRxjowrnplPu2N3TOb7AuEgUOkFyu1qCdawkQK/H/rc8CF3wF7WTkhk28qUFFbXuwD/wF0HH4wkDpqxjGphPLnMr07xYE7MJntjzOStDAD1NPUgpHI3rE3cjm/1IuRtUXXQ03PvSGjLpxR7rbew+jNp6Lu7oD2cYnozCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ursbWYBEAaPfvXnQDkDvZyrqk59Hnwa6uDdzerQ4xIg=;
 b=NSKSUnkI5mMQfAgEtDYeVNMKY6Oq3D+E9z3DRD9V7apx082RQ9Fo51wj0S3vysOtnUuyguiztEQFLkWfjgpbbcE1X4o2+kxc35EekOsSrabuJvDHCd43Q4v3ojkaaAm6FMHjgkpT+FLF2dBDKgsUWhBeYsg5eUBL8MTiNse00wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:41 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/7] binman: x509: fix CN emitted for basic x509
 certificates
Date: Fri, 17 Jul 2026 15:58:20 +0200
Message-ID: <20260717135824.2142135-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd9296b-9113-4cb2-93a2-08dee40b8254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: fK1/KOhZH6ttug4W7/Zc0KwbJIx3kptZl+BVb/DvXKBHjrxwC00Kvpdy1HZD45GYjfi9Hmr6ze+pnk1PcpmAfYICTD2IBt10G2ca6owNcPk45ar5U98LcCamjLf0jnXOuUrxJ3h1Dx5zrT8ssYzcPDlattum93Q97Hwzb4sN7toq9t6fIkVs5myK7JtL0ylNMgZGfn9875VTQyPtA051mNk0EQIdYp5QD8dd2uBCu2qfBiJquK1De2gnWNQF5tflQl/+1w0WEO7Fm677GoTfebVQ88MsT52NGak/7b4+vdsljKuOZ7FDpHFsezwoPaSofnAO4BHM6Sn+u0WoHmUgWWEtsvHzz+0GB6Z78/3x6Bl1hARz0ZKLdHOSSX0c4jCmsrEshzq75USjIEMDRgy0esEHI99J/LdcTTE1nAslRCmDA8AWWjIy48M/shx2JZbAQ03C/zZO9AVYiw7bn6O60pfNenk19FMjR2VRbDdmrmP/t34BN05RmXjc2v5HeBsyVuR+QlmHxcrUelNEZ67jScEXIgit2cJb50UvyKI15HuSh5YRl+w9Eejs5dvkyZupk1t25939jS2PgtEWmME+g+Z5BFULzU2IQ5A9mKZlPAggb0upl1TuwWQI3HYMUmltRGks/kRExo0K6CqW3w6YSlCiy4dI3N3pnlkS0WrUQYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30gbwAblgRoBr5AFnYkjPIDqjKPryBnsd3BCxtrN82v2tLVB5lwU+dH2SZOJ?=
 =?us-ascii?Q?t1Mb8cRsEs0urLYZ99lPwahjYPgEXkoO2BxjEFlSu7h2ltrtSVjCHR7sgCsP?=
 =?us-ascii?Q?eIBeEQ8dKwBUa5c9O3ZEaz1MnTw05xgvXE54wP1IrZM+JTBX+4j0S/CJl8Mb?=
 =?us-ascii?Q?047JJXXuZFUeqBnBIQTSM9ktK7h3MbeAYhqXHx3GkeNfbNAvgmJ+HtxeXGny?=
 =?us-ascii?Q?+I4SkspsDoX8lYvXKj/b797YCccnEx0nM1bGzqv513SUbTZLbKcALijkgZa7?=
 =?us-ascii?Q?YmefwLMnCkk99Kjo8xlFL8XX3GDmkwYJQuT4UzjzhmxsFZp4GzfAaE39iHAC?=
 =?us-ascii?Q?pFS81XRzBN7VattiTtrC0RYXB2p390RdHntk8VoSs9g4w5V5Xo6vMcLpwdT7?=
 =?us-ascii?Q?V14FUiZK+OV9EpCz4Kyy8WxyclhSwNY7f/5LFY+aQ3QXshzZLXFxwIYy0aqF?=
 =?us-ascii?Q?j6vd3brrCru/+Gv/ql96mQ0vv0y7nq8EbshPrbt58sSXz9Zlxx0b4cUexTyf?=
 =?us-ascii?Q?Q6GniI5M/p9s/7hwxHnz+g7ec0EqsTTN8161d12zB1n59sxOqzdyUJWpvD4v?=
 =?us-ascii?Q?AeOY3OkjfMuIcSxM9REPI/TQ3U0RFSW7bZ4nMuOydEKEKjgu5FApxEJJhatn?=
 =?us-ascii?Q?dKAvyAjVE6fBuAIaUD0s0z3SXjD+36W/8Wpvj5tjA/1ejm/fIgN/LvLuvOMU?=
 =?us-ascii?Q?zmygYgG2gNf9u8CoCVu647T+/NKHiyVw+mjqlMJEsGu59iM2dAKQXkamhlLY?=
 =?us-ascii?Q?Bh2tMlmNnXwNe0GJxdS5bSZFvTqtGx2GM9XNd7Ja5PiOY4HnUQ35dHkdRmQi?=
 =?us-ascii?Q?GZSW5GGL+KCksxDTl8d7LrxnRylpRxvtd2cPCauls0rZA1TZMjlI1BXBxL1x?=
 =?us-ascii?Q?KYDc/MK0z9Hn8Z5XMi6aTFrQxP4VuwoK/3cUQGQlpzr/qd1GyjpN0Xa9n234?=
 =?us-ascii?Q?0W5ymwaLTD1Snn/7mjMI+d91CVvdogm2WKiVBdfeBp8ut99C8B8PsrCLz2Ey?=
 =?us-ascii?Q?Eq9LSIABzE/4yo7JebD4cClbiJyHz29r7U7yN8wXq+SbgjURNGlLAUxXjPTJ?=
 =?us-ascii?Q?51KWXrFQYUJMySuXKOHlGK1KwF6bjLoAgF7MPJ3WV5pAGDQWeNxU7QXqY7jO?=
 =?us-ascii?Q?Mbcsyv+d/acigr6VkSDPR7EZuID4NP4eI9G+jtyk+e7MvOkO9qUVJvc0y8I4?=
 =?us-ascii?Q?/fO/n9EhMsgNOWfhQpDFelNMTN5bytm2aMn+3+sAEnHWP8wA1WelGW1xQiJP?=
 =?us-ascii?Q?4ATEaABKpX7a4FMc43GmA2qqzhDOvIZ1/1IRpk+EYgoX9uyWCD6zNJk8eLX3?=
 =?us-ascii?Q?oMbYJDWRjCNXn3AtU72CCL39wHLcof6pi08CvwdCgUCmHHnT+by0Sbvr19iU?=
 =?us-ascii?Q?P9hUrRntYaypGo6aNtBM5knROwTkax4Ph2u4N/P6JrZkx7sJki/KKBXYrCFv?=
 =?us-ascii?Q?qjjVl3znK8yJRjKPUOCsqcjdbHGzgJZYcp8nqWZiU+6ToQFwxLlhnb6/rccQ?=
 =?us-ascii?Q?ZvLk43g3G0hrOjpd+PT/iTGCvsydQ93pKCT+zK5qVwI91iXIrf/MlZijifMA?=
 =?us-ascii?Q?qzkMFPE1XMFBTs//RcxFz3YrPpAQJHMYNMVVC8SNFXHCDqzGBsGBYgtCo7aT?=
 =?us-ascii?Q?GPv83CqKD+yspyAGFBPATpUMRrEwBO1rmBk17c+i3ww7EKS+TqK5iH3Tztea?=
 =?us-ascii?Q?I6AM/THqwcJA+UeknXlzWpXefN8F3OIDTirho8v0UC3b8rYByTsn43NyXGba?=
 =?us-ascii?Q?KCdYR8xW6hT7Q83Ual1gre1cq+Y1/3k=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd9296b-9113-4cb2-93a2-08dee40b8254
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:41.6477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+QQfWHOswgOfiED7VNuONW1d+CauUu4jNYPuYh0X4bXnz9uyywZHtXdRdXczSobpLpbEmJX8E5bCYmFDSQLUnbqWzfM9xYAf2js6mba0KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

I'm pretty sure it was never the intention to emit the output
filename (cert_fname) as the value of the CN distinguished name.

The cert-ca property was parsed from the dts node, stored in
._cert_ca, passed on as the cn argument to x509_cert(), but then not
used at all.

Now that we always read a distinguished-name subnode if present, use
that method instead.

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

