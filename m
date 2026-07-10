Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5071C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309E084A4C;
	Fri, 10 Jul 2026 14:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cha5tm9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC2B846A4; Fri, 10 Jul 2026 14:36:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4EC8484A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyJo9kBUstGJNt9yWFvY1jUL48lZdbvv5SaRZ2g63uBsYSKezUJWPUkrvGSrM3Vj8tBnjIlyJRa6zcLEyLy89ngLqlntd3rBqCRFrZHVpD/1/rnE5JrHQvWbhk1VnI6wBaP8ffYHMOqJMlh3xKmAJ+7F7MQSWtSxEkKJxo8FVmCx+q+IE6A9OXAa4/8DDibwMh667TX54K+djqqAa0G30spWS7bW6aXY/1fZrnHx1Ho3YLtKVZtBoKILsv+j303TYcWXg0dafCMaFJeJhFJUoKgth6TuY19FHRLcXivujiq5vIRobIbuNscB1yeDT2bOSVSM/Ciu4dAePAQ8TkKMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyI3RDdRloMPTdJqI9D06aUgmOpMcsDgUc4z43aaDAE=;
 b=XS5xYXKdApAgrzeNft7XuCjpjvPvuWa9zHtOr2dObeX7QSArE94BulLKfZOFkdy2NMADr3idnMpHjGzd0eRkB88RdaJf8goTv3ZU1a/9VX9UWumz8+UuVX3GS88E6W3JQfmHXn56Sviv8OKedOSsIfZYUo+nq8OesFxaakOh7zkeLioy8sHlmuc2X8bDlA3OdKmXHbZyRg9/OVDgRzEq5/SszuHizIcmLo5OOR4rh3JPnDkO4mo6quiEgtpE2Kgs4X7AvkHunWkHK/nwgTit/+TX7dC9QDhmnXKCOOpCxSz8dsZy2jG2VBVusSwHnpP54VBIGSRO/dlOIZPOc+l2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyI3RDdRloMPTdJqI9D06aUgmOpMcsDgUc4z43aaDAE=;
 b=cha5tm9qUk1o2RQh7yEacbAXwTIXCA6z4e0HYbR6wQHxHCHxS/uSD1o4FxuI8XACbnGoqvEhZmcuz2TE5VBjg9qJOitst1rhDzO8RidIhGwZyOvmTH3Vse7Se9kmrSDMYoJ/Etyp67NAGiQBBfT0t/wm7Cznki/CVjYbJ1UonKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:24 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/6] binman: openssl: refactor creation of Distinguished Name
 section from dict
