Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D72D41C39
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB73D83CB5;
	Thu, 11 Dec 2025 14:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hvR0OYhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193DC83CB5; Thu, 11 Dec 2025 12:47:52 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035DB83BFE
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+PXuAYoVe9dsLtUrsbLg8iYQsJ8snOBcaY2q3vyhuQGTSGsWAYtrbTWx3s1ufMC4SGG0fcDksj8iMQHy/0b8Hjee89A5Zcxt+T4+eTsTg0Niczn6Jiz/Avn8pBiOxN3K+BYfwBehM4xqjB4FLPNQhDkYTlS9GDYeFCY+lqTtE7QAVHFpq63e6j3GJUb5cLGtQSsOlWaCu4ViQe4lH+22QW29XmizoLG3uH+TSwFrTkBVo9sLb8Eo5gJOKIj32hedLdXAn+ia9Jx319DQtwvwTg5FQ6paCvGGs3T+/aHPQpJAqlgWbaYksLIwI/54pqowkUHh/FXynTOYLnY7BT3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4jZGsdbI3dYcU09QatlSygrQbkgZAj1Pl8yvEQ78Bo=;
 b=M0WEa4oMgow0hyWlTcwk5T+UwJJJCLsRIrPFfjtBl7jQIqsEsoKcCWoCetODcdZxtyII9g0EHD0ENcJgaaEYPM8rt0CC/z+bDJyMKz8m5QvWykWb7wGShEBuTYoH1VyzMMWpl9LNop5PYHnzXvl3OdxZw974bbdBY2J8fdd2AySIVnHSyDg0gUKMxFeQtBZnMsC83PcE7C0Hn8dfA7rdNdFsp7U8gUUjHoU7LECGt0sO30vgSDwmWrDgfmo9opIernpp4ySgEBn7Cst2v019/GIbYsTb4T9uLeU+/cFRijwOU4fN6GHcsqMPx4fx78L6IaDFhL0t0ClVXOAcScnBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4jZGsdbI3dYcU09QatlSygrQbkgZAj1Pl8yvEQ78Bo=;
 b=hvR0OYhVNMkZUdsTqeyz9N5aocrWkjXcn3k6v069ZwDVUm+7vB7iBrMFXdd9cg/fFcEj1asYyhHTXmOypIrQn/iXy9aw7+fC1ZEJ5AmkpwyL8+qxrntWNuoxSxz6XnYq93euI97nL4xrXBbjGIT+kSQWm0F0+vY9wkLQSuE6g1nuZqy8Qfo1+byxq1Ghgbtv7Odwh9RrFlJW0wavYsU9fTvJq/zfpeIza7i8VDndlt4wlOGLcwIV4eFXpvuXmT0lS9xz9N23gZzn5S9uiqsgdm+PGrkdYOxGLeDl7lANefCFQ+ULx+pRWmSHnIEnFS/WRGSozFWP7jfMR65JR7nqKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9889.eurprd04.prod.outlook.com (2603:10a6:10:4ef::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 11:47:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 11:47:42 +0000
Date: Thu, 11 Dec 2025 21:01:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [GIT PULL] Please pull mmc-next-2025-12-11 for next
Message-ID: <aTrAm8B3VY97yrYp@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb2844c-ea04-4c63-725f-08de38ab180f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OxKjklwDFsFL3DZ+gVHos7XJNfaUu9wsB26NZmlcckieP02u0ZUFdVKr7r28?=
 =?us-ascii?Q?4P5fwSQj8fy1+mzfvamc0DhHGDFSzZhaSw3Kiop04HbaMe+1d8W/jfJnX7Vq?=
 =?us-ascii?Q?unIEUvKL8vmWBZLeorXWttmOqx7/HEOE1/eEEUs9qEd6FfM1ep4TipeXiobk?=
 =?us-ascii?Q?50IVebM776OcvW91uZE+CYFyi4ld5en+ioYPW4HPdiDqnB22Yl2+E5pfOwjk?=
 =?us-ascii?Q?opz0v4G014h4/eEcT90c8H8gcL3K8A90F4/3NU+kfy7VPgPV0JxzG5HWHacr?=
 =?us-ascii?Q?me2KLi9kqRIUB6lOKK07lJMG0BIv8fLpKyKPWfeQj55jnKsWUykGn39m4FyM?=
 =?us-ascii?Q?MSUCYNQs1zIJYDGIQFTS22BpG92YMkoll53Df7PE4D9lwTNff3hEscW0f0MQ?=
 =?us-ascii?Q?YvRunjljaCusHJVGO3bwXix5nftRhTv6y9vdUsdE0tA4QLunFw3dUUrLyD1Y?=
 =?us-ascii?Q?W6Dg9y5VTZsOSgqEwLCwQBspi28q6KdIk9EBEPX6ZuWIazi23EVSW5jZb3Wl?=
 =?us-ascii?Q?zSXt+5oNR35+Yr+HtsTWZr7WOfT++cgTORTG6u/DTFqJ2S7hdlwSTyOpTOS8?=
 =?us-ascii?Q?3UXPEUvvNXzm2Nz9v04tLdEAur1i6d+ctsjOOLjsB+dAOSllAN7ZtvTtA2ky?=
 =?us-ascii?Q?12A020LlFuwGdo9rL0cnvyEzYOJ4H9X3ZwAfFNUCOSDOHIuc4pZjYD2vtlhb?=
 =?us-ascii?Q?YhOIRcM1DHpZbjT5jmjw+4fbT3BlGwSHPHsR7AqN6ZD6trLiiQLfgaoCXS4o?=
 =?us-ascii?Q?qlPJT/6s03F7u8wLQA9VlycIVIyCKdUbFHZaFQ0iF8XSiLvzIBU8F9y1OfI1?=
 =?us-ascii?Q?GNCeiB2hVIMQTy58GU9aigHYfeq48zp4tunp880okROleLxqUdb6gYjBo6rW?=
 =?us-ascii?Q?5u0DMHDzz3RgWOhV3khp9C1rQRGl/MH+l1uPqeZKHwx9KR06N4Q+U3ZoE7xJ?=
 =?us-ascii?Q?6W1E6uf9PO0xA4otHNcFreHfpK8JqYfJiiqiMtxyH1EL7X5fWoRbU9ZUVMVN?=
 =?us-ascii?Q?Ju66h5X+wtdTBTzWQF+R8eBF6tEpte7kQJ0lAh74DZn1/5tsDhz3Gb6oCGPb?=
 =?us-ascii?Q?a7R0yd1/O7jDu90QoHcBQV+ebUEV6/m8jjOvZWPk3kmmNBM0Xo8MF6WgZntA?=
 =?us-ascii?Q?FrTjqzNvS4FLyBSI6870yDmXmiiSWycP7lWwKGUVKZogF3Q2a4Qln9tlN2nE?=
 =?us-ascii?Q?TdAnu5GAewxFt6uLWU8aoUjnrvMXjxHCKmj1jayc+qpGvDYdOgpm8Jk9Ndnb?=
 =?us-ascii?Q?GVe4uz7xnOfijIbq8m0MJCD6ZbiJ2DV0fRDNKRzhpkvzlHs4NtAUFoX49SEy?=
 =?us-ascii?Q?RWhvYkhPTF1+IZwE1QlIU75Lcr5bacD4/rs0jGyzOPe7tv3LeQtUl8EdX1Xw?=
 =?us-ascii?Q?pcuWkXnLdJz02Z70J+qaVGZcUjLigJ2agGch3W1dt/7EDSpgR6Uvt+YpDHd2?=
 =?us-ascii?Q?6U69+wxsuHlKX8LSlCaoDUplrp17E+qYZgnG20Rt/LYH/bFQQNnyO6606AyN?=
 =?us-ascii?Q?TgTbl8DmbUGFRL5N7mefSkGddALHfrOndD/+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2X038ItHSD8oIRyrmLPoxqqsXJ/X8ubgzRNOd3hfXganJHuAiwzQw061h2XX?=
 =?us-ascii?Q?1TmizvAxday9PH9mrMw1f+bHqWIXFUejEUXPGwiOIaiNDoeBJlZtu4ItB6GM?=
 =?us-ascii?Q?lsmeCovI/vZ9TVlI90rySSqGdGYCmOtMaYJHjqURZMsMr13ItH/Gd4pHMl8L?=
 =?us-ascii?Q?cEC6C08Vk2VhXOH52CQcjjrF47jihaGbyzFjbL+h8iRzqhzKCvViCqJZKoaq?=
 =?us-ascii?Q?yGQjg/N0NzFEd6PKxslv2FCzGKIBybyDZ2ND7eT0PqjyBVewTIYMrI8koVhv?=
 =?us-ascii?Q?6CvtuES6dkGamGYeCRXlo03NC162NkMgnSWdiiz58nLxYLFu94/ip+zeWpJw?=
 =?us-ascii?Q?JaqAb+YeEEOHFp37mQ1aHgG2EOGgmQDpAKAXLsCz+0QngUW9xqbf79AHN075?=
 =?us-ascii?Q?wHKLhjphplpvKy5N+TZZ85cH+NlNsHNHYScFKZ2EACeK1S43C/JCdqA0g3sl?=
 =?us-ascii?Q?4wAtvosS3pqL7PDqtnP0OCM4e2E6XdqGCRYzNTOYvXWRKcupINi6T1ZF0+nU?=
 =?us-ascii?Q?5k01kpC6nEn4F5KS3PTK+avqJugFzet6WobkZYPTjJlJg9sJQknr+RRp3Isw?=
 =?us-ascii?Q?ohhjSL2eLSi/3/NLLWnmqu5p77o9CvKHa9jDJU9LFOxmVJ6K8ef2M18leVll?=
 =?us-ascii?Q?Y56Mdan4+0UK4cj3//46FE+N3PhFJlu054wHvpcHYY0F4izJREfE+OhlL3IC?=
 =?us-ascii?Q?Kl9TpyJ6XxoQCXVvzWc41ZT/AnRj87peSY0xn86vSNgCcwv2VqEndX1phIDL?=
 =?us-ascii?Q?KEA+zKSTzzDc3JbuRBogwqUTT47My+EUQEGE+OadvFBkFD3mfAidM8a5uBwO?=
 =?us-ascii?Q?klBYKESsp3PDKOyRZfGuNTQ8wtbpLaMk3m5wZ2OEAyq6flmtSOJwwxoA2yDz?=
 =?us-ascii?Q?Kf0TOAgB34t5f2pm+UrRcSCz67XZ1sv4IVJ6Vnq7Z5blaQQv5udbbkMidS9R?=
 =?us-ascii?Q?JNY7P5tGPJBzb7YWeITU93BHoX/+D95+pQ/T2kYEoeZ0lQLMayRt58Qrd1t9?=
 =?us-ascii?Q?xZ8OXtitaq2t5378Pldx24gDcDG5SJCg2sHwPZNxNy5r06WWVPPqQEONqQBS?=
 =?us-ascii?Q?rOheR4h0U0MJXe545hOGSktXcuKNunJhKVp7p8E44g/43th67myvSj9VXfdo?=
 =?us-ascii?Q?aooJO5wJqLmUflTmdkIeqOOPS2uF1tJgDKLzTSBAFxNd14bmTiGYvW/IZlKP?=
 =?us-ascii?Q?YC2SqO8N1V6Giz/qrfY6A17iHOwH6yddGS9steWXX5Btu2w/+LpHWGiMzGSl?=
 =?us-ascii?Q?5Edw/V69S/O4f10RoSUQIGrDGczx+uIJb1GhiN36radQ3SXXMKFWlr++n0jB?=
 =?us-ascii?Q?Yz8XDTYbi3tGMqAQflZj/Ay2xmejWHXhytVi3WC2hR1A88/NYJd8gcL07YMy?=
 =?us-ascii?Q?yq6Db5PVXsVOAHNTlr0BkaDbrm+rq39goFan8bsP8x2+Tnj8yeElIbXE2FDz?=
 =?us-ascii?Q?q3ZVoBUDSQdeU595jwuHXU3JbYeyv6B6rMUbHxS1i7iP4HV5FuXKXYPWIy1J?=
 =?us-ascii?Q?AKqJFX7Y7IR7F1sLdLZn1FHs3ODnxVRi28dlqq7RsC4OtmIZR0mynunlEjS5?=
 =?us-ascii?Q?QS3Ojr5iahaEkMp60xUMB2rx7mXFYIVKLxmjeL07?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb2844c-ea04-4c63-725f-08de38ab180f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:47:42.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxl9Dtz5rz94rRP8t0RU6mFX8Stmo+IkhGiKFNmDqI0eculCfh0kanhWn/JqMR4KlwxJduCpyKUQePEba2oRRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9889
X-Mailman-Approved-At: Thu, 11 Dec 2025 14:55:31 +0100
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

Please pull mmc-next-2025-12-11 for next

-------------------------------------------------------------
mmc: assign f_max to 0 when max-frequency property not exist
Improvements and minor fixes for Cadence SDHCI driver
------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28729

Thanks,
Peng

The following changes since commit 66be03b7ee19444b23aae3990a434a7470fc1641:

  binman: blob_dtb: improve error message when SPL is not found (2025-12-10 13:45:29 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2025-12-11

for you to fetch changes up to ed0e33cec099e3f9e459cef7f66ff91068e2d71c:

  mmc: sdhci-cadence6: Add DLL master control and improve tuning reliability (2025-12-11 20:53:52 +0800)

----------------------------------------------------------------
Tanmay Kathpalia (9):
      mmc: sdhci-cadence: Add reset control support
      mmc: mmc-uclass: Use max-frequency from device tree with default handling
      mmc: sdhci-cadence: Use max-frequency property from device tree
      mmc: sdhci-cadence: Set controller and PHY speed modes for SD and eMMC cards
      mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version defines
      mmc: sdhci-cadence: Use hardware version field for Cadence SDHCI controller
      mmc: sdhci-cadence: Enable software tuning for both SD and eMMC interfaces
      mmc: sdhci-cadence6: socfpga: Fix DT property naming convention
      mmc: sdhci-cadence6: Add DLL master control and improve tuning reliability

 drivers/mmc/mmc-uclass.c     |  9 +++-
 drivers/mmc/sdhci-cadence.c  | 98 ++++++++++++++++++++++++++++++--------------
 drivers/mmc/sdhci-cadence6.c | 82 ++++++++++++++++++++++++++++--------
 include/sdhci.h              |  3 ++
 4 files changed, 142 insertions(+), 50 deletions(-)
