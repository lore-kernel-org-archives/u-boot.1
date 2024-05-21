Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C5EC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C073883A0;
	Tue, 21 May 2024 19:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="KbQ0CV4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF568874F; Tue, 21 May 2024 17:12:14 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azolkn190120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d108::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C68A88725
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK6tb1arvx8ptsBfkgDuFt3UOWESmEsDa2GVdk+EKRGxTDY+F03NPxIZGrU2sgkQtP8KE24WXBrm6gudsdbjcFZ7INUMhDXr9rJrTSprgmTLZigTG6NwMgOSYp2aT9sVXqxeWK4dZggTj6C5LrP0aILPhvEnJi6HjAmc0HZ/eRUEdUiAeHiDS/9dwmT9MQLjXObWLqkc8w/HfcmzalhqdRrYZJGo+OuIG3ViOpfEoerIBgSZoxMafX6GczceHFhkGWx5kL7p8RxLdbLtw44OLRQbYGi8rrOav442s0gFQTY7gnULuXQBpmR4hBlLkRue9+9oaOBH/78a2+c16a3l4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OZC/KZoEraPPfzgzKrFlFnUyDFI28Zcn6HjnScQCaE=;
 b=KIMEKiN26fG4YduyNI/kPTPZCNfI3gPGFwRdej2WCf2uh8rv1vOPTGC/O3Zt1S1sUdY2JHdhbGdG+nJyd7w6nljqoPYTf5dwwKcLSxDYFiqIO3KImGb8Gh/d+XG2eDeKAaYP+9pM1xIxlFlZcuDNIV8thDh1ozhn/ioCPrnPhY2pVQZpK8Ty5eMiyiudMBq0HIMKKmNI03zWTAmQfoS7CRae/CxXJkG6ITBKbT6ogpx4ndMLvG+bZAX83ylLJNxfKR6hCFQRX8eUQrCxcaORblD5ofJC+WOs86d/EwU87G/tso1u6Lby2RzJ5Z6Fb84sj5KHcOeahZCiCBaxrDf0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OZC/KZoEraPPfzgzKrFlFnUyDFI28Zcn6HjnScQCaE=;
 b=KbQ0CV4tFkOMlLvMqlxilVbxNLXIZIVhzBIUxlQ/44m5LsRZiSi+9cK93JMmSjYwD39wgUb3aXZN+H4xa0lzIiTUfk/vtD1DL9FF66Sk5jfc8rKIgc3ucmuKTHrqYiqed1SX/suUeMsLBPCkQ4W6E+uXnSUng/GHhCKUBqILuMMoUr4cmqxFYlaKOeGzbZRRsbHdw4soXqVJqyQxJN2iYxdu3UHpbIWNtBa3d4y8mVYNa+COrYtPrY5KPouvcXE0yNBehWQl1yeB+SqXadG3Vewf+vYuje+cLXTCndlFwYdvc9dUawnbUkjci7FVzzpgvsLflZLp9Z8M6z0+0fvkKQ==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 DS7PR05MB7254.namprd05.prod.outlook.com (2603:10b6:5:2d2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.15; Tue, 21 May 2024 15:12:09 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::12a8:4f88:32b0:9407%6]) with mapi id 15.20.7611.016; Tue, 21 May 2024
 15:12:09 +0000
Date: Tue, 21 May 2024 10:12:07 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chris Morgan <macroalpha82@gmail.com>, dsimic@manjaro.org,
 trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] board: rockchip: rgxx3: Use sdmmc0 as first device
Message-ID: <DM4PR05MB92290AEFA1A83F412B1CE422A5EA2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240502193410.1080938-1-macroalpha82@gmail.com>
 <20240502193410.1080938-3-macroalpha82@gmail.com>
 <ff2f5c65-2f86-4ac5-866a-afbee5a05c98@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2f5c65-2f86-4ac5-866a-afbee5a05c98@kwiboo.se>