Date: Fri, 10 Jul 2026 14:36:13 +0200
Message-ID: <20260710123618.2036728-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F71E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2c8) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 26633946-54d1-4d7d-a145-08dede7fdac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5qBoJaIr7OwlOsUFa/MX/1VZ0N6H5bY4WapJ7AqzpAdn6iaHPBbtvQr1dr/iRGKbEglwWdku3QAPaTWm6Tg0eG1JgT7hYpMlX3E1oZ3u0RRErQVXWKjrSPoBmyC2ov0XnJHAIPciS3m5g1tCDg6RXcNdXX14J+iLDESM23KYxcyVA3MHB1CA0w745FKW5zse+P10yisehZPM/AHUWcRnmWUZVfNke3kmWr64BYlFThBVlRo9CuIrYpUCHitMftf+RwdWnHT4ep47/B1sdircQLhrG7izmw1zkkBQDZoH8fQZ35Y/RYCapZtV8/q0TIhUPCVRV7N8VF+Ltd2ECawiJ6rde+Z9UL5WfiG7pOQXSiD/dsyoBtYIrwSqfV1zycmmVLEkv4V8SjTgrw+RZhFv7Uj2L1EPKy2ZIOm8e3x1yqvnBvMKcVc3wOHt5QzUd1yeLZBuaqeF739yMAvfisUYD1GMskltf22V7IB6wG+cmyZmoR1OWPdwKcnLj01hKRBoFgv/VGL//FbIeYpqmus2L5BlI19xCa5AiYQYVdhDpIOgkbM2/YKxXdNxZNMrA1nRRqyBEJFFESq4HfgJN+to13/scV2LxL/akNaSj0yOfIqnLUe172oGkA/0Qi6QPw71ujmCowvjbxZvxueGnl4iDCZflXcaa0tDrmqv1Uck+T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdAMVDvvBzvdmtiiBEVz6hN1YnSbGCTqqG++433Y0EUEvuvaJMt2XscEkrpD?=
 =?us-ascii?Q?36UOW/quhNOym4T/fdhyiP6Gk/SVXkLTB1lv5JQDnq2ItBS0+lHx5JPft8Fu?=
 =?us-ascii?Q?EhXlv3iCmlRMEeefA7KCn8DK6Rl6L+rO+inNsQkUmFNxoAf7tMJe6WWQmzCB?=
 =?us-ascii?Q?F0yhNVyHQzOd6F5Ql9asXSnswNr7DDCmjXqPpS42GhvMBvqsya9HtaiQehFi?=
 =?us-ascii?Q?GkmZWcpC/IVwHUcHbLmbIcQ+jA5dUa7Nt5Ush6awNhghudTBDbErVvYGdrL3?=
 =?us-ascii?Q?FK00yXO3RYceUufIGTe0Lkgpj06gFtrEIbtCAiRgstdP/TdPLn9I0tE2eKuK?=
 =?us-ascii?Q?lpVd+R9Hby5lccRA4garVyAYpRVGEzuL/UQ6uPJ9rqgiZDHIn+Yq6Fu0O67H?=
 =?us-ascii?Q?k0Fvj9+KgrIiuf+LAFUMcuYXR14LZhpG6554COYOsENECT/FrYe6yJ4MjZEG?=
 =?us-ascii?Q?/ZY7UA4SUN8BwpF/r1LsfvXAbLpJsc7M4co/beNFgJXS4YGkgq5IC0+ukTiU?=
 =?us-ascii?Q?0Shm6Q38WIcLzX1iSJ+y20RUyxpK+WooSfOo6as9KmGmqoEmA97aRfAKM2t2?=
 =?us-ascii?Q?mkOznp+LW/o/+ISbR2D8imhIiM3lDmVWSu89oa5+LYT88LM0EimrhWLhVjrw?=
 =?us-ascii?Q?KkGXKXkXag+m3JasDPovgTvmp+q622y4e6g4PQS+6UMAkzY+uYoWVREkahVt?=
 =?us-ascii?Q?RStCwIBM8JuvHrAWJnGZQhgHcFXgDQKGyGPYkC5K5C9cJZzU7oFYpyey1qRx?=
 =?us-ascii?Q?q25ZwAjt8RUNjIr1l06YL/t68o8boCxbsLv7ByfF2k/l29VCSY3TSAexVwO6?=
 =?us-ascii?Q?GQNqtIsfrxs9TfK16judii7bcYSkDi+fMY/VBxsw0RFIFDZ8F4p/lI+xsLua?=
 =?us-ascii?Q?oAHK2ofYopOgB/gDcsOqjGofXvkyMDSBOfR0DuRgp9pcWZ/avHt1G09GGgg9?=
 =?us-ascii?Q?5wv6b6HYG2Ww8Zk/oVVm+r0eiHU3tYBRHs/rWbMKmt6IoorC781iyzyo5E5t?=
 =?us-ascii?Q?OzgpU3vBfWfeOyp6VPbkpt65Ts97o+n3Bkipsn/dqkdeexC4svKNYtgV0QaT?=
 =?us-ascii?Q?p2Brxy1kNR2yLV3fiOSTxDX32gT8kJ+CiXtKilUQqiVVTb8J3sWQtWL71GUj?=
 =?us-ascii?Q?bYs2by74gPx+cGxu8cfGQcVP0x5Lci2VsAD1kEO4q3B35S8i0XLsYkCf1wzC?=
 =?us-ascii?Q?xGo97E22UOhwUjJo/kxRWn2IPMxdfYiOYPDnlCqE7mTJEYF7/mk+Z2PGW1EI?=
 =?us-ascii?Q?5CHQG+/3tTR8ddk4VUXKRnTda9TC+Zea9bwxfmVK3O+Aq7DYZ/YEiudHy5nC?=
 =?us-ascii?Q?KgVQT2twNNlaMVFjbwGQZ0MvSBazT3D60gRcny3u9UPjdU0vXzfNNlswbHBu?=
 =?us-ascii?Q?scWYjEqe6xqrGugPpa7FWB3iqat7QlYNDG2XYUbiwpEDG5kBIemR7wquUIBX?=
 =?us-ascii?Q?/jDPAe27fWxxGliMYl32/ydfxVzlPv0HK0de7tCJKsrGXVluQO3FdN9tfklw?=
 =?us-ascii?Q?F6mamxAKF98lssk9s3XPXlJfuaMXZCKd8+/9rP6l0elejnI773Zbs7BEqf6V?=
 =?us-ascii?Q?e2siGmp7jaM8q3u4xeIfcbTIiPjttP/2uiTxE9O1WoqT5eQFH6Xo41uK2huh?=
 =?us-ascii?Q?CibyV7vUI5hEtud2yrU16U4VdVOBtlA2FF/9jGjlaHjlWZROqceBgNN0tI5C?=
 =?us-ascii?Q?u2UphXQZoMTIYI6hcA+2Fs/RS/7HFqRVjgR/eUP3Jc8OE6Nc7U/l1TjzymHY?=
 =?us-ascii?Q?tA273JTLKr3bfAAHKhaZuMUtX4atnYc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 26633946-54d1-4d7d-a145-08dede7fdac4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:24.7441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5U2mp2VrKrzEw+leHfXFmYxoBZeYkmG+nVRYtPA979KYdIK9FlVllYONYDH7+0i4Q3e+5XTXsWNDZa0WJJiKCT/By9zWT0abDUyEHJnVLD0=
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

