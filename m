Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79842C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 12:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 355EC4085B;
	Sun, 27 Sep 2026 12:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CUg-1Wd_fOdT; Sun, 27 Sep 2026 12:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5D2FF40855
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790510966;
	b=k3UwvKt5crQ/SrE/OmadwBWseufbelSU8PojlVGOjikgLMOZtff67X9Kk8hhICsKJc4y
	 pFgE0BYagbWR4G9uffLc6A1rU/HzG21yFTU7dc1nKRi2WLd42+eNBxzf9S1ocMFZiKkXx
	 y+wdi7K/kYV+TNz7zJLYumYue7pPWXio1dbXTbOKW+ENwuH2BFoBOmHSGIXwLDuMx8yOD
	 faq40quOzeGrtGI+OPPOBhahWIDn/VryiPaf4SeURWJxUweE5XHbHDK5pWa2Y0YjAg80x
	 fQSVquX9L2Q8GLCQpU5eErs5fGvOF93nP4x3e3km6K7S+1jgXDwMgohLhTEMxiZ6qGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790510966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
	b=gp6ebxFtOGV9h4yPUdClkbZffnASVKDjzBJ/gLQOO3PUMVJR2TgRxmdOUpnjIDnKawdT
	 8MCa4lBpsWameEXEgWdHABZeSvTiedQ54VQAEFxjkfwXiNkqZmessC63yaGiRXkz9V+hm
	 PihMrcLA+sWNYCjfT25uB1I9a9z5LfxIePbl5cCWlnIdUU+F0NvyWfWzh/SwBzlWcjfgL
	 v2jNG55x8CYgXClS5z8ahseDvAARTBMl+/mDpwHAiC1hEIuyl0DDajSkDTyvjMQCTDUFI
	 ZzOMBZ8OOzxCd1QRaMPRs2sSn0tIv35iImmU/Rs5xUsW9rM4Cfya+gswuTY58euIGYg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790510966;
	bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZDOwv0KoU0mpPoOj0zw+yZSdRjNb8h5Zprk7+kFar7TshtQwUZsWqmWMJLTAxOrv
	 yTnjeipILNVyRx9vQuaFo8xSYXOPi558FrIPqfciNQ9pEQhwsveMahl5Qxzqxzt52U
	 yJZG7SYXEHYpj3SDw4tzPxjEk1maLzF78a/2yfaiET9i2M670w6E8PseL195o5i6C/
	 bt6TRc10PZYO3NqzHxwHNNR6NMDLP4mRb4Y0TN6U8d8GegClsApbLjFfQeDtRySzIu
	 i+NBl8pzXREZkSRKwiukMeXW3pdNpsg4nHikIhJiuvtPr6TVNKBEUZRY8sSxZEMcEV
	 wtcClN7RSfhSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D2FF40855;
	Sun, 27 Sep 2026 12:09:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C30473D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5F3280FA4
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFTMU3xrwM4p for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99EF280FA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790510964;
 b=esblU+u1Is2crr2azkHNo4+MmHQDKmfj6SnbhzzUjlvYoZZehr1siJCignRMSub5Eg4c
 O/ggyQ4xb6eWE9ZlCHwoMH4yvcGU8y8uvC76HWBgr0MrIVSsg6m93RMbrieq9oA51GCC3
 wPWyNEV5WF3acWoD0bHIKbedgALIG3GspCzkdC7pBlcd5BaQontCJ7TAhWA5WoEWg57Ik
 fYC5ml4CD2D2xiwjKviIWVr/lR6uQmW/M9Z+lukWd3AsPMZgbjtnDdBCEvlcvX305hvME
 RNR5QoQh+EhnMyZU/dUcvpsT0vV539D0xdbowsa3o2lJLN5yS0vFJLRUtj3ffOZ0BQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790510964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
 b=cB/nwU517dfpan5lwMbkTL7frMgrWGauzhHND8FphyloMrnXKNXxx/bIgfRKPf8Ssh+4
 79UM5Hf8Au9XELKUHLma0QSVkgB56JvUyKRB1hsicp6BJfZOO/7T4JLxEvph150ZR7Wg7
 NPKUOiHmKndj0ZHfid44jfJ4S7xMq41WUfm4p1ZF4O6zKDqujSO3qmK296wouKw52LB16
 UDkJq4futDsg5tLNrh4V/BHfWb8E8mtFeB3V7PR1haPwsiziXDgCDi1tn6pThF/DhNPaW
 nrjIc8pqIVQyCb/e9VVb7I5kB75PQDLOSwCPeqiLVoBvz/1tbuXamZhfsWqI7dDW66A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Nxz1lPjz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Nxz1lPjz
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99EF280FA3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:09:23 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae7b7fe22so3602423a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 05:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790510961; cv=none;
 d=google.com; s=arc-20260327;
 b=l1XkAbzYNWXDbYxqsCuMZPN7Z3HA6YaNRdH6G+NCgh1Olf1s1x50GKi4n07yyys7hz
 Idht7PDdd8oUHbgc+xMaLKKbHimihww6W8rLouUZJJ+egMjKTC9CXxgKX6eU5CmmxA/j
 /mBcNA0wVWMKTJ1SPyYZZP4THEaL3iWnhBd1T60xlMk7jkflnWFEEQg/sX3k+bpKArmb
 89SY6lGGWqxDCRmCwpU/IWzjsDlszeugnAs89TkhSTZseFWEoF0j0myA1EbB0xA2+7Bx
 NN+ap0ge/rJYN1rVV7oo9asuPB/W1j6kPicMNUKhhHKWusO1obtdQhu1BVCjiOTEs551
 kYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
 fh=5LJYD25QY0rThavzpSkQgIQNcTy+oeMAqIrXfpAl2g4=;
 b=CrOqIuI2/qtEjMlPTsu4gNObuzsq5mtTlLBq2In/A7nl5iX5ZqmQ6BM87pGo0zkcDx
 BuepIDMofs02ksyR8tS33jd8KdF3kebFZqy+Lbn45cTyPbsTUTORoR2QD/lNMLF5MhpY
 oug0xmBjT6nZdUa1MxDEJ3zC0iM8+c4JbcJIqjsSgDh++rUAWJVWH6GsJ3TcoU4+gOnF
 qQQBaPQ6GeODqkd9sBuX+1H9w4BMGJ80HxVgmZTgF3sbLpZ6IZB6TuLEJzMGHGxC8scK
 6EPq7S+ArcDDUfPhICyrJF58H9g9PUc1owKY6iZsHWp7p/K0h804Hhd4L5LnBg5tee01
 RdRA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790510961; x=1791115761;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
 b=Nxz1lPjzmVDskHyXJqB+2Nx8Uww0C1Hp5FiRvFvRwYJDlbJtge2x4AJm0VMKi0IJgs
 IHb1NiiIjIduK4A2b5ZwatLqa7ChLvnfmtyxrSzTyJMfLYExhuXzDZLBtwmWoi4TnR/j
 Xz1Bmv+QjiO2e9p2p7R3lPR4Ly8gShP5JTSK6LKAHzLeyXgvVqPkJ5XzZJulFcHyJIwy
 BmH+MrzF4hguJUPB4AQIX8J9Hp5+V5R57CpoBA0VdhYuhYBzkjRRM8VEG1BengOYvy+3
 FqWqOdHOf8cWXixZBHxEAO71EusQAPHLYV9xiR/b78euCaMUVA8af04/ZvXmMVydS78E
 LIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790510961; x=1791115761;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dKXpwZYeoOfjyIjBeasJu9dPTP+JNwCaKNk+iZNON28=;
 b=VpQ0ysooul6waxE2/1uvViRY330SCjQWX38Q6Ozj6Ak8rKPuYMt48PeDaAA4G+Qve9
 70pf59/7ORJYOdzmc3u8tMvhX6Gs5GTLCBUoZJCkjL27cHSaWlUdCW8sOFcjIQMTZdZA
 dPM616xo5PtiA+ER50lzI1Gp/qwyiOF5GAiBDl/rhhrPs21cIVRezyacVCeRd4BOKn93
 WVuuzg1o/99f0vptLyvkD36mMCPyOW4o7d6UUx3MLRNOBEAyX7B05DqnMDmL7oNCUq5c
 1WsCiwLHfPXNdEXrLSOixNAQbuhisdn18FVu2g/Nw3J+sXL7YaSKNlMPsOuDLoa6p/C4
 nnhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3w6VGRFBiFF84/JSxzhzsOzliFRBfxP0LybX0zXuDtxZvysRo9ulNt+5GUvkysZw/EyVhxMM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lHHUSRK4PgNgoOuYytfyRg13NxlaUo4NCYraIZ2RAw79e2sgPV
 RgHDh9AUcxqhm5h0d+J+FSopic1IGkLIVzkWSEzAqYW6dccE25LILtsXswoWiSv03iHU2DB7sC7
 zGJk3PTnDe/GLTRtdOStr0iLOuuWGlVM=