X-TMN: [RNtk9iYPO6RLugNGX7nm59h8yLNqRh71]
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <Zky5xz0w2Sn3ULAf@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|DS7PR05MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: c4932a15-c261-42e0-9d59-08dc79a86256
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199019|1602099003|3412199016|440099019; 
X-Microsoft-Antispam-Message-Info: Ma/Xqfw3rLbpLk7RBaqEfU7TLEHum0mi0Bi+l+Y8I2LqJtbv/0BVRiGW3M59XJsYjP7NNApH6LFXXbog+L+MM1f/xJ6ZPa9RDUNRLz1dvaR0Tu5q+V0Fh0ZQ51FKFU0Tkd6hLLQburLP4d5Jep+y1ZdIUaS5hENBWoyh2B/H69dfRGB64AS1byNy1gZLvVARm8T69TRdvXE89EMDMAP6xQTBKkf8L02aG5O2/yoGBgMRjgKI//Wvq5d47/MyjGBVQrYpYhJPNr97YQU79tHE9UcjsCrpMLy0Y9rfOphzwFl3xHw2gSe3bWn5pisnb8b3vl617XoccGh/N7TYuugOnPQJnUOwEovMP7Y+YkbEjqro7HjTMs4mHhhRmBEaz88Q+dcY9RSCSEpMYPJaLedTV+xwhIQ+TlPT3o9/YT+dqozq8uhzXuxLeUGto40l7D6InHUwRbBwNJmao1EThwt1SVbj5KOxa4JiuM0eE0IRYRjaH64bplLlyMA6pqrh4KowrebRqUu90WKmjoSwIgVQJJDNLN1UNYl60Xw1SbFpvH2kDcpOZV0ttaSE1kMSjfdv19OrNH868tyddrMovFGbqhMBi2VqxW00jrpbOH9ihZJwzRKkONbAh5NfxjOheSNA/Ku/xG5nHLLpVCKNbj+If9P+57++3aD6hS/Z2njXQSI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z39BVD2wyjAvawPcWIF45aezqzVzsjDsda1U9tPaT3Yxoin7dyUM6H5bts98?=
 =?us-ascii?Q?kFqY3xqrMukH7cuG9GIducVSFxqjk3usjEzu1SYUp/ubyuSUD+iIX1t1qDii?=
 =?us-ascii?Q?q1LLmwL1N1QkQRhSmMe9jPtLItM7KksycMd/Ql4qGkZWTQSXtRuoAotCTp0t?=
 =?us-ascii?Q?PId3pKHsayb0I4OaBGmAr7OhZtK8lKad9oY8cDMbH0gWr0ZrVow6N2Qqe3R7?=
 =?us-ascii?Q?w4lrMzIGMXrfiCSxmjjvlS4vvcfdwi48GAs7D1xpbEM31I5RrfJbT7RoNgd0?=
 =?us-ascii?Q?HIAJNbACsFa4BxC49v1FdpbtZHf7decndEgPZXQAY8F3sez3d0+GNeM3JN9K?=
 =?us-ascii?Q?r1iSgkV9g8UmPQf8PVWqwq0EnBeFvs89TB4hl2wWyCdMnsP2/bkZcWfSUcLv?=
 =?us-ascii?Q?QEF1hihF8X1JYgkrcxo/TIhLEqnzFtL6PfuJjPIElEqwjohSOrAWmnEZ5LQq?=
 =?us-ascii?Q?ztgzSl2+Xb3gvlWFR2m2lQU4EMSXaghclpX9QyOn5QX312h0lLDX4wnHZDu/?=
 =?us-ascii?Q?T4s2JkdEEHSxFvqLUxXjy9Re7rmssRRMmpBS7JhWHQ60vFlqaz2C6GN7n42n?=
 =?us-ascii?Q?kCwr0CWgrPc/RqOKB7I5Kstt2UjwZoO48YyXiW8LzZNHZvhzxuel6fn5J6Qt?=
 =?us-ascii?Q?0RAHwraIfN1m0pArzLYXmvIoAM9DEbqYjYilm4LLBuufakZ48yMyDDMCx2yL?=
 =?us-ascii?Q?2Lr/VrViX0XGHnJr9MM27AFi6Xvpoepdp9hB/6bVJNTI123nf2g0EUrQGems?=
 =?us-ascii?Q?KQgy+ZP0quj5f8lgXWawDag6jGW6z+u5mLW2ZtEUcE/iD6w9YmM4lt2tUTvX?=
 =?us-ascii?Q?SStJ9jNrKI6c4mqpLIEaaTS2IaFBQbtwCj8Jj/9/VMIjzXsfHXd+gW65y34x?=
 =?us-ascii?Q?HBv08QyFfO0uesG9B97aL1ukOa0uU7iVsDft4685lZutBc940jipKWNqDDM7?=
 =?us-ascii?Q?2AGjtfPuMLz0jEDjXAbE87F118Q181bI1UEhf6JttrytrwcXUOG1Addcj9Qt?=
 =?us-ascii?Q?QSPj211ohknSg4G5J3ZsZO4t2YuaH/+KegpRHIhIH/6TbTzkqWit2oZ3+e9N?=
 =?us-ascii?Q?5gqEqGKawaJvNC9aKcd+JswuEhFlbu4LmQPVqYd8EpMpTdOwIAlfMPkr/8ot?=
 =?us-ascii?Q?HC7kZV6LWYbjgFhtUWFmsmqdrORoCrB7BctD0PQgKmtWd7Ndfosm6CAwpSTW?=
 =?us-ascii?Q?buRsS2xeg8/SZv/gRO6Fh0F2l1Rl9qdCUJy7oGd4IiycCWYdkW/IZgni69g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c4932a15-c261-42e0-9d59-08dc79a86256
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:12:09.5270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7254
X-Mailman-Approved-At: Tue, 21 May 2024 19:35:48 +0200
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

