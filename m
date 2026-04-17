Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C8F436B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE17B8428C;
	Fri, 17 Apr 2026 17:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mLGIOKA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECF783FC0; Fri, 17 Apr 2026 17:52:38 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3161B84314
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40429b1d8baso419271fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441155; x=1777045955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3pGgTB0iRCthBQBnUEJgzW419P3iN50hNKJb+8F1OA=;
 b=mLGIOKA/AXYlUbBD6naQPUytkLW/dTSWZ3nAPmXvhevi3Sbj18eslLdmpWYq7Xjn47
 YJE2ncSae2w6O+PfGuRivOtpHfm8DaFT8XpGOcBaqa2ZCGiapMJhmPgGW0Lo//vTOx9n
 usTDiJGSWUtV7qGg3yteZ37uplV87jDKaH1IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441155; x=1777045955;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3pGgTB0iRCthBQBnUEJgzW419P3iN50hNKJb+8F1OA=;
 b=SPaRS/RwZachJsSqMO1Sm3CrxlUx3W2TKfITpoaHi8ePCQKuDqj/lioPNLXqHxUg7W
 K7cv3S9eY1LdBcZ3cAocuTJz3FR9A8EFG3hnHo3XRqe0HTcCPDTDuZFTV3GGyTt6bU8T
 4VJ0dD7bYDpVGCO4kchqDo7EVM8q1RHA/xphCvEaGmZGX5iO9/dX0OK17D1vOsy8TW7i
 Iftih/ZsXfNwWIwwXZJK4aXb5vNTVzsGlsKyBmmZhjDRBe4VM8FKcKT+qRHMa0gI41kA
 neOHnPKKjhb6nB1ax/Po7R69bSztAyoQ4DCnn36lfNai3hd3lky348OFA4IDr8kvr4/E
 guKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WptPZwmfU1uw32NNCEfbq+yu3WcVJL6o50RgaiDkImCfF/kkK1Kluho+NWG0LuLnNuSKIxoU=@lists.denx.de
X-Gm-Message-State: AOJu0YwzBfoldWkhITnO2m3Am5QcrqZ97DsOvJQOTLIXto2R5xeAbHEF
 LNGCUj3ZpTIaJPIrk6xoIHUzIJzKPWmabIs/lJsfztj+15QOBtYPMy38+nH2aXiHtj4vkTXpY4X
 5WqbxZ22PRg==
X-Gm-Gg: AeBDieuncfAJFkv6PngW46clLz3+MmJOhHMXxeNsz1Rgn1rA2d87ocpVGdKTGgNMM/i
 NWL4syI2dAYF8HkBgcZSxuPw/qndsbdBDOxDfJMjokeTK0JyAbJVoGQ+VaGSEELiLDiyoIit3Jb
 OlV4KcZ6RB4/NZMC4kVPbevxrk9h1ZeZDJBBrO0xNJho2g87rMJ1YGqgdDRDId7qRhEqiXwx497
 xbQ5NyNyg8BmQPmqH4raapBQtIRSHyhJ33F9wEu+RwS6cfIQ74OXQHhH4BiFRfGYvpsNt0BFBrD
 rJrFQiSi352BUWo2HehzztS5zvANZ9TbDj3QTxLFontu5TUtnDrMkybOsZ/MmaYtwVnmx8AxaxC
 F2lk8D7ur7bHq3Zl+8nOoW2T0uDeS4dFXsY09S+nMrdqIZmxOU35ZOZj8tPOOx7INyFc78TUXX7
 5KAq0Y5QqGI4VPvJVesCN5XsIjj0UBJXJlGvajiaiEws0ia4WVNEcxGN/90jdNmv0pKYQa6281c
 KoR5XwGehgLEV2sPNOpUYxKDP0Tu6/Gxq9AvRYybKL5nsmwFbUU2NyGzJVH
X-Received: by 2002:a05:6870:2f09:b0:41c:9be8:c367 with SMTP id
 586e51a60fabf-42adee0a54amr1677318fac.36.1776441154841; 
 Fri, 17 Apr 2026 08:52:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vignesh R <vigneshr@ti.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
References: <20260403-spi-nor-mx25u12835f-v1-1-c9ffdae25d8d@baylibre.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: add flags for mx25u12835f
Message-Id: <177644115393.690930.1041726272837665442.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 03 Apr 2026 15:31:03 -0500, David Lechner wrote:

> Add some capability flags for mx25u12835f.
> 
> In particular, we are interested in using the lock feature. According to
> the datasheet, dual/quad read is also supported.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor-ids: add flags for mx25u12835f
      commit: bc6c4ee8d4309af706002a8d8b6bb2871c07fca2
-- 
Tom


