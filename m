Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F9C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562E280F56;
	Tue, 18 Feb 2025 13:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="frQAK2Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CE380F5C; Tue, 18 Feb 2025 13:09:20 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8347C80BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb90f68f8cso433511066b.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 04:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739880558; x=1740485358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bRUkAyLygrJ5IzQL42wrEdSVkTRhKp3qeMnpDToXs4o=;
 b=frQAK2JqjlW3hj/N+YYrvqxY2lJRtflqQa06/J6ZRpLjr6OjcH6SUkKxZGYtERrJ6+
 BcIDVgZDLZCw/ikSzQnloLpMlEdZ2RNJVUZdV8TR0DyMS28MpUwCbe3nMQsgZiZpFVpo
 PR2UwCU3/K4eIz8AaxW4TaLVpOR4nwzU97oAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739880558; x=1740485358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bRUkAyLygrJ5IzQL42wrEdSVkTRhKp3qeMnpDToXs4o=;
 b=OY/1z7JHKmEw/W7hE2EgNlTK79+PNPFgapXuaXV4HEOR6a/GNvmM/2xwx12NDdOqnt
 TReFOL5FnxIZcw0GLYPsQtegD6xiXNaMAkpfaUSfKTiCsGJf/VHqwyNcy/Si2u59ioqG
 iQYIt1Qrr8oN+lvdP7ODIwPyRuUD9GeTcBwz/g8KUbr9qLfVi2iasZpqaDP+Eriwb3qw
 mtINMGIkBz/N9/9ZqKsoBdeu+mjcNXyxl7rlYJ+L5k1P4xg+jSko45LEs0CM9A8lAmcc
 yOSzNoYMOyq9fuRFfeqb+b0eymlWA5Qku1ww8I0nqJz/9hoYgkalhva4c4GLvlS8djqp
 yWzQ==
X-Gm-Message-State: AOJu0Yxpkui0eIG6Rd4A+T9AYnBe8tGUHhIEgu6Dk25bB5X0LZ4mHHH4
 JaLff0C1GqNGiCGc+AtQfnqpt9R3bGt7YOHVTm4cH+XiNmVvAaxYM4da1tXEoMPUjYaY9Vdl2aX
 wmpFNZQ1xbejUuD2KybPoLtlT0ZHD9E3veZ+KZdHKU6XhjYwILA==
X-Gm-Gg: ASbGncvisYzwVqXr4VeTCoXHylk6CI+Yg6bMuiRJA9EQEz0BcKRfvTickxf0qpvXEXO
 n2cDh8CjSLz4TQjysE3bFhlhCuQSRjnGc93CwOYArXjKEyxKmMT3MPBObdOn620ibJcHf2hA4CA
 ==
X-Google-Smtp-Source: AGHT+IF6K1rnrFQmpG8RNl8P+Z5HGP+f4RuADtkMrNcqcWu6XW6X0OYwJ9vBJG+gVv3lkXBrawtxdKH+VcmUfxT2CSg=
X-Received: by 2002:a17:907:6091:b0:ab7:d916:4fe4 with SMTP id
 a640c23a62f3a-abb70bacfc2mr1459502866b.24.1739880557984; Tue, 18 Feb 2025
 04:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
In-Reply-To: <20250217174805.GQ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 05:09:06 -0700
X-Gm-Features: AWEUYZnpoNw6WL7oNIdaYbRXBfnvubHt9dttDxd-p2J89Fx3tuGwqKseRZ30m0g
Message-ID: <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

Hi Tom,

On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
>
> > Some test can only be run by a particular board in a lab, e.g. because
> > they are loaded with an OS image used by the test. Add a way to specify
> > this in tests.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch to allow tests to be filtered by role
> >
> >  test/py/conftest.py | 22 ++++++++++++++++++++++
> >  test/py/pytest.ini  |  1 +
> >  2 files changed, 23 insertions(+)
>
> This seems duplicative of the existing functionality we have, all
> hardware tests can only be run on platforms which configure what the
> test requires, in the boardenv file.

I was afraid you would say that, and yes you are right, it is duplicative.

With my lab I am trying to use Labgrid's configuration and not need
anything else. For example, the params on how to launch QEMU and where
to find the OS file are there, rather than in u-boot-test-hooks. It
allows me to run a session interactively just as easily (and with the
same flow) as I run the pytests and gitlab.

In my lab, I actually don't have any Python things, apart from what I
added for that tftp test.

I wonder if I could create a way to pass the env__ stuff in from Labgrid?

Regards,
Simon
