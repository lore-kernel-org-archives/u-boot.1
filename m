Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F60C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 12:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FC7848EB;
	Tue,  7 Jul 2026 14:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qlykWQpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CC28496E; Tue,  7 Jul 2026 14:25:26 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABA584852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so516701b3a.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 05:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783427122; cv=none;
 d=google.com; s=arc-20260327;
 b=AtyYQxjPI2hPzF2oerEFt1YDrCcoBblDj9Ug+an2+ljQBTPNiCLb7OVaZ2B3rD+usY
 l2Rf3amTUOQyDIfbvdPmGEAfYDLSZ8mdDPFi1AXoH1MEn7RG/psEZe7ofcVeHAwsFRp1
 XvMKNEnCHc8+vK99Zdtw6su/ffXr5bQ2IL6Qd/OL0rzUrarILtHoY5TI+Eu0hDFF6bE0
 KJybX84xTnoBPuqYGLRhgvWIwKi3k7KYiBXiNgmmCulIDmO6Mw8sOD10moOcZArzM1j/
 B4TRoH5cVPMhT4wysBBvJdKYZE1Byzzbr8+HFD7Ws/xlf595KeQi3gAlnj0tqYbO6+ai
 SxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vMSxfTrIRSxkVvZZAv9lRQ7Yz3Wsp7s0c93GIcsSzBs=;
 fh=TzPS7AI1kBn/rnhjDKdJjQ40qHusjSKplE9KvUlGcDU=;
 b=nNsCiWDd8tSlQsqpTLG5dfBJQ1n+tI2mFYrVlm0jWi4tQgdBU/hA28nswsJpSH7EKL
 rwE693yfHBmJ44MdhCJVTMrKq5kOYKbwZMji9oJfoiwMVZrlCz4cLlNl8qO6EtfeuSOw
 qwckdmY+DLlEX9OQK77SM/ACUguA2ob/S9oEkMzhxx/Xa695jcib+zKjgeGUO4EXAND5
 SksgezmtTbjS2VIS0If7bm+rvcj3/AieZ+l5JVt5IGGYe7U19eh0SQGl8hp6+XaTRIpr
 U0djQ4iomfpEiUKRU3n59i9QnpFcCkMelucrh+3TR4dXbrZm2brNA+/va6x463+NkyH4
 r6pQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783427122; x=1784031922; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vMSxfTrIRSxkVvZZAv9lRQ7Yz3Wsp7s0c93GIcsSzBs=;
 b=qlykWQpd4lnxEdV858lBw6nAXy5eQMHIvuYUZz5Y7+9ZUfKwug+1Xzw5T7WOPIVfM1
 m1kiusyVo1ZZbsRTbzzWVy/gYeQbw3ldWtvaGqlXLed5jzE+fidvd1CHg+Aly1fyj2mq
 8/elun8UhK0mmmDcMY37hks/VGUNHGBPi/0lzSPzevCtE9rfX9hEHpOyI/ugWWNruOZm
 x7ZSOSywcjSFkRyDmviRrnL7lpQZmQHn4BpSdrwTrWf3/jSeJ1W6nsaeeQhKX9OADyiA
 1qpJvgBrjcGy+YYHR3g5uHAwvSsm0GfjGdl/PKTYbt7tLVj31dMzSny2e2C2aky7zlwA
 PXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783427122; x=1784031922;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vMSxfTrIRSxkVvZZAv9lRQ7Yz3Wsp7s0c93GIcsSzBs=;
 b=iuH/jDsaVu43dir2x7WRxBUhwAYWdirnJK5tbwUHF0NWy052jwjhpCVEsh0sPXhFkZ
 STe3qpWrBfZmnK5et25APjS5znxDN3X18OUOuZoYxub0qkZ9sN7kPX0+iigfc45UQTFs
 eP21POR0+URWJtNNEabcT5vBl5Bwf2OaojrFHQ9l6hJIjXFmMD0sUhxqvg9y36ZlNgF9
 GklkmQyks1HuiNBL0CI2UMvTCZM/sk8BecW5mvZQIbGc5oRyRS783QABMYwmM4beEahI
 wFv4v0ICjUHfaxKTABdrAQg9WaDjIfpDDiPj1iDwbILh5WYCa5MkpeUvtoDkHpQtWr9T
 E08A==
X-Gm-Message-State: AOJu0YyZXvoMZ6R1eTlsdTbJEdc3JnzYWQHH6aYGvAiqpB3PNs0aKAdN
 y21FLKzP308ucfW9rnQwMSXSWC/o719HwEgUz5z8vKuRo/dPo9DJziuXyunQ/GHOjjceG7nMVry
 DYMxsGoldx+9ITpjSoC+Cz0ecidRQtrbHNBAW
