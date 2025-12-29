Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9155E92733
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 17:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8CBA83AAE;
	Mon, 29 Dec 2025 18:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljTxpT0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93DD283DE4; Mon, 29 Dec 2025 18:19:53 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A11838BB
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 18:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c75387bb27so3856917a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767028788; x=1767633588; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23sUi8wRSuf/sqmvMA/2n2wP5UoqvEM7f70AjRT8jNU=;
 b=ljTxpT0P/QdeXvBx090odjOlptsXFyY9jWEZXb2/1YQd4leF8sejMYx+jErbs2gdZY
 qzCNVjMFaMLVklL5Mhm5LE5V7bFWZRWZNf6P/tKxUwDuRieSCwonxy1OhRxLBe3qTWHU
 hol5bgPa/12VHZtIXJ//zzsl5QTPxN3mQfML1d25miM48q+fMzQIjPPTC15X8nslfEh7
 hTnNzJjGwfxIwk4BOmdRLfcG2xPLr+jBzsvhcEiRgazNv6gX8y1vbENqOWzr54C+ac9q
 mtqwpc9SGaNx0inPX9g0QQTweQB9U6LKOBbuUW1/R3EaAjiYEO8EvP34wHkJRmD4IxEY
 WIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767028788; x=1767633588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23sUi8wRSuf/sqmvMA/2n2wP5UoqvEM7f70AjRT8jNU=;
 b=LITMrOT1oYJ+xJ2hS997a4NHfhwHSY6smdLcVr85uWz/duyw0usV3ir8gm7+PN8C8A
 SuRpOdRYMqFxbsbVh04MkbbA7sDRFGwsPQoyqXBuRCRywaUwRZn4J0QVo6aXz9nm96U3
 AFIvL3wdCoXdE8FUwJKWmVXZoW75FhYwLIITOU0sVSoXC7gih/DAaylf/NpxS5KzMZ5h
 6YVplttA5s5AAddqQJARrNQxoVNqi0cszod9W8NJgZqOGzta6eq4/vV3+6iuta01+5hI
 Gv89s1lxpIv2k5doXZcaruDb959uCk40By8Foe+KRSz51IKjUNCOSVFvqxlRh/j4hJ7t
 mpEQ==
X-Gm-Message-State: AOJu0YyGj0lLFl/GmhqwVlRNTjEjHG7Ok+D34Q7+rAMviELRhzZagO0u
 xIBMYCI4/SYYeWiY58DgGc6/FcAn86aF8I47YZkG5qOyNfcWi7SAo6VueIVdSXAsIBcf/uMLlUC
 Oi19VtnBh7oyIh9+d21jkqCi0f6taVY0OZBLyFNw=
X-Gm-Gg: AY/fxX6PxISVImj785KQU2vEITPTGEtw0qurlQEDIRcrtII+Fy8qOZyYEmIdPXVykqJ
 QYeKPw0DjO91Y3E68Ob9julYuQlHBcocxbK6Mq4fJZVmRKgWBKK+VbMIhYoh5oTwn2ggkGlBQAL
 o61eQMZf6/N++b1UUEufAcYTfscXc6FWALNvJW5DPcu62M1QMFdain+Cf+6rFCb79AlzviEc/rb
 1OW2erFvi/BurYttPV63MVBObbjsRtXed74AcaQX1F0h6Yni2yIIwgeru9UDRYulKLq9mFZ
X-Google-Smtp-Source: AGHT+IE+fpB1xVNyVsSlYg6E+LDmHbdgABIuJOh2rLgk3Iwx5MD0WsonCBUvPvQytnZ6+YeRO8zZhvBELuMa1CRpSTc=
X-Received: by 2002:a05:6830:82a1:b0:7c7:8280:9208 with SMTP id
 46e09a7af769-7cc66aad8a2mr16025823a34.38.1767028788592; Mon, 29 Dec 2025
 09:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20251229151837.4587-1-briansune@gmail.com>
In-Reply-To: <20251229151837.4587-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 30 Dec 2025 01:19:38 +0800
X-Gm-Features: AQt7F2pcirFL87ayhHLUNc8SdJYUoYA861PgF1V9kmuf8aEWv9IWpJ-DK2k7aXc
Message-ID: <CAN7C2SBsdGqt7PEUGqCnrmg6-6GATr-71mGhQB-W_PRmBZPrCQ@mail.gmail.com>
Subject: Re: [PATCH v1] Add CoreCourse socfpga Board - AC501
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
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

Hi Tom,

Discard this patch, wrongly sent.

Thanks,
Brian

On Mon, Dec 29, 2025 at 11:18=E2=80=AFPM Brian Sune <briansune@gmail.com> w=
rote:
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=3Dviewthread&tid=3D27704&highligh=
t=3DAC501
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
