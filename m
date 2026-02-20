Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21549C53200
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7878C83E72;
	Fri, 20 Feb 2026 10:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="DLCK1Vvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B0283E7F; Fri, 20 Feb 2026 10:15:26 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEC083AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY6oAkgUNCRm+/KBAbIbg1r8QkPeW6fiCmkaJm/knB3jQxgE/ajq/CFzQ/r09qmU6yNj9SblnibHykEmC7+/khT2a6YSQFrBYEwVwl4MvNjteibe/D7JGf6AHgrwM203MEBbN2dZ4t242pFk8NJDryM9DlIBrZWDXdNDilcsL2IQNMcy9T0cz79o4W/N7uHwbfwMg92bf+QUufYfaR0HvDhCZJ9bjh40Yp7FvsTPiFdBkCevOsN8YzwcpSyfv/6DwQusf+nHPHQ3wrtWVLuGyVOe6wujtN3p1mHUzb36GuEvl8ea5DsTtSHNBNIeXMGfC8X5OSqcGUh+zHZrEZGgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8REAhIBYk4YFYVfs2UkrXNHNU7pkXcrlG/MZuhNT1E=;
 b=HoRP/rEvAlweshafl5wKFA0s4/zGIA6HJRA3Arx0NRhHZ2lTWae8xxWsnSpg80+k6fvSL+vcvG2qfhokeK3i/4rY07c3+3+0frS6E/C3sg3B3GoZI2V7zcyvgnG7ym/3J8DrxifRLevJG0aL+Pw7jDe+JAY+xvyHOp/PNBc/EMJybJeyyFx0ysOo3tp5kCxbVqGMD2Tjz2k3lHwci9tQWJ/YRmMx+R+NTh6XU8RlCEFcI9OT7AqlE5x7t9NTW7SBU8MINrU1znmQ2QDFN+iA78BLqJB2EuEzktbTH19WcF8XwGqWwMaGEEpXCbhe4pja1xg/tiaGhpySBgx9ajr3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8REAhIBYk4YFYVfs2UkrXNHNU7pkXcrlG/MZuhNT1E=;
 b=DLCK1VvhiiV0ivY18u3OkgGTkejfytL8wNbtbVSFQdBpDOjV6/MHhXXyCgasr9qOeASeT1vc2Ut8J6hyhCuAyKGn5ZB60dDkhb/lf3w6OPcnZt/Pfx2Hq2HSA9Uj1impwZvJ7v3r4JLV0O1eRIjJ5BBsfn+4Z0GJ6U+s9a0Ytsj3oOYmB8VoZiE6JeOHxGw5erquqJs176f4W2J+7sJK+Q4aPH3w+zAe4JqtDkrmbXd5cjCxgP0S3CKILew5qERJ9QMBegC0JoDNI876U5nmtF+QMDdAngmPMG2O+s6njvdJjFpqzkiLhC9V98xj33NqFqTg3VIMjLeSkAi9mBi5eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB10319.eurprd03.prod.outlook.com (2603:10a6:10:53a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 09:15:22 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:21 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 0/6] UEFI Capsule - PKCS11 Support
