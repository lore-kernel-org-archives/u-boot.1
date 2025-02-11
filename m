Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467EC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D088043C;
	Tue, 11 Feb 2025 15:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LGtO+o8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA0C80AE5; Tue, 11 Feb 2025 15:18:05 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73812809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f49837d36so64308565ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283481; x=1739888281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqhpWPuCiHLYHIva546ZcmEDBZnryUdTv7Ey4stJyZM=;
 b=LGtO+o8CD70cSbT9top5rUlTjkWYc0gvW/yHz+oM3CIZfg6+zyqTUvQhoEdOfBeN50
 iiLWNPsm3bAA5jFGmMTEkKoea0/J7V2XH/pm4F3/C2cPex3AYeynPmyf5FnAqIlBt+L1
 MhBBh3O0V9L7Of1dpVGG7PDtoIdxf4DNPGeT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283481; x=1739888281;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqhpWPuCiHLYHIva546ZcmEDBZnryUdTv7Ey4stJyZM=;
 b=WOfLmDz4hNUY031xAqkg3v0UlLENBUkfsfRZH66BWlsWiMVgzJBBhbDIc1rtNOlog7
 984hI9zpIBSSP3NrPRGY+pHMWpuv5DZFsG4VX0bphdlYgs5ChshvM+odY/g1pwS4oktk
 clIfnitdLi9dpA6Nlu6lib9pb+sebcZxYvtFPV0JByCSRG7iHklcLRwSu9N8VNlm9CiY
 QJ4D1SsvO6JHx8rDnOQhxf8fSNo7EulC6lPsIgOeUR2ZjXhpY8IsTUO1XQTgpmRdRv4m
 QrEN50thl5XGyrEwvn0VWUpfwVKI8KwgzUKv8Xm6E9liJTCNZ7mcAUpsvegVN2g+/xU2
 2cKQ==
X-Gm-Message-State: AOJu0YzN3K7EXipHjKFyX/w2SHU7LCCC2vlr9CJgp5Q8MI+wnPgYk1Hx
 SSQ6Nvyod3pmEYFUpGOMxQRf9EI8NgOJ5arIlSzZLFxtAFalfKK6MUm0K2r4C/k=
X-Gm-Gg: ASbGnctVv6tgzbBNj0qlpWn6ARuag0xg0IunWCdCIA/eAiSNIBII8MPW8+q23LPbUq9
 hDqjEfK0Nqixpcm5lGPiZ6BbhlZLLzBFgsGP6SzAQNyg5OMK4K+iuwU+g9xwZDYfEHdPTZDA8RK
 yEfleE+Yamy9SdWEfvsal6r9ohtI+EoB9lFhBdNm+U1aM3UiTqhWWiQKg7QTsOlC7GoNo52DLaD
 Ah7Ug9t13xX9nFmWew4zNRCl624lVwGl9vgtv5XKPqGZMSpUU2k3ibzOD4eF2I70eOyrLH4YNuG
 1ymDYVTPzFNPeA==
X-Google-Smtp-Source: AGHT+IGX1hJs7PYiP/HJQjeHlOMby09nsuv50fW58B8kONfkhC0/BYK38VwsACLvi0ztSfbvYNnMWQ==
X-Received: by 2002:a17:902:f78d:b0:21f:68ae:56e3 with SMTP id
 d9443c01a7336-21f68ae57dcmr215465015ad.39.1739283481005; 
 Tue, 11 Feb 2025 06:18:01 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:18:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maks Mishin <maks.mishinfz@gmail.com>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
In-Reply-To: <20250202170542.2065434-1-maks.mishinFZ@gmail.com>
References: <20250202170542.2065434-1-maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: ublimage: Fix memory leak in parse_cfg_file()
Message-Id: <173928348022.3071479.17053727217623021416.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:18:00 -0600
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

On Sun, 02 Feb 2025 20:05:42 +0300, Maks Mishin wrote:

> Dynamic memory, referenced by 'line', is allocated at ublimage.c:159
> by calling function 'getline' and lost at ublimage.c:184.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