X-Gm-Gg: AYBFou0ZqpPkSlfV2yovSCN1cTxTJBdOiJZi+bsjYXezve7RrFcBX9vxzD02j7mIRwF
 JrZOVrcJOWjELfO9PfGiorxzdU0WLUbRwbxDEH72pAcXIgOO68PTHZmzXlmArKkOWpy+4hVS47K
 IVZLBQ7kDXbdIcKo1afWHhDk9meZGte45k3IVf92EPR5a/RZUhhKQ/sB9TTUmAhYNugiQM0fmha
 GaL1u54Q6Wl2zQmhrKcogus9wWr7uCoCtqPXfH+bP9l/gaeuHq7VJ0Nbz8HNtkWcRjsM++e9M6O
 u6y1UCfsBxyMy9uTJXM8eetavYhfjPvC5JC425SKR7/DyDkiQyrnNg==
X-Received: by 2002:a17:907:3f05:b0:c26:19de:9ad1 with SMTP id
 a640c23a62f3a-c2aea0976fdmr550181566b.41.1790510961066; Sun, 27 Sep 2026
 05:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-2-jonas@kwiboo.se>
In-Reply-To: <20260805174509.2968252-2-jonas@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 27 Sep 2026 14:09:08 +0200
X-Gm-Features: AclHuK-XoXpPbGWwzQKmGdA3bmyd8hwQyVICgP3ezkNktuLesb03j_PA2mAqanE
Message-ID: <CAC928HbGTRYNXdVnExJLGMDLBewYVSJ9uZiwG2aF5b6PsOC9oA@mail.gmail.com>
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jonas,

