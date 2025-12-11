Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D1FD41C1E
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E36E83B48;
	Thu, 11 Dec 2025 11:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LxENEw0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABCF83CAA; Thu, 11 Dec 2025 11:46:23 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A7D83B48
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so5829335e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765449980; x=1766054780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1J3wTFCX5hYTGd87Jdwk6x5oPgkCI1MrQQZ+57Bc7s=;
 b=LxENEw0xCRZ2U+HEBZEoEsFco8aQWf1I9C0xGLhM8NF+eYn3WZYyMNnUlS4g67+BLM
 pfuBfF50w71tzXX9mup7oz6/gkSy0LSBU84pGkLcSnLfF/fHbCKqonV0rd4+oXzPTS0K
 b4cdPJPhFLtotEsIQV8Q729Ju8hPUMN+LM4GO2vANJNuLZI6ly6uSbbxi2JjASFY1SPf
 JM3+zunPBGwaZm4u1+vo62mYhmM04Jdjcf2IQRR+49tSbU/JPpk1ZGRfLDLjPnzvu9eM
 Flp+Jl7MTd3dcQxW8u/Uy+EjdJq2hp1N2z/YQVf869pzqrbaGxhYN/gbvYI497oAtQaM
 1v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765449980; x=1766054780;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g1J3wTFCX5hYTGd87Jdwk6x5oPgkCI1MrQQZ+57Bc7s=;
 b=Pbz6lK/OFdgFYe2G2OBW7uAmiawWVRonPKBQ+NNJH5peTno37wm/oTZ7zGXr7eEtjr
 +dS8/pamC/uXIModBUBZJ6ZBUP40qTQfTBhBAd8hJEDEHhJvrtIpjRvHbDtPjdlFJIkz
 5n0qXdEUIYpjP3c5ZmIA8YNJOWeELergkHmUbhCMp1U4WtDIo42isac7YDvBEUrXMcfL
 ewqCUhAril/hHTuEJphj3LOSDfkqBdstm+1SMrvEV7DtY+/4PU5rEAz7yhej8iTIeONh
 2dyPbr4XIQUZ0EiwfK/OvIqB3RBJWjhP2SKCcDXCIgx5kPmlHtBLN4zJflPG3p5+95js
 CR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA/guiQtwaV9RZw/XSiMZmymlrIsfkljTWP8UJFMOE3DIzxOeVJwoc3yjUHNt0orJkV0/nHSk=@lists.denx.de
X-Gm-Message-State: AOJu0YxdPl+5I7YQu7QXfwEAyxJBJzJSon3GIvJoJ0DThugug4mA83+B
 N1DhH9sj+wTtZz3OZ8+N0XqhiTdB6qT5V9WOW2z8hJpIv+gcI/ZfJp1qmeG8tQRpPBg=
X-Gm-Gg: AY/fxX5iinX7MYX5RL0/LZYYz5EOfmvHdAUBhgYlAKOFH7vcIq3vmBQSN5kImsMSLhf
 PID0oNrX64kxO8+D6bvaJYJB4LIidAAj/1XjCOffn0pdf9Im/2ajkPq84LyzOVuRy5Z5UJ3ZvV6
 3OWy7HB+uhXCN8+pM6vZkY1salURTukg2o/E0q8FySD9d6i3u4ljy8XzUwe0cbM5uM9rzUoqunO
 MjEe2CAR/ruV1UZh19Vu6u6+jsGiNlHuJ/C0KN27MAfU+DQGh0glC4Pb6gqY20mTDxtp9lGCPKG
 Mk647bYNJWyYSLwEZF65Q8DSCH9RxChUv57hLlKkSjp2qUbiohaZY7xRHn1/uSPbDB8R5MfUHkq
 hiAhGAvPi6ygm5rNUaCEH3IVfjZJN4XA1sdWmvrQzqjr+JxbiujToNkUcn2zodT285fKyNPRQ7q
 OhhXGHqVP8w0deDUDPgMQvcbjpTcB/JkXWu/yvXvenWA==
X-Google-Smtp-Source: AGHT+IGgpr3s78Xyl0opWnc5GrmRNTJAUO7j5mYMnyRRlBu5cmZvseh/MXcwvUyfCExbGol2PRQ+Rg==
X-Received: by 2002:a7b:c8c8:0:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-47a89ecc772mr11837645e9.11.1765449980031; 
 Thu, 11 Dec 2025 02:46:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 02:46:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
Message-Id: <176544997944.2550755.16914870841985844365.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 11 Oct 2025 18:16:23 +0000, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
> 
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] arm: meson: add support for EFI capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8758e1f67a38e707a7c85cb173f5a8d9324c897a

-- 
Neil

