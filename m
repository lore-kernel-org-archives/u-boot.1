Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAAAE83F1F
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2268183AAD;
	Wed,  4 Feb 2026 15:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e/EfI9We";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB28683AA4; Wed,  4 Feb 2026 15:01:54 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66ADC8063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-40a62601731so339406fac.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213711; x=1770818511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX1+wzogYMNSdqnitJcF07maZb/hkdRE8jAOwGQ3xi0=;
 b=e/EfI9We95aepZIB9pgg7HrfqVyuJ60uCSNys7Fb7nrg+pCNJ9P2mE+B/8FMy6Y9Zv
 Swbr4RbwzYuws4WSZm2k6iiQLRa0uwsenYbULZCwuERNax8oWPe3omueMQuLUzcKP8fG
 ZIVQjHKMncqOxfzbqkl3tTfnTiC8VsLBjXxz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213711; x=1770818511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uX1+wzogYMNSdqnitJcF07maZb/hkdRE8jAOwGQ3xi0=;
 b=fca1NYBj6ntJbPwNULDeS9VjAxZVItCoyI3my/n1v1LtStqvsx4Jau2smAjai8lAEF
 igljE99qvi+JPL7PAORtCxutmK5d5R5CXbF7ho8+77S2McGzxBcDvwGplMTiId8q74xE
 qv49tbvFLvYTMdJrul89iaUxZaaclhpHVs78jAqvCQ4ZB3nTY161bVKv66MRZqX1DapZ
 nD/4gxM0uWeBOj2q/JS6560SHSW9MZMJ1j3Noq9hVBTxLOHkoRST99PilVXsbkWZ+mPx
 D0JOTe4hQjrTU4tdcZBhjzGOjzkerTZj1r5M89eX8Nqv45sKO9NF9JLseDUmyRyqYudT
 vlpg==
X-Gm-Message-State: AOJu0YyMfJqUd49wpnDfrIINyEbPpgRGBHNmoQr9jH+mBXnvKS0YGHTT
 z8XkT062JCJyv1mz9cv9kAt/GLbg/bjNS0Ung6s+C1V3PFxQVbY+Tr/qhaV7naBbxLuRn1pGHCr
 13euD2Xw=
X-Gm-Gg: AZuq6aKAZebLPQCuOPZWswFSwEe5SJaHYROItaQdPZc3aA2FhSYnvI3DF7cMkeMl73E
 1lNyf93PDQoTl2tg6UA3wa53fsOsxYCsJxYvWD9KGLMsYuxBl4NdSUxW7Em4xMjigPinje1kRrQ
 IiecyVgqfdGIyZj5hMoP38MNF+9WJW1NcbIpluJuvrgbXqnF79iMRPoGvpiDVbCLPzpbC2K6Qbm
 9iLudN14fgUSV8yGAM33ZUhvgkq9YcCgiwUr5g5uLcE/htJFww/mKp9cFaMIV4vLSHdyplItSe+
 MMNEQjpKP3UHJ/qeYWEJ4bihUagbze33vDapbDJ8nHepwABWkc9hX8vakuo4a6XcP3CXSf970mI
 7ptJ7w3v3ak6MByYsk1HU7OqDBFuHzhHVCZVhW/udInbqMc9PYwk2/jhOzqxwp+68zLtZg4Mlio
 99ihlMCIIhnCSBTeR/Ql9u/34GVclDJ9KZ2ZjY8FjyjzBgsdcljJXe9ePMtlBBqu2RsF97incZp
 MY+tmKLzrmI0eEs3Ps4838o/KxYmtHr3Fefxw==
X-Received: by 2002:a05:6870:a901:b0:3e7:e420:6229 with SMTP id
 586e51a60fabf-40a53ae1e73mr1607156fac.6.1770213711007; 
 Wed, 04 Feb 2026 06:01:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a590fe5f7sm1369437fac.9.2026.02.04.06.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:01:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
In-Reply-To: <CAOf5uwnzPQsvaJoQo1F+aAWP7MHbrPfsxiAbesCTfQzmH9oUWA@mail.gmail.com>
References: <CAOf5uwnzPQsvaJoQo1F+aAWP7MHbrPfsxiAbesCTfQzmH9oUWA@mail.gmail.com>
Subject: Re: Pull request for u-boot-nand-03022026 (Take 2)
Message-Id: <177021371025.1736867.13753701570498263687.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 08:01:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Feb 2026 23:45:42 +0100, Michael Nazzareno Trimarchi wrote:

> The following changes since commit 71f2564b178f3986dc89cdaa4558f0caa74fd88c:
> 
>   Merge tag 'mmc-for-2026.04-rc2' of
> https://source.denx.de/u-boot/custodians/u-boot-mmc (2026-02-03
> 12:46:30 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


