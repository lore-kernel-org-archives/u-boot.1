Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D56D1CA0E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7118900E;
	Tue,  5 Nov 2024 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rp59QynJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321A088E7B; Tue,  5 Nov 2024 02:07:09 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F8288CF1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso34482136d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768826; x=1731373626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ExWYgmzWPr+Kmhpg70s7PgaMzg/toB1JGg19TrVvcMQ=;
 b=Rp59QynJC5OCcqG+itXICbN4rz8PJmyvGpGey1bI9BjowaDzkWZC3AxGrfJ5EfMm1Q
 FMf7YPk4tXPDcGt4WQ+jqe8oM33ETX5PXW6C1okaixVTyiOeY5BOglYC4zPU5BQShHaw
 CqyLdSwGosKPzCLGjKp/XKacvR/0LVfp1Ov1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768826; x=1731373626;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExWYgmzWPr+Kmhpg70s7PgaMzg/toB1JGg19TrVvcMQ=;
 b=W7TBHWnN3mFJmUCXN/hAYKvwmx/QFka8x/yYdIUCgKk2zRxJilhYJ2/1jyBamTBSsT
 pA/ZdmR+ohkhQT0DhDNXnTpg5TxAX2yP9XyWr9Uko/lso2qsSChgwm8DSxL5asf8j1r7
 +u77MADI6KU+wwt1lmDwefXUFt3PBRBD8W+LapqvGm8yyeNXLKXkZPntY6e7lZqcC+hn
 Uu25rzX/FoYCfyzGvQwGkQ2X8qUsp46m3OTc9u4Ay0MRIGL20fQEfgXtegk6yvWLR5ow
 nmvMe29+HwINgrA4dtWkEByJ3p/ysDVz8mJj5zLe0tI2xR6nD7PeUVfU1yzirAQ8wXsN
 FTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+XrNd5vGtf1JSNGuJE7gerHDZDN7bHt2dBXQxGMqUoQ0Wq2PNTJfgt7U3DS3TNfjBjzK+en4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/yH52J9NAfWWzgdiTJGu8fK3iyuE0vmCRGPmsx5I2c5MK+MfM
 o/pjQ0AKYR0kHZKq2AHC887MRCKM+napRiD6hOwO0tAnknYc2cPWV+I9QjCcYa4=
X-Google-Smtp-Source: AGHT+IEgFl2RzADBNTATfY3WYSpi3cniu/vX7C4/IWTRXaKb125xczUQ4jG7kLhHLQXQ1WkEpQulFw==
X-Received: by 2002:a05:6214:3993:b0:6d3:452d:e1ae with SMTP id
 6a1803df08f44-6d35c1af3b5mr184414036d6.45.1730768825947; 
 Mon, 04 Nov 2024 17:07:05 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Usama Arif <usama.arif@arm.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Boyan Karatotev <boyan.karatotev@arm.com>, 
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de, 
 Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
Subject: Re: [PATCH v1 0/8] U-boot: arm: Refine the booting on Total
 Compute
Message-Id: <173076882457.3917422.12939560597045787769.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:04 -0600
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

On Fri, 25 Oct 2024 18:18:13 +0100, Leo Yan wrote:

> This patch series is to refine the booting on Arm Total Compuate
> platform.
> 
> It changes to use the info passed in DTB for initialization DRAM info,
> and dynamically initializes the booting envoironment variables.
> 
> Another big change is to use an envoironment file for boot commands,
> based on it, the series extends to support multiple block devices
> (MMC and virtio). And the env file is extended for booting Debian.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


