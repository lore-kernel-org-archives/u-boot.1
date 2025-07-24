Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BDDC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1ED835B0;
	Thu, 24 Jul 2025 04:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="paBWxALa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48255835B3; Thu, 24 Jul 2025 04:02:59 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B9983287
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTyLA8hrVJL67jc1L9qkX6Awb8j+J1tv3nu9QY74h99ajwe3J81DSq/QXp8UpFrdE6c/pI+2HHsC63k7mlkWAdCsazmYe7qzFLj6aDoS+S5r4Nk7obmeoumfOFw1BtYk6nAiyjwavdRepbPGtBKun21v9/2ruUNgWTWmf1inhooNNNe6rfbqyK6Q7QxWM7550DLFGzKBZEnpV665TPeNKGLCI+T+T9QFOichKjaBuWjmDD6zEEBMbDuShB2nsXFw0fD6QFncdtC7qSDtcNFBKIE9NakkmZKWzpDLe2cc7iskmQmG1S+oguuifXwslNsUeHXdbFfbDkVgJjXy4vtBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpPbnEs23mbB8+JFpEpo8DQw3ONFemcxCEvO685gQBE=;
 b=H6CfX+5W9A/wwX9GL93KC/Fi7MjZmHUuTRF/7JMOWxVbf1325y1QgAkc7qblmP5d2Uh1+qCLaGqzDQ4cf8ByJkWgPCWvsUJDLPTCAzndY7RjKBMPwukV5lPHkdLz0kpYnQ1qpoTCCb+6Hb/V8b6w25jFqmq75GRLA/RGHp3sH49mL/B8cVadjTuuJOK+PsOxX++0NntH4DncfurLVXRC40m+lXlZc06GaT4gXaBXOWLv6yFFYI/hhOtAjYm+6q1/11njbnOg6M4auTzCqo2GhWmtyt74zKU4yStpCGrrmCg3lpRI022w+DsnNOOwZ18iDtbuQrbYmjoV8BcGRAkmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpPbnEs23mbB8+JFpEpo8DQw3ONFemcxCEvO685gQBE=;
 b=paBWxALaBZNH3hyFh2/paoQf1MQVSkMi7SiuKrPfGTiSMOeOZO/SrquLiO9RP7aaWbsDyInOHjVKj6ETJnpqZRSqEm2ji58rEhcLVwH9t9R0ndFRm8TMCk9TyMMtHO61D9hnr/iWJT01ne+qCam5gShLwjADOYQhKjn3XDMY5UhIZCjbT0A6IoKMmDac7VSHZh2QIVe3rek5D6rDDKUJHdJRFyK2/mTp+kb6vF6TNqzRAl3VJ8JSqXOy2+9Rmp/b3XudBWihzw3Gp/ULdZO7pUFZUMD4f6SmI3N921CLIcQffIjwBCtmmKVyaNylRFgDkg+x0mE9JQu7xZSqEAd0pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:02:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:02:55 +0000
