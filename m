Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959B4CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47B6B80ED1;
	Tue, 29 Sep 2026 15:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arouXEgNc0DC; Tue, 29 Sep 2026 15:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C47A380E0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694929;
	b=JQywn3xNEuF1lXyk8KdX5yPpLfEx9oYRmOe7GiEw8pw25PH5oNwFpOgYZHyW/eE49Ika
	 pRnrspvFREkYTJXtBUEyGU6EG4dzwsbOzMKYSy0z/1jR4M0bJIAsVRkPvdqPPZaJapkTR
	 o1Qp9N79azObGQrP00wYpoy2Pd0p9Y6N2NbXDe3JbVBPJ5sPbSuUBIrr/zVI7+9pSAHAK
	 GuIuK7pLbo/noX0dy0pvPTbghVpIi9QJmIdAl89goNSSXqWtNqDmSzt6nNdZHFqXexyTS
	 uJVMWAh+4TDknDaSIdbJm/TRSL+/ybDydCymTkhnjEukby7zcDVxiQoNo1nkGll+0RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PRCX3IiwtL6x3/hhboJQ/8PQE5STgoHDvwGiZ46dWPk=;
	b=PiGRudtbu8doy6HYtUiAizj61DsD4MJ3pb/N4H+Nuc/2Wq0Hokn/UASPKLnaNIVqUPRv
	 YwCnk6b1KOtsp0Sij5SkZO38Bq0JejlFEctM3+l2L6hcviLu9V1FNdi9qtTUWG+8s5EGi
	 jUllSMXBZ6L9PcTKiRo8/7Qv7VljYqlnwlKOgAouOt2P+KnqVH/MYYJUnuLoAGG2I/kOy
	 e6nZgIrCRuFBHCo7d0YGmzmgAOtDo5XuGUd9KeLGIGdemfLULubx4PLCDJYIffnjVP3Bw
	 CiEN8BbupRycpv+W5dCQtQFH1kpeAb2RR6oV9PYzlT68TOr2z78JM1hEGGtYibBDdgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YZKzftCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694929;
	bh=PRCX3IiwtL6x3/hhboJQ/8PQE5STgoHDvwGiZ46dWPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ts0xiDmIJ0YjnDAILOWNiOSfWPMeP/xRVDqop74LI7ycI6OJ4CKozS0WGSlPCAn/I
	 T+6g+Tu88lAWnMILujpzl59N4CvDGWwiXA6QKOzpeRauo707lTDnKOdgN+MRdf8hmk
	 SHSjCCLqgWzCZzp6pWMFYjE11YSvcvnYfJU7GcJfLTgG8dURru0Ur0Uafa8T1mVqgb
	 AyTEEGn3BWVA3x8VAVCkC7h/u/l341L4qsIJj6vYNHllaZ3GhzLoAILz9cgm/Rv0eV
	 yKf0kCD/kQNTrlPZhuG4ZMUBJGmR5zh6/6yjbhnNFKEsuLfhskt0TPewu45+IN/Ht3
	 CnONI7/tCw/Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C47A380E0C;
	Tue, 29 Sep 2026 15:15:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B26C232A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9719780E0C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfH1Pb0KZwH0 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 41AF580E09
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694927;
 b=PDd9ngpdFBSWcmMGQHgp/eeLPCRb3T5v1tIQpQt/iZ/J4RgX5Xq57XRE+m6ACSgLaZUo
 ayD0q2yfxg+WY3tJ2jDLlwo3n8a+YyuAjhcSJHNXRKDZ0TJYVrxEI4JsbO3SIFPSCjuIg
 ofnVGIVsZOpF7b2R96AP/Y5feWrWBXFDIrLPVJ46X/rALKod7PS1gJu+jT9TxnDHrO53u
 qqfjKa/YKR1IRCVeR0CwH0mJuMAunb468J/bynLybE7NwF3X4N/eVkhXvAc4KDI48/4vV
 UeYErtuQGxVCG+kALY02Wt1L07RCGDlhTGwcYIYgOGaqGhsCzhnwbDAMVepRulf4Fag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694927;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=PRCX3IiwtL6x3/hhboJQ/8PQE5STgoHDvwGiZ46dWPk=;
 b=eT6Y90LYPVRvey39oVm2k6xM5WGsU6hSW1dkXa5T3YIm0HyKH3gwwKQp7WtrUQx/py4/
 +LfSStsyy35kg65y1u7f14oVWZdUYcCopMyPsR5lOpV6pqRvbPUraV6BqXSgitpPAgt/l
 4zcWobYevqjU4EvyiPdk3kUIf+kIQrmhA64Z8djS7PMUWkAmsh5qLYXfpqn4y7GLoxkxi
 Z2JL2Ys9q8hODzjCDougPkYXK+LMORjMCmh9fRweB+uE5GyDz/262sP9WqX8mWv/KQyin
 RvEQVECtNFS7KjTT6Inamvg0QIIxOtmofJxAsgmiSujCQDxHj1L0blFdKCSv+zNDv5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YZKzftCd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YZKzftCd
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41AF580E09
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:26 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6c8f6a53fabso732656eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694925; x=1791299725;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PRCX3IiwtL6x3/hhboJQ/8PQE5STgoHDvwGiZ46dWPk=;
 b=YZKzftCddhtrvlFg6NnsTteHOxSQ9ImVFrMraBSGCwDjyuRX0DVCXoG2TcFVjqEqYQ
 Ne0iq5EWokWGbu9IcDE3zQeA1c4SB3WJPz+mMSGSKuTfe+GPkqE/6lD0KznxxcLIZgOT
 NwO5i1rvVIpL056We8Kfb17FcD/QrR5FMIAfXsyfBfeKNLaYtCFMTne71JogH2TPmtbT
 YoV70COZxc+D4SMTkfJAfsoEAsiikdgeVS9DjD765uS10ELppCX9UGnSv3KBuu3GUipd
 22AN0metj6+v0sYj+EWobSAiiIuJ9wK62eCFZfKqIf3miQL7ppTgZI2RoKElTY0eO2bo
 s/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694925; x=1791299725;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRCX3IiwtL6x3/hhboJQ/8PQE5STgoHDvwGiZ46dWPk=;
 b=o5bhjR8zyY2qea6qSxVZ069pjtK/olPrnO1+jTx/UsITvyDV7//p4bRcpBJ7aDbwaR
 JpoINFj1mTmtESUlPCgarfLW11SNILtwmQMGAvxaDJrIXL51GW/4cSIrhagnVYDIelw3
 GV8tNwHI08CdVdwnRDGss3vErNPhoLa+3AFZPnfJZC4KPI8+0zrm6ERHnb2DVYKEKNyt
 IOc6QnNJuyWdDvxU9hgcssf0IsPhLEjY1+OQqSLvkcxA7s0XgJCQQ8Z4umVXvJWJoHlL
 kJNUlrCeCu2PQIyjRP2iSnSW/rsxIdRE4u7zLTFJCqd32JtB9Z3Nxy0FwIVTvgCqJMb9
 UdNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByq9Lniyl5m0SMpLdrzmqrFylJuW6LWFzR5Eotr3cSQ4InvLrzqwSM2h8fNLVCZ+Zgfpm6wH20=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m3CqKN8sSZC2o68aPrzErFTdDkecLjQItTV13BeJ0UaQ2n3Bcr
 O3X6H5xmoEMcYq6QuQzfRV3qeiCDnkRDqCKnDINuqAAQDBxyVJJjZUPDdAsJfFplKec=
