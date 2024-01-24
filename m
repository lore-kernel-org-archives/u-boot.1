Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81169C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 23:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AD287905;
	Thu, 25 Jan 2024 00:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="pOcwLbmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC9087CAF; Wed, 24 Jan 2024 23:55:44 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11olkn20818.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::818])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2671876C1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 23:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDn0w0TtZEjvABobx3Tm7ZLs9WEcvpMFfrOFR4BNdrpJYXyH6hU96kD3zrKDh53qHujjasAsgWwmb+tixdfLqE/k437MPIJTPJ+fgZqx16TYME65QUffMSdHhk0LllFrsetAmmQnydkd6uqr1KnImKb7MaNj5MkhEAda7RAPsPE1G3Ix3wEoVBTZw549UllqpJTegnlu1lKMc+c3FuzYS5qaPOwWx5i1WxQYQMZcGHeV1j9klXQSQFW2VsjBXwjRXv/CjFC4eaBkIAXPCHRuW2eO1WHCSZwYmZlWv5e/OavydK8qry0Q+Ef7XxJACpeFz0Chmo/GUG+Gi/eDEqq/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcrPfueqJKqNABSnzJH91YaulbhCwfayV6Aw0MgbegU=;
 b=IYsO3DsRROxHrlCq4ajxkzCDp0OuArAo71RHkaDNVRqvYCzF0b5TcXg1iG5MmsdnVGokkWCgH/gF9q5+XeQF/fZcnLggkSRElZXTGOY+2PaiuvssXB1Il0qE4pQ1oMbHcoLEIam8e6kr7/FbNtU2PflUL4n3/AV2m9+TxQHhTUAEPta7ONjW/EEjioMCn95lUgjG8dWpGK9tHobSzwS4on7jKdKxPiqwK5w9t/J+q3Khb5EOsDnYYqQy5f5My7iH7WGa3OPy8Wm3GlAfsBip/PTOmKjZZeOC77PXK8DymQVXa6Pm0op/EatRtifQAgur+TID4E36f+O/I99/PzQJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcrPfueqJKqNABSnzJH91YaulbhCwfayV6Aw0MgbegU=;
 b=pOcwLbmLG7iQJzBtGWVxeAFPzdcyzVk7Xc2p6d4uRMc0I62gac0crqQuj/gsgnmrejIrVobbvjtNxCKWQTk/MnHxhMTvZQ3VwPs70kDtMDTE/pnm6D2Ac3bghGu8GlSKKfFMMZiHD3ycx8yXhuP2u2kpQvQStiJ2DfNFwZH+Tq9EMBt5qNGIKUy5nOOeMbCVKxRkf80vOEMW6Lf8ez/RNinWO6RvC3JEofiKU33NI0wiBQggfCUe0DLdE9/ewlA7GSdGFSNFsplh5wZb+l4Ey0Ef1XWJe6iCOIvbA2ZBsD4FvHgP6dF4a7TurlTxXfDPC08oaWstP1FVOUDOaO7FUw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by SJ0PR06MB6992.namprd06.prod.outlook.com (2603:10b6:a03:28e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 22:55:36 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::4da0:87:ca76:44dc]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::4da0:87:ca76:44dc%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 22:55:36 +0000
Date: Wed, 24 Jan 2024 16:55:32 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 andre.przywara@arm.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jagan@edgeble.ai, jonas@kwiboo.se
Subject: Re: [PATCH V4 3/7] rockchip: boot_mode: Allow
 rockchip_dnl_key_pressed() in SPL
Message-ID: <SN6PR06MB53426122E3C4E595A7579A86A57B2@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
 <20240102154654.191055-4-macroalpha82@gmail.com>
 <9aae0791-84a5-42b4-b76d-2a89040b23d0@rock-chips.com>
 <65a93e77.9d0a0220.46f34.1553@mx.google.com>
 <706a4a06-51ad-421a-ac58-621ce85062f6@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706a4a06-51ad-421a-ac58-621ce85062f6@rock-chips.com>
