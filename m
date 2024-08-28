Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FDEC54743
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 00:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB3B8897F;
	Wed, 28 Aug 2024 02:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eSrxsbdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9AD88A75; Wed, 28 Aug 2024 02:00:39 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2DF88931
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so6781337a12.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724803237; x=1725408037;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DR+ljGSR2b/enNycIcgPd0skYT67s2F5h6hkjei7hHw=;
 b=eSrxsbdPViJZA2eSkupqAn0BZmYJDMLKKd8U+M8/vtu8aYjIlxRG4GwnXCA1qTCsQf
 f5rO1Ke9wjIGBemF7Bdbt7woSehsJe0ZmF3+XzydA2YKQ5nj4mReqJB424w1pfPI4U/+
 vnSwFQZV1WY7btM9dcFN3ZGSgUSkWu9XdH9Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803237; x=1725408037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DR+ljGSR2b/enNycIcgPd0skYT67s2F5h6hkjei7hHw=;
 b=Gi7bd6bTGJT/bbv4mvj9rXLXoZdzc2BZQUBZvW7Jee9Zyg9O/v46o3rPEQW5TW1pTR
 AYJAmA4kknDOp/Gej3YXHhk8GQIvwUsCgoBqHn1043amO1t0mPmnh689YNXmdxd9vRsS
 5Zpzhb9BQ4oXL0HsGTl0DAfpUO5zfHsIT+V7B6Fr54jhjb9osHiFR57DQ95UGgy59jxY
 wFSywAcFXHXhCOkfum55m4N+aIlf98hoeg9az6KLyyeDESnY7Fhfi2UwaHzJ7ZivuQw2
 3ra3OEfRe7ZRepARD+1Xf3f9CtksPX/tpXTgr/dYBuUSysvU98VOs6UGoUG6HVwcqmi6
 F5IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUI5WAya/vXY2tLBuQ4356s8VvqCP5fpTYkmETgOYUBkDH1zBjUfj7Pvg3snX9IW8hE9LbuTg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFrVOV+iuXhsIWWb15gVUsAcAwfLnhSaGH8/Hsj3o8QViLi13e
 6/tT255OdPcMw/sZQFzyRIC5icGficXZrlZE52emCgcKKTRCcnX1KiwKuIKNTOYPOLCbgG/iu5n
 Pg05Wgw/37WuZRvgHxw10zYQ3yXuD+AuvOSwk8A==
X-Google-Smtp-Source: AGHT+IH5qxZXx0VBztCc4EE/gr8LyyizuYWYO6yzy+CpOb/4plOQcDYNdnipnNhsR6BiYxp7xFmtqHsg1C/ez3okrS0=
X-Received: by 2002:a05:6402:51c6:b0:5be:e1bc:2304 with SMTP id
 4fb4d7f45d1cf-5c2138e0fdemr200194a12.7.1724803236179; Tue, 27 Aug 2024
 17:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240731145855.3122166-1-vigneshr@ti.com>
 <172480096431.2972894.12027347479310043926.b4-ty@konsulko.com>
In-Reply-To: <172480096431.2972894.12027347479310043926.b4-ty@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 Aug 2024 02:00:24 +0200
Message-ID: <CAOf5uw=13uaaXOdgbv2w8FJwGA4KMEuEeNVYxQLKiAyrkaLhsA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: omap_gpmc: Check return value of
 gpmc_nand_init
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, s-k6@ti.com
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

Hi Tom

On Wed, Aug 28, 2024 at 1:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, 31 Jul 2024 20:28:55 +0530, Vignesh Raghavendra wrote:
>
> > If the function is called with no NAND device attached, then this
> > function can return error value, proceeding further ignoring the same
> > can cause system crash. This is seen when "mtd list" is run with no NAN=
D
> > addon cards connected.
> >
> >
>
> Applied to u-boot/next, thanks!
>
> --
> Tom
>
>
Thank you to pick it up, I did not see it

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
