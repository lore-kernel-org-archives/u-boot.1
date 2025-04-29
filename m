Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A9C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 10:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68F980BAD;
	Tue, 29 Apr 2025 12:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zBdQKjPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272BB80F03; Tue, 29 Apr 2025 12:16:07 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9EF809A5
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so35604485e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745921764; x=1746526564; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rDq+g/9Ohm3/0UuxNYaIAYjZ6WefRY9AIhVEgsBHX7c=;
 b=zBdQKjPvZjR0qhUAnGaaHkWHujzm2kZbgiQKDAVYpgDe4jX5rw6eF626V+5x9ykier
 xtBvZpe0ZWBAju12wy/8x85nbJ+gAKeGvUJzBp2KETywDH2eG1+lLpeFy9G4s/oUYhp6
 ov1bliECKLzpzPodJslVvc1+l3jT7CZ/1X6tDGqflWoShgJWXy7dKbMJ82fc+7nwQtPs
 e9YFnnCWPZnLshYNBEUORlSsYp74KHUMIJ+6+GzTEtz6mJbTBfJ7JXd6kEuVHMWxumqT
 oGVKegbBNrfl2XsnvLBVF42kKE6HRem0/gBILyDAWYFTk0vFv1C9XiJ41n9qWzCDXRMY
 U6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921764; x=1746526564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDq+g/9Ohm3/0UuxNYaIAYjZ6WefRY9AIhVEgsBHX7c=;
 b=OqAEI2pWJJIIoGo6lkjtqL8PSdxYXTOdTXVA2MjrqHVLMAMFZ5YXO2SxNt/tp0PLOf
 uqkwD7wxOctQHXqn8q3i31Yr/Tb0T3wTQVQNB/UMY5eB2i663ndoDSMlkrJmqfVE9xkY
 8FoVTuf9VtJ9a2MvCXRq/QmXq1oUFNNcINUK2v31rVjB7BDSl5AFOCJ73fxU4PoU01Bv
 EfZxMZ0bD2nFNDlvB6CQvRC2QRdx1Ix18a5Is485Qi9OOfJ+R2GTI3S4pOIkfZ8svbW9
 xxGMxd5IZxM+WEM3kIiyTumxJhXdGfeK3q2ROcBr9b9yHq3dI6ViCx5lDIMoccG1gGGf
 GUxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVt5RRQxPVG6qQpkLIv1uN5FyH+TwSOKqYDSsUjQs5pfXYDQSKeZKs0ao8aZ6FMaIHXcaFR4=@lists.denx.de
X-Gm-Message-State: AOJu0YxGJQMCdUQ+Rif83MjpPA7HNKdU4kFGnIsgp+0SGQaaiHeOz8u4
 v8YYGaKmc3Fgj2FS7S6d//CMdW+ZDV2fEdG7d1roSMrW0YELYWH6D5K0xzBSF9mIO9AfsU3IdWI
 bdks=
X-Gm-Gg: ASbGncvIJsRA1lcoAOGrEcsykNuEXt3jS+v7TwbOgfMCIWL++7ymxCitDWAH1D//Uy0
 gcswfcitiN4vTCDZg4XTuZePXFt4qVx7nNpoEwyEmYQI/2U0XOgSxs1RfFZwfN1DepAH38l1IkD
 bYoJrjxrEtPloVwS0Beost27ramsFnUY5D+qXjLQK+ZIB1MyCZdQHrgKn7P6NX5dA1DESHcpU78
 gnZrpa4yAfJCA53wU8gr92UTorvX/zqDy2edl6xlOroTPrkHiMsJkf8U691sIn9Ac7rquC1TIs1
 NsGa2QrIEVb78PNffN5cBXTr8NZgHI6p8CvEIp5YjlV1bFioq8WUUA==
X-Google-Smtp-Source: AGHT+IGYJyorTJstGVvaGI9G8ZkzWG+kc8OZJFA69XEbFFCUJBY6KpHz90DIo6R1nq7qiuCyRknwBg==
X-Received: by 2002:a05:600c:1d9b:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-441ac85dc2bmr23626065e9.18.1745921763982; 
 Tue, 29 Apr 2025 03:16:03 -0700 (PDT)
Received: from [192.168.7.92] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a1544sm187774135e9.11.2025.04.29.03.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 03:16:03 -0700 (PDT)
Message-ID: <9b009d13-1145-4eae-9051-3837f3793749@linaro.org>
Date: Tue, 29 Apr 2025 12:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing UTHREAD doc annotations
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250428214040.GH5495@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250428214040.GH5495@bill-the-cat>
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

Hi Tom,

On 4/28/25 23:40, Tom Rini wrote:
> Hey,
> 
> As part of manually building the docs before doing -rc1, I saw the
> following:
> ./include/uthread.h:56: warning: cannot understand function prototype:
> 'enum uthread_mutex_state '
> ./include/uthread.h:64: warning: cannot understand function prototype:
> 'struct uthread_mutex '
> ./include/uthread.h:56: warning: cannot understand function prototype:
> 'enum uthread_mutex_state '
> ./include/uthread.h:64: warning: cannot understand function prototype:
> 'struct uthread_mutex '
> 
> Which should be fixed.

Please see https://lists.denx.de/pipermail/u-boot/2025-April/588263.html.

> I also noticed that with KDOC_WERROR=1 this did
> not fail and still produced an exit status of 0 which is why it was
> merged and not noticed until now.

That's unfortunate. I don't understand why warning don't stop the build
given that sphinx-build is given the -W option already.

-- 
Jerome
