Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0F606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZsLfC8t4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bgf9DKYG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3072D81170;
	Wed, 11 Nov 2026 13:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxNpXkHEGAWK; Wed, 11 Nov 2026 13:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E320E811A9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402848;
	b=eawreBVTKlCrxAQLzUe8Y5eZsyZSEc2nO518sZlsrdKo2PgwIkXf/aZRZtq7Qh2hFwv+
	 MEggOZ2S3tKH3m2mXvkdz9//E1KOqK4sLBsZ/C9ge8KD5TAcrZrZLvAuGOxGHBzA9fLdJ
	 yq+xJYjAZ62TEZWhwHZ9aos0ibHHPjBLjUYnwDlMcOr+b7Q2gRplziy51XhFEX2aZ0hxa
	 2opgA5nI5dzMRjRcVykF+c3kj0E8qqi6x8AQRTTmgEOhmCnYDBhOBzKc7Ns8kUmdiVOgM
	 dZtLtAd5m/ZV8cjtd7QhEIf3MpzqkNL8LqrW1im3IBIVokZINXU89PumiXeIRDujXSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x1uAj5qJXr5sVqt+jkYScee8edg7YSR0yphLBVOEddg=;
	b=bBZ+bHZvPdwtmp9XnxnSM1qDKnISFwuHz46Dr24KSE+4U3izrf4Q7fXP+Fh27GbcsFIZ
	 YQZc2ZOC1ZoB4ZmtBdA4KT2j0XYvCmssUu8jLYlJdKuuwVqNDpeFjK+ttTckJJ02t8JA1
	 xWoVKOor9NsPJpVlJSJl5UNkY4FcigLb/2Z/i9wq1e7ZSk8GPDX1DokCrH9geNNTT9aGH
	 vlogJiT6RQPsl/D47zQX4pg50eHxHSdvTQSC5NggFrBINMXbbpnDN8XM7cKFhpqf6RR7p
	 TyoikOG2wMCOGO5sdOGg4hTE8bQ1qM019ekDH3dCG2jYntPi850LzNF1zIoepilxDig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402848;
	bh=x1uAj5qJXr5sVqt+jkYScee8edg7YSR0yphLBVOEddg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZsLfC8t4JgFf+WKtcjUL8TsidjEN4KnfHs5ZLIW8ZCfHEb3S4y4nyJkguU8sZymwX
	 COouIRB6XUV4kYQ1JeVBxIl6ag7jyY33ywazrJHYGXznEUMqUwx/qt5hD9gVjETD7E
	 gsUmBti7Y1Kbu+ruSQLqjlcH4E/aoJa6fEvvv2BtDS0KhAftLZkP2Wshp9AkNxtkee
	 /6vkaGqLOnITHwO4fS2YJ9lR8B6roSOSFLEz27SahKuYwXOuMTA7re77sIfRGIMfin
	 ny2I2P1nfVqsARGiz6Erp2dJS5ibQmooI+rZ2RXcbDWB1rgzrwMv1+sORZ8qThYK8w
	 A5+aXg/bV8xwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E320E811A9;
	Wed, 11 Nov 2026 13:14:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F1E917CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77F4B60A92
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70dW1x4ReJjE for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 03:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E24EA608AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bgf9DKYG
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E24EA608AE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:05:25 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67bf27f179aso2849422d50.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 19:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794366324; x=1794971124;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x1uAj5qJXr5sVqt+jkYScee8edg7YSR0yphLBVOEddg=;
 b=bgf9DKYGzxBVa+Tjri7245M3pc28DcUxFIM+nn2ZMwuzNqv9TUKwqXgOBrgVuacMk8
 SmS6K6TOsEkCiuBpj5AaPsbLJcjzi/54thsXOHsimbDw1XB/iRcNqDmoCfFaD5949h8W
 OMIJiD1jOkfLgoB86i+ECyPz0H5NVZw1HciVhJi8mju6RbBXLFifT0FUZYwtHHHiRufd
 msNCYjDZ0Tu6z99eZbIJveeDJk4zIjkDq0oi5l5SJX5gSU92nRq6JmNtc5bZHgyiiwO5
 ZsSS/WObRYNoIhSwekPhuoLldatX+mWDXNH2nxggu1TK5NZaVOD2nE0Fwja4gxv6rkwH
 YiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794366324; x=1794971124;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x1uAj5qJXr5sVqt+jkYScee8edg7YSR0yphLBVOEddg=;
 b=QNEtpsNtDCfsA3CaCJue5ftz1vaw+zN1JZRbP3FhCpsMbHj4P55g0MqI4PATyjDSwD
 HzGyXuyGWB89mBMtm5NuWTGN5/1fiRn8ZIGhklvFfyGuS32JClMfiFC3zuZG5PK19gbu
 rNIiI77QzC97CtflPaKwioo2UtLWrG19x5Klbkg/b+wL4Qjr1ywb2xiL2IkHbs/rR6p6
 oabia9iNFPTSPmY4RiVKVE5nitGtLoxQmoX/6OHZI6TnaV2OWv8Ig2uFUrajFrBkG3m/
 o2DKlSMZpB/+qBBjfbHugv2UsPuZ3Atw/Pe1Eps82NOuWA2iXDrT5VWhQJEnEPP14UTl
 IuRw==
X-Gm-Message-State: APuU4Z/braAwgPej9fosYU3680Xb9KuHfb7n92Xtjucwy/MhQ3ZL1pCH
 CkpGmjqqvshhwfND9xs+j8lB7qTcEspw+/q1zrOzGn4DyssW/KOLjrc7V/5ImAoc4eMbt8tB3wJ
 GoKFRwvqNcySwDBNE3xRquhu3AR3ot/OR3FeZU43FyRKU
