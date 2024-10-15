Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2FDD1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D15A88BD2;
	Tue, 15 Oct 2024 21:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fuNPn4pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3897888B5D; Tue, 15 Oct 2024 21:44:03 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2138088B0A
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-28854674160so2389355fac.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021440; x=1729626240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ+CAV0HwhCBxkGtzq0rF/65TDmyI6azyrWVeyvFyN8=;
 b=fuNPn4pl5vvAzO/tJWa02+juvhcbDnmQLZihWpZs/eN8WgDAsmJDPeF/TMtIoxOH6O
 +gGLlGzatLpA9ekOvzIylOcbbgvSpk2bQ8H3RsHJ2UcqebmcgTyvckAImy/gTHNMs4Yy
 oIlPtP4UTESSnPOQJWPj/gjmu5wK9FaKft5Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021440; x=1729626240;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ+CAV0HwhCBxkGtzq0rF/65TDmyI6azyrWVeyvFyN8=;
 b=TLOHnPpLXVm0Yaq0+CZSCafeWL76dUF8OhccfdOCGI+dlHzd6RpQxNHs6DzSjVPs9/
 rqIJj6J4v+nXu83pM+I0inJzftODn7qJoJ6BAyRo1Nqz5VZy2AXnpPnJtLy5puYL8Zo6
 dZgN6hQt+FpcLtxDxb/wT6r3vT/beCZA9WDMF0XaaG8HVKtNlFtNcLERJjJTWSI9g+l0
 egJx4ZETd4QxK1A8q2BGhopLnFr3013ByJJR1f0/m65AOhjeUsccRAHZjJ3i8u4txkwd
 YZTLywlple9JuOrkEtU5u/A7CkhpoDcVLN/STHBJyNiwdMy3VXVjFXVZ7F3wRV3xxpna
 0XvA==
X-Gm-Message-State: AOJu0YzUxXTQ+KKOECMhGCD+Er4V8nr37UYayPmSt4Wlg8rRwRDZdNJj
 4705RPzikbAwZrbHoMimlHwhP0+XvjzYoc4XvBxxLD0KnRHDNjXTQkAYqrZjfZQ=
X-Google-Smtp-Source: AGHT+IFC/3guCbGBr84UxDNuXTWsQeb0fYfG5hs20rGBfqaxau/ZdVRWM1SsuvwrI2CYDPFBHQ00jQ==
X-Received: by 2002:a05:6871:70e:b0:277:e6fc:4a69 with SMTP id
 586e51a60fabf-2886dd4b22bmr10619772fac.2.1729021439719; 
 Tue, 15 Oct 2024 12:43:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20241004230756.371153-1-marex@denx.de>
References: <20241004230756.371153-1-marex@denx.de>
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
Message-Id: <172902143755.5381.3133865412226742988.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:57 -0600
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

On Sat, 05 Oct 2024 01:07:13 +0200, Marek Vasut wrote:

> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
> is long superseded by binman, drop SPL_FIT_SOURCE support as there
> are no more users.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


