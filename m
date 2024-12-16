Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D540AE77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 13:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0326880141;
	Mon, 16 Dec 2024 14:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fkg8BE5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E7480192; Mon, 16 Dec 2024 14:14:22 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDF880104
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so5634720a12.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734354860; x=1734959660; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXEj4vf/iEhviZdcKBHrxRe7ld54SOHzsk9xaaFGB2k=;
 b=Fkg8BE5ebC7iGh7R6gmleHxe/vw8L/ypOFr23tVACY42fUi64qm+z+roUayi+6PDLF
 z6t5KnEfHwQvMfqyNyACgLjgPUo9FfzznsKXLnOulPjAhWB8iiPo2wA1Qg0ueMjhBNe4
 HNLE7Fi6LTdr912CIatZFLL5/NqOLJLuq5/nn2TvuD2912UpPPrgXiicg3oJNQUkIZ8z
 5sMbswkJqD1rqp18ozU5YgdbNtxyDBbdYYqTN/g69o8KByXIvuA/iaXCGW10nBveGgK+
 CxMGaUZDR+YZYzA7lFl6YLAEn3oAFCHUmZkE8johkxkOltyznYuGuSOZv9m60Qnki9tj
 j9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734354860; x=1734959660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXEj4vf/iEhviZdcKBHrxRe7ld54SOHzsk9xaaFGB2k=;
 b=Kk8lXIQTm3AWM+sfTKLN9xDkvs6OgYgMnous2xvkJm5kqf6HXt6NVf6S1k/OjVTwO3
 UoRZJgNWkZaeLg9CLaffoW6NzY6C0Z+IKyHk0Pz63tN8Z/NnwVDW1Y3CEPrU8i1fN+xV
 tW/tbe6bkArauK7AO+7c24Wz/shkd9JNB1yKVEdfYR7SkARvJvRSAr7LXxtsRpBB9fkG
 gOgLatNmvxgCPS8TwyqHD/KgqHmcHtt16zo28CrD1/R3QtuIrE5JMfdSdKC0W10nnZra
 eoW54uG26lghUnqu4Xrvn5WLoJGCxTYB629YUPM2KaPSevp3Ab8MqnyowdwR7D0eKx4S
 3ieg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPsRWtewkIcH6tpgq6zF7V0JcQdQxlJplexG4/wsDA2QhS+KcDvpiA8N26iUs4YK0q3Q8UrDY=@lists.denx.de
X-Gm-Message-State: AOJu0YzdM4KP6wg6EPh+jRJlnWgSNXWYJzOxFRMtz2gOeRI0j9/lSBOF
 VwV317qCXGnzF6uZBi18xUN4i5sVe0iWrGRSQUJzjdcSnKtpNi4sIxvbMcW5RKZFrXIXWDN6gCS
 RVKNWDkLt3WNLEe/HZLGt1/6JQ9kK6wGB3F0Qrw==
X-Gm-Gg: ASbGnct6Kz9BEFDrMjPKkqQCPFBzxLB2C4PPRHPWOvvFJ4aALKamd3un6XS/shkjqHD
 Fw0YfntfUktMyVD2gPyiQNFIdQY3KLhPDMjU/qw==
X-Google-Smtp-Source: AGHT+IFg3KM0n5I38IYntLoO4SATwk+zNXyTWyEBo4/7TM8qIeVJgS7JTwJUIgqowHm6gTLORCHdbBTlWHgQaEVfzHc=
X-Received: by 2002:a05:6402:26d1:b0:5d0:bcdd:ffa7 with SMTP id
 4fb4d7f45d1cf-5d63c2efbe2mr11270168a12.3.1734354859988; Mon, 16 Dec 2024
 05:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
In-Reply-To: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Dec 2024 18:44:08 +0530
Message-ID: <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
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

On Mon, 16 Dec 2024 at 17:12, Jo=C3=A3o Paulo Gon=C3=A7alves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> Hello,
>
> U-Boot is not able too boot on imx8mm and imx8mp and gives out of memory
> errors:
>
> U-Boot SPL 2025.01-rc4-00041-g50334151c020 (Dec 15 2024 - 14:02:46 +0000)
> Training FAILED
> DDR configured as single rank
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x4802f000, size 1116
> Need continue download 1024
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.10.0  (release):android-14.0.0_2.2.0-rc2-0-g7c64d4e86-d=
irty
> NOTICE:  BL31: Built : 10:35:32, Aug 29 2024
> U-Boot 2025.01-rc4-00041-g50334151c020 (Dec 15 2024 - 14:02:46 +0000)
> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 24C
> Reset cause: POR
> DRAM:  4 GiB
> Core:  183 devices, 31 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> out of memory
> ERROR: Out of memory
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... out of memory
> out of memory
> Adding partition for mmc@30b60000.blk:1 failed
> *** Warning - No block device, using default environment
> out of memory
> out of memory
> Adding partition for mmc@30b60000.blk:1 failed
>
> The regression was introduced with commit 1a48b0be93d4 ('lmb: prohibit
> allocations above ram_top even from same bank'). Reverting it, allows U-B=
oot to
> boot again. The issue seems to occur on modules with >=3D4Gb of RAM.

Can you show the output of bdinfo. And also print the value of ram_top
while booting the board.

>
> Do you have any idea what might be causing the issue? On our boards, the =
first
> error occurs in efi_init_early() and then in initr_mmc(), and it happens =
during
> memory allocation using lmb.

We are not allowing allocations to be made from memory regions above
ram_top. So it would be good to know what ram_top is on your board.

-sughosh

>
> Best Regards,
> Jo=C3=A3o Paulo Gon=C3=A7alves
>
