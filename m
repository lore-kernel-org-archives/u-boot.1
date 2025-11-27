Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EFACFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E68F839A8;
	Thu, 27 Nov 2025 08:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZThjtXy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5AD842C4; Thu, 27 Nov 2025 08:20:17 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F9683984
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c76607b968so175904a34.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764228013; x=1764832813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=er6RYgnKoAQdcHeqWRHEWdIF+kWx9byMDB2jplJLvgU=;
 b=ZThjtXy8Zu0CddnCh504HZDY2JIatODBA3KwghHQFgH7e75OpknMBwXGRs1Qixo4Ce
 wNhZcJYQVFRfpI12Bjq7V/WxDarF2OgDlUlOQxJSrJYwHbUANCukHpGDAerC+pou/5Ku
 SPjfWW2msEyfhQflrGCJ4ja5+sT7owK9ZeiYNFnyVpeFWKWBkk2ux+W8gMw3NHMSmcOJ
 rdBN1/EEeXSCekXeGDh/vLhgXqhyib/lGn97TyIhQC+Lc2ufwMQ0lOnhxVoyE2Iua51e
 HPNOB57vHTMtgdzIcUpl0DdjAxkAwvJ4dS5t8cdGDSLZDiv4v0/Spf8hB/01G4UkrwIW
 9XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764228013; x=1764832813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=er6RYgnKoAQdcHeqWRHEWdIF+kWx9byMDB2jplJLvgU=;
 b=mZX1JvrFIJjQSunzh9MdbNOXdV4GyDCOlrw8axhECBBTQaM3nytbevA0oEP9yj0Dwg
 n6LrfBwHOXXW9wV4l2G7Ur7L9B70fO1JhQ4bvgje39yZe/e699YJJiu1FZE785jKxrr8
 /FYOJlu+AJ4gR/233EFEIRVD5tdliz3Gnq/vfSjZVgAOd99rSuKTneVq6a7y1WpWlM9i
 3T8BKMF7mkIpW8yBNlgbxg6XFMQe1PKnC/QTRYFz+TDng/QpZsU4wuhNGfJxdAvIhbRL
 u5BYifvuym1a+4J2gUnsh/rM4Mr0UpwjN6mbNVOY8rBkGFdFZmXn/V1bizDxuu2OyDEi
 bPow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyrWcsS26bZojWtOdalVDNfA6UC1pPMVjkWNapPWYwHQLIJbOrpjgqRizXRUr0180XFF4IG2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxLcmGsr2alPlqMajBA6kLZg9dxoOy2l4iednjfkvPjN/RvVidX
 1w4o1H+UVAvUSnbxnUaqVawnsxA4Se+DBRV0cFMiaJKH5wWrvRRvO0pue5fLk/XTbsrJQX44Tm9
 fPruWEwcb1vOB7HjCFkYQF8312rN+52Q=
X-Gm-Gg: ASbGnctzHq30Y3sz3TMitWu1c8D3BHUuVfLK5xRkM5G4Afa+SlIoG5FR/XlJB4flaK2
 OFdA5hWFsw11PlKPK+Eg+qYJUZhQjoMiqVzGoAsCYKshCrKNuyyHzno2pV/Lclb8Daf3oGrCIiF
 pejxgW8T8Z5OLsKBxefblh4tBws+amyO1pcjgI8TMLPtCdlzRrQ3t/L8QE6J1FPtVu8GH5qFgqR
 eoIprx/3i6Ipv05SMWwb6LhZOVAoalPlAC9rOgbmbMaTicKAhbYPXdhlAPLkHbgw3CIEnA=
X-Google-Smtp-Source: AGHT+IFYToVo/r/lTJm7/MwI/coXkLnPEgRaitANKEZTKmSKtFUEWTUh6D8creGFh2wpdc0jZ1UrAUGs/0yanHJhVfg=
X-Received: by 2002:a05:6830:310e:b0:79c:d43:52f5 with SMTP id
 46e09a7af769-7c798f7ff5amr10952385a34.6.1764228013488; Wed, 26 Nov 2025
 23:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
In-Reply-To: <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 15:20:00 +0800
X-Gm-Features: AWmQ_bmYw9d3QbcB2Oa2BJpQ4mAIo8A6XY9t5Vcw6ZGv1zH77QxpnlghL3_pd1Y
Message-ID: <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

> I shared our wks file [1]: We create a raw partition in a legacy msdos
> table, set its system ID to 0xa2 (via [2] when we use a hybrid partition
> table, or classically [3] before that), and put u-boot-with-spl.sfp into
> it. SPL is picked up by the romloader, but SPL in upstream completely
> fails to find u-boot proper in that partition. And that is first of all
> because SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is enabled by default which
> ignores any partitioning and only uses a hard-coded sector. If one
> switches to SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE mode, other
> bugs after 2a00d73d081a surface like no longer built code or wrong
> offsets inside the partition, and you also end up without u-boot proper
> being found. Whatever other partitions or partition tables exist on the
> SD card does not matter for SPL loading u-boot proper.

Ha Now I see what you encounter.
No wonder. Because it is not supposed to run like that.
(i am no software experts)

I might be wrong, no shame on that I do simple software only.

So what T.F. had mentioned all aligned will all my build and
no additional patch is required from first place.

All there TYPE, #, OFFSET can work.
because it never uses the old method of combining.

A2 <- only SPL
FAT (boot) <- u-boot.img

Actually I mentioned this yesterday in our discussion. Maybe you
skipped that important information.

All board defconfig after 2025.05 is outdated; no one syncs those.

That's why I comment that the file "u-boot-with-spl.sfp" is misleading.
You have to turn on "FAT filesystems" change MMC boot partition
accordingly.

This is why I say this patch is not a must and combining SPL+UBOOT
to A2 is not really needed but only for backward build flow compatibility
concerns.

Bests,
Brian
