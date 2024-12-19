Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA8E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E410802B4;
	Thu, 19 Dec 2024 18:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jXjw4NMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFDE8034E; Thu, 19 Dec 2024 18:51:12 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C098021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e24aa0dbso79893685a.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630669; x=1735235469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eD2OtH3MjfRwz0jGPh5V1nxWt6Tr3k+0GxQloB1LrAg=;
 b=jXjw4NMcMi1YWxyP4BYsXS9uSwW/pXjRUH1GGk4iAC+lwiipGQMmPWN/o8sjc2bSG/
 1RcO4eA7cI5W2YCALC/ATD2swjIyzxlJGH7VwW49SeaQz9C+JA8gW7Cada5TQmP9WRA+
 KYQL/hYpaFIwxFfa3cUWyhFTPxxnwxJi2IC08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630669; x=1735235469;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eD2OtH3MjfRwz0jGPh5V1nxWt6Tr3k+0GxQloB1LrAg=;
 b=eE13e4gZO1AJWLj/opgAS7pUJ65aRUhtQomim+f9etawtkrhSdgSXzYYN4DRTN8Pt+
 jN2NYPiDTkJz10in8gClM5ktFWgN6Cpjt35xeYGD4R6KgnvL0/95ObTaPqSVL40ccmDB
 le2kU18aAn0Vm49PcszI8JIjjrujmsVluHJ65VL2qMVURyx1fLcqpcthhQJPFlmm2kj+
 FON2Mk/EVEjewCfLzqu8kVbz+Erd1Fk21iy/YaGQrSsiC/zAxYGZj1jBNnb5lm9eRQ1l
 G16nr6As9mXjFruVGWq2Mvy5fIvsEBY2gZpBvXghZh2PLSQ83Orz+bAW3MjbnNxvibEA
 fz3A==
X-Gm-Message-State: AOJu0Yye3aOaV33Syolz7dap08n+DgtghqwvQO/yCASCvs+EpqJsxSk2
 lIUdhBReX3buTjqj+N1vG0JwrOzVB3gJ4qLhRJg74P4eRS0VsqYBbbm1rkDf+aAXtIpR7oYZL1S
 R
X-Gm-Gg: ASbGncsSdsf9W11QfkNxPmP4jm+TNkPyjoDNJOOCgssnouzmZrI6ZBpsUAeoyuZa7ot
 IhHAfhrwEFithaXtQSB5U5TgabR7GXfzWXHmNFAWxSNNjbkGDNUR5JzGPOfDzJyfDc6hPo+m+bC
 ClNn1662FMQIAW8kbW8oNOCBLARo1h05d78X2rKng1sKFognzm7xFDKy+hqhPnz/vf2fU41FsLt
 6ldMLCfUpeys8zG1o4qkiGTQRGvsfLJTwycV7CucdS3XZihYwIoqFg=
X-Google-Smtp-Source: AGHT+IHQ5AgWkhObuPVv9Qskpu3Hqc1C9C5nF34wKo45P3y6TApeg4lEUqZBF9zQ0vAp+wFO2sQpTQ==
X-Received: by 2002:a05:620a:7188:b0:7b9:a387:3cd8 with SMTP id
 af79cd13be357-7b9a387400cmr873131185a.42.1734630669126; 
 Thu, 19 Dec 2024 09:51:09 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478e33sm67004685a.76.2024.12.19.09.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
In-Reply-To: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
References: <20241125175111.1181749-1-paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v2 1/2] tools: dtoc: Allow passing optional input
 directories
Message-Id: <173463066773.3644953.5626806001933635519.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 11:51:07 -0600
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

On Mon, 25 Nov 2024 18:51:10 +0100, Paul HENRYS wrote:

> An optional list of input directories can be passed to EnsureCompiled() which
> allows to pass a list of directories where input files can be searched.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


