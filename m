Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C67AC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E152082B70;
	Thu, 12 Jun 2025 16:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mJNch4e9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6367182C4D; Thu, 12 Jun 2025 16:43:39 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD1B828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-735a6faec9eso686914a34.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749739416; x=1750344216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWpsOg8NHXyjHIfYnI271t98HNwLim/1fE/vBr+bUhk=;
 b=mJNch4e975HQ477pphPPBaAcOo4Oc8c1ackNbIu4HQbDxj4h3yumQtAR+pF2h+BqXy
 Bs0LjQPgQpRz5jhYDbyDPH9P2/2FpW1FWci3tzuRz2wjJ4V93w4sTri61p3su8CbLA0V
 9MELQz1znoW1F73FECEAuefiaVK3olssQvlqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749739416; x=1750344216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWpsOg8NHXyjHIfYnI271t98HNwLim/1fE/vBr+bUhk=;
 b=Jjt0oHY1SmFUTRjZuSVE4XNGvzQN/a9dtYLYyZ3H0CuV3bSzjlNY4NDpmOL8kaDKxu
 IO0/w89yZw58m/gk/rdGl7MbD7KOlKZ+B14hqmVuOMTH5mKhxIdPK1+hRsi5xBIQ89xd
 sxbYddzdIhajFAmtBmMZa1QwBfFm4FBEYOFIZEXXh21Lgv2qCrXNJfrITHoRvdBvC+9N
 hpTNzLj5Kko9rW3Kpj6jDFpDItIMV5UuOO8qO4YNBpiiSZ8Obak9TUVMZkhQb+XMRqGf
 dRanFXNWTuXCfAHFnirMxboCpgGKKdn7SXCiZ3Dp9Q82RMmIR+BJhh15TtiLQvN6R4uk
 8xqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKq48xPbLVRwxO831rerdiKoohi9WhX7USPcNl/CSHXVQjwk2lurlVRV/noSQ6Ga0ofGw3fxE=@lists.denx.de
X-Gm-Message-State: AOJu0YwbTGHbPuTXNE55br3rL3BUnz44ZykXM7u9/7yYsnuTWYxwVn8M
 XAGSnziWtFSZP3KpNrJZT1Nx3KChWd3rvYPSyinKbOZrH2VCe4SVcvqIaOdBhJh7nQDPhXCr5J3
 E8oDHGoY=
X-Gm-Gg: ASbGncvLRSsCJ/e7PfrIkcFaQB8smazjHq1YRPDwrz084S+w3MLZ3nZGU5yHTb3+kai
 5OMn7SOjKsJJ25lTBGavAPG9lIbAjRhx+zyTapwh7eJUlR7OsdblXzDSxjdpl+wEI/BVO7sNt/a
 0yYSs9GwT4pLftokl4Y1H5z7uhLfitlMTKruDW/+WyCj1QyHFhN116mHz0KV9ybz39p/tLwWsyN
 cI15R1tPOaFguLDUrjW/wZvtPKTCDFzzJwHykjHaeO5rRjrGr800lE2rnAsNoCoQy3vyLJOPQs0
 vxTju4S5A+ebAH10PTnmRrvvLhcB2J+5r7Ut6HrzeaVnvu/k9dGX/cEEVQ0YJ4/jK6fR2c0j+LK
 26kQGRQQSJyD2gAnLK8zU3g==
X-Google-Smtp-Source: AGHT+IEJedwiQZaJP3+dSiW67HChYZ+d/lS27EC/PwSJrGvHYNgKXV57e2SbmrfczrAF8Jz4xKBcwQ==
X-Received: by 2002:a05:6830:4d87:b0:727:3e60:b44b with SMTP id
 46e09a7af769-73a13adfdf1mr2406362a34.14.1749739415993; 
 Thu, 12 Jun 2025 07:43:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a16d54e40sm288209a34.63.2025.06.12.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:43:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20250612133519.764041-1-hugo@hugovil.com>
References: <20250612133519.764041-1-hugo@hugovil.com>
Subject: Re: [PATCH] board: var-som-mx8mn: Fix alloc space exhausted in SPL
Message-Id: <174973941514.205859.4992550309671528554.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 08:43:35 -0600
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

On Thu, 12 Jun 2025 09:35:18 -0400, Hugo Villeneuve wrote:

> After enabling some options to support EEPROM read in SPL
> (CONFIG_SPL_I2C_EEPROM), the following error appears:
> 
>     alloc space exhausted
> 
> Increasing SYS_MALLOC_F_LEN from 8kB to 64kB fixes the problem.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: var-som-mx8mn: Fix alloc space exhausted in SPL
      commit: 461f357fa9fa29886c787583d42e7a8d2cd14feb
-- 
Tom


