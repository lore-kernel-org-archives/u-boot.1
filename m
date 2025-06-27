Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F8AC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DF582E86;
	Fri, 27 Jun 2025 19:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nN9W+0GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E588882E08; Fri, 27 Jun 2025 19:39:53 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F9B806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40aa391ce1aso791965b6e.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045983; x=1751650783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS9X3JZJ3c4HdHZ+FOypHj30/Nx4ZsM8aIyK0U6woKc=;
 b=nN9W+0GFMzhEGJ8IRTrhkVU2pJ//V/UNEfhcgvBpKIDGpHX+u2zzpHaclBoHTQAy60
 bbV6lWBq1u5BMW6zq0R07YOTNBzb1Pv6Tb1rldwlpyeNoWgbcyqb+ZHgSh8daILA5DJn
 soagFzw3M6qSCjevUm5GVUBtOaLBSztqpCF5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045983; x=1751650783;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VS9X3JZJ3c4HdHZ+FOypHj30/Nx4ZsM8aIyK0U6woKc=;
 b=ksf36dYbCQQ3AR4tELMs3tGa+LPcu/H4nZfRLnpXvcO09HBVWd1g3O8YOwLvT2aWzN
 fFdhxxHJJRQ0cJmI8+mG2e6//HIakW6Zov3iGdHNo8A4RZujJL3hG70GwgE4fLaTcGfr
 ij4VJUGeeMOXO9/KJnWHyhya96YlpNisD4e9P2mPEEKbelBc23+zSNH2/dUWtHt/+Rjd
 Y6vLzufYMY15PS7oDd97kpjR5CD5jUf7Cd0G4UXYqDF2hY8AplLggd5M35F8IFwRFYHP
 Osi5SDwOZtwNzm//6Di8SFpnRhwNoWDiEcJ2Ymo13mBBZ/4cVwl5RfpIFSlDRySkwveG
 T1xA==
X-Gm-Message-State: AOJu0YxYxchxjyolaygAcKXkcZZIANHLgt4tJXKK4lJxVjXpP+mNsbpL
 myDfsReoddKUV5VFqH3Gvjv1c+l8DcvsSxDdQsV09hVCl3F4d3OpivhdQstdkdFJ0FU=
X-Gm-Gg: ASbGncvAVxy3oe4xJSFvNkpe0uukkNHONKLg9ngbsQaer30cPVW8J5g6GjP6iyppLxo
 lvWAsE6NQ8ehNt3oRqepA7jOrAGJqWx1h9YsxMS/hQ2T/uvtfyFCrBHnq9PNDG/zjVD1vEvjkF2
 /7wpc1XJPqNLiIKKUPpVGeKN93lLWSf9KmropUkKMHblQRcnnAp+57jwhZqwrPnH3iclbgnAV40
 0nb3De08UGz8/8qG+N5FEweblym6SAqWXhjovGxxwBv+0YEa8PnrgHHLcvdBJ59OkXR+Rf93xgH
 ZSa6stxebucgmgxumT1wnRTfBQe3sqbgGD97JPif9VdU9RaanO402kEn/VnSd8Q1+NZHwVui+WQ
 Cpr3uS3tm1XjtaDJSHI64kw==
X-Google-Smtp-Source: AGHT+IHjOJNoc68QYwhYNvtiNyidJexDbMUcGer4hpJWKlt4DeMvyHt4Shr1kcg7cUzml6UYdOs8Pw==
X-Received: by 2002:a05:6808:1301:b0:409:f8e:7298 with SMTP id
 5614622812f47-40b33a933e8mr2697759b6e.0.1751045982668; 
 Fri, 27 Jun 2025 10:39:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com, u-kumar1@ti.com, 
 devarsht@ti.com, robertcnelson@gmail.com
In-Reply-To: <20250618124210.1936140-1-anshuld@ti.com>
References: <20250618124210.1936140-1-anshuld@ti.com>
Subject: Re: [PATCH v4 1/2] mach-k3: add runtime memory carveouts for MMU table
Message-Id: <175104598167.3877702.523018445762402113.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:41 -0600
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

On Wed, 18 Jun 2025 18:12:08 +0530, Anshul Dalal wrote:

> In u-boot we only provide a single MMU table for all k3 platforms,
> this does not scale for devices with reserved memory outside the range
> 0x9e780000 - 0xa0000000 or for devices with < 2GiB of memory (eg
> am62-SIP with 512MiB of RAM).
> 
> To properly configure the MMU on various k3 platforms, the
> reserved-memory regions need to be queried at runtime from the
> device-tree and the MMU table should be updated accordingly.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] mach-k3: add runtime memory carveouts for MMU table
      commit: 4628730ee6c40864dbe475e4ca91e47a92f371fe
[2/2] mach-k3: add dynamic mmu fixups for SPL stage
      commit: b77066d73261855af406422fbbe28a5d527f4dbf
-- 
Tom


