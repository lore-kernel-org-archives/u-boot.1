Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC9AC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9055C80F96;
	Sun, 26 Jan 2025 00:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dCdAxR7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C167B80F80; Sun, 26 Jan 2025 00:40:16 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A260780EB5
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f0afda3fso304868985a.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737848413; x=1738453213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAvOTZRT/XxYoQkx7hzEJJc7k1RrRHUCk77R5CtIq20=;
 b=dCdAxR7AD6h4L7WxYdKp2pom9CZOcf2igjGWPmEUppogDpoplIPqHXf+Yrc7jfECZd
 0JYKjA1KqzyRAr2/gqNCOI41gH7WbtAu6huFmOLYxqHQYF81Qv2NFRiaMaO1u9yMpM/j
 PfCn2DsRAr7dBU3MenNfn8CcBXKQUWXjFEzJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848413; x=1738453213;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAvOTZRT/XxYoQkx7hzEJJc7k1RrRHUCk77R5CtIq20=;
 b=L+Zu4rYMU+SVy5bioxImSxjOZsRX1NhHyZr3tZce9xItJdtAg2rmExOSo7duiIeeS9
 H+tVbNzuyMsmWGSu4SyK4iFFNShC0/kv+njJlau+NhOJ4ey8Ftd/36G7UO2j0dEEjZuZ
 eJI3uceqGidzFpPjiTq4aGrmD6+kPudPWDP4lowggfHOvd8ItDqA6jP6Zjy1tPUDYOmr
 CEx1XxLv9rECvSGvzRoZxIoSfdxGTvnr2mdDm0Q/b980i2qtGSC5QdxRhzBijePAhSgE
 ka1YjsmWGZhSN+JYgPHkiiQYndKpPICqFqWfkBY6+1zLc8bz/zUnnjuvYi+MnRiUbdQM
 2YqA==
X-Gm-Message-State: AOJu0YyHKGlxcWgrlAxlWs7PN0CCRZGWlTS+LL6F/DFbH2sfWqugpIb9
 8W9UBbKN2TyFEJbXaACKyK4Kwfv2VeWXSKwH//dU7LJabnNeEk73PXcuUlV7K/8=
X-Gm-Gg: ASbGncu4D5D3Sd0bMBv/Ym6EKPILNpwyyCEJog/0JIO6jveORbixUmSudizvtxTGLkr
 OB22esvhyqdEVXs3exf6T70Grn3zZjRRakavIyyNeL8+MxWk6cuDuMD0SDhFyX16e8qFpcN7r2e
 sQuvrcmjErkQk40dRaFVL//KHeMLIg/MTMF287VBYqhP9YaY26ynJcj0TSXbDSTsPhRpywrL2BJ
 IPkQeTbc42z1PAz81qEQZIjiOz8DN8C+Q3Bmb3rBu2kXs4di24mkv3atPbs227WArniHGuVL8ZR
 vb8=
X-Google-Smtp-Source: AGHT+IE9QT/feVlznu7qGpzQsxWmX+o2BYw64wNM9CFTYJ2em1fheGkYCzlFK/dhX/Dy6E9Ul5FUpA==
X-Received: by 2002:a05:620a:3915:b0:7b6:e8c3:4b5f with SMTP id
 af79cd13be357-7be631f2f9fmr4942895785a.16.1737848413621; 
 Sat, 25 Jan 2025 15:40:13 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d48csm238979585a.110.2025.01.25.15.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:40:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241216233853.2125656-1-sjg@chromium.org>
References: <20241216233853.2125656-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v2 0/1] gitlab: Fixes to get StarFive
 VisionFive2 into the sjg lab
Message-Id: <173784841128.1163385.5405715090788987418.b4-ty@konsulko.com>
Date: Sat, 25 Jan 2025 17:40:11 -0600
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

On Mon, 16 Dec 2024 16:38:52 -0700, Simon Glass wrote:

> This board fought valiantly against attempts to add it to my lab. After
> several hours of debugging, I found problems in the Labgrid integration
> (not included here), test.py and buildman
> 
> This series fixes these and the board now seems to be reliable enough.
> 
> Note that the board fails test_dm_compat
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