X-Gm-Gg: AfdE7cl05DqC9ZNOc7cJ8T9HHUfVbGvAOJbjHWIvoBS2B8U6PNujLvdYHpc7CMlgnTR
 JA8qoHrGAJVXv1LMpUqFtGIO2vJ/JU9i3snekex7yh/LKv1Jf+66nKWkDRaP2R/7GD6fV5ojNCk
 R5IvvX5TEwbAq0V0Av1ND9pm3mU+ACiRVMNBGSqfBACjwwkDa/njYah3VGM2f9gSJM+zbu5/DrN
 C9ODOQury/QhLIux5COKMcUlfTFYl9n/1ZC3GEW2U/O3Js6nWiSdq5WsFRaJ1mbvi9mCXAV
X-Received: by 2002:a05:6a21:3986:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c08ed5527dmr6084189637.25.1783427122020; Tue, 07 Jul 2026
 05:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
In-Reply-To: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Date: Tue, 7 Jul 2026 14:25:09 +0200
X-Gm-Features: AVVi8CcUYYv3ftF-23EUMACRo03HbNRBA4uz8PvPHNK26AO3RXAMJoJUS9xFjrk
Message-ID: <CADU25KJ=F2z3eE3zr6Xk=Np_OH7t++p5DVAbA3BxK2nR7eKUHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] rockchip: odroid-m1/m1s/rk3566 watchdog support
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

a gentle ping on the v4 rk356x watchdog series.

Please let me know if there are any remaining concerns or if this is ready
to be picked up.

Cheers,
Andreas


Andreas Zdziarstek <andreas.zdziarstek@gmail.com> schrieb am Mo., 29. Juni
2026, 21:23:

> This series makes the Synopsys DesignWare watchdog usable on rk3566/rk3568
> and enables it on the Hardkernel ODROID-M1 and ODROID-M1S.
>
> On current next the dw-wdt driver already probes (d62801d09441), but a
> timeout or "wdt expire" still hangs the SoC: CRU_GLB_RST_CON routes the
> watchdog to the second global reset by default, which causes a hung SoC.
>
> Patch 1 routes the watchdog to the first global reset instead, same as
> the PX30 implementation. Patch 2 does the same for the TSADC, so a
> thermal shutdown also resets the whole SoC. Patch 3 makes the dw-wdt
> driver the default for the rk3566/rk3568 family. Patch 4 enables the
> watchdog (wdt command only, no autostart to be non-breaking) on the
> ODROID-M1 and ODROID-M1S.
>
> Verified on the ODROID-M1S (RK3566): a watchdog timeout cleanly reboots
> the board.
>
> Changes in v4:
> - patch 3 (new): imply DESIGNWARE_WATCHDOG for the rk3568 family instead
>   of enabling the driver per board (review comment by Jonas)
> - patch 4 (was 3/3): enable the watchdog on both ODROID-M1 and M1S, not
>   just M1S (review comment by Jonas); dropped Quentin's Reviewed-by as the
>   patch changed
>
> Changes in v3:
> - patch 1: keep the glb_rst_con write inside CONFIG_XPL_BUILD (review
>   comment by Jonas)
> - patch 2: fold the WDT and TSADC bits into a single glb_rst_con
>   read-modify-write instead of two separate ones (review comment by Jonas)
>
> Changes in v2:
> - patch 1: access CRU_GLB_RST_CON through the rk3568_cru struct, matching
>   PX30's arch_cpu_init() (review comment by Quentin)
> - patch 2 (new): also route the TSADC to a first global reset (review
>   comment by Quentin)
>
> On the TSADC (patch 2): while checking how the ODROID-M1S comes up, I
> noticed the rkbin DDR init (probably, at least I don't know what else
> could set it at that stage) already sets the TSADC bit in CRU_GLB_RST_CON
> before U-Boot runs. So, on this board the patch is effectively a no-op. It
> still seems right to configure it explicitly in U-Boot rather than depend
> on the firmware blob, and it matches what PX30 does.
>
> Jonas: Per your note, v4 treats the dw watchdog as a SoC feature. Patch 3
> implies the driver for the rk3568 family, and patch 4 enables the command
> on both the M1 and the M1S.
>
> Andreas Zdziarstek (4):
>   rockchip: rk3568: make the WDT trigger a first global reset
>   rockchip: rk3568: make the TSADC trigger a first global reset
>   rockchip: rk3568: imply DESIGNWARE_WATCHDOG
>   rockchip: odroid-m1/m1s: enable watchdog support
>
>  arch/arm/mach-rockchip/Kconfig         |  1 +
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 11 +++++++++++
>  configs/odroid-m1-rk3568_defconfig     |  4 ++++
>  configs/odroid-m1s-rk3566_defconfig    |  4 ++++
>  4 files changed, 20 insertions(+)
>
>
> base-commit: 835a18f80f25731dc818bf9b771bfa111ea3dbeb
> --
> 2.53.0
>
>