X-TMN: [aQK6S+aXI+FjRBhSCSw6HW084fvQQzJf]
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZbGVZIVsh0vECU6D@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|SJ0PR06MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 13daf9fb-5438-4733-8e2d-08dc1d2f936e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yzg2jzA1BGpJWL6XjHtJb2o38g0lapqf7QfQuo6KEXuAdoB8US+dlTM1sACb+Zk4/C4DZxFTwE/dxjpzHOMItqIwS6PXk6Pvp2N5Au/NNezjjW5XNKqk3YIooILVJxhGO6msV7rJRLjt9VDR05gLi0HL9ld0ajUPLUrGnx9wnN196sEOIOGdQtgmqQBMZAdvnjJOaTLe6kwFmeoDPnYuBK3ZHI+LFg+RbGwUZi0HYy24vwJhKfYUhHN+q5c03HHbsNztikL93lcLR1KdUFScR7wPBxzJ+uUI4OknLq+WvrWF1sd3Kv4fbE3SRysbtFJ1ZXT4hjwG88C6HuoMVv6EkrkjEbRD4u90tOW455QC5c2Lq94/vgixbYNuu+qqjENfX3eVPlRQqn1DDsx5VGcUUgI7g0LfckMpNWIP7ZgRgRbzXTIO5xRHuBtB1A9zzNsay79gsJYHAnQolBzrfv6PgY9Po/+dAClqD1bTM97tmrl+tHO+RYW9wAmgC92MFwj7w8yRfVObZoSk7CdnL4tuhQA6NhW/M/XLGlB9Zj0LyGMqnY8Nxa1ys3klksuTn8TQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xty5qdUGsoAMGKKA4KhwHTZpTL+LUspPkFHdgiYe0KcJR28knO1AR8IAj5qX?=
 =?us-ascii?Q?hTzFkgsjLDVOXY2ztPENCRmVLppRdVgJOwUgoYb7oMCpSL5a74sT2yPE+POx?=
 =?us-ascii?Q?ReQXE0POe8qjyKVoUcoTFv4q38Gsn6+UbBbnvE6N6l80rJL9W+jpufkNLvhV?=
 =?us-ascii?Q?XRiC9r48pHRmUJsgcDlMCsCj+3mTAOhpJIrWJDhbq5aT7Dhx0yqwHN3tWDkO?=
 =?us-ascii?Q?QL1iAovXFL57CKFxLDVxKr/zxrHKNFaGO5/F68OcnNADwSM7FFoOnpG96n8u?=
 =?us-ascii?Q?RcHRrzOWYoxehalFBbD4mk5sWn81SVQTZEOCKmfh6a78OmyPpR41fdzMbXLH?=
 =?us-ascii?Q?LCPDclyrIGnWYnMU1HPx8E1VVA96rQXNX5b6PkOArEU/dDHHDvontWpGg6Zc?=
 =?us-ascii?Q?vAOBC+Osy5YOLzS8klVtStnwtyuEjit2h5HjnevYhV76MkcBoaOHSZToJa39?=
 =?us-ascii?Q?qx9oZLmeUER0dCLi5+umIpB3vmd6h1qnTkYxQs13axk7UMRkU0i3XfsN/Lkz?=
 =?us-ascii?Q?yuUxzV+uHOfyQ9rhKZplp4I6Fy5sYfed6aNKFmZHeZ7mPBF+ugkSIaVRfoAo?=
 =?us-ascii?Q?uulIeGc6KzpvPOV/Mp4NtFTiMrZlpisUlUyvCUjXFF8RqcFz3pqDDKRyhv4H?=
 =?us-ascii?Q?0Amxo57dTpSwHsA1QBDTwd2U0tW4eVyakM98BLxQnGk/pJ6wxN72ZPGiIo/J?=
 =?us-ascii?Q?Fhv7NTV3iSPM3WQ07Scv25+Jwu+10UffPGQOIR8Qv4gHi8g9veKG11HooVWJ?=
 =?us-ascii?Q?Xaq3IKKm4bfkMlWWTrHYaRR9mFdPuUqNk3rUECAuJKzPUbHTiz0HRVW+jsyR?=
 =?us-ascii?Q?ZPAoCj2UNE844ZUV4MReElSpBBJ5DFVLySc82OFGH1ofX0iXkah+k1O0XHte?=
 =?us-ascii?Q?TzgHLL6cWwwmcYY0QtxcX3x0qzIC6Pba6KYB3XCbuHGc5ATaUPZ1OAmXGCSM?=
 =?us-ascii?Q?qEj25ox2JGVBmYlMLqFAh49/0U2uUQHFEgq/pJAKaad8banLru2SEFMru6KC?=
 =?us-ascii?Q?72aZYn0TYyw2OGq+mj17T1HuMKe/SG/E75ljocbBTMj/h6ffMQGOdaSeiHlg?=
 =?us-ascii?Q?GkCwT+H3RkhWUh5VSlaIQo7D+1Bt5FD4KONLFIEdzLLW+7nTebt8B3uUwITz?=
 =?us-ascii?Q?UDf3iAcx7KDtn9pDdzCdQF0V7v+hr7ESYJF6mXrMp2lLrZ2GMxNjuhV2cSqL?=
 =?us-ascii?Q?SzFuAJKrMgrLyfOtRkYE80kX84WiNY837HbaZ/JO4qQIDZzPNtHt4o+tG3I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-73ede.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13daf9fb-5438-4733-8e2d-08dc1d2f936e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:55:36.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB6992
