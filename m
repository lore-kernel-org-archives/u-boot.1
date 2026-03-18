Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9537103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1A284132;
	Wed, 18 Mar 2026 15:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N6PTn+fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C311841A2; Wed, 18 Mar 2026 15:08:55 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7C083E4C
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKJMCjySlH3frWQgGSNW5yu3XCcSxX+Sd044vHpYUbjGWUIputVHn/vD99L9WZyaJMIcagAQygpovfbA4SwnhWnvhnf8e52sKam2uyO0w4N5A/jUmph4Zd/RQHu5/6Wr5ug5OJ5dfK/OiGQNxXyNFLYGnZRTDTAwBvDNvCq+g2aYls6UnGaIQvVSQ3oSuWc76DjykuOvWGBqC5W5RDOEmn2bzXZymf5oGbMgnCsm9BdLhmRvDfddoBB7pvN6x/At2ohmVog1Z80sjFEZdU3Ri3Jw8GK1IVYYQl//N1dajqYo6BGDMmedLaAwE59L95WE82wVJ+J3g82q31UOVky7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WULjl6BsaBTWhp9X6UPGtBgIXsQTbHkQW4xGZSvTUQE=;
 b=KGvmorZmojMvVBbxiOW8VpQG4dC4XRKqEj7FNExYKgCC9oZB1CsZVsOSFjB6TsCSqFoWj/RwFHAqkDQ8UxRA6AjcCr18LPNOrluKjyVivTfaHp9rT8PguMZcCdt9mJKCt1uZf67XZurElM8KmxLsv6gyR8bb8AbP5ycakCU6uXpqMN43pYNhIOYokXsiJEWf/mmbU35EtX3cWMY70Mj3H1/kARDYVbvIre7tgEa7BBA1znxIu0yOxCLdWxjvrSxyB9TrDU49ZCORgkpjVZ9VDIPgewUIDdr1LUqP3f3e8UHq5EgBEjpmd5t442c+ZILxy8JSRaUnzgE5XWd2v8xigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WULjl6BsaBTWhp9X6UPGtBgIXsQTbHkQW4xGZSvTUQE=;
 b=N6PTn+fvp/jCwgauKmNZwrrJ9OX2kglY7/0Kd/zzsQbDaVN7bJNjEKgBDyulV1TYiQeXY7iaKftFOJmCyUmAhuAfhOMNVIJOlIGXOZSdQ9ml/YFJsPXUhcK8JUafbh4o6pr/+29JU4uCXF9bxTLCc8eC8mNpJ0o5C+8Nvvt7y+6Iok79U4MgKSHpy+K+wzavQ6ZhoF5/cMVT+tFCV+hJ8NBdVfT03LDp7ajlTNupTYKRYDi7mhntw07ktzxkPKFAmLb+rrkR/gRtH5eweWg9AQf0T5396BCM5Z+T6ruIyHvg2GK6pHyQzwFDYtxif9nhk0SHErvtVPtiWW6VXbMrDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:08:48 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:08:47 +0000
Date: Wed, 18 Mar 2026 16:20:38 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 simona.toaca@nxp.com, ye.li@nxp.com, viorel.suman@nxp.com, ping.bai@nxp.com, 
 sebastien.szymanski@armadeus.com, ravi@prevas.dk, joao.goncalves@toradex.com,
 ji.luo@nxp.com, tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
Message-ID: <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
 <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
