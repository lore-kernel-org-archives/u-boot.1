Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D2CFC5E7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AA08922F;
	Thu, 10 Oct 2024 19:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kiFdyeB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D0289025; Thu, 10 Oct 2024 19:10:07 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7088924F
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso101483185a.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580203; x=1729185003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBKoAM52tRy8BJAxzarYEarNDyZ9T5J6LJ2Dtg813Gs=;
 b=kiFdyeB/t6g/psg34JMNhQIU5gLYzqoymR/ixa/KQMDOird3GRFWDMNli+2UKYSqiD
 WziFSUQm8+8CBLaojBLHv42lL2O1h68QHEApJwPQeg+gepJ4+rVTGo9yCgk70bXew0LK
 KctCEWroJAIO5z555O6zf6Q9pxb+w+8ZNc1GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580203; x=1729185003;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBKoAM52tRy8BJAxzarYEarNDyZ9T5J6LJ2Dtg813Gs=;
 b=tv6ck1qqg3/bnjQBUAx1xecS3N4usNXFzC25cGhFLVEOaWQ5sKwzr+6stbD9UeWUH3
 NaNl7lHcgnw2nNisonlwLbzljloWDvGQADoTBhI2CcjVOaDQC9woGtVbtVjtbC78LM3u
 WcTOFotE6zGkiPFnx345Jh07dFI7dw37drI/N9lycHUNsTDwkrBkdVgFjbDFaqOIgQC3
 oNC+3SnPU+42ThbxAKNrkXOsJWadddS1sXZdS/xidmiaefY+BZNQ19YhmVEvnp5N6di/
 WcgkbfjOL/qyJ8EtCjA0gbQ8KrEIWA/OBuqhTaBmOpFa3KR/6Nau+QLT0POyjRlXBatb
 ZZXw==
X-Gm-Message-State: AOJu0Yx8bJvZqylrMDplW21m5mYuJAwy4+sNXLTQ2pdHeLr+ewMQoMkH
 KjkzoQB+OwhDt7Y01pi/9RFmDl/gsanlGADfJqcWgcie/jChTiDSucJ+XRIZJK8=
X-Google-Smtp-Source: AGHT+IEAEos4/R9fkjz62b3+oiF2Qz5LjpsBruux4rfay/252zud6bgFrlwlU2Ek3xmDCYSj4IaefA==
X-Received: by 2002:a05:620a:17a0:b0:7b1:10d2:e413 with SMTP id
 af79cd13be357-7b1124bcb60mr656440985a.13.1728580203342; 
 Thu, 10 Oct 2024 10:10:03 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:10:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <20240927012708.8732-1-Takahiro.Kuwano@infineon.com>
References: <20240927012708.8732-1-Takahiro.Kuwano@infineon.com>
Subject: Re: [2nd RESEND PATCH] mtd: spi-nor-ids: Add support for S28HS256T
Message-Id: <172858020169.3696879.16833579589989414092.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:10:01 -0600
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

On Fri, 27 Sep 2024 10:27:08 +0900, tkuw584924@gmail.com wrote:

> Infineon S28HS256T is 256Mb Octal SPI device which has same
> functionalities with 512Mb and 1Gb parts.
> 
> Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


