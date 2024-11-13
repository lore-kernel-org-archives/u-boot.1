Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D6DD637D2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 23:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16E189282;
	Thu, 14 Nov 2024 00:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uPRi7AE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F0F8926F; Thu, 14 Nov 2024 00:50:57 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F27178904A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 00:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ebc0dbc566so3518910eaf.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731541854; x=1732146654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdI+GZRDoIeGqmo7hRhy2EnO5BHupst1p47YHEfUi7k=;
 b=uPRi7AE4ULCyhwvlGUKs8iGFat0smdYLLTpOPYB9V9f4llJFOq2b++DiQi7YJ9EKcf
 rNSMb3rwUsSZ8Brso6fF/LD32wfGQoHrXWc+oDvl4Ca6OoDyyOdmIyudpExjmWJE8+Zz
 Y65wV+nU2EatcTE8i+jAPZBa1jTHHuu8mtCxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731541854; x=1732146654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdI+GZRDoIeGqmo7hRhy2EnO5BHupst1p47YHEfUi7k=;
 b=iCudU890x9XnThaj6T3mthBZ3OpmpOhblW6S00LdWkmmt7GpouIeiQ2/Yz42OtvGr7
 ZuuOLY0QcnHNSnS7jkq3QI6maeek4BG/mU04GgONtQGAGOhGP7axduhAq/PDpYkot1qG
 Elgr9iGxiOUiL3BelutWrcOu1j6NXbI9qsEa07J0YAt83Du/OQ1ynb3k+BF0CIqgvERb
 AX6u9wOQBAZ7C9ZwjMcvh78cBolF8c5JeCXrUkbJ/wx0rbJl0vmoBbkEFyLUbgNlDOri
 1WApduoET4rHKDYZVMEIsVjipCep9tLv4Tc7ZaZ2/IVVaI0losD9Op/1yLD+zSpcXouk
 He9A==
X-Gm-Message-State: AOJu0YwsyzRJ6BdRSg13h1Jr2W/jYLqRwKDHWrEzKx19gOeVh2ELHeoC
 6u2h7UrYl3wi1VEgx9IiaeUV69jlPF17R5raVwEBCPmJepRSk8TevomnGi+LtSs=
X-Google-Smtp-Source: AGHT+IEy1eMLMNHr8NhSXLCasgvAwfAr3bN5IWYt5M0eTP1D/zfTCYnccWHzUno/2a768UVxbUf/JQ==
X-Received: by 2002:a05:6820:1a0e:b0:5ee:369:9068 with SMTP id
 006d021491bc7-5ee57c3faedmr15789331eaf.4.1731541853696; 
 Wed, 13 Nov 2024 15:50:53 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4950f85asm3361505eaf.11.2024.11.13.15.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 15:50:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
Subject: Re: [PATCH v2 00/20] test: Tidy up the test/ directory
Message-Id: <173154185159.2076886.1253882531225210704.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 17:50:51 -0600
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

On Sat, 02 Nov 2024 13:36:45 -0600, Simon Glass wrote:

> Some tests do not use the unit-test framework. Others are in a suite of
> their own, for no obvious reason.
> 
> This series tidies this up.
> 
> Changes in v2:
> - Leave the bootm rule alone, as the bootm test only runs on sandbox
> - Make the test dependent on sandbox
> - Add missing 'common' help in this patch instead of bloblist
> - Drop patch to move bloblist into the common suite
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


