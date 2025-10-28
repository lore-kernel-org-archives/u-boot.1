Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA392CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 17:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495D0838E7;
	Tue, 28 Oct 2025 18:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T1s1xShf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70644838CE; Tue, 28 Oct 2025 18:59:11 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551E383885
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-654f5173629so83856eaf.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674348; x=1762279148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bixM3dBNrgP+0ou4GiSGJyxsW5XqeBSi+yMCtzeb1h0=;
 b=T1s1xShfBVIJyWtwi+SrLb/WoFauyiLnmsJlFUqv/MGQcS0I4/G+emqXuy7sbdVWM3
 Ih/R3kRTTQGpihxaAsZsQoW7DHsrEc67EtSroAQrXuoPDb+Rsr9Ax4pchLNx6Y0LbHp1
 2mWXfO/Qn8R3nBz+gMcmpyN+AVQbmij3h/sH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674348; x=1762279148;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bixM3dBNrgP+0ou4GiSGJyxsW5XqeBSi+yMCtzeb1h0=;
 b=vmSNDwdsMhw9N78pIZz3cOMgrO7SUz24AnXtoO7nIiuFVgUVz1/jElZq1hFVF0kBW4
 FZOw70JNT4Q+0Dvo8G/6QVJ6776u0AyQU3Ozg9IeHwOBXGVH0aj9FrTz2CPTBo7XInxW
 NJ/Hen0JajzYbBXQviSUzxudjhhLMQmDdi/NaHgcqrrPqCQvr91ImOrnWcTNHDEq9iIh
 kwy9aWGEFKyKGUB97tATUOFqbImpkJQLeGKjplUtT1K9iTTU316EjP8HioFkiejstu5V
 kg/IqjciFY23OBcaJdV9UJKzPmXYaGMERe/s5tDix0r1rGk0oILWOGwxQEshGOEPteyH
 JGXg==
X-Gm-Message-State: AOJu0YwZGx9yKQUXvEBaUl4XYFu8rDPKWM/BFmD6dvIP3Cd2nJZUh5zG
 GveHGkWv7tCC0QngdJzZAbqLtftQkSONktxn7ImhFzeyVra9Pv8y+S9hTbcv13Nrn4Q=
X-Gm-Gg: ASbGncstgNvbl8h/5lJx+a/gUGPNTGpHWzZ4+OsY6XsEAKAURyfHrAKgeF9MvwLo+WX
 ZGQBEbk//daLz0m0QPOD47JUP291v5y6DeCjk2q2J6fivnpS6+QfjbPVVE9Y20R2AwjSGF7xBqR
 i3P2IiOvXJYQH7BTdX5OjXNZw4e1Zy2vIfPBmGZ434xHYH5JecpcsT9oc0k/3S9JkLjcQP6E8Hx
 vlwDN6n8KFq995S/y5QG8gFJjAsUigK9xrwTKtyfFkEWdeC1YHHr6TAFbm6xye8i9ea68LIQOsr
 xQl0o8PzcZTXoDqJu5cZdVI+T8DTTaKysWsU5HDG+wyb3vFFydzAHY0GQIhUcysgLb73kbaEGQu
 8cGkeGZfnjkvaNZ79TyFVKAYnStyGvmavGm3OHyMga371yft2yOqbl2jBjIwzKHMBozIbG9YtUa
 dG+wuKSKfJ1AnfbZZQoPlxjgBCVjxrbGuS3+afmg==
X-Google-Smtp-Source: AGHT+IEMjO0iAgBsBpB5Y8m4qilEV9OfeqqogA+qC/vWBDbLRJqKiClHkjH5P0NCJmHZrhpgE4Xf2w==
X-Received: by 2002:a05:6820:162b:b0:654:f93d:fded with SMTP id
 006d021491bc7-65678461059mr64774eaf.2.1761674348012; 
 Tue, 28 Oct 2025 10:59:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
Message-Id: <176167434712.2025892.9174636336405377074.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:07 -0600
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

On Thu, 03 Jul 2025 15:40:46 +0100, Andrew Goodbody wrote:

> In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
> done with the value that this calculates which is obviously not the
> intention of the code. This is confirmed by the code around where this
> function is called.
> Instead return the value from ERR_PTR.
> 
> This issue found by Smatch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] clk: Return value calculated by ERR_PTR
      commit: 644b4650ee57c429bede77f44752cc867dac0e00
-- 
Tom


