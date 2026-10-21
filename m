Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBF606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rcrlgAb0;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E7sES1QI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C37608F2;
	Wed, 21 Oct 2026 12:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKJcMtP3EJ2Y; Wed, 21 Oct 2026 12:48:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8910608BF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586884;
	b=Swrs1x0GhdBv9IGGeJ9bAVWIpbI1soccym3oSbcTzP1ytQxKd+TmHMD2phpRALQsLF2V
	 QdiOeRWR5l1wZfH6ynw9iutjqwyqjq7CTnEM7XikqRzHgF0y5bhHuEDOzBuPavHDVOQ3W
	 YyBsHBj60lcBY4dasnOxU0oWzh5M0Hz/wXl3YL3zGWphkhfrYoGYwXqFoENFVIZbq5rlG
	 LQssI/FCDFdQwofdaGp/nazjb0MZpXVLDAyg/zWkf/iM6xKgawpNw4XK0xqu9fHvdOZyo
	 r97pQVoeQp+PcdAx44kcEebS+LHpEELL6wPcfjwVgHV2kZHPZ3q5ZyapG7UGMpKCm1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
	b=MZyLc3ERRWsIWwxErWxlvbEZySduleP2sFs/ALY3IRLorhuMobciNyOhh2IqE8xdqybb
	 +qxq/sWv6gV2VMEZveRKsKkY5AJP9YZrVJJjGuD6qTsNG9Gi5FPxoRQTwkYH7kX1P2f+p
	 Hzz8X+8L+B26Ovg1+qEEH1Fznz/ZeWijgL7nB+5WoxR0NVucnoKH/XSSsm35d4W95GLki
	 oihlqYKJsJfloyIE0DKXXFO8M1ZDcF7stHtqEfCwZclidpd/9eejqsVwxASwVUYD0itbg
	 kIK/KLogQk/7HuPSwajWMqJkk2/Iua9t1uiBUe5TPvQx/fpTkkyW8hPzE1rhZ8yfXug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586884;
	bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcrlgAb0wk9T2nq2xBi+bWw7KeFPFMEFLSO1pSe65yuFRpIl19+RVJSimspv6FUSw
	 kVl5c2SEfMyndFTGnywz4+0XEsaUkDr5iu1hYce9YcG5sw5eIc3eDEUMXeAXhzVH0U
	 61FOoMeEhHA/G7Dgcld/gxEh2bxYjUVBqW6SmyUagh1Pa8x/1LlySrEt4NpTET3FQh
	 Z1zFW4zfnefy9FKHT7AaHUlmqHRuZqeZxcVyMwVJ+W8CSvyOcBC1GRCj6/81Fi1Kee
	 03ucWJdNqf0yM0uIyJuKDPJCMgEQtBGqctV+NKMR0y7HlQYmJlg4X/anFLYz8f3/Cp
	 bUmXgZox6Z6Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8910608BF;
	Wed, 21 Oct 2026 12:48:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE8973AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4869810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VEZrK11W6bTP for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B084380FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586879;
 b=e1Rs2+wd2Z4Ufde5QHa07QE4LiOWw+e/1BQgDI33P8ra1xx+AejURVzKhOk6FqGODd/V
 eOZUITY0GpbeeAGqHsA1Ps3F++eY50m4R9pvV0srpxC0J+WzhjgUM12nZ8F2QA9Nq5vTN
 pAkQ48fsUxfOuqzKR62rxg6ao7zqdnN7EjVeVLuNE8KhjsKrUBA4RLmy5zgmcYs4Moemw
 y00GTjAe1jVMoU5Ctsu7UgZJwV3CQFiUASrsHlUft6eKKyWH1SdmVcDf1Fp0rg9XSX4tr
 do1Y4ceuQo4sFPWqO74iDbuXjOz6EOW8xufkR9IFoc7/7mOC/gqpuEIE+F6Lc403c/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586879;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
 b=gVjazdmPt4mNh3kE/Osqt6Vis3GETHJnO09o857ZtQz5aBRQ3dw57r1yvmRHyzRgu2sM
 Pu+FSF7c5tKm6ygJqTSuBpuC9uuFFkP7SJKteORq6NqL7GVUWv3ZpiIzS6pwuk1k8y38u
 de2Z9TSTCHVt5bw2LVTsM7PKW+Iq8gSY13rFGs8eaWkiZmD5DvNFmGdS9Ru3Q8PXPAkQS
 1FJoXowDzUfRjrD9llz403GORmFNq8BLnduOHNiwDig7PyDpEL+lKMl6zImfKGLPLq0sl
 UobQsU9CRejItCaCta1N89Zr547lZOa2Knn9LCYEMEoarAc6fGA8WNNN8gfoTyvPd0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E7sES1QI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=E7sES1QI
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B084380FFF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:57 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so420911a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586876; cv=none;
 d=google.com; s=arc-20260327;
 b=p0S8HqpKL1S7HIpnWXM/10XK+TUfroFVvIFO214AGr+BzxUZ4PduY8tscecZ6m+xdS
 LMZ09ZnpjnQcUdnXaccUW8XYXiRazVJI5YKY4M8T+xf5KiECPI88Z50hZQgPzbufooH7
 jbjzuP9YyIMpTUj5w/7s1ywDtUcWtp64pXvABwiJ0Ojg4VU/X5cFDVICAwQY7Fn2es4X
 r0a6tklcHLm6s8xP8aZ/Y1n26rEPWyD9EGejupNiAcW8gJkZfFocWUTbTs/WW93SaYH/
 7MIf19zawu6gHMaSweao7yVYye/8j+tgshkgl5IJ077Bx3bEsEclLVdQIjmJ8b5hQ9N1
 824g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
 fh=2RNABXrBNpbyQ5ILRnmEX5kxc9Ffe+QKK1McSEnthCs=;
 b=e6UvouDc/uEMisPmAP+2ImT1f0jprBDpyUbz3hrAwWwBC2+vtpeKPNygGP5hYZc8nu
 Z/qKGjkE37HOAzBFFJlkDyrEx4fY1c620TrWOpGlB4nTfxeb+9HcrHHMWorCyaBIrRgu
 6Phzzj/YRNWF2Zk0t4WovJP8uGyh4Zlzt4YRGCCL0omuF+AaxGV+5I5leUh1Y4QyURjz
 9udq3mz0Yz4D5ORzENyKuCx08xqSXttK+thWQTr746QX1MSpqp4u6yjeV84kf5Rp3S3B
 GjM8qew+T63QFEmT7ZULp6p4iw65vwEf4DAd5xavHZEoeg5TQrjWbV8Qgnu2jMoWnk7d
 fjkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586876; x=1793191676;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
 b=E7sES1QIRIuS0eBaR4FNTzgovuVJvRx/uekgFQbpFhhkwwh3mRaRqfIw8rFysSWB2R
 sWYFe36taIlVZDRZ6Cjwhrizj26aCUve6PlMxXvBWX8Pd8bJout+UBwGugG06lSTOtYn
 JqkshUYIKf7ID+H7Efw94vAPlotjKCHTjmTu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586876; x=1793191676;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9wU5r5U5XaBrhVG936QbC2no6jNc/JMdIXOaS+YuoWo=;
 b=w7JjHoDErZYBy7s6up1BJDOmqG0LgSymvjEgC3We34n0Te3ItkYf58DTgmLzQNqaqr
 w62WdGu6CQ4F79MlNNIeLfWG72eHgGPtdTsl1U3SpMWRkvaDhrlfmc7y9ApBeRARK6HF
 ejcK/jtMsz/8xiu2Z4i8Ydfps04BvgPB81biBPuQ6aDn40P0PKts50VvcJ4zvwA9NTV6
 yn2ZNDsCBhYkl4VNgebSlsZgmaQ+njXfk5euGIU/TMiB7EhUfuznwBLJWrMzGika8/tj
 UCODVw/BdyUMjKQm3cv9bDKs3eEtAdsJk5C2Dmkvn0VDe1JTItEOmSucmfPOcpAaXZmp
 YlMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztYnisiNuJvmAvOmrShvpULFtCi5dtThsGui30YSoQjH6RIJ1dGPRu0nNdFtk0b+H0uC3uaDQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJi0QELEhQVHQtmYmR/LCTA5FuZiy64I5b3H/JQ+Tfh5r3ReBAT
 kDTx/Dk4gMVbsrGK1hPa7TzDzn2NClNkpZTIf8lOzeA/m2hgjCWhqmpKzbzDbtyV6Qz55sMHLyC
 frnCQfmqT+6C9CU5/Ps6Uj4stK7p9sFWdd+n6IWDx
