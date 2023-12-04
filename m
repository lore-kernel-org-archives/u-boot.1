Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DA7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 14:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031D4876C9;
	Mon,  4 Dec 2023 15:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZrmOA+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F411875D6; Mon,  4 Dec 2023 10:47:34 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6D287499
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 10:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=phanbagiabao2001@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548f0b7ab11so5336951a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701683252; x=1702288052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8leu+SuQjkbNs9q7zh3lxM2XK1S53AXUplHVvmPWVE8=;
 b=EZrmOA+5BC26Vma80TnutTwJPh7I6+XFjC1II5JhekBcxQUUw83B4Eyz9+IYb3AQPp
 Weybuv6amfhrL+B99N/09JlwXA6wcA+yizyB9a3mQk3bXDIPWihm8rLpXJhiUVo9JrKJ
 OOdxMCt29ObIMgNwz0yVR0H84sjxOc/qWjfKHvJgDjIFhgUeENGm2NvhycKnYRAAOcjw
 1//gv3y45X5EVfl15olXt7SetH182/RWwTlVETLMF/y66ZcfLIDqbIWQ53K6a1uSEqGq
 Mk69BAeg71zHhfajJ1itSYEJAZcef5MBiHTrvdUVwM9toT/tALiWU3GWS6Q6UDe4j+Zm
 9ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701683252; x=1702288052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8leu+SuQjkbNs9q7zh3lxM2XK1S53AXUplHVvmPWVE8=;
 b=wTDoZJ5KzbPKSyoq4yw+x8NNatn+DK86v6guAqYaSsZeXv0Hpij2mbD8q5zk5Ws0uF
 F6Ro431gQRc77TQk5fbT1uCafTV0OW8Notsjq1r+KoaWYAqVrLI1TxUrRTpchlAeEMxA
 bhd65F6eJU9TbOe6zAGsIcjxYnTfMi9AxhmL3xMEPj6Wl9MYIulOpKE5F6vEZuL1mzq9
 vOZE5FqEMxZOpvBFSMERbt8SkbgvOHKyoQNGNyec4viTVAEQeXAxZOvhD6W1Z9aQVrW4
 aA+3xsLp10dg6ux4Z/sghQY19GsmdIwnwv8/pRbpO0cDJ2UPD1iLnHDkH2FSHDGfQ7MA
 FL/Q==
X-Gm-Message-State: AOJu0Yy7CihVLm9s0MWNaMOYS/0ruFAyZ9RSjtRrLRVuXaQix43AH8eH
 mLeR+3wpAkAY1swJ4xpYTymmPOIoeB5KLXBa8z8=
X-Google-Smtp-Source: AGHT+IHyElfZ4SVP0tCcNrf6Pb0ioG1OjMCERJvza5s7u/N3ioGIbpPjsQ24gYmqlfgwCufx1kSEN6R+4qTkmVlri08=
X-Received: by 2002:aa7:cd6e:0:b0:54c:4837:a650 with SMTP id
 ca14-20020aa7cd6e000000b0054c4837a650mr3190404edb.61.1701683251713; Mon, 04
 Dec 2023 01:47:31 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
From: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Date: Mon, 4 Dec 2023 10:47:20 +0100
Message-ID: <CAK9R8u_MQtmYcPwiYwXmqse+1yfPaE1ZEHZVtrgHAP-KgPAT+g@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: andy.shevchenko@gmail.com, trini@konsulko.com
X-Mailman-Approved-At: Mon, 04 Dec 2023 15:39:38 +0100
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

>
> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> but I don't think any U-Boot board uses this.

Hello, could you tell me more details about this topic? Which platform ARM
are ACPI tables enabled for?

Le mer. 29 nov. 2023 =C3=A0 20:28, Simon Glass <sjg@chromium.org> a =C3=A9c=
rit :

> +Heinrich Schuchardt
>
> Hi,
>
> On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
> <phanbagiabao2001@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > I am a trainee at STMicroelectronics France. I am working on a project
> "Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex=
-A
> . The objective of my project is to add a way of booting (with ACPI)
> besides Device Tree available on STM32MPU.
> >
> > I found that ACPI was enabled on some x86 platforms but I don't know
> whether it was set up on ARM or not. I found a PATCH that discussed
> Enabling ACPI booting on ARM with Raspberry Pi 4 but I don't know if it
> functioned or not. Did anyone here succeed in setting up ACPI on ARM by
> U-boot?
>
> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> but I don't think any U-Boot board uses this.
>
> >
> > What are the differences between x86 and ARM platforms when enabling
> ACPI? The architecture of my board STM32PMU is ARM so can I apply the
> technique used on platform x86 for my board?
>
> Firstly I wonder why you want ACPI?
>
> Secondly, if you have the tables somewhere it should be easy enough to
> build them, building on the series you pointed to. Heinrich is
> interested in this, I think. I can help with advice. I have been
> toying with going back to that rpi series but have not done so yet.
>
> Regards,
> Simon
>


--=20
PHAN Ba Gia Bao
Etudiant en 5A STI - INSA Centre Val de Loire
