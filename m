Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D96C02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC85808AF;
	Thu,  6 Feb 2025 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrkDwecT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3FB808AF; Thu,  6 Feb 2025 14:05:50 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B692580840
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 14:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dcd9c38f66so3846225a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738847148; x=1739451948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8H9frz0/DpGCTYVly78gfEJtQM9Y3+xO0vzxla7brq8=;
 b=FrkDwecTUycm0JIX8nAWjRcob7AMl91O2TLfr4PDKT4TXRpLupZgcW/sBtb/tD7Tmy
 AgNHYWh1bzvpdlN2xg7hA5hARGFlcck4HqJUCpUEcfmkzuQLupHkiVXhbEecZA+mNfd7
 fx8261YaZxQfh4Rrvo7vqCeaYgW4uKcYe/318=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847148; x=1739451948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8H9frz0/DpGCTYVly78gfEJtQM9Y3+xO0vzxla7brq8=;
 b=TpPF+6Qf2hFnjW44xjSfnBnkRnYJol/XcNFfg1RE5IF0JV3NEf6zOqJg7enAfbD1wG
 IJv+7zY7a6T8Ax2fCPQtW2NXPVkVh8OOvET+neFSJ2caGUEOLsk6CQRp5M8pvMss+emM
 8XK448L2X7I3EaTg4YkSPPdTbA+Eh1Z5U79V9976YaUn1tw0FPojMhhSSxlY/Khj58VK
 sBIN6zmV7jVJOYmXhkC6hkz4lRZ0Kn4zmACFuwZmc6PclycCOutFDaAjNvnAjKOeRHDf
 0KL11DHI/eQLhE7S9nv42VisEpl/AyXU12dD27IMDEz9iPAfwReAPVRzmU9Vp7qZLEOb
 PQAA==
X-Gm-Message-State: AOJu0Yyr+xOLC3p+x8hCEVbpTBUUo9b61+rxhev/WqxyDAs16BlE1qg4
 /AjV2wJDzstEOo/vXepmhuaFQ68m+R9XCMleoVhgYeiToWfGCughVlrll6lYXjrdkbqtOYpAbvt
 jjJ0qXXv7BCnWcAtyDHZ1PlsrumCLLN1iM6k1
X-Gm-Gg: ASbGncu+N5AqA3Fp+PaTZ7oxLR23J9GmPauw/n9ix58gjuIGNbWeUYqsdJrPGmy2uhA
 pCTP3qWVd/47zg8unEg6JA+qJk5ZBY16RxpOYymCoXgEZ6IMaFICDeOOBQfaMpSBoBAm8+CWnYA
 ==
X-Google-Smtp-Source: AGHT+IFOB2dtZx2YZncTtOHmLlZr4JjWYsXwBujHEYirY6QtO0cjn4TdAsqtksdf2Shnxl+uLr8DlTVN1SmzwqrY3JY=
X-Received: by 2002:a05:6402:278c:b0:5dc:dd24:a7a8 with SMTP id
 4fb4d7f45d1cf-5dcecc96a42mr3289309a12.7.1738847148043; Thu, 06 Feb 2025
 05:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
 <20250203200744.GZ1233568@bill-the-cat>
In-Reply-To: <20250203200744.GZ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 06:05:36 -0700
X-Gm-Features: AWEUYZlimCesdlaiI4_a9QZRAJquTKDlTdzzuMw3vSwgnWs8yzVllzEEUwxaLgc
Message-ID: <CAFLszTh0JYdCy8SYOkbnhGZB-cbtcYeZiqoHp0R-VF4Nn9rbsA@mail.gmail.com>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
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

On Mon, 3 Feb 2025 at 13:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:41:54AM -0700, Simon Glass wrote:
>
> > Before this gets any longer, convert it to Python so it is easier to
> > maintain.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  MAINTAINERS                        |   2 +-
> >  doc/develop/uefi/u-boot_on_efi.rst |   4 +-
> >  scripts/build-efi.py               | 258 +++++++++++++++++++++++++++++
> >  scripts/build-efi.sh               | 207 -----------------------
> >  4 files changed, 261 insertions(+), 210 deletions(-)
> >  create mode 100755 scripts/build-efi.py
> >  delete mode 100755 scripts/build-efi.sh
>
> This should just go live in the u-boot-extras repository as another
> sample script. And as a bonus, there you can just push the script right
> now.

But I can't be sure it will stay that way. In any case I see these
scripts as first-class citizens, in the docs, tested in CI, used by
people to report bugs, updated as new features appear, etc.

Regards,
Simon
