Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9296CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D834582B70;
	Thu, 12 Jun 2025 16:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dUJ+SoP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26D582BD9; Thu, 12 Jun 2025 16:34:37 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BEA828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso638808fac.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749738873; x=1750343673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMp5PQKD76spcV9bL5ilHvBRH9QQTc/elqjD+hJaIp4=;
 b=dUJ+SoP5sx0YL2mYZn2gWm8cgYRT5exDZpp4diu6pcNoQmlHA91tSsuO9gUTdP8Iik
 eML7vPjn+RieZmxQDlBaxRQyAeCm8sOBoErMdEM4VjpYZBwCeN9uZHv0f2BZln0z7v8B
 vexfv8ti51wtP9othLfazJsPFRHa6CpiS+9Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749738873; x=1750343673;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMp5PQKD76spcV9bL5ilHvBRH9QQTc/elqjD+hJaIp4=;
 b=d4ws/OmVPDlea/d5fdyIY/y8TZ9JLkAUyHV5YU0Uwqaxf3+djwAs+a66Mihcx+zMZb
 G7ncvIPId4SXuzC4g2HtrGbM2W7T/zh6W90s0W5a3199S081Slid7ktxc+JOxz9YXc43
 tVIjwTvGgBMjESiNR0r+rj3yg+vtbnBmpPyDSr3Rq+8I1tfRYeFtDMM2Gyqp+K8UvXj1
 9oeOMZhQEry+v6sDjoN+BNByO7JKxqp5POKfh8qfvObJRg+0OwkQjT2GgmprtoD3+uD8
 NVeVp+VP7jBPgt5SD73Ls3DI2KRzUQSgLe6pOXE9b+2/fLFft91DOWaISEQHUcL3DPd5
 oSWw==
X-Gm-Message-State: AOJu0YwicpCL2RSU2K8SZ2MAnJE/TaS/Cz8UzrjLpE80sO53DbiEwK4L
 IqkktJ/Mz9NbHjEAEVGBnGdyJL6Do1ma6YDWogNMokWQ4kb5eNpQwu/mQFa6gxUuBtA=
X-Gm-Gg: ASbGncuEUD3pMDYZpp0qtwrxHeZ99jgBTCcL1F7x4cCbG1AgC4Q2eai/RUit3hfiWz0
 IzxDUIl3+FjaMeKCjwDr/KBwbG+ulyz6AHuHnIFjmKhmUvh3pzxPFCBCP/85x7h0oVHvH2zhvGd
 brehus0gX/uXyituCRYFlo8CHTWKZBdLyYlg42HJWBsuHzw0CrZXBgU7GQhk2laf3lSRslFOheM
 ZD8c/F/r8mDqBzTED/XnG6yNmd5ojUPpwkBswC2OSNTn5ocIiQWbz7aWb9LRF8Ic9WOwfkTwsj6
 j/Cq1WsdC2s8jGr4rLgl6LW7GyYFA1i7oNU4lqFgUa7VIOHRCvy7fqSIbJg0jg4uPJlL2CCGbHH
 IVfQenqcx9Ph+d5g+l4EcL0TT8yltrZeZ
X-Google-Smtp-Source: AGHT+IFkVlrCrgd6v3R5avuFwKlxYAotVK24mzgb38/5i4jOEUbMe3L9UHNyVolkY0RPmC0AyZYmcQ==
X-Received: by 2002:a05:6870:63a6:b0:2d5:ba2d:80df with SMTP id
 586e51a60fabf-2eab447a5a9mr2012073fac.8.1749738873475; 
 Thu, 12 Jun 2025 07:34:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eac0c17211sm193474fac.18.2025.06.12.07.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:34:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sbabic@nabladev.com, festevam@gmail.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250612021356.4228-1-peng.fan@oss.nxp.com>
References: <20250612021356.4228-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] imx91: Drop OF_UPSTREAM
Message-Id: <174973887229.204495.10217403514183848856.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 08:34:32 -0600
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

On Thu, 12 Jun 2025 10:13:56 +0800, Peng Fan (OSS) wrote:

> i.MX91 device tree still not landed in linux kernel, so drop OF_UPSTREAM
> and move the device tree files to arch/arm/dts
> 
> 

Applied to u-boot/master, thanks!

[1/1] imx91: Drop OF_UPSTREAM
      commit: 02a2cbfee83df3eddf619d01e5153c3239a3984d
-- 
Tom


