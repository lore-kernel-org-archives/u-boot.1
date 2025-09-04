Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B579CCA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C1283B30;
	Thu,  4 Sep 2025 11:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o2WWd823";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3562B83804; Thu,  4 Sep 2025 11:57:39 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3FB83B0B
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b87bc67a4so6052825e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756979855; x=1757584655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BW9GR1OXI/HYSnp0eAHqnGmVpsFbE+gHYYFWS03EpO8=;
 b=o2WWd823X6iTrFFzWNgTsVNsHbtshUqsXE/rsgJD9dRJk3r9hksyHv5I6xV1sXT0EG
 h4ksllFlEjFgdsu3BG09OQnpVepi9xglkLcEr6SvP4ziCGvFRf4K2ispo+1mRiLuH1AM
 cacbVusnLlzchrYYfBdfnmtjnQUMpMJQAdzR+JQnJS6d7l51rrwdL1ZKGVS4mDhUppCp
 cPQ97W112dwIdUS2HzmApNhdrab0o7LpeotjLlEEtiemNzzT8oGy+4IwwiIEU/ANpsT0
 b5uR4KR0RkxvpYngLilzpgfGXqo2ZCHulXWF9jUJwYZd7JUdXrGwxwRq4/AnqHLCxjSh
 CDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756979855; x=1757584655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW9GR1OXI/HYSnp0eAHqnGmVpsFbE+gHYYFWS03EpO8=;
 b=K/vmu69uyF7jmcWNgmyXdXZpbq3eDs/PvdJn5YbF0h91PTaEoOpA4b7MjnzUDW34a1
 8pIDsYU14xB9pDA6KgWs6SGlrTc17AlHLUMzZtKLjlYNk61YERKXHBOluhnT6b3sXuWF
 0d36rBf59yudR7Lm3zckb8UgFGCTnlcjuQJnTyyUpCP4aKKXMKZF6tU4A1RGoJpkbG64
 iOVmCGeYPBTaz6ASBCPBwvQCoh1KirSEzu42OtXvTlbbRJ7qvFD0LAV6vUnr3s0XGaO4
 LO9f8XNKpl9pxIDQRJeVFyurdOuvCE+q1eyJ9/FXC4cs/dPYAhWYBec7qgj4AwuhACzK
 WXcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0X60kAJQ/qbtCUONNqlnNKg3R7WOBUFRtli8u5Skq7ZIgxIEE3InvdkijGKt4W7V2vqN9YA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe+FuAzB3a61kKeRRZ+ZGuJIJlMyWPR6T6XivYSbKXD/hTJBbM
 ptmjbQjeyqckNkGlDPEkAiCifKheWlJiPFwAe3ZfgjnEa7hjMW83aYAvDjdY/3C/G8JqYcHpGhQ
 EuNqPZ1boxg==
X-Gm-Gg: ASbGncsrEC76SerdXvkeymG54+XJ5YuxQZ0J/uT4WUzFgIkbaBztYlfbply/qFKaIvt
 rqmmtABql3PBM1o8GRjRK+wf9BIcroQfvseldMX9i2V+YeWJmuUC3Zr0eDxCV7aQfh0VetGqvCK
 6f7yPjQYyQyfLy/MW4UbNC47ChGZKsayvbCKl9K85q/5UZVIZ9jOus824T+9Hioq/0R5hDHVN4K
 qvuj09XB6UDoaplmZ5UI0Hr8iLIzKOawENlJu1jzOtJH7mQ2Nwlch9Il3jS8wpjPIwHCrDkSD2g
 bV/zaOnioD6zcipJ2/o9HuuUbM6rkFWnMMWj18+8iQgnqfbRpGC2Fuf4u3U0ioyFJ3JAw/MhqjF
 g8fXPeh3GCYLtrpyrzTSyeyrcGatyrQIKX05lNbkzVeA=
X-Google-Smtp-Source: AGHT+IFYbAixbM1wVWTJlgcR6aO0Ycb4yKRrBUZ/Kil6ZJ83vUgQccd90ULtifC08XYCmtQ2ihxX9A==
X-Received: by 2002:a05:600c:4514:b0:45b:7cad:7ac7 with SMTP id
 5b1f17b1804b1-45b85525dc1mr142140075e9.2.1756979854764; 
 Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
References: <20250723-clk_meson-v1-1-8cd6e73145a4@linaro.org>
Subject: Re: [PATCH] clk: meson: Remove unreachable code
Message-Id: <175697985412.2904655.13465537088051195075.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:34 +0200
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

Hi,

On Wed, 23 Jul 2025 17:37:24 +0100, Andrew Goodbody wrote:
> A second return following the first return is unreachable code so remove
> it.
> 
> This issue was found by Smatch.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] clk: meson: Remove unreachable code
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09887c69c1745829b6c004518265df4519a9f6a3

-- 
Neil

