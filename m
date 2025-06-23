Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6713C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF4582E66;
	Tue, 24 Jun 2025 01:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wzJOk4yF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7CD82E2D; Tue, 24 Jun 2025 01:49:37 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F01882E50
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453647147c6so37466905e9.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722574; x=1751327374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RE8xQt5mq0aXXJBlGBzuN6t+T/JKcnxpoiO2fkOMrjE=;
 b=wzJOk4yFEI/mpbJokeWYN0wuXBVvl3uUHb3iRELXDULLjcjac8WnU6jU/iq9RdYOMd
 VkhSVSFU18GixQ9zvUKBL07IUbgINLKWjRLIKGP3QeRfS+A2ZVhGRFmuRlNg6MTU2LTK
 LWsmd4+BMuIwGw6Hssmt1YVBGrCgFIYVnknXs5eOtIYtH86muuqSy8sEdAqEMbBfmVtm
 06Ry5wxcKjI8SeR9ydfVYHFhpRBJr93OoJjvS4z+TUS7edPW5oXwBeITRWF4kISsG5tS
 eoPleeYrZ3vAnH12XuiDjO1YOcwaD6NyOtB1i3FzBKtJ1vvqkIIjEatlwPvCahrwlY4+
 KXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722574; x=1751327374;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE8xQt5mq0aXXJBlGBzuN6t+T/JKcnxpoiO2fkOMrjE=;
 b=wklgTKGbEun5xduyDlbVSjr4hEVFOU847ZWLBftapw43YvqHNxqboHgnZ+3IVF+/s5
 dH4O+vyEC3t7pCIsgN5WMhA40++e6shDCBR8BSd4UayDKsxC6Y59WtDQG1qipV+mP5Jv
 WprnzSF25IFpJJoNCbpDgsnn45k/dGOmUvzt4AUKeop38er3+lCk0keCV0iHtwInvCQJ
 8RuKqR6DoRRSYY1ywWk7DgYWKOyrIvlr2ELGGHO0wcj4/h4fN6OqdJo7AvoyT+/69az0
 Qhqa7sVXKhBPBMq1JhCglOa5B+WZRn5WdYZlq7Y/Z16NoZzFB0D62u2lip4nSh7+bkp8
 6ApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyZVBJRuIDNCG5beLFVgtVK6mahXVjZ60xkykd8sEvuD7Z2jyDEZzp25GOS5aLTcfpS5BVTaY=@lists.denx.de
X-Gm-Message-State: AOJu0YxWoip0LAsomRq8VlJLAcnzdg9ZzAo9q+wRWbF78cCto1qXZli6
 5mLBAc2kZ00LsIluKOm7kfBPL1SJbExGHekxS3aGIv77Z1bwkR4Seo+wF3QKmv9yyBM=
X-Gm-Gg: ASbGncuCF0feASKqGyRIVoE2RHrcfHu3WnFvdefi+CiwEEdalIIXcfWCu7wlHG+jOMZ
 IP5uw3EIGr1wMtnUIW8TaIeFdLdfhef7M7ri/58+5NWNLSNgbxxOOFDAjwfTfFli1EHV+jN7a/G
 p455Gpr58GHVHglXCcvdWSNaJXq122DdfJMTHAO97cZbSz+DPFt98VImNO557VbIjkwp0o7MRiB
 TJxbkJW3zYZzT4pRw75wSAr2I7BZv3PkI380L5yD1sI7Kz1w+xMLqoICVBzt0YSDafWxG2Tb3Dv
 EkBKSCw6uzgpqYOH6uSZjXq2BLv9xUNxre/cgnQzipzLLVNSCJaazORUfD1E3SDpR8GLksM4DX7
 bsODuQ9okTFk=
X-Google-Smtp-Source: AGHT+IGZjCqPn5z14sEYy2WJ/39nYMBDFGPqA+TTZlA6AYtntPP2dzWW+RvaqNbkfkBS6o0xoioE7Q==
X-Received: by 2002:a05:600c:1ca0:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-453658ba342mr116363795e9.19.1750722573713; 
 Mon, 23 Jun 2025 16:49:33 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: sr@denx.de, trini@konsulko.com, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, utsav.agarwal@analog.com, 
 ian.roberts@timesys.com, hello@paulsajna.com, hs@denx.de, 
 bastien.curutchet@bootlin.com, nathan.morrison@timesys.com, ravi@prevas.dk, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] drivers: watchdog: qcom: Add timeout configuration
 support in watchdog
Message-Id: <175072257216.128390.15109851083936268304.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:32 +0200
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


On Tue, 27 May 2025 18:19:26 +0530, Balaji Selvanathan wrote:
> This patch enhances the Qualcomm watchdog driver by introducing
> support for dynamic timeout configuration. Specifically:
> 
> - Calculates and sets the bark and bite timeout values based on
>   the clock rate and the requested timeout in milliseconds.
> - Adds retrieval of the watchdog clock rate during probe using
>   the common clock framework.
> - Adds a default timeout value for ARCH_SNAPDRAGON
>   in WATCHDOG_TIMEOUT_MSECS.
> 
> [...]

Applied, thanks!

[1/1] drivers: watchdog: qcom: Add timeout configuration support in watchdog
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/35811a7b0d68

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

