Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A50CFD360
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 22:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D22183EE8;
	Mon, 24 Nov 2025 23:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZHCyQXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B8B83EF2; Mon, 24 Nov 2025 23:14:21 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6E083EDE
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6e815310aso2784301a34.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764022458; x=1764627258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spB9fsbhfSHTV+Dg0++Cirk1FfFCa0u4DoI7Pi8rQHM=;
 b=OZHCyQXT/DR0/Q2pb9MenaOP2RZonVQOOlFGFFaItcEbK+fsvbdybgY+2l+kuEsPAi
 IQ14EjjdH+Ij4CtIrACsvEvF/Jcil7k2WusmTcCcvMjgHER4A/iWR87OtC+D+iOCwcw/
 sSOA/OUJpYye2fRAgOgeYww5Y8q+xVjUnbQtmJESutMiYqzFJwO+wqG5QS2DLin0kgDd
 lk9Nb0/hynrvbbJ6faJ0PonMp8CMI8WvC5phvxB9Aj8idRexcUgPqzaeyrBgfYSEX/Ee
 VeUAOiMQMw/R5+iQQbYgMrT1K6lSWAprQfPqTXMfrMqqowM+01iD0IbbxPkFBg/SqGKr
 BB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764022458; x=1764627258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spB9fsbhfSHTV+Dg0++Cirk1FfFCa0u4DoI7Pi8rQHM=;
 b=EEtik7rxaOMw9HUks98IOOEQ5QXlUZZKOzHKlldnL5yvHuv+rnmepDULn6LyXqDSu2
 N5NdDOd5lS1izxV4OLaJ9yQqcbtBnogkBRZgArHRUeGet/7r4rYgKXcCjNZPjQ7GNU84
 57qz5GNV+vYgKzxFf/K+FyB9d5QPVBaGYi0siZLnAo+yver4CwSqMYN5Mir1jZisCI10
 RBEQ7BNju9/WabJDQ7efDqNBP+iV0tlXPfBU1ZDiwVIp+qDPVXyRjwMXMtDAdJDOQcfg
 o5IoDku2za+b2f0y645RGqpEQ+eW9V4fmB94usXi9SgqeQ8zfl3ULlYhzWF+cSnPvnBp
 0k3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2n14rg5qpJxIQOtRSgWpRU/vB8NTzSxTyoD+5bG53mrPYc8vrBlrK1jffw60UqRZprTNK29s=@lists.denx.de
X-Gm-Message-State: AOJu0YyJWNl9uFFjjTh5Q/DSLQ348P4vHQhIizyWao0HYZp/vDyEmvdH
 33yAuO4EYDWgZvjXucE2wZ5OLkUWg+2VaJ1T9R+AOGdExGNUVopyYjZmRl15jYiQPgRZqnOzRRB
 1kaTkI2E7VRnguYThnM8HOXrKuMClSGg=
X-Gm-Gg: ASbGncsvZUcrUCRlAvU8emxJoCST0EY8I/xNOqFOeG+jyfGhh6fj+w0LQRXEGbBDZ3O
 8wdyvELruNYdAbzRNF56oGivSYv03guwUsir0cUAXL+pNMUKQrs1jgV2w9uWqg1Iu7zjzk5ns5H
 7cONsTPEl2rwajSaGmVBx2HjqV0CTJ9qXfR2LU9xYCJGya4SF7O7TmTp4BoIxhYdx1lv1fzUoEI
 PwqiMLOz2ysSATng7tll9Ce6MEafQEZLqk1LeJH8xT1cogMv6Hp8Zueh2ZrtOj7wtB9WyWP
X-Google-Smtp-Source: AGHT+IFoPZJ+iLRRT/fhV+xQXVE20A0n5s+gL8h74IimPVaGvRaWNDy/cw5HZfhiRv9zxZgquy0rYB/td4XfFjZTt7A=
X-Received: by 2002:a05:6830:3147:b0:7c7:6da2:6d67 with SMTP id
 46e09a7af769-7c798c4ac07mr7722974a34.3.1764022457776; Mon, 24 Nov 2025
 14:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
In-Reply-To: <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 06:14:06 +0800
X-Gm-Features: AWmQ_bki6gwIfHFjC3_ReXhoAjLIk7tSexYprwRToqds7k5ocBVpkIky_D4bSFY
Message-ID: <CAN7C2SCgjW9uELcGsLQBboNTEfhhfX6QdBwTQZesQP2YtQ75kA@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> That's a bandage fix. It would be better to have some idea of what's
> going on. If this is possible, bisecting between a known working and
> broken commits would hopefully return the culprit and we can start
> making educated guesses from there. I also see no defconfig in upstream
> with TARGET_SOCFPGA_GEN5

I am terribly sorry this is completely out of my capability.
I really dont know how to do it.

Why I raised this patch is b.c. The diff does show a very distinct difference on
Altera trunk and mainstream.

And I did try what you had proposed (delay) and zero different b.c.
that calibration
is under a long test somehow. I even tried adding a redo counter. And also had
tried to check what was done before and after the calibration and no major
diff was found. So to simply generalize the issue I patched this patch.

If you had a clue that is not the case then I am 100% wrong not to be shamed.
I did not undergo code investigation first, I did it by reverse
behavioral observation.

Bests,
Brian