X-Gm-Gg: AYBFou2NmFtsVKu/1Tq1vTJJ3oW/TrKBBxmqq688pI8tXX2JuwBAH1gckpD202hKnrD
 o3WN0tmAQgNgc/0YCB8dfEHRJWSAyKim07d/clM9bGee+WeC1GWWZDDnyMxG9Z9/n5vmt0qqMgc
 FZ28sHJQQTVwmVHhIMsHBaPx7gK+jJZ5GYV8Yfvo17awtyaM6nFPcihKHsWHP56iottdeoyJXy0
 4Jk36DXl9iWjEJJnlPRTIMO4F+/aRLPet1JNMSeJsQi540SrgsssprFdO7S0o+uD4Ldp0G/rJ15
 XR2i5FGu9Z0QaIM+bIrIAVo4onOvyl31y361uTKf+PH33DOsd6jdulxbcUnwoeuxtBBpYv31ueo
 HM+YxC2zlJPptc/VtPJ+XJC4SbTV549EN2Z+kPBvv55CzbVznAtJ909X6isRvS1E/54lkY+Q=
X-Received: by 2002:a53:d056:0:20b0:675:5fb9:b75a with SMTP id
 956f58d0204a3-67c68048f5bmr547058d50.157.1794366324030; Tue, 10 Nov 2026
 19:05:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
In-Reply-To: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
From: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Date: Wed, 11 Nov 2026 10:04:47 +0700
X-Gm-Features: AclHuK--sNQXEStQ631Wj-5q5qiaW8eZY9o-Hs87ZpVhl9rnjdXPuM7yJBLxTeA
Message-ID: <CAKXvu5i3EKRKTB_LCZB8xb1a0OjD-nGWqnUWnQ-d1xtjimkY9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C
 controller driver
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000573ffd065ff7774a"
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000573ffd065ff7774a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon and Peter,

Could you please take a moment to review my patches?
Your feedback is greatly appreciated.

Thank you! Regards
--------------------------------------------------------
Giau Nguyen
--------------------------------------------------------
Phone: (+84) 387 915 996 <+84%20387%20915%20996>


On Wed, Nov 4, 2026 at 4:31=E2=80=AFPM Giau Nguyen <nguyenanhgiau1008@gmail=
.com>
wrote:

