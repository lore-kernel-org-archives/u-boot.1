Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371C8C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C9288286;
	Tue, 20 Aug 2024 02:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AWHTmZOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3288843A; Tue, 20 Aug 2024 02:28:45 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B71E87A09
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5c324267aso2911933eaf.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113722; x=1724718522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbBqO+EqKXXVyQHcXZWT1ToN4N0iGhdk5c13tiRKiuk=;
 b=AWHTmZOymwOrOmuow1RzNM5pSNVWjRKBlhwMJGTr5wIfNyOFV3XtVXhYzXTmTCMWvD
 GFGwinLyaNL056Ma/q6rDZI+8ikkaYM9VHbNPqODvnqXmftmnjAHsN0S4iPfoo5xYTxV
 rKSLcbqraXsFl2bMVOS1MpPyyjQ+d3NoAkw3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113722; x=1724718522;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbBqO+EqKXXVyQHcXZWT1ToN4N0iGhdk5c13tiRKiuk=;
 b=xMBkJvOl25/lPeT6bHI+p8cMX84tVgTR0cBGuJqhlUTQwVc+2A4azV+5cLlTTFpIt4
 7lx9GuwQ81ScvxvBDCXAzfnkp9qe4+8FJDsK9bgFeIBMKMJEF1Cob2Atkc5wPJBVXEk5
 GaU/tUDNkXEPnxi8jNQ1cJyehL5vngaT8NQfj4xkk/ZnVLc9x9IKkYR9i0TrSJdbQdXT
 8pHUokgELroWBwUENZIdfmHJVoHXMIvrYXAshT1d0HtLs8RrGt9UtMCc9Q9p+Bfp3tJV
 wdF60YLgIewHJdOztHpGXdaWaJrk+hJ9OhIFeEcxoSZM1VaIA8OMC1WdlVv1uYWd9MoG
 kklw==
X-Gm-Message-State: AOJu0YzS5AmKoqfDSUCUas2bCHLBVjzGT/752gArZUPCzwgSWTDbiWF9
 xxT1Aiq6O0s9TEKZBPKA0vvmw1W4reDk3qbzTU6GK07MkN4+yKuCD/TIcJD4F3A=
X-Google-Smtp-Source: AGHT+IGL5ygMAnL2P9OtWOe6sJTcoYIoq7SyKQjefM+aA21j+Lhysv2OhrSUu2HXZJVwWT8aY84KgQ==
X-Received: by 2002:a4a:bd0e:0:b0:5da:a4a7:8f5a with SMTP id
 006d021491bc7-5daa4a798famr8913851eaf.4.1724113721884; 
 Mon, 19 Aug 2024 17:28:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dc93c22b0dsm122836eaf.48.2024.08.19.17.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:28:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>, 
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Eddie James <eajames@linux.ibm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
Message-Id: <172411371943.165086.15363871870866133253.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:28:39 -0600
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

On Fri, 16 Aug 2024 14:43:49 -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
> 
> Motivations:
> ------------
> 
> 1. MbedTLS is well maintained with LTS versions.
> 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> 3. MbedTLS recently switched license back to GPLv2.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


