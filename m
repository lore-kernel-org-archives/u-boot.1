Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA5CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7BC84A73;
	Fri, 10 Jul 2026 14:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Um9yiFfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2E484A60; Fri, 10 Jul 2026 14:36:32 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF6E84A0B
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOkL+hnbZI+4IKqFHWK2PO/XqQ6ZzkvUXYhZpIFLQMnmckZ+R3d35zDawMQZsS3g1U4pTMo7f2HePU03LZo1ru5hYM9J8vtJPi3NeJ1ToqRWwRLWaMPE4VqlcoAew9Db78s+u8F5u+Rs2C4FCWDGRnOaYgtpt4rvn2HFHhWs6t82eDM89eIFr0FL/Rv5dfS7/5iBKkEF/AbHmziTHL3N4XX0kXoqvaCH23G5eOXcjV7dRj25OzcNYJYnRlbA3t5OimkBAx7OVpjthawNdiMnX4+73LQSjccItESQS3wFrKxS6PLp7qIYl8xIGl9lRvJQypFUyePZnnpOAlDu5A32MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqSCEDZQHHXDI1KSaZF7L8djnsUcmwur9OMxXOBZzVM=;
 b=cNN2yXWFUjTBz1GhaDERUej/ACiwsCXnSn+269eEVxUGZHiDYfZfKXlzP5dlU6NeaV8iccrMPK19FzpZegZmZWkKHSAQAMtzf3CkzgCMvHkmdAKSIq7vWIyYyTqosLYfD+16zr4u+87w8v1yQorV25PtB/7hMILr3gDNsb3qsWBvUEtJllhS+bJ1isPaKPA8p3llRuXmqgAFXbylWRKGJ1rAbJxkZ+EmL3JwIyk1jDQFArXge6FPvITFSNtpfEuV4EkdnMKzCqRAXWbfOknC8U+oDI6kFBICLLiS6nE+aqOxUn+mPWpiqrD/6I9PtOAykAhRBzxKduR/sF7pq9JTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqSCEDZQHHXDI1KSaZF7L8djnsUcmwur9OMxXOBZzVM=;
 b=Um9yiFfcLdMmXnwrghbfpFHM3qJopTg41QeuMMoE2BlkBiopI7XH8b2CRliW+UChZvuZf6k6KvO3zt4RbrQTZovE6PC7YUipOeZhkaezSLIK70XI+6gZcOwsmuA08NLkpc04M+RWXkecwajNCI44lOJuPe8dD5DiNnlUtWwyeWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:28 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:28 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/6] binman: x509: fix CN emitted for basic x509 certificates