X-ClientProxiedBy: FR2P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b032d4d-b9b7-446a-8284-08de84f7df07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rwJF0bjJ7YFoz+XjJ2YBi0gvKx94Bnu5xy337mNs2aL+Y8HoXGjasvvRTY+z7iYagsJsBtRdNLan84fPVpJUiE4lzM6+c7KCETktZ4/lorbZAI5bjPzqtWETBj0ydkx5UGpyimPOe1Wbe7V9L2EsB34kTXt52+DamJGUlVFYitnkjUQe1iJy9VWRVTK+Mc05NCR+sEOngsB69tm7DUUNZOTuBRmNj4/H/cyjKstfoxHIz4+gw+5LSVLqBW2BYVb3ZLKY/XFCFNltSUr+rngH0dnL+HyzthfQ/1vIj+sHxUDRyiYJcWvT77zAbHM92u4hhd3M6hYgdEyMSRjHhzoVoWEojzHkVlJ8hK5nwbqEU2vU8I8nac7TLgvmQIFqvPrG0eJmaSpPVFORxXy6FPkjstUmMhtfizZUvSPpyf1aIoWLW+QGoHioCL08X3acdbCW80iPUj+uxINO8i5rJg0He3XZBOBYins8OMDjSezFSjiTSytSRdr8jktdSwPVVlD28qtxZwRSPD4WhyPxu9CUeXhDRBLXfo72U9X5vIS9BOyAPWCxQ5cqEWJYWevqE4kPgCTefgGDOXHrGO4OUgv+FMOSI7SPbBTcEqy+vW2TnbV/dRfINQgVHjwq7n/OlM7qncifsx2G3Eu4EMzVs95afmeGqGysUPPN19HrK/pt9WVZQtb3qjL+QkFrZqGHbsjhu86I8scw9IPO+CO2R2Mi21HDX/YO9mDjvTCDz43Z84U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKO6t4DZp83nKVDYI6Qrt+RKIXd2cMfg6flrZAASh69Ti+f/5lX75YCrlJLo?=
 =?us-ascii?Q?7V5px5BO3LCvW6eu+xHRamhW4gaIm6nx3WHUFrUWOv+jMpJJWX0pKT23OdkH?=
 =?us-ascii?Q?/DbosO3ttOALcsrQRBbwuy2cOahXCEHrVnd6CoCve26Yeh/fNVcBQAbOoohJ?=
 =?us-ascii?Q?sxS0hHT/EWmzOEawdyqzKRHCW0e8uEWfYmXaq8oiPZ1cKvF3PCGp4afl4QuL?=
 =?us-ascii?Q?tXEbBzYJ2M0xwYYq0jWE8RBTsJRraL1ZJwhaCvcJfN9mINHwAY5iKaEdokhw?=
 =?us-ascii?Q?yRtIQUfJludkeEdmbfu2hfn3sLOCOTVZ+lq3rcCX2vmVBAmio5memigRzYp0?=
 =?us-ascii?Q?WgFahCNr1Dtbs96tR/9NLOu4tSu1ZlWJ4CBoRNHnp8URed5GSmO12uD0UBWA?=
 =?us-ascii?Q?kDmzt5c/E4zqyEayIGEMJfd5AikHz/cxU2549sSwyRXZdKCRISwVgJZuWMvj?=
 =?us-ascii?Q?qzM/Y+2uLDJB15Lq6nhojw1r7bCkzz41zz0xmvGiga/Y8lQNrW//hZqJFjg/?=
 =?us-ascii?Q?m49tpQVIJjQIJebbs7lpph1NX7twWPZtmS1YSfS8k2bl7+QKN9c4KJjbdNNz?=
 =?us-ascii?Q?l3oBj8hBzvzI5sLYdkdSVYE5BmfJJ+OWB9TUzDjrdDgV3zeg/vCDrsyfLkmU?=
 =?us-ascii?Q?x8GERy7+me+5HuCt1rPWVWW0WFjXQcLhwv6TSpjdDkKTEmv6SteVV+eR+KNP?=
 =?us-ascii?Q?oxsiRbGIkLPK9UfcNKwRcuU4IPnTHBGMVFN6iZ9mFyVX/LYvxsdHV/FzPQg+?=
 =?us-ascii?Q?BmIHy+n4yp4DozowDxKa60hHB3hgmtKoBe+rWUVPjsZ4xApCGX3u7CoodBDd?=
 =?us-ascii?Q?nFUJbLoVdGfqOJX2ZLbddTH840ijtXOMUd8twRYPuFm9++HyucpyWK02RsLa?=
 =?us-ascii?Q?SU7bSxT5AjCuMN6L/YbSu6cKIb74VBcV94TjDrJfMmZko/XeuoYszL2zSObj?=
 =?us-ascii?Q?ontiiwPy12KFn8Oc388UEnM9KciURZReXODgdgT/mFE+GIt1PJk2JlwVVDU9?=
 =?us-ascii?Q?rJ/XNhfahHYOYYE9yj8fgRbTMQz7TsNgyKe6bjzfeBV7ylIJ1IJy6hD6JLLn?=
 =?us-ascii?Q?kYYU7MjnDbTDe2goA4bskNDi3gki2GX1i3dkiIinZG5hU0+fMFeL6p1nBDIu?=
 =?us-ascii?Q?Rto7Nj5kZz85ECnJzzXgk0Iz1T/aOwSBfRhWK6cZsWwo03f9xWU+uLlgUQdw?=
 =?us-ascii?Q?o3vOPdXr0CPpDi16pp2qBi3k6sBFtm3kSaAiUrkjdBBdJNdDkrl7LTDmuL+L?=
 =?us-ascii?Q?etuqnhVgcA9j887dYqdI2CLKHAxakAElzvcoOAEnW3MYI9aDGBKQE6kTZWaN?=
 =?us-ascii?Q?86wkgQyFsh2YlVQO7vVYo21xBwnx5UdMSxPeSMZhpGF422HATbGTqOZ7Jbum?=
 =?us-ascii?Q?XGz9YGAmC5dOnOYHkFN+Ks0WGkmgLnN8WwAwiSbo5dnNOeLeOYxrPIhujoGY?=
 =?us-ascii?Q?X4+doAILuCoF8E97sINOxwh8so0p/x40IuCqY1655cxjonnKxf4LT64Dm4Qb?=
 =?us-ascii?Q?n0w2RaNnkswnXNEr54Yfnl9z5yEbJ5ciMhI9xanDD4om90jxm7Xo3hlEidUS?=
 =?us-ascii?Q?3q1YmnGBZ15dOJ9t3hUDID3oLhVuQqmWiI6WVLSJbu32AmWV0dC0qRsDEJ+3?=
 =?us-ascii?Q?oQiKzn/IRQRxP1XIThdlVoag/5/Yiu3m7Xr8uEJeDLUyN64k2IwZwD016jVI?=
 =?us-ascii?Q?QaX7kT164SvNG10O7cX76zNRM8mOXe8K3J44IURqf1btp6f1Ik0SG/U2A18n?=
 =?us-ascii?Q?fgZe8sfa6w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b032d4d-b9b7-446a-8284-08de84f7df07
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:08:47.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkLuf3RDLmgbMEth1OA+WaFZ4C/+jFyrhaqjCOmf5AbNp+7Bw63aGjVqGc34z0xHcDYON6QzI4IPC4EinTFJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505
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