> Mainline U-Boot currently lacks an I2C controller driver for the
> Broadcom BCM2711 SoC (Raspberry Pi 4).
>
> This commit adds a new DM-compliant I2C driver for Broadcom
> BCM2835/BCM2711 SoCs, based on the Linux kernel's i2c-bcm2835.c
> (Linux commit 32a0a94aa09e ("i2c: Switch back to struct
> platform_driver::remove()")). The driver is polling based.
>
> The driver dynamically queries the actual VPU core clock rate from
> the VideoCore firmware via mailbox property messages to calculate
> the CDIV clock divider, ensuring accurate I2C timing and baud rates
> on BCM2711.
>
> To query the clock, add bcm2835_get_clock_rate() to mach-bcm283x and
> reuse it from bcm2835_get_mmc_clock(). The existing fallback to the
> maximum clock rate when the firmware reports a rate of 0 is kept for
> the MMC case.
>
> Tested on a Raspberry Pi 4 Model B with a UPS HAT carrying an INA219
> power monitor (I2C bus 1, address 0x42), using the 'i2c dev', 'i2c probe'=
,
> 'i2c write' and 'i2c read' commands to configure the sensor and read back
> its current register.
>
> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> ---
>
> Notes:
>     v4:
>      - Split defconfig changes into a separate patch.
>      - Reused bcm2835_get_clock_rate() in bcm2835_get_mmc_clock(), keepin=
g
>        the fallback to GET_MAX_CLOCK_RATE when the firmware reports a rat=
e
>        of 0. Define and declare it before bcm2835_get_mmc_clock() in msg.=
c
>        and msg.h.
>      - Added 'depends on ARCH_BCM283X' to Kconfig.
>      - Dropped unsupported I2C_M_IGNORE_NAK flag handling.
>      - Removed redundant !curr_msg check in polling loop.
>      - Replaced printf() with dev_err() in probe().
>      - Dropped redundant set_rate() call in probe(), the uclass already
> sets
>        the bus speed from 'clock-frequency'. Check for a zero core clock
>        rate in probe() instead, as bcm2835_get_clock_rate() no longer
>        rejects it.
>      - Fix #include order, .compatible formatting and copyright header.
>
>     v3:
>      - Added the Linux commit ID to the commit message.
>      - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in
>        drivers/i2c/Makefile.
>      - Added Reviewed-by tag from Heiko.
>
>     v2:
>      - Clarified commit message: U-Boot mainline currently lacks BCM2711
> I2C
>        driver.
>      - Fixed line endings and code formatting per checkpatch.pl.
>      - Converted register offsets to 'struct bcm2835_i2c_regs' abstractio=
n.
>      - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard
>        readl/writel.
>      - Moved mailbox clock querying to bcm2835_get_clock_rate() in
>        mach-bcm283x.
>      - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
>      - Removed 'Assisted by AI' tag.
>
>  MAINTAINERS                              |   1 +
>  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>  arch/arm/mach-bcm283x/msg.c              |  29 +-
>  drivers/i2c/Kconfig                      |  11 +
>  drivers/i2c/Makefile                     |   1 +
>  drivers/i2c/i2c-bcm2835.c                | 359 +++++++++++++++++++++++
>  6 files changed, 402 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/i2c/i2c-bcm2835.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d273603ac64..53bf76964de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -277,6 +277,7 @@ S:  Maintained
>  F:     arch/arm/mach-bcm283x/
>  F:     board/raspberrypi/
>  F:     drivers/gpio/bcm2835_gpio.c
> +F:     drivers/i2c/i2c-bcm2835.c
>  F:     drivers/mmc/bcm2835_sdhci.c
>  F:     drivers/mmc/bcm2835_sdhost.c
>  F:     drivers/serial/serial_bcm283x_mu.c
> diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h
> b/arch/arm/mach-bcm283x/include/mach/msg.h
> index e54da86e353..ca8cc8826da 100644
> --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> @@ -14,6 +14,15 @@
>   */
>  int bcm2835_power_on_module(u32 module);
>
> +/**
> + * bcm2835_get_clock_rate() - get the current rate of a clock
> + *
> + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_..=
.)
> + * @rate: Returns the clock rate in Hz (may be 0 if the clock is not
> running)
> + * Return: 0 if OK, -EIO on error
> + */
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
> +
>  /**
>   * bcm2835_get_mmc_clock() - get the frequency of the MMC clock
>   *
> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> index 05e1a02e80f..d1b85bdac24 100644
> --- a/arch/arm/mach-bcm283x/msg.c
> +++ b/arch/arm/mach-bcm283x/msg.c
> @@ -77,15 +77,10 @@ int bcm2835_power_on_module(u32 module)
>         return 0;
>  }
>
> -int bcm2835_get_mmc_clock(u32 clock_id)
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
>         int ret;
> -       u32 clock_rate =3D 0;
> -
> -       ret =3D bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
> -       if (ret)
> -               return ret;
>
>         BCM2835_MBOX_INIT_HDR(msg_clk);
>         BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> @@ -93,11 +88,29 @@ int bcm2835_get_mmc_clock(u32 clock_id)
>
>         ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN,
> &msg_clk->hdr);
>         if (ret) {
> -               printf("bcm2835: Could not query eMMC clock rate\n");
> +               printf("bcm2835: Could not query clock rate for clock
> %u\n",
> +                      clock_id);
>                 return -EIO;
>         }
>
> -       clock_rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
> +       *rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
> +
> +       return 0;
> +}
> +
> +int bcm2835_get_mmc_clock(u32 clock_id)
> +{
> +       ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> +       ulong clock_rate;
> +       int ret;
> +
> +       ret =3D bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D bcm2835_get_clock_rate(clock_id, &clock_rate);
> +       if (ret)
> +               return ret;
>
>         if (clock_rate =3D=3D 0) {
>                 BCM2835_MBOX_INIT_HDR(msg_clk);
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index 0b5225fd3f5..77f71cd28ca 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -171,6 +171,17 @@ config SYS_I2C_AT91
>           i2c-gpio driver unless your system can cope with this limitatio=
n.
>           Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
>
> +config SYS_I2C_BCM2835
> +       bool "BCM2835 I2C controller"
> +       depends on DM_I2C
> +       depends on ARCH_BCM283X
> +       help
> +         Enable support for the Broadcom BCM2835/BCM2711 I2C controller.
> +         This driver provides standard I2C support for Raspberry Pi
> +         devices, including the newer Raspberry Pi 4. It dynamically
> +         calculates the clock divider based on the VPU core clock
> +         queried via the firmware mailbox.
> +
>  config SYS_I2C_IPROC
>         bool "Broadcom I2C driver"
>         depends on DM_I2C
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index 79e6a298808..207449f0f20 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_I2C_ADI) +=3D adi_i2c.o
>  obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o
>  obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o
>  obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o
> +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o
>  obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o
>  obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o
>  obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o
> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> new file mode 100644
> index 00000000000..58bc3ce944c
> --- /dev/null
> +++ b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BCM2835 I2C controller driver
> + * Copyright (C) 2026 Giau Nguyen <nguyenanhgiau1008@gmail.com>
> + *
> + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
> + */
> +
> +#include <dm.h>
> +#include <i2c.h>
> +#include <time.h>
> +#include <log.h>
> +#include <asm/io.h>
> +#include <asm/arch/mbox.h>
> +#include <asm/arch/msg.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#define BCM2835_I2C_C_READ     BIT(0)
> +#define BCM2835_I2C_C_CLEAR    BIT(4) /* bits 4 and 5 both clear */
> +#define BCM2835_I2C_C_ST       BIT(7)
> +#define BCM2835_I2C_C_INTD     BIT(8)
> +#define BCM2835_I2C_C_INTT     BIT(9)
> +#define BCM2835_I2C_C_INTR     BIT(10)
> +#define BCM2835_I2C_C_I2CEN    BIT(15)
> +
> +#define BCM2835_I2C_S_TA       BIT(0)
> +#define BCM2835_I2C_S_DONE     BIT(1)
> +#define BCM2835_I2C_S_TXW      BIT(2)
> +#define BCM2835_I2C_S_RXR      BIT(3)
> +#define BCM2835_I2C_S_TXD      BIT(4)
> +#define BCM2835_I2C_S_RXD      BIT(5)
> +#define BCM2835_I2C_S_TXE      BIT(6)
> +#define BCM2835_I2C_S_RXF      BIT(7)
> +#define BCM2835_I2C_S_ERR      BIT(8)
> +#define BCM2835_I2C_S_CLKT     BIT(9)
> +#define BCM2835_I2C_S_LEN      BIT(10) /* Fake bit for SW error reportin=
g
> */
> +
> +#define BCM2835_I2C_FEDL_SHIFT 16
> +#define BCM2835_I2C_REDL_SHIFT 0
> +
> +#define BCM2835_I2C_CDIV_MIN   0x0002
> +#define BCM2835_I2C_CDIV_MAX   0xFFFE
> +
> +#define BCM2835_I2C_CLKT_TOUT_MS 35
> +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
> +
> +struct bcm2835_i2c_regs {
> +       u32 c;
> +       u32 s;
> +       u32 dlen;
> +       u32 a;
> +       u32 fifo;
> +       u32 div;
> +       u32 del;
> +       u32 clkt;
> +};
> +
> +struct bcm2835_i2c_priv {
> +       struct bcm2835_i2c_regs __iomem *regs;
> +       ulong input_rate;
> +       size_t msg_buf_remaining;
> +       u8 *msg_buf;
> +       struct i2c_msg *curr_msg;
> +       int msg_err;
> +       int num_msgs;
> +};
> +
> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> +
> +       while (i2c_dev->msg_buf_remaining) {
> +               if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
> +                       break;
> +
> +               writel(*i2c_dev->msg_buf, &regs->fifo);
> +               i2c_dev->msg_buf++;
> +               i2c_dev->msg_buf_remaining--;
> +       }
> +}
> +
> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> +
> +       while (i2c_dev->msg_buf_remaining) {
> +               if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
> +                       break;
> +
> +               *i2c_dev->msg_buf =3D readl(&regs->fifo);
> +               i2c_dev->msg_buf++;
> +               i2c_dev->msg_buf_remaining--;
> +       }
> +}
> +
> +static int bcm2835_i2c_calc_divider(unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       int divider =3D DIV_ROUND_UP(parent_rate, rate);
> +
> +       /*
> +        * Per the datasheet, the register is always interpreted as an ev=
en
> +        * number, by rounding down. In other words, the LSB is ignored.
> So,
> +        * if the LSB is set, increment the divider to avoid any issue.
> +        */
> +       if (divider & 1)
> +               divider++;
> +
> +       if (divider < BCM2835_I2C_CDIV_MIN ||
> +           divider > BCM2835_I2C_CDIV_MAX)
> +               return -EINVAL;
> +
> +       return divider;
> +}
> +
> +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
> +{
> +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(bus);
> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> +       ulong parent_rate =3D i2c_dev->input_rate;
> +       u32 redl, fedl;
> +       u32 clk_tout;
> +       int divider;
> +
> +       if (!rate || !parent_rate)
> +               return -EINVAL;
> +
> +       divider =3D bcm2835_i2c_calc_divider(rate, parent_rate);
> +       if (divider < 0)
> +               return divider;
> +
> +       writel(divider, &regs->div);
> +
> +       /*
> +        * Number of core clocks to wait after falling edge before
> +        * outputting the next data bit. Note that both FEDL and REDL
> +        * can't be greater than CDIV/2.
> +        */
> +       fedl =3D max_t(u32, divider / 16, 1);
> +
> +       /*
> +        * Number of core clocks to wait after rising edge before
> +        * sampling the next incoming data bit.
> +        */
> +       redl =3D max_t(u32, divider / 4, 1);
> +
> +       writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
> +              (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
> +
> +       /*
> +        * Set the clock stretch timeout.
> +        */
> +       if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
> +               clk_tout =3D 0xffff;
> +       else
> +               clk_tout =3D BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
> +
> +       writel(clk_tout, &regs->clkt);
> +
> +       return 0;
> +}
> +
> +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)
> +{
> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> +       u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> +       struct i2c_msg *msg =3D i2c_dev->curr_msg;
> +       bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
> +
> +       if (!i2c_dev->num_msgs)
> +               return;
> +
> +       i2c_dev->num_msgs--;
> +       i2c_dev->msg_buf =3D msg->buf;
> +       i2c_dev->msg_buf_remaining =3D msg->len;
> +
> +       if (msg->flags & I2C_M_RD)
> +               c |=3D BCM2835_I2C_C_READ;
> +       else
> +               c |=3D BCM2835_I2C_C_INTT;
> +
> +       if (last_msg)
> +               c |=3D BCM2835_I2C_C_INTD;
> +
> +       writel(msg->addr, &regs->a);
> +       writel(msg->len, &regs->dlen);
> +       writel(c, &regs->c);
> +}
> +
> +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev=
)
> +{
> +       i2c_dev->curr_msg =3D NULL;
> +       i2c_dev->num_msgs =3D 0;
> +       i2c_dev->msg_buf =3D NULL;
> +       i2c_dev->msg_buf_remaining =3D 0;
> +}
> +
> +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs,
> int count)
> +{
> +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(dev);
> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
> +       bool done =3D false;
> +       ulong start;
> +       int i;
> +       u32 val, err;
> +       int ret =3D 0;
> +
> +       if (!msgs || count <=3D 0)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (msgs[i].flags & I2C_M_TEN)
> +                       return -EOPNOTSUPP;
> +               if (msgs[i].flags & I2C_M_RD) {
> +                       if (i < count - 1) {
> +                               dev_err(dev, "read message must be
> last\n");
> +                               return -EOPNOTSUPP;
> +                       }
> +               }
> +               if (msgs[i].len > 0xffff)
> +                       return -EINVAL;
> +       }
> +
> +       /* Clear stale status and FIFO state before starting a new
> transaction. */
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> +              &regs->s);
> +
> +       i2c_dev->curr_msg =3D msgs;
> +       i2c_dev->num_msgs =3D count;
> +       i2c_dev->msg_err =3D 0;
> +
> +       bcm2835_i2c_start_transfer(i2c_dev);
> +       start =3D get_timer(0);
> +       while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
> +               val =3D readl(&regs->s);
> +
> +               err =3D val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
> +               if (err && !(val & BCM2835_I2C_S_TA))
> +                       i2c_dev->msg_err =3D err;
> +
> +               if (val & BCM2835_I2C_S_DONE) {
> +                       if (i2c_dev->curr_msg->flags & I2C_M_RD) {
> +                               bcm2835_drain_rxfifo(i2c_dev);
> +                               val =3D readl(&regs->s);
> +                       }
> +
> +                       if ((val & BCM2835_I2C_S_RXD) ||
> +                           i2c_dev->msg_buf_remaining)
> +                               i2c_dev->msg_err =3D BCM2835_I2C_S_LEN;
> +                       done =3D true;
> +                       break;
> +               }
> +
> +               if (val & BCM2835_I2C_S_TXW) {
> +                       if (!i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->msg_err =3D val | BCM2835_I2C_S_=
LEN;
> +                               break;
> +                       }
> +
> +                       bcm2835_fill_txfifo(i2c_dev);
> +
> +                       if (i2c_dev->num_msgs > 0 &&
> !i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->curr_msg++;
> +                               bcm2835_i2c_start_transfer(i2c_dev);
> +                       }
> +               }
> +
> +               if (val & BCM2835_I2C_S_RXR) {
> +                       if (!i2c_dev->msg_buf_remaining) {
> +                               i2c_dev->msg_err =3D val | BCM2835_I2C_S_=
LEN;
> +                               break;
> +                       }
> +
> +                       bcm2835_drain_rxfifo(i2c_dev);
> +               }
> +               udelay(1);
> +       }
> +
> +       if (!done) {
> +               val =3D readl(&regs->s);
> +               dev_err(dev, "transfer timeout: status=3D%08x
> remaining=3D%zu\n",
> +                       val, i2c_dev->msg_buf_remaining);
> +               ret =3D -ETIMEDOUT;
> +       }
> +
> +       /* Always abort/reset the controller and clear W1C status bits. *=
/
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> +              &regs->s);
> +
> +       bcm2835_i2c_finish_transfer(i2c_dev);
> +       if (ret)
> +               return ret;
> +
> +       if (!i2c_dev->msg_err)
> +               return 0;
> +
> +       if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
> +               return -EREMOTEIO;
> +
> +       return -EIO;
> +}
> +
> +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {
> +       .xfer          =3D bcm2835_i2c_xfer,
> +       .set_bus_speed =3D bcm2835_i2c_set_rate,
> +};
> +
> +static const struct udevice_id bcm2835_i2c_ids[] =3D {
> +       { .compatible =3D "brcm,bcm2711-i2c" },
> +       { .compatible =3D "brcm,bcm2835-i2c" },
> +       { }
> +};
> +
> +static int bcm2835_i2c_probe(struct udevice *bus)
> +{
> +       struct bcm2835_i2c_priv *priv =3D dev_get_priv(bus);
> +       struct bcm2835_i2c_regs __iomem *regs;
> +       int ret;
> +
> +       priv->regs =3D dev_read_addr_ptr(bus);
> +       if (!priv->regs) {
> +               dev_err(bus, "cannot get base address\n");
> +               return -EINVAL;
> +       }
> +
> +       regs =3D priv->regs;
> +
> +       ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE,
> &priv->input_rate);
> +       if (ret)
> +               return ret;
> +
> +       if (!priv->input_rate) {
> +               dev_err(bus, "invalid core clock rate\n");
> +               return -EINVAL;
> +       }
> +
> +       /* clear FIFO + status */
> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DON=
E,
> +              &regs->s);
> +
> +       return 0;
> +}
> +
> +U_BOOT_DRIVER(bcm2835_i2c) =3D {
> +       .name       =3D "bcm2835_i2c",
> +       .id         =3D UCLASS_I2C,
> +       .of_match   =3D bcm2835_i2c_ids,
> +       .probe      =3D bcm2835_i2c_probe,
> +       .priv_auto  =3D sizeof(struct bcm2835_i2c_priv),
> +       .ops        =3D &bcm2835_i2c_ops,
> +};
> --
> 2.34.1
>
>