On 8/5/2026 5:44 PM, Jonas Karlman wrote:
>
> The sysreset_rockchip driver uses the rockchip_get_cru() helper to get
> the CRU base address. However, use of this helper adds unnecessary
> abstractions and limits the driver to only work for a single SoC.
>
> Add a rockchip_sysreset_bind() helper intended to be used in clock
> drivers. This helper expects the CRU base address and the offset to the
> global reset state register as parameters in addition to the offset to
> the first and second global software reset register.

What do you think about dropping cru_base from sysreset_reg struct and providing
registers addresses instead of offsets as arguments of rockchip_sysreset_bind(),
to be stored in sysreset_reg struct? There is no other use of cru_base than
summing it with offsets.

Regards,
Massimo

>
> The helper wraps similar handling as existing clock drivers, and will
> be extended to make use of the CRU base address and state register
> offset after all clock drivers have been converted to use this helper.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/include/asm/arch-rockchip/clock.h | 15 +++++++++++
>  drivers/sysreset/sysreset_rockchip.c       | 31 ++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index cf8bb0f04636..1b12867b489b 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -186,6 +186,21 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
>
>  int rockchip_get_clk(struct udevice **devp);
>
> +/*
> + * rockchip_sysreset_bind() - Bind system reset device as child of clock device
> + *
> + * @pdev: clock udevice
> + * @cru_base: base address of the clock/reset unit registers
> + * @glb_rst_st: offset of the global reset state register
> + * @glb_srst_fst: offset of the first global software reset register
> + * @glb_srst_snd: offset of the second global software reset register
> + * Return: 0 success, or error value
> + */
> +int rockchip_sysreset_bind(struct udevice *pdev,
> +                          unsigned long cru_base,
> +                          unsigned int glb_rst_st,
> +                          unsigned int glb_srst_fst,
> +                          unsigned int glb_srst_snd);
>  /*
>   * rockchip_reset_bind() - Bind soft reset device as child of clock device
>   *
> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> index 00308f9a33b7..39cb16ec5456 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -4,10 +4,11 @@
>   */
>
>  #include <dm.h>
> -#include <errno.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <stdlib.h>
>  #include <sysreset.h>
>  #include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/cru_rk3328.h>
>  #include <asm/arch-rockchip/hardware.h>
>  #include <linux/err.h>
>
> @@ -42,3 +43,29 @@ U_BOOT_DRIVER(sysreset_rockchip) = {
>         .id     = UCLASS_SYSRESET,
>         .ops    = &rockchip_sysreset,
>  };
> +
> +int rockchip_sysreset_bind(struct udevice *pdev,
> +                          unsigned long cru_base,
> +                          unsigned int glb_rst_st,
> +                          unsigned int glb_srst_fst,
> +                          unsigned int glb_srst_snd)
> +{
> +       struct udevice *sysreset_dev;
> +       struct sysreset_reg *priv;
> +       int ret;
> +
> +       ret = device_bind_driver(pdev, "rockchip_sysreset", "sysreset",
> +                                &sysreset_dev);
> +       if (ret)
> +               return ret;
> +
> +       priv = malloc(sizeof(struct sysreset_reg));
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->glb_srst_fst_value = glb_srst_fst;
> +       priv->glb_srst_snd_value = glb_srst_snd;
> +       dev_set_priv(sysreset_dev, priv);
> +
> +       return 0;
> +}
> --
> 2.54.0
