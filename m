Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A9C83F1D
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 18:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96AFC805D7;
	Sat, 12 Jul 2025 20:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jBq5uacp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE1E808AF; Sat, 12 Jul 2025 20:03:35 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03F980050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 20:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60bd30dd387so1518512eaf.3
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752343411; x=1752948211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXg3Uk6e4rX6fiBnaMUucFspVUm2ojngctQviGHXG+0=;
 b=jBq5uacpnT4n8CB327WmB5C+53aR1hg7fZV+sgl3clsh6TB2phtCyhD9L9ODldY+P4
 uR7s+jiPu5LX1Z/3G8JFEPwOjoUdDUwqbslfpwjT+6GVvHVZqFddrdGPXLX1IK5KwtbC
 6OfVnQr74WZILZagWfUk6/3fp3jWXBjummbl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752343411; x=1752948211;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXg3Uk6e4rX6fiBnaMUucFspVUm2ojngctQviGHXG+0=;
 b=rbyWPkVS8xA00fqvwH/jykip/yhyeISBuDzCDT2H8VnlGHsfAVy9PflhHnkjAe1q9K
 VFwe3f/CfgN41MRUqeiOE0MYDfKDa6EtSTOhfhcnWZni6QnsNt5uM/UDvJz/oegJp6JP
 DPc776Y1P+ZWUj/puHEM5H6VVYw+Zcy49kKJnTLxouQAeJIJCDJmDJ5gxjIPF26vpIoK
 EV4/UzMcxuu+vTawZzo7l2SpF13wn1TXrSAO//1WUC00+3/OO1tq5qAOPNwSnlXerbjX
 mEcsZVo/7pjqUZsR8TI9lXflzBLfcEFty1DORzn9zh/Rqnr/PIS2APs1sSun2UBib7hc
 YYMQ==
X-Gm-Message-State: AOJu0YxBurwoT0OqO9vP3Z8+x5rGqP3Jd6HVNIBe93BKgzNIn00CMvoz
 WDXewvJYR8VurT8nXXtYm0RV15Zm9dIQ4imMWHBbaz0TDODqmN+6RTNL08a7bu296ps=
X-Gm-Gg: ASbGncvrmBY4ElbKd1+VcTPPsUiykvQCPC1KJXfltEEbmRccA3xv7a1lWxyR4XMSHRf
 Tox7z4SsfDk4PFmJTUngi+lYv/tTAcQGzJpSBQkaDHj3oiiXR4muS6zuAJKiOSg4JR8SOOS0Gpw
 EmavIKuNGyj7dcrgzyp88fFtooTsEzrVqbGo6kxX1vMqK29DuTwrpumJR8k0yoqK1pvlQ4SKKet
 8GUVHnWAThwELqgOT1FSFf2mPhNloFEDyQ8KgfsouRtMMx4g/sK3yP9Y8ByzLPKVbPosYRLLZj8
 h/RWXou1QJTc5Kg1ldV2nQ0oXssQINyf5fIakJM+nCGmCn+DvGfm2NYI12HSum0M9EUnoMIfAyx
 gB6A+UrJSqdHZ/9jEWlLz8Xz1jgKsFW8o+sfT7Z14KtSr/0MS4ElxuHo=
X-Google-Smtp-Source: AGHT+IHSUQ6RBK2I0SUoNFWIJNf2gUXIFF08z02xFV3e6NOiQQ8r/pLInYR3AN1a9ikTfPGxzYlOUg==
X-Received: by 2002:a05:6808:f8e:b0:40b:441e:3a5f with SMTP id
 5614622812f47-4150f6b88b2mr4821810b6e.25.1752343411346; 
 Sat, 12 Jul 2025 11:03:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bcd27b6sm956104b6e.29.2025.07.12.11.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jul 2025 11:03:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250711085234.23659-1-ziyao@disroot.org>
References: <20250711085234.23659-1-ziyao@disroot.org>
Subject: Re: [PATCH v2] kbuild: Avoid including architecture-specific
 Makefile twice
Message-Id: <175234341036.3620534.17039080480632432616.b4-ty@konsulko.com>
Date: Sat, 12 Jul 2025 12:03:30 -0600
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

On Fri, 11 Jul 2025 08:52:34 +0000, Yao Zi wrote:

> Stranges errors are observed when building U-Boot master for almost any
> RISC-V board, the messages are in two types, one is about duplicated
> symbols,
> 
> 	u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
> 	arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] kbuild: Avoid including architecture-specific Makefile twice
      commit: e80998a77b97fa52e9321a56e004d8adfd8125d7
-- 
Tom


