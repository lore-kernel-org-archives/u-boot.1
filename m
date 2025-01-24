Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1ABC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 22:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8329980C98;
	Fri, 24 Jan 2025 23:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s1wHPgiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B865E80C7E; Fri, 24 Jan 2025 23:28:52 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C8180ECC
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 23:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so234429785a.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737757729; x=1738362529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lA2c38BvalnD04ksOy4AP5e7qIYQxzN7sD11nS0bJsU=;
 b=s1wHPgiM5JtTErsyekZUGXA6VYKxX9Cg6q2LGFpvBKolUJIV8rojPCnb2eGkUx58Z1
 zJYjVnERHqep6fDXGB9G+GVG0kg910VuBCPsWhRwnX6ETP4T7ZBU3w6eob2QGDC73OUz
 J+VHEv0rak8QTINPFXFUOgahBMux5WxULAEYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737757729; x=1738362529;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lA2c38BvalnD04ksOy4AP5e7qIYQxzN7sD11nS0bJsU=;
 b=XRN3e2HPU8KMOk1iTifcVmbMDfUGBHfoOY9TCvQyTEBbvBZlIE6y2LsHhDckzuDxuk
 Y8QBZd4njD9BqAzR8wjD649RT1qautg37sY+3lSQLluukvdZ6YGWgEbpMYRxyDUGvP25
 ckeG5RHMIdk3cqS2j5B3DeNaT8C5qu7dKX36XZ508M+C6yB3iY9O3SrlBg9GO4S0TNZ9
 g0M9cZe7qmozQhCcE6I8/1/gMGN9CU/IFq31/+b9bjqSy54nKP7H9ZgPZ29nypLPZB5N
 MV+6Omdn0AvsaVs11SnoOUUGcBeFqaBTPgsbl2V9gX75LURW3eUGvU+M4Bowoqp18zL+
 05HA==
X-Gm-Message-State: AOJu0YzNAJa2aCj2p22AbWDSACjMY6Z1+UjsJP4wsi7J2UzFcOFYdUQN
 ldmGfSTEkl6XTfl0hnkuGIB8AcYq31TrxWF7xF2YfV9CQKFMBv67IQqOU0Okh2I=
X-Gm-Gg: ASbGnctVoxfSk+N9hUEk3VeuK/Oq5UfaHZD9ZvEH6jQUVj6F6mUoB83nrgRhpHqiOU4
 8GOaZnIePLSYYER5zT6Cgc6diSET/rMBxo4l8psePzTJUORo8L3hAMWS3Va0Qao5E7CJB5PN6zH
 oPft+VdvZyGeLnOi/DNIiWm3a3z1jodNrFEnk6zLF5CGxWrW8LHmIDoxlm+Vis9vY7kNcVLssPx
 Iiymvw+eXWnrbienHQHD0SAPs1G1dKBjNoQ7dSBEO9NxDASZg97/BpT385/ozNbNPUnrRULnlrc
 4dA=
X-Google-Smtp-Source: AGHT+IGCxwwfT8cgOJA9vLc29fYQ70eh8I+sIIrv8Q0kw8Yzw/1VdYizTFRk2FnP/19A4dHHj/yaQw==
X-Received: by 2002:a05:6214:588b:b0:6cd:ec00:205e with SMTP id
 6a1803df08f44-6e1b19e0831mr532031106d6.0.1737757728721; 
 Fri, 24 Jan 2025 14:28:48 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2052498d6sm12787946d6.47.2025.01.24.14.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 14:28:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Gendin <agendin@matrox.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Massimiliano Minella <massimiliano.minella@se.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/44] test: Improvements to ut command and
 test-suite running
Message-Id: <173775772518.3136238.8892169232211950805.b4-ty@konsulko.com>
Date: Fri, 24 Jan 2025 16:28:45 -0600
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

On Mon, 20 Jan 2025 14:25:22 -0700, Simon Glass wrote:

> The current method of running unit tests relies on subcommands of the
> ut command. Only the code in each subcommand knows how to find the tests
> related to that subcomand.
> 
> This is not ideal and we now have quite a few subcommands which do
> nothing but locate the relevant tests in a linker list, then call a
> common function to run them.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


