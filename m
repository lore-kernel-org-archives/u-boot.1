Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A19CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 13:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C19683EF9;
	Wed,  3 Jun 2026 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UnHLLo+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571C384857; Wed,  3 Jun 2026 15:21:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BE1839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vvjfr7jGj4BK6PaKCVgulHBmSzd7ZV8wYUEY7f4Puc8cQgyuhyJeOwlk24Tlno18zygxsu8l3tulN8uSvrDdlnbfNCK0v5g5FjZr2zPMvJpHjrm6NGuIrJYIjlF5/rix7wJIApEloEqTBiLLzzlwZRHgzqLrlrs4+11Hqs3jBwUCsUbx5TWU22ua7FL9tg4aCAWdGo+TJudfJu3+TUpOXZBJNJ11baO1ZBkPLcS2qvERfB88FZvRARHxns1g1J4vqtfkpnJUs9KGQ94+JkHbqvhdJowas2QNWaJdOS8yAqMrkM0klf8+fTiobpx9DYxGiVvgvTG/+ceMswX7CTXMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAShLlEmmkXzmII8a/0ioLDmXLTjt3dt9OSQ15cgQ+c=;
 b=knVfG4LolxcgxBOQB7EJKIDARmbahDw0S/GGEX0v4ZnuFYc98f0jqTRWOtJ+niMGAj9Z1808paIFWRepzSkTcsBZt6/UPsvAYeBVlXQZuMj1RLW5Z5cct3wZ25aj/jR4G2NCmxTnBK/oJNX5iB4BS2XiY8P7MIO0HD16JYtAeEBOw2+qAtC6hu7isqxRRlv8QHaTw7QzcVDfgDEMLPQ+Ri52UjdhKGg8UX7SWSpRSRY9uAkY10oedxW8LmYBu/e+TAkwf9ytIkyYb0jtwI2pjz2pRvesCjmDGsdQnHjZppHXO/ort0nI+Y0+JEaKu8V/uk3LZlVUWdyNniWxTWi72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAShLlEmmkXzmII8a/0ioLDmXLTjt3dt9OSQ15cgQ+c=;
 b=UnHLLo+gVnFtSocMnjTm2HKENj1JAkDwYUPBwyS/uPsGklPHdfr09WRJlSBGVGJgDwhW433gLX7QEcDAosTxoAlnN6z8ZZn0SV4mLEcGfWZE2A+0JNt2uHdbkNl4bgOchb0qM6rITAGPJ1Ec64/pIbhXv0KTtt7DoPq9dLMhD7okQE/PRy9Yf2vBbf6sctD4gvaj8EGD7WghA/+vCtEyI0AzDKSGfexIJoiDHoTWdO1JJFrELHv0e9ZyWyuiVrm8gRQYOxCBomdGLQD3TNaYatbOeluyuz0XyLnTU+aWV4786q2wperi+km9mfvNRDc3rFWLfbEnf6946yJ4MG+9hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by FRWPR04MB11245.eurprd04.prod.outlook.com (2603:10a6:d10:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:21:27 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:21:27 +0000
Date: Wed, 3 Jun 2026 16:31:57 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, fedor.ross@ifm.com, 
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, 
 qijian.guo@nxp.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <doqobuvsxnnhfyey4ly72shhxue3g5pnqfybc4k6jaiawld3rg@rb7srjxsb5i2>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
 <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
 <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
 <9e3611ff-55f0-4a04-864a-935e6c7a3623@nabladev.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e3611ff-55f0-4a04-864a-935e6c7a3623@nabladev.com>
X-ClientProxiedBy: AM9P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::9) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|FRWPR04MB11245:EE_
X-MS-Office365-Filtering-Correlation-Id: a550b655-9c40-4992-fb6f-08dec1730411
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: QU9ijN7CQF6lw04bvwgRE4G43cS/i657pdn5L3RjP49JC9Et1tNreiMnKbiIM2d+U8HbUmBnXdz08ILOLDZsN4maBq2qo9VPEyb9dNz3NYPZYZmEtsdR6Xf86yHTrdny9RJ9TsIwh32Hj0KYkRk7Mha89xP8dqzLPlhepRtGS7QjHBcl/xuwnSyUBTglMQG7qHUoqrecZoIGsvaZrkMU8PNmxREruUH5Wzcy3mYEqYkx53YDMyHGY9B8+TQL8rWAD4NUk6FWJ2LIcS9tQQsBafSHuqmoxStBczU8YWyvmzKy9AY803XNhTsOUdf4d08OgCsXpxhbTEg5FtK0uaS1hmiIkw5McU+UlJsh6bgsY12n28wY7RySHCszGzr+va8afmcrltciSurYFflh/RnlAnJCCHzZdxR3Ecq5JLxILOjJaaLbaffoUUn87hJzhEXWvbVQSiW8W4kTa4bXLJkIEqplNoIecF7C+vhCegI1XIzhgnQmGtnTR+hiLcd6snA1Z2zVPd3LGdCkxvVEwIKxLkehXe8n9aQObw8b8wudCf+T+FgWZFCPphAUl8+WDiLEqJipj2JVq3Dx7F7b+tAQRBArKDgxnao6Vwpw3iW9tTU7cWsVK7ECKNl1A+f3FzxdaxmRA0GFMvnS6C5S13r5273khd694c78672akSCOzH1uhyJ4dBbjs4YlEH0hBM7B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5yXpwKU4S9M5ar/8dKV+IHiC9dVx3EF0QQ/zOiYuhS44W1IGd6tyJa9VL2?=
 =?iso-8859-1?Q?PJ9E23Y9mmzDGN6cC5rAJmqRlVXSh7A0em/qxFEmhuSQRh6tRKtdM8auXG?=
 =?iso-8859-1?Q?KKtfYDwFPufjfNfxjkdFXVmqMQ+BH7Zph5XMWhZgH87HPcT2JVtCdMKz5R?=
 =?iso-8859-1?Q?CE64FfgNj2+FVg2+ccmoRyaipGTmlO09FLPog1rxhNcvbcFMSmdxpJqgPo?=
 =?iso-8859-1?Q?DSJ9wMQFlT+vAnFwReDXFanOmSDpLFIWWc+35MPPF487saCahFuj8NlenB?=
 =?iso-8859-1?Q?sDT+294GAgdr0KwaMPiOX9oI9CCLOPt6DLfcywt33BsmiRC+Qseh/i7qje?=
 =?iso-8859-1?Q?XLzgYkJPnb4xdG4J8wk8XdcI1mN1msMaG1t27ltCBZe5E/MzXBlt2/oLUI?=
 =?iso-8859-1?Q?YfRqSTQVKjWsXQDytakKxpcdSfuh5eukPsOy4lyKn1Z4kuNxHgGqXm1KP3?=
 =?iso-8859-1?Q?OMxt9vxIb1v8ttdySFqr+RpbuhA2MQcYD5w18vf63zKtFcYTjPPnk3JMxi?=
 =?iso-8859-1?Q?lB9xeJWA/Cwp/uDP401iwyaKea+x2YpF8ZOf8dKAozAVYo7nANjzmN3gx8?=
 =?iso-8859-1?Q?EfOrgNggYXAacs5qC5rKEBCHHY8za2KkCEPhOLgT/ggewbbniPAfIyXSzK?=
 =?iso-8859-1?Q?tDoRLWSik8Zgad3pgA4WCllgPKCid8tXvi+7mmSw/HbRI5oB295aHJqmgz?=
 =?iso-8859-1?Q?lz9D/mP+5NUXNnTgpnx/5FcnySBxnnrHI6EeNhUivetJu8oLY3dfpJPt0P?=
 =?iso-8859-1?Q?BwuIdKkRVBbAh/CCriS1k+9hwThVhNKkbfEOfG0zUuwRWiZgaEMxtYNOSz?=
 =?iso-8859-1?Q?3np7G/7G2rIRsGEBMxAWv+uL8ejLIzFKrL7lJP8fL51EMDg7ehpv7Ihhww?=
 =?iso-8859-1?Q?jHwoBGai/AXPry7npde+hG9o7g80qlulZPE/bPpFQ6MABliQ7B6+7jaM8e?=
 =?iso-8859-1?Q?7v42m4/vgjxmjTLbx7lX9BkCHFrtdyE2DzPUcCIWjpkI6lB2Fl+xsnLNEc?=
 =?iso-8859-1?Q?IMwvOdxNsGfq7HdgQHxm3Pvmy/R8qgmcMswVHCvvpW3OeY0+JkcYriEGye?=
 =?iso-8859-1?Q?869j+G4BQGTniWuDikrOo1sTGk4N2gLkrqhRtYFcfU50nPIuACYy2RKpOF?=
 =?iso-8859-1?Q?C+iYdXgvUuRik9GKmWC7i1F3szfY6L6hu2PALuH/tQWKT7Y6uZRZI8+0v1?=
 =?iso-8859-1?Q?4UXDLvR00bCZqeA3j84nWHJr1u3b8xgMjY5geyaO8OXzo2G7Svy2W4xTJZ?=
 =?iso-8859-1?Q?RUjUao+LkRVYALDmlB/Bodiu8AGyycTdiNe6xr87Y51q1dd0JALVTKMBhg?=
 =?iso-8859-1?Q?+Dln7+e5XcQ+H0xnGYFzi4OTzrR7VAzT0VJZ98MN/4nHAFVpntHu2ekITG?=
 =?iso-8859-1?Q?la/AEhk4ofRGMBPy1qLjvYfw2JJTJ5rftEKTjRWx2OaJBmOhmtzLDBWs9R?=
 =?iso-8859-1?Q?Kau6TZ2ian8PAylxbdxx8+htiJgt3NmBEXLMemgwlPVcygKAZXVJCyMaQO?=
 =?iso-8859-1?Q?pHREPAehfJLqkxbcw329wDQhh0EySIaCse2FgQm7e1uJgMzZwHhUCzjsM6?=
 =?iso-8859-1?Q?FHFWuhm3IOPwQA+0Y3BNG37gXLiYQvHxEP0IIbTEeNVCrhm06TfiguLkQL?=
 =?iso-8859-1?Q?MBJnLcveetqRSdn+PvDae1pjLCay1S1r7luJvbPWg9y+8BPrbJtwcQM2Ah?=
 =?iso-8859-1?Q?n0+dgAh4vXA9rm0+kVU7QG7yfHUiwW5Reob4OhhpjWxb2jifSPjizic+F+?=
 =?iso-8859-1?Q?6a4RfpJubyo6zJzgB6y2OjuPzkFVcQ/LXPV8z8kzXkSg0A/xiUXl82jh5N?=
 =?iso-8859-1?Q?fJisOai4zg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550b655-9c40-4992-fb6f-08dec1730411
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:21:27.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Vn11EPodvMCoIFr74liOoVeoLimeNtyKmWkExUxyOqgiCdm585IDZwSkU4rndzbbwgzgaxKBkyjD9uXOvdyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11245
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

