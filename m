Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9933FCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 18:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58AC83AA0;
	Fri, 31 Oct 2025 19:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G88xzU/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4CF83AA1; Fri, 31 Oct 2025 19:03:59 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC0983A9F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 19:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so2012592a34.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761933836; x=1762538636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Y4ekKPkPKaPkTSFyRnI/N5HfGp1xJWQz7yVL5m/jE0=;
 b=G88xzU/s7S6jPtJBFahS/A0bd/AgwryBU86zVg6eqaMAVO/mYHGnTHPHqNsoIcR58c
 p5Tr2qPB+/mESbYpob1ekWhgCBV6mRodi4u7/ECS3iRr+v75zTg/pZqMNEeUJYuA6wH8
 qNpZqptzKcszVxCz7GDjwLnKYWkb2a4kEuoCI781yk9q8g/7USvS9ixNGFlQr1UsPClX
 tLDRKMFm0KryvkeAakXwMxS2KE4yp+Yxzo2aPPyNjn8HC34Bh8a0Mq6r5XDcHezZVrHN
 mNUxFvT3XLWqv/HPI70vELiFognC12LqZJTzV/PbOBEsqEvXNlnY+JQKqhgF+LXuvJXS
 Iwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761933836; x=1762538636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Y4ekKPkPKaPkTSFyRnI/N5HfGp1xJWQz7yVL5m/jE0=;
 b=q2XdlvktsUPOuxWBFqaB8j0vojSUYJ6XLJE5m1R9qP/3fruwD10pn0z15l6YXrjqvH
 i1BEvGYiE8shoLOTEGEUbBO/fAh6X9QtS7elSuEPemAHUfCEN8nsuBnS9gObGbna8RjK
 BXrGy7ARGMlAuTZrAGcOYOZaA+D7b9XIBZGMRuvmtLWpL8drpOarsUM3rPjF7RJWeBi8
 OPVeQrgkeuSIRz/h082sOxhA3HziaZ2vnbY27oFb6RtIz7Joinq9IGd+LzS6Hsl63F55
 7uwHU65kA7GCu9N+qQZSWbr1x+uJNMWhBz0ERvmevksvgx3znunr6ThlkuBbJ4b3PDv1
 yEKw==
X-Gm-Message-State: AOJu0Yx+NTpk8TPW88tMHMGYq/oix24EYN1hZXAIvHKtxrmNC06usjy4
 8PowxwaNRJR8cP/w3aRuZBG1KWZFixc3VeI0FdprkBDdVar4Xy0/ISYBTF/oC4/wfKDQ/8fBhSN
 tYFxQDmTkKyaKbYihZFo69tulChFcJdR4Jw==
X-Gm-Gg: ASbGnctNUySQygn+axvwmUgtKWagIXTODdKyVownQUVTErG4ypqrWjaifUFzaW4gFJw
 scPG/Kz4FeyTDZ8UHouWTXABQwwzoNQkn2G9K/9alLLgdspWbaDNfuo3P0w7X5G2qQAtuIbtUkL
 tVH6jrtByIRIHLjSBF5dduK5kwtQcJ1NS4oDQc7M386rbwhU/Hp5XeE8ehICjp/JL7wq9P5c9q4
 PwudhyLriV+OO3rFqZK5Yo2z00K5xZScKp1V01Bw6qAIvl8bT1HdILrNugALA0DYOgpjwmz
X-Google-Smtp-Source: AGHT+IE+UO55Q1o2siCk5GfwLZw741umgkWbbjMYafD/fJ+pI+/lAEkfnL0ywOlU2lI4kNq1RfRjThLQ3yk3iECW+NM=
X-Received: by 2002:a05:6830:6a93:b0:7c5:3b0a:5eea with SMTP id
 46e09a7af769-7c696705798mr2841969a34.10.1761933836480; Fri, 31 Oct 2025
 11:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
 <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
 <20251031155427.GC6688@bill-the-cat>
 <CAN7C2SCXWoi6XRKppKFUzPiUykYeQ0Mbm=S3dhALajP98S8rAA@mail.gmail.com>
 <20251031174613.GD6688@bill-the-cat>
In-Reply-To: <20251031174613.GD6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 02:03:45 +0800
X-Gm-Features: AWmQ_bkYItmVeEGw6CXiHP8tGeq80wBugLmlSek5BF3UUlTnZ3P3ntYx6piFQBM
Message-ID: <CAN7C2SBKVmT=BXQQoN=R81q5xPGV3jGOs01_mRszaOzuu6xo0Q@mail.gmail.com>
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> there's some way to add Makefile rules to automate xml -> c that would
> probably help other users. But that's just a nice to have thing. Thanks!

For the Makefike I need some time to understand the flow and how to add it.
Just push the backbone to the trunk first. At least the user can run it more
easily.

Brian
