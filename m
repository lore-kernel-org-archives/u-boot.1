Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F78C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 10:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90B688256;
	Thu, 27 Jun 2024 12:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="er8HiLAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62746883E0; Thu, 27 Jun 2024 12:28:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EED68823D
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421b9068274so65985355e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719484079; x=1720088879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzLa8vPz5UpRu3VWZPDwZ7yN+usr2b1BI1htbxAh9Hw=;
 b=er8HiLAq96IOz7tTiw44KwXEs+dKh/Rac4+dMb13QUwmbEmQVBmuhX/uXnslQfW+km
 pdf4yo8zRru15KUDDEh+oqod5anowZ1gSLe28ul+wlPJTIKMpYbCYbwezPhV81kr0T0o
 XcclMHQMsKEnv/RJuKMNI6Kd12Y8X7RK8mAEsL1c9w/QkdwKO3v504JKzz7vHAUDdUV4
 wFlxRdx6kVW7s4Y3mCvdjq60GtcdPSEThGJvYj19PQYEyvg3zXP96yzbaLSRGVhATWS/
 +NirH0WPJeHIS75hLI7JOP+K9Iwq9uztmrNZorMzEETB5YU6a3DMeTYWm5+9CSfcCkJ0
 KEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719484079; x=1720088879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzLa8vPz5UpRu3VWZPDwZ7yN+usr2b1BI1htbxAh9Hw=;
 b=adeefTlkHLSspM8DjfKMEmcx1CG9nrfKA8V3OFQ7KvPL9kxx0ubWlHNcP/Sw1npRXW
 Kk4pDOVFSR045rFZj22oj93laSfH+y13tyUlezjCdGQILSF5icV1SFYsEXo08K3Zp2zD
 XykDaxbHY3JfkkP8Uukum/2O1zBkvzlGo/28U4n+NZZumFBeA5sq+Rz/eJkyExN/igv2
 pkmfEGEhOHAUi2LptzeUzSy3pFjEIiANMOaLQwTPQc649eCv1WoDLugpGJQQGKsHLcHj
 M39rqpYuChRInD8JkldrtpgQPm6T+BHZiJQjF1H0xjwx/UTybQd5E8jDep3njCEasCIs
 SgWw==
X-Gm-Message-State: AOJu0Yx3R/wzg17aFncc2waSdOv2O6gNwzOqBLDvnc7iuJuRka1411RU
 lAuKYwv5F1z8IffzDELgsggbw1AzpnP2GykWvSvGtAvVl1zQw6neSzuqbFezDOgaq8K1gmKd0JU
 hss4M6zEpUfdxLzapgkxMvpnGxTW4Fg==
X-Google-Smtp-Source: AGHT+IGoYFU81n9E6tjRdGs7ybRpZrlc5e5Ihth15i6yNHIcfO7Xy6vgRYPj6H2lMOxIUfgJGsmX/+tA2ksQMHvbGzQ=
X-Received: by 2002:a5d:4e42:0:b0:364:7de:d70 with SMTP id
 ffacd0b85a97d-366e7a0fc25mr9612667f8f.29.1719484079347; 
 Thu, 27 Jun 2024 03:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240618120030.41502-1-clamor95@gmail.com>
 <20240618120030.41502-2-clamor95@gmail.com>
 <D2351R7O6BQT.1TQPPLXS6F5AL@nvidia.com>
 <634429E0-0747-400D-8457-2BA066B18FE4@gmail.com>
In-Reply-To: <634429E0-0747-400D-8457-2BA066B18FE4@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Jun 2024 13:27:47 +0300
Message-ID: <CAPVz0n088T_EiPLcTRdZtDzYh078pU8+wgiuM1yLzm5x5kBbcA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] include: configs: tegra-common-post: make usb
 first boot target
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
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

=D0=B2=D1=82, 18 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 17:1=
6 Svyatoslav <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> 18 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 15:23:09 GMT=
+03:00, Thierry Reding <treding@nvidia.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >On Tue Jun 18, 2024 at 2:00 PM CEST, Svyatoslav Ryhel wrote:
> >> This ensures that the device can boot from a USB device prior to MMC. =
Useful
> >> cases are when installing a new OS from USB while MMC still has a work=
ing OS
> >> configuration or if the OS configuration is broken in late boot stages
> >> (kernel boots but the system does not start).
> >>
> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> ---
> >>  include/configs/tegra-common-post.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >What's the implication of this if no USB mass storage device is found?
> >How does this behave when USB cannot be read or booting from it doesn't
> >work?
> >
> >I vaguely recall that boot order doesn't always proceed, though
> >admittedly I haven't tested all of these edge-cases in a long time.
> >
> >Thierry
>
> If no USB mass storage is found bootflow will continue with the next
> device in the list (mmc1) with co-responding info that booting from
> usb failed. I have tested this on lg p895 which has only mmc0 and
> with asus transformers which have usb, mmc0 and mmc1 in all
> possible configurations. I did not have booting issues whatsoever.
> ATM, transformers use boot order which I have proposed in this
> commit.
>
> Best regards,
> Svyatoslav R.

Thierry,

Since you have not responded to my statement above I assume that
you are fine with applying this change. In case you have any
objections please answer as soon as you can since I am planning to
include it into merge request for the next merge window.

Best regards,
Svyatoslav R.
