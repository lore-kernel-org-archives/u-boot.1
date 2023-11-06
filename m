Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15379C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432F686F05;
	Mon,  6 Nov 2023 18:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nXd2XtJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA4C86DD2; Mon,  6 Nov 2023 18:25:00 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E4786DAF
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso8108103a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291497; x=1699896297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfE+b4DsMiK+KVS1c2YYcH2Sc9RzoDo3Z7vXaLGGzb0=;
 b=nXd2XtJbA424YpVYDR0WA+Glq5e7mIipwyMHQjV4fLKTNlHerg1aKGqZd3CAdKNiYV
 GiDeT60bPdhI6nS4xjCv5hyfIjhO/QxnDL6NjMhSs/4sGMXn2FKyEezaIW35fb2oIefV
 oyFRd3h0yxG0j4FS1qYi7fShr8gqfQTpkZK4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291497; x=1699896297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yfE+b4DsMiK+KVS1c2YYcH2Sc9RzoDo3Z7vXaLGGzb0=;
 b=WjiuyAhnbd7yJLbi/HwLH+2yvSr+GHYkILmIzg1m2KOzU3yG+UYA5e0KUijoBiuiAI
 oLA/OHOyH5qTF/xT+tOCa0AvWggSfbBqJcRgAq24iCc4LIreGUj8HBMCWuJfvMwFLY+z
 rbhWDuUTEHUYn+yOxnUfBgJMq5xCaNRJ41+MpSl6XLNtLQKd42c+E4itXuPPGj7HKL+1
 vhJGWW5Ezxu41sS2tYh5y8Ubzm3l/exKVQ5kBkRwr3YFFF/QlY9rZQnJrGOrKWrVUdK+
 M/gUw1H/BG2Rnw416QfhE12Jh+PEtXRFlbq23oTKjtE4O5P/sVlTFkVccM6cWH45FCQ0
 SAFw==
X-Gm-Message-State: AOJu0YwmkeXPrFRxcDc7BajLlvpGNZG4xQj9WRpptdT8PVNXfvCp6c//
 ZWM6ibIHXE2b8TQj+f1fHy745g/CXVE8hvdDgFZlxkNKJy/FFp2e8jY=
X-Google-Smtp-Source: AGHT+IGR9vfQGw5DnzWLiNDg6u7rzumi8+7P5xsMlbUnGmjjJGrLL5MOyvm2kIPkDHD60Sr7WMrSGlRY0570bPAkh3U=
X-Received: by 2002:aa7:c68f:0:b0:53d:b59c:8f91 with SMTP id
 n15-20020aa7c68f000000b0053db59c8f91mr24420486edq.27.1699291496844; Mon, 06
 Nov 2023 09:24:56 -0800 (PST)
MIME-Version: 1.0
References: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
 <CAPnjgZ0zjD+vrsyHkRpAzatZvA7Cv5-9Q+96O1mUN0Ei4H70uw@mail.gmail.com>
 <891544b36a1a9a1cd62345f341828c144e7f1ec6.camel@physik.fu-berlin.de>
 <CAPnjgZ35bJSBE_HqVxh_fb42AYm+vYmx-oyaDQzXqcsmqFvHxA@mail.gmail.com>
 <1b27e5f825851f6a3c0c198c0b42e50bc36f67b8.camel@physik.fu-berlin.de>
In-Reply-To: <1b27e5f825851f6a3c0c198c0b42e50bc36f67b8.camel@physik.fu-berlin.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:24:45 -0700
Message-ID: <CAPnjgZ1PmHzB1jYRwjDUiUAydSvS=-Q50mzDLdHROr2xA1NYWg@mail.gmail.com>
Subject: Re: Need advise with u-boot on SH-7785LCR
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: u-boot@lists.denx.de
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

Hi John,

On Mon, 6 Nov 2023 at 15:00, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Simon,
>
> On Sun, 2023-11-05 at 16:29 +0000, Simon Glass wrote:
> > No, sorry I don't have any idea about that. You could check the
> > MAINTAINERS files in U-Boot and Linux for other people, perhaps, or
> > check commit / blame logs?
>
> It seems that the flash memory is mapped to block devices by the kernel:
>
> root@tirpitz:~> dmesg|grep -i flash
> [    1.592000] physmap-flash physmap-flash.0: physmap platform flash device: [mem 0x00000000-0x03ffffff]
> [    1.604000] physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000001 Chip ID 0x002201
> [    1.632000] Creating 4 MTD partitions on "physmap-flash.0":
> root@tirpitz:~> ls -l /dev/mtdblock*
> brw-rw---- 1 root disk 31, 0 Sep 30 12:35 /dev/mtdblock0
> brw-rw---- 1 root disk 31, 1 Sep 30 12:35 /dev/mtdblock1
> brw-rw---- 1 root disk 31, 2 Sep 30 12:35 /dev/mtdblock2
> brw-rw---- 1 root disk 31, 3 Sep 30 12:35 /dev/mtdblock3
> root@tirpitz:~>
>
> So, I assume, I should just be able to write u-boot.bin to /dev/mtdblock0?

Maybe, but you will likely brick the device if you have no other way
to write to flash.

Regards,
Simon


>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