X-Gm-Gg: AYBFou0zuVNUpota98hVfoKoAmv1uXNTCON1bb6U1GLVg1qEBlJklWPOF2WJK+GVy2s
 PIc6Z3vFVFC8GVwGBT3chbXeOXBp7bXtpS5+qZPOdtkJ1GEWaM1jH0UtE6YIiu9yW29Ts1PEMRz
 HOyvDpn60k6O2m92N6gTVVIwS4ymA5298mKhD34kQkFrwSta9oe/0QHF25gFVIvtcoGIulveyzJ
 1QC8744vKPmK9rQIqS8WVHjjkl8Y5DPtTc92lQ6s/G7PrvVLYuBpCAi/lpk8HmDaEohoEs53IVr
 O1H6kWLD9ELy2X9cqoZs8TB27xXP3tQiPkeZiXUMI2z5tG134G92hMkSvDxKQ94iLf9wIAt2YI3
 w7RF2AJZpQ9Op0uuM6MSHSMCKPvuVVeUKaA0=
X-Received: by 2002:a05:6402:4605:b0:6ac:73f8:2e4f with SMTP id
 4fb4d7f45d1cf-6b408ec96d4mr1202565a12.29.1792586875970; Wed, 21 Oct 2026
 05:47:55 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 12:47:53 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:40:35 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902211501.127915-4-bhargavdas100@gmail.com>