X-Gm-Gg: AYBFou1DZvDm2BTuVPPv1Tz2Qrbiu7TZpPbQE8FebUoTN6JSYHTirDJg7VAnh1M2dZ2
 32yFViYJYu4wBHCa6Asl6qlNUH/8ZRagPJikt7kN7DFXVNlLaU3d+ONlX3rcvluA870DHRokLF3
 iFzvrR9FAylfHHTNQjSBmJYX1+sviHsyLNBJ0GXgm3j+1BgMfpy4KsqTnjt22FIQbA/CDt68ObF
 oiVcsm5YI6KPCN0SxiVfVVndSF0XTutoheg+of1CWehHvzaguR9Wsi7Z1z766WLS8+c0YIPxT0f
 7vPK1TVV5L43zqkik7/RDjBGS2eLWCu14iPF1BKHEuCN3Iq2Iyh7BqjdHHCQPhyQKGI72YL46bD
 Swgwkydd9kYY9aqqIuzhIOMmen7zuzSgrSVlVHuw1klt4+W4miKmY/hmEl4Zz1WLh29axUSW1+s
 ZxAiKc3Ie/YuI5tYhsou5Z8rHU74xI394tZev8tLJ+5FqLAvUEYPK/XYerhzMJ31OAUCun+dGpx
 /1lZZKlJa9v4rGl3Ai9nt3TAa6VQ18dulxS6yu80Ki3ZKRt
