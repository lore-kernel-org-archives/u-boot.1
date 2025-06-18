Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F5C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0B582C79;
	Wed, 18 Jun 2025 09:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJJe3FSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9317F82C87; Wed, 18 Jun 2025 09:41:40 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34ED82C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad883afdf0cso1292409166b.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750232498; x=1750837298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gLMUAEIjz2N/yMjV6XNPlEOBwIXqTEZfHXSIolamW7c=;
 b=SJJe3FSwzqycDXbOBN+TOv8Zp0oBFWsGwvH6jLKSFiMws6U3eYDpbjULeSmdnNsuNb
 tzJk7DJKolxEAUdewxnIqSn3EHFbh3y730ZVON9Cak83+8pYi22iugm42H9TTLB87z9V
 rLsCQgQiFDJ9yiUMDxLdbhoQHzg3oSrUmiSNicP3n5vBjTBX9B4bECrbvdlFz2+jibZL
 Xf1kzOoXC/Tu283bnba2GoClkATpwkoAF4tC1o4pZvEqdJLFDZkGcELz39uvtjwrdHpw
 WcvbGlIhnmIp/mlBaG7R0CyahoMPAqf4XAoJDBc3X7RtugFZBG+u7oN4a7jQtqpFLseK
 dyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750232498; x=1750837298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLMUAEIjz2N/yMjV6XNPlEOBwIXqTEZfHXSIolamW7c=;
 b=FWcLHGvpefAGel0bYFdw7OoQmJw2+Mc/HYhrJOsGZ9Mt7UyVQXIbKaekk94n6ct2ke
 6Y2KGgB7Q+pLRa/fxIpOVls9F3SFrJjJPjb6iMdcgY3LnUBRc0jASw1oqM6G3XWlvcFS
 KM/1k0AuebCuAAc441Ultg4SpP+REIcbyb5Poo3VNFHbQk75MMhgyjfg8WfHJGFpARHo
 wO0e6tNRRdr9qlD06JckffaIHPmZpf5SZPtwKje+vAGRgX4Kk6FTJHf6EL5uVJarKx/B
 DL/N76PLA1H7a11K32DufLp/+rxOO8LMCiINOJXrZc3tN6fxPm7MnMB0CWCd2sN15l28
 rsCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Dld6WEwvUPcPOxlAMW216xTFA0f8JW8CUUCbYU7nz3BRCSg7K37fDES5tsiqbqlDhJK+gho=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu+QqCndzmKbeMwja9Em441aFyk7IhIOqLRIG1Pd0wlMhU8kpN
 XliPPqy7lw0BswJ+UCEPkG3HICsZKBIwrfn8P41h+oE2V24qKsvmybR2L+bzVmHJMS9WD8xxxYu
 eBOIgQ7GAtpD/xekjNefsDukaGEmQ5wk=
X-Gm-Gg: ASbGncsaRH/gj1dTNTL8HeLqQqO7VYihoSUgphviiWkVtu2yzVC0gwRuSAb1snQBwZO
 jry0hTl3kPhvqZuSXhVb8u4snAwThzQYaAMg5UpPUws8rSbAUemENCNPml+cjgHStjM31AtN+tw
 AcUElUUy88y0Iw1VEDy24vHasHsabXaYQqVCc8OVQ/I0AV0MCUi0w9NE3Azaap/0gOW/Rc4g64I
 ELp
X-Google-Smtp-Source: AGHT+IEPOOm9UhcTRbuuAPhYspDoAz1MoooUbolMdcfCDaaKZ6jsIf37cnmlGS+w4fIKLl6f6LsAKYEUzllnBdpABmQ=
X-Received: by 2002:a17:907:3f21:b0:ad5:1bfd:30d2 with SMTP id
 a640c23a62f3a-adfad54ab92mr1595043766b.55.1750232497920; Wed, 18 Jun 2025
 00:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250615093344.159920-1-pbrobinson@gmail.com>
 <DAOLOVHXW7MX.LAIVDE0UN7GN@linaro.org>
 <20250617231046.GQ1382132@bill-the-cat>
In-Reply-To: <20250617231046.GQ1382132@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 18 Jun 2025 08:41:26 +0100
X-Gm-Features: AX0GCFsIWhWlcTP8MQyXK42X_1C3lrBYv0nJpSCm6Cq-1Ox3rY6fV7A5uTjTzlA
Message-ID: <CALeDE9PJ2fUdgXUPt+25EkD8MQP+7SW2=+7we3aT7YdpuL9wXQ@mail.gmail.com>
Subject: Re: [PATCH] disable VBE by default
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 18 Jun 2025 at 00:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 17, 2025 at 09:39:25AM +0300, Ilias Apalodimas wrote:
>
> > On Sun Jun 15, 2025 at 12:33 PM EEST, Peter Robinson wrote:
> > > The VBE protocol needs explicit device support and as
> > > such isn't particularly useful by itself without that,
> > > it also adds size and the potential of an attack vector
> > > so devices that wish to use this protocol should
> > > explicitly opt in to it like all other large features
> > > in U-Boot.
> > >
> > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> >
> > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> This is I think a tad premature. I believe Fedora has been carrying this
> patch for some time, and that's the prerogative of that project and so
> fine. There is a chicken-and-egg type problem with this feature and if
> we aren't going to enable it by default, we then ought not bother
> including it and that's not a collection of issues I wish to open at
> this time.

Can you provide some docs on how to use it on every device without
device specifc config?