On Wed, Jun 03, 2026 at 06:57:14AM +0200, Marek Vasut wrote:
> On 6/2/26 4:11 PM, Marek Vasut wrote:
> > On 6/2/26 3:46 PM, Simona Toaca wrote:
> > 
> > Hi,
> > 
[...]
> > > > > +    ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
> > > > Can you please double-check whether "offset" here is always
> > > > aligned to 64
> > > > kiB (SPI NOR erase block size) ? If not, this erase here will fail.
> > > > 
> > > > Thank you
> > > 
> > > The erase size of the SPI NOR should actually be 4kiB.
> > 
> > That does not apply to all devices. I assume to align this data to 64
> > kiB offset, I would need a replacement AHAB container?
> > 
> > > I added
> > > a patch a while back enabling SFDP support, so that the erase size is
> > > parsed correctly and this does not fail. I only enabled it on U-Boot,
> > > but if you are using SPL you should enable it there too.
> > > 
> > > The only reason why I did not enable it for SPL is that there seems
> > > to not be any defconfig for iMX95/943/952 for booting from SPI NOR.
> > > 
> > > Trying 'qb save spi' from eMMC on an iMX943 EVK (with SFDP enabled):
> > > u-boot=> qb save spi
> > > SF: Detected mt35xu512aba with page size 256 Bytes, erase size 4 KiB,
> > > total 64 MiB
> > > u-boot=> echo $?
> > > 0
> > > 
> > > Without SFDP, 'sf probe' reports 128kiB erase size, not 64kiB.
> > > 
> > > I also do not see why I would check if the offset is a multiple of
> > > the erase size, since the erase fails gracefully.
> > My understanding is, that the erase operation should erase the QB data
> > from the SPI NOR, not ignore failure and keep the data there ?
If there is data in SPI NOR it means that a previous write was successful,
thus the erase shouldn't fail (as the write method in qb save also uses erase).
> 
> It seems that on iMX95 B0, the DDR_DUMMY offset is 0x76400 (aligned to 1
> kiB, which is too low):
Yes, this is indeed too low. We align our DDR_DUMMY offset to 0x1000 (4KiB) in
imx-mkimage, I see that here is not the case. At the same time, aligning
it everytime (even for eMMC/SD case) to 64KiB seems overkill.

> 
> This makes the "qb save" work reliably even on SPI NOR, because the erase
> block is aligned to 64 kiB instead of 1 kiB as it was before. Maybe we need
> such an alignment change ?

My suggestion is that we align it with what happens in imx-mkimage
and make ddr_dummy take an additional argument specifying the alignment.
(and leave 4KiB default alignment in the dtsi, which should be fine if
SFDP is used).

If you're ok with this, I will start working on a patch.

[...]

Regards,
Simona
