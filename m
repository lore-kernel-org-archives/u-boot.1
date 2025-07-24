Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFBAC87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5879D83936;
	Thu, 24 Jul 2025 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mp3ili7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2760783923; Thu, 24 Jul 2025 23:30:38 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5768391A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-306e88f0b0aso314656fac.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392635; x=1753997435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGFP6mNXD11lI4HIBGWMIUzLBeP66ihVMX2D8MSzz7s=;
 b=Mp3ili7z8la1mkwpONUjEeKzTWQnMPvtq1RK7LRfmdRsN4lMR/T+uxshy6KLhY1HzO
 m450hQ2ZTLbbN30SBBDYf1Uke1YFsnWZZJIUGntQviCqbng0SVOjVg2hvbqBOGQx1qyA
 6s7b5hukL+4jFi8MptjXsqiXndWsrFF2LXTsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392635; x=1753997435;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGFP6mNXD11lI4HIBGWMIUzLBeP66ihVMX2D8MSzz7s=;
 b=mKlu3DV68iXtMGSFalZLtJhePVwxvAQVpMCuyKcDiZifkm4LF+Nw2Z6XRAceKn5wSe
 vzInNjMqUSwFSayi1v0l6CU+CjtoHxjeAqyZbGouZsf1qfOX97iJLdO1oHzZ57Vl3WY4
 FW6aiinFoJ7VYo78b/Vh21DHH62phpXv7haRlMC6hjBSNg0pQRHO70rj48Rq/GeCCtdq
 E2fBt70pBuXLhCdFH/fcguE30VfSGk+oOHREQmk0wK1ssrsXNxtKmGAbkdyYDWVhGb/R
 me/4M6JcudrDxIY6kePKwFc1lQfAP/EXNn1neX6hOByUpfR/iybQZ7wdF7kHq1sGbMLy
 JDuA==
X-Gm-Message-State: AOJu0YwQuOSrOSJQBYv167kXoqUySk6p6JpyIvonah1YXlkyqVpRINDo
 DGDInoIL5M+QEVMRA61X8y1fxxj5/jcdFhe1e4TaGw0O1F0UPkBh7urtQy9QhHEZRcM7GLUt69g
 3eLFrs7U=
X-Gm-Gg: ASbGncvEJkQ8nw0Qt+tyAvN5R6w3kQ397yemobiNlDEfQ8kSkzNCvxNmTeWAUjA9JLQ
 o1O/ycdDct/n+W/x+vwmhmrWCOascQXD9G03Gzb4t5/DYqXAj2EOknyW8f1RtxnWsPmkOwqUMq3
 xf6M56WdO2XzfTRPAERqyzXmL2LKLtUjyO67t+fIPum2ZnBVpbwecQ6DmZcsvvp8ngMibzeH2vC
 xQxjXK1SAFXcu+1BfbhS03QDedx3gKO8l9Aujr30qdjV8I6h8njqgoO7wS0eFssXzCtHsOTlNhh
 irFzVLzQO6gubS8lEVdFPvVXyJmMQ1KlrZWUF6Fhb+hA6iiDfeCruSrh/efFd0ZME+ee2ZF1pA2
 nQ39KolBmB3ZokVZpJoGVJ6KWo5HkmKwC14heX1iscCqSY5G79fZJDz0=
X-Google-Smtp-Source: AGHT+IGnbqO1KjvDqb++4tMhia9h9igQVeVY64Qi5i4i1cQxQ459dXAPm3S1tc486VCRXynVI1i1aQ==
X-Received: by 2002:a05:6870:c6a1:b0:2ff:9aee:1793 with SMTP id
 586e51a60fabf-306c6f21cdemr5676653fac.1.1753392634707; 
 Thu, 24 Jul 2025 14:30:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>, 
 Rebecca Cran <rebecca@os.amperecomputing.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250717161527.2664-1-rebecca@os.amperecomputing.com>
References: <20250717161527.2664-1-rebecca@os.amperecomputing.com>
Subject: Re: [PATCH v1] arm: dts: ast2600.dtsi: Fix typo of uart11 reg address
Message-Id: <175339263403.1899261.16590205465204736738.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:34 -0600
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

On Thu, 17 Jul 2025 16:15:27 +0000, Rebecca Cran wrote:

> The uart11 reg address was a copy of the value for uart10.
> Update it to the correct value.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: dts: ast2600.dtsi: Fix typo of uart11 reg address
      commit: a70bbc4436bab45e7025cd50dba86ab5c96db76d
-- 
Tom


