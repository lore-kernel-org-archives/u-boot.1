Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF06C52D71
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 05:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EE488B33;
	Fri,  2 Aug 2024 07:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="QeQhr9h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED05883D4; Thu,  1 Aug 2024 20:37:25 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C7588B4F
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 20:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef1c12ae23so83880371fa.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722537440; x=1723142240;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghrZBfxP2yIHvV3VvyXO9PgfCF28QwaGOUMdFz3VjyU=;
 b=QeQhr9h3jYmd7VB2XlArTzW+Z9PJ6gycBsFo5dLlLgRxGF53kBUunL9LqqTod81Feu
 MWBoGbqtg6KxjPw9+ksF/c0BJl3Z5cVXNvdAUDv91BM/YBJlbMEFMoqslMPuzoUPNwHR
 9EzjijX0eQ6NA6Nmar3VEY8ZvRiXroncjRG7WLJhUxNPVZLF+EZoLSw3ulTKx+VE5I6N
 76dzGvajc1Yqr9Czu/1MF2hrf3udRJyvDUZsTXuoW2RdDGQKxMshMXasY3HWpAgXyt1t
 ZT2M742u7cPdFBlMhoqgCikLj/MVY2N13mWjVcLrJuRPYscrQ03TGrknZRVz5gwi0lwh
 RHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722537440; x=1723142240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghrZBfxP2yIHvV3VvyXO9PgfCF28QwaGOUMdFz3VjyU=;
 b=cfWGokIM2hxbXK00m5tYWkSIWXiGzblwthTw/luaI0RzNzwEl/Y4B+S5BiQn/1hBVU
 l3Vc/qwLDab6yJ7NELBsIX0MEH2KW0dN3JJFvDoq7zTVmXYy+9z0Q0Vs7Om5Kvi8LRqK
 NAq08Tz4JFZ7SSWmIEGNAvo182QdSRm8CqNzrSyPAFqlAZLgL21H/qoogp5Axq+3gJCx
 ZGZvKNwrDvcj6s0xyM9mYCUook8PWQQVunGbDCqtEz1ETlROgLbXqAotCLB95IDxXbcQ
 e3pzdu0MQemrsqfijtJEexcgvzvj9ra6S+aUfEVDi/vR6QscA3QABd2fjkaRlOxbtb+2
 ut7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW+fpgouxB/ca/8SPdeiS7LuOqLBowkbJvbw1xKfaNeOSYPNIVyNS8Zc4c0idhqCilp8F5ZgYcsk2UrjwZCFOC4matJw==
X-Gm-Message-State: AOJu0YwotX3ehuEDbfccJsXWWCBXQeLeJtgLU/U2l3blLFUIX7tcNePj
 MmJqnwLcPYQqoDuLyaDKs5cFSc0GZBzkOwBjLSemdOUMhyckAbFzqXobzkMth4HXqeLG2xcXZQw
 hq7CCMyE6ygo7nh28j6HQad0yi56H969b7RoTfw==
X-Google-Smtp-Source: AGHT+IGreUUxkAiX2yNQRn3YmjTGDu5g5apf5ThTXJ5ZQbOZ9wv7li4lqeWkRbJTc4yTxfhPYSCqVGCDQJ4qayos+uU=
X-Received: by 2002:a2e:a9a4:0:b0:2f1:5c73:f215 with SMTP id
 38308e7fff4ca-2f15c73f368mr1808521fa.46.1722537440187; Thu, 01 Aug 2024
 11:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240731134257.686017-1-admin@hifiphile.com>
 <CAFLszTiAjodH7P50ryJv7NZCAn5zahT=gBrvs+sNUPX0CDdb-Q@mail.gmail.com>
In-Reply-To: <CAFLszTiAjodH7P50ryJv7NZCAn5zahT=gBrvs+sNUPX0CDdb-Q@mail.gmail.com>
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 1 Aug 2024 20:37:08 +0200
Message-ID: <CA+GyqeZEJJocLXRKP5aAeKeZABzEGqkBqagRZyvwJjE2bjh7sw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] dm: Duplicate uclass name fix and alias
 improvements
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Aug 2024 07:58:00 +0200
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

Hi Simon,

On Thu, Aug 1, 2024 at 4:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Can we rename the gadget uclass to usb_gadget or similar, then update
> the aliases?
>

You mean split patch no.4 into 2 parts, first rename the class to usb_gadge=
t
before doing the alias job ?

> I think it makes sense to show the seq instead of the index, but
> please update the header for the table to say 'Seq'

Will do.

> I assume no tests need updating, but please do add a note to
> doc/usage/cmd/bind.rst

Will do.

Regards,
Zixun LI
