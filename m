Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE6F45A12
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498428419E;
	Sat, 11 Apr 2026 01:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HvVSQpeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E4383DC9; Sat, 11 Apr 2026 01:01:10 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B7984198
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so364855366b.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862065; cv=none;
 d=google.com; s=arc-20240605;
 b=gpCz1I+9NSymMM/n1Vn8mNslq21bBCRMe3qW/HVvm1wpc0fZVa79sqsKMeNCboNqEA
 2vA7hZi0dj6D33eOzbhkh2UGlVu1Xf4nAXeHkHu0o5qZsl1apgX3P5lLO65fQNQZJ+pS
 uscxFOZBLgmvJ45dJJ3+kWnSCLnddOJPWE0otaE5HgILV2ELvwYaiVtn2+YU83RaCF+e
 W69xP5JSxmLW9QXXMuaGf6DfL5zku+X0sg5eUCt0LZ/jbAbd7+GRhoFBeDYfLV5CBijQ
 +Kj1mgr56yXz0rQj8sguYYCrZ44voUyInvqqQb6p8wA2AsUdhmqoXN8BvUmZLn8GvGiM
 ohIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oqJrOBdsNCRqRUBJSqqrX8D+I6icRigRH0eQv7h61Lc=;
 fh=qjB3nBOJ0/N7iM5BUDghjmyYYspP4cX98xiGXQpl+L8=;
 b=kJssmdRbGmbbKBHvfkFlPt+RdD8eIsq6+g188AJz8easUk6GEAL1QOGKek5aERTmGj
 FeAygjPyY911NtZGoLCdUW2XgD7LgU5F/qwKq2TL7Hg1JWGPv5lgTXQ1cgVY4Lu17YQ+
 eHVz6B87H4W/b06w3dfTYxDpIBQjXG/mB+BT5JH0IU9Spwtn/LXYdch8ViJLxvbCv9Am
 S09XN3KVXYnjbZEXIsOyufc5jp2r8KrDLd6RjXBOPSZ9Hq/WNUYE+om41BJcN1VZRppq
 0ixKFoGSfqBgWCGEWUTP690ERJB1vmUhc3qMEYVdcY1XPPLZKrFddltW16SiKV3+5I5g
 1J6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862065; x=1776466865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oqJrOBdsNCRqRUBJSqqrX8D+I6icRigRH0eQv7h61Lc=;
 b=HvVSQpeTzXCnd/NL5dSFiZynXEkjcU9RDZldRd0xFgk1rCLxGZLCZAuyf51ozZeDoz
 LthVqL7KsXJ2d0oARUONBG5yCFNVCAQuZfbFniWpe5N4BRrqKYM8vcrCO7YHwH4jcsW5
 lb8YIZFZkqvJH6UvuQA9U8o+2koRmMwb/RTfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862065; x=1776466865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqJrOBdsNCRqRUBJSqqrX8D+I6icRigRH0eQv7h61Lc=;
 b=MFeYtSFKDlB9QVMbYRbL8pqEHyosSdsXpX347MamZPQCqB6IZKTIfUy1EAEHuegv20
 BMAA+8+kV/LZp5lGHfZKx0RF0MwnqZtEj62hVjMIHJ3+lNmIYcoVUOYeNhGd8Ejj/zxK
 b8cD+T9VQuPsUr8c3BLtZSuY479OmLcLN4Iog9CvrgAiUFfA+QvhO+3mE1XUGJIrZOfs
 y3IAM7F4YBZwgLQRfBC2sUj5TukMoQ4aSb+jI85xdSsq1d5dC3d1UdBrxbLS6esaSitf
 1bkcXs5dqRINzS2Db7W7f5lZc1156Edw6CTSPv3mzRa7OPwc9dii3QMOK26Fx33o99B4
 8ohg==
X-Gm-Message-State: AOJu0Yy6HLpwZK377BWLA951QwRrhVKKQOoIxnzGmUG2wBCRrfW3zI8I
 qSBbm340VvoqsQHDaJlugYhPjkumdeCWCC3da1jr+kXGy9jrws+6e5W9D+FcerRY8MuKoNisxH3
 X/e1Eqi2bB9TiMQUTpRoSv8ul1SFI2VnMLQFr66W7
X-Gm-Gg: AeBDietDpUQJxjwjFGokPJ0JYlgldyN7hq0qOxxmeS9ulSbcKuSHaCk5vSwdANo/rwU
 hyiGPhST2C5SSzJgherP9Tlxn71vpHoBP2SpBp6YH97/zxj+AR+83Lk3OLlcAY0fLuqFz6DVRiU
 Oxr/JUDhcWmFsxyxlqWdOoEvaTcXo81CYafO0IhhUh0qfT2ok3o8x97CPF/PjyUGxsZ6doOCdoS
 UTf1b3bEYm/u9NmjvriSAgvu87LncxGBhTtBho843h25DT5c455x1K4BPyO/2CAD/prLklJ9W2z
 eHiqeA==
X-Received: by 2002:a17:906:9fd0:b0:b97:6384:2317 with SMTP id
 a640c23a62f3a-b9d72496149mr303806766b.17.1775862064935; Fri, 10 Apr 2026
 16:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-5-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-5-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:00:48 -0600
X-Gm-Features: AQROBzDYrtBDJYDs3hORqEem1OkBnEuqj_PAezn2hbjIcQT8wynhvA4MjUxYRWQ
Message-ID: <CAFLszTgMGz9+WW2ay=2VgSY7EneUohPFnqtRymTeZptoxG5-Zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] cmd: part: support lookup by UUID
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Tom Rini <trini@konsulko.com>
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

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> cmd: part: support lookup by UUID
>
> The 'part' command currently allows looking up a partition only by its
> number or name.
>
> Extend the 'number', 'start', and 'size' subcommands to support looking
> up the partition via its UUID. Unlike names, UUIDs guarantee unique
> partition identification, avoiding ambiguity.
>
> The logic is updated to check if the provided string is a valid UUID
> before falling back to a name-based search. The help strings for these
> subcommands are updated accordingly.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> cmd/part.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
