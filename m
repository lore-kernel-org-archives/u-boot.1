Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D242DC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5309A87688;
	Thu, 30 Nov 2023 03:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JBT12zPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C5B8082A; Thu, 30 Nov 2023 03:46:29 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A728765E
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-db538b07865so185119276.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312381; x=1701917181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9b/wyl0BmhyikQ/DV/Sf+io1oXYWdyFB6FA7Qd7Pk8c=;
 b=JBT12zPTcGebQ+JtmTAAZ4HnWcl309/DxYIe23ip+zMwn6XQ08SSwAxmKYa1CFjqep
 aDlB0FjJG9VIpbgFkTCYenohaTsn77bTKPmzMff2/Mdoklt5gWDnGqnTGhKdI+/ug4xe
 QqLp6Lj4uHgmtNazr++Y65cPV9ylwhgGuowIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312381; x=1701917181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9b/wyl0BmhyikQ/DV/Sf+io1oXYWdyFB6FA7Qd7Pk8c=;
 b=Nvr2f3U/29gKVliU0TfrUEMK78I4hUwznEC7TnWEYnElpfZOlI119UGhtAaQ5pMfOO
 LKsrsO2UTmx5+Dx6PyR2SRRX3JmfYn/TkaoYs8vXRhRC+ZkGXhaZaSYJfv9uwTRvpAhF
 DNlUAjDg5dMDwyHkmqdKFrjI/frJLGKdthMkV2SF7dEKpPV1uEJgHRHorJ7whUFgvnSR
 P0dh5M1eZG6A3/+2HB9lajBA8zJh3gxsaFyepS6Op0rB/aMho9Q+PBJT7/zNF40ouX0a
 EQtoE2c8PIfB8bjAsklE9+5yAev2WCdn4hkDmpi2yu6x3ZNsP5t3aWzzT01UL9ttEdvI
 QMRg==
X-Gm-Message-State: AOJu0Yw6bg0loeKNuhb22ptk8TXmNxJXDHbvvu38ajeI5zYQst+uUfUH
 h79tBoW0Xv7mN+ErceUZ947dmOJkgvSgf9jS94vcNj0XHGiNjlkuvgc=
X-Google-Smtp-Source: AGHT+IEP+WKpg1FSsE+JxiWyjj9n2xpH6+8xf3Z5Sft9mgxw74EXiHBE/Uc4vDSdiUsZX5TDTaxaukweV+97VvfcynY=
X-Received: by 2002:a25:fb04:0:b0:da0:38c8:2e66 with SMTP id
 j4-20020a25fb04000000b00da038c82e66mr19070091ybe.3.1701312380801; Wed, 29 Nov
 2023 18:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:42 -0700
Message-ID: <CAPnjgZ2i4ivjUHSQGQyvyTR1dJ-sKJZOu+iWYWZj4wyVA0NJLg@mail.gmail.com>
Subject: Re: [PATCH 0/7] efi: Partial attempt at a test for EFI bootmeth
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 21 Nov 2023 at 04:36, Simon Glass <sjg@chromium.org> wrote:
>
> The test coverage for the EFI bootmeth is incomplete since it does not
> actually boot the application.
>
> This series makes an attempt at this.
>
> However there are at least two problems:
> 1. The test does not set up the loaded image properly, so it isn't
> found by the app.
> 2. The test needs to use USB instead of mmc, so that usb_stop() is
> called

I think you may have missed the point of this series. I am not sure
how to fix problem #1 above. Do you know what is going on, or could
you help figure it out, please?

>
>
> Simon Glass (7):
>   efi: Use puts() in cout so that console recording works
>   efi: Show the vendor in helloworld
>   efi: test: Create a disk image with and EFI app in it
>   WIP: efi: Disable ANSI output
>   WIP: efi: Add a test for the EFI bootmeth
>   WIP: efi: Allow helloworld to exit boot services
>   WIP: efi: debugging
>
>  arch/sandbox/dts/test.dts     | 10 ++++++-
>  boot/bootflow.c               |  2 ++
>  boot/bootmeth_efi.c           |  1 +
>  cmd/bootefi.c                 |  1 +
>  include/efi_loader.h          | 14 +++++++--
>  lib/efi_loader/efi_boottime.c |  5 ++++
>  lib/efi_loader/efi_console.c  | 19 +++++-------
>  lib/efi_loader/efi_setup.c    |  2 +-
>  lib/efi_loader/helloworld.c   | 39 ++++++++++++++++++++++++-
>  test/boot/bootflow.c          | 55 ++++++++++++++++++++++++++++++++++-
>  test/py/tests/test_ut.py      | 32 ++++++++++++++++++++
>  11 files changed, 163 insertions(+), 17 deletions(-)
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>

Regards,
Simon