--000000000000573ffd065ff7774a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Simon and Peter,</div><div><br></div><div>Could yo=
u please take a moment to review my patches?</div><div>Your feedback is=C2=
=A0greatly appreciated.</div><div><br></div><div>Thank=C2=A0you!=C2=A0Regar=
ds</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div><span style=3D"font-size:12.8px">------------------=
--------------------------------------</span><br></div><div>Giau Nguyen</di=
v><div>--------------------------------------------------------</div><div>P=
hone: <a href=3D"tel:+84%20387%20915%20996" value=3D"+84387915996" target=
=3D"_blank">(+84) 387 915 996</a><br></div></div></div></div></div></div></=
div></div></div></div></div></div><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2026 at 4:31=E2=80=AFP=
M Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gmail.com" target=3D"=
_blank">nguyenanhgiau1008@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Mainline U-Boot currently lacks an I2C c=
ontroller driver for the<br>
Broadcom BCM2711 SoC (Raspberry Pi 4).<br>
<br>
This commit adds a new DM-compliant I2C driver for Broadcom<br>
BCM2835/BCM2711 SoCs, based on the Linux kernel&#39;s i2c-bcm2835.c<br>
(Linux commit 32a0a94aa09e (&quot;i2c: Switch back to struct<br>
platform_driver::remove()&quot;)). The driver is polling based.<br>
<br>
The driver dynamically queries the actual VPU core clock rate from<br>
the VideoCore firmware via mailbox property messages to calculate<br>
the CDIV clock divider, ensuring accurate I2C timing and baud rates<br>
on BCM2711.<br>
<br>
To query the clock, add bcm2835_get_clock_rate() to mach-bcm283x and<br>
reuse it from bcm2835_get_mmc_clock(). The existing fallback to the<br>
maximum clock rate when the firmware reports a rate of 0 is kept for<br>
the MMC case.<br>
<br>
Tested on a Raspberry Pi 4 Model B with a UPS HAT carrying an INA219<br>
power monitor (I2C bus 1, address 0x42), using the &#39;i2c dev&#39;, &#39;=
i2c probe&#39;,<br>
&#39;i2c write&#39; and &#39;i2c read&#39; commands to configure the sensor=
 and read back<br>