Date: Fri, 10 Jul 2026 14:36:15 +0200
Message-ID: <20260710123618.2036728-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::14)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cb869f-0a23-4bc6-95e1-08dede7fdd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x2wRQ/w6tu9+/mC4ZH40SLo5uN5IVB6eWebJBvVAhS4gp8zqKU7FnKXGi8YqzpfTv1NCA71PZtEtwjDfbeUt/SkHit9glnidoZ/QccF+cZoibOGgyL9WeMgJDocIRGQn0EhcNvkk1U8oBPP00GUePN2ZkWE0i9MJ/AGiL+fOsnLih1zokFRRWNxJVp6chxrhtLQx84YbFwn0HOxiO9rQrVwGbw/1w5RP/Cu5GFgQ5kY9wbU6fXiFr53oog3Xz6yvFvuGkzedX+9fJ8HCcAdgb3/SWlPEA/QIUwegzMWsCN2fzTPNhvbzW0xklHGezLeuQku4fSLq0anFdQqjG3ofg9Ert0tauXKMx6GOX4JwafJd9cP2z2EmsmiPD8rXwvBWhWwDJcv/llYddD2ZBiS0CvbJ85c2KqddeqKZVMxJfgVFHR99PuTs4ipJcqeQyu7yFMoHMstSR/OdsMZQ6jDkJVYxTvxUMz0V1DrNaABu5MNRT9QdeYx7qgjxAgu2XW7XeoDCwfnysQ06OXVWlrziwRQsW+DUJ3L6tYZBW+kwMVCvu/bP0lqYns3Fao+vk5RqYYsQEOJukptMPljIlG6gwgH2z4rUsxFLBec8OtejXhMAWkiaFV6QNy69r6YYa93qUHsoVGQqw22y5qRN1J81FzOyJHVAsdjAPfJGENqOZks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B+9Ic5BibxlQiHsWe2IQmh5Ft/3W6fL2V0X1y3h58B/LyIb5xh4uAMi+yqCv?=
 =?us-ascii?Q?4QvOYMK2cSEst2Y3dUqu0uGzcuFxlAMQjhEB6zFHGgDpH8zv3c+uQQrnRAni?=
 =?us-ascii?Q?zq69Ucaevc9e0rmF986T53b5RfzRp42/tEP6MXYz2x+a5iZBMvxP+Fh3YqHn?=
 =?us-ascii?Q?HHDkgVsmYJz4vsRx956y4h0btQb2NNjPULRskM1FCK8KicJY/XXHHj071fXb?=
 =?us-ascii?Q?8r128c+DYGrWaSWlLAyjzBiFNtX7kQk+baAj5V7RFasfqRM3zOVM92njYO1c?=
 =?us-ascii?Q?+w55syp7tabneGf9JaUFSwy2u4Wh8fYZM6g0UGtBRgcC5JvHAG/DNuVn17sa?=
 =?us-ascii?Q?Rj/NTOLN50TK8x7YA6QqQ7K9311hh24NbIwOF3r3miGqAuHbGxNKKYaTXSPl?=
 =?us-ascii?Q?1+aUf8HGum336tKhXlAj0ZmdHMskYkHA8FuTkomtgf/pkr0fsiLQkjmanxU5?=
 =?us-ascii?Q?eGrUifptYsGxMCgvgazAPNPM5bnAusOItjKckJ/VbHTn/eyz1wsm6ujjc4HN?=
 =?us-ascii?Q?qDk7fzrq9uwaruw5CRNigsZFiWPQOj4F2aAcTwIQmbLhMv+z6T+OkQTNFglY?=
 =?us-ascii?Q?8h+3w0YKbYJBCJ3sL4scjNqiqBD16FrzsQZVS1Y2eEnkwngTEMZpAxpqNuw2?=
 =?us-ascii?Q?rO47WlK8pcEbtRmiCrNk0N2tHGDhQeY6tFNykhp8IucwFHS3xXiixvNQJLgD?=
 =?us-ascii?Q?Bwmdc+OOpLuowPtd7cujviSLyjk5uMZP1ZYVw+CH2qxJruHXD61PJD0NgZxk?=
 =?us-ascii?Q?XUs6d8QNLKKijDa0fCp7xkZL9D2vt1p2AkQSLrsvVhvkzg+tfDFs3STXgU+2?=
 =?us-ascii?Q?GTfS7W1m7iPDdsUpd/+dxVmcS4SUlo+Ek5GuqIsgKG0yicSe7481yMMNHQY0?=
 =?us-ascii?Q?AHiwh4Ui5Q2bm6Zh2MNMDptyUosirwAQ6GUdYqrJyvGDQ406xRnkuzFZyFvf?=
 =?us-ascii?Q?XD7BcpYsl90k1UzLkXVodCoNQnFbq3WslfLidLxPKcEqVKwseqa5tPP7XV4X?=
 =?us-ascii?Q?sj+4VQ8g3vFE8IsKAh+Lydni/Z04zwvu7zRnCXq/gJsB2VBEjK0XWFxOFfwQ?=
 =?us-ascii?Q?AA/lly1WMnEyXlP1UvyGLbPMIzK0FzCrnw3d7x8SbQlYPJboaOjvZrF479zU?=
 =?us-ascii?Q?50Suxl4UywYKkwBqAvkpSsWCC2ufx4Bqr6EPRxoTtozsZz1hotOYqANUGwuI?=
 =?us-ascii?Q?veTkwTFo98ZeWK/8Zetqy2qIBmpandRq/xnyOrJzFrkHIyQD9A62SZNDevI6?=
 =?us-ascii?Q?zngmzydE4dODDvOPGTwbzhOSdVX3hnS+6VIlFbZsYU+sDKgnbOyvtd1sCDBF?=
 =?us-ascii?Q?81FFAH8sVJR1qG9QHDDNFExFHDebJ4rkseoQ3LR3NlPRgjqdwpoWKzqw1lYL?=
 =?us-ascii?Q?OZi8cHbujv+Dn3Kz1UOG0XS7fuApbz0Yr+6I+2EvPabKa7TAohsVAZSZRSIi?=
 =?us-ascii?Q?rUA+9Tbk4rsknRet6ZYlLlYHQmiWBPCOxUvbNNeQYVbvqWEVWHUs3oi7j7Hp?=
 =?us-ascii?Q?+HmWXHDo6wvX+GwtWJWkFYh0Rk16CzE9o3QKGyGqq+zLv2MkoctQQvtfVCgZ?=
 =?us-ascii?Q?0ZpsEwIHHlgyfU63LGVRS8T2lLojE9WnUwhx7pvnFJM25N3v+AohAIu6H8by?=
 =?us-ascii?Q?sfntMAzJvlBa9+u81I382TfbZVohmqHOZJTQZaJjDpQhjsmElR6rKd2PSo3t?=
 =?us-ascii?Q?z0ppizhWaEBnQgMVoqUPt8Izw8aF7yvz7Sr0NC1rt4xsZBcwBjdY/8jt0xqB?=
 =?us-ascii?Q?aOwfWKPZKPw1TpvZrjciTPZRHWI4wO0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb869f-0a23-4bc6-95e1-08dede7fdd0a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:28.5037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk7CoygYJwuxFG8tu+F66dXIywoqLiZowOMRwTikZXANeoq3QiEuKnXWBm3pcbJzxpn6+8sYcCzenQ7pec0R0x/11ykFIAO9hsv/gHXbwHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
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
 tools/binman/btool/openssl.py            | 7 +++----
 tools/binman/etype/x509_cert.py          | 3 +--
 tools/binman/test/security/x509_cert.dts | 5 ++++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index 370760ccaa5..7ad1d7a1aaa 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -44,8 +44,8 @@ class Bintoolopenssl(bintool.Bintool):
             s += f'{field:22s} = {value}\n'
         return s
 
-    def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
-                  config_fname):
+    def x509_cert(self, cert_fname, input_fname, key_fname, req_dist_name_dict,
+                  revision, config_fname):
         """Create a certificate
 
         Args:
@@ -68,8 +68,7 @@ x509_extensions        = v3_ca
 prompt                 = no
 dirstring_type         = nobmp
 
-[ req_distinguished_name ]
-CN                     = {cert_fname}
+{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}
 
 [ v3_ca ]
 basicConstraints       = CA:true
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index ee4c74db6f9..e072414a714 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -56,7 +56,6 @@ class Entry_x509_cert(Entry_collection):
 
     def ReadNode(self):
         super().ReadNode()
-        self._cert_ca = fdt_util.GetString(self._node, 'cert-ca')
         self._cert_rev = fdt_util.GetInt(self._node, 'cert-revision-int', 0)
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
@@ -96,7 +95,7 @@ class Entry_x509_cert(Entry_collection):
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

