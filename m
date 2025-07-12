Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622A1C83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 06:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7E6803DF;
	Sat, 12 Jul 2025 08:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lVitjnUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E543806D8; Sat, 12 Jul 2025 08:28:48 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9286580194
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 08:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e82278e3889so2080761276.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752301724; x=1752906524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zw7PFyLlqwlEyhotu8Y4kWFF9W3a6ItSoNdnazFR0Zw=;
 b=lVitjnUB553S2hY+lF94t/ytaAWmvdEE8CoMbfrkB5uoSz44C5mg3Bw4O3QrOH0GGF
 u/qlxQL60e4WIhmsjurFVGTnVNtEJC5kTAuX7kiDvIz5PYvy42D2w5pRhnsqWnLagXDl
 nV+HRXKwF2MhewrnKV3zm0szps08ezRuOBtYUIzsGiNQxb6A1oNkbix/9aYaCAgfZnQE
 c5VFczxfsbxEmHyhDrBlFP+kNSEhh+WYRdkIXUYIsnR2WnH79odSf+82iMQqd2VLiF5m
 rGU9fEZCtPoAmxw8dCITvKAl2D56H6mO1PeP23oEOx+WzRVdRzaKbNo8AE4slzKNeasp
 UToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752301724; x=1752906524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zw7PFyLlqwlEyhotu8Y4kWFF9W3a6ItSoNdnazFR0Zw=;
 b=MGH7C1hq7F7T7R2jzvkkhRF7ArvXTfTGYK8r2eLDWzttnHIapho8+Qwf2QTqC6MKFN
 WVwwTXnaHnr6dNetZhH655HVuM3lDWVzPv3PYrRbZ2CW+rg2qLawiJRXfozJNvf7p+xU
 HTiinxk+92Z4XILupqkX/wmt171E+x8x63vk1AxSqIc+aR8S4LVZ4r+6KHx2gOk3zaKZ
 HFZX0J7CI9GeAm5HmUfFA1T9shlr8mW/ybc8PenAeEedPtqaTxzWTpCvkjU+Nis1QlmK
 z//D3smpXfjsQyhe1zTqdWLtDaieIWTPhH3rPeBSVZ9aQpfXMj2wc3J3IO8ii8lcO31I
 DRfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXejJe+EUP8+4fY81XZcyRCA0vh6Y984IuJWhW3YpZac2H8imnBlHu0TPK9yA455++C6z31/W4=@lists.denx.de
X-Gm-Message-State: AOJu0YwspAvswP9l2qM05skhc3Fyq8jLYCg+9wH/T1S3W/qJMKDNgXnz
 Ymq/W5UlBgRmaq6Oq2D8SG7apGZ7Mf3cm9eIOy3h5TPfoUGzysVGAwPFRHELv/PYn6zOEDl2MMs
 Xi3A9k+6z7KWu0XouE0RyseABQzs/mg6AMGqXhkA21g==
X-Gm-Gg: ASbGnctFiFCAwAaX/BYyfO+FSc+4Rgb0syL4cgdvq0xdbwhTNFHbHV6cVwmRqmZYz34
 y2Q56rxNnm2dNZpouugyodqL3j5dPcop/tfQ4GPOjS76eTqllVxtBJvzUVsz/ZxfvPK6pvFGDUo
 5OLoWp3uqoVoqieD4HJePfPR3jqjLS3jhomMcsFD0O4MiQSaa2bacX8tDy623Zn8UoPVUSv4jz5
 HsHo3U=
X-Google-Smtp-Source: AGHT+IG838uQISXn+7ge5jNViq6IA4BwuIjBUgMuwL8VWUqbUlAr3NpV0EH5PDH9reV7AiLr+e8xQ+4+LIcLKE+gXB8=
X-Received: by 2002:a05:690c:ec7:b0:70e:87d2:c2cb with SMTP id
 00721157ae682-717db2b051cmr70966717b3.31.1752301724333; Fri, 11 Jul 2025
 23:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250711185512.2250368-1-trini@konsulko.com>
 <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
