Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9895C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19F388756;
	Thu, 11 Jul 2024 23:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KKLKp1Cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E2E88703; Thu, 11 Jul 2024 23:28:00 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C9E88680
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d6dd59170so732068fac.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733276; x=1721338076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpRQ/30zPxNJXo8t+93y59YRt2YYyyEAaTyDcA0jEqY=;
 b=KKLKp1Cp4F5DknQcnAR39iM2ASQuuPaSRZv+/E8Fv7jHYS0s88+mFi0ZlW8PDgYxYx
 Y6BQDXPsP+UEm8zcp/JrYMNJ6/nmVVBXqb1n1fyRoHWAGvHlF/oUaTFSp3t5IXVCSE8G
 n7RuUp3O12gyV9trUAxhkXlVk0kZtOIyq5OZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733276; x=1721338076;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpRQ/30zPxNJXo8t+93y59YRt2YYyyEAaTyDcA0jEqY=;
 b=gtaDreoG03hk6otZIXWdEvxTi12iepBuJnRv78UwErAzVz0b0YyJ6PNqLqvqSakLtY
 vKiKSrq6uITaWSkjCtwOCmciWZlMGzmZZXrBxhhVOn4EabnlSzY8iX2FmgbOhPfONQTT
 h7gkxcbfmBeLFC4h/NQf66qFB2uMyNDxzMgaGe/RdPdJpxVb2jQE1Kg18W/HEnKa5JTo
 PHCq4fRDJk61h5Nq9Buee2a973bfvJfsjrlFBLn9sb09U0eG9ySl+RwiFHORKeyYrp61
 ts5dWl75en1vG+yZRyODia9BZrob/j8Cofp2P2MYrAPAmrKlRcnns1TRcOYfLY7gryr/
 bMnQ==
X-Gm-Message-State: AOJu0Yw54esxEKCwaFHdzT4wFBia2q+hSmkWwqn5G6OUU0lmeOmT379+
 JflimwsEbuD/CJyFHdzxXIvaLqO9dJ0qJ8O76N78X2VOCkVGTU4xHLXraQ9Cl34=
X-Google-Smtp-Source: AGHT+IGsrxaZ0AEl67uwkMKe2kvVvhfcctFE6YEVlGdBbLqwTgPvOuNj9eYQCrjh5gWKpTt9K0Mc8w==
X-Received: by 2002:a05:6870:3117:b0:254:b318:8a05 with SMTP id
 586e51a60fabf-25eaec74a0cmr7710408fac.57.1720733276400; 
 Thu, 11 Jul 2024 14:27:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <20240702195429.985628-1-ghidoliemanuele@gmail.com>
References: <20240702195429.985628-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] mmc: am654_sdhci: Add the quirk to set TESTCD bit
Message-Id: <172073327562.2744109.10056841742024246729.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:55 -0600
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

On Tue, 02 Jul 2024 21:54:29 +0200, Emanuele Ghidoli wrote:

> The ARASAN MMC controller on Keystone 3 class of devices need the SDCD
> line to be connected for proper functioning.
> 
> In cases where this can't be connected, add a quirk to force the
> controller into test mode and set the TESTCD bit. Use the flag
> "ti,fails-without-test-cd", to implement this above quirk when required.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


