Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7E9CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 16:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2538381D;
	Fri,  3 Oct 2025 18:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ddp3I/b0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB1883826; Fri,  3 Oct 2025 18:16:17 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68EA8380F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 18:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-42571b8abbaso22199385ab.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759508172; x=1760112972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0rXyJA1ThHGIuuiyCu7PxJujuXHKHGucBZ0w24Trc4=;
 b=ddp3I/b0idadXa5BsvPsk85yfqbSU1RlVtIWPWpD8fM9XN0yOk59X139TPk3NynLV8
 X/Uowk8UFRUN9t8k37aIeD5POs5HroaCvyJTvuoDPju2jrV/Jdzzxgs/WJrNu/PtlljW
 pMaSpjf32vJn3VfXAiidRxZdG5AZA1CMOGCFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759508172; x=1760112972;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0rXyJA1ThHGIuuiyCu7PxJujuXHKHGucBZ0w24Trc4=;
 b=se83Xrw6Qh8qlb0f58SfKSi8naXtwHOk6+VKNt4VwmeyR3deTSbu/p4YZpdftGdTSw
 MEUFAbuPwx8eRLOcpoibxkCpfEKVqtLaAXXAVFuf+bmWI+VNjSLLsagB87SSB0Ck6UbQ
 5y9AeOtFs6ca8Fm/iW2cNrVl4aDDiMpeJNlOkTn+7YBBIaW1GruD8KsjK8OB2Uwfly77
 L9d2qYyz3Rd/1RzzVhHphO8fJ0iKYEAxU0Gy5dCOE7kXgu0eawS0UR8k51fvbuIwo/TK
 2bRCbnYn+KkVrENn5z9IAdfb4hm6bU8Kz/z0P09Vkyg+mG4egyuzitPNixBL6ktbxmsT
 JYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/LJn0nTTkOyBF58fG4nwsyxXebUOPnwImTgPQmimpNXPk9X/cMS6s1GATvdVI/15cIZfOIsw=@lists.denx.de
X-Gm-Message-State: AOJu0YyhkMkMg287Dbb3vBoLoCznNS4AVDYqbzGwCW0h9AhPQ945H05A
 I3l44OUuqouUjATR/rjWCwF0htA2MG6zo6/YPqVpSHK791mEXaVuOTRvII9EUey/vE0=
X-Gm-Gg: ASbGncvuowh80fVJoRJYnhYiZbo4qfAY6fU6SdSCmRitJa93J8hc/5iQ0w00ph/Ud2O
 Boq/WWSJlDwHGazWO+gvOzgXRE1XOoBwbvJ27SiF5wt8brlDkvGy0TItZ30vTZwEhHj0ynX3iuD
 83cIjEk2qJ20zvHjD/WI6kbIxOtUuZsQETQH+cdL0bdBjng5w4Z2VIs9C6GRlgHY2WVGOj6dpis
 7Qr2qw2CvgPLJW87iKxUwwr5+H11t4F6Shd10u07+7l+fTj0VdAhGq0oHgMAri7rMCjTOeTUBfm
 2s5gynF1rVXoKKayNt/rGi40X9X3J2w29wVT8kiQAXdrxMlMyiAKqzTrmFcSrzZlNXqcopsGKyD
 MpfU1RIBjtVZSOT7TN3sgOlVDNBi8qZzv1sDscst+3ItZnsXpUN9cLS5X3BiZdks3o1irDOwxpK
 jj1GKSd/QAaKeEFGy1r3Q=
X-Google-Smtp-Source: AGHT+IEUtxXi/0L5MUBITQuFooWSvhibPIMtdWsHYkH/UE9SCTvPYd0JcRZ0GIvBi5xcoGR5+ROfHA==
X-Received: by 2002:a05:6e02:2308:b0:42e:7b4:691f with SMTP id
 e9e14a558f8ab-42e7adab9c5mr51519845ab.28.1759508172438; 
 Fri, 03 Oct 2025 09:16:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc83basm2037701173.49.2025.10.03.09.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 09:16:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250929221926.29046-1-semen.protsenko@linaro.org>
References: <20250929221926.29046-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] Revert "fdt: Make sure there is no stale initrd left"
Message-Id: <175950817159.616824.16427461712635114523.b4-ty@konsulko.com>
Date: Fri, 03 Oct 2025 10:16:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 29 Sep 2025 17:19:26 -0500, Sam Protsenko wrote:

> This reverts commit 9fe2e4b46458f9c4ec6b8115ebf18b4b26fe6127.
> 
> Commit 9fe2e4b46458 ("fdt: Make sure there is no stale initrd left")
> introduces a regression in case when U-Boot transfers control to an EFI
> app which acts as a subsequent bootloading program. Such an app might
> try to set "linux,initrd-start" and "linux,initrd-end" fdt properties,
> but by that time those properties are already removed by the code added
> in the mentioned commit.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "fdt: Make sure there is no stale initrd left"
      commit: 072264c4b3406aee50dad08355588577a547ab48
-- 
Tom


