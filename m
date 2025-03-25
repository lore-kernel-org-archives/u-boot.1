Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C37C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 09:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 974AE8192A;
	Tue, 25 Mar 2025 10:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OkziUaOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6E6819B1; Tue, 25 Mar 2025 10:17:25 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C1080EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso53222485e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742894241; x=1743499041;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UXG7S6veWhmUx/Cy4rmLRWVgeXw8m5IWGLjdW4T/uKc=;
 b=OkziUaOOrqOpTi6LvYs7d9H6ZTHErs4GjnoT5PTIPJxHSiU+NOpgPZgY4TI393EYoD
 vxu8m4+zFrVvP1Ra9MHBaO+ytYv79wqDiug8FMDOV9IWqwArMEsPcfqLh9Lk9rXczmTz
 EY0oT3gpVsp8rtj1XrjmAkb3jS/DZ65tDdm4SMbrsfAy3JRy2uEuDNWKN9qNizoOH1Uf
 Wd6bxTNdKLGJKA8xb9Ss9WTsPLTSEgs/uKJ5j8EoAA4AXqlD7PJeWipr4jYqUzWX83MX
 dnEAr7NT2rqYk5BAFp8ISEvM/gPJf3XhoqTvCvo7gfi9NXh4pUgiz7Mwfa6aSrZNeD4v
 ZxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742894241; x=1743499041;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UXG7S6veWhmUx/Cy4rmLRWVgeXw8m5IWGLjdW4T/uKc=;
 b=FjjGWsC8J+Y1HUotUBMYwmFajUx1ouDw1N1fbHHg5FH+5cIYVp3rtkT6OMRaG+24Na
 MIH+tB8IbL4EH/kD1xg6jyMDn9w6Unf+i7S+RPJMhm16dM/hEPv5oLWI+jhDkemw4oYF
 LN5IxZZ04IJzFLZ2SCv7cs3XN+MsPn+MOX2dppllKRpXmTW3Jx37xer4XC+ORPy1G9Af
 Hlurtu4w7Wynz+/T8mm0Del6HaaT48rKQXcGYyOuEfGxV5BTBYN53yqPsufBOkVaoLum
 ophHyVTUKb2sb0vN5ksxp1qxn5pMYg8I/UtWhsKd456bS/T0naIziqs/F/+4HTlS+u2h
 hyLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtU10XjhX9giTfp5hFOEMU1+HJ6ZA00K/iBlAR2ZmtPWVnTVUeul5bFGy9VLIFRRahhDi4ANI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj/eUg/qLjXLMWwP3eGQTEKD95UHMhR5o3cFNpILhksdy31Lu4
 Kxza3emXZDRIek5ZoDwnHRW0QX3UuS11K7f25D8iPBlcotsqI76O0S5jIX4yIDQ=
X-Gm-Gg: ASbGncvV9aSJSkJxHL/GlCNYC/tQnQ5htb30re/TXH4Fd2u4VxYRZb+7qmUBCgzS5t0
 pS/HbdlgmQ8uSo+u6adspIq6KdvZaWptGecFpEOxLA6VVdWg2mov/DTCbDnqWuQ9c9kHGC3Cozt
 kBF/5+5CeXw8UIU8pqt4025XAlYNaKgDHrVelQvt+kkrTo+klejqdpViJxARm9ZE96O5dIuzc0F
 7CKRri2QuXNYWZjjQozX04LK2dRjH0W4L72fT9ajcjI7N5bjb47tCnFcVjAcLWHBEmCPGs+7fMY
 R8j8ehThMpCAHTKMAXJ3Abkasi4qiCJKnh/50sN9C6RYGIcrWEt9ot/y/TpDlh8EYQ==
X-Google-Smtp-Source: AGHT+IFVlXk7USpH0c5/Kp5LJEwpQHHxZgvSZWnrw2BBwF7nBfGELk0hO+XWH0u5+tWy+2hLqlt2Bw==
X-Received: by 2002:a05:600c:470f:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-43d509e0f82mr135011815e9.1.1742894241435; 
 Tue, 25 Mar 2025 02:17:21 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceafb7sm148759235e9.1.2025.03.25.02.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 02:17:20 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc5 released
In-Reply-To: <20250325020130.GF93000@bill-the-cat>
References: <20250325020130.GF93000@bill-the-cat>
Date: Tue, 25 Mar 2025 10:17:19 +0100
Message-ID: <87msd9o4f4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On lun., mars 24, 2025 at 20:01, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> So it's release day and I have tagged and pushed things out. This will
> be merged to -next shortly.
>
> One thing to note is that just today a bug was reported due to a missing
> 'fallthrough;' line and in turn we need to fix that in a number of
> places and ensure it doesn't return. This will happen between now and
> the release as I think it's clear enough.
>
> While we have been having regular meetings after an -rc release, I have
> assorted personal appointments this week and need to reschedule for next
> week instead.

The calendar invite on https://www.u-boot.org/ still has an event for
today (25 march).

To avoid any confusion, could you update to Tuesday 1st of April?

>
> Repeating what I said on the -rc3 release,
> I've been looking in to seeing how we could get modern project
> governance setup and some umbrella organization to handle financial
> matters, etc. To that end, I've been talking with the Software Freedom
> Conservancy (https://sfconservancy.org/). I continue to need to post a
> bit longer of an email explaining my thoughts and looking for volunteers
> to help with organization.
>
> In terms of a changelog, 
> git log --merges v2025.04-rc4..v2025.04-rc5
> As always, more details in pull requests (or the tags referenced by
> them) will result in more details here.
>
> I plan to have the final release will be 07 April 2025.
>
> Thanks all!
>
> -- 
> Tom
