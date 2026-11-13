Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91844606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZPhX9CyW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Esrc0CeQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 648DE81567;
	Fri, 13 Nov 2026 16:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fd1O6iGSniSQ; Fri, 13 Nov 2026 16:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A0DA8156A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794587342;
	b=LV8vZdsg8Gxgpb4TbMTny15QfYxkSradgqwrOZqAYoxfA3MwfrQmA5qnjdT5mFXoIOG8
	 MUyJBEttuhSxWklFCBloLJDCAxvS4MkMy8PKE7lt5gMGrX3USB+CXmibxpmZRkBIyR5QT
	 g90oyMnCoDpE8wuhA8Uace88CLTDlpWZb4LvaihIYO0dcRqANEJYuTI1sO9w9IRE6tSb6
	 znhTv17MXSqvdKbZ3EjatbJAkn7Vh7x47idQLjjGqiCaRLwKU6eFajZ2nuzzEpBf/A82A
	 BTxGwyYO8jffnaGTrMSlJsFP/BwmdSBAVanJwJ0LMyoqTi0CfvD6QXEIWOSmjOAAn4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q5uA+rg9TCE04L6mrcUgHb8LxRSGrJza73fExrcUOlo=;
	b=dZBVzMkH68l9bQFc/IDItMzlt7BibJRYmpOwb5OByTQ3/FnSGuGz387bbA8JsSM7iybH
	 3+O6ivwKaJd/fmj7iaPHqCSIIvOVvZ/kCKDMHBCEJAcMX9Cj5up/hRzfVgu3AJRT71Zc2
	 NJEoGY2Jmg+Boox2gAdQwhJ6NJ4W2V2cEw+HcnhhyebtZnAIb91EhmJI9K5s1cuGobEXk
	 e6ItmWiUfxZKh4ngch8yd9d4P0GsInwJh9FUV+gU0lhVK/JwgGL6HPRqWbS6mAB1jB5v8
	 1JeHdaJSi4Yulmya4jdpD3UOKl6m2qOLQOQcb4weB//SfRDymm89xkAzNYheGSUSRmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794587342;
	bh=Q5uA+rg9TCE04L6mrcUgHb8LxRSGrJza73fExrcUOlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZPhX9CyWkdgTXXl/pRJBvOhDI2+0Ti02+QtCJoVMf/bK0vInE7tYmXlfxX++LL4JE
	 WucFsA48kq26USWfOQDg2DWOr9f1rv5yv+iFsijs1+FUVKccDSQwwrbVn3kZ6bl/TM
	 xHTWETHoqUAj9tGGUehUujb8n5OM+FrYeFEQc0YBGtD/1NB2Ey9NH1IAlbdNTR3La6
	 yVZCFNDrhKBMVkF+KizupUAkJq5Z06Jh8QV9sBuAGOMi2V8BfhMqWNppqExiNZGRd0
	 8bc52oTFpu2rIlMKjtyRe/h+la7q8yfRbSkuxQi88ttsUPIFpAR6vMFBywihSf5RSv
	 wYBK26wPYG92Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A0DA8156A;
	Fri, 13 Nov 2026 16:29:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 688872E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EE23409EE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19QShshIvLMe for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:29:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FF4B409EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Esrc0CeQ
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF4B409EB
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:28:59 +0000 (UTC)
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso1297673c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794587339; x=1795192139;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q5uA+rg9TCE04L6mrcUgHb8LxRSGrJza73fExrcUOlo=;
 b=Esrc0CeQ9+2XNlcnwKBkRn7ovqxRbwv3Fmw+nupRcpv1YXcJX9X9pm2s1E6/GCEY4v
 zKkavdDf5c4Xt4AsCKoHEZyh8s+p1DsYTKvpM5odNfAb/d6LfbYHrIJTcgnRxtecYK+D
 ZA+o1SIbUwF7Wex0XPkj11FXFbdK75XZD2YTzkcNAKVbRZzwAa1SSEv2T0XyArusbrPd
 H0DDwQap3Cg5qssOO1qpLDTPROKfX9Vo51DzUCAFuKbMzxOhesKeldnSKQymnhEbrzoS
 r073AIcpDj7x7rEplv12AlJINei40D2xSOSB1jYNETDPVJlkGv4Rnl8wmYKE/7nUBkIA
 vRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587339; x=1795192139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5uA+rg9TCE04L6mrcUgHb8LxRSGrJza73fExrcUOlo=;
 b=XT1+4Lf/Vpnrzl3dOrRww+3jIUMaG161ZinhG+6TypMI5O7UTfyuarN+/z0Dot6vHr
 yVYef+4D3FIZXyeUUn0dTsqpuP8J0c242wNYIB0Epanoact61qkj0NMmKO0bzWa+Jnu0
 DRlCy7waJqej7qF3P6l5IKcy2qKqvwFHBTa8/jWcijMAgxcZZxp4ocaQdScyYz0M5PiQ
 SFMDlbEoYcyzwPDwC89o0LhVMaV23QYKMDSw5KdCs0IM8p+fQaE4rPQrMGX7qGInK+l6
 tKJT6FftmxC/nsSD6GzPUROvXKRSv9J7O7RYirdiGJ63e2W+Z2jfHerP7scwmBYX9zYT
 UTLg==
X-Gm-Message-State: APuU4Z9+E8Sw9ww45yVo6X3/k76tAHAXimuICCxH/kp6JO3GWVTiDUHl
 j/a5KSBZ7tJnnjvEvtjtFgxUie+BM0SX3LIHb2FM4LZEi8K08ixcD83n0wSyxIQzusawCh+6pQV
 iBuJjK5Qu3lmlRGJYg4vjMzItvUbYcRKKEn5Q
