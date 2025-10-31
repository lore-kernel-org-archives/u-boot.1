Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DF5CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 21:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D8883B03;
	Fri, 31 Oct 2025 22:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3HCU/93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8CB83B0A; Fri, 31 Oct 2025 22:02:43 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BE783AFD
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c53c863172so973436a34.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761944560; x=1762549360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2nFR7A/lfTJZqW3hkhJIkuUugwzKY+vi06XY7y3lgk=;
 b=W3HCU/93X7+ySgn5I44a2EKmLnlWCM1YiRyUXGA7eTbNPCcRFWQGUNgX7Srkv93lfF
 T/x/a0XBBsWHl5r5JMsE6Q5zlOzo7o72496MTCUl+4HggCOWPaAloqlpyyf+m9cZyHc/
 O+ohYEpAucjCwghJrDnAUxoFbRSiKyxdGYrr2Ug5DLU+xUbKqqH77N8SzT54pD4sHBtp
 JfmJ3aemurFIArhKxQ4/pk1I/X6F42VNJmLvRvOVm0dZ0lmV5CNR6PRGAc5mHNXVN7dI
 +QkSR9Rq+HInIP1wDiswWcCROAtQ1E6dTudLrbY3Z84cQtkWjwiYzGamOJcdk0U8f6LN
 BrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761944560; x=1762549360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2nFR7A/lfTJZqW3hkhJIkuUugwzKY+vi06XY7y3lgk=;
 b=ReOI/XYnkK8ttLvj69zOKpPIOut1+8fgzPXfdkoBkyK15Yt4M+nM+UYJM0Dtapo+ZP
 YR3UgkI0KtCkAI92+KIo9WEVT0UDDowDdKFExST3TwtpJYwdIo9WLnvdpilr/DHgDT8A
 tjtlMVHfMR2iM2gDFhbjTRGiUqYe7+kVYQnBEaRKMLBm1RtDp+SnziNykaxg0xN+jNoE
 LoRhpsS/WW7A6KGvyWM0ti5kj6H++R/r0hcpBCpj4Egw3EMlQSEihOfn4dbF9/KcB70C
 HB3JxCppsQxSwWH8kCjUyW7esVBE40QqLBy0FdfEDq71LPGk3IcKDzmW5sj3iZQIYqyF
 l1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeaf7Ve3GsiQ0K5iCslqFnDvIdZTHP3xP8mNZQMyGjojkWtqqCeT6RCkrC6XHT8lH4drg5eCA=@lists.denx.de
X-Gm-Message-State: AOJu0YyvB5uJ5Vj8bh0OgP+9ZS4MdBcnr2lUjHMqcBeRIU26WrPV0szz
 x71lPgOi6G1Rv8QPtHFnpovP5TZ9Xujx8b8cYyGqQdNtzgyQX4c5ZSTRZ4iVh5hlkrFqc9Mg2vK
 hNze2gePvx+3CpHvCjOscOFmAhy2D85Q=
X-Gm-Gg: ASbGnct3Oqxhu6yn7R715/og0YuxxmtGfP9N7D5Q15oeVoMS5/gY14H/uU6PZmmYWsP
 dAWmzo6RFYIEx+ATKDIWsqfUqGFakSmFG9X/w69MTklJvGvE2tAv5ALWYTmxilTZw81Dy1ejiOV
 JQP/7ELXwo/BDQlF+J6PodIBKO/rfUnc4kr7PxUF2Siq/HO336p6Kus22t0bDG5ZRfYbkj3BUbF
 DCdOVJfUvB4DIdLUXiXoujSs5RyTPQypZ6RdoxK+YiH+0wH+PAeSJ29R3TUVw==
X-Google-Smtp-Source: AGHT+IGhznHRi03fcyvTM6f1ZpDW6cFnQgQt+2X9g0jU60WBxKSa9FH7IvSS8xjL7tUeWQU6pnlGX26eFV2tvQibzQA=
X-Received: by 2002:a05:6830:2783:b0:7c5:370c:1290 with SMTP id
 46e09a7af769-7c6966fb245mr2979920a34.10.1761944559894; Fri, 31 Oct 2025
 14:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
In-Reply-To: <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 05:02:29 +0800
X-Gm-Features: AWmQ_bnStMAsolvP2M3PIx9JcBmuGQlRpPP3YGYugPbStTyU83XvPwmHfn038I0
Message-ID: <CAN7C2SDpWi4-+adCT+KbW7mhBHvxe95YGin2qv+AHRAkc1=ASA@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

> Your original mail mentions "sometimes fails" and that you tested U-Boot
> v2026.01-rc1+, the most recent change for the nanpi4 family was related
> to sd-card regulator handling to improve reboot when card was using uhs
> speed in os and boot fails in spl due to this.

I cant 100% conclude all boards and situations so I used "sometimes".

> Please try my suggestion above, the datasheet for the LDO mention 50us
> start-time and card may need one ms to fully init. Defining this timing
> requirement in the device tree that U-Boot SPL uses should match the
> workaround/fix you mention in your original mail.

w/o modification do your board experience any sd card error or stall during
boot phase?

brian
