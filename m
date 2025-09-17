Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB11CA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 08:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7288883390;
	Wed, 17 Sep 2025 10:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UGTXpVGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BA2833D0; Wed, 17 Sep 2025 10:39:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F62F80077
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 10:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso1147123266b.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758098350; x=1758703150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t6XIrcrprvyVGuLj7XY6i3y85ocuOaqpp6qq2ABVLwY=;
 b=UGTXpVGSwTVaVGV8h86SJeUv6Fvc+Dz4sIC3qLex83cbYP8maXPInJOXH4wE9QF555
 z5o4afrr42sNg0TTsqk0BakgIbnIIyHhArDQvKlqroYvZ1tGDTZX1QvgIYYpgYeOg8mf
 +oP8AuetLfqChRIC78q+1VSK04aAoN8YdqLfnGes+wag8IodIml5hMl3r0mJvDKxwaDR
 /dYzefa2TwDf6Je2yQDMjKQyRlLpSIjK6aX5S8y6pM4AVRBKh9jDbrGjBju1I4bo9OiC
 HUZE0o7f5e+odyPXnDLRY+DF+7sNO8w+zWUN1JyCKf8pJesizW5zZqUzy6X88hZF2LaM
 A77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758098350; x=1758703150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6XIrcrprvyVGuLj7XY6i3y85ocuOaqpp6qq2ABVLwY=;
 b=pqsfwNl3Qm/5aVZ7vgRVDFE/SD8agLOl++jMts9NcumEoz8rGwnraMU5Q8+4D6Y9Dm
 YstiY5bGRjj5C3Qms2m7lIhqXa9+kaHwSoBMUym9pV2ILR3XgQJxXAkGd5H67kSk2qfw
 AE/Kgh2E5DqMoWPScfMCcfyRfeUyaiB1kdnhGKKyojdw7FFrZJZnEGzXdOVVunfejlN6
 qYRilq22XjUYWx6O+RzYNK1W+A+95aN0AylC+ax/F7NnwnPN6NtEoJPTngxMRXK+uXZh
 +AnqSUHtU+F/xFVup2nLd/So9gCKw0Ie2EiPqFZaHa/06/OVepccgzi1AmWsJ7oTggEz
 7YdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXddumSvJB+ZXK1ca2s+gUad8pBPnvY5c/nKHVxQ/Gil6RRyu9JjlOQ+ex9gKPHhkWBSbzDy40=@lists.denx.de
X-Gm-Message-State: AOJu0YxLjx1X5MLCkeOnmiX9F82eZt23meicyI6lxeN2CmbLDexU8ZNp
 3ZzLsYdEad6EnU8Hp4HwrAkJDHFZknGyxuL3yh1tlzbuBuKNAqdGku828tAr05DlHt6uAheuj/U
 1ntNnYgANrHjhW1XmF9cf+zqak9sTwqg=
X-Gm-Gg: ASbGnctcgZKqY82jzDwJoW55NusICXHtRHKa3Tq76zWekxnOWiX3pm4HC1FR82dP0R0
 GZ9EU6sL2O9lI3YNsJpS9jgf4ssOsUO0hKpMCyzD1SEL04zVfwPVwtJ+IgnEiUXbvctBnCdmJ5c
 s99/zYGTsVZb+ZGnOiS4y7gUToXnMaptKZNYpe/iZhKdCzH5GmgkWQIyfHQrCKbJCldP822Xv8d
 +5eSK81EQ==
X-Google-Smtp-Source: AGHT+IGnKOhjq4Y8R6KTGT5crQK7m0gQeV19iLDlzzsHzZkksypmV47RugWbRGKi22YRBV/M2UlA53DM7Z1AV48QPS8=
X-Received: by 2002:a17:906:dc89:b0:b0b:5547:409 with SMTP id
 a640c23a62f3a-b1bb7e3602amr156732266b.49.1758098350416; Wed, 17 Sep 2025
 01:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
 <60d548b8-1cbe-4fab-a49c-8b1cb9027f19@epam.com>
In-Reply-To: <60d548b8-1cbe-4fab-a49c-8b1cb9027f19@epam.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 17 Sep 2025 09:38:58 +0100
X-Gm-Features: AS18NWDYFXkl0JymXaZG96mXHhkGGg4LkLPFZiykLxzwozIwXHk3GkxrhjiXfE0
Message-ID: <CALeDE9Nct9oht9sVLFuBPJ7144VLj5aL1uhFzX81etD2zOhE3w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: Jonas Kvinge <jonaski@opensuse.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, 16 Sept 2025 at 19:54, Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:
>
> Hi Jonas,
>
> I see that rp1 bindings are already merged so we have started rebase
> process.
> Once we'll done we will send another version on top of the latest master.

Please also take into account the feedback I have already provided.

> On 06/09/2025 02:12, Jonas Kvinge wrote:
> > [You don't often get email from jonaski@opensuse.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Wed, 2025-02-05 at 10:15 +0000, Oleksii Moisieiev wrote:
> >> This patch series provides generic support for Raspberry PI 5 in
> >> U-Boot with additional hardware drivers.
> >> The following features were implemented:
> >> 1) add generic board config for Raspberry PI5 including device-tree
> >> files;
> >> 2) add support for RP1 chip with additional hardware;
> >> 3) add support for rp1-clock driver with dt-bindings update;
> >> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> >> 5) add clock/reset/gpio drivers;
> >> 6) add ethernet support in u-boot.
> >>
> > Is it possible to get these patches updated for the latest master
> > branch? I'm having trouble with at least patch 9 and 11.
> >
> > Jonas