Date: Thu, 24 Jul 2025 11:13:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] imx93_evk: Fix the board name in MAINTAINERS title
Message-ID: <20250724031323.GA18395@nxa18884-linux.ap.freescale.net>
References: <20250723134557.1972331-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723134557.1972331-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc02036-5fbf-4c07-2bd2-08ddca56344b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XUYwLnmvt38fbuDUcfozIod8k1/DAw3nNgw92ur6IvuPvHCZRcgUv44+8h1D?=
 =?us-ascii?Q?nm6kldNRiz3nIPYhzw7IxqfxGpYvE3JUnEcg7hs/Sm56udMZ2ncHxuQts5rd?=
 =?us-ascii?Q?Ub+LvDPTNmRJdywhaLQ9cn1vKNXtx57yiZdrT2xxnwqGhWTOR+GPMeSVcI17?=
 =?us-ascii?Q?3oH84zW+ICz2I78x/w5Ec8AULqvQcG47LOPBs6HrWowreGRf8s5JfEmJ9Rmc?=
 =?us-ascii?Q?C5+jdCuPQISDsJGm8l3Em37qFYSum5Hcgb7RaILm4IwE0MXaWjAM8MhfQCja?=
 =?us-ascii?Q?rWemcnl2qPdYvoISCZZpHNsLS2TfocBTcBrlzX5zweNbxRebe4VG0zo2vGSO?=
 =?us-ascii?Q?8mYfgHV0HZzAkCJhOxNgwz0Hj7OroIVIbdo/vGVwe0zGqlb9Xv9dotCT4xb7?=
 =?us-ascii?Q?sQxduMi7oDX7mgSuq5y+Rko3V4WUTEhBt205iq2JA7xMK6M362pCbwtXCtVR?=
 =?us-ascii?Q?DATgzb/2YdY42RJFDjvUIbfuddOG9vNzJytPrm+P6mD++Xum9K6B6F1cMuvh?=
 =?us-ascii?Q?TratP6zoXio3vBryb/3tiuUH9hQRpEavKyDoNRgvTcoy/2kZj54ka+hrQgf6?=
 =?us-ascii?Q?cpLwwgrrb/0xcnVGPX4+Q3UOrs6Fb7+d6pOyk4voM33v/6MHPSArDUQiq84o?=
 =?us-ascii?Q?uJTZ/8pVppLFVJqQPvVnaBTv2WQTZo/yaxNiwS9Np/86OwgZR7kxCqmnVnuO?=
 =?us-ascii?Q?nbFCjce0ynA++YxvMg96FP+ssWLSExAjFnYX/o5gOM8hbebBniibqUfxhEsh?=
 =?us-ascii?Q?CYt/7pf9ezO3mB1uARkNOwAoZrcOmie6GZQf9n/11sW0WzAcnTWWD5NTTimK?=
 =?us-ascii?Q?8DjiY7wyXSxpguA3XsGeP/f4IJ+oNsfcltSnotDUbXW9q/t1tcH9HTYAv514?=
 =?us-ascii?Q?bHdL408b2TKIgBspx2/P8q8HD5gc1nfRPx6BhSHWm5mSt+swjF0W75sfuIVz?=
 =?us-ascii?Q?YnOI66p6CwufxZSC1CgWqWl/FK4LppqM0oY5AVDZsHZ2GV3yJfWgW6MDYfrg?=
 =?us-ascii?Q?/9kZtgccFt8e9wSkHfYV/sE7jZfmWlBH4ZmCFx24KAUktQmvsUzVZ7N3RLsL?=
 =?us-ascii?Q?vDm4Df5h1qolslCNX4+1+KRKdpgJDtC7rWpHLeC6nz4i7Y+7au6r4G3T5ZC+?=
 =?us-ascii?Q?2wvWQrsKGsCNSLStGJTnZ3Dr7NZMv4971apeENAJydsS2Ci30R9nSB5FUCAx?=
 =?us-ascii?Q?+CW+NaE32WA5GPmYQPyOjX8hGR2fZNZeEonmLSG+s+Ru2vb/roQLjHvA7Oql?=
 =?us-ascii?Q?ucaLrP6aizhLGgO1yk/aoSF2QK7FYokHQ5POp9R5gKvNd5W4dKvyZ/5Dawk4?=
 =?us-ascii?Q?t3X4Cz9MXvMHRsualGOrYSuZ8XZtSOonXNzvYx1FObI7ZDsvg1o7Ii4SG8hq?=
 =?us-ascii?Q?REcSV0I+dcg0nL2dJGheeYqaxbRMzAWRt6eBA2MOQXUCBU6HliXAYgJOwIBU?=
 =?us-ascii?Q?6AT+zP+zbZNfIkBkAOi4uxvPi+tjQqfHossbaAOYDfOAPAUausG1hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xOONUM3RGFrOl/YPm9CLVHeilUcq2PI6AKMs2g496PBe3AcZTI6pS3T+Psz?=
 =?us-ascii?Q?gio8K2mTrRTXQ4LGcLyOo5pshXeQVcbcAkGDlAKJewy9o8fYTBioCu8cQl5v?=
 =?us-ascii?Q?KPSRkb3vkR9ov+MFIU8D34Z1py/Pe9e8CMEDLS8m3FddoYMG4zW+d8t/It62?=
 =?us-ascii?Q?YzCRFHBBS4+T6wNgoajdEFtd3BzZGosnfxl4+TqliRdn9wy15oMEbEhoNN+K?=
 =?us-ascii?Q?aFH29YNR8vUv42DF65BWPHdiYPWFSEpO2OA826AYZZekbrO8r3ofzR3ZYaue?=
 =?us-ascii?Q?Hh9OaB+33vAobEVWrQnp8yCs3eB5gHPWl9kuqM2p/b9Lo/41Kl6M3MeWPwqz?=
 =?us-ascii?Q?eYj1EVnRaqmljLyQ56EoEhgfm0svHT/tKQat58mhGGqem3g5CUnrjslv3NzG?=
 =?us-ascii?Q?ZxpF71EbwavoSITjwHKspskieUofwHrm1DlUCiwGaSAgkk4T/xRtEvqDmNaZ?=
 =?us-ascii?Q?U9Q3ewwpALAnYoX0k1J2a/z/6I94lLm5DrSBFh1sQQJU0glgoF07xlimjNeu?=
 =?us-ascii?Q?fBFPRffR3scuNtZqw+OLq2GZTzIosmysCHxNMa6h1pyFUPaJuRrCmvgq6HtA?=
 =?us-ascii?Q?PpKPfaw03OUp3dEsW6JfxH/q3pvEGJyaDuKIKQfL0fvZpH07n1jg9kPQ4EKs?=
 =?us-ascii?Q?Z3/IetUcOyq1L1Rhu2yBPP5gcmGeU4Bd/VLSof4wS1CIAnjRobRSDcO6A5gW?=
 =?us-ascii?Q?FiPBAcjBM4MSPtkUhn49q9Yb+wq3cM1D3Bxn8COhM2TJ3TEjMboQ/G2TtLMb?=
 =?us-ascii?Q?UF/oXAVKwnMNrpWOOJyhu2wLD/7Ah6V6V2ECvAEbVxqGWI+yAx05JZXa1lW7?=
 =?us-ascii?Q?gFK8J9PKnNo3QCu6bPS4WHDAsj46o4sS9hHZPElur3yRtWDdJs/jZTHiqqE2?=
 =?us-ascii?Q?sJNG8q49cpeUm96Y4RR2mvIIeXPdx7EICKKEUH441DkrTLoqEkJXoEfO7egx?=
 =?us-ascii?Q?EJ8JrLcbqVJyxBfhScwzo7UGEvF9oBH75ek0qScaE3P9yPCUcsiPCA+/Lg+m?=
 =?us-ascii?Q?OS2kswPyIjTBSDSiRRhCIfrvjqbKGaDdqqbRs42o7qYkpySeAXrGCVf6S1iI?=
 =?us-ascii?Q?Jd2hSbtcWwtjw6hAkhADiq0NqxVO7F9Fu4nM6QQ+BzRIWFiH9j4vr07gFo9c?=
 =?us-ascii?Q?FV0lm8vHHaueeIkZR8N8GafiA6n2vZn1gkuBulBV0KOiQJBpIUO25FbAqeKw?=
 =?us-ascii?Q?5EDJchfRcAK0158ZFFUuv+S9x4QHEOTrDswmpMMlboI/416mIMvKJ0zX31nO?=
 =?us-ascii?Q?2m/lmnqFoFmvOytnyj5NGfk/DstFXB+zd++dDSEkP4KaSeDkWY7GMW4PWruW?=
 =?us-ascii?Q?IbyF88CSphsT1z8pOrFfbnxzM2j4Gzw5BUEMiUWCOQzaNqwCmywJzbplx5e8?=
 =?us-ascii?Q?JnMtdCEh8iN33ru2G+6xTs07aPROHqG99ENA+hTMiBJhX6Y5wQe/9550ZDeM?=
 =?us-ascii?Q?LJ/jUM2ZJoh3DJSOyEMNPQDaV/HFSTzHmFR5vbBlvS4fvqOQRL+Nbceg98Yd?=
 =?us-ascii?Q?5M4s2LcQxrgqmsgKRTdikcwkMtkCRw6CIqliziNv8sEA4nLKedMOdx2lPnyi?=
 =?us-ascii?Q?YdYBpnRgVplP3tEap5fpeeRRcaROXIkhgS7WDAIR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc02036-5fbf-4c07-2bd2-08ddca56344b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:02:55.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q2mqD0Yrd06PlUSj6h4kx+xG39NKfSEJ2VUHd4E7zbCPc8dEWypiy8JV1FMg7cf617g+MUXct8oCG2vH2zflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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

On Wed, Jul 23, 2025 at 10:45:55AM -0300, Fabio Estevam wrote:
>The board name is "i.MX93 EVK", not "MEK".
>
>Fix it accordingly.
>
>Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
