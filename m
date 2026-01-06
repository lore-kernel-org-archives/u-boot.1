Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C05C47BE6
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 11:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEE783B64;
	Tue,  6 Jan 2026 12:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ZLgD/guG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEDF83F63; Tue,  6 Jan 2026 12:11:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACC883952
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 12:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhYJ/gHHn6iD+QYiiOuNOIk/OBNcz1QkMdZgygPfm9KyAOijZVVfjb/REpINp/8dcikTCBS8WVY4KCwLFqhEP0M23zk9y4ygXkvia4+g/WgBK1iE/lirOQ9aJbrCN5uT8wASyyX2+GtmGmiFSEsHd+Fmsa7H0kfJ0mWVdvIDDmAbXrQ8DfMfZgUvmo0ZsE2pGsWZiUz+ubkX9Xbri7uI/bPAfgan1rUA49ZU2yRYHab50E/yxA0CAOQhVCiPA929IEKervJaTx/X/lAY5tzkhwTtfwQUmSLBUxsC9HE6ISpGSdQaAR8WErwXbuxCL/iFGHzeNsqpLZU/3qLIbehcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXwscwtqOL8x0sFBpRGrwIkO60gIPgL2p0a21JpOrfE=;
 b=gEJgBdhFFpl3fBSIUcsHJBRlbVWXtIkj1SDLIp4rgndSzfUg3aRakqIyREcuTEq2PKZ2jHaVpuhsTAz5Pv84F152Tr01A30zqvwSDfIZuoWp4PPrXYdfu8RTBbCSy6WJ+cZqdf5Vnt7QcNGcty64a57LsxxOQ9iZst7YqWydAu9kSqFotYb7XkoPUKalrFLxE7VFZd02jzO4TVvsjnqH4DUnAtJZ1SNmIJGrhSIlvBiu4Rc0qezPwfstr8J8e9hm0V5w5g2aknnFK94/hskWObpM9Q3bZ9YtEr0HvlaXNmzMJIGW1gfEqcMhcwaZQhGXv5wZhYxfv42gzzYdzUzTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXwscwtqOL8x0sFBpRGrwIkO60gIPgL2p0a21JpOrfE=;
 b=ZLgD/guGQblUK0RyLpWkraeKdBP7qMkaOSQ+/nYK2RIFB1x3KKSTjGjMVb4sC1GmZQiHuknH+iRPCG+gJVBqKLRdlD7NT4kcWyo/7tdhbxralFBTzD0/b8bUuoPe9UGprqImphZEDSnsju9BZyRbQ6ZkKZhtZ6SIVOMO0uy8BoQ36IHn5GqQeYndmQvtt+Gleb9lNBqM06T25mijbZOXeXOUgQwF+JvNzFSSL+PjO5WnOX4HeDYFxvo8+3z0vl58e96x/jSCdKUnFLecBov0AZecylEHH9ENFBiwIUpjeuthycch0fJ2s5iCQ8ePJcUh0AlvMQGrrc1fJFKnjH5iMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7302.eurprd03.prod.outlook.com (2603:10a6:20b:2ec::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:11:05 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 11:11:05 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH v2 0/3] UEFI Capsule - PKCS11 Support
