Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D7AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294E1803B5;
	Sun,  9 Feb 2025 21:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k1BYRhvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D115807D7; Sun,  9 Feb 2025 21:14:43 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF0180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab7a342ef4eso260647266b.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739132080; x=1739736880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMwgBxagb/DGVfQEGCkzqfsjdxFYmf5CfADitWO14W4=;
 b=k1BYRhviCJV1KoCtbD54FMdVvcW+bWNM83Qa17UrzKPPshlQ3zwueOEZCDDmsQJ5nC
 Nk/xG3JAs+pINGMwuqJtVXhU/KAdhil5AvdzqXQdI4Ua0cEMjMpKgVt5lzWd17QfQJnc
 5NuPJG1JEkwrgPxzPebn4Ke76zaYSqYuwbEAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739132080; x=1739736880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMwgBxagb/DGVfQEGCkzqfsjdxFYmf5CfADitWO14W4=;
 b=FgJWxa6L2GszdCBpNJWGx51QISnH+g0ymJjbhR/sPmphN/41Lq/sexTCi67QTiEWnw
 EKGEjlYAALvnIFKNqunOT5/EV6sG+w3gru7VLC0TX8Kk1HpqbiRryjDQUjV2bvg750hJ
 zKcmundOKEEcl1hPbbFC+VYpWtu2JjVAua3IqOGa7JIrwDtP8kMtAiSqB6U5vacuFLTt
 kT8D7Mlvt1jmdCimk43nGt71V/NSG+SkjkMGontM3mLQw/tcRhssKfu/dUYxFuSKUhTp
 qAjbBLaoOUFSkNHDHv5lhV3YhHVCkYquxhEaBUZzZhNFgiSgjMs2N018xXBzjfkqSEWv
 VR5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB5Lgecy9oc1ZD3ZXBy7T4wcKLKSCTYLwCAZkmqm0PrSDuaCawyr6LJMnKdRw55U/Yl3vr3gc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4pJMGC8006aoLaPw4dYtZdPAkdm1A5e6rMQzudweeb3tFu9C9
 0RhTzLeHGPM/jY809Y4n+2UhNEd6uVogqsnU6Z0pi0NNLZWp4W5GyZKM+z3/oacQmlavjDo1FYl
 l9Y/UelDWRqy/WlHZjVH4n/1mDFcmmAWmlnG5
X-Gm-Gg: ASbGnct9T7QdlR3rsUFPGlCCpzjP0SNQjOl0IO259IvheFXtTqX2Zv0HguFf5ieblo7
 ovGvLA2JefHL6YCNvgtlhZkAtE+cMry17LsmNxLC2mfUHNcX+Ol87X/zaknbKBYyy44hSfCj98A
 ==
X-Google-Smtp-Source: AGHT+IEyjy6xTfOaXDFn19eDBbaI0L9cKO1/bY9of26JUv+YC2O+9dhSjKa3Z13EB3yueKYtpPvd7T76OoeVzjPuZUY=
X-Received: by 2002:a17:907:bb90:b0:ab7:9df1:e57e with SMTP id
 a640c23a62f3a-ab79df1e772mr569030766b.47.1739132080582; Sun, 09 Feb 2025
 12:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
 <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
 <20250209164945.GN1233568@bill-the-cat>
In-Reply-To: <20250209164945.GN1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 13:14:29 -0700
X-Gm-Features: AWEUYZlK3kO4gjSVp92595Yz3caBp-xLk1-SG8caYi4vFCyFUIHmEyJehcak8TU
Message-ID: <CAFLszTjFDzM18Nzacj+z7E+PaGwmF5+PcP=T2vFA=Eg1+AdpsA@mail.gmail.com>
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

On Sun, 9 Feb 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 07:27:37AM -0700, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >
> > > Hi Quentin and Simon,
> > >
> > > On 2024-12-13 15:30, Quentin Schulz wrote:
> > > > Hi Jonas,
> > > >
> > > > On 12/13/24 12:57 AM, Jonas Karlman wrote:
> > > >> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
> > > >> by binman for the u-boot-rockchip.bin image.
> > > >>
> > > >> Change to include the binman generated FIT for the u-boot.rom image.
> > > >>
> > > >> This change result in TF-A being included and the use sha256 instead of
> > > >> crc32 checksum in the u-boot.rom FIT.
> > > >>
> > > >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > >
> > > > IIRC Simon was fine with removing u-boot.rom support for RK3399 when I
> > > > asked months (probably years?) ago, if that hasn't changed, maybe we
> > > > should now.
> > >
> > > Good to know and fully agree, we should try to remove it now.
> > >
> > > I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
> > > this series they are now identical for the full size of
> > > u-boot-rockchip-spi.bin.
> > >
> > > However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
> > > starting at 0x300000. I have no idea if they are used for anything,
> > > if they are it is probably not for bare metal booting (TPL+SPL).
> >
> > I'm not sure about the extra u-boot.bin, but the fdtmap is so that
> > 'binman ls -i xxx' works.
> >
> > >
> > > Regards,
> > > Jonas
> > >
> > > >
> > > > Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.
> > > >
> > > > @Simon, you said you tested the patch series on them, with which image
> > > > did you do that? Are you still fine with removing the u-boot.rom for RK3399?
> >
> > Yes that's fine.
> >
> > Basically all my testing is in my lab now, which you should be able to
> > use with gitlab.
>
> I really wish you would use the community gitlab instance and not
> encourage people to use your personal instance instead.

I wish I didn't need one and anyway, that wasn't what I said. Jonas
has u-boot-rockchip, I believe, so should be able to push things and
run on my lab.

Perhaps the problem is that it's too complicated? If you could find a
way to allow this change in, people could just click the button and
may be more likely to use it?

.lab_template: &lab_dfn
  stage: sjg-lab
  rules:
    - if: $SJG_LAB == "1"
      when: always
    - if: $SJG_LAB != "1"
      when: manual
      allow_failure: true
  tags: [ 'lab' ]

Regards,
Simon
