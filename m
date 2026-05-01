Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79943CD3427
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 23:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC138464E;
	Sat,  2 May 2026 01:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mH6/pa1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24ACD841D7; Sat,  2 May 2026 01:51:20 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB1084605
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 01:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso1306135a34.3
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777679472; x=1778284272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB11rjFTRDxeBUbbf4pH4F63C/vjjo2WpbSHuZAYH3Y=;
 b=mH6/pa1S+iRwDqURTpdf0lsCL1q5txMXvHlcJIPE0MUzOQ7EviKnBvTgp5hal7Fan1
 xo6jIGlkS/CZL0oRNS0B5XNeEXpQcVYHYg/VoH17j/saLpspr9YbHLl+ulWXafTZJO0h
 jvhogNAsxgkKcva/sCFWebfEcEphU9JvVtPj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777679472; x=1778284272;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TB11rjFTRDxeBUbbf4pH4F63C/vjjo2WpbSHuZAYH3Y=;
 b=UR7xcOUieAgIclU2e5g/BProbVywlROiB8LS9oCo+kvrhQLIsPg3nWb6qNNGkXLVFA
 vETGg/bVi6Bpjwyc2DCiU9kYFTcwMFJTI9mSzbsP+HsXCqp8vfbXEfS6jc1/w2o9Zr93
 3I3krbaMLBAGC3/wha0rubwxvX6QRkh/u05FMqFtNv6oBKpmEJbqnuP1tPEe/MTnXOxN
 Yi2VmZwY8V0UyeorcL542YR5pOrDBEozvfSKiqMNmvXVTpYgkbuoDCT+imjZVjD0GirM
 WsmomEyfw/KJoGPXdEui51Pw9c8k4xxDOJZG/K4kbRSuIAhOib4xmWNtQKwO1BmHOhew
 ezlQ==
X-Gm-Message-State: AOJu0YzOr+H4ZECjVRiVruDjMt0QfbSUI1iOoCk3vJAcMziMzWD9Z9O2
 SxpGuQrKkYl/EY3YdJ/BwXj5n2yOo4+NLrnPc7gi/3poJYvOPKE7dJMVRd+1191CDB1PsM4NS4i
 7ZuxGq2Y6P/pG
X-Gm-Gg: AeBDiev+WFl1hJU9nuzfDWsnxEOdDDpiVqBNvwgSjP2JGoa2NT15AcGEuTeG9Mvd62a
 Oz4eJjb1WeobmiBdNfBPdf0zsSh3MzUxcRuhfgTOR+0kmpYmAx5y8oWXclzt/NOjtw8yJlajWjo
 rjrlewc0yZ9AWFg3fAYB/O7BfxslhDW6WI55BtuwTUuxGWzNb9P2stag68sRxTL3eyvioLHL3n+
 4qNb14h+iaYgB9C3dir/KfkdY1BdL7h+ijQtQ/StySx6OLHJepuw8njiyXv5Ho9DQzvFTm7CvsD
 +zxEkIkGkpS2ROFHkS5kK9ac7Mz56rRCzwmnUtn4F9GDaq/wXdAUUIGrEBPiVQ7S93kcHBW2ZZu
 5w7+hc83MEg7m8RoC65hLjJpqqpFa/IXykvOm88LgZsB+6Rkv/r4S0w2eE7spOq+BWg2vXJt7V4
 8vIyvfVHWkg4aSMOihHcgDHw8nAltx//rL263DHzXf5lCk1ty3ofFTNG9xQwoFUO3BPJkzSSIww
 12tx4Rw4bx0QP4dUDxVVXjZmsSOjMkR5U3Y056WATwx2BqFVF+3jADvPeWv
X-Received: by 2002:a05:6830:3c08:b0:7de:44a5:51ea with SMTP id
 46e09a7af769-7dee121de03mr864816a34.6.1777679472500; 
 Fri, 01 May 2026 16:51:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded51a9612sm1967949a34.26.2026.05.01.16.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 16:51:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Yixun Lan <dlan@gentoo.org>, 
 Richard Genoud <richard.genoud@bootlin.com>
In-Reply-To: <20260501135917.9276-1-andre.przywara@arm.com>
References: <20260501135917.9276-1-andre.przywara@arm.com>
Subject: Re: [GIT PULL] u-boot-sunxi/master for v2026.07
Message-Id: <177767947137.2064724.7106308396690525541.b4-ty@konsulko.com>
Date: Fri, 01 May 2026 17:51:11 -0600
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

On Fri, 1 May 2026 15:59:17 +0200, Andre Przywara wrote:

> apologies for the delay, but please pull those sunxi changes into
> v2026.07. Nothing earth shattering, mostly minor improvements like
> better SPL power LED support, and fixes to some H616 DRAM setup. Also
> some more forward looking enhancement for the SPI code. I also pulled in
> Richard's raw NAND flash improvements for the H6/H616 SoC, though this
> lacks proper peer testing due to the lack of mainline support for any board
> actually employing those chips.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


