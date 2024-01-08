Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54DCC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 09:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330B58793A;
	Mon,  8 Jan 2024 10:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CAHbSPNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB308793A; Mon,  8 Jan 2024 10:29:52 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDF0877DE
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 10:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 634c8058-ae08-11ee-abd4-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 634c8058-ae08-11ee-abd4-005056999439;
 Mon, 08 Jan 2024 10:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=60HQAItS5B8UMcOtFDMk5rfvY4s+xImhuWpHDROVesA=;
 b=CAHbSPNx8suEwyBZMRcFVSfrBmB8lgJ2yhdaDNQcte9zhxN+Mky16ckBzkOa4foIlJNgyixQTwTQQ
 6mobJNTC9C0QnLxaxZ3lDubjSun6rym0fSYQs2/DWKV9dzQpKqqEUe2BJkOfbm381SCwzwUx6/+9uB
 e/5dlnnvpF2it/pm69uLR3zxoj8NwGZ0qwN6DRNkuSF8rus43SVFrSHO4bF/JjbPEU6DrKY2IUtj5F
 OlMVp1/y7nqqDADIqjFK+aLb6g0FOKBglKHwL08e5/dhoJG+fdI3t7E4cJ3t6L+hYQAU7Txly0RkOq
 sBifSBjJppoX+1SOcAxUIPY7ogGPEAA==
X-KPN-MID: 33|qWy0mH9hQAERNZXfUxDC8iknBA2G3ewAcwxJENfbNs1xZaKFF3wE/dnYmCbtBSE
 +s4AJcU0CQ3/KSlVz7g6nUA3nvtrVnEO4QCU8rndtQtk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|R1NT+rLq6L4SwGS309Hxsna8VQAnZozOdsKviW6f0ukw0EO/14KQaw6oRO4EryU
 P1T6lX8taIeqffRUfZxmdfg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 78460e7b-ae08-11ee-ad2d-005056998788;
 Mon, 08 Jan 2024 10:29:50 +0100 (CET)
Date: Mon, 08 Jan 2024 10:29:49 +0100
Message-Id: <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, sjg@chromium.org
In-Reply-To: <20240108001455.35638-2-sjg@chromium.org> (message from Simon
 Glass on Sun, 7 Jan 2024 17:14:55 -0700)
Subject: Re: [PATCH 2/2] coreboot: Switch to a monospaced font
References: <20240108001455.35638-1-sjg@chromium.org>
 <20240108001455.35638-2-sjg@chromium.org>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Sun,  7 Jan 2024 17:14:55 -0700
> 
> The default font is proportional, with different character widths.
> Select a monospace font for coreboot so that the 'dm tree' output lines
> up correctly.
> 
> Update the coreboot tests to match.

To be honest, I think defaulting to a proportional font is wrong as a
default for something like U-Boot.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  configs/coreboot64_defconfig |  3 +++
>  configs/coreboot_defconfig   |  3 +++
>  test/cmd/font.c              | 12 +++++++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
> index 49c982ef756..c4571090859 100644
> --- a/configs/coreboot64_defconfig
> +++ b/configs/coreboot64_defconfig
> @@ -64,6 +64,9 @@ CONFIG_SOUND=y
>  CONFIG_SOUND_I8254=y
>  CONFIG_VIDEO_COPY=y
>  CONFIG_CONSOLE_TRUETYPE=y
> +CONFIG_CONSOLE_TRUETYPE_SIZE=20
> +# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
> +CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
>  CONFIG_CONSOLE_SCROLL_LINES=5
>  CONFIG_SPL_ACPI=y
>  CONFIG_CMD_DHRYSTONE=y
> diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
> index d4e44e00dca..7aa841bb54b 100644
> --- a/configs/coreboot_defconfig
> +++ b/configs/coreboot_defconfig
> @@ -61,6 +61,9 @@ CONFIG_SOUND=y
>  CONFIG_SOUND_I8254=y
>  CONFIG_VIDEO_COPY=y
>  CONFIG_CONSOLE_TRUETYPE=y
> +CONFIG_CONSOLE_TRUETYPE_SIZE=20
> +# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
> +CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
>  CONFIG_CONSOLE_SCROLL_LINES=5
>  CONFIG_CMD_DHRYSTONE=y
>  # CONFIG_GZIP is not set
> diff --git a/test/cmd/font.c b/test/cmd/font.c
> index 9c1eebf799e..ee1c610106d 100644
> --- a/test/cmd/font.c
> +++ b/test/cmd/font.c
> @@ -29,14 +29,20 @@ static int font_test_base(struct unit_test_state *uts)
>  
>  	ut_assertok(console_record_reset_enable());
>  	ut_assertok(run_command("font list", 0));
> -	ut_assert_nextline("nimbus_sans_l_regular");
> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_NIMBUS))
> +		ut_assert_nextline("nimbus_sans_l_regular");
> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
> +		ut_assert_nextline("ankacoder_c75_r");
>  	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
>  		ut_assert_nextline("cantoraone_regular");
>  	ut_assertok(ut_check_console_end(uts));
>  
>  	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
> -	ut_asserteq_str("nimbus_sans_l_regular", name);
> -	ut_asserteq(18, size);
> +	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
> +		ut_asserteq_str("ankacoder_c75_r", name);
> +	else
> +		ut_asserteq_str("nimbus_sans_l_regular", name);
> +	ut_asserteq(CONFIG_CONSOLE_TRUETYPE_SIZE, size);
>  
>  	if (!IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
>  		return 0;
> -- 
> 2.34.1
> 
> 
