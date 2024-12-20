Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B6FE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ADA805EB;
	Fri, 20 Dec 2024 05:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHTUxETr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F10C80608; Fri, 20 Dec 2024 05:06:57 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B338036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so212555866b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667614; x=1735272414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBNkhL0cIGkRjZgnT8FAgzV7Yz7jGw+roiVfNAJdDvs=;
 b=HHTUxETrcJxB97rCF6vfQ2/Lfxs9Leu1alX3Mn82GVYcDod0OPThhsUSCCToaHhR+V
 2LY1bIYe8V4ivyypmvS6LpiJY94o0/w0lTayCxRe2wC+MlN5TVvzJXHiCq4NaWZf+DZL
 Y26A1k8XVcmpAhigIv4pVdCoF5NktyW56z5tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667614; x=1735272414;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBNkhL0cIGkRjZgnT8FAgzV7Yz7jGw+roiVfNAJdDvs=;
 b=ARa+6i40yMenfDxFytjlEdXJd6K8eeKjOFaZ/empmjV/uiHQqT43lgWlcO/wKJX+5c
 8kJYgJhPu2bQnjJcn72lmXZZMt0EDfIgCn4rTWAGvjNNHYvoGAmbaHYRvIn1LOvLpFyi
 w2/89xpPNk77US/eqOZ2boXjqW7GfOSxSMdNYvh4H+Enrh9k6PfFobI/Jgbsm8qXzouy
 Nvs9KfABSmvSFPxn+QOkei2dJAdo8mb9k0qCM6ujPmfa+sQv+apPp/nAN0XnJy9SyCX8
 q1q9xv0ydwyMHG1eyJs9+sRW3Vl1o+IsNNp82aYHMu2V6uG/xyWFmSrpxs6dBB9Dvu2A
 uSnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5V1RpuI1nOStbD2eWF0dkmORzA+yQyID4PoHvq0TB8Ml3EvJG18YWm8Wvjoj0jpku1srj3y4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzck4j2tPzkiOMCGKKK7C2Ti7sJfgkYEHoG12P5YKCepFIq9Ixw
 HhgdAqx1nAH4Kh1IaDAxDhlK4jqh1ZcKSDbjcmqsMwsgdQRjbiOBVEyERSnBKUSefNhOtXBX9ZN
 ppPUm3hc0frNP7Y4LAimEI2sRE4CZBUf76qMw
X-Gm-Gg: ASbGnctOlfI97RfDsFdWqfsiip1ix1MJyUMUppLJxJU2fizbaZd8rKy6vTIe6kSXKZ0
 Uezr95oDtQl3oHVANzJpmQxYNCLJt3ZIzTUTIJU0=
X-Google-Smtp-Source: AGHT+IHhGjVj3sRKredGcM73Y31yFcj232/00X7rTsRA2b2rft1H11onK5zkYaSzeyaRqnCoDsxZ7HCfAeu/ar8+dsg=
X-Received: by 2002:a05:6402:4405:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d81dd83e12mr2478542a12.2.1734667614643; Thu, 19 Dec 2024
 20:06:54 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:52 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-5-sjg@chromium.org>
References: <20241206023626.2456858-5-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:52 -0800
X-Google-Sender-Auth: aQOackPuBltAg8u8iC2o14ylkPw
Message-ID: <CAFLszTh6O7Psq98PYh3TaAy_QR=JNbJFN5r3fSEnxA5X0bR+Kw@mail.gmail.com>
Subject: Re: [PATCH v3 04/46] x86: Move x86 zboot state into struct bootm_info
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This structure is supposed to handle any type of booting
programmatically, i.e. without needing a command to be executed. Move
the x86-specific members into it and use it instead of
struct zboot_state. Provide a macro so access is possible without adding
lots of #ifdefs to the code.

This will allow the struct to be used for all four types of booting
(bootm, bootz, booti and zboot).

Call bootm_init() to init the state, to match other boot methods.

Note that some rationalisation could be performed on this. But this
is tricky since addresses are stored as strings in several places. Also
some strings combine multiple arguments into one. So to keep this task
somewhat manageable, we content ourselves with just getting everything
into the same struct

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 29 +----------------------------
 arch/x86/lib/zimage.c         |  4 ++--
 include/bootm.h               | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 30 deletions(-)

Applied to sjg/master, thanks!