its current register.<br>
<br>
Signed-off-by: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gmail.co=
m" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
Reviewed-by: Heiko Schocher &lt;<a href=3D"mailto:hs@nabladev.com" target=
=3D"_blank">hs@nabladev.com</a>&gt;<br>
---<br>
<br>
Notes:<br>
=C2=A0 =C2=A0 v4:<br>
=C2=A0 =C2=A0 =C2=A0- Split defconfig changes into a separate patch.<br>
=C2=A0 =C2=A0 =C2=A0- Reused bcm2835_get_clock_rate() in bcm2835_get_mmc_cl=
ock(), keeping<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0the fallback to GET_MAX_CLOCK_RATE when the firm=
ware reports a rate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0of 0. Define and declare it before bcm2835_get_m=
mc_clock() in msg.c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0and msg.h.<br>
=C2=A0 =C2=A0 =C2=A0- Added &#39;depends on ARCH_BCM283X&#39; to Kconfig.<b=
r>
=C2=A0 =C2=A0 =C2=A0- Dropped unsupported I2C_M_IGNORE_NAK flag handling.<b=
r>
=C2=A0 =C2=A0 =C2=A0- Removed redundant !curr_msg check in polling loop.<br=
>
=C2=A0 =C2=A0 =C2=A0- Replaced printf() with dev_err() in probe().<br>
=C2=A0 =C2=A0 =C2=A0- Dropped redundant set_rate() call in probe(), the ucl=
ass already sets<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0the bus speed from &#39;clock-frequency&#39;. Ch=
eck for a zero core clock<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0rate in probe() instead, as bcm2835_get_clock_ra=
te() no longer<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0rejects it.<br>
=C2=A0 =C2=A0 =C2=A0- Fix #include order, .compatible formatting and copyri=
ght header.<br>
<br>
=C2=A0 =C2=A0 v3:<br>
=C2=A0 =C2=A0 =C2=A0- Added the Linux commit ID to the commit message.<br>
=C2=A0 =C2=A0 =C2=A0- Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 =
in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/i2c/Makefile.<br>
=C2=A0 =C2=A0 =C2=A0- Added Reviewed-by tag from Heiko.<br>
<br>
=C2=A0 =C2=A0 v2:<br>
=C2=A0 =C2=A0 =C2=A0- Clarified commit message: U-Boot mainline currently l=
acks BCM2711 I2C<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0driver.<br>
=C2=A0 =C2=A0 =C2=A0- Fixed line endings and code formatting per <a href=3D=
"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</=
a>.<br>
=C2=A0 =C2=A0 =C2=A0- Converted register offsets to &#39;struct bcm2835_i2c=
_regs&#39; abstraction.<br>
=C2=A0 =C2=A0 =C2=A0- Removed &#39;bcm2835_i2c_readl/writel&#39; wrappers i=
n favor of standard<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0readl/writel.<br>
=C2=A0 =C2=A0 =C2=A0- Moved mailbox clock querying to bcm2835_get_clock_rat=
e() in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0mach-bcm283x.<br>
=C2=A0 =C2=A0 =C2=A0- Sorted drivers/i2c/Kconfig and Makefile alphabeticall=
y.<br>
=C2=A0 =C2=A0 =C2=A0- Removed &#39;Assisted by AI&#39; tag.<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0arch/arm/mach-bcm283x/include/mach/msg.h |=C2=A0 =C2=A09 +<br>
=C2=A0arch/arm/mach-bcm283x/msg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 29 +-<br>
=C2=A0drivers/i2c/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +<br>
=C2=A0drivers/i2c/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0drivers/i2c/i2c-bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 359 +++++++++++++++++++++++<br>
=C2=A06 files changed, 402 insertions(+), 8 deletions(-)<br>
=C2=A0create mode 100644 drivers/i2c/i2c-bcm2835.c<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index d273603ac64..53bf76964de 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -277,6 +277,7 @@ S:=C2=A0 Maintained<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0arch/arm/mach-bcm283x/<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0board/raspberrypi/<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/gpio/bcm2835_gpio.c<br>
+F:=C2=A0 =C2=A0 =C2=A0drivers/i2c/i2c-bcm2835.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/mmc/bcm2835_sdhci.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/mmc/bcm2835_sdhost.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/serial/serial_bcm283x_mu.c<br>
diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bcm28=
3x/include/mach/msg.h<br>
index e54da86e353..ca8cc8826da 100644<br>
--- a/arch/arm/mach-bcm283x/include/mach/msg.h<br>
+++ b/arch/arm/mach-bcm283x/include/mach/msg.h<br>
@@ -14,6 +14,15 @@<br>
=C2=A0 */<br>
=C2=A0int bcm2835_power_on_module(u32 module);<br>
<br>
+/**<br>
+ * bcm2835_get_clock_rate() - get the current rate of a clock<br>
+ *<br>
+ * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_...)=
<br>
+ * @rate: Returns the clock rate in Hz (may be 0 if the clock is not runni=
ng)<br>
+ * Return: 0 if OK, -EIO on error<br>
+ */<br>
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);<br>
+<br>
=C2=A0/**<br>
=C2=A0 * bcm2835_get_mmc_clock() - get the frequency of the MMC clock<br>
=C2=A0 *<br>
diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c<br>
index 05e1a02e80f..d1b85bdac24 100644<br>
--- a/arch/arm/mach-bcm283x/msg.c<br>
+++ b/arch/arm/mach-bcm283x/msg.c<br>
@@ -77,15 +77,10 @@ int bcm2835_power_on_module(u32 module)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-int bcm2835_get_mmc_clock(u32 clock_id)<br>
+int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_r=
ate, msg_clk, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clock_rate =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_power_on_module(BCM2835_MBOX_PO=
WER_DEVID_SDHCI);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BCM2835_MBOX_INIT_HDR(msg_clk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BCM2835_MBOX_INIT_TAG(&amp;msg_clk-&gt;get_cloc=
k_rate, GET_CLOCK_RATE);<br>
@@ -93,11 +88,29 @@ int bcm2835_get_mmc_clock(u32 clock_id)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PRO=
P_CHAN, &amp;msg_clk-&gt;hdr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;bcm283=
5: Could not query eMMC clock rate\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;bcm283=
5: Could not query clock rate for clock %u\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 clock_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0clock_rate =3D msg_clk-&gt;get_clock_rate.body.=
resp.rate_hz;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*rate =3D msg_clk-&gt;get_clock_rate.body.resp.=
rate_hz;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+int bcm2835_get_mmc_clock(u32 clock_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_r=
ate, msg_clk, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong clock_rate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_power_on_module(BCM2835_MBOX_PO=
WER_DEVID_SDHCI);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_get_clock_rate(clock_id, &amp;c=
lock_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (clock_rate =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BCM2835_MBOX_INIT_H=
DR(msg_clk);<br>
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig<br>
index 0b5225fd3f5..77f71cd28ca 100644<br>
--- a/drivers/i2c/Kconfig<br>
+++ b/drivers/i2c/Kconfig<br>
@@ -171,6 +171,17 @@ config SYS_I2C_AT91<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c-gpio driver unless your system can c=
ope with this limitation.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Binding info: doc/device-tree-bindings/i=
2c/i2c-at91.txt<br>
<br>
+config SYS_I2C_BCM2835<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;BCM2835 I2C controller&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_BCM283X<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for the Broadcom BCM2835/=
BCM2711 I2C controller.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver provides standard I2C suppor=
t for Raspberry Pi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices, including the newer Raspberry P=
i 4. It dynamically<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0calculates the clock divider based on th=
e VPU core clock<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queried via the firmware mailbox.<br>
+<br>
=C2=A0config SYS_I2C_IPROC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Broadcom I2C driver&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on DM_I2C<br>
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile<br>
index 79e6a298808..207449f0f20 100644<br>
--- a/drivers/i2c/Makefile<br>
+++ b/drivers/i2c/Makefile<br>
@@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_I2C_ADI) +=3D adi_i2c.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o<br>
+obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o<br>
=C2=A0obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o<br>
diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
new file mode 100644<br>
index 00000000000..58bc3ce944c<br>
--- /dev/null<br>
+++ b/drivers/i2c/i2c-bcm2835.c<br>
@@ -0,0 +1,359 @@<br>
+// SPDX-License-Identifier: GPL-2.0<br>
+/*<br>
+ * BCM2835 I2C controller driver<br>
+ * Copyright (C) 2026 Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@=
gmail.com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
+ *<br>
+ * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c<br>
+ */<br>
+<br>
+#include &lt;dm.h&gt;<br>
+#include &lt;i2c.h&gt;<br>
+#include &lt;time.h&gt;<br>
+#include &lt;log.h&gt;<br>
+#include &lt;asm/io.h&gt;<br>
+#include &lt;asm/arch/mbox.h&gt;<br>
+#include &lt;asm/arch/msg.h&gt;<br>
+#include &lt;dm/device_compat.h&gt;<br>
+#include &lt;linux/bitops.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/kernel.h&gt;<br>
+#include &lt;linux/types.h&gt;<br>
+<br>
+#define BCM2835_I2C_C_READ=C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+#define BCM2835_I2C_C_CLEAR=C2=A0 =C2=A0 BIT(4) /* bits 4 and 5 both clear=
 */<br>