Date: Fri, 20 Feb 2026 10:15:10 +0100
Message-ID: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f030dc-624a-44c1-c5df-08de706092f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|10070799003|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JuaG6Td8Q7K+THIcM0J8xG9zjHkavWmJimOQwdp7zjLp7CTtrvXfJvKxMps?=
 =?us-ascii?Q?J50Ku+nCxh7GOrwy2WBA0wLzS0Mj8xOxSN970mLMYt6b6RiDNggfPmWhXMeV?=
 =?us-ascii?Q?SvjVs5jhGwl3P298HzbggzYMuyRcNKHAKHG4BA4J+Jc+c5i86CTzISEIVrgg?=
 =?us-ascii?Q?DOnias6BZIkY/81PN+hEuisfi4Y02Tx+25fLgJD8Xx8wC99VWhu+5SXkSG1B?=
 =?us-ascii?Q?SNMfq4Gzj5PFfWWTxcecveC16EkYNwdhDz+yVuUwQbngWqI9k/gPzUBNF8C6?=
 =?us-ascii?Q?0Gk5Ng1OLS5ehOFW/RhHKRN5gsgaPzcbgl/ysAbR11cXNbRQoo4COl4YlX20?=
 =?us-ascii?Q?LxL6B6tbDDXc5h1DIYp+j+ohyhOiZ3bcxTaVRpR76vTEOwU4yYqrJwb4sVOO?=
 =?us-ascii?Q?pI1S4ZOo40m/lkmlOjkQWx051QFq3RZW/cjBLBY8UKqx6lBn0hYiwDBJTKMr?=
 =?us-ascii?Q?WuvQVYk8yF3rkFRGL6GxyaVeNjT9KCY8I2HKu2mGtH1WyYR+/sc7UvfBSZeM?=
 =?us-ascii?Q?vgCN0NiwY4sS6/KVLFIX65B6MKlaBxvA9J5tHp5LwDAMkGi03kzvFcLNRE5C?=
 =?us-ascii?Q?m1u1oJFPgi8J22nB7Sn8eosn8wi+L5m2CovAWym0Okn3ad6993eulncV8rKM?=
 =?us-ascii?Q?hRX6E101hHtciU3OlaxDfa8jDm+f8iVgO1JeRn8KOnYKZVpYgBRA9ytSyAVi?=
 =?us-ascii?Q?o5pbMLge7Wc191KM/8cBOTa/xJv34gHw01Eszi7kcmoPDLq4bMEH8G0pDptJ?=
 =?us-ascii?Q?kfZcFVDUJrbaRvKNKx7TzQ8wJ0Gtt/ifey3ME1s+ZxnB13KkzwBZER70S6Gv?=
 =?us-ascii?Q?b0YmQlwOUc3UakTmsCAtAYxbAZRL9hZwEgBwNuv2tJ/Mjn/v4dqkUXQp8YAw?=
 =?us-ascii?Q?5fPzknKWu8/uOaYhylP6eW+Q6E/teWmHorJQoPjmkBWKOM5/+QMUfEN88znY?=
 =?us-ascii?Q?TzWL15HfhMhd5QHS2ZJR9xFK6jtWXHbGHYmiOOVF1r8fPgcNMux+QN8fBBIC?=
 =?us-ascii?Q?4/JyETklraPVfPJpdyIHAvNu9lubn5ZgRg6zfFhL0x/kXiEC53CI4Us7GjDa?=
 =?us-ascii?Q?k0Aby22eelp+xZZH4fIq9asUN+4IAEonuWocz/nNc0PRGWZ+tPyPc3F+qE2p?=
 =?us-ascii?Q?tA36J4fo4W7utlDAiuEZxhP25PaaiLQyueZ5TXi3sqyhOmMAT3wFKv3pEO4S?=
 =?us-ascii?Q?RCa58MLGdBwcNcnghQ2dF/g0E1py84j7EIWKJF+A26OfYlawbKMw4hWV/9PN?=
 =?us-ascii?Q?CxQYSbxcaWudc5AnKYB/RTTgrURzrZE83mNwrzbozssJJMPBtoz83R8oLGC+?=
 =?us-ascii?Q?rmYkD/IJGwIff5zP1Qcf/NlU3NIFLC0/FHRDZmBzEidw0rhM8G4CyAyT6vAm?=
 =?us-ascii?Q?pEc69WJnAC3ATIRhx4/UXek0r7JzgTKisc0Fl5SJrwzVQ514wCK7QrZ0cdvV?=
 =?us-ascii?Q?alh7HIgw7IyzTDHYMWvHmjCm5FXIbacvyBl2UGrd4OjNxTtorN8qu0gNTp50?=
 =?us-ascii?Q?Hv4RBS+AXrg+LwztcbPo/iJ+oEU4w+fudjxjr0G3OWyDGFM+qtsAPj0SsI0H?=
 =?us-ascii?Q?plj2wi3yMrPvEjF274Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(10070799003)(1800799024)(366016)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpfSXOSmXu/sP4I4WF7I2U76REgnLIC23StwygM9lxfz1VhB7hr2+IyFZx5a?=
 =?us-ascii?Q?7Bo+n0ey1339eEIdu0laGmi9LDfd+upsOG2NSG+8v0ADlB5fMtMDiD6kVOvu?=
 =?us-ascii?Q?eh/t48+CHHf+8BcHfwTaiSYwiOq+5saIjCTAKYLejWu/wiLDrKUqR/QOL9YJ?=
 =?us-ascii?Q?ZZqZvclazxsGI2/pc7uioxBA3960JwH6EZsQ694/XVzjKSK8v+bICUZ93m0F?=
 =?us-ascii?Q?G+cGm8pkDCuTVerPCn+SFjiope9z3ARiGk3fsMCfRBGE6vH1UJTNtk0GnAOj?=
 =?us-ascii?Q?q7jPH/4dZtl7SQgICtoXEjMiDY8dJ5qVYFcV0bhq4fnsM3zslsnLwXx47T2g?=
 =?us-ascii?Q?qku+6snrWvnEtFuofYEtMh03eszZmpukjQZgmZrKrUH5DKevKoGX7YPkHa2K?=
 =?us-ascii?Q?7kj8DrJVOqQzDOumLcg64Y1LpLg/wbeRb3l/Uc6z1ACtAxcSgm1FC6Bnzd92?=
 =?us-ascii?Q?ucAgeciSJ2zMZ7SOVQb5weWI8dvMT4rXyzwFNFVDB/bEEgrCuT785GDBJMbh?=
 =?us-ascii?Q?gbTVQp4+JCIXNuflugZfhjIbVFD3Pz5JBfX+s0qbIsYkk2XGUsUL4DHspwp3?=
 =?us-ascii?Q?3RXtBuh19DjN+c+zATzOPSFG18ZGZvi9CcHF383M5upaeWWp+cPEfgBq2cBl?=
 =?us-ascii?Q?qSk3vWcDiEdyOMn7iK7QTdtFhY+aUK4LiqUO6jlOdwi1SwGZ/QUBk74wVnbl?=
 =?us-ascii?Q?/ZsEOPwjwWB5R1EQ0Dwi6dCjT+XRKDSSFLw2hwUUk5p+3hPf9C85ctC597ez?=
 =?us-ascii?Q?nuvrkEcKEsyuFe5J8KnENHZ6UbJN1gNGvP0z2GFeUNCl02+fe06zitnNZOrW?=
 =?us-ascii?Q?aaNR8FisZH5WMrxEsXowVA1W1vGfCTFjQi0fojilJjy3W3Uv14sclvCJxSKK?=
 =?us-ascii?Q?k8GJjbbN/ftZNP1pILgW63XLdHbYwdLJejMoZ7HUFJ5lrbdc+MZhXEGkSn8U?=
 =?us-ascii?Q?I/NP6X5cNOn+tjF6OA590DTqglACAn8vnPQDr/6Fe8v1EFwwIGiJRzuEDU28?=
 =?us-ascii?Q?e50Ea5xmmL7fJUX/VwKUkGh8qjULCWd/AIhS2TCcffiurn/XlglXuwqn2/Oe?=
 =?us-ascii?Q?GRzNOgOhrpE5ONeopK/uhkDBVZTyT0/6glQPnaVNEA099UuxWbt/KMLqIPLR?=
 =?us-ascii?Q?eJUJRI66I0AJ/mz7iRdsGNP4uAPGxhETyw9nZosq2sVI9MkcOPhjMd4KfMYE?=
 =?us-ascii?Q?oxZf273/A2hEkk0LoAbD5X+gqy7l1fPjwrD1PrCOazaJ4jptGwTxWJDfc1Mz?=
 =?us-ascii?Q?mw3uOs6L39IOf0GXa1PJNL54Y9nCSOjEIMH/uXq1VaT6Hr4SA4N+o8Ovenmu?=
 =?us-ascii?Q?gGp6IUwdsYzf1byFf8RWuRQpZfMmBwO18TneZz1kG6UBEHgdG0n23AXeENWt?=
 =?us-ascii?Q?Xez8Mc8RUtNag34ic6LRfWBhcnnkoGLgGg3mZgn4yU/TwSYnmh921uMQ0pMi?=
 =?us-ascii?Q?h0CjWYNHY/jzXGUS6hQ849AJYxVc1sKWYxSZLLV64updB66cfpnK2WXHOva2?=
 =?us-ascii?Q?YFCD5MDUZzLferykJ1pFl5ZrjUmoaTSShZBjOdhRPZOyWz93JG2dVdgFe5kW?=
 =?us-ascii?Q?tkbY3Xd2kNxlMxiVCYKzIScZ/5D5N6rEuQ51/MDGW1eyUXXgXWO2QaCxEyMX?=
 =?us-ascii?Q?ZjDoC8XWRDu5jO1dgn1ma2HnkT2droDoUhE/Xr+q1/IltOT6bV/SKDqMEmbE?=
 =?us-ascii?Q?9Eo466LpB7yUUBK4UHdIri8o1VpaAPMr/4gVbUiqhHSqA2d2x8u5zeufPsq/?=
 =?us-ascii?Q?nr23bYQUTpFEZUguH/pa3tyFUXKlhRenBa1FImxHlALezJ6rP2kS3sUluobQ?=