References: <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-4-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 12:47:53 +0000
X-Gm-Features: AclHuK8nvuCta1vRqV8Xj_1c8fTUtJIUFIH9JbEKc6pwyD9MsByAQK7xyzWfIhg
Message-ID: <CAFLszThHH8hq0B7VDt5m_akKegQ4p-JUrHSzEcRdbBvNg0=WPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: raspberrypi: Add Pico 2 support
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bhargav,

On 2026-09-02T21:14:48, Bhargav Das <bhargavdas100@gmail.com> wrote:
> board: raspberrypi: Add Pico 2 support
>
> Add board support for the Raspberry Pi Pico 2.
>
> UART1 console is functional as of now.
>
> misc_init_r() sets a fixed value for the "serial#" environment variable.
> This fixed value is hardcoded as just a placeholder to confirm that
> evn_set() works post-relocation.

Please can you drop this, along with CONFIG_MISC_INIT_R? 'serial#' is
meant to be unique to the board, and 'SC1631' is the part number, so
every Pico 2 would report the same serial number. Setting it from OTP
can come later. (BTW 'evn_set' should be env_set() )

>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
>
>  board/raspberrypi/pico2/Kconfig     | 15 +++++++
>  board/raspberrypi/pico2/MAINTAINERS |  9 +++++
>  board/raspberrypi/pico2/Makefile    |  3 ++
>  board/raspberrypi/pico2/pico2.c     | 81 +++++++++++++++++++++++++++++++++++++
>  configs/rpi_pico2_defconfig         | 29 +++++++++++++
>  include/configs/rpi_pico2.h         | 36 +++++++++++++++++
>  6 files changed, 173 insertions(+)

> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <dm.h>
> +#include <env.h>
> +#include <init.h>
> +#include <log.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <asm/arch/rp2350.h>
> +#include <dm/platform_data/serial_pl01x.h>