In-Reply-To: <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 12 Jul 2025 09:28:07 +0300
X-Gm-Features: Ac12FXwbSlGoynvHgWG-I6esyAcPgw6QjI0mJ7C5hz1A1cm8wZ7mLPb59FAd3ec
Message-ID: <CAC_iWjJQh8M8KsscLb6JXkFH4t+wr+oi9xX=gko6ztPm2YuQWw@mail.gmail.com>
Subject: Re: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Josef Holzmayr <josef.holzmayr@northern.tech>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich

On Fri, 11 Jul 2025 at 22:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 11. Juli 2025 20:55:12 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >As part of upgrading to QEMU 10.0.0 we discovered that the EFI loader
> >tests would no longer pass CI, on this specific platform, while still
> >passing on real hardware. Upon further investigation it turns out that
> >on ARMv7 we rely on some undefined behavior with respect to enabling
> >unaligned access. And while this is seemingly fine on real hardware,
> >QEMU is now correct enough in implementation to no longer allow this. In
> >order to not rely on this undefined behavior we would need to implement
> >some MMU configuration (and then ensure proper tear-down possibly).
> >
> >At the moment, the most reasonable path forward seems to be to document
> >this and disable the support here.
>
> Where will we document the issue?

I think we can add it on the EFI documentation? IIRC we only enable
the i-cache not the mmu + d-cache. I can double check and send a
patch.

>  Does it imply that we should discourage EFI use on all ARMv7 systems?

The spec says the MMU must be enabled, so I think yes. I thought about
disabling it, but that's too strict.
Perhaps someone that uses v7 and *needs* EFI can look at enabling the
MMU with a simple identity mapping.

>  It would be good if somebody at ARM could find out if they ever delivered designs that match QEMU's behavior.

I'll ask around and see if I can find something


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Best regards
>
> Heinrich
>
>
> >
> >Link: https://gitlab.com/qemu-project/qemu/-/issues/2944
> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >---
> >I believe at one point Norther was using this platform, in QEMU, for a
> >reference platform via EFI for using Mender. As such, this would likely
> >make this platform not useful anymore. I believe Ilias can better
> >explain what needs to be done to fix this properly but there's no one
> >with the available time to take care of this in the community at large,
> >and this is part of what's blocking updating QEMU to a newer version
> >that provides other platform and feature support we do want to use.
> >Alternatively, we could just let this platform go and remove it, if that
> >path makes more sense.
> >
> >Cc: Josef Holzmayr <josef.holzmayr@northern.tech>
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >---
> > configs/vexpress_ca9x4_defconfig | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_defconfig
> >index 67adba437bfc..6ebb37fcf2ec 100644
> >--- a/configs/vexpress_ca9x4_defconfig
> >+++ b/configs/vexpress_ca9x4_defconfig
> >@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="vexpress-v2p-ca9"
> > CONFIG_SYS_LOAD_ADDR=0x90000000
> > CONFIG_ENV_ADDR=0x47F80000
> > CONFIG_SYS_MONITOR_BASE=0x40000000
> >+# CONFIG_EFI_LOADER is not set
> > CONFIG_DISTRO_DEFAULTS=y
> > CONFIG_BOOTCOMMAND="run distro_bootcmd; run bootflash"
> > CONFIG_DEFAULT_FDT_FILE="vexpress-v2p-ca9.dtb"
> >@@ -20,6 +21,7 @@ CONFIG_SYS_CBSIZE=512
> > CONFIG_SYS_PBSIZE=532
> > # CONFIG_DISPLAY_CPUINFO is not set
> > # CONFIG_DISPLAY_BOARDINFO is not set
> >+CONFIG_LAST_STAGE_INIT=y
> > # CONFIG_CMD_CONSOLE is not set
> > # CONFIG_CMD_BOOTD is not set
> > # CONFIG_CMD_XIMG is not set
> >@@ -55,4 +57,6 @@ CONFIG_SMC911X=y
> > CONFIG_SMC911X_32_BIT=y
> > CONFIG_BAUDRATE=38400
> > CONFIG_DM_SERIAL=y
> >+CONFIG_FAT_WRITE=y
> >+CONFIG_FAT_RENAME=y
> > CONFIG_SYS_TIMER_COUNTS_DOWN=y
>
