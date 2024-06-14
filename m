Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8881C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2D2889F4;
	Fri, 14 Jun 2024 16:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DZm5jNO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A366C88256; Fri, 14 Jun 2024 16:54:24 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8791C88989
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-24c9f73ccaaso1235204fac.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376861; x=1718981661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3ixQcZuU52QvgZww4qFLSiJCeyQLpvDqRVaMP1bzVc=;
 b=DZm5jNO8LBpJhfhgvqdTi5SJsEbY/XQqX31DnK60vW2xW+ylNpwR0dU9/w9cT9FGOm
 f1J3M82Zvin3dEFcRPnK4q31Vi+yKFop/gYFrjWJSsdLo81DesHu02H1vFHlrN9RpJUZ
 C0hvuDM8IexwMFMwZ3hVMwrLwuBfLMGVqMcXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376861; x=1718981661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3ixQcZuU52QvgZww4qFLSiJCeyQLpvDqRVaMP1bzVc=;
 b=AqfpYibuSp43Q0SXelgwTZkM0/11N92hQzdOz4/J3+d35CfCpHylIrQrI2YcXT6ZK0
 ImylN4V06TJX1WSkXJsKkOSnwHST5ObP+G8+9dmrGVwfzbEijDYUMxr7+Aa/SCbB4+gi
 XdHifQYJrbMdWUMEffgi8uAbLxtZaEqCfZupZasKKSzyEO09hlXBLtIRz96mSkbUOEQA
 qLTKshhptNvkaVPG49gYiHV3/Jh2Z0FtTvlNBjt+NluffnwhcFj7k6DvElEAKkKUEB3J
 M6BZR+KK7o+0FL63uak8wQH7xa1Aj5znriluUumCmMsgOHbS6LN4Nn/t9WmR3sb9Wz1M
 XsQA==
X-Gm-Message-State: AOJu0YwvjNTxixEIcJzjjf+24UqWhGWkkV7AktkfbK26KWbOn8kiujTb
 /FgbRd5sFCj9uQ0qSnEKV1pEnb/DG057+4e4Iu0atdnKclZm/17gKYiNVbF0eKaVihT4sgtSYDr
 O+2Yyew==
X-Google-Smtp-Source: AGHT+IEXu6QuKb1LcgqNnOhN4yHhgEIJQmx3XL6tOxAlIFFGncqBSG/TFNtnhZ05yRvnSpmzl0UkKQ==
X-Received: by 2002:a05:6871:594:b0:254:9c12:1fb6 with SMTP id
 586e51a60fabf-258429b71a0mr3138659fac.33.1718376861150; 
 Fri, 14 Jun 2024 07:54:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] net: phy: Turn default auto-negotiation timeout
 into Kconfig symbol
Message-Id: <171837686047.2655592.885719495890320459.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 31 May 2024 18:47:16 +0200, Marek Vasut wrote:

> Let users configure default auto-negotiation timeout via Kconfig
> instead of specifying it in board configuration headers. This is
> the first step toward converting this to Kconfig fully, so far the
> legacy PHY_ANEG_TIMEOUT in configuration headers takes precedence.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


