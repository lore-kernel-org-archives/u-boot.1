Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C58DE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD21C80619;
	Fri, 10 Jan 2025 14:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L6B0V9BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236E5800D0; Fri, 10 Jan 2025 14:41:20 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86548069A
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2167141dfa1so36160425ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516476; x=1737121276; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Uw4Z1gwZMxNgF1uw6q9X5OrAPKBq2CtQz4ww6j6LbM=;
 b=L6B0V9BAPHPBFGL4kkA0F4aJdHaw+O0RBgxqKC33Yob0vx6GNFTkC7A+9SYmxRQxFv
 N+XTiFxCjEF/z3sEFbhlDnoQVkfksCtoGn+6aiyfkj/6OJNtHNUCwy3nsQWGvZ7jlQGx
 uLni+jwJ1ZHSNEKoZF5ptlbptIwNoBc3ybsZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516476; x=1737121276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Uw4Z1gwZMxNgF1uw6q9X5OrAPKBq2CtQz4ww6j6LbM=;
 b=XfXbXKd7ZghZvv4VZi3uHpDpvEXEcavGUUIytYBcLh28dU96TOK+3NERoQhigolKAg
 UejKQWrgSu4mbmpBmVzpq7yj+VHWkLY1M3HAY2VoS0BtrGJ8Kt5198zcTmkvHWNC8Bpp
 wuyRaVdJqc8cPNhrZkPxQDap8C6HU+rzKA3s2x1Djky1U/LZyIq3nTqHLQZlP1cW1oh5
 J4oguZ6xh3UoSeTmRghn3E+edWx+Gy2ygeiD4G2ZcKkIMadkEit58yjSQFXNWplDIa4E
 nXu8D7gkO5M2tSCNYNAHUwp5FyOXWazkCMh7gw+2R+QhLqH/VSPhPRUPMeLSWC8IM6Tb
 Exdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNYvNqyEYaryJTiy7Y4sZ1Ll2CP7Hjo2vQMZ0E6aKW3rBeZ0gcHSlVvxa065sFKqFtlrDs8FM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh2P6DsXsEixvX3XS9n4ZCHX3oTKUZEAj4fpnkCxF57I+fzR/f
 tTznk3+NOxX7tuS7Zq4lDPONquUqjOAIMZc+Z1E3rzDREVLNZRj2YUOYYYfLcMbeTQ62mifSOrH
 l/KFr5ByFx3hlHKc/iHTOkgh8NPZB6yGvVXri
X-Gm-Gg: ASbGncsGAPtP82jwr7aPBycy0eVZ7eQRjo6TFjpz6P2PxNkk6bnK6bw4XMoTMkm13nO
 yoobvEeIFk1xNEkWvDxP2lgDNqRdwtS4ROaJn7T8=
X-Google-Smtp-Source: AGHT+IHGjWSKj7QC7HV33Yfo4G6z5xgnBSx3hfhxI6ZOupVa8DltPpPkBjSBllWgi0Wyi42AB/YCBVyLwNFGWyXVLIM=
X-Received: by 2002:a17:90b:2c8d:b0:2ee:5a82:433a with SMTP id
 98e67ed59e1d1-2f5583add61mr9240812a91.17.1736516476279; Fri, 10 Jan 2025
 05:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
 <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
In-Reply-To: <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:40:51 -0700
X-Gm-Features: AbW1kvbLNcf2rjO4umhT7wyJx1W0iJ-UeLluhSmiTpTjvUTtZQwQGhypSk8K75c
Message-ID: <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 3 Jan 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 06.12.24 18:30, Adriano Cordova wrote:
> > The command bootefi calls efi_init_obj_list to do the efi set up
> > before launching an .efi payload, but efi_init_obj_list is called
> > only once. There are some initializations which depend on the
> > environment and should be done each time a payload gets launched and
> > not only once and can now be done in efi_start_obj_list(). A motivation
> > for this change is the following order of events:
> >
> > 1. Launch an EFI application (e.g. bootefi hello)
> > 2. Change the ip address
> > 3. Launch another application which uses the pxe protocol
>
> Hello Adriano,
>
> Thanks for addressing this issue.
>
> There are a number of events that can lead to updating the IP address:
>
> * EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
> * EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
> * EFI_HTTP_PROTOCOL.Configure()
> * command set env ethaddr#
> * command dhcp
>
> All of these events require:
>
> * Updating the relevant ethaddr* variable.
> * Updating any other references to the IP address.
>
> When not only considering EFI applications but also EFI drivers
> installed via the bootefi command all of these events can occur during
> the runtime of EFI binaries.
>
> Function efi_init_obj_list() is used for setups that are needed only
> once before accessing the UEFI sub-system. It is not able to handle events.
>
> If we need to update any internal UEFI data structures, we should do
> this instantaneously when the event occurs and not when executing a UEFI
> related shell command.
>
> U-Boot already has callbacks invoked when variables are changed. These
> are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
> callbacks' to list these callbacks.
>
> You could define a new function to handle changes of the IP address and
> invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
> U_BOOT_ENV_CALLBACK(netmask, <function name>).
>
> With lwIP we can have multiple network interfaces. Each has a different
> variable ipaddr# assigned to it. We will have to extend the concept of
> U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
> find_env_callback(). With CONFIG_REGEX=y regular expressions could be
> used for this purpose (cf. include/slre.h) but we should better avoid
> the code size increase.
>

I have been saying for some time that EFI_LOADER should make use of
U-Boot's existing tables, rather than creating its own duplicate ones
with extra info.

This seems to have been understood as 'hang the EFI tables onto
existing data structures', e.g. efi_disk_create_part(). But this leads
to duplication.

Perhaps the EFI_LOADER init should be quite small, and be done each
time an app starts, to deal with the 'current' state of U-Boot?

Regards,
Simon
