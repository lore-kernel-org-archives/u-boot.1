Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B8CFC5E2
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B64289025;
	Thu, 10 Oct 2024 19:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cvD3Namx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4ECD8922F; Thu, 10 Oct 2024 19:10:05 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1CA889206
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5e7ffcd95c1so603441eaf.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580201; x=1729185001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qnc77HWeY660dKcSPwb+cSkaUYcdbmVgBVk6fd+/WRU=;
 b=cvD3NamxZgRoXHj+1p6iC5KlX9DCpxmUkh00o5Ac0UssXlDXmcYppeCz0GaQ00+6tt
 fETU9Xfz+rmMhhoZfMA/ELS/LiWJzs2zxcqBVT1/ZvrWhEvTKr2G64AgnMchO2M+IPjV
 EzI5vlw/6ccemd8cHxPYvmlWRaDqRi5nv5nlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580201; x=1729185001;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qnc77HWeY660dKcSPwb+cSkaUYcdbmVgBVk6fd+/WRU=;
 b=Ecy0CjtkVl93JDAwLcnxnuIlb0ZHGLbLpKjJR4eYxlmPlePK+S9x/cnUgrDb7Sy/U4
 Fe3N1Jy8/9SUaJZzl3r5QHGGS7AwyoVoiGuaEQVthkEO8USjJlYjhQH/s+PKqWC8lb1R
 //GcXor50PamJO5GsaAQpt1KRGSsIc0zuc/Uzdupgu+bitSUx4n9+EhZXvYDvAv7Mo5C
 fNWS5cW7XlZX8Kf8c+El09UqPJVe/LPVSYFbPPyZ88J7eEvv1DvlfdoLoq7NIpbaFMbi
 fAJYvOwuVIzzJHTsRMp3fnEyYJ4YNVcrIJif5Ni/wR8x9pF3faqwrux72qjU1jB+S4mN
 fMXA==
X-Gm-Message-State: AOJu0YyQqVMpzT8r9MK5cUnTfPaRILeiSrieWeiI4uoSffdilHB82i+p
 rB+GGF3QRW4iffAfeoGZH0OGzu0jZAR+U+ljdhah9FUibnWEKVqzJdFOmNuyx6o=
X-Google-Smtp-Source: AGHT+IF8pM6YAjIGh/jcFrRfMSWhC45TgyxOD08YMXwTd+6oaWDt4EUpit/zxxOBzftn8xNDO1U29Q==
X-Received: by 2002:a05:6358:898:b0:1bc:4589:cfcf with SMTP id
 e5c5f4694b2df-1c32985586dmr32102355d.6.1728580201561; 
 Thu, 10 Oct 2024 10:10:01 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:10:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
Subject: Re: [RESEND PATCH v2 0/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag
 to Infineon 2Gb parts
Message-Id: <172858020030.3696879.1609067352751394188.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:10:00 -0600
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

On Fri, 27 Sep 2024 10:24:14 +0900, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> S25HS02GT, S25HL02GT, and S28HS02GT are dual-die package parts and do
> not support chip erase.
> 
> In v2, split the patch and add fixes tag.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


