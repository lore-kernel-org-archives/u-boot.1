Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABADEC3601E
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 08:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1788082991;
	Fri,  4 Apr 2025 10:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSr26v+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351F1829CF; Fri,  4 Apr 2025 10:40:43 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D725E82991
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 10:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1805995f8f.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743756040; x=1744360840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcyqTWVrH4Vio2kcGcS9lfwz/WcmsFbF8bds/seprwI=;
 b=jSr26v+KrhUnrxGdnpqnAo9mtXDa3hs2/a19MDbqzVhOyYTdfAoCaTLILadEoi2ETe
 CHe/hw9tRM3VPzdIqB0ipf7bd8vD5DaUNp/GGV4P+XO5JNTjncmN0Hm9yTbsjJUmy5n7
 0aRn5IT/UCatD/qgCfFG8e0iK8iCFiKjjHH7dxmWoqAO4UkjJ8C40Q2ZruLOpgRnha7m
 p0XgBUa8N04SWI81vOq9S1HHYK+zdUUjIG1WrQdrhrW35fjozSwpVhdxFB7Zl3GRlW2w
 C78BIJCK/gm3QTykYXXSQSIMAyi1hmmRaB05XpyG4C5NOqjd+RC556x852ajCv1ovp1X
 XJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743756040; x=1744360840;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcyqTWVrH4Vio2kcGcS9lfwz/WcmsFbF8bds/seprwI=;
 b=YGdhN+HTH8xEIdE/pR090lYRxzWYu8yM2mSMWM2Z+q6yVGUbkKcoIHOMvBbhzXIInh
 4+xiSwxedBK31skpONWDvkHz1sC58NFhlG4cvyDnIPakKYk0srL4VR+MuDmO4lxpo59L
 E3HRqrDYDjN/FGbUMiGhWqWhFgCgMzfzs13hpgOQBLISuGxUBP40F4cf/SXPLp/q377J
 DEWOCdsW12nxzr5KNsWUsmyeE/tHBRDy3E6IiWIdDtkQwxrtlGTunI9EGUj9slBB1b5M
 9j3hrhHaUm+HbhQJtf7Ok1jT9h0CX8szMja+mGtI9B76jiXS44uXHxcMkjvSt/TzjtLS
 dgjA==
X-Gm-Message-State: AOJu0Yz9+nJn0tFmaRsFT9NbtpV3NT2L4AhAIsyQSWTDSzpcTYU0toa4
 +XYEBuAsRN6e/skKtRAzAw7taovlHG9lejJ+tqaFeyTLeDkeLVIq6ciHPBQgXyU=
X-Gm-Gg: ASbGncuotvtxVb1Fy8RqCZCn2PYdEPazkerSLIXD0a1DHUJ8N7QqQbquxCAcHY1Kxh3
 9uE6Ge2KwhicAZ/TFU/aMbJyeEsig8/Xl0WqFsrVpzxFX2H95EsqKDD0Q5VaBSFxNMW/jwNpLh6
 gj4kmNzSZlI+Fkg4Nv3H5JiXkZFyNf6PPnuvL/sIPNUqmXWjEpzsJOus1yIfZY8LUiW5U+HunCC
 0a/3JhD+5RE2w5U8JEmntOotYNZ29F9q4Zi6ZN/Dllb/Qf27CHEPkQPbITBmfIX2bZUDQ75l24J
 /MyQ+NvhgSEHtxKxP0fA5mlPVrYPi4pUjZVYPZV83HI1LsNO4xtB7/o6FxGw7S0GGQ==
X-Google-Smtp-Source: AGHT+IEiuZd39+N914ggP8u9zuSQn67eBwEE7ajMj0IbwIqKg8nAeMrFWfFN4foi7HAvAgL6TMh5rw==
X-Received: by 2002:a05:6000:1884:b0:399:6d8a:3f with SMTP id
 ffacd0b85a97d-39cba94dc6dmr2048188f8f.27.1743756040274; 
 Fri, 04 Apr 2025 01:40:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096bb2sm3830928f8f.12.2025.04.04.01.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 01:40:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org>
References: <20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org>
Subject: Re: [PATCH] board: libre-computer: check interface before
 comparing it in set_dfu_alt_info()
Message-Id: <174375603984.3130822.11319635435773875897.b4-ty@linaro.org>
Date: Fri, 04 Apr 2025 10:40:39 +0200
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

Hi,

On Thu, 03 Apr 2025 18:03:21 +0200, Neil Armstrong wrote:
> When set_dfu_alt_info() is called, interface can be NULL when called for
> the EFI capsule, so check it before calling it with strcmp().
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] board: libre-computer: check interface before comparing it in set_dfu_alt_info()
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/c5fd2c7ac7fa4835339ea09ead2884794314c9d8

-- 
Neil

