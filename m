Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB12C531FC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 06:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD94405D6;
	Mon, 27 Jul 2026 06:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBJ5uyblbYdj; Mon, 27 Jul 2026 06:05:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFE82405F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785132343;
	bh=czOMgazdmE0OxSfwB8mBT1SdHRh2r6T2kaD+ij3++ME=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=D7qMtff83+kZ+OZn/LlAgIQQ2R2oBmxoKEq5hG7LINBbupJ+5JRewm71AFYmmn6F4
	 h3xMfxHXayiLI6+X0oFz48yKuqKlgpasVk8bpolMmIzvLI1iUzjow183KfC3zH9JhR
	 vk0XRuhx0LXQcsBBKkxQR/LOVNscuxBaYrIWIlTZR21+VpAEB2s1XCVb00pNVYqkJm
	 ZI3SRXACBfaGq+sg8jBIZUlP4gz2vCEO+Me4Prp+6958fFPc/yP3AYgirpizIv1+uO
	 Mf4747b9rSvKdPbNs7JOh180qURu13o242rau8C+Er2nyiD9HlNtIsNlh9mpO7gXvA
	 kC0IufyEWEABg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFE82405F3;
	Mon, 27 Jul 2026 06:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4B074C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D208A80BE7
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQa94GfmDg-3 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 06:05:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 156F580B95
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 156F580B95
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 156F580B95
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:05:41 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so2429081a91.1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 23:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785132340; x=1785737140;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=czOMgazdmE0OxSfwB8mBT1SdHRh2r6T2kaD+ij3++ME=;
 b=aCLXfahiNomUCBZIpjlM94mKTuSsqXITClfAKVqilMaylt0+KO07x/6ALItQlsFv7Y
 784pG8SNUyzlTEkGI+WQOLuQWanEsXG94W+wJYmJf7eo1AvMDMqmwVGZUcrDOCuEl8OT
 VoLx4OIbgojdRBL2TbWPzdOiEiLGonmTU9UDdQvLKNDuRG+3Cul/CDfSCHgfdbwpjbTn
 IxKdYmyYg4kcR3h4JGFVkG5QeU1f53ra/WRySxlrHaS3LPll9r+JGjhb8YWolGbuxbWc
 mfKXzfllp2e4J0ihjQj/Y3y3dbpqA5YmLdOmt3hXC5U3mFajlXQxcSKDoT4oTPmb12+A
 qIDA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rria0oSdSanUTkNVjO2CFrvH6IA+A7abbBpwvQYKfnyt9Z1utmJMZ3c2y4JonMDdhsA/uk4Mz0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxKcQXAlAKXFZPLt6QrLVZS/NHGIVUFyhgj0BRlzC974Rw9BsUR
 BPn/wnB6EHD9k6G6/ebT3/C/FDXkFidJqnTFcPTUEAPe8Z903TggzNIikuMO9KclxOQ=
X-Gm-Gg: AR+sD13B4taALP7Fm7lE3r2Mvle4Zk2s6VNHSHeuAgDv5qxFHYSKvDTrGmm5x7QvCHS
 MAFRO3Ko22DfG6AZQ8mXDKQU909L5vpOYIK/C/BRg1aJSMSHNEjm4JdB6MS5x+EjwyS49YkKol4
 ruSrtYc8SK1Fay5v8BFJlshzv9gCKjSHHthBXiN+TlHYJM0arBBPRWyClqvWPR5DGf12mixj1ln
 J2ggIHwy26cNZgwBXHH2sGmCw6AcvaNJKIaa0S4H68XNk/QQtKSHzVS5xV/SwtacrvIo0W7mcgB
 aVuAzUua2N2KubHn0zwUYB6tNXGoHkfr+10qRxhmEbI5iXOPkvox3WmuMMiHaoWDmCdPg4yy09F
 ekovbO1Xn0gkF4rXZRFFH5W+/Vye+dsBxw19fvMciQl0qqFsYCKP1a+fNODVlRQ/soswEjjvQxw
 X2uV2c8KZeX0z6LS+6in2R
X-Received: by 2002:a17:90b:248e:b0:38f:57f3:4dc5 with SMTP id
 98e67ed59e1d1-38f57f34f2amr591616a91.3.1785132340619; 
 Sun, 26 Jul 2026 23:05:40 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f2954ab07sm2498422a91.17.2026.07.26.23.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:05:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:05:32 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <amb1LJ78pH-HB1Aa@lliang-1876.localdomain>
References: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
 <20260710-add-milkv-duo256m-v1-2-0f761100361d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-add-milkv-duo256m-v1-2-0f761100361d@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785132340; x=1785737140;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=czOMgazdmE0OxSfwB8mBT1SdHRh2r6T2kaD+ij3++ME=;
 b=nBnV5vmmo3j5rtDD/wo0dR83Ghx8FVKFlfgCe2QyEuKcLD/JHOHUr+hD9YPyM7qiN1
 Xu54hOIEahayvxEz07Ezx+X9K2sjhj/BNw0lKmKSOM5Nzj5+7XaRiJixRns/+9p0S/Rc
 MQOGz1Ks3kAyd0XAJcJHczoIfiqhoH+wXqRbAPVpGhxhxsXYFehg8VB/IU+fA+oTPVnS
 lRs4cl5dO50IroDIk8WNzODKvGfyOsDYkBfxaDNP/evcZ9PFiKDrKYwf1hgSLzI1udO8
 kNMXOQsttyjytH4LeDXvyuBewoxSQPNgs5/uBGHxybsRUGy4BdW6zPMEPK/T5L9GcPwW
 NUuQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=nBnV5vmm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 10, 2026 at 01:33:56PM -0300, Hiago De Franco wrote:
> Add U-Boot support for Milk-V Duo 256M.
> 
> This board has a different SoC compared to the Milk-V Duo 64M, it uses
> the Sophgo SG2002 instead of the Sophgo CV1800B. Both SoCs share many
> common IP blocks, so this board reuses the existing cv1800b CPU support.
> 
> Link: https://milkv.io/docs/duo/getting-started/duo256m
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/Kconfig                             |  4 ++
>  arch/riscv/dts/Makefile                        |  1 +
>  arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 +++++++++++++++
>  board/sophgo/milkv_duo_256m/Kconfig            | 30 ++++++++++
>  board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
>  board/sophgo/milkv_duo_256m/Makefile           |  6 ++
>  board/sophgo/milkv_duo_256m/board.c            | 19 ++++++
>  board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
>  configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
>  doc/board/sophgo/index.rst                     |  1 +
>  doc/board/sophgo/milkv_duo_256m.rst            | 82 ++++++++++++++++++++++++++
>  include/configs/milkv_duo_256m.h               | 12 ++++
>  12 files changed, 256 insertions(+)

Acked-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
