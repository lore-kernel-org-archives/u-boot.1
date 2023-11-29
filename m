Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11360C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA99387646;
	Wed, 29 Nov 2023 20:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOdlY+WW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65E8877A4; Wed, 29 Nov 2023 20:28:03 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349C3870AB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54b18dbf148so223889a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701286080; x=1701890880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AuWnpOKn6/LOs6gN/1onSqqVkwgRi2QX2eXlxAuW2I=;
 b=oOdlY+WWFkrUMBo5lM9PMKOBtHZz2F8G6yaBglxzkPSrfehorFarE43f3zVIHriw+u
 bzi3XxGtJ34Oe7cgwKTVSYYkD9IuvtcAmekm14Zx5ro/HJjA/qLpOtdY/7e4kIj1e4bh
 2+rOl8T5hOEz8XMsaQWrfWDgoKviYfMJm+Qzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701286080; x=1701890880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AuWnpOKn6/LOs6gN/1onSqqVkwgRi2QX2eXlxAuW2I=;
 b=Zau6/Bp4KaKD46lDqa9yec7gFw04Z0vMt8AC76qXlX4OBquPDR+rRwMo9lanvn9+0Z
 XwaRUc8C0Wh2VuVNc56vZKB7oD8YS0m7rNjcCSsRFRiGQLIXnYCbeOjWVKEruMIf2a9G
 c7hiezaarJ3EOjwdyQkCWqhhCBl9xrul5dluojK6gbCnrJHRD2GTlonMYMWvAvXXJ/v2
 Hh/yuxo0QW3ZXoXBxpAvhNRVZq8KZw/rj7WcaB73LVIQPbmOaNhMP/TD0ATU+o4odqoz
 x3uRnBN8WYM5rqukdBBE9OrR8nik1cOf/NipwvlZ66Uly+BgR9rabqZdgBPrQSxdjupg
 W42Q==
X-Gm-Message-State: AOJu0YyTdt0GmMyb5SWChVveR59L+eXgBt0S2OienI/6oN8bc9XwNkGX
 +CNfZZrEewAhn9RIe8uX1kSDAcd9NI4+eeomFrf39Q==
X-Google-Smtp-Source: AGHT+IFmYameW0CYgEPlsImQwgdWcG4hnumiGXF0r14PE3qagwmhY8/VsXK2HU1xr2OLOxeIOU2zBpo3qa9BLuwQVQg=
X-Received: by 2002:a17:906:6ad9:b0:9e6:4923:680a with SMTP id
 q25-20020a1709066ad900b009e64923680amr11731908ejs.3.1701286080464; Wed, 29
 Nov 2023 11:28:00 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
In-Reply-To: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 12:27:49 -0700
Message-ID: <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, andy.shevchenko@gmail.com, trini@konsulko.com
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

+Heinrich Schuchardt

Hi,

On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
<phanbagiabao2001@gmail.com> wrote:
>
> Hello everyone,
>
> I am a trainee at STMicroelectronics France. I am working on a project "S=
etting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-A .=
 The objective of my project is to add a way of booting (with ACPI) besides=
 Device Tree available on STM32MPU.
>
> I found that ACPI was enabled on some x86 platforms but I don't know whet=
her it was set up on ARM or not. I found a PATCH that discussed Enabling AC=
PI booting on ARM with Raspberry Pi 4 but I don't know if it functioned or =
not. Did anyone here succeed in setting up ACPI on ARM by U-boot?

Sort-of...the refactoring to allow ACPI tables on ARM is completed,
but I don't think any U-Boot board uses this.

>
> What are the differences between x86 and ARM platforms when enabling ACPI=
? The architecture of my board STM32PMU is ARM so can I apply the technique=
 used on platform x86 for my board?

Firstly I wonder why you want ACPI?

Secondly, if you have the tables somewhere it should be easy enough to
build them, building on the series you pointed to. Heinrich is
interested in this, I think. I can help with advice. I have been
toying with going back to that rpi series but have not done so yet.

Regards,
Simon
