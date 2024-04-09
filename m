Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E957C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 08:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A75388022;
	Tue,  9 Apr 2024 10:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKj1VfsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7981D8808A; Tue,  9 Apr 2024 10:42:04 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637D787EB4
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 10:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4165a253b39so2586825e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712652122; x=1713256922; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Yo02ZH767tNIujJtL7UP7Wgn8Dz1Bfr8Bc5vEUlxoE=;
 b=eKj1VfsWbjXNl4XSx/6QI+0kK/1si+5J/3CO4QZUdhb8WELb+uAQ+VgK6D/RXwp59e
 QWqt+mJagBgdBVZ/JrMlODWhi9bUjsNXFRXwP6QWbM3EoVDDDHfSxuYg2RBArQVXceFn
 tad/QEw4u8dQe5ajSpZl+8bkCakr2d5/Sw7S9nBfKFO+S+b4rf1ClwGvglz/ciDRYL9z
 JnsLsla9wrs6yRj8b9fBfnw7oCpFH5s1AwC2Ey7FFX/pZFLTi26/ttj3dSyJIgPmnEwi
 dCEt779KBMhwKMZEzUU+rQ7P6kH1iPz5TPmmkQHWPlAFHWt12qDrXAe8H20BU/pE6/Oc
 Lf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712652122; x=1713256922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Yo02ZH767tNIujJtL7UP7Wgn8Dz1Bfr8Bc5vEUlxoE=;
 b=qVDA/QTtZBjy1w5PIuGnqVCiNCWPT9RL0vqBX1TF9U7HDAI7yuskF6aWxyr+9DgcmQ
 uQLLb66uczPI3+hcoN7Nslil89PkSi6HiYvSLSYxVyA/W7F+fcViEztPS4GY29Mkw7QT
 YmaXLvPQ0DseYJdy7HK/j9GXsx9UYqdxy9slCwamc0koG7KnOyOK/pENMZZPvTI1uSd4
 k6LZuX/6Y9yv9ymO3PWlc1ifMqOG2mECZLZnO/Ox+Am0eWYQfbcJgDtLLtSSSZQuxUXK
 eylHf0NGqKUt5Iuh7Q3SCCFkgQ8wi2tiR5FlqdDNnCW8scz4bC1YRZCc4VbDqEfBLafA
 1SkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYMpSoGKM9r+Z+QtIKYj+2zRubbTnsvA/YsJPzuigR+rGXrxIOs+OVHdPWNBJRGqQ5/QFaaPAfrYIHwDOlOIvCT1RZGg==
X-Gm-Message-State: AOJu0Yz4Me65xQaTUdINv+RyH/EMTG9L5IzGwpjP+NIZLzn+oo67UxAn
 kvxzyVLvadUlKijuQ9aL3wn2wbCsR+CuXWARbtt14BgcVeScqLYab6oAQcJ18EtBKMZIJqJQO7A
 ezE/3W48Z3+U8cZau7YgSwmXGmoM=
X-Google-Smtp-Source: AGHT+IG/RlnPgWaHTDQ2xHpCRPXa0T/FPh3HxHALgcVI7bYSmYA0puRwXMamGIgvopyj3rIlMliA23FpmC6NAj7OGIs=
X-Received: by 2002:a05:6000:1864:b0:343:823c:6d54 with SMTP id
 d4-20020a056000186400b00343823c6d54mr9852478wri.3.1712652121553; Tue, 09 Apr
 2024 01:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240409075549.12514-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240409075549.12514-1-heinrich.schuchardt@canonical.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Tue, 9 Apr 2024 10:41:50 +0200
Message-ID: <CAByghJbYs07=DO3dQnFfB4TzcS5QAo97NH5RjYJ76EqW=YTSYw@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: typo curren
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 9, 2024 at 9:56=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Fix typos in test_eficonfig.py: %s/curren/current/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_eficonfig/test_eficonfig.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tes=
ts/test_eficonfig/test_eficonfig.py
> index b0a6cc47df2..1d8e033f75d 100644
> --- a/test/py/tests/test_eficonfig/test_eficonfig.py
> +++ b/test/py/tests/test_eficonfig/test_eficonfig.py
> @@ -224,7 +224,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_=
data):
>
>          # Change the Boot Order
>          press_up_down_enter_and_wait(0, 2, True, None)
> -        # Check the curren BootOrder
> +        # Check the current BootOrder
>          for i in ('test 2', 'test 1', 'host 0:1', 'Save', 'Quit'):
>              u_boot_console.p.expect([i])
>          # move 'test 2' to the second entry
> @@ -269,7 +269,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_=
data):
>          u_boot_console.run_command('eficonfig', wait_for_prompt=3DFalse)
>          # Select 'Edit Boot Option'
>          press_up_down_enter_and_wait(0, 1, True, None)
> -        # Check the curren BootOrder
> +        # Check the current BootOrder
>          for i in ('test 1', 'Quit'):
>              u_boot_console.p.expect([i])
>          press_up_down_enter_and_wait(0, 0, True, None)
> @@ -326,7 +326,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_=
data):
>
>          # Select 'Delete Boot Option'
>          press_up_down_enter_and_wait(0, 3, True, None)
> -        # Check the curren BootOrder
> +        # Check the current BootOrder
>          for i in ('test 3', 'Quit'):
>              u_boot_console.p.expect([i])
>
> --
> 2.43.0
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
