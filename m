Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADACA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7F882B07;
	Thu, 21 Aug 2025 19:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="donqhGEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D1B82B07; Thu, 21 Aug 2025 19:16:37 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D8682998
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-30cceb83f85so800083fac.2
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755796594; x=1756401394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1ODwSGIvA8YTv+ObvSLJGhtq92p1iZ0Uz78q1d0KAU=;
 b=donqhGElJ3nEFb43ND+hmBEJFH9D4yJX50uWF4Sic3uV9udgRoP3sqICmevQ4gmzRZ
 nsK+kBPz9zdD5sTy555wbxAc/ZG/ly+qLOeT/AVxVvL2u74Fbc57zU+ZybRzOd0s+mQy
 2SOyEZSfekEoep807LVOhCbfb+Tf+4Ci+DyBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755796594; x=1756401394;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1ODwSGIvA8YTv+ObvSLJGhtq92p1iZ0Uz78q1d0KAU=;
 b=qGKs14tDFL74R4S738FpznBAUeZMFDr9rj6bEvA5v3NHGAleVOqt1jbM4WrDF8ikTI
 bNAvm9J+8nUomL5cfb/34DEaGdFg6Z3Q9R4uD/ld3O3m/OqDjR6yM5+6V1rqpkqsne3y
 2uwxoAP11AVunEtOyp3F2WhAPxoTaxUrAjIILop7CQqzkqQm1WDmCJ/4ntulcCmOqw3w
 VHsuc5ePpVNgN38SmY3zAiM9DH5jkUF6aUgQzRt4RfX5tS5+hwucUDrYXmCa9zfYK+A1
 jWJ7ne/C4QS+zyeX65mcf7+SiCd8nCNxrxbDuAk038rKaNv+vyw+AyATcj+310ZoKRcs
 gFqw==
X-Gm-Message-State: AOJu0YxLDG6u8Cz7yYngvaEmUeJEnPO/V+nfd/f1sl5wHaepUUL/kI79
 WOKyZDB7I3mzf1L/fijkdg7PKu6xhOElnMgWm9dsv5AIi79lUefFWw9KeYcYQNuRxQM=
X-Gm-Gg: ASbGncuN7AoPOk3CF/3r/hlMEB1esB4DlMu5cGlmr0pgFVMaoFhWK/xhNpjs/MKGGAV
 HCTj1jH28Wl1w9vj+noAYzbCNAGAkXuEPtBZOKdqQbLz6Id1IL1Vr0iBYVDqQgyblJi7ZUbXMCX
 LMlrKbEqamTdyp1aYduNPjT1rSQGLgeXtqK0GUPmhiuyOaCMZuFzHAqhBXT2PiMmjMo64YWXRzk
 gseymUGj9/NKEd+WoXOWDA4+Jj/F6V5DeEPGXL6kmFfsXTNAAokAlIdeUCxfwoGUdRSJTi/zaX3
 odAIGbPAPemBNIjOQ0CcSbmhzgwUxuEovU8wvGFO2Uvq8WeWy35GlSCoXnndY/ZIbXlF3YIzCDc
 ijaf287OGxogOUaHO+oWZC0dK2WBHAFO4FqHFcp3Xctl66bsuGoKigbI=
X-Google-Smtp-Source: AGHT+IFiYxTlgifrnxsvuDTjnQZ4823zgLlNftRfGVKxoVBCSmye1O45LcOa8EQUX5UqueSxzcSNjw==
X-Received: by 2002:a05:6870:56ab:b0:2df:787a:d8f9 with SMTP id
 586e51a60fabf-314dcd40b74mr8469fac.26.1755796594463; 
 Thu, 21 Aug 2025 10:16:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab952d79sm4999909fac.15.2025.08.21.10.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:16:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maxim Kochetkov <fido_max@inbox.ru>
Cc: ravi@prevas.dk, sjg@chromium.org
In-Reply-To: <20250813055432.1095253-1-fido_max@inbox.ru>
References: <20250813055432.1095253-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] serial-uclass: set GD_FLG_SERIAL_READY only when
 cur_serial_dev is assigned
Message-Id: <175579659345.3655101.16734987231103061262.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 11:16:33 -0600
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

On Wed, 13 Aug 2025 08:54:32 +0300, Maxim Kochetkov wrote:

> serial_find_console_or_panic() may left cur_serial_dev unassigned if
> REQUIRE_SERIAL_CONSOLE is not set. Setting GD_FLG_SERIAL_READY in
> this situation confuses serial console code. It tries to use
> unassigned driver instead of debug port and stops printing.
> So check cur_serial_dev before setting GD_FLG_SERIAL_READY to allow
> console to keep printing via debug port.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] serial-uclass: set GD_FLG_SERIAL_READY only when cur_serial_dev is assigned
      commit: e4507f4a0a7ac3b5346934df19c2daed626cc404
-- 
Tom


