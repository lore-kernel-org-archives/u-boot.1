Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA24DC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 18:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6AD81671;
	Mon, 27 Jan 2025 19:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lMhIFoCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5AB8169E; Mon, 27 Jan 2025 19:47:05 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695F681292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6ddcff5a823so35511076d6.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738003622; x=1738608422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDDJIgOP0qtGL6TXxxFDPJCMklhhCq9oxfU2ac2FUmk=;
 b=lMhIFoCxErPWB6sGbP67200X3CCyj9LnMKbur7lCmabGm4TqaZ4YUXlDTB/cmkw1nl
 fM8x6EBq2FIorQ1Y9cq/1hReX8wAVKnztL31uRyD7vgml+O8G4Ub1s7PFQjhyeX9HBmU
 1UWFP4ozu7wd6AGyN15Wv6gtciGvhrzOOgr7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738003622; x=1738608422;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDDJIgOP0qtGL6TXxxFDPJCMklhhCq9oxfU2ac2FUmk=;
 b=DgQWGI+jjTIKAWm36hp4011EXl9F9fjbyCKwdzZ5KUg9uBa2SFZwu73SgKnKk18NO6
 tLY15EHna3oBZXQB5YaI4I4j2fGtZ1E4TxlLMkxhYSVIPekwsr+WyFmyamFHsYMR5wOk
 i1I1unCjkDzs4QLlVQ/836ONPShvDcs8B1MxB88ETeTktoIRWiE6mbB2HAiX+p9zr/i3
 SfzlDzhF1qaFsL2ywTfeEdqVEmHr1IPQi16yPydgg80ksX3RB/aSFtK/Lp+eZNal0ogW
 0Yz5ERdhMPdZjZOaOdazdHiNuWCoXsYUM8UvjeNHPNS8GwBeUcs1O1eN8AJK16cGsyUh
 6Mqg==
X-Gm-Message-State: AOJu0YxfoCtmMF770aNVK4Yx9AJtlY+Lv+hZApA0lqZn5ZIJzAlrQQjm
 giluDnAmGXjPz4fqLvM+cSHclH9ON7Zc/kKJkULB3XtrWsXgFn1UpkX3s8KgMsgkUxvRJJP/fNJ
 B
X-Gm-Gg: ASbGncsVcllLlUVNpEB2474CdjIH1kmPMjY2GJusBi7Q+44kswM6L7/g1XTgBWz33dB
 PZgrZBWcUlbVv4t9q52dXL/5K6ZImdhdJY98Ir5pdyEsx+0aG9jVWN+nZTohU02QgjR9PBYH3YZ
 D90KS6nYuBPI9graBs/1YZx7T+O8qB1O422JEecZqNTeErFV9uHb26CLFt9yhrb1pBqzdP9wZ2G
 xvTrEdspBxxrY5dO4S60KD/nKsgh13DvOPfCkkrIf7ayyeIWa+9voeONrhjIxq/mRdGRjAklDOe
 /9U=
X-Google-Smtp-Source: AGHT+IEf2qRFT3UbnLzwGDCvEaNxWgl/rpMVMUYlvNp6q+jS2dOkEVpNRjSQuxwsgq7a5aAHUN82vA==
X-Received: by 2002:ad4:5ec6:0:b0:6df:9740:68a3 with SMTP id
 6a1803df08f44-6e1b224c029mr715440246d6.38.1738003622237; 
 Mon, 27 Jan 2025 10:47:02 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a87bdsm36937886d6.77.2025.01.27.10.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 10:47:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Simon Glass <sjg@chromium.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
In-Reply-To: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
References: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] test/cmd/wget.c: Fix loadaddr rewrite
Message-Id: <173800362090.1649283.12780971276006858460.b4-ty@konsulko.com>
Date: Mon, 27 Jan 2025 12:47:00 -0600
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

On Mon, 27 Jan 2025 00:57:03 +0100, Marek Vasut wrote:

> The $loadaddr variable is a hexadecimal value, not a string, it must be
> assigned using env_set_hex(). This may break follow up tests, like the
> dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
> set $wgetaddr variable which is specific to this test and use it in the
> test.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


