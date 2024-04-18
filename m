Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B96FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9956388648;
	Thu, 18 Apr 2024 20:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6Rm6hXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0651788648; Thu, 18 Apr 2024 20:02:27 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC3788524
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so280999a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713463343; x=1714068143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOxsS6j/qvXul5TPJwDt50iTMkvW5G7A3ASZtHoz6Ak=;
 b=C6Rm6hXZLPJemVmW3snQJsCtnEj+hFhqtJZqrUkWnMlFx8UzYYAFuwAuTC3XxbJv3W
 DceDLjLMOJZUWzqS8YGNiPGnv3D+m6nlwaxaRnPTEYoiKtNcJIoaPIWyfl1/mJEDJQDG
 BmJ3whvJ1ux/E//15600tc1nJk3lSijnHlyHf/TDK5IinNZs+r3iZQtNQ3AqiAFdTcXD
 O0zpy+oy79tC47DgepYbz2h3SmR2Q4xv6OfzDm0Rf3BQEAZufQEwbQl0gupmsjmlCrkN
 GMui2f0WMkv1dkYtMUphMQdrICQW8tgwfRCTQP8fLvprTWXTliyUrVvsLFbhG0p8WltY
 p/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713463343; x=1714068143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOxsS6j/qvXul5TPJwDt50iTMkvW5G7A3ASZtHoz6Ak=;
 b=XDy/WGmAbgHsQR4yRRBn7xCT2IvvVJqY7S1mrQ9I+BVxuEXz2BzrQ+8gbnRGueGsKt
 vsInr8HVAEKJyZoz4bcTvdMa/I7kdjv9QWdJvfaQEr5Yyz/zuKY1Q/rJ8yJ8AN8IAHB5
 OCPmeLEwTlx5TfIo2JrhEnLfPOR77KpPyYb2bXcroQT4QjvgNpu1kHmsj+Tk9HZkRer4
 fN5AADY+xqrRYJ+vpTkPIHHPEiFd1NfIKJd8ncn85zL6GgtwLbPB3wqI49I/QHy2+g+q
 M1Rw2uiyeOvoQp7IbdVTbQ3BGZUk2BpZzbKNcpTj+CmjdCabSS9adMerfeVCFmAGx3b+
 iCNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq4GTX1GlsO51T7BQPdI9kfUmpRPQCSpqtIN3xMwgw+yJx9i9CL8yx/Rur9S3Nu6l082kTaPpRxjJyFDeMy3hcB5r5eA==
X-Gm-Message-State: AOJu0YwEFLRf3sCHB9MwLLwu+yoN9ElfUNNqS/meRbbDnU3oW7RbfS33
 MKo0Ix69YrrDvdbgvbEOjByGU/jBcO6zInfDATskbKdifolYbWNrP04JHVvZ20xtxgBjeor5JDw
 Kh++xMhxKmTqV+rpBHE/A24fzPD09PUYd
X-Google-Smtp-Source: AGHT+IE3f2Ig1uj3k1Ny6ftxXDZjc2cKJ8BhCjcFzxAQPNLm0WN45hEfrFWxXNaZR3Qo3RaLzEzY9dMrPyYwubsAmDQ=
X-Received: by 2002:a05:6a20:b227:b0:1a7:a3cb:7909 with SMTP id
 eh39-20020a056a20b22700b001a7a3cb7909mr4193869pzb.3.1713463343297; Thu, 18
 Apr 2024 11:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Apr 2024 15:02:10 -0300
Message-ID: <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

Hi Tim,

On Thu, Apr 18, 2024 at 2:54=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get the
> following in the SPL?
> Couldn't bind rng driver (-96)
> SEC0:  RNG instantiated
>
> sec_init failed!

Yes, if I add CONFIG_DM_RNG=3Dy to imx8mm_evk_defconfig I get:

U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:57 -0300)
No pmic
Couldn't bind rng driver (-96)
SEC0:  RNG instantiated

sec_init failed!
