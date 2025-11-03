Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C348CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2E483993;
	Mon,  3 Nov 2025 14:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5Srr18X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E9F838E7; Mon,  3 Nov 2025 12:07:21 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C72836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so4249955d50.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762168038; x=1762772838; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbzIU4VLiwBaTAq1n3Jz0sntJf5sSDoTkntKcuFS7gI=;
 b=I5Srr18XeQKdcMZvlSGMIpt6UAPdkpkDleRxzyYiMJ1vuYNVlvjj3EX0jV8JjwrWZP
 SD13RwmqGZ8AsIJDlXSndrmlOxtyctBV9NfpKn7YqeUbzIqw3BKwx70qLfkOo/qTfHEo
 9vXROyel3h8SFFDLOhkV4LPUFp3L+wdAGyuINOw3Rt5sj+LgbjckJG+7+qZbkymW31mu
 UWmkYLNfL8h5sDF/W4HboyVxyFA9mhr7jpTzGMRO583sO9JYoF3ijWUuP+VxaBwIaFaB
 4X4PgztTuGv7jAjSD1zjcEgNdMVAvYfwyHJIEoCNi0ev1bzMIdqlD2/OHNyYFNgbjRaF
 fjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762168038; x=1762772838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbzIU4VLiwBaTAq1n3Jz0sntJf5sSDoTkntKcuFS7gI=;
 b=A61SSWRs7XvvAKwXjjv8gWQUIFsfQ1qz8fENx5Xg+WgpSJGOkYew+9YiPRP5i58805
 LbRv7M3fA9GI3jJR8W2wHRnOYMuZ5fijw2mePEkIC0b1Li9hcwY8tObqcxHtd/82pOLV
 Z0TgfHwJn5Uk4tI8CISm+GOVdS5JKi8q5UrnURxfzF2U0bopWJRHSgjldoBjK+sfjC64
 Nja4t3Zsepnqs93dvUc/7GXDpmuoorUiH9ZzR4mwWReUCfk9Ze4g6RT/k2j48lCHapoX
 LY0hj0qhGfX4fWejvo3+oHHXHKAPuQLilqOmG2IQ2w7RUV6xqZrIhA+4cUSfdMpefig9
 ln9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFoc0v2AsBvkNA71hlBOeBTHTFp7cSvAIsS9xg9d7UuQmnttv9wbx+LduGUdK37f1XIHWdcMk=@lists.denx.de
X-Gm-Message-State: AOJu0YwxUIqkI8ayL8YZhQCUVTP5zeokaKz8ZsFdtKd/caEZ0xelqiqC
 SQatSFqsAbH3Kn+W/+vifwLDGPLsH6VWfrC3U8RdD6Ed0wJf1n8J8uWe91xrK4XH9itWjJVd2v8
 ZQOE/3mRzmYnvz7iU7fxPxrdNEUuBa+ka6A==
X-Gm-Gg: ASbGnctVw6f4l37HthZc0izCWUJVpYOadQXutPsVrof0yP0IVKNO1b60rpmSxXvys7a
 U/1DvoEBwZMTixoa4k7ClkpbDLpzi80MOt5LRg50KiMLKb+53fphvmXQY1beuF8P4e++NRsxB8m
 mZpaHsXz3DIQBCVoed+PFJgiwghoPQAsq2y7LhKH2FnqeUyfrLkeEk05p9907v9na8dUf62urhE
 C6BawdyYWVCnpLGOy8wG9lUAUgSRLioN9AqESnKSGaDlMCpE+BQ+Wbsd2n1CYhRMfJnCZK9tw==
X-Google-Smtp-Source: AGHT+IFZEieioA7NXnNJKbWOoxwFo/E9KN6bi7AwE+w8Q7Mm5jGI9iwAyIKiphGC2ZdI3x7boDtBzalu1LW29taHqlU=
X-Received: by 2002:a53:d047:0:20b0:63f:b5a5:373 with SMTP id
 956f58d0204a3-63fb5a50666mr2043389d50.10.1762168038462; Mon, 03 Nov 2025
 03:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 3 Nov 2025 19:07:07 +0800
X-Gm-Features: AWmQ_bmCxa6b5hYYfr8vYZ7QUC-UtESv3Ml7-x0tCKEsDHDymp2qGOS-W45o8Wg
Message-ID: <CAEUhbmVCkjyPOyYtbABqEQZYeGV5QLwMUkO9xP4obFne7PryQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sat, Nov 1, 2025 at 3:59=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For testing ACPI on QEMU we need a defconfig that supports acpi command
> test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/qemu-riscv64_smode_acpi_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