X-Received: by 2002:a05:6820:178c:b0:6b9:3a84:a156 with SMTP id
 006d021491bc7-6db147e559bmr1665032eaf.26.1790694925435; 
 Tue, 29 Sep 2026 08:15:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9b16:2a1a:ef3f:3700?
 ([2600:8803:e7e4:500:9b16:2a1a:ef3f:3700])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf31059asm100323a34.15.2026.09.29.08.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:15:24 -0700 (PDT)
Message-ID: <17015c04-0745-4c47-999d-942a59cbf854@baylibre.com>
Date: Tue, 29 Sep 2026 10:15:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drivers: power: regulator: add driver for the
 regulators of MT6373
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Guodong Xu <guodong@riscstar.com>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
 <20260924-mt8196-spmi-v1-3-dd2263403691@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260924-mt8196-spmi-v1-3-dd2263403691@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/24/26 11:02 AM, Arnaud Ferraris wrote:
> This driver supports basic operations (get/set voltage, enable/disable)
> for regulators found in the MediaTek MT6373 PMIC.

I saw in [1] that VBUCK4 gets special handling. Do we need that in U-Boot?

[1]: https://lore.kernel.org/all/20260511101355.122478-3-angelogioacchino.delregno@collabora.com/

> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/power/regulator/Kconfig            |   9 +
>  drivers/power/regulator/Makefile           |   1 +
>  drivers/power/regulator/mt6373_regulator.c | 797 +++++++++++++++++++++++++++++
>  3 files changed, 807 insertions(+)
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 428689702c8..b529285cfd7 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -581,6 +581,15 @@ config DM_REGULATOR_MT6359
>  	  This driver supports the control of different power rails of device
>  	  through regulator interface.
>  
> +config DM_REGULATOR_MT6373
> +	bool "Enable driver for MediaTek MT6373 PMIC regulators"
> +	depends on DM_REGULATOR && PMIC_MTK

Did you mean DM_PMIC_MTK_SPMI instead of PMIC_MTK?

> +	help
> +	  Say y here to select this option to enable the power regulator of
> +	  MediaTek MT6373 PMIC.
> +	  This driver supports the control of different power rails of device
> +	  through regulator interface.
> +
>  config DM_REGULATOR_PMBUS_HELPER
>  	bool "Shared regulator helpers for PMBus chip drivers"
>  	depends on DM_REGULATOR && PMBUS && DM_I2C
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
> index e17937f4c26..ce8b465afc4 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_$(PHASE_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_DA9063) += da9063.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX77663) += max77663_regulator.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MAX8907) += max8907_regulator.o
> +obj-$(CONFIG_$(PHASE_)DM_REGULATOR_MT6373) += mt6373_regulator.o
>  obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
>  obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
>  obj-$(CONFIG_$(PHASE_)DM_REGULATOR_PFUZE100) += pfuze100.o
> diff --git a/drivers/power/regulator/mt6373_regulator.c b/drivers/power/regulator/mt6373_regulator.c
> new file mode 100644
> index 00000000000..7927a620fb6
> --- /dev/null
> +++ b/drivers/power/regulator/mt6373_regulator.c
> @@ -0,0 +1,797 @@
> +// SPDX-License-Identifier: GPL-2.0

Prefer GPL-2.0-only or GPL-2.0-or-later

> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + * Copyright (c) 2025-2026 Collabora Ltd
> + * Authors: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + *          Arnaud Ferraris <arnaud.ferraris@collabora.com>
> + */
> +
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/device.h>
> +#include <dm/devres.h>
> +#include <dm/lists.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <log.h>
> +#include <power/pmic.h>
> +#include <power/regulator.h>

Headers could use some work here to include only what we use (and directly
rather than indirectly).

> +
> +/**
> + * struct linear_range - table of selector - value pairs
> + *
> + * Define a lookup-table for range of values. Intended to help when looking
> + * for a register value matching certaing physical measure (like voltage).
> + * Usable when increment of one in register always results a constant increment
> + * of the physical measure (like voltage).
> + *
> + * @min:  Lowest value in range
> + * @min_sel: Lowest selector for range
> + * @max_sel: Highest selector for range
> + * @step: Value step size
> + */
> +struct linear_range {
> +	unsigned int min;
> +	unsigned int min_sel;
> +	unsigned int max_sel;

It looks like this is not being used as much as it should. min_sel is never
read and max_sel is only read in one case.

> +	unsigned int step;
> +};
> +
> +/* Initialize struct linear_range for regulators */
> +#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
> +{									\
> +	.min		= _min_uV,					\
> +	.min_sel	= _min_sel,					\
> +	.max_sel	= _max_sel,					\
> +	.step		= _step_uV,					\
> +}
> +

