Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4613CA1007
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 23:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C48183965;
	Tue,  2 Sep 2025 01:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WRhOEJrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7135583A1A; Tue,  2 Sep 2025 01:51:47 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CCB83443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 01:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-31533486f07so3559416fac.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756770704; x=1757375504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2v33EDRWHAB2yodLIdVsRmJuh7vD3UITBmhMCDziic=;
 b=WRhOEJrmgrz/abx9EBWQmvcG76eqrHAl2+d2adU0PDFpuV5jIroJVa1A1h1VP6T50u
 530P75ACT2k8+xV7OQpwoSXQZibujAb5yuK/WKli+/aLmZtqmddH+/QGrcakA6B1mRWA
 4NvBkVPIBeM2Tn7hP8+cmhWLsipdOKaAE+gIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756770704; x=1757375504;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2v33EDRWHAB2yodLIdVsRmJuh7vD3UITBmhMCDziic=;
 b=cRvDdEC9v/lSOlTXC1J3dsukadjQ41QnTLHbdxWVFWR+Bni1xRvVPFBGt5DHHxywKR
 Im4eLzDS9Mw4jzJ3o+s4jo+Y1dnR3RrmE79eIZN6/iNB5TreJ5mlpNpPHqOJMnMXiQnx
 BGxivnYl1viyyG0VIas86G62HQTvamAm60uRmEda0lmZYpOhcXciBsmNfA3CSm5jEF5z
 6hvUtMsAyJNDdCeW72RcJno+2bEGmheiUowZHF6X4bpUGAs+sQSYz+z8EgV0g32tviRj
 4aVlIM3w9xWmeFedoMXL5vq2REhkHTjlcFXDBltJjUQb6ccnuvQzBLMF3TxAoOyzKNT1
 BCPg==
X-Gm-Message-State: AOJu0YzpI/kx9qN5Fim9ufj4g0rLExZEcBtL1wL8meq26N1oWUjb6p5D
 21l7Fb0qGKRLlStOPjYZBnt74IEIS8T5BAWHy6J+J8F2c6CVHXhTH+poo45Gb98jnhfFVozy40t
 il+KL2Cg=
X-Gm-Gg: ASbGncuIAPz9/6jlK/Qg928hv/sHoP1pyGcCClXUghxY5mCDESpYlmVWBakbxZDOZD0
 M3hkJtGUzV01NfFfQhTvFfMT0iZv3+Jy07oJ4rZ+qJeLQiX9IKs5lvkcmLgk/bt8aD7XLAPhFHS
 /XugvVFMff6P9+qNhxfmCIPdK3DAarEDg4ZWbKjEMBXSyGC+rrkN9O4rvO/rlytmhJbVCqMx0Hr
 vRaBk520+O+xwl1/5eKyZRt9WdFvRmreIpxMVycAjP9gyw0RsRC43pIJ9Ke2FEuY1NE1vouR4ki
 N1TF8JGJzQSEYzEGoCsMrd0msnNFGUyYx+rRHdFIJa6fW0tLF5H9LS6UG27PDGuhJw/5z6NIB31
 Vt/2/odhhZIL+I8RMEYSLiGor088WX07UJcOzaSSH7Mykj+N73osqE1LlZlUa/Apl5A==
X-Google-Smtp-Source: AGHT+IFOsL/e9SIUo2TVg5FcOf6cfUPtg6NLdInFiIS/+5Lc7FyuXqeARFpgiudpfNhvfV1QYbCxlQ==
X-Received: by 2002:a05:6870:9610:b0:30b:9a9c:72 with SMTP id
 586e51a60fabf-31962d4b892mr4298986fac.0.1756770703932; 
 Mon, 01 Sep 2025 16:51:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-745742a6716sm1292171a34.14.2025.09.01.16.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 16:51:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
References: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-power-next-2025-09-01
Message-Id: <175677070255.3222815.16676627703082250620.b4-ty@konsulko.com>
Date: Mon, 01 Sep 2025 17:51:42 -0600
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

On Mon, 01 Sep 2025 13:03:59 +0800, Peng Fan wrote:

> Please pull mmc-power-next-2025-09-01
> 
> ----------------------------------------------------------------
> Update compatibles for PMICs used by exynos devices
> Support system reset and reset status for pca9450
> Fix for pca9450 LDO5 registers and drop deprecated sd-vsel-gpios
> Two minor fixes found by smatch
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


