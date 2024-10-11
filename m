Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EAD0D79F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF6F8932C;
	Fri, 11 Oct 2024 16:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FnluFFGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEB489352; Fri, 11 Oct 2024 16:42:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED0489324
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43055b43604so19152435e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657734; x=1729262534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRcv7osLv8GG3JVgJNSN589Vr5QBk9sct5/iG33DVrI=;
 b=FnluFFGoZksjNBlsK08qmV9zJhpKDHASj94P/gd2f+ytira7XsPEopJ3ktwxgkduMS
 Mv6J0C4AYItmDtZcKBOsLFRRKGY5tuELZ6XqzAkQAQD8YZfaV1OlcSoaOzraPL920U5X
 hmDKFELkvXKujVOi9XZjlHw67uAYmh6c3qPj+qR7F39z2UlzTQwc8BmiQ6edH437EA2Q
 Jbx7vSS7L4ZoqTiRYiFI0F6GDu1wDXUD7M4tNyrBPcfp0QADiuacEsXIjuyAdzrFKSRe
 k1u7XhdU/GY/TbNuw/bxPZX+Dn4DaQkr7OMEzh5ZFiJsP8N3p0d4YpIz4no0oBWgQqUt
 bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657734; x=1729262534;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRcv7osLv8GG3JVgJNSN589Vr5QBk9sct5/iG33DVrI=;
 b=SA8UDt+2Kdxw2msxHWOi8fnyZByTWtKrG0I5wL0LrelePw0+TDsvJLARIj/YVyxMVR
 Pu4yqepwqjfMv51V7B5qrSx0Ol8cq8SUMxsW80E3ebb1HwjOyHV4wheuE2JdFaJSv13p
 15dUV7nVVMdXwgDd0+mmJ4oZylv/PdR/0vmbvCYAVZ5ufn6sciIX1WO0WLUyCi5dllea
 i8Op/b+Q5yJSNDxkh/jj9pitnD0p43OXTHjW2nsFZ1AzcVo1xQOUWDuAAWb8wcQR7tmM
 71SYKpKxbUDMg9VOO7Xw725TX0mtRnFbP1wucCTxO5bS5cytOAZ/C7x0GWBF8jWxsf6M
 UgrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBPTIJANvFmigjV09wAZypXmzKZQ436OA/HUppcEURCOpnecBZo7c5Pr4eaIQaIJ9cev1zwjs=@lists.denx.de
X-Gm-Message-State: AOJu0YyeWbQliNq1/0Wru0H8Xlzd2YJptBOuPU0oNcO0wZYCUG5289po
 afjoOFZGqWxa7ro9QG5dMSjc9ht8ZLkQ7wIlUF4V/cdQTxKlIjURhAPekGbaSH0=
X-Google-Smtp-Source: AGHT+IG71AiRlqJcDr+aY8i4N4cnOUSmc1QP+oxc3bghWEOkwz5jrBpe8NQXk1gZrJmH/8VNZ8dlnw==
X-Received: by 2002:a05:600c:5248:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-4311ded3f1cmr22103015e9.12.1728657734246; 
 Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:42:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
References: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
Subject: Re: [PATCH v2] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
Message-Id: <172865773344.2734796.5228507096974795702.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

On Wed, 09 Oct 2024 10:01:56 +0200, Neil Armstrong wrote:
> If the regulator is already enabled, this happens if the regulator
> is set in regulator-always-on, regulator_set_enable() return -EALREADY.
> 
> Ignore the -EALREADY return since it's not an error.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] video: meson: dw-hdmi: do not fail probe if HDMI regulator is already enabled
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c472742f5c25fd4098e034a7f292cc4e26bd25d

-- 
Neil

