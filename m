Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEC0C982E7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE7983B55;
	Fri, 16 Jan 2026 19:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qd9JRlu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397F583B49; Fri, 16 Jan 2026 19:03:33 +0100 (CET)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E81C83B2C
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so3286743a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586609; x=1769191409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X91804og3sQILXLvAgoFFIxDMU/Gf+vfo+CAdVC3Y1E=;
 b=Qd9JRlu3+Ip0T/ZBgHJs0+j2bl5ZTtB5/ru0NOQfeBdRPwUDer801WMgwaFBwXjs82
 ILsuLGpEey9TF4yPZ7zKkgOF8x9zy35Kge87raVpLuuqp2+1/QU+5UIRwvWQPWVkH91t
 lYE2lWjzN8XLoE00RC/DJhU+aQMDpN3qo3tEelcSXZ6TZatY9IRj5Hw6hTvE/LWYSWYe
 oxZlM2sm8uUSf/HqyqrUfMLhX5gP57kUMGgwh92Alr1d8h2+BypV7XIDuucNKnCa9LDk
 4tB/AcI9s1q5Q1qqv3v/k4TEoeJ1+F1Grcxl7ndDcfaDldjEy+CeMLyyVfiBpFDo4J6V
 qfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586609; x=1769191409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X91804og3sQILXLvAgoFFIxDMU/Gf+vfo+CAdVC3Y1E=;
 b=pODOeDHu1ftNq70JTynIdubXynWMQm4gHGv2MKyuUJWgwYtOQcQJRYSfPw3yaVcPfX
 I4WHlVvqFs4VyVsZV2bItb/wpFuGl3RLptX8MRnjSM83pc9yBhsVzg88RCYinlPbXL0s
 n7oZhwKUk3C4BdMDxWuwpT8F3aLRtyCU3mLxSI0P60ab+RPcN52lGLuISEHbeZguMMdl
 DCD28vFBWtiIs9ga4pelLuOCcpS6UYnDGRB51qp2EGWTTyfNM6Dtd0hGJMSKYCbWrs5N
 GCHmXQESypY3+Cg8mI3wEgtB4N8R5nOK2zg9Qg9AGlwtaU02AKPK381skGpQdbldCHXD
 g2Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu9CJ5dqFnzGoazbCZ799tvNnc64q60XpS1k/KOV6n33RAyHp5CGAMtN9SCQkL22P5AgbdIng=@lists.denx.de
X-Gm-Message-State: AOJu0Yxavg680d1G8GN1o2iT1NSDSZDt7VpQ73rDooxnbMQqXeJdO5/k
 Hih+ezLwq/lNaQ1dYiDOeQFqlOGoXilcmjFB+WnOFIKlFk0JjzXkQBQN0co/a20qEiw=
X-Gm-Gg: AY/fxX5zUnbCkNtEHnPd02cMTDQB1VtYuEuNE8genlpbTMkgyCw2oMDJuRRkTYKHiW1
 mS/R84JhvKQQXefgR2U8VQqd/QNC3Sw4gOO8mUfDf65Ahyt2FMT51RzVZBk+Cr4rGCJxNl071jB
 0mk9OVUb5VCxcfudHgB/lyoY1QNZzY+OqXsrXiVtD5Fj7bVMKxWclXn057cnjs/PwdxDwikbQTO
 498uS7BDZ3aikfKTxsbdkQglrDR+VpIydM7gI8WoXuG+maCrXCiUA5D+UPP2cCcTMZ/+ZHHKMZV
 CvOeptb/VD+0OEFeQeeO5r7Y1c8i+5qXNImcUaKwheRBkoVzayaKnLqyiqv36dkMHeZEkn2o8ba
 4rSAO1bibB/UtYtRCIhZN9YR84kcX7Ydtj1GNs1UPyIA9QZlDMjDbAGWNUnUNt7xnIck2iM2Vue
 jcLNqvKfjqbQApXFH7uGPSSNp21NjAAImYWOLGFZsNQsxM2SKhkDIc9dGxZMHk2WAd
X-Received: by 2002:a05:6402:2549:b0:653:7bdc:9561 with SMTP id
 4fb4d7f45d1cf-654526d2b36mr2991228a12.15.1768586609445; 
 Fri, 16 Jan 2026 10:03:29 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:28 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] configs: Fix fastboot buffer address for QCS615 and
 QCM6490 boards
Message-Id: <176858660823.3399278.17000677438725692285.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 07 Jan 2026 15:20:38 +0530, Balaji Selvanathan wrote:
> The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
> NULL pointer dereference during fastboot commands when users dont
> provide "-l" option in fastboot usb command.
> 
> Set it to safe and sufficiently large region in RAM
> of the QCS615 and QCM6490 boards, to prevent crashes.
> 
> [...]

Applied, thanks!

[1/1] configs: Fix fastboot buffer address for QCS615 and QCM6490 boards
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cb07205adb5b

Best regards,
-- 
// Casey (she/they)


