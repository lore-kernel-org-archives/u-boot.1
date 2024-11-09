Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2DCD5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44840891E1;
	Sat,  9 Nov 2024 18:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NwJ94WzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B678920C; Sat,  9 Nov 2024 18:35:04 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03D0989247
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so791277766b.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731173701; x=1731778501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1QeSL9cYX8YWnMh5btRXbfq5dX21BQXGDUEyKLEoxg=;
 b=NwJ94WzWrt/1yw1XYh6kSpsbuMgw+j/jbTsRyzHtwejtMF3TLNmqJhDmn5F34kAb7w
 TkljFpL/u1m4yvs4IlEtUyNfvHFSK7JXGLJGDd3o5LT2ybvCGr3/b+y8cS/UXGsy7ANd
 nZeZlgTOEmQoVmP0Gm4YPFsLKBhk3wgUD02A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173701; x=1731778501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1QeSL9cYX8YWnMh5btRXbfq5dX21BQXGDUEyKLEoxg=;
 b=exssiT41g9zNGPrakVYUHjJdcnupxPsgm0NPIDCmb6SHJPObcGeAVQmuuOAjUxY3La
 zNCbf9sbG1JcAXkdBGo6FQSYix34YtQ79U9rVpYb0gCwaRWh/RfZet8269xlBwcptCZK
 2sdsPNZrSo0pwEWMjgQl6+SC3qsz51YsfTgyilkJqxb634pRewqlWPYwROmAQz18wozq
 YwkCmat7QgPXZ97O/2Tbmhb5Q9Nv1w4tcIgWnAF1nijBkeupaSHM7Kq1tiGxt27nwQ/S
 5WyTcL6uqgD/Mgf3cwEPya5jwmhTvf4R3wnjZ23vfBwo+kZejjKetNI3EZ+K6JENTUwb
 ULUw==
X-Gm-Message-State: AOJu0YyEAAas0EHX0uJCDezT4ud44ev5YziMGHqsVzXE7POTnk+Cm898
 HVu0mqiOAunxMcUGuStobY/VcKAWi8kAavlnmWKHaIyEBACrIw+P0yCeUmlxpUmxaSyuaUY3Edz
 J5f7cSJpWY18pJoYmDRPDj0jmndLu55Ui/fTr
X-Google-Smtp-Source: AGHT+IEAbCLu9LK2ZEaoKnuBAg4RIoEcRcAid33e75BNJqH91BM2rlhRZ7RL5nlnX0BYDn0tmJL8CsIh2hgZBMehQno=
X-Received: by 2002:a17:907:2da5:b0:a99:fbb6:4972 with SMTP id
 a640c23a62f3a-a9eeff97fe5mr715867266b.25.1731173701139; Sat, 09 Nov 2024
 09:35:01 -0800 (PST)
MIME-Version: 1.0
References: <Zyv8zn2oGmmKz5XU@vodafonemail.de>
In-Reply-To: <Zyv8zn2oGmmKz5XU@vodafonemail.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Nov 2024 10:34:49 -0700
Message-ID: <CAFLszTjGEVsFXdLNQdfD6mNNFC76k+4S0VZLJfbMNO7s1V5K6g@mail.gmail.com>
Subject: Re: SiFive Unmatched: Linux kernel doesn't start (U-Boot 2024.07)
To: Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

+Heinrich Schuchardt

On Wed, 6 Nov 2024 at 17:53, Yuri Zaporozhets <yuriz@vodafonemail.de> wrote:
>
> Hi all,
>
> To all owners & active users of the SiFive Unmatched board: do you have success
> running any recent upstream U-Boot on your system?
>
> I use the default U-Boot from Ubuntu 24.04, and it boots GRUB and Linux
> kernel just fine. Today I flashed the unmodified U-Boot 2024.07 (compiled with
> "make sifive_unmatched_defconfig" and OpenSBI 1.5), and the Ubuntu kernel
> (6.8) doesn't boot at all. The last message I see on the console is:
>
> EFI stub: Exiting boot services...
>
> Adding "earlycon=sbi debug" doesn't change anything.
>
> The same behavior is also when GRUB is excluded from the process:
>
> => nvme scan
> => load nvme 0:5 $kernel_addr_r /boot/vmlinuz
> 38603264 bytes read in 47 ms (783.3 MiB/s)
> => bootefi $kernel_addr_r
> Booting /\boot\vmlinuz
> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
>
> Is some additional patch needed to run U-Boot on Unmatched?
>
> --
> Regards,
> Yuri