On Thu, May 02, 2024 at 10:00:46PM +0200, Jonas Karlman wrote:
> Hi Chris,
> 
> On 2024-05-02 21:34, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Some of the rgxx3 devices do not have a way to recover from a poor
> > flash of a bootloader to eMMC. Set the device to always attempt to boot
> > from sdmmc0 first which ensures that we can override the boot from
> > emmc if we have a card present with a valid U-Boot stage.
> 
> I would expect that after [1] was merged in v2024.07-rc1 the likelihood
> of booting a bad/poor flash (where FIT checksum is invalid) have been
> mitigated and the boot process now fall back to loading FIT from SD-card?
> 
> Or is it to protect against flashing a FIT containing a non working
> U-Boot proper that this tries to protect against?

This is to protect against a valid FIT with a non-working U-Boot.

> 
> Also sdmmc1 seem to be missing from SPL control FDT so that could also
> impact fallback logic in SPL. Following nodes should be added to
> rk3566-anbernic-rgxx3-u-boot.dtsi:

sdmmc1 isn't really needed. As long as we have sdmmc0 we should be
good. I can remove it for the next patch series.

> 
> &sdmmc1 {
> 	bootph-pre-ram;
> 	bootph-some-ram;
> };
> 
> &sdmmc1_bus4 {
> 	bootph-pre-ram;
> 	bootph-some-ram;
> };
> 
> &sdmmc1_clk {
> 	bootph-pre-ram;
> 	bootph-some-ram;
> };
> 
> &sdmmc1_cmd {
> 	bootph-pre-ram;
> 	bootph-some-ram;
> };
> 
> &sdmmc1_det {
> 	bootph-pre-ram;
> 	bootph-some-ram;
> };
> 
> [1] https://source.denx.de/u-boot/u-boot/-/commit/61177bead95d366d3155722eb52db8077829579c
> 
> Regards,
> Jonas
> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > index 793ed4ae8a..18f540a3a2 100644
> > --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> > @@ -4,7 +4,7 @@
> >  
> >  / {
> >  	chosen {
> > -		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
> > +		u-boot,spl-boot-order = &sdmmc0, &sdmmc1, &sdhci;
> >  	};
> >  };
> >  
> 
