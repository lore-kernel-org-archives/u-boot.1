Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3968D6E2A1
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 02:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D64895C8;
	Wed, 20 Nov 2024 03:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DomK6SI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42118961D; Wed, 20 Nov 2024 03:42:33 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A481894F4
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 03:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso52752105e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 18:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732070550; x=1732675350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o5Vh++R1LjzofBLTr+9rDXfrvoj2ZtX3QuGQdrTWY2Y=;
 b=DomK6SI1GpKP8zfWDpooq7nkVvh6yxpExO4C8RX7bE2jlYdo/r8xBZtn7ctob4o8gg
 D31qK//GHGK40XgcvStKco0977t1U+QPHQ0pZB4H7N5BtW7TYnTRtNyFWypFmnM5sK4g
 9RaOtv5IFkxvooUeG5wMJbfW6V72oIbVYGGRkgSlfyjUiSBE57fO+Nu8r0FvhcejfH7P
 5fUNzbRj2N8c/Fbo9Zo1hFl5CW8kXHL+4d31tfINsgPorDkAt+1tquwafSsjhhjliLvw
 0Mpu9CETuOpSxujlX65y3GQH6fsF2DTPBSk6SfNq/EmUNqjkHVRrCkD1i/kClA8HY01N
 0HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732070550; x=1732675350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5Vh++R1LjzofBLTr+9rDXfrvoj2ZtX3QuGQdrTWY2Y=;
 b=ZWfR46rFy/zdN5p7XOzHb0scPF+vHgbZUMSuu+G4xpVSgnXw9jPXNzFujg/QT1CErT
 dO1k4HlGEhrIiRYD50pn+3bAnxWBKAgKfMU6teh+XrRsHqnpBbhaeLBrtrMivvEu6lFz
 Ff9IPP5pxNsycCXFg/bKmcfXP3ILFz3SJfxFAxH396uh7+lOLZqksfEUuDL1CnFFrTEF
 fDzBLdmpPgavNUL3NIAJipvoNfpQZdJhQe47XtR64hJ6/GR/kN9rvB60B2lyJb/6/+2+
 sFOz0EDhmH5tJMxZU5QQaBkuc5nMlGQTmcRNE6CtvDcSW21jA/gD1lITvEkzyCoK8/07
 4lSw==
X-Gm-Message-State: AOJu0Yw3pd+BJBxyG54IM3DmzVE9yhhDWUIYfe00G5H9LxXNu/ELauXQ
 0tMtutZHEOzpi3QSN3QbS2BFlRAh+Cyx0jZ2iYSTiWD+5p1iTsE7TpoCXrWBWz8td8Hza3CMMCY
 I58cOtmh4uSx5/aFj8Tft8UtZ+JZooQBPnqRv2Ckw3pTygH6r
X-Google-Smtp-Source: AGHT+IH7pkmanj8O+E22PWvpLoRve1BVZrD5fP38uutG3h7v117Z8Gej2yUF8vCZgZ49LnX66KdLUhZKgmSW481pdLc=
X-Received: by 2002:a5d:5f8f:0:b0:382:4e5c:5c82 with SMTP id
 ffacd0b85a97d-38254ae4d5emr814051f8f.14.1732070550272; Tue, 19 Nov 2024
 18:42:30 -0800 (PST)
MIME-Version: 1.0
References: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
In-Reply-To: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 20 Nov 2024 08:12:19 +0530
Message-ID: <CADg8p94ohYfNLL8jbRA-hNd=fbg9PuVJvp0z-QYTeaGwHZ9q0Q@mail.gmail.com>
Subject: Re: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: E Shattow <lucent@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On Wed, 20 Nov 2024 at 04:48, E Shattow <lucent@gmail.com> wrote:
>
> Hello,
>
> On HEAD some commits after v2024.10 I encounter a regression for
> `bootefi bootmgr` fail with error "Not a PE-COFF file";  The fall-thru
> case of global EFI boot is successful.
>
> Having run a git bisect I discover the first bad commit 22f2c9ed:
>
> $ git checkout -b master origin/master
> branch 'master' set up to track 'origin/master'.
> Switched to a new branch 'master'
> $ git bisect start
> status: waiting for both good and bad commits
> $ git bisect bad HEAD
> status: waiting for good commit(s), bad commit known
> $ git bisect good v2024.10
> Bisecting: 850 revisions left to test after this (roughly 10 steps)
> [82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'staging' of
> https://source.denx.de/u-boot/custodians/u-boot-tegra
> $ git bisect good
> Bisecting: 422 revisions left to test after this (roughly 9 steps)
> [8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
> 'u-boot-rockchip-20241026' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
> $ git bisect bad
> Bisecting: 214 revisions left to test after this (roughly 8 steps)
> [0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-binman:
> Add support for HS-SE
> $ git bisect bad
> Bisecting: 106 revisions left to test after this (roughly 7 steps)
> [88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow flashes
> to specify MTD writesize
> $ git bisect good
> Bisecting: 53 revisions left to test after this (roughly 6 steps)
> [625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
> bootflow_cmd_label for when DSA_SANDBOX is disabled
> $ git bisect bad
> Bisecting: 26 revisions left to test after this (roughly 5 steps)
> [5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
> SPL_FIT_GENERATOR support
> $ git bisect good
> Bisecting: 13 revisions left to test after this (roughly 4 steps)
> [e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not add RAM
> memory to the memory map
> $ git bisect bad
> Bisecting: 6 revisions left to test after this (roughly 3 steps)
> [2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any changes
> to the LMB memory map
> $ git bisect bad
> Bisecting: 2 revisions left to test after this (roughly 2 steps)
> [3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to allow
> suppressing memory map change notification
> $ git bisect good
> Bisecting: 0 revisions left to test after this (roughly 1 step)
> [22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the lmb
> API's for allocating and freeing memory
> $ git bisect bad
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve memory
> above ram_top
> $ git bisect good
> 22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commit
>
> A commit is good if Star64 boots and absent the error about "Not a
> PE-COFF file" (duly confirmed by eficonfig to adjust boot order
> allowing removable media of an OS installer image on SD Card to be the
> priority, verifying that the installer runs as expected).  A commit is
> bad if U-Boot crashes and/or has the error "Not a PE-COFF file".

Can you post the output of the following. Thanks.

1) running the 'bdinfo' command

2) do you get any errors when running the 'bootefi bootmgr' command
other than what you mention above

3) What exactly do you mean by "global EFI boot is successful"

-sughosh

>
> For context, the Star64 eMMC contains here an installed Debian Linux
> OS in the usual way with Grub2 EFI on the EFI System Partition there,
> and that image boots fine from U-Boot v2024.10 also when loaded into
> memory and using 'bootefi' directly on that memory address.
>
> Best regards,
>
> -E Shattow
