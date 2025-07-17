Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75BFC83F27
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 03:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AA483285;
	Thu, 17 Jul 2025 05:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ksQurYFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674C983287; Thu, 17 Jul 2025 05:25:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DC383278
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 05:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC4JZJIfjv0zzCGz+wwbiOtqF0EqDbXXZMpduM2ojXkLIT1C6s0SXiXFDPe7oQtCBUUfHOY7+9MNW4JVabTQnqgG70jeGUZ5P5sDj7uhKiWHX9SMkQAlMoBsEVx6syRuTevTX2ZcuzNNGATh3s0kl2CsnhFV4uNyl3kGv3bWGl3uxo35tsABlJc/lOFOe29ojK3Xq8eqc1V07Q7XBHY4+aMKIbx1E2hVvI+HOGuWVI9aQa+S++VHHmu/0JTpfV/DURfrwIdmUnt5CV8Udw/rBdiiNjA1mPbu5YI3S0ozwDDjLNoMi3quHl1NXDBxRodUjBo9j0/qAXDi1KR38RDifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qejKaqEe9rDvf6y8jmX7sqzVUNR1kDMrDhbgI3JudM=;
 b=CMf/vOZiI7Of+47Q7jxukdIEj/IWHImRrSacnEsw4kwQ3y2SPZQyKn2dBHMFPvkuId+IorI6FgriwtI+w4qsVF4jj7F8UIfQBJjPB8y02uNOPBglU2IYKHEzO/AVJKgraZTwstgp9lSd9IyxwnCCVc5wecGZO92JTv7+S9ie5Fzv/bRJ8Lni+SJeKgLwUF6a7usKXI2pfjRPt40JXvuvXLx9BxSpqVnaARGycA67WQ4cE1Jai+IQkgpC8mMIXP9gFK5IrezLxMYZaRBXfdHwwEmZXRSmMGEInTbhqAFN8oPHed+6DmRAVD2bM38TedozbALDb8MEcwHva+V//38HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qejKaqEe9rDvf6y8jmX7sqzVUNR1kDMrDhbgI3JudM=;
 b=ksQurYFPOnDL3yOKy9oDNk33A9zOBmeLBlf6LvhjjQnGuZE8+41u2eugpLz6aDifqpaieuyJ3+M0F2G+4YYG5tkPzRSDnuHjne25hQ7vWwJeEZxZuz9Xauir/RMIyOqHLUS8H3tlIYNyvwTT+yAr0jIOs/6QIlSp14B6UpaZzpCCCNMFC0NVn75BvepB1vGbM4et6RSeEsR0GQ3m0em9BDKbJlCKHwZqt6elDllMBTCDJ/j4V2+7su4JPu9q5qBj0U5t+ME4NRpyVELkWndqW31GgihGLx6UEOjcMRxL5UikwjvdMq0+SaflAc0nQr/URM7Ak+i1D79JRGp3JdPJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8452.eurprd04.prod.outlook.com (2603:10a6:20b:348::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Thu, 17 Jul
 2025 03:25:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 03:25:24 +0000
Date: Thu, 17 Jul 2025 12:35:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-2025-07-16
Message-ID: <20250717041933.GA26574@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 324e1976-0d4f-458a-8e25-08ddc4e190df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ygpEO4qsBwdbsS1r69mSz0Plk7RUzOBygpSBReKYJZUDBdSGNxpAbcyXuF22?=
 =?us-ascii?Q?LUupeitq+AIaIXIok955V8mWmh2ZUGryk0HBkwJ/J8YvF4KjjDbtXkJo0/78?=
 =?us-ascii?Q?4abUJwQm5gnR7so8xDIn9/NlgcgT21yE73cyK8ckFzMh9Vw4E9mHAaWYcJ5C?=
 =?us-ascii?Q?hN6GVj9rJm30XEVfg1kC9qm368MHAme/1XBNRdGTqd/SeRTjD07W7BaYzXs7?=
 =?us-ascii?Q?fVY5i3zpHxguE0lO/JYm9G/y67V0c0UWPF4btR2+S0ZigyzYvxrvJNa5iYAu?=
 =?us-ascii?Q?Bco1uTyXAMq9c06vrABcomO1P/1cQjNTmPDzwXcMgqi4GcMMH55QaZUx/UId?=
 =?us-ascii?Q?75sGG5uSmjfihhxpjCmxYcrpcQZEmCQh9MsuQlP43XcSaeiIr+veh+MjEkOJ?=
 =?us-ascii?Q?t4cJzehN9pa3UzAL3B7iFpmHsNDdr7MftuoW2oyCViAtADz1/VNrFxVrp5QS?=
 =?us-ascii?Q?83CYyykQOwwlmwxA6qbbs/3VoQ8hxYNrmn8wMTOJS6uusCmfiRFmfJwzaayC?=
 =?us-ascii?Q?r1kh4U9+BvbCqf7GwYBUgT2qyU+kCjnmeJ0h+jB8S4/z6UhwxetX4HbUppYS?=
 =?us-ascii?Q?lUHfqlDu5R9fYkE/Q5vtx5xlTBNxVVvT5WLO99iLse0/eoGwCOjVviKyFmN6?=
 =?us-ascii?Q?GTnn4kuGK/U1ejepAatbm3q8UH2l+3MWj03hol2IkoxbGcd02bKBaFkhc6Z1?=
 =?us-ascii?Q?CpM9PJlvpGySqQiSRPSeKwyDV15yE6+mZ5YqtIU0sM2a636TL/4RUEA5diRy?=
 =?us-ascii?Q?813wYtmaiFDlPtskRUHhD0ifujTyVCHtUPrv2N5o54vlQ2sDznq7d1pLLAeC?=
 =?us-ascii?Q?tdg/MR6tNFhryAYOd5d3bt7QRaq5P6R4vVjwPxONd4qqNg2V8phMPcaGXLbs?=
 =?us-ascii?Q?jcbjnlNtHvQ/91zIij9PkXX4ql/TcRi1b0gC9R2Ucpt52882rHLLz3iVG3Zh?=
 =?us-ascii?Q?u0WnW9tqIcmwkxQaWs/TJo2Ht5T3OyoS/WRndsaBNNKhJDeDMCyZHJG1f6F0?=
 =?us-ascii?Q?DXK4Xx5d7QZMDnlzK7et9o6eOs91ZQ5UX9TLlD47ZIokmJx1x5430MhaYeKS?=
 =?us-ascii?Q?hbmltNfIeYybVqFX/+PKBN8CCWhOvFSfvlUpO1TJH69KRu297b/Tb4dd46C8?=
 =?us-ascii?Q?HIog8XmaBcnt+fQhk0fUViIWpvYFd1+CajmcJ7qAKheJdZSn5JkajPpNShLq?=
 =?us-ascii?Q?mKmNMFVxcUZLpvNeN51eQjXFpR1sAEUETFszHT+kQv42xZYpNe8VVnZn+UC+?=
 =?us-ascii?Q?pXklw0av3PBnrd+ynzJHTYAMtp0h+CetGfSb3mkwK0pX1kAjzvFt/Fmy/ydI?=
 =?us-ascii?Q?oYBaVTwmuZCfM/Ak0JQyeHhXmEQxnpZDuszIfrB+XlKdN0zSG5I2xhEyvkii?=
 =?us-ascii?Q?YDW0uvj4RuJrx0A1ZWOJ/7KDT7O0BTJWJpp7kdGhZGkGtObluC+ki9C8UBtk?=
 =?us-ascii?Q?27qFAFT+R9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?syhyoOapWEiN40Phaz/TFr79h4tO2z3+U98i8FfJgYw1GtwSHrOuGjhY0YCL?=
 =?us-ascii?Q?Bz/a9gu/XPM4cgFIte7unL+vg66qd5W3ooyNth7eftrcTO12b0vPHNZ5P8f9?=
 =?us-ascii?Q?A/9gfZvsy78eDqw06OgTr4vg8Wx6qv6iWDhkVt8epf2o4lgkQBu5U9tA19zs?=
 =?us-ascii?Q?aIsmqEM5im41CrStYj0tWAzueA8pO5U2CXwEKmzENwiAq1mJHPeqA5HoTy29?=
 =?us-ascii?Q?4fR3tKjAU8EK3XwjUY5c0e9CpAP4ilyaJG9WBuyPiYDlzCcplhD9W8hrpySu?=
 =?us-ascii?Q?57sifKafbDF/wNSfm/1EQE6uKhQ6QrMYCvvVr54aQ4f74tVTBa9WG8rQ99L4?=
 =?us-ascii?Q?VK+m0AKl8Pvy+VNiYmkJ1udxThJwOAgsxkWZxuyY+ijBRhY5JmneQjhfkAgH?=
 =?us-ascii?Q?KffMnbzx20nS+Zag6MTtHsRLHIi1TpYHIJufwyd9FKRVGY/V+D76+TtfbD5V?=
 =?us-ascii?Q?UOCJCIjmyWuI1bfTxKaxnQwsrsw3hvpqm8ldWloKaMdr2MAwSiIKdic7y2r1?=
 =?us-ascii?Q?WG6YYCTDhTCPZFLNgKxarSmlbcFnpw1xLWcfLcGyskSw8FYTse9iTBF2jkJi?=
 =?us-ascii?Q?P5IqvgxV10doSHIX018jWTYqyZErTjrjegjrKmhxmEBwaw57Zfutio4HmEs3?=
 =?us-ascii?Q?xVp3b/jPj7CwZi6V9EE8C5jhmPFqT8Q5t+ncIG6TcbuAjXeMCU+4z6Bp7Fnn?=
 =?us-ascii?Q?D0dWZcFDgMgB5TGjvyZEy4pM2/8PzhxyGCwLiaooiBQhFKyEBcs10fr+yQ+H?=
 =?us-ascii?Q?zBpccEa+3r/IKkwGvOJQsKT3Vx+G59eV7+17eWTNLtw9KFMMgAfeE8/G4cEe?=
 =?us-ascii?Q?yapPJAYIWbIPyi8HEtWhrzO8Kz2rmmbjtJ3xFLhGEZ+E9JvGNA5X1xBo/GNC?=
 =?us-ascii?Q?pGmKV6hzyISSQatCZzaeeBXIcjjHqS1nCVY8B7qVp3tqYH7o0GKSgnsL9nql?=
 =?us-ascii?Q?Cbm98tVSL1kenE0JggLCZ6+aBFrDNF40+bliHfxFyqwJWNH3NL9m1j7WVcsz?=
 =?us-ascii?Q?Dj1i1MrmL5E8Qxi19cNnpXgQ6X9sW7iXlRGApyIceLdDy+BoBGDWO4SAFNm7?=
 =?us-ascii?Q?0xYign11AmIIDWQsuZhwhkF7BEF6Nz+XQRam0Vf/fDFsRtrHV2WrTOHLrBI4?=
 =?us-ascii?Q?nww6jYxRB95NolSko+bQv3MW8pbz87VcDofW0MkgxRUItSi/rvDMmp/L7wjM?=
 =?us-ascii?Q?UEO0EJNTihrLBqiHyDEWOS3Undf8kLtRmdPkHVyw+IytWyfK2uMElkteH+DX?=
 =?us-ascii?Q?HH4gWzVd00CknM24wnh6f/C+OxrHHYMTisX56VnmrKKbaY1j2Gif3h0mfoXy?=
 =?us-ascii?Q?ZE6rjKj/qugEOqQa2iCKEVbf1X9+88i46Ofh7I/Sb7Duc2+2cWi9bXEFNC1J?=
 =?us-ascii?Q?Jr6hGOIkoPUsv4Mqdbbsmjsua6VKSiS72O1YNwZKnkCOgk+Ko8rYbmUXwtx/?=
 =?us-ascii?Q?xnRoS/YXZVNNjFt+M5OdlaofjuKplcoBXJhAmRblat8IKUn3Cqv8o+QsZRKL?=
 =?us-ascii?Q?7Mf7U6Ur0mApMbPlog+VgQpoQ0VkDHV9gF2O7gO4WHaSFe2EKlrhwBRzIpFQ?=
 =?us-ascii?Q?XiZpUIXLTiWrIK2RRpPUdqA+DvLnKPDmbbzhz1qI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324e1976-0d4f-458a-8e25-08ddc4e190df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 03:25:24.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gOlstfVBooAbrGicqCHCJb7mjNqwqRF4oy73QmwbYLsJjDpr4iFfKzDxi+o2Kqabop47dRIBGVML7imZYtk6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8452
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

Hi Tom,

Please pull mmc-2025-07-16

-----------------------------------------------
Drop unused kona_sdhci driver
Tighten config dependencies and a minor cleanup
-----------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/commit/0f38307dfe0ddca18ed873408e2c5f67873a7aab

Thanks,
Peng

The following changes since commit bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d:

  MAINTAINERS: Update email of Stefan Roese (2025-07-15 11:20:10 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-2025-07-16

for you to fetch changes up to 0f38307dfe0ddca18ed873408e2c5f67873a7aab:

  mmc: Remove unused kona_sdhci driver (2025-07-17 00:24:46 +0800)

----------------------------------------------------------------
Andrew Goodbody (1):
      mmc: Take cleanup path to free memory on error exit

Tom Rini (2):
      mmc: Tighten some mmc driver dependencies
      mmc: Remove unused kona_sdhci driver

 drivers/mmc/Kconfig      |  26 +++++++++--------------
 drivers/mmc/Makefile     |   1 -
 drivers/mmc/kona_sdhci.c | 132 --------------------------------------------------------------------------------------------------------------------
 drivers/mmc/mmc.c        |   6 ++++--
 4 files changed, 14 insertions(+), 151 deletions(-)
 delete mode 100644 drivers/mmc/kona_sdhci.c
