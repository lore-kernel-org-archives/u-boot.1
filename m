Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F686C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F33181703;
	Mon, 31 Mar 2025 15:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dDRVcelq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23113819D2; Mon, 31 Mar 2025 15:34:56 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B470781E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso30134865e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743428093; x=1744032893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgH9bS0t4cV58C8EhbNmou4lPFAPN+mkplCe9WHU17Q=;
 b=dDRVcelqPs55ayrS4uwE61w0Hl9dyg4fYjKOsYGxdEv4E7rVpe3ytfVMOnaDUsWXWY
 SXZrKX2gkfcF5lg6wRbT5nuy02gYUFExtajKLDzPq8a6KBDTKQComn/2YpsXJ/p/5iKF
 Y/SE71yPXrdAax9HtALVKxkC1UTn4U9GN4vhWK1iVrKJGgcrEwZAbAIz7PUsxATHMk0t
 DnUS/TkximqH/g3ZgWsNyLhbWAEWZqVzBeovOlO3fIxvy7/FjREuLgYzMsGIrWv9BtSg
 2pJxXjpPPzCUzAn4nOpEpfC+slxJB4YEGpe0tbTEwNZfgQbGEZV5kB5vjk5xornPIgd9
 KN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428093; x=1744032893;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgH9bS0t4cV58C8EhbNmou4lPFAPN+mkplCe9WHU17Q=;
 b=ZM5EQj1N+UeQJHR1eC5sJZxosx+v8pdIP1oO0CoiaATXtRPJYSvTwNR4gejzH8AZdT
 vb/muk7QrP5ErUTMZsSr2f7i0e4MT2E9kovNxQBIDpNSG+w+r0YcZDrH2YZuWsEZo/tN
 EeLyRwBz6sU/7kH+IUohtZKKZh6u33nnvlSFhvrvimgkQ+HctI7VNZvddFulxlJy0s7c
 OnZMp2C/AE8xCapXGPCpt2V9VwivUqtX6p8DGKeCK9tVviSSxmhTjgnVtJL0ogAzmEht
 CReN3XUh5cXMZcQgJzm7DYpGR+gxmr8EoI4jERfL637T30fAW9YTlAIEmFM2VlRT7vbv
 O7lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyay7FDiGsq7lGp/EMWXpzaG0meqaxFmr2TFGiBb1JAhGkmQBaGguc6M/qgQXz0hpWvtNdPhw=@lists.denx.de
X-Gm-Message-State: AOJu0YwNe1t8jWM0nZCMWCYQ6+kFcoRA81/OYwQU9S/6m/lamU5ol2+B
 gHfV+T3pHN02AeaJpMyydAddQlbXk4dnKt+U/38Q0U5UUL9DfSdZTrrhAs/uIeM=
X-Gm-Gg: ASbGncsXGd0pq1E4w0rntOqYZ/dCq3FQvCLNlW1lAGIp5UHw/A16IjLK6Xy8iJ3pUDf
 oMrriLPGl/Ad6ppgezlpBasx8ZXF7v42Ajg22/q+zi024V8tZGHdMlgJDFF/8znOjPkgletAZPN
 osJDV81PvzYIXnIff04Y0yuXyOYUZrALYCyw9enXXbmrD6EVPJyIwPWVZo8aPI9TYE3zXBctRkT
 WhbZhrDz0xwIh+8ePBLJNO26wT0SeE5f0jn+Pavu/NOQK599uZZOtcJGZo2aI2lv6HJ0Va+V7BA
 7gnf11iVjNg6alS5wumhUrVJD6ZhOiWnAVYsDS0uAuHkfsRGf1KSOSdiedM7nuvLx+2hUPQGvPt
 L461Ui5wcmUS3
X-Google-Smtp-Source: AGHT+IGCLtFws5TfsZbeHvyZLffHNQlsvTAnECSfZeqrM6//HwX+rJaU9lWjOPnjPJiww+D+fsNsFg==
X-Received: by 2002:a05:600c:1e85:b0:43d:1c3:cb2e with SMTP id
 5b1f17b1804b1-43db6205bf4mr107360165e9.17.1743428093080; 
 Mon, 31 Mar 2025 06:34:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm164266095e9.19.2025.03.31.06.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:34:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250331104327.321339-1-caleb.connolly@linaro.org>
References: <20250331104327.321339-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: of_fixup: fix condition check in
 ft_board_setup()
Message-Id: <174342809175.411395.18399236341198057352.b4-ty@linaro.org>
Date: Mon, 31 Mar 2025 15:34:51 +0200
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


On Mon, 31 Mar 2025 12:43:18 +0200, Caleb Connolly wrote:
> The fdt_node_check_compatible() function returns 0 on success which is
> pretty confusing, and we were using it wrong!
> 
> Invert the condition check and refactor things to be more readable.
> 
> Additionally, add the check for the RB1 which needs the same fixup as
> the RB2.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: of_fixup: fix condition check in ft_board_setup()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/462471e596e0

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

