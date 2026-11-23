Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035E606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cdWh8ISa;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cjuy+5tL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4038C406E5;
	Mon, 23 Nov 2026 17:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZjbrDDThNMA; Mon, 23 Nov 2026 17:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CBC8405BB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455582;
	b=SFqVP01ntf+hDRBN+OM3iCFzi6Y7lKEqJbyiTU98NAO1sy8SrGYIv98MAkelGYX/XlWh
	 83fRqqO2Zf8V8KKfq7iWPXlDyiX7Kw2Fd2AnoW8ZjLAM8vBp8KhsKCzUZjPYYUyfKH33+
	 qM/n0ZiYh0SmWdnYH3W+GzZqH5b79Z8fXUr+8DhUD7I85Q5SsDQzn7Uf7LfeKjYN3MuGu
	 e2VUxGn621vSbeQJBUlNZ95RhzRC2Jlf5l9XS9swGmNUPCZhtKFP4ancjzN4ryAgWyeTO
	 5hwD7HAd9NFjF/vXY9fzNqgm7H8IAp83ig3+Eh3InT3Huw//N3TD9OvjA15SchCVBkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zKduW2/0JIQVO6seRLwnu13wcoRhBMT2KooWRQklm6o=;
	b=KI43h1Xkt8gqBfUkBkvIqNwwOw/ktobVY1NoowzeSEDyDtWYXqhHNa/mYc3g9QR/EXIP
	 KOBYxK36dzDc7hitluIzos+uSQnLNMNWyEUe5WZb7Hpbp0gwSOM/mEzHCzGVOf7/7jz0n
	 wkq+sHbzZ39w4pPpG5RjaGm0C0oQg0EuwkJOKtorm2mnQxKZ8/AD4+5dmI7XpC+uXaoho
	 9s5PIzWB/PaLJeYA7WAedK2aYnFo7wF2nVu/RO6z/l5gSmjc+CDr1yxS0Glpiew+Huqyn
	 hn2JzxA8lNqWn1FX4BQivBFDIfGky/rbl5HXQlaCKjbvURD8oMqvYS5t5edl2PLcoYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cjuy+5tL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455582;
	bh=zKduW2/0JIQVO6seRLwnu13wcoRhBMT2KooWRQklm6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdWh8ISaJ163w93lstUPwb7G0cne2nG/ojtqxbsoXuy/SRwC7/vWh8prtiN5F9cwC
	 RUSlWcmYbN9MFMOkfYjkK1ls/kPPckK6qbw7czVti25/CwG5euDgEOoKB1BcBwcNm+
	 VMKShx+DcWDQ1b1nwAEoaXTxntGSe2k+qP3yJOEviJAukEg3QEBTb6LThk8Y+8LO3V
	 6qV0azoSV0lHfs51t+56FZC3amJgFnY++TspjsC922SaLbjOuBFDYb3ONNw6W4N3GN
	 Udjm479+57XgWXF1GBSQpLmv5pf+Xt/6nbSLB9kGG28DoGHHnY7RH84F5W+oN1tXxr
	 9D4THSC07Yhcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CBC8405BB;
	Mon, 23 Nov 2026 17:39:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E64313A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D866C40662
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbMqLe0BGYbp for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A278405BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Cjuy+5tL
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A278405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:39:38 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c516a192844so223516966b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795455576; x=1796060376;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zKduW2/0JIQVO6seRLwnu13wcoRhBMT2KooWRQklm6o=;
 b=Cjuy+5tLtrpEzYn3jJdlIEF8ySnX4MGwdGh8icQezfVUsn/wGSOASgv1GiAR7+Mx3n
 enReD+hsMlHatqr/cpu4LEecjlqdf+752DYESOXKlt5hg04SiD6wLEB4OvQboT1CJxKk
 KGn1cc0eETqh752HIpAKwAdUcXxsqwrnj7wPzQq+q+nVmXbJh2sBncIIsTk/vm2NCB2Z
 cYVmB2zyuxvkWdot3vB26IXZWtvwRHWbnASvVoPVs5hYswvFMimsxbWzokoSNx8JOabR
 m5OTLroKPajXKF5Y4AJZvTIoDWGt7jMOseZRSnL9hZ1bhdruT26qBTdO5HIe2F6Yb6LM
 Hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455576; x=1796060376;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zKduW2/0JIQVO6seRLwnu13wcoRhBMT2KooWRQklm6o=;
 b=gVNfVdAhb8oZ8vtpf1YOmkdJTAbgwzd5VxKAL+Gh4476+eJe32IiV18HZDI4XfUVpx
 Is1owTn5/KHcAP5p//swxp08+EGnvSi2We7ZlSiklKSCohrMcDgYHTfCPsfVvzDAySKK
 c4N8ZOwCtyDU5Pk0cvxSNtpj9LdXiEyCSg0vxu4/dhVIrubSEX/AlIRDo9kssoxeKm2k
 Ae1yeupvU9ksqd4CiK0qGwk1wELtTQgd6OKp94uqMHQ2vzh7SBqWCoJG3jfy+PFupAbQ
 Bc6TXS1KVwU46rfDdqDYPw03MoRRhZdL9DzlFSdLHw7VOHN1uKeGMnEbdLNBE4IAZjY9
 3nEg==
