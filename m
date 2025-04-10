Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C887C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A33883B63;
	Thu, 10 Apr 2025 11:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LY7+/IvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D26C83B7E; Thu, 10 Apr 2025 11:54:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB7D83B4F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso4797005e9.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744278880; x=1744883680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjgBPDsNquXPe8neQOmjV+BYkrfj7A1gJyBDTgVvObo=;
 b=LY7+/IvOXVseIzYyJxcv1J/TI56rhA/t+b5TevpmVQbMJBwq/yfH4FwFAZbmriHjsg
 L7YfO53ab3jNtHAjAZ0aCcmSGQX4OZM7ZswCeRjatuhqHSe/WI5v4HUQHOFfxeJRPppU
 DVvr66ao/aw3PmkPHaaLwoSP2pSuJotsTl/FB+V4Y2AeIbxl/Da8vBRGoMwReO4Y3lu0
 Y1PqIFT2vI1SVfMfnzP94vzj8bpdomVavZhLVl8l5x0hiK8TcJ+wtERmDXY65zZ2OmJW
 uzGAl6roTcwq1/Fzg/30dFhVNAsEpbRXGjGsfKFJYTcL12KVlPWUkkWaM2HnbARy+1G/
 4NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744278880; x=1744883680;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjgBPDsNquXPe8neQOmjV+BYkrfj7A1gJyBDTgVvObo=;
 b=ZL1XzzJ/MTrXHx5JGnnXaN7LzZ8LWwKBwhXrtVwJ96cBnIzqXeNPMe76ufa+DTTCle
 V8dqyEfWLr6PxgX8O5UfhvL8M1KYpE+ipLVaSQGPiiZWCHzQCDJmic34YY1A+IS4uan0
 jS+71hYXFMnWB9ig1wAmnrEYx3gfE4xYAqZ9Bac19AX4mRJeC1fy9DiGAkX9nwcZx985
 uMx6xh8VZdvBFJIPb7rzlbqsjzHqnLhzXh98PnM89l1T+qJV00REP8e1fqNG6QGixG0v
 Hg56J0w76P157MOfPqknO5e9WI6w8BdBjFMVcAY9V3ZiDd7eOrNsG7NKklyCpKH44uuE
 vZjw==
X-Gm-Message-State: AOJu0Yy28jI7yTLXvRLVAk4XkACLJooFFpJnY21W4hFUDQTUExBsFQl7
 Yn4r0g9X/VtB2saeEI28Eup5jO/Miivo2x+cAZcFL+ZhROTXFicReOCe6k6vcrw=
X-Gm-Gg: ASbGncuXecX0zYhIsf33E4PuJ25FIY8dTKtk1P+BvFNLLQYzatzfCjdOtyv22FV8M9h
 9hsFgKVsscvVFyDsodrLPe7ISBa3BpRznKeS1K7mCnzKISDLK8UlxXMrGcQJloza5F0w/lfx7UQ
 oq1VY3hJgrtj8vuz0t7hsNh/fKfrLEGT+wXKxUFsGNuwZ2yVX0b9jjDhbuQ6A6+A/AMdCKQCwEO
 uCX5pdA299YahnpnPcqbdxO1LzZ1Zv/mhgXp5xo0vfc/0b3mnzjxw8bw2Cvcb5JT6vnnc3Mw+eh
 XRv8O/PrFL7x36EVJ3Rim1Bh7KlnQmW723HTL085ZS8elnzmc81EImFSvbGerCY5lR0ECx79BJp
 FjT8Ktw==
X-Google-Smtp-Source: AGHT+IEGO+/NJt7EvesUmU98IbA6zNVdUeiYK5mkBHUBTZYXS+273tir426ItHHLj6HHKcesTuMYBg==
X-Received: by 2002:a05:600c:2904:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43f2f6d0079mr14772265e9.15.1744278880519; 
 Thu, 10 Apr 2025 02:54:40 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5e9dsm46931315e9.36.2025.04.10.02.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 02:54:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, alexeymin@postmarketos.org
In-Reply-To: <20250410080027.208674-1-sumit.garg@kernel.org>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v2 0/2] RB1 fixes
Message-Id: <174427887927.2136308.5751804895002061254.b4-ty@linaro.org>
Date: Thu, 10 Apr 2025 11:54:39 +0200
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


On Thu, 10 Apr 2025 13:30:25 +0530, Sumit Garg wrote:
> The eMMC on RB1 boards supports HS200 mode but currently the msm_shdci
> driver in U-Boot is missing DLL configuration required for HS200 mode to
> work. Hence disable HS200 for now until proper support is in place.
> 
> Apart from that, add a fix for USB PHY power on sequence which got
> broken by recent addition for SM660 platform support.
> 
> [...]

Applied, thanks!

[1/2] qcom_defconfig: Disable MMC HS200 mode support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/01445f10cd58
[2/2] phy: phy-qcom-qusb2: Fix USB PHY power on sequence
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cd5799caf491

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