Instead of manually expanding the req_dist_name_dict, create a helper
function for creating a config section from any dict. That will also
automatically allow other fields to be emitted.

Eventually, we could allow the values to not necesssarily be a single
string, but a list of strings, e.g. "OU" -> ["First OU", "Secound OU"],
and encode that in the config file using

  1.OU = First OU
  2.OU = Second OU

as documented in 'man 5 config'.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/binman/btool/openssl.py | 44 +++++++++++------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..370760ccaa5 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -36,6 +36,14 @@ class Bintoolopenssl(bintool.Bintool):
             name, 'openssl cryptography toolkit',
             version_regex=r'OpenSSL (.*) \(', version_args='version')
 
+    def dict_to_config_section(self, section_name, d):
+        if not d:
+            return ''
+        s = f'[ {section_name} ]\n'
+        for field, value in d.items():
+            s += f'{field:22s} = {value}\n'
+        return s
+
     def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
                   config_fname):
         """Create a certificate
@@ -92,8 +100,7 @@ imageSize              = INTEGER:{len(indata)}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             firewall_cert_data (dict):
               - auth_in_place (int): The Priv ID for copying as the
                 specific host in firewall protected region
@@ -114,14 +121,7 @@ x509_extensions        = v3_ca
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
@@ -163,8 +163,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             cert_type (int): Certification type
             bootcore (int): Booting core
             bootcore_opts(int): Booting core option, lockstep (0) or split (2) mode
@@ -184,14 +183,7 @@ numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
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
@@ -252,8 +244,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
             sw_rev (int): Software revision
             config_fname (str): Filename to write fconfig into
             req_dist_name_dict (dict): Dictionary containing key-value pairs of
-            req_distinguished_name section extensions, must contain extensions for
-            C, ST, L, O, OU, CN and emailAddress
+            req_distinguished_name section extensions
             cert_type (int): Certification type
             bootcore (int): Booting core
             load_addr (int): Load address of image
@@ -274,14 +265,7 @@ x509_extensions        = v3_ca
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