...

> +#define MT6373_PMIC_RG_LDO_VAUD18_ADDR		0x1b57
> +#define MT6373_PMIC_RG_LDO_VUSB_ADDR		0x1b65
> +#define MT6373_PMIC_RG_LDO_VAUX18_ADDR		0x1b73
> +#define MT6373_PMIC_RG_LDO_VRF13_AIF_ADDR	0x1b81
> +#define MT6373_PMIC_RG_LDO_VRF18_AIF_ADDR	0x1b8f
> +#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_ADDR	0x1b9d
> +#define MT6373_PMIC_RG_LDO_VCN33_1_ADDR		0x1bd7
> +#define MT6373_PMIC_RG_LDO_VCN33_2_ADDR		0x1be5
> +#define MT6373_PMIC_RG_LDO_VCN33_3_ADDR		0x1bf3
> +#define MT6373_PMIC_RG_LDO_VCN18IO_ADDR		0x1c01
> +#define MT6373_PMIC_RG_LDO_VRF09_AIF_ADDR	0x1c0f
> +#define MT6373_PMIC_RG_LDO_VRF12_AIF_ADDR	0x1c1d
> +#define MT6373_PMIC_RG_LDO_VANT18_ADDR		0x1c57
> +#define MT6373_PMIC_RG_LDO_VEFUSE_ADDR		0x1c73
> +#define MT6373_PMIC_RG_LDO_VMCH_ADDR		0x1c81
> +#define MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR	0x1c8f
> +#define MT6373_PMIC_RG_LDO_VMCH_EINT_HIGH_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
> +#define MT6373_PMIC_RG_LDO_VMCH_EINT_LOW_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
> +#define MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT	BIT(2)
> +#define MT6373_PMIC_RG_LDO_VMC_ADDR		0x1c90
> +#define MT6373_PMIC_RG_LDO_VIBR_ADDR		0x1c9e
> +#define MT6373_PMIC_RG_LDO_VIO28_ADDR		0x1cd7
> +#define MT6373_PMIC_RG_LDO_VFP_ADDR		0x1ce5
> +#define MT6373_PMIC_RG_LDO_VTP_ADDR		0x1cf3
> +#define MT6373_PMIC_RG_LDO_VSIM1_ADDR		0x1d01
> +#define MT6373_PMIC_RG_LDO_VSIM2_ADDR		0x1d10
> +#define MT6373_PMIC_RG_LDO_VSIM2_LP_ADDR	0x1d10
> +#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_ADDR	0x1d57
> +#define MT6373_PMIC_RG_VAUX18_VOCAL_ADDR	0x1dd8
> +#define MT6373_PMIC_RG_VAUX18_VOSEL_ADDR	0x1dd9
> +#define MT6373_PMIC_RG_VUSB_VOCAL_ADDR		0x1ddc
> +#define MT6373_PMIC_RG_VUSB_VOSEL_ADDR		0x1ddd
> +#define MT6373_PMIC_RG_VCN33_1_VOCAL_ADDR	0x1de0
> +#define MT6373_PMIC_RG_VCN33_1_VOSEL_ADDR	0x1de1
> +#define MT6373_PMIC_RG_VCN33_2_VOCAL_ADDR	0x1de4
> +#define MT6373_PMIC_RG_VCN33_2_VOSEL_ADDR	0x1de5
> +#define MT6373_PMIC_RG_VCN33_3_VOCAL_ADDR	0x1de8
> +#define MT6373_PMIC_RG_VCN33_3_VOSEL_ADDR	0x1de9
> +#define MT6373_PMIC_RG_VMCH_VOCAL_ADDR		0x1dec
> +#define MT6373_PMIC_RG_VMCH_VOSEL_ADDR		0x1ded
> +#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOSEL_ADDR MT6373_PMIC_RG_VMCH_VOSEL_ADDR
> +#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOSEL_ADDR	MT6373_PMIC_RG_VMCH_VOSEL_ADDR
> +#define MT6373_PMIC_RG_VEFUSE_VOCAL_ADDR	0x1df0
> +#define MT6373_PMIC_RG_VEFUSE_VOSEL_ADDR	0x1df1
> +#define MT6373_PMIC_RG_VMC_VOCAL_ADDR		0x1df4
> +#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOCAL_ADDR MT6373_PMIC_RG_VMC_VOCAL_ADDR
> +#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOCAL_ADDR	MT6373_PMIC_RG_VMC_VOCAL_ADDR

