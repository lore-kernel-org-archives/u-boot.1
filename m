Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECF8CA0ECD
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BBB83102;
	Mon, 11 Aug 2025 17:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBg5ZkuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5848883118; Mon, 11 Aug 2025 17:49:13 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40802830CA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so27529145e9.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927348; x=1755532148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaN/aMxeAvic2TkFt9SUzJa/+Zp0mhELgjX9980aLdI=;
 b=WBg5ZkuP5ihatYNt3hiEiL9F1vDFjxHTMkTk5th3dA1qLla1/RX7UlFTd10CNJeS5A
 dnlIDCT1ap3uGMF9e+rjmqGz+Bs73fB80Rsqlz4b85H4zJAHVb2/Edp/d5zrypg+WL6z
 5eG6oGxZyiCLBwaWvYUBqPHtmUgr55WExPLPTe3RQbGob+S9YyeWSFbs1rPImnClXsSy
 +3CW+Ztl/2wPO7KlT2P9wEXVSMQwvKbKZgI9h7v2oDEDmCxmFzLOQqQc3fGwmJ10Ylls
 7FTuLgnugmK3bgrPwWXsS2BdXChAOFLxBu2gYj7JtEpJCBip0fgsguAJpzp+lkZd3xcl
 loXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927348; x=1755532148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaN/aMxeAvic2TkFt9SUzJa/+Zp0mhELgjX9980aLdI=;
 b=oY4nocuC5Umii76m5JkC6LMr5pVUJman7CIdrH2H/mEWgtCj2gOGjJoHA2XVdmG65Z
 oqh58eul95pHQ2uZVjBWfxlAX0vbFyxPuUJMj5FBGZATbkim8PFyg4rS9Oj5xNSrVkUr
 0+sKG4Szw4mOucAWAojVaYNAEj8OvQrthMXqYKn+0nE8KlBZ4u4LYfQsXh4AmbgJAjVP
 YiD6rE5nmPRs952vDhb5Smoi7rcW5bTd44BXgjdcW+BDtIblYHqetnyIfZlAHiGVXT7O
 /1fO2wyS3XmN54dJL44+b1y35L1q+2ikYEs5xKAzNH4aeD2XoVPE+qP0MtAl+aTwIPRL
 nOQw==
X-Gm-Message-State: AOJu0YwOQSkn9Q6sIXkNMEcfGtGtPIUHDgQKIZ1J60w7YGBFF7YvqyrS
 2AJCTynkYVMR+gGNaXh+1zJRckkpamJpJc8Gmbd63u27wWvnSYygo62mnhNx9w==
X-Gm-Gg: ASbGncs3mClgsBj/IQ6Pp1YJR7ac8PCUT59ngoxb8/q2X2tZCZkgaB+t9Mg82UjrXi2
 zaQRomWZzM7xzXwUtt3jQlMaBb6x0AhDan8rP6px8hgp1n0QM5ciHOoPEOsLT4b0n2VVi73vwiz
 LbYx8+WQ9H0gl9S0O8+p9IA7feSyII0aMzdUiDwQZL0ZnrC6jMx/M0eARfS1IXpnESZ+Uk6Khet
 zyUC+wT2Zc0mHBWbIv6a0N2A3yEmSSQ9dSwXBBS3sLsK9HYy8fIJSgJ1squ2qsR4vdQ3KrR6iIa
 0ISI79q9je5RWVc578chFpzvM/aDETSXf5ESPoDqWhFiW04lpmhH7wVFDjimboP4+zA9rbl7zq4
 XCYKeU6bprpKgSpiMIGBIJ5INgDWvrCPstKwxUAqpS+IR9IuvNAZjlM1DIJJlhHF0ddco8EWtpg
 ==
X-Google-Smtp-Source: AGHT+IF8yaEb0JXZCQAYRhjt9mD68TKy30Kri4hWnVqeLz0qZ3mQZzXGJNEZQEgDX14gMmnLLo7j6Q==
X-Received: by 2002:a05:600c:840f:b0:456:19eb:2e09 with SMTP id
 5b1f17b1804b1-459f4eba76amr117620555e9.8.1754927347309; 
 Mon, 11 Aug 2025 08:49:07 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e584302csm280904685e9.7.2025.08.11.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:49:06 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] sunxi: H616: dram: fix LPDDR3 mode register settings
Date: Mon, 11 Aug 2025 17:49:06 +0200
Message-ID: <7836068.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20250801234918.19176-4-andre.przywara@arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <20250801234918.19176-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sobota, 2. avgust 2025 ob 01:49:18 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> The JEDEC LPDDR3 spec defines mode register 0 (MR0) as being read-only,
> so there is no point in trying to set its value.
> Also the H616 memory controller encodes the mode register index to be
> written starting from bit 8 in MRCTRL1 (for LPDDR3 and LPDDR4 chips), so
> we need to OR in that number to tell the controller which MR to program.
>=20
> On top of that, the mode registers between DDR3 and LPDDR3 are
> completely different, so writing values crafted for DDR3 into a LPDDR3
> chip is just wrong. Due to the above mentioned bugs the writes for
> MR0-MR2 did not have any effect (as they were all trying to set the
> read-only MR0), so the mode registers just stayed unchanged.

Nice catch! Looking at BSP DRAM code, it only sets MR1, MR2 and MR3.

>=20
> Looking at the LPDDR3 spec and the BSP code, let's write the proper MR
> values into LPDDR3 chips, using the proper addressing mode.

Please explain how you find those values. Are they always set in this way
for all boards using LPDDR3?

Best regards,
Jernej

> Use the opportunity to document the LPDDR3 mode register bits written.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi=
/dram_sun50i_h616.c
> index 877181016f3..3345c9b8e82 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -1078,18 +1078,18 @@ static bool mctl_phy_init(const struct dram_para =
*para,
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>  		break;
>  	case SUNXI_DRAM_TYPE_LPDDR3:
> -		writel(mr0, &mctl_ctl->mrctrl1);
> -		writel(0x800000f0, &mctl_ctl->mrctrl0);
> -		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> -
> -		writel(4, &mctl_ctl->mrctrl1);
> +		/* MR0 is read-only */
> +		/* MR1: nWR=3D14, BL8 */
> +		writel(0x183, &mctl_ctl->mrctrl1);
>  		writel(0x800000f0, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> =20
> -		writel(mr2, &mctl_ctl->mrctrl1);
> +		/* MR2: no WR leveling, WL set A, use nWR>9, nRL=3D14/nWL=3D8 */
> +		writel(0x21c, &mctl_ctl->mrctrl1);
>  		writel(0x800000f0, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> =20
> +		/* MR3: 34.3 Ohm pull-up/pull-down resistor */
>  		writel(0x301, &mctl_ctl->mrctrl1);
>  		writel(0x800000f0, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>=20




