Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B23C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 21:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3BB81760;
	Mon, 16 Jun 2025 23:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="amkZqg6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B839382B18; Mon, 16 Jun 2025 23:24:47 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CEF8006D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40791b6969bso3131567b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750109084; x=1750713884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsYcRivND7+/QysHE2jL3u5cCWdqAHjAKrtciQtjk/c=;
 b=amkZqg6z8INS9nY271+Qbjh3GuQe36HDeSfWyetB3feYQNxEVqZKak0DIQjTLmu4tG
 bbYKc554McmGLoE2iJgs8w39hgTVSIcdrYbZ0AuDF44xJlssBgSJcDAMiuSBQTY9bEbd
 vN6TB5SS4CCCwA9M8uPr8nsk3R3oYeMBLEz8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750109084; x=1750713884;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsYcRivND7+/QysHE2jL3u5cCWdqAHjAKrtciQtjk/c=;
 b=NxcuX/TZvjm0RRw7CHHHNx7p0WINznF/Km8QMj2tryGMQ8g/E/rUsBqdWnHQToIkL8
 F6ku0uRLTDWF3O5LjizuYvIfFL2sDt50kl8y+oIPwxgai/OpKTCQxet36amWz9q9blJO
 l49AySXaVfJ7ZsjMy412e4O3JaF/Tu+ny0qIPxjaTw+0v7gnnNiiEj3T4MqhwGoU7HQs
 SLN+HZPEGfA7NIfKBEbvrssxykowYyPDlK4+EwvsJOPUp4dYV3LNDefftlelXrByjpc2
 UpII8Er4Xh5mRUiS1G1qwTxJwFw847m2H34hFWCFWXZJRF4PzRMAdUh2ZLrbM4Qy5aPS
 HPig==
X-Gm-Message-State: AOJu0YyJtdzRgiRjZs/+RypdBoxgSXhTfjED7SHDyY1DKjRU56SewOxy
 VuNwoZD31iB2+e79zgJTEM436iFo7SXIFPTtKyPhT3guVk/FAbVtFrUr6599yf6UAYoYHUqicGe
 UDqB1Ado=
X-Gm-Gg: ASbGncs3hVJLVLBFfjHahKqBLroO5ooOgv6Wz5g6hHTTmFNn9Wuc5h+fp2SgfSYRrSM
 SP7G5Jm5oEYGk0XnxTlQCzhk0VXofKGTaysp8eO5rcnK3iMrDMCjwflRmrvvZEB615WJIBlvIMN
 HmyR2rSWh9Ou8zzvlsADoenHU1yXXzYj8G7BFxMna7AXruLZrw/YCZVtoJmfxZqpY6Lb7kaSApY
 PnIEMB6olIdWI4JgmX8L76lsgPXdtjnddBski50khtABIhl6XtfwKlJIadioh0HnPEbDXjdXmBc
 ev1KBhoYN+ez7dE7rakyPBrvYJsrTLWXUrLeOTMBOq6MlnwktBu4juAcAAOrRprZVm3KsCPwtzl
 6egJcAER27K6IMzB80nVIuw==
X-Google-Smtp-Source: AGHT+IHZt84F7E1oJgieCLTfrYf/tJQS9Z1OaoLc6bx3FHSoC+R5OrvwXnb7hl9DyXFKc9o8b7CtEQ==
X-Received: by 2002:a05:6808:1b2b:b0:3f7:d16c:e293 with SMTP id
 5614622812f47-40a7c1aeb9bmr8150349b6e.2.1750109083952; 
 Mon, 16 Jun 2025 14:24:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a74172810sm1630900b6e.28.2025.06.16.14.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 14:24:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Zixun LI <admin@hifiphile.com>
In-Reply-To: <87wm9bg3jz.fsf@kernel.org>
References: <87wm9bg3jz.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250616 into next
Message-Id: <175010908303.1299925.13471655729577875226.b4-ty@konsulko.com>
Date: Mon, 16 Jun 2025 15:24:43 -0600
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

On Mon, 16 Jun 2025 16:32:32 +0200, Mattijs Korpershoek wrote:

> Please find the following fixes/developments for next:
> 
> Usb gadget:
> - Atmel: Improve gadget disconnect stability by power cycling
> 
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26704
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