X-Mailman-Approved-At: Thu, 25 Jan 2024 00:02:26 +0100
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

On Fri, Jan 19, 2024 at 05:01:38PM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2024/1/18 23:06, Chris Morgan wrote:
> > On Thu, Jan 18, 2024 at 03:20:52PM +0800, Kever Yang wrote:
> > > Hi Chris,
> > > 
> > > On 2024/1/2 23:46, Chris Morgan wrote:
> > > > From: Chris Morgan<macromorgan@hotmail.com>
> > > > 
> > > > Update the rockchip_dnl_key_pressed() so that it can run in
> > > > SPL. Also change the ADC channel to a define that can be
> > > > overridden by a board specific option.
> > > I should ask this earlier.
> > > 
> > > Why you have to enable the download key in SPL?
> > > 
> > > This works for a long time in U-Boot proper, both mainline and downstream
> > > vendor U-Boot,
> > > 
> > > no one is detect this download key in SPL.
> > > 
> > > In theory the SPL can implement all the feature which is available in U-Boot
> > > proper,
> > > 
> > > but it would be better to make the SPL focus on the job it should be done
> > > and keep as small as possible.
> > > 
> > I wanted this code to run as soon as possible in the event of a bad
> > write. I have some devices which lack a way to bypass the eMMC in the
> > boot path; the fear is that if an SPL stage is written with a good
> > header but a bad payload (or if the A-TF does something wrong) the
> > device will become unbootable. If we can't do it this way for
> > all Rockchip boards that's fine, but I REALLY want to at least do
> > it this way for the Powkiddy X55 board and the Anbernic RGxx3 board.
> 
> That's why rockchip platform has two download mode, loader mode(in U-Boot)
> 
> and maskRom mode, any error happen before U-Boot should get into maksRom
> mode.
> 
> Most of user/developer only use loader mode because the modules before
> U-Boot should
> 
> be more stable and have very little chance to update, for the module owners
> before U-Boot,
> 
> they are the users of maskRom mode.
> 
> If you enable this feature in SPL, the error still have chance to happen
> during dram init to SPL key detect.
> 
> Does these two board has no way to get into eMMC event with hardware rework?
> any hardware
> 
> signal of eMMC CMD/CLK/DATA is OK.

A few do not. The error is less likely to occur between RAM init and
SPL key detect, but yes it's even possible at this stage.

From my testing using the latest BL31 file from the
rockchip-linux/rkbin github repository I was unable to reboot into
maskrom mode after A-TF loaded, the device would just straight
reboot. Do you know if A-TF does something that makes reboot
into maskrom mode no longer work?

> 
> And another way to bypass eMMC is to use SDcard which has higher priority
> then eMMC in BootRom.
> 

I see in the TRM under section 1.2 that the eMMC is higher in the boot
path than SDMMC, and that matches my experience as well. So this
wouldn't be a solution sadly.

