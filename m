Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62561C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 19:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3A784AFD;
	Tue, 30 Jun 2026 21:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bmNy5DJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA7D84B03; Tue, 30 Jun 2026 21:30:30 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0181684AFD
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 21:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a17e36fa79so871470eaf.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782847826; x=1783452626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5aMPadLStoZaNeRSxoFWDINM+orwFPKVi7026AxZn0=;
 b=bmNy5DJg1oUK1aR35xKuyToYEyV6expF3EgD8hXuSxMKs+rjOpxPQuOA7N4io/jhlC
 e/vE9QPCL8RGdL+l85BmnlevrNWMyyXMfqbeophCDzKmFAT6nYmGs+D7DO25QNfPh8zZ
 /0R3bgdpr989cAQnM9Mkuy7ABQuEqtnWywZWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847826; x=1783452626;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T5aMPadLStoZaNeRSxoFWDINM+orwFPKVi7026AxZn0=;
 b=S6xKkugZIfUI5qg9Ew46KXBuDPAg6ADMZ2YaKlWN3Y57scRa/+5B5O68DBATQsBq5a
 krqHV/q34DsmX0BsZJ93CyGtEoLVrQIRAy2fyFpcC8DjejC0eSsj/K9qTI4T52h9ZdSj
 Lk3wGw8/sBlDjcIxUFU8j3AnfnrV5CiORk1zKqBi4cI0TaNwvDSg47EozIWU8UmdA6JA
 HPrT5KwivjLq8n3n7IZFtUdBPJ/ZA3mJV6sfZ5hpTjutv+5DjzY2i6TL9d8j/bDhxZZZ
 cTIUgVQmSTL2EnknyKSd8rXY3MoEQcc6cx99pthnNerDOHOo1I1lkfhjrs7+mNKZDfY0
 Vmcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/K2sK2M11lwktyX0AteywSu9BDZsdRJipbNzB7RNKQjXkZT3+BrnobIwzwRn3crHF1JnlT2g=@lists.denx.de
X-Gm-Message-State: AOJu0YycAIXdtnsG4VEN7ddkWwZUnn3J3AThxgN/ZUBEINYc8cELhYRJ
 3dRv1Ln/xHZKqmods+L3WOiBja/zc6Z3y/KY448+R8XCbmXsGTS+p69Mh6dOGqb4dbBWkmUEC0V
 lhlpuq1Q=
X-Gm-Gg: AfdE7cnjo0vXzj8vBK4/RZkO5IEEK/X3MQ6REmgEesusfLVcoobOSBxLdgGGsqyFAhm
 5vIVWhJllnwec6TOE8SeQFJqYo8q+5crjsQqWrYrr1FzkC55csCKc4lFVJlxZ3ZssHrNGDKcC8w
 r5gpulJUPZY5MYU/i/vaqCYnzCtCXcxAa5NnqT7gRW1mjQfVfyHb1HQbDvJDlzD8TuDi5JhKI4E
 Nla+r5fXyLYqlkZI/HwASs8nIQtitJ7L5bRGyr9LyCUH4JZbGA2lxgWPbHbdDq7sr8QT1SCNIuo
 K+9PZ+iMZfldMeIrp/ageUkaiNBv3KXFTjK9Ixn45uywsZiCj7e6FofOyyw9jAkX21wlP2sXHPw
 w+oUzCGCYeIVkQWLnJYthjzHCWFo3zyUL+RCRmYGo8iCqh+eY1AINqxkPQM099keSCLA6AhTmuz
 PlWwFHaNzMuTrwWync3PbLC+QCovlwHGTvRAUXrvJkvC747UtsXZIdmWql/VFas5hoPTnX30YFO
 zhNSZpU9MPD6kueti+V1WrtoCuVFA06pPl7I8k=
X-Received: by 2002:a05:6820:6ae6:b0:6a1:788e:86a3 with SMTP id
 006d021491bc7-6a1890f4d32mr3096554eaf.31.1782847826556; 
 Tue, 30 Jun 2026 12:30:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a18941c29asm2490438eaf.10.2026.06.30.12.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:30:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
In-Reply-To: <20260627202410.1148976-1-jonas@kwiboo.se>
References: <20260627202410.1148976-1-jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: sdram: Fix initialization of DRAM banks
Message-Id: <178284782535.2318957.3948388364406972360.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 13:30:25 -0600
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

On Sat, 27 Jun 2026 20:24:09 +0000, Jonas Karlman wrote:

> The commit 55a342176984 ("common: Add an option to relocate on ram top")
> changed so that dram_init_banksize() is called before gd->ram_top has
> been initialized. This change broke Rockchip DRAM banks configuration
> due to gd->ram_top now being 0 when dram_init_banksize() is called.
> 
> This makes first DRAM bank size calculation overflow and end up with
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rockchip: sdram: Fix initialization of DRAM banks
      commit: 6ce741232f6d206ef689b1c17117f408207421b5
-- 
Tom


