Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0CACCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 21:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA1A83B0E;
	Fri, 31 Oct 2025 22:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jwYNC2s7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9DD183B21; Fri, 31 Oct 2025 22:43:52 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909CA83B0A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c5308f6aedso1940473a34.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761947029; x=1762551829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=akzQNjDiluWlNbz9UKAq5NLKc06TsAvZZDYAJDToNpQ=;
 b=jwYNC2s7fklT8ElL5TiAoFqV5/tdtCtSJflJ6N5MAt8dhtR0zsJay4ASiKoGnnRZDL
 ymfwmV9RN7QHa+tB+CZ3axdhP42bXJiaWdHjlmKLuYQiIHVRi4CV5WSiYgQ4XD9vJy1U
 SPStTPhPdzPExz61HJgfan8s10BV5Dl2cLpSl5Lw6mbDln6pVeCKYhy44BgtthWK0hz0
 jAw2YHjyOmZqqkDtVDC4kI7m07Yo0C+HU3AusiuOzvmdJQDoo1dsxQdydD0ix1yLPit7
 LSlobNMLQ8+5QWrApR1menDKrm5s3v2GGQ/Jt5uBHgsDlbTY9cto187ssueoV1Zu7yvg
 wJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761947029; x=1762551829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akzQNjDiluWlNbz9UKAq5NLKc06TsAvZZDYAJDToNpQ=;
 b=gqSFExlRDZ0VEruX2OMAzdIR2SfEQqxRWhbLrl8kpuhTOFvNF6IsHGyjCop6uxVB4Z
 uI9zKgVW90LHNyVW7k+6Qz3w5rcSCTM0QGYkZrEaa/5PYw7hUiu0GKa0ItPc0IVnes3A
 KUZim6wcAlCJP1nfd1ZlHp7AbhdIJ1wwczfdkTLZRw85pCrAW970aKBk2Zudy/EmX0lx
 6l3RMtEnIvjqoR75SQmK5bAZHIvoBa5J1qpJHUbwZICuChkOWi3KKAiLZd5+AVS9hg+w
 QDzn1J/EdpOMqs6lelByOAAfv+Q5qEi2Et0rSZ2K2McVnvUnLST21MsGe+Wmp09gK/wI
 kqIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWwoYORr0GMqWwd9evNoT+nqhjOlNigsxI/GlKRFIbRTTEXcGoV8lvz7OtQE5zMK5ChSDv0z4=@lists.denx.de
X-Gm-Message-State: AOJu0YwPIWJsR4EXEUsoGDY5glBeD+Qr7ahyAAAPKUwlevgWsTOZV5eQ
 uFfVRdrquZpb3rT20wHEnhHdR5uMQHBYHSwWxCo0x7id/w10IY+xMmT4/QhOfXG1UfUSantGVul
 dCJL5QTiOi1XKmRxSgHCK2PJGeIilZjWxA09yDmU=
X-Gm-Gg: ASbGncuOs/E5UGH6jZUTOw7QR/xnWgUPUQdrGzlisI5moYyFXfxSZX9CUHCKVLKnsI8
 tpkuIUL72FFx0sVopHGEvMZ0Dx99hDULS5B7zXFLJKp9CDhxD3FRNCKK0IlWq6PQuGiuPqf6R4l
 y26VX+fz3J9rw8Ml821s3IvswaeWS7rgDhQ7l20tHtZywAt1WvfZ8i1rnVaMkAbxumrSv9YWpmi
 2JqTCKUTpPzUS7VjIxYB5b0vIDqe3/lMLwmaRaAX92PL3JNbP+Qvq0cHF5cZQ==
X-Google-Smtp-Source: AGHT+IHEzS89dGxEWmFnOKNACzouMMZRh7Fzhbib8xh79j3+CBi//Bqm7JJAiCZJE4Z+9k2CZyKn3ZN8mYjhKWrQ99E=
X-Received: by 2002:a05:6808:23cd:b0:43d:24b7:2b93 with SMTP id
 5614622812f47-44f95eb8411mr2560213b6e.17.1761947029301; Fri, 31 Oct 2025
 14:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
 <CAN7C2SDpWi4-+adCT+KbW7mhBHvxe95YGin2qv+AHRAkc1=ASA@mail.gmail.com>
 <3e1590fc-19c9-4e89-a280-cfc975bda8a8@kwiboo.se>
In-Reply-To: <3e1590fc-19c9-4e89-a280-cfc975bda8a8@kwiboo.se>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 05:43:38 +0800
X-Gm-Features: AWmQ_bmFHaaUNip8E7o_juy2G9n7FT0JHrpbPh3t2-svNshfpZYUnIQSQ7x1OBY
Message-ID: <CAN7C2SAp6znuN-q83wkwkqsSzf6U2VyQER5WwrDdmMn45QiA-Q@mail.gmail.com>
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

> My M4B could boot using sd-card without any issue last time I tested.
>
> I do not understand the purpose of your original mail when you do not
> seem to be willing to test suggestions from board maintainers. I will
> most likely just ignore any more replies from you, sorry.

First allow me to clarify the purpose of this email.

1) There are no reports from any user in the first place, could
this only be one specific board issue.

2) I never said I won't try your suggestion, however, the delay method
itself is a very bad method unless there is no choice to do so.

3) If there are board users mentioned this is not the case then why
cont'd debug on such? As the LDO delay might not be the root cause.

4) It is not guarantee my observation is what actually happened on
the boot error or stall.

Based on the 4 points I had given.

Could this be a board QC issue? aka one specific report only.
Could the inherent issue not be caused by the LDO startup time?
So more samples and feedback could help a lot to resolve the
stability.

Not simply using a delay test to conclude all things, this is what
I thought.

I appreciate the feedback on your board is not having issue.
Then with almost the same hardware design why does
NANOPI NEO4 have this issue?

If you feel I wasted your time on feedback and suggestions
I deeply sorry on that, but I never mentioned I am not trying to
take suggestions on your side. I am just playing very safe on this
issue as this could not be a simple timing issue.

Brian
