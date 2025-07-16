Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58937C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 13:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 842EE8324C;
	Wed, 16 Jul 2025 15:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3ZousK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FEA83242; Wed, 16 Jul 2025 13:56:05 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B2B831EA
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 13:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-531426c7139so2786005e0c.2
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752666961; x=1753271761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KZTmVaIDd3P/0osElDkOzh11BNxNYNvmtzA6J1coKGM=;
 b=D3ZousK1N1DWoTAbihzNpeuGZBFFqBBlvz4G0DONk+IQcG+uC6kx1UNjB1bYDByzz2
 k3VY4eGnKlYBj4t7GNjEwkTknorqAlNW5mg5vCqKroymlKj8NaQSiNgz6S4LFEeifggL
 LNYK1X9z3XpWqWUT0Atcg5zaIpt4Ho0aV26xSjWVm91svklZfITMTr7TF9ox11c+7bf/
 QjFIMA0txymWKEcoTKXqfOaDlLYZqkGV72Unoabuu4BeVwUVdoVx5Xhr5JvFONvJBwn7
 Pko6vCcGpEEOAmYBWusan5ImCj+mQnW6vQhP86voP+2CSkOZYLBjGFGT/5XWaXenP468
 QpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752666961; x=1753271761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZTmVaIDd3P/0osElDkOzh11BNxNYNvmtzA6J1coKGM=;
 b=xSxk7ipclABAWxoOfPlbL39zyPblEqf2iMpeDWtG8t2HhnJiagg4jglDARRLORfXUl
 5VnBOfhpI6htsjiXFSF1PaiY7Oo5aXZ5dXgRF/fH6mUW6ao72hCL8ej3XS51c4fK4Lws
 lXWHFSax8bFaku3ijxEQlUGk1Jeywq2GDHIOlqjRBJX9sELRQMFgf6J64aIL6YdEQD5y
 WUfjs1kzA1RXFCbgF6pbmtfIgfUs1HhVTZ4CVZipRjmwtVpVUI9ei96yHMUXYsIrM5cG
 yYpdno/3ynoWhpVNuZwa8JY4gd7uGW1jY6o5PIzhNkmB8DvpmJJ4ynPNHDA9LbS8+us4
 fDDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkzdGjuM0/4roqUpUbm8WqAQ0EMKYJVowxgdoIBRq0TwD4sgY3xO1q+RIfw5Vw5moxlEVWszU=@lists.denx.de
X-Gm-Message-State: AOJu0YzFD4/4EUKSpA0gE4IWmOoHbh8nROX5HeiSWNW/Sr/0xumHuaZU
 APXP9hN6Vg2+lvTjFi3xg/FItZZewSF7igKvwy+2ZdgnETrMyRPLyk/1kr7R13hSV5P4vH929D1
 AoEUTfbKzmLiNXyG/CNrRLXHT21Vowgc=
X-Gm-Gg: ASbGncuqSMx3ZmbtX6aHKbD3PhsFYwwJxLBW5kxVVOwAOKL7alMh28Fi/pVQ9hNp8Zt
 ccwZc+t1V2DQzkgE2ZNSlKKHTf9wJky9snuOwFxSU6DWXMR0kGuL0AINto1sd/SiMz18WzkNXt3
 McatKwyCT7GKivQHpfTjRcgxYY57ris0w5AaHtVr7QYJ7dKVJCDtPDg79oN30ysf/2KlfG4lvBg
 gMc31MJ
X-Google-Smtp-Source: AGHT+IHITRZ+71hKJZYYVN7HvyiWjbdcNdS+yXGtMa16ttyV69YB5K4q5j+IeWeBRq7XNrUwuB1cVzHrVPx6K2YnKpY=
X-Received: by 2002:a05:6122:d29:b0:526:720:704 with SMTP id
 71dfb90a1353d-5373fcb944dmr719077e0c.7.1752666961310; Wed, 16 Jul 2025
 04:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
 <871pqg4iar.fsf@kernel.org>
In-Reply-To: <871pqg4iar.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Wed, 16 Jul 2025 19:55:50 +0800
X-Gm-Features: Ac12FXw16uvXRJX0YJtPcV0g43C-oV4GrxjxT_JiOx8JyrmFgfAomdM8YcQfqtM
Message-ID: <CADgMGSuN249mVLKja2r1cpN4Xn80CAkuv2F5rSizo3C_qaRpEA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Wed, 16 Jul 2025 15:03:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Mattijs,

Thx for reply.

=E5=9C=A8 2025=E5=B9=B47=E6=9C=8816=E6=97=A5=E9=80=B1=E4=B8=89 17:05=EF=BC=
=8CMattijs Korpershoek <mkorpershoek@kernel.org> =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi George,
>
> Thank you for the patch.
>
...

>
> > -     ret =3D env_set("bootargs", cmdline);
> > +     ret =3D android_image_modify_bootargs_env(cmdline, NULL);
>
> I don't think it can be done this way. bootm_boot_start() is used in the
> ChromeOS bootmethod as well (boot/bootmeth_cros.c)
>

I got your point. I have 3 ideas come out.

(1) The logic purposely empty the env bootargs, either developer don't use
env bootargs or those use cases touched bootargs in some early step. And
then wanna disregard previous u-boot bootmeth operation, and empty bootargs
for that ongoing bootmeth stage...well that's not congruent behavior; I
have a gut feeling this is a bug or band-aid anyway, it closed the door for
people (potentially abootimg) inject needed boot param between bootmeth
stage. Perhaps, either clean up bootargs before bootmeth load stage, or add
kconfig to check and enable this logic, a better representation.

(2) One more thing, the vendor_boot cmdline is not handle neither in
original logic nor in url from you provided. So I can say the url one is
not capable for extended with Android boot img version > 2 since
vendor_boot cmdline not handled.

(3) I don't think it is very much different between your mentioned url with
my patch. There is nothing advanced, but just existing code logic reuse and
that logic handled vendor_cmdline in other path. I prefer code logic reuse.

And I believe above are not the important thing....

>
> Changing this would potentially break ChromeOS boot behaviour so I'd
> prefer to find another solution.
>
> I know that TI has a downstream patch that changes bootmeth_android.c
> instead:
>
>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63


...


> Would that work for you?
>
>
Well, the one from url also fine with me.

The important thing is here. So as to ease the change with "minimal impact"
gets in. I can add one extra check to maintain original behavior in case
people have concern of breakage. Code example as below:

+ If (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
+   ret =3D android_image_modify_bootargs_env(cmdline, NULL);
+ else
      ret =3D env_set("bootargs", cmdline);

This logic eliminated the concern, but it also limited those potential use
cases for Android boot header version > 2, unless the newly introduced
CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS is defined.

Or this one with good extendible.
+ /* Clean up bootargs purposely */
+ if (IS_ENABLED(SOME_FLAG))
+    env_set("bootargs", "");
+ ret =3D android_image_modify_bootargs_env(cmdline, NULL);

Either way. I prefer first one and can blindly apply without afford. I
leave the idea above to people more concern with it. Please let me know
your decision, I can provide one more revision later.

Regards,
George

>
