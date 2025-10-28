Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43254CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 17:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEEF838D7;
	Tue, 28 Oct 2025 18:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCfL8O4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B0380422; Tue, 28 Oct 2025 18:59:15 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED01480422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-654f5173629so83887eaf.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674352; x=1762279152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fp4HgxVwQZMxmHeWg18DgswBnwZ1nu63PA51FQbwLGQ=;
 b=jCfL8O4+CDBGUptcfJ4Sg/EkkF1R82wIUMiSTcnNmJLFC/EwtEeqci09PAgkeBJ35n
 8m5yFtoDnLghFUX2t3/UfXS3N3g4DrL4u83Igq9+7hRIcUxptjX9T5hxoojDjsKSYEff
 HR2ntVxKBe63sudBTNnzOVt30wXZTVhmpJv2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674352; x=1762279152;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fp4HgxVwQZMxmHeWg18DgswBnwZ1nu63PA51FQbwLGQ=;
 b=YflirZHXLkAG8UHYixf/SOm/6//CQZ66IyGyPHho8J4W55qLHWjDQxjnBE3R0atsjb
 nH1BSRwaoVNaCzF8uVgC1sc7v3MAdiDLvCg5dl6SkOP5HmhipTvsZrLMRVrRPN1M0dzH
 tci5JVqITsZ7Y+Omm+pCdcW17hiuONgw9jAX5Jvi9b/8YXD4v9KYh2mYuwCEANKHChIS
 CNHMB1WUT1VA7s0RY2L8O04bjokemgcyWIKfkSxCYSJQ4qDf3z17B8fLDhsImgYAskvf
 jzVOVnnn7Z6JAFMTdG9xTG7hnA4we7myBLcaVUQgiPwd3YqXw/drRzx5Rr6+oYIB12F5
 zB9A==
X-Gm-Message-State: AOJu0YxOMDeeoGsvg8boF/9ewJeVf2AfrZKhBlYTfr8/PmNe4wGICXQ+
 h3SqX4Abz0laz2dkjiwHqIAa7LyaoJ3AlL3xW5WqGRQ4nyH+6KzgVnL/dTyU6PfugNQ=
X-Gm-Gg: ASbGnctanQMhc0lvsuHAdy/SzBDwvKXMIGbZqtIVWWbR3spU89VEhs5wRSYYouF7XR3
 zuvp+b5CdaLryM9e5c6AY/bUdWxWbACvRrQTHTRwmwIv14SvwIkRrBotoxvitMjk/Ys+zCQvOdi
 yYt5UQvmPbmbiuaGcQNae8vNAIJp9bdEsq8ujSnBB0ZWtrw6WqJo1Xe5wZIeOShSAdLikZW0s1L
 dApDz7lk+qoeLXzfYTk0YTW5HJ5fZqTJi8O37muD3fHLKx7i3zVkemPT3QMgcKAKL/Ha3emsE5c
 tbsN+0kT6N4cQUV/D5UV3zlvt82UWWpe+uvuxBAmLX8UkzY4asHdVUxNBXWuQ/XHaL6/0Q1wauh
 HxCoonUXYJo8+cgP/4QSPV2Y5GgLnoCmqDX8XpnuG8JuVVv1x54oWuB0AMr4ZAhy81MnQmZS52l
 tAGxgbri92SG0PMFMx17AOJW8hT7RMQUOf2vtSkw==
X-Google-Smtp-Source: AGHT+IFFt/GrVdYM04SyryATAsJKTKKqi6ShOW3D2VnG9EG9Gc1SzWaoHiV7JUcjXZyYr8zQb8NZhQ==
X-Received: by 2002:a4a:b684:0:b0:656:3197:ac3e with SMTP id
 006d021491bc7-6567011505dmr1156819eaf.2.1761674351657; 
 Tue, 28 Oct 2025 10:59:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-spi_ich-v1-1-6bfc94a2b31a@linaro.org>
References: <20250812-spi_ich-v1-1-6bfc94a2b31a@linaro.org>
Subject: Re: [PATCH] spi: ich: Do not use uninitialised value
Message-Id: <176167435067.2025892.15180061622543823634.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:10 -0600
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

On Tue, 12 Aug 2025 14:31:16 +0100, Andrew Goodbody wrote:

> In ich_spi_exec_op_swseq the variable with_address is only assigned a
> value in the case of op->addr.nbytes being non-zero.
> Initialise with_address to zero. so that it is always valid.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: ich: Do not use uninitialised value
      commit: c01280b62c44e2a6be57440939f1912e60a7d5ec
-- 
Tom


