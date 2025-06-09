Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6050BC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737678144A;
	Mon,  9 Jun 2025 22:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jADlBskN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C34B80E9A; Mon,  9 Jun 2025 22:13:32 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EC182B0E
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 22:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4067b7d7e52so1152482b6e.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749500008; x=1750104808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+7t9V9I20wcKDbOCJ6PDmWL5IzfqFxKN6olRFGHfME=;
 b=jADlBskN+TxPrNxjUj+/Whn0ApYeeT729X8HMT5b9myGKOJKQdJCBKqXQOo9/TC88r
 IgVkpXXBKJU9BwAnrIygIN55/OjDGColLZ4wKVcWWL3P3ErVfDT7kL9lGTkcFGNT7s6V
 mmW1X5QeXr3CwAZkeYYK5LUi5zDF02Waf5p7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749500008; x=1750104808;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+7t9V9I20wcKDbOCJ6PDmWL5IzfqFxKN6olRFGHfME=;
 b=NYsNgE0Iia/NM96ByzYoSckmXc5YXXHFQVeDNNFTAWIzB2k1qV9mOStGuTag67ByIw
 hXld9GS8gcRmEzdGlW074dwtjMqQ16GQ2FebuMw1hxAp0dmlC2iEBbPEDkFFyML5xEqv
 15OcozQw7Rywj+pmsINdcYRXx4jzHGhy4CrGt2NVrXuLvlDlhv2BNIo/m/S59RO8/PB4
 vZnhHKjJLFo0r0J8ZjQKchGbPz3SDoqj6JqflHen8iUIf5lRtjFB2mV6nGvjn7ZXiEv+
 qD+aMhh/6YqY903XXjSdNHjIdax7Nb1aMoYHN5UKp/fcDks5lvktufHgeDBD7aFKeMiV
 0Amg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1uuec2ZC1PFPuWeu/JEcGbxUV0oscIH3zTnNM4kDUCMYYc7TA0J4Y6FBm2JDyC9bfvrR2M6o=@lists.denx.de
X-Gm-Message-State: AOJu0YyvF16pgQkK+cqNREpHwJQKIgQBP+UzFifGjg/aREd0DO+hwuxW
 U5RPF1DCFDns4hlvGuJTlJ0NVkxrmREFPQZh0s8QaDJW9bCQ69KbFGj4Al0/kDFNtYw=
X-Gm-Gg: ASbGncupO4w7sANLXN5m+BugT7FzflLA299WQdAmUkhOE42e/9tisRHZKDe991yjwra
 2eTrzQHcjgcZDI9rXiua3DOMioom8flOqHxPOtRP3KrPBHGx/8V6K/N3UHiP4zoo6Lq+k5kJ/Lg
 N8f9lcSOLgCT4mP33wdTbMt9qCode9qJvOUvCY6WcMXTSU011JEjxJix3oTcLKSA3+SzARTxU2M
 CxGIcBxHjK5l6EUNEz/dMd0APnhT2TWn8Iv9haUibXKbgWncJHyG6Cyhy7R/3+bYdR4GotkGjbw
 UCLRJzP6tPTc4OZ8exaxU+eGSr+uIzyPnja/KFJb/SyV4JBTveeo+80ZtibPo/UF4fUiyH+6BEI
 n2BQ2Ayw7N9SCyLC4pcEPeg==
X-Google-Smtp-Source: AGHT+IFmERXOvMBBlsJuiNZ+DgzQtaWUnHL/RYaFQ5MDiNyOcepVtdyGKTpAv7SJdoRDYD98K8mzrw==
X-Received: by 2002:a05:6808:6b96:b0:406:7186:5114 with SMTP id
 5614622812f47-40905238d00mr10220134b6e.36.1749500007930; 
 Mon, 09 Jun 2025 13:13:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090692e00asm1933503b6e.3.2025.06.09.13.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 13:13:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: gaurav.jain@nxp.com, Fabio Estevam <festevam@gmail.com>
Cc: olaf.baehring@draeger.com, peng.fan@nxp.com, tharvey@gateworks.com, 
 u-boot@lists.denx.de
In-Reply-To: <20250605105244.619858-1-festevam@gmail.com>
References: <20250605105244.619858-1-festevam@gmail.com>
Subject: Re: [PATCH] Revert "caam: Fix CAAM error on startup"
Message-Id: <174950000696.721141.2568172199816233078.b4-ty@konsulko.com>
Date: Mon, 09 Jun 2025 14:13:26 -0600
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

On Thu, 05 Jun 2025 07:52:44 -0300, Fabio Estevam wrote:

> This reverts commit 159b6f0e119962ce5da645f548cefe9196c8778e.
> 
> Since commit 159b6f0e1199 ("caam: Fix CAAM error on startup") the following
> regression was reported by Tim Harvey:
> 
> "I've found that this patch causes a regression on an imx8mm board
> (imx8mm_venice_defconfig) where the first call to caam_rng_read fails
> here in jr_dequeue but if you call it again it works. With some
> debugging added:
> SEC0:  RNG instantiated
> ...
> Hit any key to stop autoboot:  0
> u-boot=> rng list
> RNG #0 - caam-rng
> u-boot=> rng 0 10
> caam_rng_read caam-rng len=16
> run_descriptor_jr_idx idx=0
> Error in SEC deq: -1
> caam_rng_read_one run_descriptor_jr failed: -1
> caam_rng_read caam-rng caam_rng_read_one failed: -5
> Reading RNG failed
> u-boot=> rng 0 10
> caam_rng_read caam-rng len=16
> run_descriptor_jr_idx idx=0
> 00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f.....
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "caam: Fix CAAM error on startup"
      commit: b492f9520c04b1c581f57735e224612155f66780
-- 
Tom