> For SPL itself debug, I would suggest to RESET into bootrom download mode if
> any error happen
> 
> and a reset will need.
> 
> I pick up patches other than 2,3,4 in this patchset for now.
> 
> > While I have you, I have a related question I hope you can help with.
> > Is there any way to utilize the boot partitions of an eMMC device? I
> > don't know if the BROM of an RK3568 or RK3588 is capable, but I'd love
> > to have the SPL and U-Boot stages written to the eMMC boot partitions
> > instead of the user partition if I can.
> 
> No, Rockchip SoCs does not use the boot partitions of eMMC, only use the
> user data partition.

That's unfortunate, but I appreciate the feedback.

Thank you,
Chris

> 
> 
> Thanks,
> 
> - Kever
> 
> > 
> > Thank you.
> > 
> > > Thanks,
> > > 
> > > - Kever
> > > 
> > > > Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
> > > > ---
> > > >    arch/arm/mach-rockchip/Makefile    |  4 ++--
> > > >    arch/arm/mach-rockchip/boot_mode.c | 11 ++++++++++-
> > > >    2 files changed, 12 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > index 1dc92066bb..ff089ae949 100644
> > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > @@ -15,13 +15,13 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > >    obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > -ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > -
> > > >    # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > >    # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > >    # we can have the preprocessor correctly recognise both 0x0 and 0
> > > >    # meaning "turn it off".
> > > >    obj-y += boot_mode.o
> > > > +
> > > > +ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > >    obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > >    obj-$(CONFIG_MISC_INIT_R) += misc.o
> > > >    endif
> > > > diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
> > > > index eb8f65ae4e..d2308768be 100644
> > > > --- a/arch/arm/mach-rockchip/boot_mode.c
> > > > +++ b/arch/arm/mach-rockchip/boot_mode.c
> > > > @@ -38,6 +38,10 @@ void set_back_to_bootrom_dnl_flag(void)
> > > >    #define KEY_DOWN_MIN_VAL	0
> > > >    #define KEY_DOWN_MAX_VAL	30
> > > > +#ifndef RK_DNL_ADC_CHAN
> > > > +#define RK_DNL_ADC_CHAN		1
> > > > +#endif
> > > > +
> > > >    __weak int rockchip_dnl_key_pressed(void)
> > > >    {
> > > >    	unsigned int val;
> > > > @@ -52,7 +56,8 @@ __weak int rockchip_dnl_key_pressed(void)
> > > >    	ret = -ENODEV;
> > > >    	uclass_foreach_dev(dev, uc) {
> > > >    		if (!strncmp(dev->name, "saradc", 6)) {
> > > > -			ret = adc_channel_single_shot(dev->name, 1, &val);
> > > > +			ret = adc_channel_single_shot(dev->name,
> > > > +						      RK_DNL_ADC_CHAN, &val);
> > > >    			break;
> > > >    		}
> > > >    	}
> > > > @@ -73,11 +78,13 @@ __weak int rockchip_dnl_key_pressed(void)
> > > >    void rockchip_dnl_mode_check(void)
> > > >    {
> > > > +#if CONFIG_IS_ENABLED(ADC)
> > > >    	if (rockchip_dnl_key_pressed()) {
> > > >    		printf("download key pressed, entering download mode...");
> > > >    		set_back_to_bootrom_dnl_flag();
> > > >    		do_reset(NULL, 0, 0, NULL);
> > > >    	}
> > > > +#endif
> > > >    }
> > > >    int setup_boot_mode(void)
> > > > @@ -90,6 +97,7 @@ int setup_boot_mode(void)
> > > >    	boot_mode = readl(reg);
> > > >    	debug("%s: boot mode 0x%08x\n", __func__, boot_mode);
> > > > +#if !defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> > > >    	/* Clear boot mode */
> > > >    	writel(BOOT_NORMAL, reg);
> > > > @@ -103,6 +111,7 @@ int setup_boot_mode(void)
> > > >    		env_set("preboot", "setenv preboot; ums mmc 0");
> > > >    		break;
> > > >    	}
> > > > +#endif
> > > >    	return 0;
> > > >    }