Date: Tue,  6 Jan 2026 12:09:56 +0100
Message-ID: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da2114c-d672-445f-c1b1-08de4d1448f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djmSrpBQqd5nedQ7UYkj5xUMLufEqJ2OE3LXd6OAvr1EkwOPDaDhMVkHjTb2?=
 =?us-ascii?Q?fydl3Bb+cfukyVc5+TvISVH9wWPwiQLgEyFOFRW6rDTW4hGn9/0uiYIKxORr?=
 =?us-ascii?Q?vkqrhq5DdkIapGHT68nphMgU2hxFZt5FdxrZM/jsZMCQDAmN96RfLWQRRW7y?=
 =?us-ascii?Q?8X615xQqWm0bNrp1e0Ll8GbLC7refHilAT/WepsWeX39XCjHw+/anj7o2VjA?=
 =?us-ascii?Q?RKNfioFxAkbNINYWsColR7OnqYzsXUoOGYcTXKDx8Y8bp3k/6wHQ9pd6ykLk?=
 =?us-ascii?Q?jYVo7hFk7e+v9ilumlGvnOSeGfehaZ8UIkgEDdaRblKsDw0qxiH0ctCv7ITw?=
 =?us-ascii?Q?mk6E0scA/Yxsset9bRl1gFIIvQNifsIJ8nr9n9IwZH1NPXdKEudmRaNjpuJA?=
 =?us-ascii?Q?5Z3qF0ybEdna6G6viTM7VRRoDz9QZHRkCIPculNyuJ86LZhsMkn8oyXchhkl?=
 =?us-ascii?Q?NgoCXJVmVlgs4kioDOZuNQjNVJJ/dEjkg++JE9xr2lQWlYZYEqRd5cE7Uj59?=
 =?us-ascii?Q?HNmoWvFLsZBexVyslxnxdM8csHaqdmnottVm0Yzwk32J7BHyR2loiWwQbt43?=
 =?us-ascii?Q?+hjrNEfP84sbZhEMsajRNhAmxFuYJcernUhBckLSirHl+W/1uHd2m37IZuhQ?=
 =?us-ascii?Q?CEO3OJXYfQjET+ZuY4waOvBaoqH7QMnnlplQGLLBJi4OvHHyFtbq8o01UdCr?=
 =?us-ascii?Q?oLgrVIAf2qNxf5GrhxrnLR42bnH5oqzbzuu9lZUguJbMMYUsfm/A7VeQMZdo?=
 =?us-ascii?Q?gvubItTZZ5heHRJnUtW9/oIbsTIaZxFuTiVwYpQmeUjwm/oTH01KTSS1iKUq?=
 =?us-ascii?Q?Jvc+3O2+HvEABuAWcZSRa/INlmWzzVetCt91f8519ovnKzeE+xFSUSTVp3DQ?=
 =?us-ascii?Q?wiFweZceQakS6oA5TRcdHFhWF8Yig9hrD/OhpFCIjk9QlQ1OHstg1t3f8RRX?=
 =?us-ascii?Q?HRJRreraiumOtiKpSd/UvOnF+8QJQtGHeKCRzAA6hZeCWrtj09gGsHIeJmSV?=
 =?us-ascii?Q?06PGzV+U7I3pOoqamlosHgGyYRuP+SaN5/iFXPGG52JE+kncH5gvHZ+uFaAb?=
 =?us-ascii?Q?PA9izdNanDlyyry1lAYvKtj46auJ+Nsj3DvbOhFlFRc2Shzn22XZIHL0htEU?=
 =?us-ascii?Q?zLe4ufY9yHdUAkjFBb9rhPOo/x/PWQr1kwZGYYb639y6g43onZUaXTMF5MP7?=
 =?us-ascii?Q?1Z4jdtoddKBPq/luMT/D4afhGd53VYUpLjC120vAsrTM7Va1vEd71IBes+WX?=
 =?us-ascii?Q?+VWQhgPBJgisQSMGk+PnXqQKH9OObbXLdaqtWWFLBc9BdjJ2P4ux9+oIwM24?=
 =?us-ascii?Q?v+CHZg/mqJnMjHOP5qo7OoGGoVvgxd/M5Ga+QJ2CNA7VhdjjLwvTYZ/wcrh/?=
 =?us-ascii?Q?ix2rC6XBsFGYf097TkuZ9T5kb1nIf2FsLYMMmujw5q5YqbAFoC3+6L2hbKFa?=
 =?us-ascii?Q?UBG+VF/ooGDGYGB2PVp1H90sqftB5PEQerDUw1mHBVbIuFrFlH+je8FJcbBu?=
 =?us-ascii?Q?9GK2g0VoXIH1yamWuMV7z2ALU2lAjriox8bY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pS9xu6QPeERGd4Msml81JGnTVVL4OEus3GKcLa/gOwheINFHapzsJlzNHks2?=
 =?us-ascii?Q?2pjTXXTG/+J/IWsjlUkC5mYWjgW0It3pYAJW0Oh9u+A7FFeSFKDiJFHaSICw?=
 =?us-ascii?Q?Ux5sXaC6RY2uK7WBTzLECo4ZR2xWXNorBacqtItVkuhyo5djvEV3M6fOBcyg?=
 =?us-ascii?Q?40yAIlQ2PmrkynO2dzArHB9dKjTCgJ5eGC4+HPhpt7DbXw+HyWFuNVidY9H9?=
 =?us-ascii?Q?SJplkyCg10A509l/EdY0Dz5xqdBWTO4D4CWWf79ha/cP3vz/tChA+QmA9guE?=
 =?us-ascii?Q?LaHCGGqOksE1pU+19f03PGDEomCuvVTmW2r2OYjC2JGh0hig+nYcWTZf4rna?=
 =?us-ascii?Q?1v0GWji7E5ec+xBioKm0lbin6/FojC8xPqO1j3AKtj5cgSo4H1OvNFsnf9Kj?=
 =?us-ascii?Q?2o5Vi0+DP5AED3lzPEeo+BUw0GMRVhCaSJ0gGlBM2EXNoqz8Fr9k4jI8FBre?=
 =?us-ascii?Q?6KW8KFDoCSGpNtYLNHQlttg2Gv6KAS8Qxkgl+rXJw5Lj/NZcOxI+EP/mh5W6?=
 =?us-ascii?Q?+pG4tQmlM93EeTAvhP7JoYlS9WeYvyQO39ikAYW89P5XgoOy/0uIOAX2b7ko?=
 =?us-ascii?Q?XlB9HtnnSWM8xeHBVIAbMyHVH8adUrO2pMS34HmM4MACny4eIZlDaVRGSO/H?=
 =?us-ascii?Q?fXggHk3dZb40E+bf9VpkezUURbGvlx64ar2HrqVSi8xwb0XZER2tnu9o4ZwJ?=
 =?us-ascii?Q?TgbbMLbu+fTdemGKOJgHwyeAV5tbngefClN+bAOZEXOqR/q+VjMDjyLI6XdC?=
 =?us-ascii?Q?bCQuSnbQuyQtS6lThfQrlVWqtGROZ08v1KHUqu8xhuGEG9ISgXVa0x3aEBBI?=
 =?us-ascii?Q?VK2yxkI/PKRwm3mOhzqi5rj6aNr7867ne9vGJHh1K2IPjXyn7yzQEYX8Q8ld?=
 =?us-ascii?Q?q2Ffr+Z+hW5tABs8MXPHJtpwTGIJmsTpISs1V9HBmRy9CVqFD0xAtmcY5rs2?=
 =?us-ascii?Q?ff/pLlZa94YmZy8XicVnoUDOe2AkrjkeL1KdJqYozYgSBXlO+T46uC0yFb8z?=
 =?us-ascii?Q?EaI5BmFYib0nLe4IJ66IweaB49xG7moqCPE5XWTv8kBt45e60QrJ760RCEue?=
 =?us-ascii?Q?yL0bXqagNEG1zTnWdp29I74IxgrXT/ADbUdl8Amn+o2GO+5bnV7by66yotTa?=
 =?us-ascii?Q?ErsSPQMt1AmH9hxEgykwrKb01y9tL1wABVUWzeMUk/pVSNHqVjZ6IDtewNA+?=
 =?us-ascii?Q?4yYo8x/LhHxRKugfGRGpIJfLghOIQstxxefIxQMqFmuN5LjO8TyKce5m6Ixc?=
 =?us-ascii?Q?rC7pXxT2gd+FXmcPxUNqF9E7UV6anVetcysXgW+32H11H/KaBHzIkydrrcBs?=
 =?us-ascii?Q?UMDaC0SEFVC7DLY7x9xd+wwBqCU3m1s8aXt+M733EEbV7t9XTuXHnpkNfC9m?=
 =?us-ascii?Q?3uvYWrJG2rKZjLPfkzz4/c8ULLvGUzwkWX0vEKYP3OMNqj5mhVyN9EU52Y8k?=
 =?us-ascii?Q?G7wI6yWQtY//hcniaPKPddJdnqzBN4tejgfOH2hX3kQK51FYqpXJ8sFhT5/K?=
 =?us-ascii?Q?SvPKD5XbEn4LtxZzSOsSr1rhAXbeQmTs8+B4gZQRBaDUwKn7kbrCwNFqfOUj?=
 =?us-ascii?Q?vzLOAJIGQbs41hPrRtLjtKSHwMgsYVO4LTRYZr1ndcg256mnrHQlYK+CTHXD?=
 =?us-ascii?Q?UC2U8Yv0E5CfCx9zgmQfZVDHP3DjlVvQGc27SNEqRxHixsxiwRxu+ddwg3UG?=
 =?us-ascii?Q?H1jdU2qu8RGnwAReQlztrXt9LfOCgz00Bkct0TYDJSEUgTFxmXzuNEQhuAkq?=
 =?us-ascii?Q?dA653J0lvA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da2114c-d672-445f-c1b1-08de4d1448f1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:11:05.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQJygtL4ztKWm++9Ht+zQpj7FkHOOuxCKt4SyUWh1Z/pkIrjDfzpMufc+/NCG5sPYQ+U4pqq52Dxh6CHJvfiVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7302
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
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (3):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  test: binman: Add test for pkcs11 signed capsule

 tools/binman/etype/efi_capsule.py             |   8 +-
 tools/binman/ftest.py                         |  46 ++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  20 ++++
 tools/mkeficapsule.c                          | 110 +++++++++++++-----
 4 files changed, 156 insertions(+), 28 deletions(-)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

