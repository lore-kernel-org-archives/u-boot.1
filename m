Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9929C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A6980821;
	Sun,  9 Feb 2025 15:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GYQg8D2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBDC80141; Sun,  9 Feb 2025 15:28:01 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F040F80A35
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso5556577a91.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111277; x=1739716077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y32rIz7t0impBqB34TeBvmfW5adM1NBYCRW06zjNPXo=;
 b=GYQg8D2PwcUWmWZqpYEHhTl+5YYlEhg0/5h3qPQKIes+suEocXXdZU723hORknvlTe
 /0v40QOxuehiALr8gb1wMjE5Rhvs+NvgJ1OL/5peAiul90ARiLDiWWjcCU4iabP1dxmv
 M2pzXP9nl8jWHyzDybcTpW/hjvtrY2cYe641c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111277; x=1739716077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y32rIz7t0impBqB34TeBvmfW5adM1NBYCRW06zjNPXo=;
 b=PrmX049lvovtRAoUWVkkZYq6IWgrGXKRdRI6c6SHFMC2eXYg7pPdBZpZo+A/XK9dwK
 6Tk/3C0xJayehFWX79K4R9ktp9gheWZXZSzoOp3PUfu7BS2SPZizhrtKWUTJjj1wgqGx
 /tRCoL3TtHH/EFKZMHYATfplAIKLK9YfsGUXI+mzgfkLdrpQ+k8yVOfObdtYmTciUMCM
 MVdMM3KzpFZfGvchve45OE+3ONmqwEVSYdeH5ZLWoLjFUi4oMJyd6u1+bX6J4yOpmYYc
 Kd6IdUEkfAqbHEd550hCYUehLXqaL1KAzsABjnABYjMh5f3lVEVQKkbyYX3cWngpMUOl
 dTTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfeWb7Vv7nbMVEF+u1y0jIJ7z9BCd3M7YS9BUaqt10obGyDceeA1uuKPbOiP8tNqWvJoWW58M=@lists.denx.de
X-Gm-Message-State: AOJu0YxYuf2Qyo2RieEXstqG4CvzvRfqH3CzukShm7WzWt8OdXWGioeX
 pSSCBEoBzWSGa13eqNbwQYkN/BEsvXAsVMt7l0KAkABBwiPVxnLMvbvNApmu15Zom3KHO+DDYyL
 mgPIw6lZYmqMVUZBdkeIDeIvnMrwzuIiB4/+C
X-Gm-Gg: ASbGncsHQz0h181uswlpF75JRvWWgFPDJ1iwKpMOyhCMgdmCDyalunDw29tUnf+cqFN
 u3oejHrunqcop9A7KSDWsxDU1GdGWTuznVy9k8TKnJonKIqgboAsDFlxL+PaKqeA73p8NXvqTTA
 ==
X-Google-Smtp-Source: AGHT+IEYr8e8uJ2DXhVKpFQGwWS/IwTgD4yBBtAI71rzaDp/LJPFEl+mM5socFs/cL6laN+UbndfWGQSNlsCUrVmVHY=
X-Received: by 2002:a17:90b:3e8a:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-2fa22681b43mr15973835a91.7.1739111277578; Sun, 09 Feb 2025
 06:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
 <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
In-Reply-To: <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:27:37 -0700
X-Gm-Features: AWEUYZnoYHf6nDanN7J3PRmXTHG3aK6KScdcHEs2Lm_nfQvKZHOvDS67DHFShU4
Message-ID: <CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com>
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Fri, 20 Dec 2024 at 09:50, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Quentin and Simon,
>
> On 2024-12-13 15:30, Quentin Schulz wrote:
> > Hi Jonas,
> >
> > On 12/13/24 12:57 AM, Jonas Karlman wrote:
> >> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
> >> by binman for the u-boot-rockchip.bin image.
> >>
> >> Change to include the binman generated FIT for the u-boot.rom image.
> >>
> >> This change result in TF-A being included and the use sha256 instead of
> >> crc32 checksum in the u-boot.rom FIT.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >
> > IIRC Simon was fine with removing u-boot.rom support for RK3399 when I
> > asked months (probably years?) ago, if that hasn't changed, maybe we
> > should now.
>
> Good to know and fully agree, we should try to remove it now.
>
> I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
> this series they are now identical for the full size of
> u-boot-rockchip-spi.bin.
>
> However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
> starting at 0x300000. I have no idea if they are used for anything,
> if they are it is probably not for bare metal booting (TPL+SPL).

I'm not sure about the extra u-boot.bin, but the fdtmap is so that
'binman ls -i xxx' works.

>
> Regards,
> Jonas
>
> >
> > Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.
> >
> > @Simon, you said you tested the patch series on them, with which image
> > did you do that? Are you still fine with removing the u-boot.rom for RK3399?

Yes that's fine.

Basically all my testing is in my lab now, which you should be able to
use with gitlab.

Regards,
Simon
