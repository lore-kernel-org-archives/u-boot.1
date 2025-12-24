Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E34E776EA
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A68FA838A5;
	Wed, 24 Dec 2025 17:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O1upuWV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0A5838BB; Wed, 24 Dec 2025 17:41:01 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3380838A0
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 17:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cac8231d4eso3728410a34.2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766594457; x=1767199257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJOzlu+dgSjgoJUGel4K2puWLlW7DRkwne0dBhgiIjI=;
 b=O1upuWV6nrtt3o/544dlTbLjZxxTW6uN89sYjG9O5AIq55fZoRHEVyAL0HFisSxGQr
 vtPPmKZRV/XhXKvwqPip2QmpQwv7AJWRtkextuGmBXunXnM7pZG+J2y0Xd14PYROFGJv
 YafRTXfPFB2ORcZAToO9Flpoa0RBPP9Gxs7pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766594457; x=1767199257;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJOzlu+dgSjgoJUGel4K2puWLlW7DRkwne0dBhgiIjI=;
 b=rrIVlRFFjkCzttrw1/gdGkw6h7bFnPt/OKCIADQmOg0smnIV3ohWrdz1oY1Ep9rstE
 ESfscHmBqQ48HaeH8dSJak8EItYoqkv9Ym1QQkfVBfrKb4hMF4B75YTXVz3NZqhjnl49
 yCCwjmjjEmTe1rPWNGHAlmH3sujsclneX89lYOenqescIl7f3NfEKRfX3wUrhc2mOLgl
 qjUvYcUC92HBgJVUGYrvp3uTqwCgNPm3a31fVoOGqpoqvJAtFeah4yblxOXHVXjxnTZI
 QwcQXFh/fenANyeba0PymlDkYl2403rUZ/JZ+8o6fwlwWxfPDMb7S3L/Yc90nsG8r3Jn
 7qhA==
X-Gm-Message-State: AOJu0YyYWAIm7dnndMCKggaVKMt2eOJu1MluN6O+VadHix8rwz4S2Da6
 3fDydXa+vt/aTj7twyVYsOn5rxNxRqzW8O3sgdc1RxEh0lcBHi5H1JcFx0MePrgFHlw=
X-Gm-Gg: AY/fxX58pR8+gD7VRo+Q893xgLLC98dFAtjN7kC8pdNzxq4PP/QY4eWQhQQuuz4XKai
 MzFTayJ91LnzXy7+K9bj9c+oclxTwvkG9uVXrFleZP3pMOpsBwZBOMEe1GF/bUAqf36JR+VJW/u
 6Igkl5QltiE1YarRdDpBai6VwBudW5VPVJQwpLXzRmDxwWr61y40R/ESEUX07CsBWRLnUM6dOBp
 WjwFI9Y9GLHeIJ44dvph0bpYGVI+5tabOdgZ/dlfi4RRjUSVdAPn9pkOUBv6l0GHzyLYeNApK2l
 MUpJ7fk+BuO0LpB8ysrb8HMskGm2/5xy+yuJ42g13rADJlrJFH62xKjYBqDnwf7sGWNLKAruSAx
 dsUZEafA6D7EPIdc/dRGHo4rYIKYH8AIvAlSFEhqEQSsxp4LMXZYvsXWwjww+fDdnwd5OF8hVp0
 Xp5PebBjLswSOTxgda1vn18/0Uev5YMYuLsugXx+a6KzzaQAoE
X-Google-Smtp-Source: AGHT+IEHMTIjfnSM+ZAaMUQyVliO0FIgLn5mFpNTtM6I40XW3wF685BO41F9P4Y9Sui6DpOqqLUzng==
X-Received: by 2002:a05:6830:448e:b0:7c7:827f:872b with SMTP id
 46e09a7af769-7cc66ac20b5mr11356326a34.37.1766594457335; 
 Wed, 24 Dec 2025 08:40:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d572asm11653541a34.14.2025.12.24.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 08:40:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 quentin.schulz@cherry.de, peng.fan@nxp.com
In-Reply-To: <aUuZKcBaddeEk5ov@nxa18884-linux.ap.freescale.net>
References: <aUuZKcBaddeEk5ov@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-power-next-2025-12-24
Message-Id: <176659445649.713650.6564742159880615964.b4-ty@konsulko.com>
Date: Wed, 24 Dec 2025 10:40:56 -0600
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

On Wed, 24 Dec 2025 15:41:29 +0800, Peng Fan wrote:

> Please pull mmc-power-next-2025-12-24 for next
> 
> ------------------------------------------------------
> Various Kconfig prompt fixes for SPL from Quentin
> SPL_DM_REGULATOR_GPIO and REGULATOR_PWM dependency fix
> ------------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28831
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


