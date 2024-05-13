Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1DCC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 08:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66FD88275;
	Mon, 13 May 2024 10:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="otb3CTBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B9187F13; Mon, 13 May 2024 10:27:21 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712CF88275
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so966362f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715588837; x=1716193637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d7IqIvC0TyFuYW2zD3nIrDVh4BElMLvF0++SuVhJ6o=;
 b=otb3CTBrfhAsLI9jF9b88V1RE5vydmBhfFiShVW6BtS3PvfU9nVcxpKaNFyXrs+nlV
 wyOAM/Z0QD9jVqA0RJMKxDC4m2+eGGy5jvKFJpvcS+J4OadPebnBxnPa2NsFoDNknv/s
 A+VY+lQqfnBb0Fztw27LUayjScN+7Iv2Lfu7U++DWum+53Mvl2XHX7SUan6fugoS7tfg
 p+nuym2ZSX+qxC35dqtNzUgSYeMPHZtaiqVqZccoigpavApdSA23csFT+zF/ytDcH/r/
 Xqca8MyMi6e1JHQSEr7eYkbhkdBcL1E8BQTpOtGuhwUegsuE1sS/9CpOHc9surP8K5uE
 yG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715588837; x=1716193637;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5d7IqIvC0TyFuYW2zD3nIrDVh4BElMLvF0++SuVhJ6o=;
 b=oYWFiEM/fsD3CkE9GIs/dfp7zfLPwSO7X6oduFggNMqrbfzEMePrRcHCMP/gTpViAs
 gtAMfQapaEhcBdYuzI+Hq47yOfwI1uOcdEUZ8S+w3joQSPxMY7HokcGMkxksg4bf4UTF
 1oCKel91jy8Q5HtUd8x18jjpi5rJ+X75SiX6brAWaV6Y0fZJMTY63msioVCFMYAAE7os
 yCRLoMLkiIvfSfKYrrshZEe+gz1+0iGIqyyKvLYH+wh6lhY4E4xFnAhZsG0LuB8KR23K
 N6OUr3fLBdzB3oaRPxtk3eyorcfCroCK4txoi64QOH5ZHg91FSsii+C7zSvDbvg0TkmZ
 waiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOD1ioRdyIuYNuMuif0ssBc0SRb9Uu8qaIDVVS26N3ryvNIP7uwyBXGj08qNSqu2NNjfrLGIfn+PmWrakgxYcIoNagBQ==
X-Gm-Message-State: AOJu0YwU/E6eIB2oQuKC4SHXA6qdz2qbxdfRqDwTNTcMFZNYDC8CyCSU
 L+q71L1j98I47cCHo5UuE3Lvxl6hM8JHXT6P9OK1H5BAujJPV6dYtW9koQZf59w=
X-Google-Smtp-Source: AGHT+IGbFzG9oOQ3CUOOSv4aWy2j6FS4MKxmSdwnkA2kGrRFzyaHyd45pG040j1lUkgrxWfHOHsAXw==
X-Received: by 2002:adf:e88e:0:b0:346:1ab6:dbd5 with SMTP id
 ffacd0b85a97d-3504a7379b0mr6637945f8f.20.1715588836994; 
 Mon, 13 May 2024 01:27:16 -0700 (PDT)
Received: from [10.91.0.157] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacf52sm10640263f8f.87.2024.05.13.01.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 01:27:16 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
Message-Id: <171558883607.3055487.4753666162213612810.b4-ty@linaro.org>
Date: Mon, 13 May 2024 10:27:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Tue, 07 May 2024 18:41:23 +0000, Sam Day wrote:
> The newly introduced carve_out_reserved_memory causes issues when
> U-Boot is chained from the lk2nd bootloader. lk2nd provides a
> simple-framebuffer device and marks the framebuffer region as no-map in
> the supplied /reserved-memory. Consequently, the simple_video driver
> triggers a page fault when it tries to write to this region.
> 
> As per Caleb's advice, this simple patch only does the carveouts for the
> qcs404 SoC for which it was originally designed. The intent is to do the
> carveouts for more Qualcomm SoCs in future.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: do carveouts for qcs404 only
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a8910537bb6c

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

