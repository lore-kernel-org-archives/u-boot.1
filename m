Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FB1C27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E7F884D1;
	Fri,  7 Jun 2024 20:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MzYm+F1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A8F884D1; Fri,  7 Jun 2024 20:57:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D931688485
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f855b2499cso1314861a34.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717786659; x=1718391459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDf6Nm4R9IafA3FI4WhMCosYlCzXKIGzTGJJ8sfC0iQ=;
 b=MzYm+F1Rf1Lj073575K6fstCw2jzSf3LcJZPzKNvl+tnEmzBuVF3VIYo7NJ0/QpBdY
 LB8ifLbewp3DQxqj4q/mrhlrJZsAKBPf7nR722qycP7jlyUtYqhMJNvOpkPbLj5Bi9Y9
 ctsmtBZ7tegFA/g7o1RUwid9xIDY8vDBp3Zh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717786659; x=1718391459;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDf6Nm4R9IafA3FI4WhMCosYlCzXKIGzTGJJ8sfC0iQ=;
 b=QvrU4qEPlBAhkJNFO1KqRBxXQyN3RKCBZvn+EnBqYpoM0//bW3Q1PrsqM2yzsAQEkY
 M7o3NKv8zE5WB3VrSJmzMdm72oU2D88uhjmKgrtrSnFFxi6vmXYTZ+g/4Nl6onmyWeFx
 zo+yE8aDxuwYI5j6OYMKgRRwxrTiLMkvzUEtWBY8KZeV6NZcRH64G1Xly1sjkUoEj4Db
 hxSE4QMkOk14mcDX3sRYPbsKtyr0aNsBvW+hu2WhYd8sfkyalyb5ukceQR2GXhU8A7zJ
 DwADN238vICPcZ+raFJjFmAVKr2fGSdSaHpolk/H1GVD1AD9yfjnRjATmrU64cDpGL+g
 1P5A==
X-Gm-Message-State: AOJu0Yx4Bv0pZtBW7LOy9KBb0uEoNg7EkLjTIPb+LI9/T+SFgPfjxelH
 3xZcdhSoGiNYHmNHLL9ArAhKCX4smyLsqLoc74alhCGRILE779YMxz6lSbj0eTI=
X-Google-Smtp-Source: AGHT+IEhDZl40+kCcmidiYUIwrA1y882SnoV0KWgWhMLinS4jauLgw26Jkp/hhvZKuQt6QGqlnPUAA==
X-Received: by 2002:a9d:64da:0:b0:6f0:2a7c:2fe1 with SMTP id
 46e09a7af769-6f95727243bmr3258170a34.22.1717786659573; 
 Fri, 07 Jun 2024 11:57:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f94dc9ddf9sm784816a34.37.2024.06.07.11.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 11:57:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
Subject: Re: [PATCH 00/11] 'eeprom' command improvements
Message-Id: <171778665872.4033010.11655288158092530779.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 12:57:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 21 May 2024 09:13:24 +0200, Marek Behún wrote:

> this series contains improvements for the 'eeprom' command:
> - refactors
> - fixes
> - improvements
> - ability to use driver model EEPROMs (uclass UCLASS_I2C_EEPROM)
> - more flexible EEPROM layout support
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


