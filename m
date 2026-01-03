Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231B4C2A063
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 23:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6B383981;
	Sun,  4 Jan 2026 00:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Izyqueo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE7683AA4; Sun,  4 Jan 2026 00:41:30 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B0383956
 for <u-boot@lists.denx.de>; Sun,  4 Jan 2026 00:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59583505988so1454034e87.1
 for <u-boot@lists.denx.de>; Sat, 03 Jan 2026 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767483687; x=1768088487; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSWKR8PV1r6v5J/oFBgubTFEm5r7u6VeJfgQw3T15WY=;
 b=Izyqueo+old/SDYinCTZCpec99+NsmObyju+841X0zV7Pxv9dPp9ab0erP8W5ElUTL
 PXDv5mTv7SwVpNR8ayt+C6aiIXaRtT/qAX7IVtjwc9/yM8RZQRWASOLa6b2JW7pJFY4u
 bAlB3ylUnuMrxBxrUdnZRsiGBskajqmo1DLzVM0+7QrgdJiwpVpJXBktW3Y8pC4r0f97
 +x8Duw05fn4gpW/7QIFvUp4edAVkEylg7L8NWJcVeTDoyHFlX/hkRWOhtaNSbmP7m4RI
 WoqaN1CrG5cjkgrdlmtE1BYAyW2685f12mfaNSBHyh3K5i2+6jGMGNeoyYQk8G3aEs7g
 UIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767483687; x=1768088487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSWKR8PV1r6v5J/oFBgubTFEm5r7u6VeJfgQw3T15WY=;
 b=S1z88JyLuM0mn5DYNIZhNiJesffqqBHJtbMhlfNLhAJ63cebfAGCtWkelmjFVyiyey
 R61L8dk37SyJ9iHKeMHQZXCIr2fGyxKvh66wMORagDpayBdQn9fPoQr3KiIiEaY6XRvM
 vyMxxVht6V5eTqP5f67LDDt2iBK4jEBwXx1gB03XoItDNZrwoBzFTvVP6wFtzyZNSPzC
 el4ufYCNaqA6b6COtZap8Di0u1BAtjBFtaf1t42nlPplfw20aZ93KK2W0ix2aBXGRdI3
 yhuu7DH1NGgRjzW5haPduZlx8/+0Z2F6g7unp6ARkLPkf903u3a4FFhhTD4uuO/I/cWw
 VRnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbL6oHA+mtyk9CA7ULP331G1TRzYFBeFLX9Hvys53b/1xpupcWW21oSwffs2YMtZHcm4aXxyg=@lists.denx.de
X-Gm-Message-State: AOJu0YyCvcQ+X3R5k4H2bgihxi0dFGRurklDiZtWVL+62Ga0f9VNhiRe
 monawGBQT+xUMpQ5cVkLzNnW0k/78HSLhLEDuBetYAZcBCcSa9Bi+Kb3TKX0RAwngsMypzIho2m
 e2NlrjY7LGASlKHB5p2o3rY4Su0chjA4=
X-Gm-Gg: AY/fxX4fi/xlYED0j0EPewm7Clc2RudXLx5bhIX/Jd2GFh6kr10iV+5VwcHbrQ+FEpa
 NXSj3J2BKEuVo3gETv3HIelTjcHOsHUvkLExoF8PVDKfFOIPFNtyolI/RWO5FlTZFiWEyw+rOfT
 22VOIX4rQ3iikqQcIiGFTzMeqCx7+zwJE9hF4ZM5O4isK2w+AGkpyJHE2Jvmkh9jjG2nuxLDazF
 bQNqPIJNXoyygPOFQWBiQMpMNv2WrceA8btQk+uwwhDe/opnk3kksx7XAdldkRDtKZbpay05WNL
 jocsIq/FEAsngnFtVsxdvkSzePPEf1VhVX8SFw==
X-Google-Smtp-Source: AGHT+IEz4MfwrxNwdhzNhgXgg3BXvJQ5yqM6TNT/VVQXwqWN+Ahyeesm+pRkTK6S7wU8XCSIZpuN71r+/8UF2hKAbNw=
X-Received: by 2002:a05:6512:3a93:b0:597:d6f0:8810 with SMTP id
 2adb3069b0e04-59b56584763mr1188519e87.1.1767483687169; Sat, 03 Jan 2026
 15:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
In-Reply-To: <20260103-imx93_frdm_tcpc_fix-v1-1-d7ef892697eb@valla.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 3 Jan 2026 20:41:16 -0300
X-Gm-Features: AQt7F2qg-r_0WXPTHQUPVYEZjipGbeum75r6x1TD0prqjWOB1CaEHq8SOyhIjyw
Message-ID: <CAOMZO5CNeWPs2w6VED_PopU=UXHnG6oxZwKMxu6FdFeCRimC+g@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: clear and mask TCPC interrupts
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Fabian Pflug <f.pflug@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Francesco,

On Sat, Jan 3, 2026 at 6:22=E2=80=AFPM Francesco Valla <francesco@valla.it>=
 wrote:
>
> One of the two on-board PTN5110 TCPC USB Power Delivery controller on
> the i.MX93 FRDM board shares its interrupt line whith the PCAL6524 power
> controller (GPIO3-27). Since the PTN5110 starts after POR with the
> interrupts enabled, this can lead to an interrupt storm on OS startup if
> only the driver for the PCAL6524 is loaded, because none is servicing
> (and clearing) the interrupt requests from the PTN5110.
>
> Maks and clear all interrupts as part uring board initialization; they
> can be re-enabled later by a proper OS driver if required.
>
> Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Interrupt storms have been observed during the Linux kernel startup on
> the i.MX93 FRDM [0], leading to the IRQ functionality being disabled for
> the involved IRQ line. Even in case the IRQ line is not disabled,
> several thousands of interrupts can be observed:
>
>  94:      55749          0 gpio-vf610  27 Level     1-0022, 2-0050
>
> This has been traced to the interrupt sharing for one of the on-board
> PTN5110 TCPC and the PCAL6524 I/O expander. The same behavior was
> observed and fixed on the i.MX91 FRDM [1], so the proposed solution
> is the same: to mask and clear all PTN5110 interrupts during board
> configuration.
>
> With this patch applied, the interrupt line is completely silent on
> startup:
>
>  94:          0          0 gpio-vf610  27 Level     1-0022, 2-0050
>
> I added the Co-developed-by tag giving credit to Joseph Guo since the
> technical solution is theirs, as developed for the i.MX91 FRDM.
>
> [0] https://lore.kernel.org/all/20251230171548.67289601@windsurf
> [1] https://lore.kernel.org/all/aTDyW8Rm1u6hWUuc@lsvm11u0000395.swis.ap-n=
ortheast-2.aws.nxp.com

Thanks for your patch.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

It would be nice if Thomas could confirm that this fixes the issue he repor=
ted.

Thanks
