Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0300D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CDF88360;
	Tue, 26 Nov 2024 10:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lgwf5juQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF2C85B66; Tue, 26 Nov 2024 10:35:11 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777928857C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so15680825e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732613708; x=1733218508;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGckb0XLAvPvYoXMYnoqjgBpy3ZLGc5yol+GD5Jmejw=;
 b=lgwf5juQD+7xHr7HsFRgmXXWehz/um3PAiXeE/X0Kyve8J7mqOdGKLoA1qhIcLswmH
 OpmVsL2485N+S4BSdcS2tq3SPoONpBUy1f3fgAo+4D/MGcxyB6AtE9QN3qSBIVp2d0dp
 CXluKRnb6PAA5tgjXcUfSZMXcrX/ba3tcM288ozmT2MRl+XhQOqADrOQP4k23l5cd1Lm
 RSbVPJFQs+UocrMQPYWMqxkO8YP8FeXFqE664LAorhgM08M4JRmvMidwokzSVjo21GFc
 xIEJK+d41dDeNy4Wqvrf73nwjWq9oq30eCxLJUxZ6L4Qqz8v8jsnbpzO1H0KfJDhCse7
 KwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732613708; x=1733218508;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGckb0XLAvPvYoXMYnoqjgBpy3ZLGc5yol+GD5Jmejw=;
 b=douaRXwVDAXGw/tbHNPu3jOj0cO4LrunYhl2URt1nqdx8nJvnQlyDzj24ddfMvpDqG
 0/TM2N/9C3krmckg9NJitBFrzyerdyYwRB6oNz6W0rZoya8TBIJnYIJyGIBsdKWVONBU
 Pql8/0k0QkCtirujbGHnAA1aWKtVCWI3bTHZzCVyOYQxnnIGjsHdf9T/S3DhWSRHnESG
 WLMIoTfbTZ9RfgWTM5aBKs0xXFRpwX0SHF7hHV1Thetj42FKgebxdh8W8F1USnrp9fhG
 rnVA1DKQdcTbf8yMdeCe12O8UqYiAam6twSAZJWxDx+qzDMmN3K1R5sCQZNzBVIO+n6G
 3dSg==
X-Gm-Message-State: AOJu0YwwY8CVgnTRI7tIV7w4FV3uUsMNLxQiGIBIuVIHf8DZ0HULW4cb
 NuNQOpUz2yGKR8A05PeH3yNFuwZ1G0aw2gt2zxdiy5paAVFGE1XrQHgIaNR1yeI=
X-Gm-Gg: ASbGnctDskCiZkKqeRL3ujv8kASCZ56rkRp08VVAxOSJE36Fn1zYb4MYM0SuJNEhWTT
 l92j1Y3n4fdwa23YN6janTzl4CjXnu7+9Y8Px6ZF46I9yO2hknJslngSkB8Zu4m1j7iC6mNY//w
 ISKvt/fodAZZyGCQChud6fT80UFlJDQNQSM6GON3gIycNJZoOH91Cmd9Rx9a8eshUOq+v/bngrF
 vrVBW7N+9F2QjM0b9hV0svmbm/75X/ZCm7MzBESsQGwmCORC6LKXQ==
X-Google-Smtp-Source: AGHT+IEcQ4M/7DNrI/vt4Md2Uzqeo7b1mQ3UcANl8ak64bwdX6t2hB5/5f5YXtfjt78IK0ZuLC/6lA==
X-Received: by 2002:a05:6000:184e:b0:382:319f:3abd with SMTP id
 ffacd0b85a97d-38260bcb8a6mr13931764f8f.36.1732613707898; 
 Tue, 26 Nov 2024 01:35:07 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6441sm13100632f8f.4.2024.11.26.01.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 01:35:07 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, rammuthiah@google.com, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Ying-Chun
 Liu <paul.liu@linaro.org>
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
In-Reply-To: <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
 <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
 <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
Date: Tue, 26 Nov 2024 10:35:05 +0100
Message-ID: <87v7wapcc6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On lun., nov. 25, 2024 at 23:41, Dmitrii Merkurev <dimorinny@google.com> wr=
ote:

> Hey Neil.
>
> Will do it by the end of the year. Only tested it with a virtio-block
> though.
>
> On Thu, Nov 21, 2024 at 12:44=E2=80=AFPM <neil.armstrong@linaro.org> wrot=
e:
>
>> Hi Dmitrii,
>>
>> So you plan to send a new version of this patchset ?
>>
>> It would be very useful to enable fastboot onr UFS/SCSI based devices.

FYI another development for UFS/SCSI has been submitted here:

https://patchwork.ozlabs.org/project/uboot/patch/20241125110354.602124-1-qu=
ic_varada@quicinc.com/

>>
>> Thanks,
>> Neil
>>
>> On 06/03/2024 19:59, Dmitrii Merkurev wrote:
>> > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> > Cc: Simon Glass <sjg@chromium.org>
>> > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> > Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> > ---
>> >   drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
>> >   1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> > index 5e5855a76c..460c5e98d7 100644
>> > --- a/drivers/fastboot/Kconfig
>> > +++ b/drivers/fastboot/Kconfig
>> > @@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
>> >   config FASTBOOT_FLASH
>> >       bool "Enable FASTBOOT FLASH command"
>> >       default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> > -     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> > +     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>> >       select IMAGE_SPARSE
>> >       help
>> >         The fastboot protocol includes a "flash" command for writing
>> > @@ -109,12 +109,16 @@ choice
>> >
>> >   config FASTBOOT_FLASH_MMC
>> >       bool "FASTBOOT on MMC"
>> > -     depends on MMC
>> > +     depends on MMC && BLK
>> >
>> >   config FASTBOOT_FLASH_NAND
>> >       bool "FASTBOOT on NAND"
>> >       depends on MTD_RAW_NAND && CMD_MTDPARTS
>> >
>> > +config FASTBOOT_FLASH_BLOCK
>> > +     bool "FASTBOOT on block device"
>> > +     depends on BLK
>> > +
>> >   endchoice
>> >
>> >   config FASTBOOT_FLASH_MMC_DEV
>> > @@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
>> >         defined here.
>> >         The default target name for erasing EMMC_USER is "mmc0".
>> >
>> > +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>> > +     string "Define FASTBOOT block interface name"
>> > +     depends on FASTBOOT_FLASH_BLOCK
>> > +     help
>> > +       "Fastboot block interface name (mmc, virtio, etc)"
>> > +
>> > +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>> > +     int "Define FASTBOOT block device id"
>> > +     depends on FASTBOOT_FLASH_BLOCK
>> > +     help
>> > +       "Fastboot block device id"
>> > +
>> >   config FASTBOOT_GPT_NAME
>> >       string "Target name for updating GPT"
>> >       depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
>>
>>
