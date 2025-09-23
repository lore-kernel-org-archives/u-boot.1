Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C1CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF298341C;
	Tue, 23 Sep 2025 20:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BdYZ1EXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8557283448; Tue, 23 Sep 2025 20:32:59 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948E480107
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-62f4a8dfadcso7105904a12.1
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758652375; x=1759257175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9whfWAdyRLxQyIZZufp93g9yvTXlHhHU/qQDIz0ay2w=;
 b=BdYZ1EXaDYFdZHT2usOIp0utpCHnd6qVGLGJ5eDcYhrvFsguLfIn166r8FxMuAtXyp
 VOGTN3sY83GrizIJ42Fkcj7YGZqb6DdCPfn5EXAYVqTBIMoLEpB6MXuYEHG4APgXXrFf
 UR2PelkruzX5Co6s9Ip59gJGd6WqKT/ox4kr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758652375; x=1759257175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9whfWAdyRLxQyIZZufp93g9yvTXlHhHU/qQDIz0ay2w=;
 b=BC2cLWf4x9/+mt/bPMXoYWlgsnUP80oFWKfNHCiYEYCMY8o4ZKnmGD0pgeN6M51ZJc
 AJ1/Pvjg3ry+nfZ8/Xn9LzHk/Lvz6Bb9dHLcw/NId6aUYIETgQ6Up5xCtoufsRzHXAyE
 9J1k92B0XbzLCj538SqDBi+ifG50kV5QR88NNHmO1kY4eQ1ukbM9MJfaotgQjL22MqUp
 8kYY/RnZUm+6jhL/u7+Oabbfolz8Ra+Gex1OAtVZD3UdGzl6x8WR9KMc4eaxnXPz3kUd
 fgIb8+yPmPEduohqWpa4Wm/dZWMMBpHsZ15Fmu4Yebi8pmK9TNQdg6BjUXIykJSIROCE
 HUhg==
X-Gm-Message-State: AOJu0YyXOI+ju1zQpGv3cVdxl+IOO72xLlkqMDq37g4brzEtnIoahTlz
 9QkdcjjccMF1xvxcYB3IFWzbCFH7fB8Pl3z30hmZ4iQ12SjJleskssNRlvqJyp1n2+BFbq+EKmY
 jlXt8cv/wCk4bN0jp20TM6SMUUJrvzDqsZmfNJFml0kDyKHdL8qWJ+w==
X-Gm-Gg: ASbGncvWor2kYwVCEpCdvXglIsVP0HhkeCErmt38yHZEuiF9kqM/7sgei5VoAyNae3A
 Lr4aMG/08uJz7ZQhaBm0NE8hlfvDUg87OhofInDj2xOvd1fK/uLq7CeQhc3XyI4pPSIBYwKynW0
 EcW6Dvc7zk8amnsFhTjgHywzQI/8dt9fmT7RHV/Oq6IvEdjntCAjEnb06EjkEFMBj9D6Bqq6+De
 BVl5FoEPiXnsjVN
X-Google-Smtp-Source: AGHT+IGNHgsL1h/vktsNVWmsWxMxoF7jkHKGiv6cET4aVCOLhtBYbwBKmaquqxLMkbnEMGkXxR1x1Qmfc8+npMD6gDA=
X-Received: by 2002:a17:907:7f91:b0:b04:848f:a0d4 with SMTP id
 a640c23a62f3a-b30263b8326mr348430566b.13.1758652375208; Tue, 23 Sep 2025
 11:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250923183053.786043-1-sjg@u-boot.org>
 <20250923183053.786043-3-sjg@u-boot.org>
In-Reply-To: <20250923183053.786043-3-sjg@u-boot.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 12:32:36 -0600
X-Gm-Features: AS18NWDANljiSZgar01e7Y6zyygTSbWyC9qXh7hksygIq1VN1nvnwc59XqMuq_k
Message-ID: <CAFLszTgbn-DQ7-_8iZ=MnqewSWzbrhujXTfqhja1CXDEoamn9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi: test: Update distro EFI-app tests for new naming
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

Sorry for the noise, please ignore this patch.

Regards,
SImon


On Tue, 23 Sept 2025 at 12:31, Simon Glass <sjg@u-boot.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The EFI-media devices names were recently changed to make it easier to
> tell them apart. Update the tests as well, since this change caused them
> to fail.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: dea4ea00a72 ("efi: Set the efi_media device name when binding")
> ---
>
>  test/py/tests/test_distro.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> index 77caf32145e..cc4aa265d90 100644
> --- a/test/py/tests/test_distro.py
> +++ b/test/py/tests/test_distro.py
> @@ -84,7 +84,7 @@ def test_distro_arm_app_extlinux(ubman):
>          ubman.run_command('bootmeth order extlinux')
>          ubman.run_command('boot', wait_for_prompt=False)
>
> -        ubman.expect(["Booting bootflow 'efi_media.bootdev.part_2' with extlinux"])
> +        ubman.expect(["Booting bootflow 'efi_media_1.bootdev.part_2' with extlinux"])
>          ubman.expect(['Exiting EFI'])
>          ubman.expect(['Booting Linux on physical CPU'])
>
> @@ -102,7 +102,8 @@ def test_distro_arm_app_efi(ubman):
>          ubman.run_command('bootmeth order efi')
>          ubman.run_command('boot', wait_for_prompt=False)
>
> -        ubman.expect(["Booting bootflow 'efi_media.bootdev.part_1' with efi"])
> +        ubman.expect(
> +            ["Booting bootflow 'efi_media_1.bootdev.part_1' with efi"])
>
>          # Press Escape to force GRUB to appear, even if the silent menu was
>          # enabled by a previous boot
> --
> 2.43.0
>
> base-commit: 136c959dd2d089710fb131956081d09b9da3bea4
> branch: labh
