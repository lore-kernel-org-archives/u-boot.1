Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE68E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD31840ED;
	Fri,  3 Apr 2026 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VELXHTpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4877684120; Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6CC84120
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so1729509a34.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245636; x=1775850436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F5ffvqjcEo2BjrFpPC9NeqQOTBJbHMGa1sxXWIlLZBw=;
 b=VELXHTpgyN0Ln+LpZsGfK+hLRq5JzB0vHEB7r0xQhd7B0658Vsj6qMiAecq9NgQe3O
 Jy+e9SCUvTKBheS2l+BVwNZSq38BqqrRx6WAHLX3CLgDagYinAr2VRiH601KEuJ+ut1R
 ymjA3B2Wk3EX411UM6T9hGkxT8SgRqcXp+aRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245636; x=1775850436;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F5ffvqjcEo2BjrFpPC9NeqQOTBJbHMGa1sxXWIlLZBw=;
 b=mKlWDKoXFCnX3P5mKeUWb7i/Y+ZnlWx0T646A6wXCOjvayt8UZ0bwksVBmfN4ikoNi
 UMwQIAel6nIgnludfixqQH6z7TeKto1c1bHbeJG8urz+bRA5iS1WIhqXOMQKSXV9J2Ay
 zMIME8U0ZSByk7zNDvjr+ezyYsGsTlKRR8GmNgmDBnXbjKMJu9p/xEpF5NJXSrMViEQv
 YfmNAlA3lMTSsJtz9dOFJRWN9MIkC8sd6tSOMErvYFcCotEQ0fLAIHYSPpHa2fefeGO9
 Q27zCQgJGr/a/Ppl2JDjs1bcyUGi6XIS1JyiMmDc2aBh/MhFCiomgnzstkAWIaEHVhib
 EGeA==
X-Gm-Message-State: AOJu0YyjnzsMHp6Cm8vwO/tsWDGz/Ou4W6jrCLggbjzKhbr1fxUgWAJe
 awfmo/96D3UgesxX5NxmXkZtxG9ego4H+z0yuUPk0vInt7FLoC5ovXTn0KP7mNtMYD8Us87xCGT
 9IBB8qEI=
X-Gm-Gg: ATEYQzw6EgxMWZReo+tHswSjiPFwjPMrw8nd+THoi7X4u7ex8iydiRqYQdOZ3jPRoht
 /5a8VJUl9H6gixH/5ExhCcsp6OZxA7KhwVsYCcZazkJuNylA55MZuD3Dx1nEdwRt38wLdYe+ChZ
 8eL8gEttKbg1HPo0Y2rQfi9vilb1DQMCpaQFNe4Ak12JAi1tItaxVFogvX99WQH4cT+93dsi3Nx
 xsJHLRCm3bXxda8kKMUWCx3Syi5mupQveRKYeN3puAOH2ASjPl1BqWMBzIVsH6lT0J7PxWXIMGb
 4P+Ha6d3sQAYfAPF0eelA3ziM1NkZtyRt3KomOIvAP44ACzLldfPfOXNhHxTc2GEx4c8crYVn3d
 /Ovj5tDWvTVwcLCllDCMxPqLVQq9Oe/9LjLw1OlviiXMVglHm6OHXJD3N8G7d4dAGrjcPlH717f
 Xkn+eTk76HkRnIhqElfo0DNPSS5C59w3faM/1l8dcaLPsOk6ixOQM3UzWjUwZY7CBqxkq9tztwa
 skWSnXGgH+HPGdolyFxxe8obO0Rh2Kl0odCQRntMsdNwcg=
X-Received: by 2002:a05:6830:63cb:b0:7d7:fd71:f2e0 with SMTP id
 46e09a7af769-7dbb6cbe506mr2877925a34.0.1775245635793; 
 Fri, 03 Apr 2026 12:47:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205331.3788710-1-trini@konsulko.com>
References: <20260320205331.3788710-1-trini@konsulko.com>
Subject: Re: [PATCH] rtc: Remove legacy DS1338 support
Message-Id: <177524563528.2281750.12707923201091764730.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:15 -0600
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

On Fri, 20 Mar 2026 14:53:31 -0600, Tom Rini wrote:

> The DS1338 RTC chip is supported in DM mode by the DS1307 driver, and at
> this point all users have been using this functionality. It was a
> function of Kconfig configuration that implied otherwise. Remove the
> unused legacy symbols.
> 
> 

Applied to u-boot/next, thanks!

[1/1] rtc: Remove legacy DS1338 support
      commit: 592c244a3a76e17df165f3662a596f2f9e970ef7
-- 
Tom