X-Gm-Message-State: APuU4Z9esZtDPQTjKfaK1+WjOGnKJXO+n2BwXuIGA6eTeC7ezwfWlYrX
 Ev2KxwEatSA8LpyNGPIfBTY36n4SFqFy+4otoxYwyy53gC70T9Rt6w3gNrgyXQwMPKJ86+I4Sog
 dUwPOqFrfoLbhbt3cN7Hkk6u0XRq75mU97Hbc
X-Gm-Gg: AZFdTZdfpYIgJquQ8kjOfxlSNqOAGAKqywFM+ke6HvckiOh3/4/yXTYXeu+UHc73rQ3
 htH7rnH4JUaxakoJHXWOrD4PgO/8i56uC+MXmOG/VvXF1Hc/FpCWW0JOTnGT4Ba1Lzi7FFJGJc9
 G96hq5K1/OPC4tgoAvKIq4qR+l6s3DPiFCnePXqCDvxf2JMKBIhklZJXHIr/DbpJ9iMNIIjpcGg
 CbAeRVNJh6sWilsquKlIAVdSqMHw8nbqYK1RTtWgFTyEcnpY/3GgbGDy5tB8ohxf2FDLVH9Df86
 Zh7FOmtGKZzM3NCZIMX84VKo1pq6174Uu/iP+T+teH1UBCwI3h9KAShfj5Xlk8OLtyAwsgnWeSn
 VkpX49IemHYFyVIy+sFcVLUgXbB2/hRPvQKSN
X-Received: by 2002:a17:906:680c:b0:c29:f5d5:5a9c with SMTP id
 a640c23a62f3a-c513aaacfc1mr790945266b.38.1795455576001; Mon, 23 Nov 2026
 09:39:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
 <20261117-rk-doc-follow-up-v1-2-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-2-2cc0910f9455@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 18:39:23 +0100
X-Gm-Features: Aa3M54r3ETqb7Hm2RW8DQGzh2DI7Y2fODjeyyyL6M165m3t_tC8VokTxgrr7HkI
Message-ID: <CAC928HY55pmOvWOMqf8uoDK9a4tF=4XbJN-vc71X7jBABKDheQ@mail.gmail.com>
Subject: Re: [PATCH next 02/10] rockchip: be consistent on the "wording style"
 for MaskROM
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>,
 Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 10:19 Quentin Schulz ha scritto:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Jonas suggested[1] to have a single style for Rockchip's BootROM, so
> follow the recommendation and update all mentions to follow the same
> style. I've decided to capitalize MaskROM so it's consistent with
> BootROM.

I would suggest that you consider, instead, an alternative rewording, less
consistent with BootROM, outlining their different natures also through a
different "wording style" to avoid misunderstanding: the BootROM is an entity,
a piece of code, while the "mask rom mode" is a mode, or better a status,
that the execution of the BootROM reaches under specific conditions.

What I care about more is that "mask rom" should never be used without "mode".

Unfortunately, the original sin is in Rockchip's poorly chosen original
wording, and we cannot move too far to avoid further confusion instead
of helping to clarify. In the end I would probably go for "maskrom-mode".

