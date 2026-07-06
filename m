Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E8C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2098846FD;
	Mon,  6 Jul 2026 18:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Isp8XDW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F398490A; Mon,  6 Jul 2026 18:40:13 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FFE846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44d2204d195so561396fac.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783356009; x=1783960809; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ulm7wupbc5omcF12z5fNqofkZqiPAN88WltN+SYeDEI=;
 b=Isp8XDW1Nu7ZDZJx1AxQzOnDGGaeVTxQCBk9NfUgpRtctcnoQ0YqqPvCd01MBR94wG
 T5kxdbcrn/LmsK+Jgc1vsI2rXx9LJVHd7FcZzrDvKhZnT2H9j7alg+2TpWVZgKS/elXj
 8X8zHeMJ/qy1K7hW/Omi6O8+O6tUqe4cmW06Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783356009; x=1783960809;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ulm7wupbc5omcF12z5fNqofkZqiPAN88WltN+SYeDEI=;
 b=QdPWP9wPQ4n1zt7QYler68267if9yqV/JQ7DmhQh+HDSv2lcYDen8TabRKFAi5s9UT
 nL/FmPtlMNUveFxlXLSixYCOocuKNHqbhRWPGSDLWIpbM0zrHxSRl03aZZog6Iuf+Td+
 8xfX7bXK4Ai6B51Z30AKQtvwjVAymgUTtAIlix3pVCw8s1E2JidntrR0ksOH9CFuLgBG
 TY2YO2gd7XiiyaI4PeP82Ji0yqw5qCGZaP3mWj2l1x5NBpT47vcu+NY2wC75vXCzYGH4
 vE0VTAtW/SiGbHkVz+SxJau99hW0jF1ivC6MvGKR3MoBFusChLB1rkg8EQsfbupx3LZV
 LYUw==
X-Gm-Message-State: AOJu0YxnBv5wew4rg4SBCz1A5TokCqekumGtYoh8ilo5qdxL0Q8GOgiP
 gFlvGPQaqEpxoO0wzdSbO5X9dyfnv2xIFdJhzlhO0JH2ljbQ25RwD+aSn22NJeuMCfo=
X-Gm-Gg: AfdE7cm3rKp4kFgDPia6Ey7Eh5ITkJAzd0mBTkATN/7xouLRSq9bzdCkUnnNR0fs+gN
 ZJK7K7jzKlfcsy9/rb3SdZBPWxXdpNFHa2sESOdqIO1vxCbeMm2b/wU7JShHDS95G+3LF8NPIiQ
 tox6Jb8mjA8pzM7FzX2BbOX/8MiUb7AQrn3gn18OA/8U16vPuZnpnM2XGj2bU3QKxBtOXpeD1J7
 YqoNg09hMzMBnfV4JDfZk3P1dLfejNS7mYNrSZGZO8DbKBJVOkDR0dwleA7VCYfBAB4eaoBNOCF
 cOof417o2dx+ZV2TDamEhx7wqiOGzTrKTicJsVPPc32TBAd+iMlqf9B5ht5kcipdtcumdcqDr9H
 dQiGwca9ay8Gn5csKrnw0qmmSyPIWUJunxEYv9DBV4qJxpa2iX6oNUHKfDXdfm3NkDs2qKBte3F
 YQnQTAGYOszcOj2iLTHaR/llV9Risp8qrmct+lqh8ox6jgpDQ2FBi+MHXooWFh/k7yp2EhWZj6F
 B6fey7Szgg958fscUHTP23m5/z3bvRqtYC7
X-Received: by 2002:a05:6871:3319:b0:43b:3d67:5fa0 with SMTP id
 586e51a60fabf-45106107a2emr746076fac.33.1783356009265; 
 Mon, 06 Jul 2026 09:40:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb67156csm11355120fac.18.2026.07.06.09.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 09:40:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, tanmay.kathpalia@altera.com
In-Reply-To: <akt9dcQaHAocUuqA@nxa18884-linux-1.ap.freescale.net>
References: <akt9dcQaHAocUuqA@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2026.07
Message-Id: <178335600859.1167284.9166640625546576671.b4-ty@konsulko.com>
Date: Mon, 06 Jul 2026 10:40:08 -0600
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

On Mon, 06 Jul 2026 18:03:33 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.07.
> 
> ----------------------------------------------------------------------------
> Fix redundant 1.8V voltage switch on cold boot with UHS card
> Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode on SD6HC (v6) PHY"
> ----------------------------------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/30621
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