+#define BCM2835_I2C_C_ST=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(7)<br>
+#define BCM2835_I2C_C_INTD=C2=A0 =C2=A0 =C2=A0BIT(8)<br>
+#define BCM2835_I2C_C_INTT=C2=A0 =C2=A0 =C2=A0BIT(9)<br>
+#define BCM2835_I2C_C_INTR=C2=A0 =C2=A0 =C2=A0BIT(10)<br>
+#define BCM2835_I2C_C_I2CEN=C2=A0 =C2=A0 BIT(15)<br>
+<br>
+#define BCM2835_I2C_S_TA=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+#define BCM2835_I2C_S_DONE=C2=A0 =C2=A0 =C2=A0BIT(1)<br>
+#define BCM2835_I2C_S_TXW=C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
+#define BCM2835_I2C_S_RXR=C2=A0 =C2=A0 =C2=A0 BIT(3)<br>
+#define BCM2835_I2C_S_TXD=C2=A0 =C2=A0 =C2=A0 BIT(4)<br>
+#define BCM2835_I2C_S_RXD=C2=A0 =C2=A0 =C2=A0 BIT(5)<br>
+#define BCM2835_I2C_S_TXE=C2=A0 =C2=A0 =C2=A0 BIT(6)<br>
+#define BCM2835_I2C_S_RXF=C2=A0 =C2=A0 =C2=A0 BIT(7)<br>
+#define BCM2835_I2C_S_ERR=C2=A0 =C2=A0 =C2=A0 BIT(8)<br>
+#define BCM2835_I2C_S_CLKT=C2=A0 =C2=A0 =C2=A0BIT(9)<br>
+#define BCM2835_I2C_S_LEN=C2=A0 =C2=A0 =C2=A0 BIT(10) /* Fake bit for SW e=
rror reporting */<br>
+<br>
+#define BCM2835_I2C_FEDL_SHIFT 16<br>
+#define BCM2835_I2C_REDL_SHIFT 0<br>
+<br>
+#define BCM2835_I2C_CDIV_MIN=C2=A0 =C2=A00x0002<br>
+#define BCM2835_I2C_CDIV_MAX=C2=A0 =C2=A00xFFFE<br>
+<br>
+#define BCM2835_I2C_CLKT_TOUT_MS 35<br>
+#define BCM2835_I2C_XFER_TIMEOUT_MS 1000<br>
+<br>
+struct bcm2835_i2c_regs {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 c;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dlen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 fifo;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 div;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 del;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clkt;<br>
+};<br>
+<br>
+struct bcm2835_i2c_priv {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong input_rate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t msg_buf_remaining;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *msg_buf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg *curr_msg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int msg_err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int num_msgs;<br>
+};<br>
+<br>
+static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_d=
ev-&gt;regs;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&amp;re=
gs-&gt;s) &amp; BCM2835_I2C_S_TXD))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(*i2c_dev-&gt=
;msg_buf, &amp;regs-&gt;fifo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf=
++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf=
_remaining--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_d=
ev-&gt;regs;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (i2c_dev-&gt;msg_buf_remaining) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(readl(&amp;re=
gs-&gt;s) &amp; BCM2835_I2C_S_RXD))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*i2c_dev-&gt;msg_bu=
f =3D readl(&amp;regs-&gt;fifo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf=
++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf=
_remaining--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static int bcm2835_i2c_calc_divider(unsigned long rate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long parent_ra=
te)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int divider =3D DIV_ROUND_UP(parent_rate, rate)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Per the datasheet, the register is always in=
terpreted as an even<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * number, by rounding down. In other words, th=
e LSB is ignored. So,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * if the LSB is set, increment the divider to =
avoid any issue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &amp; 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider++;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &lt; BCM2835_I2C_CDIV_MIN ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0divider &gt; BCM2835_I2C_CDIV_MAX=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return divider;<br>
+}<br>
+<br>
+static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)<br=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_get_pr=
iv(bus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_d=
ev-&gt;regs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong parent_rate =3D i2c_dev-&gt;input_rate;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 redl, fedl;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 clk_tout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int divider;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rate || !parent_rate)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0divider =3D bcm2835_i2c_calc_divider(rate, pare=
nt_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (divider &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return divider;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(divider, &amp;regs-&gt;div);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after falling =
edge before<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * outputting the next data bit. Note that both=
 FEDL and REDL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * can&#39;t be greater than CDIV/2.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fedl =3D max_t(u32, divider / 16, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Number of core clocks to wait after rising e=
dge before<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * sampling the next incoming data bit.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0redl =3D max_t(u32, divider / 4, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel((fedl &lt;&lt; BCM2835_I2C_FEDL_SHIFT) |=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (redl &lt;&lt; BCM2835_I2=
C_REDL_SHIFT), &amp;regs-&gt;del);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Set the clock stretch timeout.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rate &gt; 0xffff * 1000 / BCM2835_I2C_CLKT_=
TOUT_MS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D 0xffff=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_tout =3D BCM283=
5_I2C_CLKT_TOUT_MS * rate / 1000;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(clk_tout, &amp;regs-&gt;clkt);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev)<b=
r>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_d=
ev-&gt;regs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CE=
N;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg *msg =3D i2c_dev-&gt;curr_msg;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool last_msg =3D (i2c_dev-&gt;num_msgs =3D=3D =
1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;num_msgs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D msg-&gt;buf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D msg-&gt;len;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msg-&gt;flags &amp; I2C_M_RD)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_=
C_READ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_=
C_INTT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (last_msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c |=3D BCM2835_I2C_=
C_INTD;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(msg-&gt;addr, &amp;regs-&gt;a);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(msg-&gt;len, &amp;regs-&gt;dlen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(c, &amp;regs-&gt;c);<br>
+}<br>
+<br>
+static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_dev)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining =3D 0;<br>
+}<br>
+<br>
+static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, int=
 count)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *i2c_dev =3D dev_get_pr=
