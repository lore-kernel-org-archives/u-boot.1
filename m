Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F85C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 12:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9763E880CC;
	Thu, 21 Mar 2024 13:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOdcOtSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAB58805D; Thu, 21 Mar 2024 13:15:15 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED2486564
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 13:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-696499bd61eso9270976d6.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711023312; x=1711628112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhWzZO16AvGQoU6gvj6NeIhzw9Ou2j2OPkfvY5+eVhY=;
 b=QOdcOtSPo2xqR00EyqD01Is3SGkhdgXb66EUABjP2DaJ7gMAfVQ6lXVJ9YMUh6yX4X
 u6KR//1jGpZk2H9t5K+hxgRRH78d6EzeoU3UxH5JlUStIfR7YiZuD5lwp8mPrYLqYwnF
 Wy8yJp35EN9+qPXl2A6EyAG6bejtiedHr2wic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023312; x=1711628112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhWzZO16AvGQoU6gvj6NeIhzw9Ou2j2OPkfvY5+eVhY=;
 b=V+i0Qy/LRDFf6vg3w213Uzoyz63slfP1QrZEM5ZEqMC/lQuA+xpLn381QYl07cxtLI
 WY40mZ6+C4APithZ/ZkcU2zhKreSn6+odkOES1XzIZOQvEvQbLYbRrCoSITX1hQZQzns
 bGqONeRYkdjL/9v0rnsJ1GiuXEbNWy++11LfXBCFWyqQjdqDNuFGGtn3ISgUMesa2PtH
 KzIXWgeKAtYMuVfi/bqLUjWsXU7cIXu4D851jHwOSWB4GudLZH/K9/jtSoEFKpdMZwjO
 E2NpKa6tw+w7+l0EnZwMFnCgBW0eJXJJDISPcLT9rMgMw1dS+jZ9iFSZl5EO3mUqISzI
 EGpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQyPR641UowSSzp59LURaA+ni8VWrgxSmmTbAImhSNdnCxpEg+zUYE2gujdK3pj10S7QPaAkaLXqnqWvTuInmKLjpTng==
X-Gm-Message-State: AOJu0YyOrHLMq46bS90vz+MfS63hQs3VxwHnJeCgG5Nu1or0NkRBeEXG
 qZmiv4rGzjZNGe6q1STQ9utZ6Qcxs2mGfkKpklSj/joQILxpafWtdIgkk93Q2VyVAg7foGbSIrX
 I
X-Google-Smtp-Source: AGHT+IEVQtuzBw3roPOOJXM9iWczb371asHVdfyV3CnXwsoVCwtKciyQ71yhy5zh9K8P1MJ+qC2lkA==
X-Received: by 2002:a05:6214:500d:b0:696:5d63:7209 with SMTP id
 jo13-20020a056214500d00b006965d637209mr810011qvb.17.1711023311915; 
 Thu, 21 Mar 2024 05:15:11 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 kj25-20020a056214529900b00690df461ecbsm8990690qvb.10.2024.03.21.05.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 05:15:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, 
 Ehsan Mohandesi <emohandesi@linux.microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20240319132459.1997125-1-caleb.connolly@linaro.org>
References: <20240319132459.1997125-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH v3] test: dm: add button_cmd test
Message-Id: <171102331072.1913497.14668608082015300845.b4-ty@konsulko.com>
Date: Thu, 21 Mar 2024 08:15:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 19 Mar 2024 13:24:42 +0000, Caleb Connolly wrote:

> Add a test for the button_cmd feature. This validates that commands can
> be mapped to two buttons, that the correct command runs based on which
> button is pressed, that only 1 command is run, and that no command runs
> if button_cmd_0_name is wrong or unset.
> 
> Additionally, fix a potential uninitialised variable use caught by these
> tests, the btn variable in get_button_cmd() is assumed to be null if
> button_get_by_label() fails, but it's actually used uninitialised in
> that case.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


