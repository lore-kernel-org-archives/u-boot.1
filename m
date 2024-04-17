Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0117AC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 19:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5552E88119;
	Wed, 17 Apr 2024 21:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLXbQqQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4738F884D0; Wed, 17 Apr 2024 21:29:47 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F22487FED
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 21:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4dacb2ad01dso1775e0c.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713382184; x=1713986984; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWArZiHhkxZ2URZfetTgraqwVBYUjyfMOBZfTa8VG58=;
 b=CLXbQqQ0ZpZZy+YSCUQR1nF/rzYzgzIHdpN3UVA6Sywt51DsRtwF5dgemCSJyjRBvx
 jynKtpodVltI6vhNaa/GOvhvF5nFsCyz89EswdtfH1jKBdFkv5H3W5SfZDHq3xeCFstX
 YocJNCf+Ua1HpOdoPV6bhJMhkNWN1XpH+WMdjObmjy9JsACtyko/nBWRC/nRySVJ/vds
 xAurZEkD4gug4v0fqAdMsQnxVn+Wbu/1aiGPHQv0qPZM9ZFGwOsl8HJmEvTe7ixkZ5G1
 Uw38id4V02sqhtJcd0s5yUYUWrk8YGRn8cEtPpE9XvP2AjGMqynHNfZeumJMSj689mON
 Xpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382184; x=1713986984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWArZiHhkxZ2URZfetTgraqwVBYUjyfMOBZfTa8VG58=;
 b=XtvevX3T+4Z88nK1KJ4n8Rj7W2+6qtMMFrvaY2BWiyf7HtI5TV9VKfrqoIJdelAgfr
 HxRSSOTrn0jE8tHmzOqA9Snl2YK/2X6qT2wTD16rDzgZIqT5D3YFzE028Z1f1I3JQk6O
 QX9QdzVKf2JKgC1Q+C/8WCfxHYoqkR1fEXQw/x7pgMI5QJt7dCFZjcpj0Mg5xjdra/SZ
 4Q9Hy6666f7Wd+bQZ36PUeTz8Qqas5zgWkyuJah/qR/sm3az3ORzZSA6xJR3yI9Z+K7z
 dBNImzDGATaL0FNvgt991KRD9pSlAxgEK2k6OuRs92shwuLFJrYNY0tB0/yjIZXNAMp1
 0jpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4NTkWHkLLm6xSYWhkrSv5hu8ojCQLgoRggePhCBAS7fBbE9JDubxCXdGY7MUzx0HyW73v7oyJ9kEsflS+0tVzfTVK9w==
X-Gm-Message-State: AOJu0YyBZFGsdOESsXGByaQqiJHJB05dJwTV8RKCYyptxFxBSCfqM3X+
 51ABXUn6n8wNbmTJHLliYIh2G0C3UTJCj2yzAYatXih6eYyxfhTqxtNV24WLEzA7PimwuC458ZC
 F8Sm0dsG1yDz2/iJv/QT9LK41YqE=
X-Google-Smtp-Source: AGHT+IH7tgbEyrqN1M+koJMPClARybNlz/Cpt23orvRmINhvQnrzJMvaIcigvHhX67ydFL782FepWFnA7M7w/x338OI=
X-Received: by 2002:a05:6122:984:b0:4d3:3f2b:dc63 with SMTP id
 g4-20020a056122098400b004d33f2bdc63mr779343vkd.5.1713382183465; Wed, 17 Apr
 2024 12:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-5-heinrich.schuchardt@canonical.com>
 <CANV2PTNLVMQQYugK4HB3Yv6WXmrbXBLB0FswKPHqq47OkX-DFQ@mail.gmail.com>
 <73cea290-b42d-468c-8525-c285fcc7810f@canonical.com>
 <CANV2PTPsxrxBuJd=-GzXF5VBsWWA8LFcMvBwYDaX_QqJugD_BQ@mail.gmail.com>
In-Reply-To: <CANV2PTPsxrxBuJd=-GzXF5VBsWWA8LFcMvBwYDaX_QqJugD_BQ@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 17 Apr 2024 12:29:31 -0700
Message-ID: <CANV2PTOZ+RpCpT+GroyaxGB0mB2hq0r7KjMwnj9UTAmrcrGgBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

P.S. mis-spoke should have written "Having 'env load' allows to skip
that reboot step
in-between

On Wed, Apr 17, 2024 at 12:28=E2=80=AFPM E Shattow <lucent@gmail.com> wrote=
:
>
> On Wed, Apr 17, 2024 at 1:22=E2=80=AFAM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 17.04.24 03:41, E Shattow wrote:
> > > Successful in use w/ 'tio' serial tool and Adafruit CP2102N Friend
> > > adapter on Mars CM Lite board in DFRobot mini router carrier.
> > >
> > > While SPL and u-boot.itb payload are sourced via UART the environment
> > > variables are from the environment variable storage as-is. This makes
> > > sense in the use case for development but may have side-effects in th=
e
> > > case of U-Boot as a JH7110 recovery tool. There is now 'env default -=
f
> > > -a' which does not purge non-default variables and retains the
> > > non-default variables when migrating from vendor firmware. Consider t=
o
> > > also build for U-Boot the commands that can aid in cleaning the store=
d
> > > environment variable state CONFIG_CMD_ERASEENV=3Dy and in-memory stat=
e
> > > CONFIG_CMD_NVEDIT_LOAD=3Dy. With these it can be done easily with: 'e=
nv
> > > erase; env load; env save'.
> >
> > Thank you for testing.
> >
> > After erasing there is no need to save the environment. If there is no
> > environment on flash, the default will be loaded anyway:
> >
> >    *** Warning - bad CRC, using default environment
> >
> > Instead of 'env erase' you could use 'sf erase 0xf0000 0x1000' which is
> > already available. As adding CONFIG_CMD_ERASEENV=3Dy is not necessary i=
n
> > the scope of this patch series I would prefer leaving it to future
> > discussion.
> >
> > Best regards
> >
> > Heinrich
> >
>
> The 'env erase; env load; env save' can be done at the same session
> just before recovery write to provide a sanitized environment with the
> defaults of the present U-Boot payload loaded via UART, so is not the
> same as 'sf erase ...' waiting for a reboot (5 minutes more to
> transfer via UART at 115200 baud) and needing to interrupt the boot to
> further 'env save'. Having 'env load' allows to allow that reboot step
> in-between. Point taken though, it's helpful for recovery but not
> required. -E