iv(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs =3D i2c_d=
ev-&gt;regs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool done =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ulong start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 val, err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!msgs || count &lt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &=
amp; I2C_M_TEN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EOPNOTSUPP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &=
amp; I2C_M_RD) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (i &lt; count - 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;read message must =
be last\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].len &gt=
; 0xffff)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear stale status and FIFO state before sta=
rting a new transaction. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |=
 BCM2835_I2C_S_DONE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg =3D msgs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;num_msgs =3D count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D get_timer(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (get_timer(start) &lt; BCM2835_I2C_XFER_T=
IMEOUT_MS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;=
regs-&gt;s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D val &amp; (=
BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &amp;&amp; =
!(val &amp; BCM2835_I2C_S_TA))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i2c_dev-&gt;msg_err =3D err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM28=
35_I2C_S_DONE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (i2c_dev-&gt;curr_msg-&gt;flags &amp; I2C_M_RD) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;regs-&gt;s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ((val &amp; BCM2835_I2C_S_RXD) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_buf_remaining)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D BCM2835_I2C_S=
_LEN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0done =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM28=
35_I2C_S_TXW) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM2835=
_I2C_S_LEN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bcm2835_fill_txfifo(i2c_dev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (i2c_dev-&gt;num_msgs &gt; 0 &amp;&amp; !i2c_dev-&gt;msg_buf_r=
emaining) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;curr_msg++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_start_transfer(i2c_dev);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM28=
35_I2C_S_RXR) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!i2c_dev-&gt;msg_buf_remaining) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_dev-&gt;msg_err =3D val | BCM2835=
_I2C_S_LEN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bcm2835_drain_rxfifo(i2c_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!done) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D readl(&amp;=
regs-&gt;s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
transfer timeout: status=3D%08x remaining=3D%zu\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0val, i2c_dev-&gt;msg_buf_remaining);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ETIMEDOUT;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always abort/reset the controller and clear =
W1C status bits. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |=
 BCM2835_I2C_S_DONE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm2835_i2c_finish_transfer(i2c_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_dev-&gt;msg_err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i2c_dev-&gt;msg_err &amp; BCM2835_I2C_S_ERR=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EREMOTEIO;<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+}<br>
