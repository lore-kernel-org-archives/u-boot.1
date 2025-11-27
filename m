Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F2DD111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4171283B49;
	Thu, 27 Nov 2025 17:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qlEs4Cf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719DA8447D; Thu, 27 Nov 2025 17:55:54 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BB083B49
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so639337fac.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262551; x=1764867351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aic3X8sguc9lVAPxJ6N5R28a/cw7C9dILmN5emRmv04=;
 b=qlEs4Cf6YkV5PY9Tm1iv1SkigMiNXepz9Azdy4lUYw/a2mcijn1NNJHUbJSqRyNARU
 7EJkTPHYtd1Hz3N5Mczv53miyGnU1mt8JPXcn6JgjZ86/Ais8gtTn3XCu6DjEL9iFwxu
 P67FcYcjC34TLyGwXQeaFZNiL7vDy49MUMPoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262551; x=1764867351;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aic3X8sguc9lVAPxJ6N5R28a/cw7C9dILmN5emRmv04=;
 b=Nx0DDT4vWcZNF4VZQJ8jHw5DPEVvZRPGtEXSYvXP/dM0w5bAn/my2eBV7wVCweKZ3K
 4NSlZAQPmD1l1j4UU5WOOfaM+bAlIdGjwwOnOmaJketumeqtbiy/JZnDM0bppsLjNOTh
 McF0C6Kc7349bPs4d5pFswPrpz4CJeEz6SqzCdJ4pTQoKyf351hpbbqai39fDOiR6flO
 FvrmBmViwr4O1TyKAbOhCt2XC5MtB8cdUfauYTIa1NzPzFb3MmR0xht/46J5U5b6saly
 aqhjTcMXczZlPLpu+58RHPfWPCPA2pQzj3fuqUHJC2oiKrxOhFUHjP6PprqVrWe5HH9I
 jwfA==
X-Gm-Message-State: AOJu0YzHzr8bqKxelthNiKXh90meG1x0ITNRkiZcXK2RKGA1v/eyyLpt
 xiqtXe7IN5FXrPQJpENL7WRqOooOCT9F5HMU44PuXJ67yxCcCgHY0bhZpkkYAyHyk4IDbuniRut
 /tt3AAmU=
X-Gm-Gg: ASbGncvfA5p7m8+ciIhqlQIYEh4+N7PUAdvqvcITdTY8w/BR9xCkMPCoA34MlmpkSHE
 +9shyWkzc3QPXNxw4UgsmEyJzFfkDDDjGp8PSElACtewnafk0Oep2tyP2I9DYH+FCL3djlrbmsh
 XqFX8eDSbpCr6CATs/LUwAmaXjIleDvme3s/aUURYM1gbrvSz7bHZmWYTOhM8kN2Eb8XLYPBpxI
 F8pHOq8jUHGAozO0KyCkWNbNlYUekoy0bVP8KXWPDFYKs10C9fuxR97acGYMTilFy3dKpjHx18j
 pi3jlkjSCiX/Pqn27LM77hRZUdbHadUbtoX4wGJN+DtLjIOoMs8X3AUHiyxPnwUgL+gZUvCasFW
 Wq418WeG+srVsqLWJabW2yxU22HdO8hTsooKzLgDiF0+dcemH5u0ZlWiAhsVgLvFqUlxtSutPe0
 kvhJpEiEBjKrX1ubODXhaVzBMH2tBTi8tUeMgUAQSN15sf8CDM
X-Google-Smtp-Source: AGHT+IGZdDfvCwGiQkXpLthoo28JRHIrBnYkKm/8dgz06jUV10gWChRukPb4+Z6fMe+mzddVIJ300w==
X-Received: by 2002:a05:6870:831b:b0:3ec:3ff0:a714 with SMTP id
 586e51a60fabf-3ed1fbde3ecmr4712088fac.8.1764262551149; 
 Thu, 27 Nov 2025 08:55:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leonard Anderweit <l.anderweit@phytec.de>
Cc: m.schwan@phytec.de, sjg@chromium.org, upstream@lists.phytec.de
In-Reply-To: <20251118143021.1757423-1-l.anderweit@phytec.de>
References: <20251118143021.1757423-1-l.anderweit@phytec.de>
Subject: Re: [PATCH 1/2] bootstd: rauc: Don't check root part filesystem
Message-Id: <176426255045.4117678.14133779475552589040.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:50 -0600
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

On Tue, 18 Nov 2025 15:30:20 +0100, Leonard Anderweit wrote:

> Only check if the root partition exists when scanning for the slots
> partitions and not if the filesystem can be accessed. It is not needed
> to access the filesystem of the root partition as it might not be
> supported by u-boot or be encrypted.
> 
> 

Applied to u-boot/master, thanks!

[1/2] bootstd: rauc: Don't check root part filesystem
      commit: 5d7c080ae5dc1f8d5ca4fb1dd93a15ea96ca8c72
[2/2] bootstd: rauc: Only require partitions for one slot
      commit: 962711498ddac6179f1d1f3fa123397ba02a381b
-- 
Tom


