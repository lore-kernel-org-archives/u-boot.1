Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F98E10F9945
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DA284150;
	Wed,  8 Apr 2026 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="om7RNhWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5B984150; Wed,  8 Apr 2026 16:51:21 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED7984132
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463f00cda04so3444211b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659878; x=1776264678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JplCvu95TxXzRxWjJVGkxT/jWs31qyZ8DFaru3Fa+iA=;
 b=om7RNhWT5mHhh9yCfJclkCWe59PXBcoL8ohbchdZUovq9yfk9vJrF+muAJ4jEOP0wb
 P5xWp+MKbDEidyQ1h+YFxsAx6Cwsldk4+ullrnSVzkJLMArcoaE7ZFjtxL5kA9BdP7hr
 TagyauUOIH4wOavX+k16iRYU9CVCmMS45CCrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659878; x=1776264678;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JplCvu95TxXzRxWjJVGkxT/jWs31qyZ8DFaru3Fa+iA=;
 b=jPa1IMaUgX9MeAQuzQxKkvTL4r2H0foBOK35tJdnLUMOcjJm90EIiKhp0nMGAx7Yw4
 sI9B0O78e5ojMhAh9k1xoKwpRKO2ONEghsUM3rwbobCHZiBrzQ6/aAxJQDu2VQQuaW/D
 8wKEjCeOyG6LD8U/3nDTjuqfMbEuGMqr15UGD84VRrWx3ASogAAcDHwrnwGBBYIfwXnw
 9/whX0MyaeJLcZLm1JKdMQyr4TPtvBkSZhCC1wCEO7jkbvrVOSearrRD3QjZjMVb2sMb
 l5+81boTL0uYug0FkrKMlexoMmDJqddiNWrFDtQuNPUXf+27yPM7cgmQdZehAwkAhgik
 iQuw==
X-Gm-Message-State: AOJu0YwzUM0IxxflF0KtlZGhtPRMg5kIK2PZnAnEBcW2fJkCHUNDBF04
 GtV2bnn3iGLdDG4ODoKI2LD9Nxh+MA4A7dyp6c/Q4G0Tzij5YdG+0SpTcnjtRcEq6fhvxTR2cZc
 yMKPPDjQ=
X-Gm-Gg: AeBDieubtx5o8k46DAF5t31brDrL7zv/d/GfI99T8cLwEgFDMFDR2cLupS4JIqkZtfq
 zHJg0lCeNNQQO/kfhYN9OOHappNvQ0axr/1RTQ/U+UwfVFk3uU4u4TMx5HUZ154to65JAnXdsAX
 oLZ9UM/zy5rgiq8UbGakTQguGdwHc3dAX7UaA7brkq+pECSnjl8YodD3os/ZsjSVNCAmEFeY3qi
 EtPJsGFophSihRVRkvG763mPAHvJ5CtcecuOo9sVpvv8JWtAeG+sEybegojkNyjBVZhaARzttxF
 8fd3MyT++kTSyy3F4QqCeL+bDX/20JFFUi+bTG0M8fy0ISgJFiR9jTbl9ZX+wNbJwYtIvEMsCTe
 eeRjgHlEkiD4P+fT5sgMhuC6y1U75maAkKLneRKIlinuaYDF/lxT1eT/KPaw3TEq3lJLEu/qhSM
 +WOo15grpxMC874X7yhTBEPEUcZCxpo+lbAwm5cxRluHj2ZAjHJzzBNWIyHMpfRLc+gN1KPuHaO
 6xqHJew7IklBGyO//zhAnAtmPI+03E08NOP3fqc4bfDFSc=
X-Received: by 2002:a05:6808:c1fb:b0:467:15ad:9df0 with SMTP id
 5614622812f47-46ef57f0137mr11059795b6e.7.1775659878096; 
 Wed, 08 Apr 2026 07:51:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:51:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260325190020.3428514-1-trini@konsulko.com>
References: <20260325190020.3428514-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: Remove unused CONFIG_SPL_FRAMEWORK_BOARD_INIT_F
 option
Message-Id: <177565987743.779397.12587945370930143333.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:51:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Mar 2026 13:00:20 -0600, Tom Rini wrote:

> The option CONFIG_SPL_FRAMEWORK_BOARD_INIT_F enables a simple
> board_init_f function in SPL. This however is never enabled, so remove
> this function and option.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: Remove unused CONFIG_SPL_FRAMEWORK_BOARD_INIT_F option
      commit: b9650a8e330bb2fdb83af28646f3777e9fb503bf
-- 
Tom


