Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323BDCA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67470831E4;
	Mon, 18 Aug 2025 12:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EIMt1nR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF74829E7; Mon, 18 Aug 2025 12:31:32 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3C782BF6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1963so1902617f8f.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513090; x=1756117890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNLk3ShJID8OTRrHWSyIdLtok94ubim3kl4XKIKZvbQ=;
 b=EIMt1nR73uTnc/PYdKDQg6MuJm9XrDG8l0MxlD3f8p5QhMjPSJUCr02R7zGlsCyAGs
 Cezm2mSsc/X2LBqiAepj8G2bsMAF84wgN9vk9sOMxD3UWVsTcHW7xDL2ZHn2j5R0rmN0
 m7LRtUVi1ExemP+elQoGimd8QkDQwwh5VEb923e7KucmdxlQx/jtSKAm0GKUJnAr//rT
 l+zeyfwQEeArQiR2X0FHlNfAT1i2b4G8l03Ckgy1XWxrOzK+m1eWI2LeJAzlCX6Gqfk7
 HsXsMMhaM113DSABeolgPdM81zCC4U/QeWOGmKQETwfdNOjONKaWprAoBtlSrsIEFZel
 SdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513090; x=1756117890;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNLk3ShJID8OTRrHWSyIdLtok94ubim3kl4XKIKZvbQ=;
 b=TJF+BraAg8g4j+tUVO3qY29phLzdYgxXqcTWMq2lO5aiZasrLCiAjs/gx4M2w2WymH
 rswyPjqyKqbCvcenLncWgOJmLVXjWzfOjDH0uLh4bArAhdslU8jHr8KOD9V7DKnDXps4
 3w+MYD5YBM3Szo+MlNNCnoOVZ4Iei+NIAeK5FmyF/HEBMjDye9PHCAnIIkVo8+by5dEA
 2MiCq9uzuIj9TVLJ2xXHoxqLPu4UmHvAWkciXKXs+OJnxxHZMx+wn8eHYytjLqIGuAP5
 jXOW+Tu2oaGtMkJ/QjYnb95N4CRr2GI4+N3DsboOE0wCYiSVHrlXAjxvFV7T0EEYWBJn
 7u5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhtOtK2WEDI2CVSZZDrenXKyVN0gBHLCemryVRFi1isf7mtJ25/vURtofutYw2TvIZtf2HJvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwOu2fwL6ZNkwjZrG7X2jfk+9ruvN3VaBQaTeLOD4AIQLkV9dIA
 5tv8EL14yWxgvMbxb/sYPK2wpRgr+Y20G9+JVoil0IYW5wAGw2dr0t1xozw/POvtPCQ=
X-Gm-Gg: ASbGnctRg+WXtp+SZ1Td2r+4YmcRxnGvxnUS2iYlCYxvXVeYiuxwvg1FJINuShN5jN9
 ncEDDxrZOkGekEDhLnZXDNN6p/P/09SVwibOIJY7JnFErluuWI0Gc7Hd4WvQ6ApXigNDjRjwihd
 8kzpKOYMTJc7PmlCll8ygkZ0Xzc5Jgu8sUq4e7xeCvrO7XqM85l6HPBXROFJXSUboYYE/WaTf3P
 Ej8IB8zVdfuyxT3TCQZxZ6jKuca+Txn4fcKGJ3/XJjBRy42oNsJgYv60B0JIpUV1DXCIobhODhA
 VASO6U7lJt9poVMYULeVbD64032npl+w9+GpHyI6dVovqWYaIX/NtkuZw8rDFANuj00c4THyj0+
 dtYZV+tb8OvgzQWwqjg+Fc7/9n9Dg8bSdZlnIzxYTsKrCWZCck4nmVOUWc0wXhdfr/T0=
X-Google-Smtp-Source: AGHT+IEW6eOxwRO/89ojm76bpFpwlaextZUb061STrjelEndLytPpu2aqq6AKLLYplPkijtqbwNj2g==
X-Received: by 2002:a5d:5f56:0:b0:3b7:6804:9362 with SMTP id
 ffacd0b85a97d-3bc69053ce7mr6118942f8f.26.1755513089780; 
 Mon, 18 Aug 2025 03:31:29 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm172438035e9.21.2025.08.18.03.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:31:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
In-Reply-To: <20250811104710.1896382-1-casey.connolly@linaro.org>
References: <20250811104710.1896382-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: fix erroneous lmb allocations
Message-Id: <175551308845.842888.12515429438812196356.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 12:31:28 +0200
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


On Mon, 11 Aug 2025 12:45:13 +0200, Casey Connolly wrote:
> In 6e4675b8e5d8 ("lmb: replace the lmb_alloc() and lmb_alloc_base()
> API's") an additional allocation was mistakenly introduced resulting
> in ${kernel_comp_size} containing the address of a second 64mb region
> rather than the actual value of KERNEL_COMP_SIZE.
> 
> Additionally, in b40d7b8f72f1 ("Merge patch series "lmb: use a single
> API for all allocations"") merge conflict resulted in an additional
> 128mb allocation for ${loadaddr} when CONFIG_FASTBOOT is enabled, where
> it should actually be set to the same value as ${fastboot_addr_r} to
> respect size constraints (and since it doesn't seem to interfer with
> any bootflows).
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: fix erroneous lmb allocations
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/23e1a11f4e8e

Best regards,
-- 
// Caleb (they/them)


