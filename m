Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05655C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 10:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A9284105;
	Mon,  6 Jul 2026 12:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CLFXaKB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09679846F8; Mon,  6 Jul 2026 12:04:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53B6807C4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 12:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFpfnNzayKl0UEX8/VfUBFU5ql02+lYuJZejQgdURBWPBLsRepQGbNkfmXmq1iZJ0b6VngtJnBCBi4BD3jopFbBvVFFiPL17OpnZ/huVeLJsbbSKgyAwKAJEDSXQn4e8CNiWgTMLGJwuuq+vYBeE2l1/ONMACgTcsSn5v/Na5sxVgCCe+Dx+P9m9RnYStMe03PjYwgIz8iQlbccfJMAjH4egMe8FD9pJP/T0GnSlje37/ds2w7/MpFuv2c8BWiTx76pozJ0Xl4z0jcTm0tdf/+kNrrxTauTG2t947Bk3EAmgCpmUjw+5Kjzi0vBA6+FFj4OgGIbaY+41B8iuOCqhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaVOOvunEtDXkJ1p2CIV3OPD226bk0MWvtYvI9000pw=;
 b=IvpTxGpJNLckDg1VLPInKxbO3cvIGUqVre4+isolSIl2jJdJflISwAiqGpHJdKyJABjhqBZ51fH2VBQYBsNsNlaeaxCmbT37o+hpV6fSvhi+f3a5UCiV+Ii73Tttl39VuRYkL2r2f3ksueBVww8KjKDY75Q/CR/SUuIVsMpt7x0HECzfCIgdiEsEMykLNUiQ3H4HhlHFiL/ocBMMyOluHX4GrVC0G96ddF5YyzyrJl1e2+aUGbJSdz1ECsBfonSk2aY6QRvveoJ5rm5/GNfnnFmINIqSFVigZ2udXXO5+9sfTQaGjXk4amBZ4acV0EuqP4j2HEmpR1Y8rw/rJaGndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaVOOvunEtDXkJ1p2CIV3OPD226bk0MWvtYvI9000pw=;
 b=CLFXaKB7QimXVjWsVsqcvC4CUNkInjURP3HdyTt8X8AHVCU6QkFu71qCobYgSNqhZQyPPzYn57CFlIKD4K5HpR8OlG0fKcV36cvymwCaJ0NdO/D/0RF/CyiVM07ueRHkvFW2nKqWOFURZu89iMxjQyNNGoQEBLLYmbzF5LceOBDj3/Lc4AHp2ync9v96sYozi4qRNaG7XmOdbURQ8jCfe8kAzKvngAKGmp+aLiVhy8v7TnUtxIcu3tDwhVXbVEQqLFv4ELXYMCl7WvIolEYWK31qJC4nYEcI22Hx1OHouuStGIdj4GsJh1EixwrDv7wySFervWs81qTBo4cJp/KRYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7676.eurprd04.prod.outlook.com (2603:10a6:10:20e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 10:04:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 10:04:47 +0000
Date: Mon, 6 Jul 2026 18:03:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, tanmay.kathpalia@altera.com
Subject: [GIT PULL] Please pull mmc-for-2026.07
Message-ID: <akt9dcQaHAocUuqA@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5bff35-8ac6-498a-5747-08dedb4602fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|19092799006|376014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 5pkmtfJ0OuTcfdIwHQetDNFGEAJVkzg21HFjyjcSwMYUmHj3tzL10OEiGjqTNJqTFkrbA1yzDpgY5U+eTaa5kUWOjgC7S02r1dSib/WNnpPCBWtvmzp3L1AKELX4dt4Ky4M/zorSU9Q6PMaJnWSwfLvJrZ4eQpzuZVey5/mLsV0HvHNkGF2C1ztH00X/s6w+hJRrkVPnrcZ4Xo35FQsZZhlmH/M9dOO7rm7ulPUuObuhX0cNWwRQvQqKSm5eXxOgcgFZrc8o+OAbQ5MhZcXwwL9nCj5W3gRKrNuj6z6qrHCtI752PFrbW6wmZ4XAd15g6nbe5Ljik7cyfOwBhShKEA4M0GFuYj2E6ncURloDbhKZEWAuq6jz6FEOQm/Y2s+BjhenyJOXNQOMnM6bMI8dlJgUKoFuwcF83cSWa7a1Fsr0k5b0VR9vIMAowGFOWvfrHMF6HmX8tGuHxPAdqiMTdanNwT/FpJlsOftR2SMirR/b6qFrCSvCK/CjKH2nLmA3/AmaaAsrg3Dmg2u9RDL5gW4M3ChzpPNu++/o6/N1UO52UfsmYp7Pu32sfVBshvdzvXFXZspeHYGUcto2WTSpQ3EcQFJPlbGSD5hIxasEcJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p06nN2E7eRdnN8AQNkjXW57aKUhOc5vYxSR/J9JCroenh6yL7VSZefTGL4DD?=
 =?us-ascii?Q?D+d5hnR89BoXkDU1FxeGTn1hesyAQiEgBbxz4Pn43XJ5SO12Z7KaYLodXthT?=
 =?us-ascii?Q?Ki/HQXh04+xgNh9pnWjJhr3wHL7R3nBLcKupqV4tiWmRwGLhEgniOs92Nyr9?=
 =?us-ascii?Q?CXuFVVfKCVvG9dXfNR8tFbzwF8eW1Acvc2FtTnStO73W+XwqlpTrkmCUq6us?=
 =?us-ascii?Q?el1iJ6cwe3MCdEa15lcYPjShEXS+U/AzbPsS75xipuh4LKGPi/FeARwj74by?=
 =?us-ascii?Q?3XsbWWdBhU5696wtFgik+h0wfYshQBsImMyu94tmqPA0lcncpLKRWoLcAZk4?=
 =?us-ascii?Q?rrdszlY3CTlnIqtON3Pc5igsgmhmXDA2ie8w2hGVBzaF3fa22s+60HS0tzeC?=
 =?us-ascii?Q?9d/fOWVwSRfWXlsQ5Nw14i21cA5Te82tOS/4l/TdLc5Tr8DDjF3zAL69qEfM?=
 =?us-ascii?Q?8ssniRzugE6dpdlIDiBX0/J8w12h0rrDQOtevUwHXu1AlTXj4XtXe5TiAxE1?=
 =?us-ascii?Q?4pD8HXbA+CYDYJSEe9GdoEq8YpEfu0/AkPcr2KppxaBKApHRtw1hR9lMrUIb?=
 =?us-ascii?Q?y7srUVI95+BDTfCy8M36pCQmw3KDKpbJWpQgZMV2iSqH1sIRj+BDw7q4apKF?=
 =?us-ascii?Q?46Zk2ZzVBOB2PqzqhkwoZACy4ymVQNWHSb+4AuK3bmNrjqM9vgmFB90aQxyF?=
 =?us-ascii?Q?/Rl7etzt5hhZ+V+6VlJAR8o7H+yA5FXh8zfSXnLymxcxUNSHwmibKpcYVj7r?=
 =?us-ascii?Q?q7vnXdZbvjo8zyT6Bwo2jcvFc/ligYGXaIOdevB1OuYVlTAp+CfNUjsTwavU?=
 =?us-ascii?Q?yS9hGj1eofkZVP3XOqW2En7ftr3QD7RyU1YuERKi+aixE8m01fD51AoUO7nB?=
 =?us-ascii?Q?Or5uFO+bEZTXfWAhCAQHUXDDIpISSrZyZih8WFB74aazqr1AAUSfTYTrQyDR?=
 =?us-ascii?Q?aNYH3IcIQQBogmokn53PNIYRmgMmNOovDFbp3zpECxsRC1ornzKsFRSkXRdT?=
 =?us-ascii?Q?0TCXV9VbcNdHdhhmGPOQV0eA8R2qkgEmyqMtu9PMyA88OGc7GPKtx8FgmWnp?=
 =?us-ascii?Q?UZkwu0mPxU8y4PgUYLKtPNCYBp7VdenImz1eSnLL+EfwCMNDpatSEV4zSyW4?=
 =?us-ascii?Q?di9u4I4IlVKfU/3dyjoNoi14zNUzLC98h9z6sowEvchCc8iwv/5sMIEE21fb?=
 =?us-ascii?Q?iGHZgMZF9bU52J0j+YZlNl4YZQ6xSYqw1O0VDfI0NFlSJrCr+1ueZ+0oN4L/?=
 =?us-ascii?Q?L+fH31K/IyKQ4ERcrWwZCVUxfcTY3My4eCRdPQ8ZPSOPqQCRD4y4iiMxOca5?=
 =?us-ascii?Q?DSUcePK+YU0Rjv3KFGrrnG+uHa9B/Qa5Q/36wBDkdwVt90kRxreU6uMtIU9X?=
 =?us-ascii?Q?R8505wqp8QyGU2BKhSR1BhCYyDHVFhJDySKxmu380FeD5R/NUkh1GDVUWoW5?=
 =?us-ascii?Q?4KvaDZ9DEvE8+O5q282osIrKfe6wmoQlFaO6Bm60nCIIH4A0IGNQNyOzrOG0?=
 =?us-ascii?Q?4bB/2IhStmJ9mSLOg/9aj/GmUSGilhH8+BhB0eKOBHocwAn12qdErS/uXQOw?=
 =?us-ascii?Q?6TsEhy+rVOYbE0ApasojZ+5svRGvQw4gzWrRt3N5mHRl074gvXQAR7+GJMkS?=
 =?us-ascii?Q?h6ayeXHD8YDJKDbRRh1q4kzTUynyAFk9pN5I+5jxzhch8OQEcpABFHXRl+d9?=
 =?us-ascii?Q?4cEXhINl7GnCHaGOMTggtUAK0KlO1uscHj7nqaryOuvE3J5N9T16KlQqRWqf?=
 =?us-ascii?Q?eKq+X+zb2pMGMXuj6m9ZGHGDksGN1m7jxdUxApaiGE5lJQH/OrrR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5bff35-8ac6-498a-5747-08dedb4602fe
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:04:47.8817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yTxs1I0rgOpULrCzWQcEULEiFVjIOZIuam+wesBtAxPpw852sutkCB1jz0l8xrGUUleZHrM0h4yOSG1PG6Pi+iyXAzyrODpWGdQFnQlw47zoAoqov7D5IWZyOEcHdLK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7676
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

Please pull mmc-for-2026.07.

----------------------------------------------------------------------------
Fix redundant 1.8V voltage switch on cold boot with UHS card
Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode on SD6HC (v6) PHY"
----------------------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/30621

Thanks,
Peng

The following changes since commit 780084d7c07f511da4a39b43277c573156ed42e0:

  MAINTAINERS: Add entry for ARM (2026-07-03 14:42:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.07

for you to fetch changes up to 3e0208cc64966b2a5049b3b3c6d64c05a018698f:

  Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode on SD6HC (v6) PHY" (2026-07-06 14:06:27 +0800)

----------------------------------------------------------------
Tanmay Kathpalia (2):
      mmc: sd: fix redundant 1.8V voltage switch on cold boot with UHS card
      Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode on SD6HC (v6) PHY"

 drivers/mmc/mmc.c            |   7 +--
 drivers/mmc/sdhci-cadence.c  | 108 +------------------------------------------
 drivers/mmc/sdhci-cadence.h  |   5 --
 drivers/mmc/sdhci-cadence6.c |  45 +-----------------
 4 files changed, 6 insertions(+), 159 deletions(-)
