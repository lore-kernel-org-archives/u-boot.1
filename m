Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E7D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B1E8964D;
	Thu, 14 Nov 2024 19:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d/V3goK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76638964F; Thu, 14 Nov 2024 19:13:23 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C8C89639
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cf8593ca4bso686820a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608001; x=1732212801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p59DgOp+Mmqs5+ykuXp8jnHOA/wHzF3uvAU6cvOozE=;
 b=d/V3goK7mXM4/mBc0jP8SlAY8EFQudzFhvBZLPSZYAl2xhtBXVGvSyL2fLysvzPz4y
 By50svmwVrmzNvkC5eo6guzQuhfSbovRN+LTrTmnP+3wVXWgOQrTfgsyC5ytvuH3nBxQ
 elP8NKfiQu3oz2CVvAzS/CC5GNKc0dDsQAFUZhtHh26Ed6xYIhKc+6/ntiQEhRbB0fkg
 etz//bE7UNaaZLDyVqA2S6cAXmGGdlEJoLY+4nrgzuGL5rJH83HLo2asXLrT103Rvcv6
 roGuOz2Objw4z37gB+JL/B2yQjAboF3fB9n/Y6/2ftczO0WVchoGEDH8+YxQCyIhHb25
 31Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608001; x=1732212801;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p59DgOp+Mmqs5+ykuXp8jnHOA/wHzF3uvAU6cvOozE=;
 b=Lf/DEyO2mkLsWxQBE2iJO5TS0Tzn2H4k4kYOgkdV/dbBlf28V4zOnxm2g7kxjWqqJU
 xZ/vtDjgUZceVe6o7EWIcciJfkYtl2dNuq4p1+fSvU3X+B6KjzolF/CMvaNOXLKTrXcb
 VUV5fFZTgVryM4acmCMs1226DNCJHxB39Xg2kyopCGJcR9q9DE4x7KHkV2hz7kj5yFXf
 Eq0CTAq7k9IOgphYfL62obHv2tjAbpMJ2rg+6l0z6JtOu0AGEwL/yx2Zlhzsvg9WP0Fb
 E3chQgeyehuOh1rXB6BVjhZ7PBu0LCJ6Xw5bD/VXcjjwe5+1VGdu8NbdA8nE+ncUSTky
 dc9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmhepxarYIafpqghfzDzeSvqqqC+sH9AYBzilfMcKnX62IRCYj5E9LdNV/TVOMtkkvqaXSbY8=@lists.denx.de
X-Gm-Message-State: AOJu0YwZm1ZFvqQq+oDOlWl2J0iTDVUIKSLclF7ip0plc6HvEqgCNfgf
 N9GhFTrC/pq9OaNe3kKxlyn4Yjw2/yN/xZlqy5Lg5TYxQdOBPJoy45NGxUFHV519lUCnvdjcjYz
 O
X-Google-Smtp-Source: AGHT+IE8R3ntr8rtFGEHuZKau/LIpYRl38ZyrTy5EN+g+s/nCa781gE4cR81/Cir6dMt9Ao9p2OQZA==
X-Received: by 2002:a17:907:3d8c:b0:a99:7bc0:bca9 with SMTP id
 a640c23a62f3a-aa20ccdabfdmr335791766b.3.1731608000912; 
 Thu, 14 Nov 2024 10:13:20 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:16 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241016-topic-sm8x50-bigger-malloc-len-v1-1-361b132ce7d4@linaro.org>
References: <20241016-topic-sm8x50-bigger-malloc-len-v1-1-361b132ce7d4@linaro.org>
Subject: Re: [PATCH] ARM: mach-snapdragon: configure a larger default
 SYS_MALLOC_LEN for fastboot
Message-Id: <173160799650.3344230.9504275002668727633.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:16 +0100
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


On Wed, 16 Oct 2024 11:25:32 +0200, Neil Armstrong wrote:
> Fastboot is very hungry when it flashes larges chunks, and 8MiB
> is way too small, allocate a much bigger size like other platforms
> using Fastboot.
> 
> 

Applied, thanks!

[1/1] ARM: mach-snapdragon: configure a larger default SYS_MALLOC_LEN for fastboot
      commit: 325e210fc0e47871e13a497c2c6883bd9a17ad5d

Best regards,
-- 
// Caleb (they/them)