Is there a typo here? Aren't VMC and VMCH separate entities?

> +#define MT6373_PMIC_RG_VMC_VOSEL_ADDR		0x1df5
> +#define MT6373_PMIC_RG_VIBR_VOCAL_ADDR		0x1df8
> +#define MT6373_PMIC_RG_VIBR_VOSEL_ADDR		0x1df9
> +#define MT6373_PMIC_RG_VIO28_VOCAL_ADDR		0x1dfc
> +#define MT6373_PMIC_RG_VIO28_VOSEL_ADDR		0x1dfd
> +#define MT6373_PMIC_RG_VFP_VOCAL_ADDR		0x1e00
> +#define MT6373_PMIC_RG_VFP_VOSEL_ADDR		0x1e01
> +#define MT6373_PMIC_RG_VTP_VOCAL_ADDR		0x1e04
> +#define MT6373_PMIC_RG_VTP_VOSEL_ADDR		0x1e05
> +#define MT6373_PMIC_RG_VSIM1_VOCAL_ADDR		0x1e08
> +#define MT6373_PMIC_RG_VSIM1_VOSEL_ADDR		0x1e09
> +#define MT6373_PMIC_RG_VSIM2_VOCAL_ADDR		0x1e0c
> +#define MT6373_PMIC_RG_VSIM2_VOSEL_ADDR		0x1e0d
> +#define MT6373_PMIC_RG_VAUD18_VOCAL_ADDR	0x1e58
> +#define MT6373_PMIC_RG_VAUD18_VOSEL_ADDR	0x1e59
> +#define MT6373_PMIC_RG_VRF18_AIF_VOCAL_ADDR	0x1e5c
> +#define MT6373_PMIC_RG_VRF18_AIF_VOSEL_ADDR	0x1e5d
> +#define MT6373_PMIC_RG_VCN18IO_VOCAL_ADDR	0x1e60
> +#define MT6373_PMIC_RG_VCN18IO_VOSEL_ADDR	0x1e61
> +#define MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_ADDR	0x1e64
> +#define MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_ADDR	0x1e65
> +#define MT6373_PMIC_RG_VANT18_VOCAL_ADDR	0x1e68
> +#define MT6373_PMIC_RG_VANT18_VOSEL_ADDR	0x1e69
> +#define MT6373_PMIC_RG_VRF13_AIF_VOCAL_ADDR	0x1ed8
> +#define MT6373_PMIC_RG_VRF13_AIF_VOSEL_ADDR	0x1ed9
> +#define MT6373_PMIC_RG_VRF12_AIF_VOCAL_ADDR	0x1edc
> +#define MT6373_PMIC_RG_VRF12_AIF_VOSEL_ADDR	0x1edd
> +#define MT6373_PMIC_RG_VRF09_AIF_VOCAL_ADDR	0x1f58
> +#define MT6373_PMIC_RG_VRF09_AIF_VOSEL_ADDR	0x1f59
> +#define MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK	GENMASK(7, 0)
> +

...

> +static u8 mt6373_read(struct mt6373_regulator *reg, u16 addr, u8 *value)

Needs to return int instead of u8 to pass error along.

> +{
> +	return pmic_read(reg->data->pmic, reg->data->base + addr, value, 1);
> +}
> +

...

