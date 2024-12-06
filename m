Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F478E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA38F8921B;
	Fri,  6 Dec 2024 20:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZX9hzswi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262E388F0C; Fri,  6 Dec 2024 20:18:06 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DE28921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fbd9be84bdso2364454a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512682; x=1734117482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3ywdM7yXh6y/8i5MleNnrOMBhbaUzzsHnExLeIf7ZE=;
 b=ZX9hzswiRZ2vt73FZQZ9l7MV79QVZcR0vFHpnSGI0BCNNeQk3QZmsVWUE7dDbAaqGl
 A+WOc+VudUD41bmqGScvNTJJvg3FCOCp2uxyb0zZip89GXJmtyJSmzNevtW6uZXDlItq
 qaSfbpewKZNpmQZxCPIRXgfC1wBu+N3aeR08s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512682; x=1734117482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3ywdM7yXh6y/8i5MleNnrOMBhbaUzzsHnExLeIf7ZE=;
 b=Zb2vm2i1d43NxjNV4EBk7ASQS3hOXwwuax0TSvqiGjIJfQVH931CeWrIZ6BkY65iQA
 DXIgf+1TDRdM1ilAcncfbOJ3MHqLClxnIcLX+8Yu2jozBT6UPxHV9C+A83WXa92tM8VL
 gcMJxUdWl6I7gB8c1QiYXeVJrLTbm0m3Y8Gut/8kQqEpuhuNVZ2K4HCq3DbyOi2ZpopG
 0r6J9BapuFcx7Gmeqo7sC55YwmAQoBX3v5bwRG5HOJBnEu7/W9VTqO9gXVmOQrAkxtTv
 YfyVlZ+9WmGV0HoT1MbHjD9NTwe3xk5d/nDLaaF6gC1ZFU85MhGbJJ6q00nWekxY8uNY
 PAHA==
X-Gm-Message-State: AOJu0Yw5RTXDFWbJTmLzRusIO8t1Hg3T6am9SHgKGxnFU6uFaacv41LD
 ETjA+3Vvyx9FD742rZpzec/RzMu6N6jyfSjyBUybN4hx7BZaWz4/PlZ5kqgeGoUbxNDaoxjOxbf
 98KsTw/aB7ON43Um/IQcf/Rmt8YTM5HkLrFQx
X-Gm-Gg: ASbGncvg8U2DuCB3Yo1mqF7foTzypsZrIrembqi0uLHhJF+kdr117YCCOrzwxq/BEQA
 FwRz2jyG3UU3vTBOuilyBw8XTD3Ytmqnl
X-Google-Smtp-Source: AGHT+IEquHeYGIsNOSSpIXJTLJX2oMdq/YUCDE9QrwWP1YA634YstBuN1bQtYhtzcZ6l1azrMXO5A+pvyP0fmS++VSY=
X-Received: by 2002:a17:90b:520b:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2ef6ab10483mr6707964a91.29.1733512682489; Fri, 06 Dec 2024
 11:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
In-Reply-To: <20241206140852.GO2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:17:49 -0700
Message-ID: <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Tom,

On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
>
> > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > ramdisk, by expanding the available space.
> >
> > It also tidies up some strange behaviour with the provided FDT, where a
> > separate pointer is maintained to it, even though U-Boot has copied it
> > and placed it in its own space. This avoids strange bugs where it
> > accidentally gets overwritten when loading a file into memory.
> >
> >
> > Simon Glass (3):
> >   rpi: Update environment to support booti and large initrd
> >   fdt: Allow expanding the devicetree during relocation
> >   rpi: Use the U-Boot control FDT for fdt_addr
> >
> >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> >  common/board_f.c              |  6 ++++--
> >  dts/Kconfig                   | 11 +++++++++++
> >  4 files changed, 29 insertions(+), 18 deletions(-)
>
> My feedback here is the same feedback I gave the last person that wanted
> to update the Pi addresses, and I forget if they came back and did that
> (and it's in Peter / Matthias' queue) or not. Disabling device tree
> relocation is a bug and must be removed.
>
> After that, given the range of memory sizes available on Pi platforms,
> allocating the kernel / initrd / kernel decompression buffer at run
> time, ala mach-apple would make life easier in the long run.

Yes, of course, but for now, this resolves the problem and I don't
believe it creates any other problem.

The solution should not be board-specific though. Once I have the
bootstd files stuff is finished, I believe that bootstd will be able
to do this and I plan to do this. Then the variables will be unused
for rpi and we can just drop them for any bootstd boards.

As of now, we have 390 boards using bootstd and 381 using distro
scripts, so it is progress!

Regards,
Simon
