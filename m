Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81D4C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9DE8043C;
	Tue, 18 Feb 2025 08:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K3q9SExu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4157C807F1; Tue, 18 Feb 2025 08:21:22 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E818800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-866e8ca2e07so1552056241.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739863278; x=1740468078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ldd3LwpJgzZPWtXkX8L7vzaUgv0zq/Xdy/N/AQucBo=;
 b=K3q9SExuqeIU4uPR3+yALyOOPCEG0gyOHHZO1jS/jiITS/gP10C4Ar2oJFqSN1zRnm
 n1cLjoweG+V0r3l9WmurGBpF1jLltGyeMqQj1FkhJp3PPpLozDEAWpU/aA9r6X6BBfKg
 aaNQt856kx9amNwZvqK/TO5xAvHEKEZcd81l63Wo6pl10bT1JDIDpz/VTrXCyuX2HPJV
 ba2eYXDAIb02OalsiWMRyyc5TRPDK3DleI41h3r8Y5ATgMq2+sd/bnXFXPjWG++LA4gX
 N6V3hzJqKTgzS+NuFFBK6UJjRFXBfw4MdxXsBtqlRjLuqjLvryOYNAAZnmMIeB4VTiZy
 Xnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739863278; x=1740468078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Ldd3LwpJgzZPWtXkX8L7vzaUgv0zq/Xdy/N/AQucBo=;
 b=kXq30N/ytY2gZl5HKqDWknZt4bnywKK76rvEJKb42qTgascw1qk6kp//PP0TUYw4jA
 2zSThpRwyutCtG8qhyQ7KUxp7Ho9Uo1rpLEplI8T3fLKupVYeoNVD8ihEnGQpTk2BqR8
 xo2t/LXVuGTe7IE74UQdN3zbhiDd9y3TY+iS8rcqhHT2HAuEyumhnJKoaRbkWqiD+9eK
 k6jEP7BgyTwTBqPZFfo2hy2bBbLaQI/MK7dz6wx8E2NcUTKldaIicsBqnQr2KUEE4JUN
 2vSTaXXE80SIDovaCo983M7Umr4opvzWxNxwA/KY/vwiRSOX8nkBwFsUAMn1ekSodr4G
 RFSw==
X-Gm-Message-State: AOJu0Yx3fr8Gr0Jpc5yUGZvWH4FFRzY4HW7MkbqvH0mzFdKNAS3dpdc5
 MP95LmAxkqTj3REIFIR2FiCD4YqoYc4VD9TLK1oLamW44zSfygxQVWfSMozAF5T9wATxI1B2DrZ
 +NouVSoS4DGGE0CMuUF9Y9cgjdVkUiP8oSON4Mw==
X-Gm-Gg: ASbGnctDpz4BQvD92H9HU0QDto6sHGIJ8CHhg6mBaPBW5PUwws5djwbzML0muWgVZkg
 s8vyAcopAk0h92lu1aP9rmuCxqPTUlPt4r8aEzUbHbJ13XbRhRn9CKI8TBvc171rFdAl0DTz31g
 ==
X-Google-Smtp-Source: AGHT+IHNM/vWyLldeLhHABJGvYAhwE41mfzwR9fWhTPXHUNTJWCxu+MoMvtHunVfbu7HH0DCa6dDOYO0BJH+31FoTzY=
X-Received: by 2002:a67:e70a:0:b0:4bb:d062:447 with SMTP id
 ada2fe7eead31-4bd3fc61509mr7224960137.5.1739863277111; Mon, 17 Feb 2025
 23:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-4-sughosh.ganu@linaro.org>
 <43b20b75-5a12-45be-8845-09c4174c5d44@cherry.de>
In-Reply-To: <43b20b75-5a12-45be-8845-09c4174c5d44@cherry.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 18 Feb 2025 12:51:06 +0530
X-Gm-Features: AWEUYZl4p5ROFtkTUH65vLcHTiMSN4Y7nM1CyK3YICz4s6qlhX-UlHbSBehOVMk
Message-ID: <CADg8p96C=tEatxAVRy1Q6p4fBVzYpf=ae84H-xkMTH_7wetNJQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] lmb: check for a region's coalescing with all
 existing regions
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 17 Feb 2025 at 20:59, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Sughosh,
>
> On 2/13/25 2:11 PM, Sughosh Ganu wrote:
> > The lmb_add_region_flags() first checks if the new region to be added
> > can be coalesced with existing regions. The check stops if the two
> > regions are adjecent but their flags do not match. However, it is
> > possible that the newly added region might be adjacent with the next
> > existing region and with matching flags. Check for this possibility by
> > not breaking out of the loop.
> >
>
> What do you mean exactly?
>
> I know nothing about LMB, but I assume a region can only ever exist once
> and with one set of flags? This means a region can only ever have two
> adjacent regions, before itself and after itself.

There could be two regions r1 and r2 (r2 > r1) with a hole in between
[1]. And this is a case of adding a new region r3 where r3 is adjacent
to both r1 and r2, and where the flags of r3 and r2 are matching, but
r1 and r3 are not. The current logic will not allow merging of r2 and
r3 into a single region.

>
> It doesn't make sense to continue iterating if the adjacent region that
> has a different flag is after the region to be created since we won't
> find a new one, so we could break if base1 < base2 for ret > 0 below?

You are right in that the change is only needed for the scenario where
the added region is after an existing region. So we can indeed break
for the case of ret > 0. I will update this in the next version.

-sughosh

>
> What do you think?

[1] - https://paste.ack.tf/351fc7

>
> Cheers,
> Quentin