X-MS-Exchange-AntiSpam-MessageData-1: Thod7XF9HgC0h7FOjalGuQqg/sDjhODqCCU=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f030dc-624a-44c1-c5df-08de706092f5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:21.9033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAwo2ClG+4pqw1GeVtT8Jozow1JNSSnu2t7JlPUOnTOhRWlabNNNYxAXIuk1qZ4wAU0xM8iGEfrTr4Ct5q4lWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10319
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v7:
* binman: Add support for pkcs11-tool needed for certificate
  import
* binman test: Use public certificate and private key in with pkcs11
  to get 100% test coverage
Changes in v6:
* mkeficapsule: use strlen instead of hardcoded values
Changes in v5:
* add bin wrappers in test for all external tools
* improve error handling in python test
* fix data types in python
* standardize option name in mkeficapsule
* fix typos
Changes in v4:
* adapt mkeficapsule python support to dump detached signature
  for authenticated capsules
* verify detached capsule signature with openssl after generation
* use p11-kit to figure out location of softhsm2 library
* fix missing long option for dumping signatures in mkeficapsule
Changes in v3:
* fix write file encoding, env setting and extra line in binman test
  after review
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (6):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  tools: mkeficapsule: Fix dump signature long option
  binman: Add dump signature option to mkeficapsule
  binman: DTS: Add dump-signature option for capsules
  test: binman: Add test for pkcs11 signed capsule

 doc/mkeficapsule.1                            |   4 +-
 tools/binman/btool/mkeficapsule.py            |   8 +-
 tools/binman/btool/p11_kit.py                 |  21 ++++
 tools/binman/btool/pkcs11_tool.py             |  21 ++++
 tools/binman/entries.rst                      |   4 +
 tools/binman/etype/efi_capsule.py             |  17 ++-
 tools/binman/ftest.py                         |  73 +++++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
 tools/mkeficapsule.c                          | 113 +++++++++++++-----
 9 files changed, 249 insertions(+), 34 deletions(-)
 create mode 100644 tools/binman/btool/p11_kit.py
 create mode 100644 tools/binman/btool/pkcs11_tool.py
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