> +static int mt6373_regulator_set_value(struct udevice *dev, int uV)
> +{
> +	struct mt6373_regulator *plat = dev_get_plat(dev);
> +	const struct linear_range *range = NULL;
> +	int i, max, ret, nranges = plat->info->n_linear_ranges;
> +	unsigned int vsel;
> +
> +	if (nranges > 1) {
> +		for (i = 0; i < nranges; i++) {
> +			if (uV < plat->info->linear_ranges[i].min) {
> +				if (i) {
> +					i--;
> +					range = &plat->info->linear_ranges[i];
> +					break;
> +				}
> +
> +				dev_err(dev,
> +					"Requested voltage (%d) is lower than"
> +					" minimum regulator voltage (%d)\n",
> +					uV, plat->info->linear_ranges[0].min);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (!range) {
> +			i = nranges - 1;
> +			max = plat->info->linear_ranges[i].min
> +				+ (plat->info->linear_ranges[i].max_sel
> +					* plat->info->linear_ranges[i].step);
> +
> +			if (uV > max)
> +				dev_err(dev,
> +					"Requested voltage (%d) is higher than"
> +					" maximum regulator voltage (%d)\n",
> +					uV, max);
> +			else
> +				range = &plat->info->linear_ranges[i];
> +		}
> +
> +		if (!range) {
> +			dev_err(dev,
> +				"Unable to determine proper range for value (%d)\n",
> +				uV);
> +			return -EINVAL;
> +		}
> +
> +		ret = mt6373_write(plat, plat->info->vsel_range_reg,
> +				   (u8)i & plat->info->vsel_range_mask);
> +		if (ret)
> +			return ret;
> +	} else {
> +		range = plat->info->linear_ranges;
> +	}
> +
> +	vsel = (uV - range->min) / range->step;

Should this round up? (I think that is what Linux does.)

> +	return mt6373_write(plat, plat->info->vsel_reg,
> +			    (u8)vsel & plat->info->vsel_mask);
> +}
> +

...

> +static int mt6373_regulators_bind(struct udevice *dev)
> +{
> +	struct mt6373_regulator_data *data = dev_get_plat(dev);
> +	struct driver *drv;
> +	char *name;
> +	ofnode child, node = dev_ofnode(dev);
> +	int ret;
> +	size_t namelen;
> +	u32 addr;
> +
> +	ret = ofnode_read_u32_index(node, "reg", 0, &addr);
> +	if (ret < 0)
> +		return -EINVAL;

Why ignoring the actual error return?

> +
> +	data->base = (u16)addr;

Cast is not necessary.

> +	data->pmic = dev->parent;
> +
> +	ofnode_for_each_subnode(child, node) {
> +		struct mt6373_regulator reg;
> +
> +		reg.data = data;
> +		reg.info = mt6373_get_regulator_info(child);
> +		if (!reg.info)
> +			continue;
> +
> +		namelen = strlen("reg-mt6373-") + strlen(reg.info->name) + 1;
> +		name = devm_kzalloc(dev, namelen, GFP_KERNEL);

Should check !name before using it.

> +		ret = snprintf(name, namelen, "reg-mt6373-%s", reg.info->name);
> +		if (ret < 0 || ret >= namelen) {

Doesn't snprintf() return number of bytes actually written, so could not be
>= namelen?

Also, it doesn't return negative error.

> +			dev_err(dev, "Failed to create MT6373 regulator name\n");
> +			return -ENOMEM;
> +		}
> +
> +		if (reg.info->id <= MT6373_ID_VBUCK9)
> +			drv = DM_DRIVER_GET(mt6373_regulator_buck);
> +		else
> +			drv = DM_DRIVER_GET(mt6373_regulator_ldo);
> +
> +		ret = device_bind_with_driver_data(dev, drv, name, (ulong)&reg,
> +						   child, NULL);

This is dangling pointer. reg is on the stack and the device will keep a
pointer to it. Even if it doesn't get used now, someone might accidentally
use it in the future.

It would make more sense to just past the static per-regulator info here.
And since the data is the same for each regulator, it can be fetched with
dev_get_plat(dev->parent) without having to make a per-regulator pointer
to it.

> +		if (ret < 0) {
> +			dev_err(dev, "Failed to bind MT6373 regulator %s: %d\n",
> +				name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mt6373_regulators_ids[] = {
> +	{ .compatible = "mediatek,mt6373-regulator" },
> +	{ /* sentinel */ }
> +};
> +
> +/*
> + * Driver for a 'bank' of regulators. This creates devices for each
> + * individual regulator
> + */
> +U_BOOT_DRIVER(mt6373_regulators) = {
> +	.name = "mt6373_regulators",
> +	.id = UCLASS_MISC,

Should be UCLASS_REGULATOR? UCLASS_MISC requires ops to be struct misc_ops.

Or I guess this is because this is binding to the parent node rather than
individual regulators. In other MediaTek drivers, we have the PMIC driver
register the regulators with pmic_bind_children() instead. That seems
simpler than re-implementing the same logic here.

> +	.bind = mt6373_regulators_bind,
> +	.probe = mt6373_regulators_probe,
> +	.of_match = mt6373_regulators_ids,
> +	.ops = &mt6373_regulator_ldo_ops,
> +	.plat_auto = sizeof(struct mt6373_regulator_data),
> +};
> 

