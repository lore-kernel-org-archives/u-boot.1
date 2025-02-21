Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169A4C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824AC80FA4;
	Fri, 21 Feb 2025 18:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pmMCbI53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FB580FBC; Fri, 21 Feb 2025 18:38:19 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE8C80FA6
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220f4dd756eso49742305ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159496; x=1740764296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwf1sSQQqQlGuhsKeeKey2DlSEjq51KMOv4ukuMXYBk=;
 b=pmMCbI53b+BorhQIPR5ezQCWWv2XK13kRLhZK3gzA1imV5/SXxmZXz5ysxClseA8bk
 LkIbX059s5qDDtLfSv1JU6tfkPn6JlOeTvVYoaxB02K7qpZ+7JPlZIEVtcJ3RLJs6qO0
 rpyn3olxQmK6FkyNOaSrE9djQxmy43RWiSkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159496; x=1740764296;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwf1sSQQqQlGuhsKeeKey2DlSEjq51KMOv4ukuMXYBk=;
 b=u85baSCfKyh6fesW3LHtcYMAas5r7PJrnWFrkeRNoYlCQmlgVHvpunJuVKoqsgNJrI
 fZQXDBksxo2RADJTVNlL4KRGL/df/vLBuvLtE08qNpHwrV2DHf+VhcZhrgNU63XP1Jx8
 pLKsk2HZCqU6h5dmAyVOp2mY0Jpppiy56ggsgf9P+YpLrf4189FCOmSftgmkS+PoeHiS
 I3VrzyPpHoyY3ZwOUAeMWCy2sR6ZKNM2UmSPKFN3yFwJRLGeCMYfRpDu7SZ2YhaabibO
 2hpnjIPtLgs26F58QpJIrtRtWRUU9FlhZRzvGg3zNOFRtRBz152A1e+QcGXMxIYZt4lM
 ezGQ==
X-Gm-Message-State: AOJu0YwTQJ8b84qVX4Qx/kImjFTzWtfOeb1oS38OdcXPzRFrgO7908+P
 1GO7OZuNMVhwSOVrWTwGcvZyoMZdGjCyTTvLuOos9uUZdrhZtt8dEwcWolfiMk0tV/LMCteSvdY
 6GdE=
X-Gm-Gg: ASbGncugOVcm8croPmIMf7Jlz/g6UBCjh0dbZNwQT8X1sjG0Zp42MNyWzk/LRwztkkV
 /5jOIqK77/xc6MhieWEcnnOu5qxEn8hwAi9I8i4a0+F8UqC5nVCw7/aJLeJk75CZ8s7jqMuam9f
 yDJdLRCwRq5FMJGSBQIkhVd/X228PqGSfQNH74kTiZaOx8GTXhcom4G6yOWYx/UkAFjUC/YIohp
 V9r3Cu3MSnTEBfOEPNytETtJ/9iuQTRq7Mvc21tKhppuhsjiitWqz0zWltXM4JYhGnYsYGV2dp6
 3HfSgKMeyuCXl2ri22AaayY=
X-Google-Smtp-Source: AGHT+IGwG4EQA9dovyA35p7ev8qGafp0X3Q1WitIQfMduRtasUDWF9l34D6Jp4HCTjYG1nyi+klQvg==
X-Received: by 2002:a05:6a20:7f81:b0:1ee:c6bf:7c68 with SMTP id
 adf61e73a8af0-1eef3c8a93emr7457131637.17.1740159494384; 
 Fri, 21 Feb 2025 09:38:14 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250212222333.684437-1-trini@konsulko.com>
References: <20250212222333.684437-1-trini@konsulko.com>
Subject: Re: [PATCH] tools: binman: ti_board_cfg: Fix pylint error over
 'br'
Message-Id: <174015949344.3526942.10150330984522873484.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:13 -0600
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

On Wed, 12 Feb 2025 16:23:33 -0600, Tom Rini wrote:

> With a newer pylint, we get a warning that 'br' could be used before
> assignment. Fix this by declaring br first as an empty bytearray.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


