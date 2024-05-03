Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417D3C10F16
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 21:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0F387F8D;
	Fri,  3 May 2024 23:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxWkxwR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4360888251; Fri,  3 May 2024 23:52:24 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4028820E
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 23:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4df295192b7so73947e0c.1
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714773141; x=1715377941; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYkEOOW1gdIe9YmqPnOomFIi/yYZ2hTmSVjs8mA2Kp0=;
 b=BxWkxwR2CTpst2NOyz0VDW7+YGOdonKP5EiYTZA8+RIusK4QvIH8vZZAPjJiPlm3eq
 RQm/hbn8v5tLAVWA/I0MZVjUkLC2Hw4jegZ0vlyRv2YovEEwrK0o0JmnAUnEkAHq7iLh
 y08+2toeDp9OjflRg8ta1jrOg2oSqrHb9BOQqkHeQjt8+2eQ4GiowaVEAy9ahQ+62oZN
 40zoAA6AA5WZaeAotxUaCX9Iyn6Qnv/ECxfqRl6a17okQjaQwYB/GhMI0VpkHrgDCQAB
 fhsGJJsSy29wA6emhcaf4Gj9uOrZ5cvAZD7+urEFtVzAOT2zveq95xyr39TZBmhkjPk1
 ZjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714773141; x=1715377941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYkEOOW1gdIe9YmqPnOomFIi/yYZ2hTmSVjs8mA2Kp0=;
 b=GT5lDXlZms4/SZA7PhB1cRdrlIm4n5Yu1rGgkQRmqDw5wBgBodYiHxlJGkCz7ab+jx
 OrGh4yfYt3zfZxRUlS2avCxbbTnrHFx8o4WVYpnZk3rb4bJC8TCHlgqaLnwuYQH90ioh
 swYzMWWfLqBmDMmxnlxuhoI5RDZyT5Xm1BafmCys9R1dYXfGORNWbQ8SoaeY6mC/Fd7F
 9ajskzX2EO3qmhdFIjgCr8D/82YAvqIKhL7CnLrqsq8v9sdVX1qXQdEIuStU7eBZUfD1
 WNrNy+fChq2qDEHl4zZgouZ+NoP2Bxx1HpaO5ytlJ9rwRe1CJMxxSsbOPvT+P7YOxrP+
 OJ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjjt4zQWy2cwfoixc/by66W8Egad8wUX04DPFFchTX06FhKTct+8jbl27z++IS1VjlaQOlVworugBGnrjr+BPC/+NtJA==
X-Gm-Message-State: AOJu0YzKOhCUk7mpdzYhnMjzBLqegooIiOYrC1yna7TAMM8r6NCsiJAG
 JtazWgKlqFFrsmtzdxysOpNnioNmXeyLo1nX07GyMB3S8HBOl/QdtKlMLUNL1mGTAK6P29TfY7F
 e+mgQgkfR3GffRrRW4vocoQIInzI=
X-Google-Smtp-Source: AGHT+IH3kwpT9JjHctsks4Yuj5rtueWvgVfQ/Ga9099q4zKiEtJy2UjsX4JXcS3C6ooZB2RsqU4gYt5GI5mmbD2W4jM=
X-Received: by 2002:a05:6122:2094:b0:4d4:1fe2:c398 with SMTP id
 i20-20020a056122209400b004d41fe2c398mr4089804vkd.2.1714773140976; Fri, 03 May
 2024 14:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
 <20240503090011.37849-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240503090011.37849-5-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 3 May 2024 14:52:10 -0700
Message-ID: <CANV2PTPB34__WpAOeC3zSkV_ZsgmXhtOUOQMXWVT16xGWO9+Kg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, Mason Huo <mason.huo@starfivetech.com>,
 u-boot@lists.denx.de
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

On Fri, May 3, 2024 at 2:01=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We can use U-Boot for recovering JH7110 based boards via UART
> if CONFIG_SPL_YMODEM_SUPPORT=3Dy.
>
> * Send u-boot-spl.normal.out via XMODEM.
> * Send u-boot.itb via YMODEM.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  configs/starfive_visionfive2_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index 3bbd1dbd67c..174ac24dc74 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -62,6 +62,7 @@ CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_DM_SPI_FLASH=3Dy
>  CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SPL_YMODEM_SUPPORT=3Dy
>  CONFIG_SYS_PROMPT=3D"StarFive # "
>  CONFIG_CMD_EEPROM=3Dy
>  CONFIG_SYS_EEPROM_SIZE=3D512
> --
> 2.43.0
>

Reviewed-by: E. Shattow <lucent@gmail.com>
