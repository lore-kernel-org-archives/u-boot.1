Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75728C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA7184E26;
	Fri, 17 Jul 2026 15:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cmCKDhn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D2EC84E51; Fri, 17 Jul 2026 15:58:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4C184E43
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3vktNxHxdJQ1A+EBEZ62H1WiKrt6C/CK9Eqm1TzG/TtcCtntWVB2Khrn2bZhehAvPMwkeU3BMyOsYx5DCmqegoFhqqcccoKWwGnk2KkDpDYxvVtaMSeudqX3JLmWLTNqjNSVzXREdREhY2P97x7Xt78El0Slc8L3ZxcrHEXkYeBE+GU3RJ48acR/mJ5LYJSn7Vl+9LpsOie/12RYBZ7LtIn3QhMFxbiwtsh7Qxo5rXTjiACl3DRAv8KsGKUaYVK6UlRkvN0Tqx/yQ2LX1JsyeH0ciOfp9cnyfpvWr/Cdwwx3D5U1AMXJM7DfMA8+PNJynUehiJys6SowapwI2cyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryQ9glx1DlIK2O7e0d0YQHvHPXVIWxo+4oUGW2R7GqQ=;
 b=fpt7FP9yGXlxnIu/kG22RMZGUZp2CMX0FHO83RJiwC0JMLV0rLZw4+kpaJACNQtVbS40aV//7cTDhRnJA1e+FqZTHS8F2JXGBXdj8e3THNWfxPgB8eZd4P9vBmlv48c9n2juGYDZ+LRIsI3NDOmT0+Dxee3ryoXuAlj7AzfwmBZcEyfh7Hp/adx6fX0iuuEQMWTwHTlX5Nse3B3kDS3LqJd0hGLfRFNYxs+YZXZVmLcNakcyCsfU+USfRvBcoF0pD0aNuEqTPp4dVs01il9tmtesbBH1E6sI7xIe0F3GZqtUTXkbBQplcVZeaKRad8MIICQxUHUIOYeQ8rrdWvkp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryQ9glx1DlIK2O7e0d0YQHvHPXVIWxo+4oUGW2R7GqQ=;
 b=cmCKDhn7owBRwzlP+iYWTGA2bkrrVQAUBhhyGmXZ0MFaGRG0V7TtjzD5ZH0tA+bBW2Xt/iPz5Le1SZyTlxf2x9Z5QPC/0MNdlp1QrOW9115BttawcFu9AL/dzfqU/gtdeN+7JAuRW3JvARcjFfA9niBoMBdicz4e5OA5AqEllzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:31 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/7] binman: openssl: refactor creation of Distinguished
 Name section from dict
