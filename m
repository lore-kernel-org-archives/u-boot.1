Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AEDC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 19:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2308684B03;
	Tue, 30 Jun 2026 21:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hhwjdvzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9571984A52; Tue, 30 Jun 2026 21:30:28 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7192E84ACD
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 21:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a183eb9689so1267564eaf.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782847825; x=1783452625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ARWQdpacRK4eVt9XlBOhv2xSfIDJha9P+QARzW46CO8=;
 b=hhwjdvzBayypW6vWbHedvX2SlLQvWyRUPMd3qEatgnhUJ786xu19Va72ks2jPm9F+4
 JejVI25Ut1gQX5LuV+Q0ekVrNVslDQyX+oMAO9dCeQ99Vw5RTBnuSU3l/MufRaaW5IaA
 cSjjPpO50/h1OUhiNZrBvI6WfGhb2Y2ytcog4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847825; x=1783452625;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ARWQdpacRK4eVt9XlBOhv2xSfIDJha9P+QARzW46CO8=;
 b=CFWo+U0F8UqJVVQ87akkC2ThKLLeB2an004VB2piUVyBXHT2qokYyHkKJHp+4eTKBR
 q2/4e6jG5AphfA2y/ckiOLN8n2tDdeUgJ9DCRVkloP7X4iezYyiQUyAqKWaKX1C8Sr2v
 6UTSvqoPq7baqo356FJJluzWaH136srDfFq/5ZxBIkT/sg6dICRru0NBDA6o1O87Sugg
 FxsQaD4oANBm8Cmg+rPfCxgLDy5H+5+cawCBiRYXXWGrOsxaIox7soagEXSTExgpq4Zg
 W6zlHwn+nUnj+vYoaLWHbgdUlmYvOTWplhxj+3Ji4GoC9w7k8UcIFwv9TDXHwIu5BmtM
 tXnA==
X-Gm-Message-State: AOJu0YzljbyAdRROGelU9TUz+U3R9RjliwzWbH9VEiYaqzWt4hIqNq++
 kGo6+IRXmpxUtCpwhaVceuFbS+rfDq1ifz0UjiHOLhssMiaMXCLHBIo3YI+hdsv2SXw7Yg2skxI
 fgdIGdJ8=
X-Gm-Gg: AfdE7clTnndO6tD05Fre+lnWPNhvi2FDDuZnR++0BrbsRPgm8itvhP0jl3yBByCbYwH
 cOwQIXLQy6zibjig1CH0ZQZVpEqmnNXSKA9+wNo0nees9uY1ik24Jc68Y+hEWj1FWOwcEo8uoMZ
 aklugnTyfB10m5DNPjkfEC5hpZspovK53Y5oz4J+xINcY6PSA1jEAWe+z3xIHnNTWYlATfLUpHX
 5saS84oTf4T4gAPCwn7UVifnN0NIgBK1qKMQv5yKgNpx4vAZH7ItGseUiIgtI7WPSi4xrasbOT3
 aHQV/RrlGOfd/x2kO9AcRHC+HCmXt7tIKc6QGwKfge3ueDzFV4t6DxMV2SInYkrZfOX25h2VyRi
 m7403yVZV7NIuWi98RIFNL7mLL0RmpQ4kBDctlOC6mIRwj8VQSXkYKVKW6cCThMIDd0B4O2V2gW
 UkzFo0EfgbIqdXFQ6n+axLoi6tEoYLQNGSPwHwgOClw/IBn/EmL0656qmfZU0WTTRczCCiLjC2v
 EP1tbj0SEVft90LJwk1CQ628qUwLOnM4ebuKRQ=
X-Received: by 2002:a05:6820:613:b0:6a1:7644:7727 with SMTP id
 006d021491bc7-6a1892e648fmr3688914eaf.69.1782847825222; 
 Tue, 30 Jun 2026 12:30:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a18941c29asm2490438eaf.10.2026.06.30.12.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:30:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rv@rasmusvillemoes.dk>
In-Reply-To: <20260617131204.3737198-1-rv@rasmusvillemoes.dk>
References: <20260617131204.3737198-1-rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] Makefile.lib: remove stale migrate_xxx logic from
 fdtgrep logic
Message-Id: <178284782458.2318957.1358798848024469451.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 13:30:24 -0600
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

On Wed, 17 Jun 2026 15:12:04 +0200, Rasmus Villemoes wrote:

> Commit 6d04828b452 ("dm: Remove pre-schema tag support") removed the
> definitions of these migrate_xxx variables, but left behind their use
> in the fdtgrep rule, which now makes that somewhat hard to understand.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Makefile.lib: remove stale migrate_xxx logic from fdtgrep logic
      commit: 791c9c97114d704fed24437571aac1233a50b239
-- 
Tom


