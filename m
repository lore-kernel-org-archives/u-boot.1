Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B22CD6E79
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166F783EEF;
	Mon,  8 Jun 2026 21:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="teQoP/yV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB43847C3; Mon,  8 Jun 2026 21:53:24 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB67838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-440dcd6406aso1679005fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780948401; x=1781553201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FehPPQjxR/eqwyBwhW1gbCqGyAIJGCP3bgjEf6aTOcU=;
 b=teQoP/yVhBxeuN7M4AFtrPSjrC580gYZWsucpqqZi751hNVxvFJG2/65wykZDgIh1r
 TCyZXbDuHTtPi1kKbnGPYgyBhsf4RZNEPI9agTYsVW7q7nJovS7OhCK7pEraCf4984wS
 15u62iw+Mpk9fbKXgcF2qoJVKB3vH0s2MNOXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780948401; x=1781553201;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FehPPQjxR/eqwyBwhW1gbCqGyAIJGCP3bgjEf6aTOcU=;
 b=crBJH4+GHirzJAeFpiJ5BArO0owmKrlgXO/b57EO5/pvHgjhDYBjdfbyUmIMWDW2Jm
 MNawTBrC0kBYZ72XsrYlD8BidB9dYpebTye/v4hkXyU2fnx8GLKByig5bPYbhs44xNHi
 T472n2Eq43Iu9Cr4/lG23kyKLIdzUQAjO0bteoDDEFrUGo3OJ9CbSL6DI2prEQeQrJ27
 gUB7J5/UpiebTQ1cL9knbNmbXpwozvqAvfP0J12auLdH0lr8EkHMZgYJA7LL5NtksSyq
 m9PgZwQwBaURvYNuGswS+3FTMi0ng6kHDz3c3Qc/sVuyLIZLYaSSS2OsZy/6MqEPlOyu
 kjRw==
X-Gm-Message-State: AOJu0Yz36xgdzYxvbxTq3IQoOzdcFnTzOqT4CXjWVw8/hp+NfyMsPPTi
 11NEJw1lPkoepz3sTITrrgjiAAic51BChtYOi5aiHLdfAWwarKAI1o4MjYIbuP+r7yM=
X-Gm-Gg: Acq92OFL3SqgSimwLvuy/dhz56g2PjcwUpjr24Sr5whs+SdIFQhAMwz0FeSuCc81jfV
 dBM/KKFbKrnj3jNwOEKwJ2eBFh9Q+itVVbNUg/h8JGENo9CDD2LT6nTqMdxy7ZEQxs6XvSyZXBK
 MlpXD1UwSeKZ7qzB2ts1I7OT5j6JoGhoZdwCdDdHUiQZVkhnBFuWvNbV2QHJ98NL5Y0O5L5iCGL
 eJY4MRVV+zCIKfrg1LeRnYq1BfB+ygTyD3AHDnjSymbuoY9lCEYuniKTOm3DUFIEQjNxK1jbx42
 t2pz0cs6lw2hJJ7pHX+UAXHMqSYJlig2qyE+V2NWYlUevynswu91gZ1bUTvN/nj0cQHTjkjfItq
 +YOkjdAsx7jaLcCmb7UFRIRQZNMfF8bThOqZONdo/G+bYkf7ti5uF9Pp9fUfW/jL3CDMh5Y0/Qm
 afi/HvcikzS1qPfc+cwoVGoEa4hGlUIeXbZ4IYw7CS/5CgCMK1Ykyjgx5EnvCcrmP/U2cENlqZQ
 yAe0jb1gYPVMJBz3D3s+wcTiqyBQae/UMlgl0ArLwZJ2cN/dLVwuP55GgHR
X-Received: by 2002:a05:6870:16ee:b0:43b:6dcc:b364 with SMTP id
 586e51a60fabf-4413d6b1531mr9412536fac.16.1780948401366; 
 Mon, 08 Jun 2026 12:53:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d8295b38sm16484374fac.10.2026.06.08.12.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:53:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260604173330.8586-1-marek.vasut+renesas@mailbox.org>
References: <20260604173330.8586-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] lmb: Rename LMB_LIMIT_DMA_BELOW_4G to
 LMB_LIMIT_DMA_BELOW_RAM_TOP
Message-Id: <178094839999.2176779.4997823839194655661.b4-ty@konsulko.com>
Date: Mon, 08 Jun 2026 13:53:19 -0600
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

On Thu, 04 Jun 2026 19:33:15 +0200, Marek Vasut wrote:

> Rename LMB_LIMIT_DMA_BELOW_4G to LMB_LIMIT_DMA_BELOW_RAM_TOP
> to make the Kconfig option more descriptive. No functional
> change.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: Rename LMB_LIMIT_DMA_BELOW_4G to LMB_LIMIT_DMA_BELOW_RAM_TOP
      commit: 3dd149ba17cd34724bc535d6de290de6e74e177f
-- 
Tom


