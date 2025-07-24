Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29334C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 01:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE21B835CB;
	Thu, 24 Jul 2025 03:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sTHMaDXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD0482BA1; Thu, 24 Jul 2025 03:37:32 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6962A82BA7
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-42a56f2e953so19830b6e.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753321049; x=1753925849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wln+1l9QGJqp9WDl1pAFKEPNribtAiPh3wmOC4LPrVE=;
 b=sTHMaDXYE7gnlbKJUODRxRwbDsUa5msx+P0YlvMIQSRH1xOwC7ph0G1x1TDx0Kq7hU
 mK4OPvkroTieDNr/mXmwPzyoRkuy30omxWA3Y4KIlvEAC8OMU+N+KNQtklFDxIjRSq/C
 M+i4mtP8UCMncgU63btw++2MSyml0w+Gh+8L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321049; x=1753925849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wln+1l9QGJqp9WDl1pAFKEPNribtAiPh3wmOC4LPrVE=;
 b=pQPUu92HfBo/7xTbNg9kC4igY16PvM7Z0yw1UA36MvFNoP8BNKI/P46j2k0hwRR3ny
 fBcqs1MJAWYe82p4wIdTlSDYFtUnamp218CAUb7Ubo7RiufApLAjMLTSEKkBGrSBPONe
 WuBiQKAsz29ueDDJWZDxz0irNE4SrpjcMn5KkgnFr43gAJ1BtJdVvOD6frwUpoqBA/Xi
 S/fULMGyq4PcMR1L0tyQpAWYNK3kkxSLwk5rHzoxYpeeQ3Fm8GX5qgn4xPPzEO7Jr1Vp
 T3SIR8fMzXsWVQkVQsbMCnn/p5LtNQWliJcb48LyTt41XzzFV34RWIDgcyuscHKro1V0
 TD7w==
X-Gm-Message-State: AOJu0Yz+UK9R5tzFql0uT6obb4akM+Fsoa4gMPqE+GEbCQCgmzZrmEYN
 po8NsE3vTmOCipGwgswoaD6nWfx1fciaFmKg1U1n4wqdHYpuAZr4sGDrk0dIkAHQrmg4ndnc1sC
 n2F8nANw=
X-Gm-Gg: ASbGncsAQlqTYmGiSYB+VvFQNEuNhXWGlAmr1/9s6v+KPYbbPz/lwvPMoDKQfVFfAcp
 whqH/w5cycglupzv3G5va5Z2Wc7JivEbtxg7qg77wJIbL4Z0fg4HmTVhFL9SdRf689hRNpMptFE
 r5h4LnQDIZ+ULTi9m0xyl/aGTvK/x0pqoQT/lCpw0+Jdja2qRRarpEliIby8Xm0k4XBk6OnoNv/
 +B860rgFobe9T7DzA3KtDYS8gyxQuELkiY9VFASx4HaxIT82GX/yrhUKvGpblk1c1sxYXQ8zZvy
 uduXXQ2SnyjWLha50VVmW3mR+4Kj5qrLcpp0rkMB6+5Q/xmYIGOT75K3MUwjYIPW0TUJrOsFeuA
 wf4cphLDEANUv+KqNbQ/Z5dLSEBbh23J6TdKkTWdQ9AD46SaPjLNZ1ag=
X-Google-Smtp-Source: AGHT+IF3WD8x1t2VTDwqmSsIpJg9BizUmF7bLAJ6u3hpmGz+T3JGNAm8CBwkQJDtp7ZOwZTYbNcfyQ==
X-Received: by 2002:a05:6808:50a1:b0:426:4ed1:8c30 with SMTP id
 5614622812f47-426c1242e1cmr4294687b6e.1.1753321049086; 
 Wed, 23 Jul 2025 18:37:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-618fb4431a3sm102604eaf.13.2025.07.23.18.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:37:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250716-gpt_offby1-v1-1-6aa3546069ba@linaro.org>
References: <20250716-gpt_offby1-v1-1-6aa3546069ba@linaro.org>
Subject: Re: [PATCH] cmd: gpt: Fix off by 1 errors
Message-Id: <175332104796.263924.7177911568370816128.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 19:37:27 -0600
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

On Wed, 16 Jul 2025 11:55:47 +0100, Andrew Goodbody wrote:

> The buffer for a name to be copied into must also contain the
> terminating 0 byte but strlen returns the length of the string without
> counting that 0 byte. Adjust the length checks to take this into
> account.
> 
> This issue found by Smatch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: gpt: Fix off by 1 errors
      commit: 25d3e0509c7d812e05d21c2c73038dce6fe9d889
-- 
Tom