X-Gm-Gg: AYBFou0oXboRBk3CjGtQs3jjaPocNcAMDdf++KDkotgL6UP9r5QPqSyeWnjA5onN0et
 U7XuN49nsOMnvan9YUItOgRx+FeUjaFSvc9NlwLR34mEqfrKnZu2UObc4FenIb27K6VqujQRbFN
 rB7SJKJR2syq228snIFukwvDX+nfMWVGO9gQGbR4Ad5S4448w7tRqos+9JPI8SzMnP2OzXZbkDu
 jbsnSkX+WafZ2p6D+Bftz+4eREvxQ/Dd1bv+4sDrcII3he2S94VIJhQI40FAF1sUWEQH8VHpLUn
 pXiGul4kkyJ4Sdjjmxo33ybOqzZDlsakjBz1hJkVwiKhd97EkKZyYwm+gp7/08TtDKC/8NKIRaP
 BrD4vELqF6K/stL3qC4Z7HkGEMv2IQK9opvtM6juKhz4nxviFJk7oh5u1i8ohoXUKxupCdcNuz6
 qAtCKyNrjTlU/l/MftIypYgA0HM+KLmg==
X-Received: by 2002:a05:693c:895b:20b0:36f:5746:3364 with SMTP id
 5a478bee46e88-37967ce04e9mr2516289eec.28.1794587338685; Fri, 13 Nov 2026
 08:28:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-wdt-tegra20-v2-1-b452b03bedb5@gmail.com>
In-Reply-To: <20261110-wdt-tegra20-v2-1-b452b03bedb5@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 18:28:46 +0200
X-Gm-Features: AclHuK-pCanWjq3TXVsd-ZCRlRNEC_xMfLG1kehr-0cexieSSxC_HNTowgo_k3k
Message-ID: <CAPVz0n0ujiyuPncTuAOqfQNvTzH7mgHoN-t0=nqiWmmVr5NwOw@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: add Tegra20 watchdog driver
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=B2=D1=82, 10 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:4=
8 Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The timer driver binds tegra_wdt to Tegra20's timer node as well, but
> tegra_wdt programs timer 5 and watchdog 0, which only exist on Tegra30
> and later. On Tegra20 they lie past the end of the timer block, so
> starting the watchdog writes to unrelated registers.
>
> Tegra20 has no watchdog block. Instead, the clock and reset controller
> can reset the system when the interrupt of timer 1 or 2 fires while the
> previous one is still pending, enabled through the WDT bits of
> RST_SOURCE. Use timer 1 for it, which U-Boot doesn't use otherwise, as
> it only reads the microsecond counter. Run it periodically with half of
> the timeout as its period. Clearing the interrupt alone doesn't restart
> the period, which would leave between half and all of the timeout after
> a ping, so a ping also rewrites the timer setting, read back from the
> timer, to restart it.
>
> As this has nothing in common with the watchdog block of Tegra30 and
> later, add it as a separate driver and make tegra_wdt depend on
> !TEGRA20. The new driver keeps the tegra_wdt driver name, and the timer
> driver also binds it when WDT_TEGRA20 is enabled.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
> Add watchdog support for Tegra20. This makes it possible to recover
> from hangs in U-Boot or early during Linux boot.
>
> Linux doesn't handle a running Tegra20 watchdog yet. Its timer driver
> uses timer 1 for CPU0's clock event device, which can reset the system
> early during boot. A Linux series that keeps the timer driver off
> timers 1-2 and adds Tegra20 support to tegra_wdt is under review [1].
>
> There is also a Tegra20 quirk that affects any watchdog reset while
> Linux runs: the watchdog resets the system through the clock and reset
> controller, which doesn't reset the PMC, so the power partitions keep
> their state. Linux powers the VDE partition off when its PMC driver
> registers it, and whenever the VDE is idle. If the watchdog fires while
> the partition is off, the boot ROM hangs and the device stays dead
> until it is powered off. Linux already works around the same hang for
> reboots (commit 8f0c714ad9be ("media: staging: tegra-vde: Turn ON power
> domain on shutdown") and commit 510f276df2b9 ("mfd: tps6586x: Register
> restart handler")). The Linux series either stops the watchdog before
> the VDE partition is powered off or, with tegra_pmc.vde_always_on=3D1,
> keeps the partition powered on.
>
> For these reasons I haven't enabled the watchdog in any defconfig.
>
> The patch was developed with the help of Claude Code. I have reviewed
> it and tested it on an ASUS TF101 (Tegra20). Tegra30 and later are
> untested, but tegra_wdt is unchanged apart from its Kconfig dependency.
>
> [1] https://lore.kernel.org/lkml/20261110-t20-for-upstream-v1-0-592344995=
1fe@gmail.com/
> ---
> Changes in v2:
> - Move Tegra20 support into a separate driver, tegra20_wdt.c, exclusive
>   with tegra_wdt.c and keeping its driver name
> - Link to v1: https://patch.msgid.link/20261109-wdt-tegra20-v1-1-d04bbc58=
29e4@gmail.com
> ---
>  drivers/timer/tegra-timer.c    |   2 +-
>  drivers/watchdog/Kconfig       |  12 +++-
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/tegra20_wdt.c | 134 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 146 insertions(+), 3 deletions(-)
>

Hello Artur! Thank you for adjusting your commit. Patch itself seems
fine, I will pick it into Tegra custodian tree. Question is if you
need it in upstream ASAP? Let me know pls. I have a few changes that
are not yet cooked enough to be picked into upstream so this change
may hang for quite some time.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