Date: Fri, 17 Jul 2026 15:58:18 +0200
Message-ID: <20260717135824.2142135-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F68D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::130) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d2d913-cc08-4bb2-e5db-08dee40b7c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: CUAIIZx2cN259FUsCWqnDwWSKp9WqBZwrBlLiHystc1iVCfP8W95MzhLIXnSVeUtQz72dvVHTlDgVV6yYN/Bw3zU53V77pmKpaQd7rdBXF6iUVaY3MOpfawHWW2mPXcVlDxLg0z+yuI4yqobI1J+OzA2zuVmj4+Mkbhq92KFE25rs5V8PxXQ+Cx6VXbvTOsmWiadDWBUkqMEGLxAghAwTFlpdO5VqQVoIdoCOdhqEvHHr7BU3HSyyrkHouPLoqVNUqo4ZahBIAcEIjhnZmpNhVR80e8YbF/FGwF3KSpXcfs14UZJ+xuaAchy63Ptmr0hvlFNl0hQH7uXS9c1od9WzuUk1tkX/1rPl/s6OsfmUcikSz/WoYxm6NCjdbDjOoXKZ/h83RalrTfx9rii4yjvTHu0m8QvJLIMgT1RK9ZCQeQfuHEvN5BoXW6Cx0avzSDQKsIouIGGR39Fl2/zNhKLEVE2TeIkWU40z1yq/4YkVVVPZSgJBf5eV0mahW7NoEzQgsMLEeZSp2mLx/OIrrRGpK6KLAHvArJWMWsRLbMIP9x7EEp4lL349A0DkHcFzasRUtWMXwZawhTTuaX29P5v74x4j4bBlMvKwrzfztvD00J/CrbfPp4tYm5zXS7Gqg+yBS/T9tlQj4lnQy8ntWcuKjN4Gb7+TmiIM1iNoQt25NA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOiiO/VOrjkKaZowkNrlN23geuJxa6bsOw5u/CYAoD1Us5lL4kE/c6cZYoSo?=
 =?us-ascii?Q?Si3vK9O2bSc/3aAI+X4HPtNmy4jpc1lOjuDSokmwq9Yf5ABiYIVOiEbw95en?=
 =?us-ascii?Q?Q9ziqmScQ/DyRyfqKbth76I2qkmkK3GD9i9rLj2yWkoZ+XYqTRn2GchEDWdO?=
 =?us-ascii?Q?jJyIxl3Ndrr9SWQaMo8VX0jlAk4mMqGZkyUKhhqEoNw9wgfglFKwsAgRYGqI?=
 =?us-ascii?Q?HI+KIVaVGPSuS0iOC9ZK+3GvMznOaiOSKFuvSzuELWaUO1UymaiTFOUXi+PI?=
 =?us-ascii?Q?S6JUSA2SzF/9OMSwbpBwDVxEWqrU/klTvM4Gd0R4821VW7zcsZ7tW/qr9pI0?=
 =?us-ascii?Q?n4UGZ+5MqokVFiJhIjcdFSgNe6fWHVUL7AMJZbuYq0ufTOnd8ZsXJJorKrdt?=
 =?us-ascii?Q?+uMe42rvuBaK2JNfEAfb4akfvRoKtujtV2O27WpRyGQ6rrOhH4g8+op4bNPU?=
 =?us-ascii?Q?LsD4S0rovIA8Y/CQuu9py4RuBocPCD6PXrY3Qlf1h82Vxe49zvnNufPyLwDA?=
 =?us-ascii?Q?qGsAmjS3OkijwkBiOzKQ9EaL8DZ/GtylMAbbThc1BCrHOUo89tQp7wl1yhJc?=
 =?us-ascii?Q?eRKkcEUFasRkGxRqgo5KwZbb47XlNn9xbTsUbXOGgLCckvirIP9WsWRLl+6o?=
 =?us-ascii?Q?PY2EjOH+T9b808iMDral6J7ZDMWnFr0D2oc2AlI9H8D3hBUb57h+ylM2qJpV?=
 =?us-ascii?Q?c+S8vWTv0ZN7OJOPRgOM4cCoCVcaDryS2TuuU65u8to5PMWkr77eZGmRethC?=
 =?us-ascii?Q?30ummiKm+tsh9jOkO1TUU+IVE3PM8SvZZAJg248dyzSam5EjTBbfaczry3rP?=
 =?us-ascii?Q?LtCpxeQYU5CT/+/x9geHT/Cq93Tg9UaHbZ8aq7CRr5Z+YyvP0PGJvM/aPdzy?=
 =?us-ascii?Q?+XkR6VZTCE91pjF8uO0deWW8zPkKwQXWfusbKAhwLYJ7uvzhltLgzBbnsYAm?=
 =?us-ascii?Q?BjqC7DhC2j1BtuDzaKtyDDA5vkJ4+eaIng5d4clfmeryfJXfFx8HEbiOtRp6?=
 =?us-ascii?Q?3+cmBCR6W41nEgiSTvP75RffUlNgAb6EKlb64Y0ie4/M97Q/w51Jp783mRqq?=
 =?us-ascii?Q?0GWgcthDS7S3c4AQkoqiSKIPVerF1uQbigdB6DlrivlcR5gtnIYTLqXX7Nr4?=
 =?us-ascii?Q?fzyrP/yyYH8n53gnMbkfJWDFvYTIK3BpC2tFasSdYo/uJ9246v8n+2lDwcEp?=
 =?us-ascii?Q?bB1XQWHNlxXRNWyVrZzBnGVATYoEYdEKbp76mlTPUm8piO0QSQIjSDr40eAG?=
 =?us-ascii?Q?B+z9yIki5fwy+B1phf+yPfU/OkdnnppB5bvZ95DjkY7T+Z31pdhqP1J1G/s3?=
 =?us-ascii?Q?8CK3Oo6h5NIq0jcEkRRD3uneSAlMuVnZQ6vySEGe8hqtgj1w5lLZejScyIt2?=
 =?us-ascii?Q?1z6it9E4Eeu+yfu6i2T9DQUBy8Ht0fBxhPYtTpBqh4xsLBdcEBjs+D1uMTdz?=
 =?us-ascii?Q?yjF6196NgGYCgBJ8v+6VAVNfqoO42Lxd3LLQdxHqS+q7Zw2iUFZISs7bo+x7?=
 =?us-ascii?Q?4cNx0Qmt/goqDzG9ikEm21O6wJ3MxHMP5vvg04caH0e3Mis1JoTVGw+1P7SP?=
 =?us-ascii?Q?dNB2cUF1mUhFu8H13qedkWYZz7Dtcbv0btlwF3DPhkZkEwqQ6gJJJ0bL4TBs?=
 =?us-ascii?Q?CNhCJEFd6dBhGz5OtYsJbzh0G3r61qEObDpfTcoiuOQoIRVUKT5OgYA0RLwg?=
 =?us-ascii?Q?p/jDw9kM9E1wCekeQV3FeDiHp+JMRI5mOQxHU/0unmo53L6LZLd2vT5QGpmj?=
 =?us-ascii?Q?fjvVKe3I48GEjpROqaJTx9xVKKhF5uo=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d2d913-cc08-4bb2-e5db-08dee40b7c4d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:31.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOF+PAStpFQG93C/oD2YD1c2u+S/7LUowGiQ7xOAi/R3U28+4E8+pTIPWSNB03QwXhjmTCqmDf54tA8ZEn6ufjszXW9bd1yyv2iso1O3LIY=
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

Instead of manually expanding the req_dist_name_dict, create a helper
function for creating a config section from any dict. That will also
automatically allow other fields to be emitted.

We can allow a field with multiple values, e.g. "OU" -> ["First OU", "Second OU"],
and encode that in the config file using

  1.OU = First OU
  2.OU = Second OU

as documented in 'man 5 config'.

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