>
> [1] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/mach-rockchip/Kconfig          |  6 +++---
>  arch/arm/mach-rockchip/spl-boot-order.c |  2 +-
>  doc/board/qnap/ts433.rst                |  4 ++--
>  doc/board/rockchip/rockchip.rst         | 16 ++++++++--------
>  drivers/clk/rockchip/clk_rv1126.c       |  2 +-
>  tools/rkimage.c                         |  2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 2dc45aa54077..fef5932844e6 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -751,12 +751,12 @@ config ROCKCHIP_SPI_IMAGE
>           is built by binman. U-Boot sits near the start of the image.
>
>  config ROCKCHIP_MASKROM_IMAGE
> -       bool "Build a maskrom mode image for Rockchip"
> +       bool "Build a MaskROM mode image for Rockchip"
>         depends on TPL || ROCKCHIP_EXTERNAL_TPL
>         select SPL_RAM_DEVICE
>         help
> -         Rockchip SoCs support maskrom mode boot over USB. Enable this
> -         option to produce maskrom mode boot images containing U-Boot.
> +         Rockchip SoCs support MaskROM mode boot over USB. Enable this
> +         option to produce MaskROM mode boot images containing U-Boot.
>
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>         default TEXT_BASE
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index d2dd5e10935f..2bcf9fab0426 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -104,7 +104,7 @@ void board_boot_order(u32 *spl_boot_list)
>  {
>         int idx = 0;
>
> -       /* Add RAM boot for maskrom mode boot over USB */
> +       /* Add RAM boot for MaskROM mode boot over USB */
>         if (BROM_BOOTSOURCE_ID_ADDR && CONFIG_IS_ENABLED(RAM_DEVICE) &&
>             read_brom_bootsource_id() == BROM_BOOTSOURCE_USB) {
>                 spl_boot_list[idx++] = BOOT_DEVICE_RAM;
> diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
> index 1e1bfbb91901..446c8ec8f2a8 100644
> --- a/doc/board/qnap/ts433.rst
> +++ b/doc/board/qnap/ts433.rst
> @@ -57,7 +57,7 @@ Image installation
>  ------------------
>
>  The Qnap thankfully provides an easily accessible serial header as well as
> -a very user-friendly jumper-header to bring the device into maskrom mode.
> +a very user-friendly jumper-header to bring the device into MaskROM mode.
>
>  To access both, the drive trays need to be removed. Looking at the board,
>  through the upper cutout of the metal frame the white 4-port serial-header
> @@ -74,7 +74,7 @@ Directly below it, the mentioned 2-pin jumper header can be seen.
>
>  To write your u-boot to the device, it needs to be powered off first. Then
>  a jumper or suitable cable needs to be used to connect the two pins of the
> -maskrom header. Turning on the device now will start it in maskrom mode.
> +MaskROM header. Turning on the device now will start it in MaskROM mode.

I don't know if the PCB has any a silk-screen printing, but if so, it
wouldn't be appropriate to reword. In any case, to be generic, I would
rephrase without citing the "mask rom mode", something like:

  +cited jumper-header. Turning on the device now will start it in MaskROM mode.

>
>  It is important that the jumper gets removed after that stop and before
>  actually trying to write to the emmc.
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 2dfbfa5f5f8c..60b190c198e1 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -333,16 +333,16 @@ Notes
>
>  * rk3036: SDMMC and the debug uart share the same iomux, so if
>    a SD card is the boot medium, the debug uart must be disabled.
> -* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
> +* rk3066: eMMC and NAND share the same iomux, so if in MaskROM mode
>    and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
>
> -Mask ROM mode
> +MaskROM mode
>  -------------
>
> -Mask ROM mode is the fallback mode of the BootROM,
> +MaskROM mode is the fallback mode of the BootROM,
>  in which it listens for USB commands 0x471/0x472.
>
> -Options to get your board into Mask ROM mode:
> +Options to get your board into MaskROM mode:
>
>  * Hold the recovery button, depending on firmware support or wiring,
>    while booting the board.
> @@ -352,7 +352,7 @@ Options to get your board into Mask ROM mode:
>  Methods of last resort (USE AT YOUR OWN RISK):
>
>  Short the following pins briefly while powering the board, so the BootROM
> -cannot locate any boot firmware and falls back into Mask ROM mode:
> +cannot locate any boot firmware and falls back into MaskROM mode:
>
>  * NAND: connect pin 8 and 9 of the NAND flash with a needle.
>  * eMMC: connect the clock line to ground.
> @@ -476,7 +476,7 @@ Note:
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
> -If all other boot options fail then it enters into a Mask ROM mode on the USB OTG port.
> +If all other boot options fail then it enters into a MaskROM mode on the USB OTG port.
>  This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
>
>  SD Card
> @@ -517,9 +517,9 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
>  NAND
>  """"
>
> -Bring device in Mask ROM mode:
> +Bring device in MaskROM mode:
>
> -If bricked and no Mask ROM mode shows up then connect pin 8 and 9
> +If bricked and no MaskROM mode shows up then connect pin 8 and 9
>  of the NAND flash briefly with a needle while powering the board.
>
>  Show connected devices with:
> diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
> index 018232dcb027..c80044c93308 100644
> --- a/drivers/clk/rockchip/clk_rv1126.c
> +++ b/drivers/clk/rockchip/clk_rv1126.c
> @@ -1724,7 +1724,7 @@ static ulong rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
>
>         /*
>          * the child div is big enough for gpll 1188MHz,
> -        * even maskrom has change some clocks.
> +        * even MaskROM has change some clocks.
>          */

What would this comment mean? I would drop it altogether.

>         if (rockchip_pll_set_rate(&rv1126_pll_clks[GPLL],
>                                   pmu_priv->pmucru, GPLL, rate))
> diff --git a/tools/rkimage.c b/tools/rkimage.c
> index 34f563f6a169..aa68ea792ead 100644
> --- a/tools/rkimage.c
> +++ b/tools/rkimage.c
> @@ -6,7 +6,7 @@
>   * rkimage.c combines the TPL/SPL binaries into a single image, sets the
>   * magic value expected by the SoC in the first 4 bytes and RC4-encodes
>   * the result if needed. The output is typically used as payload
> - * for the Mask ROM, uploaded via USB OTG or stored on a boot medium.
> + * for the MaskROM, uploaded via USB OTG or stored on a boot medium.

  + * for the MaskROM mode, uploaded via USB OTG or stored on a boot medium.

Regards,
Massimo



>   */
>
>  #include "imagetool.h"
>
> --
> 2.56.1
>
