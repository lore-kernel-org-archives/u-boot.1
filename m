Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE89ECA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 08:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6945A82D21;
	Wed, 13 Aug 2025 10:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dKA6DLEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CC28320C; Wed, 13 Aug 2025 10:00:34 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA4882CEA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-af94e75445dso1146103166b.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755072032; x=1755676832; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KxBnUfJZgLG7OsyikEcgQAD0vTS+nyzLL6AnQMmxpFE=;
 b=dKA6DLEywOSLwb8UhzvEgh19g27nj9nNncoMmj3ts7MJm7m6qkrmFKqUK1zr2MiBsh
 gSHDTE65NGlDqdFjEs95LUCJfUd/iQu5z+nlwoEDimWvyodCYRTxeJNtnIcu/XR18Z0a
 dMjRRGHWG7zm+rkxTdJWDzGAhvWkyGHMEHGDVV0R2MCnwSOX8P9Pfil5Bdup6S/IJmiQ
 6TQq/nOBVRzDlLqrMHxxILWLQh7o6+quOM5+rYUOCbRzHVWdlHcG8So2N2Uk2p/gWDi7
 xE0GHW/jj+zG9wZ3uSW3GWfIe/itRMa4vqRreG5zKZCcdzBemWuzzMQmlNFysgRRNsIF
 HG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755072032; x=1755676832;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KxBnUfJZgLG7OsyikEcgQAD0vTS+nyzLL6AnQMmxpFE=;
 b=AkO7tHhOd5dRfcZqrmevRKKX3vwpQ53tPZyWemOkqNl5qzsB24Xnqmb0wPkGX2VXTX
 qxjOM53l6VzM0wPGIfR5zIcDxqnL2ZEuRGRVFAeMOLXL1w5gaIoiuxmJ06gJ1S8/7utt
 ymDZEls8I1arOGGZ3/+7m/MAMz8eUK4tdhol51GOYB3cMF4x73KxKb2WxSFjU7sm0iR3
 0MBc2s+BzX0j4s9327dFGdoqIScWtQH6ScqQA99DJQ2k0EY698S+pkVuz8Hqs0cuyEOE
 Ploq6Vf6VIz3cQUT85wnGiIcFrr1cTRdudOJPcZ9e/Mb9P0suJKsMUMbIr9qJmOQUBOW
 n0rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWxirqvtPJkMHj3BGNhDHdLwL2uhwzbQs/EJ3byGkrqldu5WuyLhbBDCof1HpO6fPZ7vFMRlk=@lists.denx.de
X-Gm-Message-State: AOJu0YytP5hhFqPc46gBtDNLtC25LQZqCT9tdQgcGyV3FkrHX0qhfU9t
 iD0DA+zsnuKqezejN8q1VNhwNNbMMZlJS0vog02D+qdC0Zjkhl5TS4GXHtP5gdEldpY=
X-Gm-Gg: ASbGncvhLFKVal9LuUCv1/mMZWOe1OICsJoA4dO9ZcUPCJ8PJqTTn9qZCm1w03NM8cO
 KC5bsDqOz2XoMt3Pqg+N5FUTLRpDN6+2PjVTwEqC7X4zl7Yb7ffQAlHmzGKT2lMj4ZVvL+PSTOV
 E/Hd+PJZspWcPlcbKDN9oaIYwM/NTRLF9DQgnJSUD9YTP6vNKPQycL98hgs2pBNILyhGfFEVwRd
 3yeMEWBlSztudMOZaGpsauTgvhvkUBz7WIWBup842Fu2kHGLV5sauGI+ADil7yqtd19QujDbH57
 tFWib5MwlxzSpiBv++6eox8IPrAj5rm8t1B069Z7rjycR3mgbbPkBuFqt4QIIjcyzdZRIiHVS7y
 Iq6bzhC0KJPe9v/sRyAtG3ZbVeDZUoSpDFt5g8m+z
X-Google-Smtp-Source: AGHT+IHjBVR7SlIDqWWq9MFzmGV2nroYTVGukQjq/wO/HCW2Vl3LEpIzY9IWKp49G7mpGzxW+o3eAw==
X-Received: by 2002:a17:906:6a1b:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-afca4d36263mr226678766b.10.1755072032468; 
 Wed, 13 Aug 2025 01:00:32 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af99518bfedsm1376028366b.105.2025.08.13.01.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 01:00:31 -0700 (PDT)
Message-ID: <396dc528-a33a-43d5-bf21-33d6eb05ad2d@linaro.org>
Date: Wed, 13 Aug 2025 11:00:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: spi: atmel_qspi: fix race condition in transfer
 completion check
To: Ramin Moussavi <lordrasmus@gmail.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>
References: <20250722182710.6095-1-lordrasmus@gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250722182710.6095-1-lordrasmus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/22/25 21:27, Ramin Moussavi wrote:
> In atmel_qspi_transfer(), the status register is polled with:
> 
>   imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
>   return readl_poll_timeout(aq->regs + QSPI_SR, sr,
>                             (sr & imr) == imr,
>                             ATMEL_QSPI_TIMEOUT);
> 
> However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
> and will then be cleared by the read. If that happens, the condition
> "(sr & imr) == imr" can never be true, and the function times out.
> 
> This race condition is avoided in at91bootstrap by accumulating the
> status bits across reads until both bits have been observed:
> 
>   /* Poll INSTruction End and Chip Select Rise flags. */
>   imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
>   sr = 0;
>   do {
>     udelay(1);
>     sr |= qspi_readl(qspi, QSPI_SR) & imr;
>   } while ((--timeout) && (sr != imr));
> 
> Update U-Boot's atmel_qspi_transfer() to use the same pattern,
> ensuring that both flags are observed even if they are not set
> simultaneously.
> 
> Signed-off-by: Ramin Moussavi <lordrasmus@gmail.com>
> ---

Applied to u-boot-at91/master, thanks !

For future, please send out patch updates with 'git send-email -v 2'
(e.g. for a second version) and include a changelog below the '---' line

Eugen
