Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847C5F41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B97C83F75;
	Mon,  9 Mar 2026 16:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y7qr2KKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FBE83F75; Mon,  9 Mar 2026 16:10:52 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44F383F82
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4171ff4cb2cso644307fac.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069046; x=1773673846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXQPQf4MsG/Dfn0HKiaXxCNE8UhNXflcPpbVvy8t8Zw=;
 b=Y7qr2KKsdmpkMtLxn+/TNhDFenx4I+uots4UX+O4ePBFpMvKYxGK7e06f+x+S1/eFk
 6h6T3X4hq4RSu7vWPU8ayi4J+D/kjnZfPPb5ztyYJ1JUwQke9wip/K7Yf/SRULKi8cio
 WTRyT/1ysvQI6AnPqpW/h8rcdG5frm4PdL62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069046; x=1773673846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXQPQf4MsG/Dfn0HKiaXxCNE8UhNXflcPpbVvy8t8Zw=;
 b=N4leQVWS95Vjjkr6ZZzFTcXiofgf5Vl5Y1RzHdpgOsqy2itN4NGxpsX5ysb/ZmBBx5
 frMIvfATUB0WuDxoSWGz5wzOIG4mE35UviVb/eTfLt7OSFMVy7A9JO0v0/agv8Id2RLs
 nGdKSDSvzSMT2X+vEUgxPrJZVYyjOxNG1w5hBN4t4p4SD6Ip9cxLfV+FJS7kaPw7jh3n
 L2ZWSRTvnT7onmv6NLlR7DF1pYNkZvWBKvLhyeQphqX6V+5yQJzcLyErDlDbXAy45FWr
 Da8xX3WA+oeFoZex0NkR+84suYNQ9GEcEjqb4IS7omhH0jn182kFPtJ6yPD0pGbM2Z8g
 I8gg==
X-Gm-Message-State: AOJu0Yxc5p+t1Jk1J5MoRYA/tXmHDvg6RQPEe7xlXZEsMo57lCB5dgOS
 pcx42euIvmbXQ+CIR01pGcPtOfgvNp4Hu2ZjqoTwRcwwu7eWYxI2GGKO4HXlfjF0znEYfR3kPGW
 8+HEZ5fc=
X-Gm-Gg: ATEYQzy6nBzR0LZO4VItSJybGP9h7JXewCV9QloGfWTaDy0LYCfDOxktbt5U5tJxNE/
 gfxi7Y01etyncGhmhCvsNRN+lzH0Jd56vW6wqHjW973suBXltX59tp+41HDJOkhkwW2TT3xW6mi
 +GggxSWC9Mbe4LCVP6GdK5ckQf7CpMefdZGFHuPp9TYHcbPKbkVwJEoP15vur0AULrJ/BMKxE26
 d4Pua6Y6DRJrozKt3dGiFAMq6gTkd0jLUn90Yxp3N6jCpVKra8pkaucWO0UTHbVSo9cnRd4rUIv
 Hz+AwAHZ93Re7DgONZSnOucg1AJjfFFa386AUctzOGiPId7Wvbw+HflvsqzTVYBH/FAtqKa94Dc
 iqKvywXihyL1KrflWNvNmgUMlap1gVRW9bGiNNK4vGteYBUfdulnCSXpuv3sfX3Fgm4gE9KW5tG
 /jzI/aXGizd8b1nUxM44qb4HmatCZvi0z+33pGDL36xpz/c4iERYIuBms520FdNTz2L59Asq42q
 OYgxnRRgkNXD7EcXjdVv02Tyeb+1LrnLIcL0nV1JTfi
X-Received: by 2002:a05:6820:81c7:b0:67b:b718:1a49 with SMTP id
 006d021491bc7-67bb7181bf0mr1207815eaf.54.1773069046504; 
 Mon, 09 Mar 2026 08:10:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e65b1cacsm9376128fac.8.2026.03.09.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:10:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Martin Schwan <m.schwan@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, Andreas Pretzsch <apr@cn-eng.de>
In-Reply-To: <20260218-wip-bootmeth-rauc-tests-v3-1-64aeea6d1032@phytec.de>
References: <20260218-wip-bootmeth-rauc-tests-v3-1-64aeea6d1032@phytec.de>
Subject: Re: [PATCH v3] test: boot: Add test for bootmeth_rauc
Message-Id: <177306904585.2117441.10016162647069280239.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 09:10:45 -0600
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

On Wed, 18 Feb 2026 14:35:07 +0100, Martin Schwan wrote:

> Add a simple unit test for testing the RAUC bootmethod. Provide only the
> very basic tests for now, running a scan and list, to verify correct
> detection of the RAUC bootmethod. More advanced boot tests of this
> bootmethod can be added in a separate patch.
> 
> This requires another mmc image (mmc9) to contain the following
> partitions:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: boot: Add test for bootmeth_rauc
      commit: 36add050eea439f0b2a15e4ea0d3a8e21216f159
-- 
Tom


