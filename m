Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E8CFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 09:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358D683BF1;
	Mon, 24 Nov 2025 10:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XKmnpTxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D3D83D17; Mon, 24 Nov 2025 10:44:12 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB00183BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 10:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso43880595e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977449; x=1764582249; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJG2HySlhjdPP67urzuhbh5m5uMXNFr7pm2mwHHgVkY=;
 b=XKmnpTxMdQ2X0DcxS0Xjk7qI/67cRG2pxzk9AsacI2MfDMQ9Vf0Cmszp8NFs/y6oNI
 kT5w4fbCeJd7by2o2SL8GfVt8GfnavdudIP4m6Nh/3k1RFs/wRr383ZsipmqnB58gVbe
 nJHwdwi0Uo0R3FnwOeMWlmlbnYpRrkcHQvi4cKuWBrntfEoTg0GWsktl/PnRUKESLVeZ
 7mtmj37pMUr3K4ZYOcADiV8HYtgZwGTLkMgZAZHSX46D2zkQmBm6fCUjYGRbsZDVeBjX
 PTSPEsA2pE1mKAd7A33imvWoNwjkfPGvQEynWCGe7ihl7yUd/DQKeYSDkDrBnCJuP0pO
 FQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977449; x=1764582249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJG2HySlhjdPP67urzuhbh5m5uMXNFr7pm2mwHHgVkY=;
 b=f9qsOrSCi2PenAC2oUduYEz+Ja98Cyuur8CyzvPoGCilWojMAKmCa672AKssRozyXc
 JG52lrvwqp6mn5HRQfEcOXCPdft+WuApEvDhm3QIkaJYZazrbewJ0nEuavzg43SILC4/
 E5aizAejws/WmFkm7/m0PmHAWZe+Dz4rvymBF9nPhiDAGGC1MQ6SXNUfKDWI+qewKAOV
 UmKTwcRnxBbtmuaaPGwOQtNqojWQYgLqtOdlKVCeA545xDvigfb3m8yhQ2GE29C8O9fh
 mzafPO0fpF1M2zShBIkidcuuvIpFhR78xDwC3h+9tX8MHAb4oO2Ttz4QYL53FxWrffQm
 pMZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTJYk2z7Wer6QC4c0wkOpTG5WwhZTphHIAjtauyAHqK96I8sjtlbZx4IZWoWpmPW3N9GcGPjA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvl88ZHj16ca4W7jn1FNlSi4L83C9PMgYngF4oeEaGHdENICUq
 SCaTpS3b6NaYkqsW/+J9F/DWaVljLexo8G7c1quCE3cJw2tBOgZH/625X+CAR/jnXHY=
X-Gm-Gg: ASbGncsSOgjVnUAF3Hc2pKuQlzTG9jcFMPhc7TZKjpIpyAgCEFlgRYOceakPudSTolY
 oKLbLBlJPZAq4E/Uu758Uvlj22zIZZKaV6GUV+XPGgVcuGjGehVpCKMmlFIfvTQVwlz3nhv7fsz
 jQ5kDNjEsNWrQz+T4uurcFN8Ya1DQBHi1DrXEM3Uk2PGAxggNc1LgT9fSjFiXu4lkQ60VYvwP45
 CI1MyGmS8zyjiodFjQ4g1N93ffYJvQ2twStKOMh1Pd/1KNcIsrFmHfTy0zHlZqCfZfacZEeW9b7
 XtiNNBaQ1sZWb2zz1OJdo/+0sgAXlW47eGNHlxVcH6avRDCR5x81fUb7YuB2kKx9bAjTz+4dKPQ
 yxvqQdxm7Q9jvcgrtoDC/jLL4MDZ+KM6ydK4/CSnhgW/mQxFZljgn/qFc/nRL2hZE2NoGaG6mvA
 i9PTg9C1CgaOT0P6HcXThl15b2Oj7+
X-Google-Smtp-Source: AGHT+IG5uB25bTNjMbP6+bp9VCUhYnf+CPqMOD3SKeoIWtgTl+Pw0H70p9DLaYTVqkbUbamQIBmXdw==
X-Received: by 2002:a05:600c:3551:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-477c10e2bc2mr132053315e9.15.1763977448923; 
 Mon, 24 Nov 2025 01:44:08 -0800 (PST)
Received: from [192.168.0.34] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3592sm26136716f8f.21.2025.11.24.01.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 01:44:08 -0800 (PST)
Message-ID: <ae491f1b-0f33-4fa7-8842-96ff7626b9d8@linaro.org>
Date: Mon, 24 Nov 2025 11:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mtd: rawnand: atmel: Fix ECC error on SAM9
To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
References: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
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



On 11/7/25 17:02, Zixun LI wrote:
> NAND ECC error is observed on SAM9G25 after updating Linux from 3.16 to
> 6.6, due to PMECC setup time config was lost in the driver reworking.[1]
> 
> U-Boot is also affacted as it use the same driver, this patchset backport
> the upstream fix.
> 
> Backported from Linux: f552a7c7e0a1 ("mtd: rawnand: atmel: set pmecc data
> setup time")
> 
> Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
> 
> [1]: https://lore.kernel.org/all/c015bb20-6a57-4f63-8102-34b3d83e0f5b@microchip.com/
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---


Applied both to u-boot-at91/master , thanks !
