Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8D3CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4941A841C2;
	Wed, 10 Jun 2026 10:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="LVYJILg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C92846A7; Wed, 10 Jun 2026 10:59:20 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8AB83FEC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-13807d2f898so5688912c88.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 01:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781081957; cv=none;
 d=google.com; s=arc-20240605;
 b=e5Tcjm6HiBrUWywe224VGF6yfkJ9vylv6DdZv7/91UZB57SzTZBXSOfMsnGMMR+Knt
 mtnTTLKHL3SbJWZ2bzDUONQ2ZtMjL2TvDM4a4vx2ISNuhY8JIdWFSK5fayksly0VGLkz
 BURQg9krlneLtRFDWUnAcgQhNor/HK4Ymm6pNZ5orLdlvtXrK9+j+OBxxzZePw/Iz+Nb
 a74WTl/HbxpJdizmfX5u0PBe/iKA+HRs3O41rMuIso1U0yAj6XPTJp1t7G6wtrddKOYK
 EZqdl7tn5K+vtbE9uoB4jtxWiyqaVMXVJQZQpN15fkhwKa0N5C0jy99gs0IgaVTm6h6x
 7laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ALlxyQG8wtJsWJ0ovFRQHWX0Ixiju4bCmJIh2c/1T7U=;
 fh=NNocFvm+8BHN9r+RumAb4BmIcCwMKiKgbaPoj1ScGIQ=;
 b=KtrX/YlyVVY71SwuVrzFdaNeO1PSWmOJDs9+Cs+bwVWANJjTRhfifJN+SLWA+wMDNY
 SCVPp77wxEvtahIL35cFdD6Cr8+S9dl9JWujl0cMWln0TT77HceD89/q9t9BVcYZmNif
 lOQJqslV7kgg/zdtzOzd/Hu5st7mZhLXdltX9aNoB9NMGvdzW8ko0hT9i1CkHRICHr+l
 9lhIAo5oVj6sWuANroe9ieBOnYrcV8x0mBudl3iEx/UduRD0MxerFdj/INteSDNklBP4
 wY3IfzWAYSE03iGBdyO593UfEmw08OjZKOML1iFPxROUxzhEl81PNsMEGyvrJcbfd1jl
 K0aA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1781081957; x=1781686757; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ALlxyQG8wtJsWJ0ovFRQHWX0Ixiju4bCmJIh2c/1T7U=;
 b=LVYJILg3hPwb5gOs3drcmZbD/GkiEFfGUa7/93zsFUYzbd2xMhwt5vdZnNpVtW4imF
 LTwO3nUU2ZkxxkxbYuqS5SjAfls62PnpTIMfDiI5gTf4LZYlQZNhXK7kIk3vdxQclaDp
 EcQUx8+9bPWtvp75MWG50usbQpSWzmZ7y884Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781081957; x=1781686757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALlxyQG8wtJsWJ0ovFRQHWX0Ixiju4bCmJIh2c/1T7U=;
 b=nXuKZlaIAO1Q3/jTMBLkc0a8X5PX2az5eRv06UkXiuMAW9S5z5fHtdI9o2LUQbmMGo
 wPtfuLd+PwmWAcuw4R6jXWCe5PgDNIktSDnkWJ8etQbQY35+gocG6lJGu+xlyqvfyz38
 aUIPl+5L7efqICgGReXtUWSSuMcWYLzuI4EpFpXHvwgFq1mx/x1mJRb7bDYB2TPwoFh/
 kbvCfqXC6hI5SpufkX6dMlajy2RqDmEUZB/ZZ8LtmF7R29iBAXgQVAe/3Uh90wkCeuCg
 MMwoj4TygAMtmyRjR3JKWNR9wEFZ9GaOYlmTA8C7fNAyi9TLdWdUpA6IxLYMp1q3GTZ0
 FP9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pcLKjTuGniL4ppXmtoCoAH25GO12ZT+CGecCZs9oHd9qRTjwjA5PCqoPxnF5Sl8p1ABjAuB8=@lists.denx.de
X-Gm-Message-State: AOJu0YybRtEd4PzZhE1bz+SLJ6rEG5LO1q7KbKTdP2+gOcbM7q4hIXsJ
 /G+R66vXBx7+ZHIYwGJJSVLjnVwct1XHOwRkdJCVOLmD9v8ScpqGwkoDXApejxfOhNpVQ2fsRVI
 K80bgM+8kmfb9gEbYrwE/gMgxdrHjGh3B9CUl6HDSgzOPHc3B0HOG
X-Gm-Gg: Acq92OFEcWdXcaJYcp8jQStGULw8Wx6bYpLdOUa+GQKFHnRiZn8n65CjUXLMWsAdU8z
 rAY/RZGbZRmAHOf3c91zB2qzPIdztlcecJxJ71VXSI3dQoEjNeHtoa4yGp/0+F8z82o9FgonDto
 +3gAvl89vmpEBey8st9tXbJrYPnaYyRl+NZxHmQCfVhSgPkZYd0RAOlhnEtd7JFG4azX4uEySqG
 k7yPE4y2NP4c/W/ZeZKfhVmeW3HCRK8nGsWpgbnJ7M3n+0qm8itd1Yrg/0GUXDpy+jRU6kUzhJB
 xtgZv4rqGBswI7948uVdcYYa34w2DDjzCCdLZ6yl48MqAQY69g==
X-Received: by 2002:a05:7022:797:b0:136:c565:e847 with SMTP id
 a92af1059eb24-1380674955dmr13799857c88.32.1781081956921; Wed, 10 Jun 2026
 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
 <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
 <364e247b-7cff-4711-9d1a-2a1c9b6544f9@cherry.de>
In-Reply-To: <364e247b-7cff-4711-9d1a-2a1c9b6544f9@cherry.de>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 10 Jun 2026 17:59:05 +0900
X-Gm-Features: AVVi8CfWVSA8uEiY9XwifXsKkB8fA8P1GHdliD8sRPmmCC6daVECd9X_vpiBwgY
Message-ID: <CAFr9PXk+k2yhuxTiZGJ-m7+pAb-rUpGRfrFgTHJzpaOxmgg-xg@mail.gmail.com>
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Quentin,

On Wed, 10 Jun 2026 at 17:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> I'm fine fixing what needs to be fixed now and improvements later on.

Ok, I'll wait for if/when Tom replies and maybe send a v3 just fixes
the main u-boot part.

> Note that we generally do not like complete rewrites in one patch but
> rather small incremental changes (which may end up in the same result,
> but is "more reviewable"). We don't have a maintainer for that feature,
> though Tom is the "catch-all" maintainer, so maybe you can convince him
> a full rewrite is ok. In any case, I'm sure we would really appreciate
> tests (I don't think we have any from the cursory check I just made) so
> make sure to include some (especially for the issues you encountered so
> we don't regress!).

I haven't touched it for a long time. But from what I remember fixing
the issues in it was basically rewriting it because of the code style
etc being so different from the rest of u-boot.
Maybe I can use AI for good and have it generate a series of patches
from my version. I'm assuming sensible non-spam AI assisted changes
are ok :)

Cheers,

Daniel
