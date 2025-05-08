Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0FFC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 22:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7867782A0A;
	Fri,  9 May 2025 00:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="L++xbHoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBDF828A2; Thu,  8 May 2025 21:54:39 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986BF82162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so224118266b.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746734077; x=1747338877;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3stnx/8tSv02z2R+WZ/pNypTKXfQ6hJ4O4a92YG83Ic=;
 b=L++xbHoN5vd1eXMH+NmjEPcwVcqgs1fFdKaEI3X1dfX/5vy9u/FmiMUrspiz8krk2s
 snc62MvcjpnfJtTDGpMGZqiepOHapuwEId8PjDwORE6d19U1DlhYzi4ioCv6yuj6K+sc
 J8hPzP7bZ0fqg09a8Q3adXLlgdAlq//+K7XDhp05ksZ6NnMeWLXYXLv71sPb3WJq+0Yd
 9m9+5rfHbaJMl1Cx3ZsBjkuuN6/NA4sDg11P712jb/Bhyn3TXYsv2ywS6/JWnxrizBxD
 vtosU7aneTMsMC0CHkXA6fb+D8U+3DEv7+O5jG81WU5v0gePcH6vHTpdVGEXhcAc5WGv
 6rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746734077; x=1747338877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3stnx/8tSv02z2R+WZ/pNypTKXfQ6hJ4O4a92YG83Ic=;
 b=aCQU54hdpNI/rnwEo92W01aItQOEbMhfYt2t3F/P8Yx8ifPI3rnjWCgQTSTjRUuMjD
 y6dQlZV6NC/NZJ8MCg8HNUgXqpDJuZwS2vRSe5xme33uVf8/McrxqlhSfu7Ei6N9kVkb
 2SNEP86Eo5/LyaN6cPWhlf8GCH9wVcDCPeIM1vEF8AQMJNNw/9zK5IqASKDJyS7vzS8F
 UYpxNLF4bh+fCO7s1juKvA6qn5FA5T4NlkGgc6vXarUSQF02YzSHglMgkUJCJemWdkGc
 r9llx1ELmOozCXqlKgbPrdgidqMtRWXEzq7N2ppOvVWky2gnPPsH7e8++IFVfQI8grnP
 U/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWX1WifsoXNk8aRVN9O76zQNL/2rNvojM2caesRbuSf+2zzGkQfANxDbRoXi/o89mrmpl2O7M=@lists.denx.de
X-Gm-Message-State: AOJu0YzqI8kE778EXA7PvfgP9uqzF4owwzfmOtX73lwFu2YRFWaaWoiS
 dNvc7sREW3REXs91oqNr6+qnYKPFgneOEcba43amHhrcZunQGclQn0aKAXpYCzxmQ8LP6Fq2kps
 EJ4c9+H92VgsmAkHVD24zGiKW4dIEEDX5xb5B
X-Gm-Gg: ASbGncv7bl9bjNJ7UPsCWNjOe8fG8NFzXIdOQ7CU1LNQ4cAyrfZZ3SpUaAf4eFsdnY3
 JY4AbEMiQ2KH5yJyuz7UYPwUn5Q/vDIUUJLlNeSUV+3nx6YBjRZwLzUsiZWBfPPJMBO62fw6e8S
 PPq+0RgNicaicuGM8NSsUHGOKEjYg+MQ==
X-Google-Smtp-Source: AGHT+IH2+/gg13T5NN5Eyoum1lKK2XajbhrJ0rZkP+NMR+BmxtRzYNi93HyAeD7SxIGunz1ad62B7jFOeKm5i/whAuo=
X-Received: by 2002:a17:907:c081:b0:ad1:e587:9387 with SMTP id
 a640c23a62f3a-ad218f19a66mr78477966b.21.1746734076821; Thu, 08 May 2025
 12:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
 <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
In-Reply-To: <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Thu, 8 May 2025 14:54:25 -0500
X-Gm-Features: ATxdqUGw2CG134B1aSNbqeEu0cZ_c6g2trXskQS6xYNTP-PlR6OnNDQu0nF5Xnk
Message-ID: <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 May 2025 00:16:49 +0200
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

I actually already have a working solution that I documented in my
github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
check/delete a flag file on my boot partition and if it is found, then
reset usb and sleep for 10 seconds.  I then have a systemd shutdown
script only on reboot to touch that file.

CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
reboot... && usb reset && sleep 10; run distro_bootcmd"

It is a hack, but... the system reliably reboots remotely now, and
that's the important part for now.

Wayne

On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > It's hard for me to quantify if usb works in u-boot as I'm not loading
> > off of any usb storage devices.  It certainly never lets me use the
> > keyboard to abort auto boot, and never has.  On reboot, to reliably
>
> You can send bytes via UART to abort boot, if you happen to have a UART
> adapter around.
