Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62257CA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8B183B39;
	Sun, 17 Aug 2025 17:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WVXDByVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CFC83B34; Sun, 17 Aug 2025 17:24:58 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A469582B07
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce5b711bso2908859fac.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444295; x=1756049095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nJBniU4GtYYUezok1DyGiqPIhuzT4dcno5GCLiMfDI=;
 b=WVXDByVUrhmARVsJZUQNl95NlZZbd2stC3Mprj6zvp9bSOG31Q/ya9CYSfK2xDjrF4
 oQOBk4lDR1L61sNMotPdiQj5LhRYbs9/MxN8vMgwjT5sAXHJDLA+dnkSn2L7YaNvVel2
 PgNSKKYsl4fST5Kbifw/enuD1YH2VQ1qRLnIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444295; x=1756049095;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nJBniU4GtYYUezok1DyGiqPIhuzT4dcno5GCLiMfDI=;
 b=kllJdNwG5ltiqhQib9YNOsWP0HbouvO/STZHrcJxsBkf9B/Q0tBSIAKjBIK13yBiZT
 ccp/MGbN+q1jKX/1BDTh91/wMj8zvWLeL4aiHUsa9AKh/bj5znaZff1cXRm0UgEXDGoY
 /qywRglQ9Eh+XER2DQi/8IKhbJPQvRKztMVXM1eTX6p/oU+oCl621mlyN6/UtRX5dQrm
 L3eOfqSoWroywGA8Fw9tf2ZAfNjaPhy5NVqxTUmVvEDrmNCtA7gFqKrxKboi3Z0nBqGF
 HjgvyCfuYP+A02MqsoOHZytI/Sev5zqRD5KRUUWtObxr+Yh4sRx64oPqytAr1ZV9oJLm
 U4iQ==
X-Gm-Message-State: AOJu0YxjorYSROAAfOQkqDDvP/5ILaLr/HSf3Dt+b+oyeLj6Ktr5mw+4
 GpMQtHOJv5bMsCT8wHrUuXydNGlxTvaQskmA2nRKpNhFn5rdMKnbu7lLUiqp/6DUZHw=
X-Gm-Gg: ASbGnctyppPDEwrTXjrrICUvcTSvCTJVG+vxxngHMJtVK7FtagjlyV7oOSAF1yutN5A
 BVzi06Blv6ssf2MbFU83SinXIXA/W0/8jUXQm3qJnGuqMrDeRWEm2M124+jSYMHPmsndrDe1oNE
 QXKSj/k8bqvlJ/4VwIotN++sSHZhSmde96ZOUcD9lbxZjVsvxIlZ53N83aaEYLmq1A4aWM5pLV/
 EzZWhRQWuPJicCNc2mvD6bHdheN9NSXxaSK3wJmQLy9YV3k6FRTI2mpM7dx6sn/I1bqdO7m7n9o
 HBxORwWkEDm4DY5HRzG35gLH9YLWgrG9aaLZFtbNxHBAigGluzKdNMmZh7eM7QonkS41EWe9/li
 Jsjgf/0uJYx3/ULZApQtidtbFgwIqkOlJixBP5DdtLGrUSZxsmqagN2U=
X-Google-Smtp-Source: AGHT+IGr1+gEfL2N4IOZ8TLOqzYGjXFVfBGVwyk7yk98QKhWwqu9/80v/80TCzLKNLu3en7qp6WYfA==
X-Received: by 2002:a05:6870:6b06:b0:30b:be2b:3e2a with SMTP id
 586e51a60fabf-310aad24e38mr5978120fac.10.1755444295397; 
 Sun, 17 Aug 2025 08:24:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
References: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
Subject: Re: (subset) [PATCH 0/4] pinctrl: Address some issues reported by
 Smatch
Message-Id: <175544429402.372553.2859196032702735983.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:54 -0600
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

On Thu, 07 Aug 2025 11:04:01 +0100, Andrew Goodbody wrote:

> Smatch reported some issues with pinctrl drivers. This includes
> unreachable code, duplicated code and uninitialised variables.
> 
> 

Applied to u-boot/next, thanks!

[1/4] pinctrl: single: Remove unreachable code
      commit: 64204ab107b51c60e490292ed1eda40a9a64d7d9
[2/4] pinctrl: stmfx: Remove duplicated code
      commit: 4a2f360bd280b2b5af1c5daffbc189590c83c995
-- 
Tom


