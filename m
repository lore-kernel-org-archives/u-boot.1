Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA09C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4C2680F5C;
	Wed, 19 Feb 2025 03:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n4QTRLw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A247C80F18; Wed, 19 Feb 2025 03:04:51 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2BD80C8F
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso5869415ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930688; x=1740535488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRRYY1YVHaYwxsDK0PGJ3qsDe8fZfF7xgaadoc0Iw38=;
 b=n4QTRLw0P3J9sKPjtCH1JRLu6ZM8Td8b7LGwIghlmRWHYrVde9Hzv7hMK0Y1UjRGly
 SNvyzvWK3IfPxuu21iASv1Y+UjvWY9zE59MJgFtv8UMJ/IZ4rY23kMsldADq0R+9A6hJ
 4L1v57usqo8Ux6/J0g62gTp1tS4zDaBTbX4Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930688; x=1740535488;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRRYY1YVHaYwxsDK0PGJ3qsDe8fZfF7xgaadoc0Iw38=;
 b=S8KbyY7B82U+tXxLz1V12YRw8aoKR1B96NZ6MFetn0kuYe/EirxaFc1DI/d9D27wG7
 f9j/ZAm4GSAafOOHE/n6+q8PR/uPsLjIlEh39Y8HYC5IoK1NRUdXhdz/z08rXoSpp7M5
 zqsBN3AlfDaq7uSHnHzusVpsMkeWF89J8+L029C8pCi/U2HO9AB9E2dwPbnhhC0NSP7o
 owBMTAxRa0kRFTRFosvoDhs3ksdaZzypGu8snBl/jsG6qnYwYDQNmxZgRHG+YVWcHrYC
 +UohNeh8JGTibHb8J7w+ziWqsc7fSSGf1/3XIqluUq1d/bnG+t3He+lAcc+SSdxfwNpE
 5jCg==
X-Gm-Message-State: AOJu0YzmMdsmHhkizI3qJqv6Tknd5ifQ+2EeuPiy0T3ZtyaS4k9hUyIe
 4UNinZi3bjYUWu1YdRy9pR6YXzIFBx68qecgjpOhAuTbymFnuffICFA3ABweHhc=
X-Gm-Gg: ASbGncuUf493xLMz7spTtqMtDJPlA+IuWURppdPmLKb/jNmr8Ys82Z9v7VgjMiHONjY
 OC+Nvk/bwdgwoK2MfpyChh8YNDaG6SAsBVUlPniI4B4XF8BAPXzO/9/CPwqchXjNUYL5YiOHeu/
 THWf1ETCfwgzvSazsjdDks1wrbgIOqqmHatnhHnkri6xmbNQgbJcHCGHhosTv9T983pPUMQEKK/
 vjr5MDAh+JGXwGHE2dv4qiFRsBzoA/z8JFOqcsdn8rigv1IpfnP/rMuwHesI98T3PxRU44aKNNl
 Hc0GasoHJ7Rw
X-Google-Smtp-Source: AGHT+IFBAiBLuASeN2yJjEGfhuPfwQ9dPO70ICIsa/YXOZPpeiu/ghQQfs9AAeXou6TmftF1bURmqg==
X-Received: by 2002:a17:902:f541:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2216ef0c858mr34236125ad.16.1739930687955; 
 Tue, 18 Feb 2025 18:04:47 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maks Mishin <maks.mishinfz@gmail.com>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
In-Reply-To: <20250209154621.714878-1-maks.mishinFZ@gmail.com>
References: <20250209154621.714878-1-maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: Fix potential null-deref with result of
 strtok_r
Message-Id: <173993068711.1662848.13294254427908703378.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:47 -0600
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

On Sun, 09 Feb 2025 18:46:21 +0300, Maks Mishin wrote:

> Return value of a function 'strtok_r' is dereferenced at kwbimage.c:1655
> without checking for NULL, but it is usually checked for this function.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