As far as I can tell, dm.h, log.h, asm/io.h and serial_pl01x.h are not
used. Please can you drop them?

> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,81 @@
> +int dram_init(void)
> +{
> +	gd->ram_base = RP2350_SRAM_BASE;
> +	gd->ram_size = RP2350_SRAM_SIZE;
> +
> +	return 0;
> +}

Patch 2 puts the memory node in rp2350.dtsi but nothing reads it.
Please can you use fdtdec_setup_mem_size_base() here and
fdtdec_setup_memory_banksize() in dram_init_banksize(), as the stm32
boards do, so the size is only defined in the devicetree?

> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,81 @@
> +int board_early_init_f(void)
> +{
> +	rp2350_soc_init();
> +
> +	return 0;
> +}

The XOSC/PLL/clock setup is the same for any RP2350 board, so I'd
expect it to live in mach-rp2xxx (e.g. arch_cpu_init(), which only
needs the clock setup, not the MPU code) rather than in each board
file. Then any other board using the SoC gets it automatically. What
do you think?

> diff --git a/board/raspberrypi/pico2/pico2.c b/board/raspberrypi/pico2/pico2.c
> @@ -0,0 +1,81 @@
> +int board_init(void)
> +{
> +	/* Nothing special needed post-relocation for basic shell */
> +	return 0;
> +}

If there is nothing to do, you can drop this function and disable
CONFIG_BOARD_INIT in the defconfig.

> diff --git a/configs/rpi_pico2_defconfig b/configs/rpi_pico2_defconfig
> @@ -0,0 +1,29 @@
> +CONFIG_CMD_TIMER=y
> +CONFIG_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_EMBED=y
> +CONFIG_NO_NET=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_PL01X_SERIAL=y
> +CONFIG_TIMER=y

Patch 4 says that with CONFIG_TIMER enabled but no driver, the 'timer'
command and any udelay() crash. Please can you enable CONFIG_TIMER and
CONFIG_CMD_TIMER in the timer patch instead, or put the timer patch
first, so this commit doesn't produce a board that crashes?

With DM_SERIAL and stdout-path in the devicetree,
CONFIG_SPECIFY_CONSOLE_INDEX should not be needed.

> diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
> @@ -0,0 +1,36 @@
> + * Flash (XIP):  0x10000000 - 0x103FFFFF (4MB on Pico 2)
> + *   0x10000000  Second stage bootloader (256 bytes - handled by ROM)
> + *   0x10000100  U-Boot image starts here
> + *   0x100F0000  Environment storage

This looks like the RP2040 layout. The RP2350 has no boot2,
CONFIG_TEXT_BASE is 0x10000000 and the environment is not stored in
flash, so the comment doesn't match the code. Please can you fix or
drop it?

> diff --git a/include/configs/rpi_pico2.h b/include/configs/rpi_pico2.h
> @@ -0,0 +1,36 @@
> +/* Flash geometry */
> +#define CFG_SYS_FLASH_BASE		RP2350_FLASH_XIP_BASE
> +#define CFG_SYS_MAX_FLASH_BANKS		1
> +#define CFG_SYS_MAX_FLASH_SECT		64
> +
> +/* SRAM */
> +#define CFG_SYS_SDRAM_BASE		RP2350_SRAM_BASE
> +#define CFG_SYS_SDRAM_SIZE		RP2350_SRAM_SIZE
> +
> +/*
> + * Stack / Malloc
> + * Stack at top of SRAM, grows downward
> + * Malloc heap immediately below stack
> + */
> +#define CFG_SYS_INIT_SP_ADDR		RP2350_SRAM_TOP

Most of these are unused. The flash ones only matter with
CONFIG_MTD_NOR_FLASH, nothing uses CFG_SYS_SDRAM_SIZE, and
CFG_SYS_INIT_SP_ADDR is ignored because the defconfig sets
CONFIG_CUSTOM_SYS_INIT_SP_ADDR. As far as I can tell only
CFG_SYS_SDRAM_BASE has an effect, so please can you cut this down to
just that?

Regards,
Simon