+<br>
+static const struct dm_i2c_ops bcm2835_i2c_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.xfer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D bcm=
2835_i2c_xfer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_bus_speed =3D bcm2835_i2c_set_rate,<br>
+};<br>
+<br>
+static const struct udevice_id bcm2835_i2c_ids[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm2711-i2c&quot; =
},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm2835-i2c&quot; =
},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ }<br>
+};<br>
+<br>
+static int bcm2835_i2c_probe(struct udevice *bus)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_priv *priv =3D dev_get_priv(=
bus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm2835_i2c_regs __iomem *regs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;regs =3D dev_read_addr_ptr(bus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!priv-&gt;regs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(bus, &quot;=
cannot get base address\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regs =3D priv-&gt;regs;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLO=
CK_ID_CORE, &amp;priv-&gt;input_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!priv-&gt;input_rate) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(bus, &quot;=
invalid core clock rate\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear FIFO + status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_C_CLEAR, &amp;regs-&gt;c);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR |=
 BCM2835_I2C_S_DONE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;regs-&gt;s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+U_BOOT_DRIVER(bcm2835_i2c) =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;bcm28=
35_i2c&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D UCLASS=
_I2C,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match=C2=A0 =C2=A0=3D bcm2835_i2c_ids,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =3D bcm2835_i2c_prob=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.priv_auto=C2=A0 =3D sizeof(struct bcm2835_i2c_=
priv),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.ops=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;bcm283=
5_i2c_ops,<br>
+};<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000573ffd065ff7774a--
