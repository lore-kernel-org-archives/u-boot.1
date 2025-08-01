Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BFC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC26B83A48;
	Fri,  1 Aug 2025 13:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sU84uH2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3E583A48; Fri,  1 Aug 2025 13:42:10 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BFB83A3B
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45555e3317aso4169115e9.3
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754048527; x=1754653327; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6gVvh+zogiPEBrUFRl2HqVLe8+yujX84OZvrWpTwnk=;
 b=sU84uH2wA7Ts9+rA1jND/ptghQQXzR2GosTJroJXOE15kopTQ532jsRK62snfeBGzr
 eGQz3AjXBW7V5fmdEAMUNyb1IjAMuICDSleyHVY7gstQFHcTl0b4vBVomJQ6hq7fXfyU
 UgxBKCtMhO5LmVlg/l/eZQ+WRkFiKZgffy+nS5Ve7pExeatY5FHrRRcBT3WAyBaEMNtN
 zPqb0nQ49AccBl6nB3/3H6ZwWByQXzaF2fJ+VOtIf0rI4WUzPFI/QW5B1oLNt5z+bdva
 biSvh0OAB2gNoGYqxpqs7SNiXZ6TUXP/+OG7HyD5Xvp9wdLd8xGSzAZL8hvkjR/kMx3s
 qs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754048527; x=1754653327;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n6gVvh+zogiPEBrUFRl2HqVLe8+yujX84OZvrWpTwnk=;
 b=TB8e8HnfkZ8Eqq09pwQDkttKiDO8WBUbVzDl689+OnVk2JDCOCCs17MA0hDspdsXVQ
 JBPAIzW5RKXQxzd1/IElcAoYxMDwDa07tzwOfKUsv8dztgM/k6HU4qsR5pDUuuDEWXxP
 f0AkmaBaQ37RVMtDFsiAuLADVW3fAkgSj4aM2z6ZVoufTkoHe72/3rWuI30YXBvgZLdB
 ByanwPq+aFR1y08Apm4Rf/CInBE5tFDoCmfz9IRWTNPp8l/M0rZDC20+AvvnImJVQkE/
 UlTt9tCo8T2d/PXCwDmOhb1sedvOeAEzj79bWHF4ETIx5m1K/QA4qelND7mPSzFNoh5A
 C3mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnlyX1e4Gr1jXrlNKNVkFb/QTvz99Uhb9aq13FxI9lYxTLy4OaITL454zi/B+EpexbpIbVauQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwCkHVMeaCYUx0vnKvMkEOeWs/XJmtBv3oWCiMr3eUAaLDFd2h1
 TTTpsolIPQ8W+Jxd+yXHJeDVl9MZK4cPIbChNJcTqPHKksjYFRGQ5YjHs4zg1lvHdPc=
X-Gm-Gg: ASbGncsx6B4/VRcEBMqIu/TfwaAAkugJXRmuLBwfpezcA3OmM5yqp4vlpfPnrA0hMXB
 V9aXPPbi3YBO5Itqk3cgntHrNwyGjLFVSW/P/NauYOMuEUjlEUHnBmKxi06CP4eW2FJfHw9YlwL
 lEv/zNu2FLgdmx2jE91A9rtQP07xhSs9b78LMnWhnC5x1t1Ivh6dMnwt0Qx5LGxydyFbONVnLT1
 frnwaqhV8eYlLSNaZxyyOi07dyumgdUuc4/X6VDX7ssSavIOoA3P3tkrSjhMWQnSX8tNU7pgQCo
 wgPFeIs3ClL1OY2s+4Z0oGaPPscLQgV+V3D4iIsuIQBIX1dGWdyczaZSAFC6Zs1Lvqm6E67MPYw
 ZMb4/uSFv+KZQF8/WdzGcWcZJuKzferSb8S+cRGd7CSXk0Jdfs42GITBzF+PzcfvWdrL/rS4op/
 xSEQ==
X-Google-Smtp-Source: AGHT+IH71YkmbFsdLCkoVanmo+j1mY0ML5mgxjHVaxj5xQkYDVBJWQwXgiZw20h3Ah4tou1Xrcn4bw==
X-Received: by 2002:a05:600c:1f92:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-45892b952d8mr114302315e9.4.1754048527391; 
 Fri, 01 Aug 2025 04:42:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8?
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee4f0f8sm62902365e9.15.2025.08.01.04.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 04:42:06 -0700 (PDT)
Message-ID: <d34b63c9-4fd1-46fd-a984-a22cc0dd3e0c@linaro.org>
Date: Fri, 1 Aug 2025 12:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: John Ogness <john.ogness@linutronix.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch report for ubispl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Smatch reports the following error.

drivers/mtd/ubispl/ubispl.c:782 ubi_scan_fastmap() error: memcpy() 'vh' 
too small (64 vs 268)

I do not know the code well enough to attempt a fix in this case.

Andrew
