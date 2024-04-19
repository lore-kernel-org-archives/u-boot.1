Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0377BC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 00:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580EF88682;
	Fri, 19 Apr 2024 02:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA3588690; Fri, 19 Apr 2024 02:34:26 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9C1885DE
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5196c755e82so1908427e87.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713486863; x=1714091663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSYLD5SwzBaB5LC4mmFD62Vk9Hl4DW4hxIfMegLA96c=;
 b=cfv+OkpcPdVwEHgwZRgFjIs1SPZp93Pelnu9caeRfKTSOnVe3bPtrGB79uuInB9VuV
 SIF5oiVioyruCsobr5oJnGFuo3iG8JHoA0T2FJrA9Ivgg8N4nsuvT7LiwhrTxCsklG4N
 jMQ5jZpDS79qp94LgHZu29vNSP2lBeAWE52nzXLml455BqCTQ9kEbTfd2LKIgNoRwlFK
 QRxkHF4eeJu616b2ftwpd46DcSPeK/79lr/O9bZ1ZszLZ3fv5MzGaAL7cDFsaFxA2vQ5
 Q3NANoZYqdMlX6+rcMql/H1J9MFZbeasZBvhal7BTnEX3R3GF+83Sy8FBe4NwbNBTn8K
 cFRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq6oRqX8H02QUQd/LiyQ+MmPLeq0v0o4P4bXgd5m/lEhs9Ju8OKmdMd3uZX9eZKYL2+fVsF/CNvS2vG1v04FTPw38xVg==
X-Gm-Message-State: AOJu0Yxw2ynO7eC7SPeRCyizxTCe44j/gwyC/fXwo0hOsanwP6NEbmbT
 y3wL0T5WsBthlmyECghugqjHWr07NsK9dbH+l5aGATStURnzkpM48JsF4rOdcoWOqw==
X-Google-Smtp-Source: AGHT+IFf8fHM3K4XHSETztkynSmxfTG96XUfRbdLgOEc1BXEa6KipwZIsw6vqUq5LGsmVnQ0F4T4sQ==
X-Received: by 2002:ac2:4a69:0:b0:513:b062:98c4 with SMTP id
 q9-20020ac24a69000000b00513b06298c4mr279825lfp.11.1713486863207; 
 Thu, 18 Apr 2024 17:34:23 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49]) by smtp.gmail.com with ESMTPSA id
 g2-20020a19e042000000b0051884ea2a32sm465621lfj.31.2024.04.18.17.34.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 17:34:22 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-51abf1a9332so84381e87.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/dea36XiThb8UMJ1H+OG4sYg2fD/G+srIF4fZOJMbQejQeeCDkJpAg4G8K1VBKd5PEJ6WT0lXb0coc+P30VYTKxwvdA==
X-Received: by 2002:a05:6512:3714:b0:519:231:e4b9 with SMTP id
 z20-20020a056512371400b005190231e4b9mr254768lfr.48.1713486862553; Thu, 18 Apr
 2024 17:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
 <20240418-apple_config-v2-5-7e5c6b9a9db3@jannau.net>
In-Reply-To: <20240418-apple_config-v2-5-7e5c6b9a9db3@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 18 Apr 2024 20:33:45 -0400
X-Gmail-Original-Message-ID: <CAEg-Je98=-j4zOhfy4L3smy5PKqRyaNMJX5H_6jKr0o2pDJqFQ@mail.gmail.com>
Message-ID: <CAEg-Je98=-j4zOhfy4L3smy5PKqRyaNMJX5H_6jKr0o2pDJqFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm: apple: Do not list bootflows on boot
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, asahi@lists.linux.dev
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

On Thu, Apr 18, 2024 at 3:00=E2=80=AFPM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> The bootflow list is only seen briefly and is probably more confusing
> than helpful.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  configs/apple_m1_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> index c30aec7c55..4eac1a9e2d 100644
> --- a/configs/apple_m1_defconfig
> +++ b/configs/apple_m1_defconfig
> @@ -8,6 +8,7 @@ CONFIG_SYS_CBSIZE=3D256
>  CONFIG_SYS_PBSIZE=3D276
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_BOOTCOMMAND=3D"bootflow scan -b"
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_CMD_SELECT_FONT=3Dy
>  # CONFIG_NET is not set
>
> --
> 2.44.0
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
