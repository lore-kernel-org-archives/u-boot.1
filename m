Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A840DE69E8C
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78828952F;
	Mon,  2 Dec 2024 20:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cNlScu5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0250894E5; Mon,  2 Dec 2024 20:58:51 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1EC88E3A
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 20:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71d551855c2so1895886a34.3
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 11:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733169528; x=1733774328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICLlt6PdvfaVcHvliLY4NPDRkUXmuHQj27fsxiSIdZ0=;
 b=cNlScu5YTOihKqEXlGyP10Qebr77p11BOUqvtwkETGmprTCuCXPp25AzHfd4f+CXUp
 S5lPtY1RpchAqAtYHtOEThMddAVeHVdEiE0xZul1AboayzjQu9C+dtK5QcVG8PfB0eW1
 dZm6E6j1jYrIYvEkRMyh5tr/FkiKOPlGR8xR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169528; x=1733774328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICLlt6PdvfaVcHvliLY4NPDRkUXmuHQj27fsxiSIdZ0=;
 b=iGmpRSvfQNElk1rfgfokv25AW+RCsQJTUhtjJFPp3CVp0RTARGwOmq6Nn9/mpUUUIC
 cFdLGtEuyaSAIPIofHFy73A+LoXdaDY6MMdi/Yby3cjqDvJlfjHx6oiGHgAMvh0bt6/o
 lA2jgMD6UgRGJz6Qc6Wy5u+6NxjIYp707YoYV837aLO8Gb9VE78UzLj9bzJE+zq3wPc9
 2v+lYjXkY1NVMQsju7FoY/jjZZLkp/uu95LCC62go3iVb8D7rDFR3RafrAXxMk+kr8mM
 /Lb/6IqNFz5OVwQnqqdsl76q/qQPH6wPcPCBUxZrXbgq5S6rMKJyEZ1JnXuWaQ2q6ran
 nXtA==
X-Gm-Message-State: AOJu0YzG0VSVytj1Hjf2ITP9UXp/awDfZedlyjxC/oW/CMYHkHsM671H
 FL8CBZqsxfH90Q70hHb/ps9l5pv0Z776no8PAf62DLh7uu1gN8dcWGJgx2hT8wE=
X-Gm-Gg: ASbGnctLswcuv/U6t75Yahge8UesCbCvCDUSzSKgocAJrIRPlmME7gRKcAl/twnpCtC
 sUywz0T4y7BnqHm8e2RakWoauX2gogGvNjkMwk2XqqZXRqs6y9D3Nacktos8rJFTr3yyWfTXf1b
 HSduIiCIagjPi3YjBTslE/uUQHfXI2fW/xHybiPUXTLUL0obm081ck48VUxvsxUwjyg/dq3ROtS
 bEM5nEN6JURKj5YWeRIfs6AfzMfdCstjGT5I9sTeE8tFud1
X-Google-Smtp-Source: AGHT+IEtmL2Y5xOmkpdiMdQJ1kFg8AO32cYVLMu9uYYdMkspod+vEF+ijq7ZZrbMiOLsf01Fj7wbMw==
X-Received: by 2002:a05:6358:4b01:b0:1ca:9b61:af0 with SMTP id
 e5c5f4694b2df-1cab1605686mr1023243955d.13.1733169528151; 
 Mon, 02 Dec 2024 11:58:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c424a31bsm52870641cf.82.2024.12.02.11.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:58:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
In-Reply-To: <20241201144240.1664398-7-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-7-sjg@chromium.org>
Subject: Re: [PATCH 6/8] binman: Avoid skipping binman_init()
Message-Id: <173316952628.3421598.18021076360127279829.b4-ty@konsulko.com>
Date: Mon, 02 Dec 2024 13:58:46 -0600
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

On Sun, 01 Dec 2024 07:42:34 -0700, Simon Glass wrote:

> A recent lwip change stopped binman's init from working, so it is not
> possible to read nodes from the image description anymore.
> 
> Correct this by dropping the offending line.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


