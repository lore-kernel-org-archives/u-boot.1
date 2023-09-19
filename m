Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275B7CD54AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F67186AE1;
	Tue, 19 Sep 2023 13:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="CNYUUH+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D97786B4B; Tue, 19 Sep 2023 13:37:19 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2052807BC
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpLsc2x9P3L7/wi/w6m0uBuXEwemhHIX9u+rmuAQGfZVp9TyFnpiumH7AYK9sEP4PGHYZSAO3ky2G3S+PIDsAeNeA5gSj51Ml+ifKPovl43z1YM7rPSS7LIrhBsfXIWKXi8aO8BkvV4RRS2Ix5opDHCL44yTRhKrcm0+AyEHb66PrusS1HGZB235C0Yyh4si5s07Y6bCVupIe/Uku+rpcX/UXo0sUz6fL5f+R55oAMs/qQOeWZdvvaA/HTXJ1spT/v5bRpeQBgNtZHqxCnzK35KY7yN1QBImfDlokt8+51f7HRzTM/DIlTt8Mphh4I+2Jxim1YItbV+wFOiUboj+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryt9mjaGViRf6bUjBQ4pcnwCFokMkM7UlISidu5oomg=;
 b=Ljxf/E8NtcDWqyqpbzTbjYtF6acR62FyrqztMCZDo3x48Pym8Y1XC9fwDhNw7ApmNjJmz6BEutwFbD4nHiTt9en5kWekLxQzypSK3skRsAado8MNPlrqRaB5V/KM0L2d41BRBc0LzKutAZJsI42KWMtU7fIHhvUhpycZuAXTbV/rfUoHDpi2+5Bet5ftAGIP+/MrK2AQKQmZiPP6GG6mHfD4mHPTXPuLnqS+dlFMZzq1tJP5NOT7rR3gyd/HUyA4MAhH+X5ByOojF1iGs4NRoFzuxrHtbpm3lrpybF1Kix2I+gXQ3tkqfkU5zOm6Q+VBGDGirKQWsMPuIcJfUJ46WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryt9mjaGViRf6bUjBQ4pcnwCFokMkM7UlISidu5oomg=;
 b=CNYUUH+JBgUY2vX1G16lMSHJEiBzb8JLe83fatagMSonqy/iYqgmoqTts4eKE+2pu8qOY2qAA+zr+LGPigjVl7VzZTaxCcmvFq5kof11gmvP9vDLDCk2ODM4dQtmxcIk63w9v7VM6jOngyX5he1Z134TJ5E1k/RPETQARZuquKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:37:15 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:37:14 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/4] mkimage: also honour -B even without external data
