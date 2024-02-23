Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11116C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 17:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EE78795D;
	Fri, 23 Feb 2024 18:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wIAOzNdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CE2879DB; Fri, 23 Feb 2024 18:23:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 515568791E
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 18:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41298159608so1956555e9.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708708988; x=1709313788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhpfx/ePUICxS06uEeSdou4myF4uuNjCR2pKvdgsQ0I=;
 b=wIAOzNdlIqvttqu6AEGe/18JwYFvDMDmVzy31ECq8g0FndS4jrMtdyVQbdxKsa5HXK
 HV5ssS8oGmKt2tup9Z7TypmjV0KnJcu+L7uI2V60RkULB4rGRDNn62fK4S+lL8RSn9ax
 dG7z0kGYyTjHOmTDL4d/2iqxKe4zLTV22SNMwgXkqG4bcfivcqhes506dY2MlFA/Gox4
 ym+4Usg7sJzwFKgjbjPb/l5bft+VD8vN4NwaPEkweL2ZMuIsf0q8ZQJBwrOh8ONGKq+i
 JooHo0nhMKIrZTkjXaz4gWlz/M04coL6meDPwSX123noLpGx3ItjRNlEc7J47lo6RPig
 Q9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708988; x=1709313788;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhpfx/ePUICxS06uEeSdou4myF4uuNjCR2pKvdgsQ0I=;
 b=Lexx/lmjGQybtCodNk21cugBVMPGrNNrmLmF4Ihb1zLXRGbWQQ/hPx+QQewI2EZnb1
 PW3GXMgR1DqAzblgQsXzKrB6kcqF0tg854E+8zBpVrP7rbigNIr3LGdCI2ihbmUFf9ya
 pL2N6v1zYCFJOMxbZ5YQjY5lM3CXr895lPRfsu8AmzacNS7CI33T0kgz+DA/2OshJY3w
 Ab33pmcKn67m5KDj0Xu4122YiQbGiIjvK1dp1tCxXUcSxxnkg+BadmIwzmnOjtjC8c9W
 dC+dihD0xA0BomXfvLXxptaEGKkHmaizxzUkc/Z6khOMf1Y0+lSo3GNVj7GosPoUqsw1
 LbRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvRkIzce0/DqEYnfCrGXFdgL72jLZgBtWElRrKNFfFY/6t1l+gf3AFKxBR1LOZvM9ovktq/koalNaoqIsBJaUqKNSiNg==
X-Gm-Message-State: AOJu0YzuW+dERtVGNwgvdT428s3QYfqVZwIlHmy8L90X6T1TOUgYOVLO
 e71zMMvaLJtcXiTeDQAbbBhZ0Vgv743WkI1sb5DzGy6nt5WuhnI75pTzNxpC1Tc=
X-Google-Smtp-Source: AGHT+IGIsSeQZqBaqBWjThOPRbhNoRHLe5uWldTOgRFDmFR0Vf1J5qrEZNLtxGm1BRL07XJLSRhgfQ==
X-Received: by 2002:a05:600c:19c9:b0:412:8cc3:bf67 with SMTP id
 u9-20020a05600c19c900b004128cc3bf67mr471767wmq.8.1708708987776; 
 Fri, 23 Feb 2024 09:23:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a05600c290a00b0040fccf7e8easm3015320wmd.36.2024.02.23.09.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 09:23:07 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
References: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
Message-Id: <170870898716.200337.2390441000812477288.b4-ty@linaro.org>
Date: Fri, 23 Feb 2024 18:23:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

Hi,

On Fri, 09 Feb 2024 09:58:35 +0100, Mattijs Korpershoek wrote:
> When booting Android with AVB enabled, an OOM is observed:
> 
>   => avb init ${mmcdev}
>   => avb verify _a
>   ## Android Verified Boot 2.0 version 1.1.0
>   read_is_device_unlocked not supported yet
>   read_rollback_index not supported yet
>   avb_util.c:182: ERROR: Failed to allocate memory.
>   OOM error occurred during verification
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: khadas-vim3*_android: fix AVB oom error
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fc0a7431e1729f456690468f2e9570fcc2c18175

-- 
Neil

