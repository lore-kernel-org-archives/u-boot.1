Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248BEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7684F88B69;
	Wed,  7 Aug 2024 11:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AYG9RrGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8197088B74; Wed,  7 Aug 2024 11:55:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6E788A7F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srinivas.kandagatla@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso10797725e9.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723024554; x=1723629354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iV0FQP++vqMUtGeFQZXpoV/QuW7m4m+Nk2rBOq2n+PI=;
 b=AYG9RrGOD7ZXW0yMx6HMyX+SoRiGEViWo5vg/nhFb/1RyyhyiRmF3ZlMr7FLBn2qB8
 myTWkyG7o3BspKlA74UzV7CNonXNsuD6voZdD1nFdiLJ9uDZa4gVDE1ibazXrxvxk9zI
 68RNd/RBmdor9kikRsmI/WrGWT1Z4xogeZHiV+iL3LnYuJySs0M4glvd35i7uf5uqaXJ
 O7sz8y49MA2633hGzOil8zQ9xHqU5WG6j86mD2NzCI8FYf48Lk0OPLif8hq4CSwWlKgb
 WGsDjOopp7rVJtyGILfJ/lwNxM1rByM4LMgzQI1+S5i13mWq2VCS11G3Lh2VFq5p8kbB
 ewjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723024554; x=1723629354;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iV0FQP++vqMUtGeFQZXpoV/QuW7m4m+Nk2rBOq2n+PI=;
 b=aeq4ZK+st8Dn3B8HYhAcwXM67tk0MJGUotnKxUlsd+o/8+v8D9djnzwtOLtVzujVi+
 EjyqkazKtdykT3uPPPEiiQ4IsLWgqJn3eMG5aecR3IojvcArR3JEIxGkwHbc3pBWMP+q
 Xo1cj1UHkIaWxRjK0H5E+j6Hqabde2d/mW2WJqkawSXuHAYGndQH/OX+ecZiMG+zg5rh
 m0nhR17b4QmsQcSjJHD+d8S5blDwlQLCBqvMybDH4dzsMQqWTewjW0/W18Nl/inU0Yss
 ih5DPTPTZo3TuYtorK0Rke9I4efAU+HcoVTlEC2FKYxlbShMR/GYzlbBEQ0KWFo4wlIi
 Xo5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbsmS9OI3UfKvpHWNT2HnHzO03sMb+5MGoU6krAVomGBhOWz1l8hobRhRy4xyMb5+RuPHu5s+1GNA7+/tTj38ePjTG1Q==
X-Gm-Message-State: AOJu0Yz5Ad3v6/V2ZwbELETv/ScwUEAIdEvFq86P2j5MGCZcHaBknkiI
 jNcPAfCt2GzUrqJwFzpwHkEQPIBQtP5FJlJzVoE4bhsangM6Y0v6hH7yMzRgmTI=
X-Google-Smtp-Source: AGHT+IE3vEUjxKYTmLbMVbVULcwDedxIFTHlJkf/M6s5xb9scxWEgx63NITV0XFFGFGGaB2KdRv75A==
X-Received: by 2002:a05:600c:190d:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-428e6b31ecdmr130357195e9.22.1723024553869; 
 Wed, 07 Aug 2024 02:55:53 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429058026b0sm21194255e9.35.2024.08.07.02.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 02:55:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, 
 John Thomson <git@johnthomson.fastmail.com.au>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240729080733.16839-1-zajec5@gmail.com>
References: <20240729080733.16839-1-zajec5@gmail.com>
Subject: Re: [PATCH V2 1/3] nvmem: u-boot-env: error if NVMEM device is too
 small
Message-Id: <172302455213.382580.1153614262268282040.b4-ty@linaro.org>
Date: Wed, 07 Aug 2024 10:55:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
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


On Mon, 29 Jul 2024 10:07:31 +0200, Rafał Miłecki wrote:
> Verify data size before trying to parse it to avoid reading out of
> buffer. This could happen in case of problems at MTD level or invalid DT
> bindings.
> 
> 

Applied, thanks!

[1/3] nvmem: u-boot-env: error if NVMEM device is too small
      commit: a80f2ebe78d7a81354b1c9d59fcb79b77982df2d
[2/3] dt-bindings: nvmem: convert U-Boot env to a layout
      commit: 1b3f5b88c541318a95fc74db80083b87c1020e03
[3/3] nvmem: layouts: add U-Boot env layout
      commit: 641d6abbe15f96a4d2cce5dc48940fd22916d15e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

