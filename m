Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353F7C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3011C88C0B;
	Thu, 15 Aug 2024 22:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tZoAgeWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A8D88BFD; Thu, 15 Aug 2024 22:33:15 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15BB88BFF
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d5ed6f51cfso898775eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753985; x=1724358785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JKAcNvvQnzEFd8UP0ICFYn19z44yG1HdbQ3saH4e2mw=;
 b=tZoAgeWXyrez2OWLm3nwG6CszH5KGMzw2B+pvIVoA/GuNzyJcO+oTQMbEFWHHkNSmR
 afjq4/o+nfJaErPd2aY8gP6j2KeqqeZ48traMtw1U+xm4HSojsf/6myJlt8lgRDeqG/S
 cxJn94Gs+OytdLcA9n7gQKnPUik15446j51JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753985; x=1724358785;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKAcNvvQnzEFd8UP0ICFYn19z44yG1HdbQ3saH4e2mw=;
 b=uf6LzDkXpI0kiw/Iobf7vfDeeNSHtGoK2VKWZIZoyiwQg61+g4AIz5TP857ClplnHi
 ZweLEEL6ge96LXAQplreN3HeAZaw5MWgolC53PIFlgMkl28FwofU/8vyuC8W+ofzm1BC
 LMQ6Bk6iC5Af+YtYDxB23RLXLo2n55YUcY+yr9CFEYaRKhphNbfdcqnqUzpbaFGE0fxo
 Okr3MkTy9/XmDFHJfJX4Bfda36/tZsMBrc3CYm5bYOAvUg3OKlwQQ3ojhXCYI4Y8zYjh
 afGpP3JeMpYSGjktN9gi69xKGGyjPhOjIBWb93YKgdbrK+FC1Gz4kGlPCUhaAXGr4uc4
 pyaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOOGWLOmpLe88kNy2L6OLyX48yUDh8NgHv12he3dd/sjxcjS74KaO5xDRvG/zvqTqK/M1Vd2DykWBgoB/BbJCMXwbnvg==
X-Gm-Message-State: AOJu0YyJtp/Zyk2ddNNBV4MzqC1N1uQr6iHrnQ8nmPxpVnvVB+K5OPmU
 c1O9C4oAgJtmeVynvV4qqrJggYVdvaQW28sgdzOAqphXFJVAlLvyulvC4ZWFiUxvCjOBQ6BzrW2
 D+ho=
X-Google-Smtp-Source: AGHT+IHitOg+1nqcslzADtMv3lty30nhjJdya2+p6TmuvyyivQysGwqRtFq5V6dCbi4QElA7GVOqtQ==
X-Received: by 2002:a05:6820:1ca7:b0:5c6:60d9:b0e1 with SMTP id
 006d021491bc7-5da97f32e1fmr1198226eaf.2.1723753985089; 
 Thu, 15 Aug 2024 13:33:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v2 0/2] spi: dtb parsing fixes
Message-Id: <172375398422.3490037.4263335235288301999.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:04 -0600
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

On Wed, 31 Jul 2024 08:11:27 +0400, Mikhail Kshevetskiy wrote:

> Changes from v1:
>  * patches description was updated
> 
> Michael Polyntsov (1):
>   spi: soft_spi: Parse cs-gpios only if num-chipselects is not <0>
> 
> Mikhail Kshevetskiy (1):
>   spi: soft_spi: fix miso gpio property name
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


