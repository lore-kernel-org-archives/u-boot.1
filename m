Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5A1D73618
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 23:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122D58963C;
	Sun,  1 Dec 2024 00:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IGozsPvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBFC898B2; Sun,  1 Dec 2024 00:37:37 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2C989437
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 00:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d43e034ef9so23967506d6.2
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733009854; x=1733614654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEr48cVgzqHA6tlftCOi/AQiw+6eLL7SS+nsPrJaBfo=;
 b=IGozsPvm2HfImik6xO2KZxdb7Tz9raT3oiAKUUqOFFAEc2MlVTfClY3ribHta5KW7R
 1nnf5V21hqxMqXvRIqy9+5Q48f52/BYNHttJWkeGSwCfBy0eIJb5PdDC+3KnYAsi/7oD
 s3ZluVp1ELHVDtnZoeCCt0QHZp6XvAOqV61l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733009854; x=1733614654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEr48cVgzqHA6tlftCOi/AQiw+6eLL7SS+nsPrJaBfo=;
 b=waaXliXELTGMBaaR3mjrS0Fwj60TGcJfa/ySPZINfWYDhpC4RVElCOhqA1IUAtBH8e
 A32/WUPQ5bqY4Q9ls4WDLne5V6PolEm0rNWGrF4tFq06f92GkeVNZKFlciTTcFqMhuP0
 li3QJS+BKKsxiFj/g2jnACSK4HhGGI5JGKSsB6tmr2AnpU73q9vZUd5QRSsDy2EHpdKh
 g7cSKvD9ZODm9mw3olY/+7sab4UeKmO7K9bQFYxQnkIlI6rD2MTFdcCxtges5bclM6SR
 CvAxnHBaMj75LFei0ma92J0zHbcaUFeAfe1gVcv9P1iXAotv0oJyILB89/2S40gFcl4e
 4w+g==
X-Gm-Message-State: AOJu0YwRSUtR01ZHbq3hqKzxrLeVVYGsu9Xjz8Mto+fxFkizoIGuoAVO
 o/uRZGhkHs7lj28WNj/B3QEG+WAWWs70IHLO6KUPEtb+v5ZcrvlftxYZVK+CzDw=
X-Gm-Gg: ASbGncvhBTCHtA9NvV+Kkc79D/Dnk3TwxVIIzizshBU6FpaztVW2eNyMVzLiJkNexsz
 Y0L9tz79M4V2XxnnKKN1+o2UI+hJDGt+JFWyqlFs7rfk6n3kOU+q7eAhE+wsNIQeXSirf1klX1C
 3cZNvqS/rufoUhz5JWc1rcx65Hv0dnsplDNNOwrtoC6CioPd/eBEdVNa4LPk1Oor2gVI+tSQzKx
 3xWXCordlS+zAtrTJf2hDG0IXcpcoOI67eMvaHS8uwFmn6D
X-Google-Smtp-Source: AGHT+IH0TZuyntdNH/ZgP2ClvXy7hl/WUApa/MTTv2AYn3mcfxhwzbf5i362cIcfwJlgAIUJJDrsRQ==
X-Received: by 2002:a05:6214:5087:b0:6cb:c744:c415 with SMTP id
 6a1803df08f44-6d864e07c5cmr232703786d6.49.1733009853886; 
 Sat, 30 Nov 2024 15:37:33 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89b158778sm5725926d6.96.2024.11.30.15.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:37:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241126144508.501779-1-jerome.forissier@linaro.org>
References: <20241126144508.501779-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] net: lwip: wget: fix legacy syntax
Message-Id: <173300985159.2282108.4839153894367790554.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 17:37:31 -0600
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

On Tue, 26 Nov 2024 15:45:06 +0100, Jerome Forissier wrote:

> Commit 356011f7ac25 ("lwip: fix code style issues") has inadvertently
> broken the support for the legacy syntax:
> 
>  => wget 192.168.0.16:test.bin
>  invalid uri, no file path
>  Invalid URL. Use http(s)://
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