Date: Tue, 19 Sep 2023 13:37:01 +0200
Message-Id: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:208:be::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4957f62c-0cf9-42c7-84f5-08dbb904c57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqoKglFCe9LV8hQZCeT/mizIO11HOtQPMSRzHm5++ElhLCaqSUIZPNI4ZInBbXpz2YhDQ0+NhS6P6hqOkDSxyZd7rWmyRBLILscobme5cBVigqx2EFH99ja04aYg06x4xgUl5BlvXY7lwgVbYCj5RKGpd9u8+FTWoUJsw2DygAV0xInBGt7SY2tKZXz2rj57xhoqvkOjXQ/RQjGHqdQqGIskYD4crMqrOH6vUDGMJmzwZx9CqJDvZA3D+pKg2k1XgPR4ViQy8+64RNIQIEHkCELxWOp77VOdywrPqHT1LXKE+0+eA5sNQ5FM6WIc6Ijis6x7qPpdBrFvZk1dSaP7hdkgNdy0pJYreUYdHM8NoD8f8yYsSAXKCQiUbBm2m4GLnNUwAbxnOLW5aoAvSt6nB/xF5uaVyZTHmY1ss5ms0QTo88gPk9Ape/Kf7pcnC+sOh4hWdIBktDIRbuxTfaP+58UeujT+0k2d+V4fOl/1YAU8waRmtpHgNjlzq6P5cA3CrIJOxhVyam5J2l1Xcpdw1V4gaTn8YVrQg6haXcE39YGkrtaAPUZvvvAqj9LyqNgpEs/Kx5EuPREd5+z69UGp80KXbEeR6bb7AqM0kGQpeSbOZfdUThSmhGY+r6X/kI14
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(83380400001)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(316002)(6916009)(4744005)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6486002)(8976002)(6666004)(52116002)(478600001)(6506007)(86362001)(36756003)(38100700002)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1jHSVqIA/FjokmPB7vdTWNPVPILJ3GHCucRr8NZzUNfil+0ZTTUTUKUlWl1?=
 =?us-ascii?Q?NXmevxaPwqzHudx3oU8M9/UqMCfnzBL7/kQGlWbmmCyG5BUCqI8CFH4Fa6gr?=
 =?us-ascii?Q?S+x5W3bBh6k/OiNfDREt2ZMX6OXlZJrkPOJUIvPhPA36O8V4mxA7JYKnwcOR?=
 =?us-ascii?Q?QcATdVV9vJK8hZZotcyAEFvCjkR5l+hlbBa51vHK9y8u4SRoA4aTx0a92n71?=
 =?us-ascii?Q?xE5fZwj7iriRFMrV/I3HDvL3a81FKb2qGhSRGiFrG2yW/so7WUlACxUhdazN?=
 =?us-ascii?Q?RmEbUnkIgHMCrjQOOhgPcmpy4nhLukLrL/yO4ttsJg5T1DsgNiRaXtZd5myh?=
 =?us-ascii?Q?IahP40mltSPZLa1OXeJbcweLwk67VolGX0g1dy474DZ0FkYq4NxSf+L2G0Ey?=
 =?us-ascii?Q?OM1Xi5esNp4FSzCXtoovtqCXGJ+Jnf0CQc/T1yzYfwQDDamPq1JOWIVoXCDC?=
 =?us-ascii?Q?pXrrcy64nMIC5zNZsYhv9Q8W+iw3UXM10G9HQYElBTeTWiHkXkwgbbglv3U2?=
 =?us-ascii?Q?wrFqdeXlBLRF0Yz1GPrzHFIrh1gIZD6GnLo5UuQeHtlqZTeGiSCuHUBZrToJ?=
 =?us-ascii?Q?at8WbK3kXPON7CjKmH/NvI6kksISS7Jt1rfh16IMIK8/r3XI5/FbkvJoq6g0?=
 =?us-ascii?Q?3ogp0LydbWtBYcfqpSIBNGHloNLujRYQ5gyUj8kGYzEZoPYC7egc+jkdcE/g?=
 =?us-ascii?Q?Pe4gO+nlN8i/hYzukO63Ffe2Z7dTAnOjbQTzlJlGUVYQNsUPzJazOw8YtvHj?=
 =?us-ascii?Q?kGjR+5TKUH/GlXW7BpiLSeUiT1MIGROck+mI5yuFKHamEkyd2o6MqFHO17sg?=
 =?us-ascii?Q?poGqvJLWZQth67Zbsza1eBBsDzZuwF1GltNoheAB1NyacuDwFSawBJuQK3n/?=
 =?us-ascii?Q?ELt2j4Smpvidj7jqvFyIBA8mp7ZnDvP4J8mgMlDYQj4CjOFXRlS63dmwGr8G?=
 =?us-ascii?Q?E8naVyK07aZg6xhhO/IdPqpp18z6GgTU8rWH8ZpseEytmnE/cqASatoHXWeU?=
 =?us-ascii?Q?uhLECRlWPY4N5HqlXSWN6n3ev6UKOSzhpYimSelkXFw2wV2Irg1mHQYn6zjF?=
 =?us-ascii?Q?ZCkLTcxdvwUbyzWkQz/n5RRWCNbJAGFsMguL9ELoQfQhkmO/KrCAqg+6ewc6?=
 =?us-ascii?Q?MCiiANahwtz2HNsqk0RswPuBA0x8CHlk6YZFkdAtdIQbBMnleKieqY2f456Q?=
 =?us-ascii?Q?ozXrO2k5y8dqfJj7M94YARruFZQhkynMhcZGMy1UYTrsOzC52JcWhI/iKKVo?=
 =?us-ascii?Q?mT6bRNZPw3p05k+R7mNxQ+D3RtDMr4flrfz+C/VQ3bSrxbfF05Lwa37JIYjw?=
 =?us-ascii?Q?szs+I3PEq+F+Pje61t/bNzTXZPqD8M6ks+nkXqWaMABzvTv8fZwN/fQhk8tC?=
 =?us-ascii?Q?YkvMnFE6sCb3pSzEZSexqK4G5L0Ailh1HHWibgo58+6q4CYXR4TnsGWXWqUD?=
 =?us-ascii?Q?8Qyn8Y19ZLqJBuh7DFJOJh7YWrWR2P09uBCoqfcQ3vy8/N7hgbVSRJ7IxeW9?=
 =?us-ascii?Q?r2Z2xJ7IcmYHenixYWw6AkMpkD2jCcPFfVCBKp2QrePwbPofqjv6F3Z4CMQ5?=
 =?us-ascii?Q?mNPSPET9SCM4BwZCaS9syH7ZqRynWvTDidyvHJNBOOm+8BC4NUd8fD8Puy4z?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4957f62c-0cf9-42c7-84f5-08dbb904c57f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:37:14.9044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P53NFLSFrAIg0+T70jwy5Wk3kLspXl/gogT1AfFwe3TFVs24/mejYPKsRhkn8I6ODS3n4SWjkJK/74HuPR/fICVpyfVlhhA1sg+1tDNhUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
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

I was surprised to discover that mkimage effectively ignores -B when
used by itself - the help text suggests otherwise, and it's a
completely reasonable thing to have.

Also, binman already translates a fit,align property into a -B
argument, without requiring fit,external-offset to be set.

Rasmus Villemoes (4):
  mkimage: also honour -B even without external data
  binman: test: rename 275_fit_align.dts -> 275_fit_align_external.dts
  tools: binman: add test case for fit,align without fit,external-offset
  binman: update documentation for fit,align property

 tools/binman/entries.rst                      |  5 +-
 tools/binman/ftest.py                         | 14 ++++-
 ...t_align.dts => 275_fit_align_external.dts} |  0
 tools/binman/test/311_fit_align.dts           | 58 +++++++++++++++++++
 tools/fit_image.c                             | 40 +++++++++++++
 5 files changed, 112 insertions(+), 5 deletions(-)
 rename tools/binman/test/{275_fit_align.dts => 275_fit_align_external.dts} (100%)
 create mode 100644 tools/binman/test/311_fit_align.dts

-- 
2.37.2

