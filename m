Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F3CF4BB83
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 20:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EDE83D8A;
	Tue, 24 Feb 2026 21:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZlD8Qo7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86ED083E36; Tue, 24 Feb 2026 21:02:22 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688D483981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 21:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4648447c899so741936b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771963339; x=1772568139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1X9erx13AmO42yXWBgfxF/6jhINnqR80C54B3wMUUQ=;
 b=ZlD8Qo7zxQcPeRDmc50tZSWWD7TIiCJYfO22dB9S/Qv3pC7dtZKSpBFLFmB6m9TvQQ
 d9TuM4twLVLsR6whMEiQwyAVfZSntsOdMvFSDoh6pF5/FSZUi+k5z0Pn6Y4xPJe0l/ay
 ZYiRChX1iwhInEysxDV/lq4Jh8dtrTta/ZxfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771963339; x=1772568139;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1X9erx13AmO42yXWBgfxF/6jhINnqR80C54B3wMUUQ=;
 b=lCm05esqF7b/bJwFWvImYepXVzM11FcvNFlyhJKeMIkK2OZpneyiCE+OWZRrRHzse1
 KT5q5OXgan1H6/u1AjcprIUyKPAC5DSz2ToPYDoci9AaAZR3EoZuVnBhvAMoeAk5Y4AI
 TG9zan7vVnPKhnnhatLd13PekR6YmeSxJjAJVtYIpYiSkwH1wNYjpSlzrh9ZTwww/U8J
 YmNHIO/RFj/N1/73wNkriHhIlojB9KZe0bDCstUIwo4IvUVpwmUg5CzK73AhsqJoHJfI
 bsT2M/x95LgkbrPvNe1C5dsSVjpAKbqKUqlGuDQvxelss6zhKwI+zlUghwKFA4DMNG5v
 xAjQ==
X-Gm-Message-State: AOJu0Yxa5iHSNbnctB6hG0wNFEN1akRZCzkRAEIVGnVNhCPon4u55PqY
 5yXhPfScu/XiV65UPJuVLI4bVAsrCiEqVsx+3Hz6G0zlmInd+5iQ1Ko0aiW7Va73QYana0wdqTH
 C5NjiO/g=
X-Gm-Gg: AZuq6aJID7WG0gz7HHWD/3RsKNmgJeLNzcoKqAQvVzWOMyMnd+Phrm1BsjlBJnIeDum
 uLL+LrR1ta6nuQw8gSS9JGtuVr66LAxqvMgJXkvXQ7jF7qhmtMQ9LJ7CFvxbpTXRQnwjuyxU6E2
 HHNxoTqxtApc46J8jBavzwrR6i73ir1WXoHmWvMCLSrBm63ujzSudvaz3qLOwJ5mCslo1CTU1H6
 ewQd2T1Vwu2BTXoDzLo4brq4fTf4JUg3HkidAAk8eTMcf74NMNPbGLq78meoDu7g/M0c8bUoJO/
 uaYG/EaX2WoPTmccJVQbmL7hfoWBsQKjn7CXD7q13zaN9izdXqcmYjfB+T7aDzDMq/f8beUtRvl
 YTbWFBOZSFldoSr28HjD3mv+63+vOeMnSdmvXM/fXMi6h01JSbKcQ88jr0QRhN9iWOFwxwgE0rO
 UEhX/52BN2t4RLFgRs/FWYCTsq+PqNsoatLYifgIaHNDTLls8MDvPhovBuOYP1D2GAzmMd4GeC0
 c1VlmkpOXb7ztnIT79gWgChKcEWMM4ArdEwSd9ZOh5d3LSWxQ==
X-Received: by 2002:a05:6808:5094:b0:462:d784:fc6e with SMTP id
 5614622812f47-464463d309amr7294720b6e.53.1771963339081; 
 Tue, 24 Feb 2026 12:02:19 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm7621369b6e.6.2026.02.24.12.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 12:02:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Devarsh Thakkar <devarsht@ti.com>
Cc: sjg@chromium.org, praneeth@ti.com, francesco@dolcini.it, 
 d.schultz@phytec.de, w.egorov@phytec.de, ggiordano@phytec.com, bb@ti.com, 
 anshuld@ti.com, vigneshr@ti.com, n-francis@ti.com, s-joshi@ti.com, 
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com, s-jain1@ti.com, 
 r-donadkar@ti.com, sen@ti.com
In-Reply-To: <20260224134557.2067046-1-devarsht@ti.com>
References: <20260224134557.2067046-1-devarsht@ti.com>
Subject: Re: [PATCH] arm: mach-k3: common: Clamp RAM end address to
 board-usable region in spl_enable_cache()
Message-Id: <177196333749.158215.2974830610070294409.b4-ty@konsulko.com>
Date: Tue, 24 Feb 2026 14:02:17 -0600
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

On Tue, 24 Feb 2026 19:15:57 +0530, Devarsh Thakkar wrote:

> commit ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from
> end of the RAM") switched spl_enable_cache() to use gd->ram_top directly
> but omitted the board_get_usable_ram_top() call that limits RAM
> configuration and provides updated RAM end address per memory map
> used by board and impacts subsequent allocations and reservations.
> For e.g. here it impacts how high the TLB may be placed.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: common: Clamp RAM end address to board-usable region in spl_enable_cache()
      commit: 26048cdb4ce35b4119e82df2aafb1ebf3f611480
-- 
Tom