Hi Marek,

On Tue, Mar 17, 2026 at 06:10:47PM +0100, Marek Vasut wrote:
> On 3/17/26 1:53 PM, Simona Toaca wrote:
> > On Mon, Mar 16, 2026 at 01:32:48PM +0100, Marek Vasut wrote:
> > > On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
> > > 
> > > > +After successful saving, U-Boot clears the data in volatile memory so
> > > > +that qb check fails at next reboot and the NVM isn't accessed again.
> > > > +
> > > > +There are 2 ways to save this data (both can be enabled):
> > > 
> > > Replace () with , .
> > > 
> > > > +1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
> > > > +
> > > > +- this will save the data on the current boot device (e.g. SD)
> > > > +- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
> > > > +- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
> > > > +
> > > > +2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
> > > > +
> > > > +- supports saving on the current boot device, or on another, specified device.
> > > > +- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
> > > > +- use for: saving the qb data during flashing / controlling the NVM to save to
> > > > +
> > > > +::
> > > > +
> > > > +        # To save/erase on current boot device
> > > > +        => qb save/erase
> > > > +
> > > > +        # To save/erase on other boot device
> > > > +        => qb save/erase mmc 0 # eMMC
> > > > +        => qb save/erase mmc 1 # SD
> > > > +        => qb save/erase spi   # NOR SPI
> > > 
> > > Can QB data be saved to arbitrary SPI NOR ?
> > > 
> > 
> > No, this SPI NOR refers to the SPI controller selected by
> > the CONFIG_SF_DEFAULT_BUS and CONFIG_SF_DEFAULT_CS options.
> 
> Maybe the user would want to make a backup of the QB data to another SPI NOR
> (e.g. if the device has two, which is not unheard of) ? They should not be
> prevented from doing so.
> 
> > The point is that the device we save the data to is also an
> > option to boot from, otherwise the qb data is useless.
> 
> The QB data could be stored for backup purposes, that is not useless.
> 
There is one thing that might make this clearer, and I forgot to
mention it explicitly:

The get_qbdata_offset method searches for a 64KB hole in the bootloader,
so it can save the data there. OEI knows that's where the data
should be saved. On an arbitrary non-boot device, or, on a filesystem
partition, the hole would not exist. It is mkimage that puts that
hole in the bootloader, and U-Boot explicitly checks for container
header tags.

If one wants to store the data elsewhere, they could use
the generic fs methods to make the backup wherever they want, and re-load
it themselves to the QB_SAVED_STATE_BASE address, so that U-Boot can save
it from there.

> > And the
> > board will boot from the selected configs if one boots from spi.
> Please see above.
> 
> > > Looking at this, why can this QB not use the same interface to select
> > > arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
> > 
> > There is a limited list of boot devices. By keeping things the way they are
> > we limit the usage of this command to the actually useful boot devices (and
> > that we also test this command on).
> 
> I would argue that it is better to use generic code instead of hand-writing
> local ad-hoc implementation which is a limited version of the same.

In the above context, using filesystem methods might not
be feasible.

To not spam you with replies, I want to thank you here for your review on
all the patches. I will fix the issues in the next version.

Best regards,
Simona
