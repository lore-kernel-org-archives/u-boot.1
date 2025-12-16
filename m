Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47974D609D3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 17:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1252A83984;
	Tue, 16 Dec 2025 18:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EEuYwDrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D91839D7; Tue, 16 Dec 2025 18:29:13 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0458392C
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-65b68c8c649so1278122eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765906147; x=1766510947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rG3EqpuxPbZI0s9VQn2f8BtNT7b24+WOMD25j3FyccU=;
 b=EEuYwDrWcdlMzqJXN06oRfs0Jdd8/iU1B3sQ+6/koFqlZqfNCsVN3qKz+J+Rfe3vUs
 Te4prUBJ6c21P75MSe73+3x4uuiXBfjGLoJ4yE6jEewG3++ciRiDZWoUrzCMfsd+MXpU
 nnXE64f7fAT/G+IMlRhvevlsdd3rAGg827CDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765906147; x=1766510947;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rG3EqpuxPbZI0s9VQn2f8BtNT7b24+WOMD25j3FyccU=;
 b=lg47sJK4TjDBm9LZa4FKBME5ehfHQL4saOcaDIplIZAfCoQIrZRgKCP8igbWFih07U
 MH6JUuAqhi0nAEjAbEqXBqtID7tCr+AfBg8/Og8wkqPn9ts2aXV9wY2oqvHNgs/lhmFE
 yH6l5e6ykmvAeLsfWfzu7kWZBwoTA4BA0WnmdFW3WqR33TLl09Z+56Yxt+Y9SBDu2eof
 osskwLhsJgZogTvuqKNNQ0AZRd2hS1NBuVBVYNsF1lvC5PK99D3l8syI0MEgF0dQ++G7
 XDg/+mR1XwQqHgqt30ZbnGoyTPab3g35SUzqmaWftlIwFX4PDrpbrh+o/fAYXnfw7oou
 8CPw==
X-Gm-Message-State: AOJu0YwlZ1EJGM3KFePvk0Y0PFc9SRFP0KHT3mm1OHhp1ozDuut7htya
 uCOyS+KR0NZzxl+En75+jC20OZ3qOvA1cLHUcD2aftbA3PBJ2dx16gmx1nD5v/gNXFQ=
X-Gm-Gg: AY/fxX5Z+oIkE1dV61xwm4v+p40IcIyD4UXonjnoAKQ0/Lz40fS/IaBuIvetIt89sSk
 n0MCe7FWg4wraLKIJsGgduo0qxNDEIXpWbFTC/0BWKKzs9W/g7nAt54PHeKVN/IP0fLrmM6YcTP
 GM7dRBdvSe9mON6MteeC/JT5T+LiRXQyhg2nhKpmCVIs8yDc3xG0DoseF9cR3aK52QZtV34o34l
 5rsMxQIaD4urr1ZMYjHTvzQ2IdUVV0wHgqXfbvKfmyjTxU+dwtZqAqdj/m+DQKTDb5AX+P1a5oo
 vZz7Hx3Is9t3CPjAI0JIIf8uqAdtglm545BgPe6lcG5INZSZA2AYkJhzASpjogxlfQNJxfMPUUz
 z7pcdg031WDTB29pIGwN8tlxhbIQRO3qNvPzNnHcvRIVNP7LcnxBGk0rxkbutspyqDOkkvS964H
 VY+iyx7An2lyRhK/6v6IU9KqpPAzyKa3vinTZ2SLRxC32r4e/w
X-Google-Smtp-Source: AGHT+IHO2CQCq0gVeo0YGIwDMTQ9pujHmoBE55w+kgqdhzlDZF1lE+3MpyoYPqlNL02JU7tqwaK8jw==
X-Received: by 2002:a4a:e907:0:b0:657:432e:a820 with SMTP id
 006d021491bc7-65b451684demr6600171eaf.1.1765906147468; 
 Tue, 16 Dec 2025 09:29:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b86c32d5dsm526682eaf.13.2025.12.16.09.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:29:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d98f857@baylibre.com>
References: <20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d98f857@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: remove duplicate '@parent' field doc
Message-Id: <176590614659.2175876.14713216222453991636.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 11:29:06 -0600
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

On Thu, 11 Dec 2025 15:05:27 -0600, David Lechner wrote:

> Remove duplicate '@parent' field documentation in struct mtk_composite.
> There is no need to say the same thing twice.
> 
> Also fix spelling mistake in the word "parent" while we're at it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] clk: mediatek: remove duplicate '@parent' field doc
      commit: 9d08916a575beba3632c3969b96f74be08560ef7
-- 
Tom


