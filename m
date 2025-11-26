Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE951D10F22
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6372184011;
	Wed, 26 Nov 2025 12:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djyK4VBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2C2840B0; Wed, 26 Nov 2025 12:01:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898C38334F
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c7aee74dceso882909a34.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764154856; x=1764759656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dxCXWNybfeGtECxe22MFwobD0fBAQVC+rIhIrC1Lc1Q=;
 b=djyK4VBilcMqVH9d9Q8qVRkCcwKGc6xpjKlDSfp69ju0u0yUksAQwQJqx8TQqR6slg
 gOdyjCRkcl0PFSxK3kOuOV4/9q1Qo5c1pTyjsJSsqBdTUPYLmHMKLrHBPqy1pawQGPrm
 Ke+KWd/5j14ho7kjMmzYnnZg9R2vSiN6uVkCmiQ6LpQ5FR5SGpO2wkf/rh8iNW2WOVT2
 ijU2Q1FyxUlEeVEsjZRFbsuxGX6kFoX1akqvDeGW30XukH3j4CNFnbPrmu9o5/hUEUAW
 b/mqZeWu4pZ585j7rcKNgh9Rh87N6iQtL2uK1rJpW237/sbR0qUCuDccmuTDJOCOcsM3
 +sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764154856; x=1764759656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxCXWNybfeGtECxe22MFwobD0fBAQVC+rIhIrC1Lc1Q=;
 b=D45W0pOZzmlRxMxYSNPgd3jRFhYz+zaqpRgcCExrQ/nHbNOD0UCRfWKwKOuMtFDFNO
 BpIuL0YhZ5St/7C79aGWO6AieOgoVRXZgY+45Lnp/XPmGYG/Ykcs/lwpa/nDEpJ88kBy
 yHN+zI9aumrqQjkOnKGw3rt0gURCU9rTq2twkaEK9sFSXKAzRQlmg8Zpi9zyPCMCzxSG
 koLub0MMjpPV8O2E+IfjsQSFyijWWZIa2xPTmMEs35sc5UFDtuYT8pBEFV9QK3TE35ky
 pUrJZjweO4NYBmSUj6BVLzags03vwC52OWCTW1x75hEmRpXwiFtV2c4SYmD+zX4Fk38j
 PQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR+FUX7VcExhc8ItSnfHTduUD3VR0SHf3kIsFufAajEbC45eV4w4+TOqPm45r0jgewWR4j1Is=@lists.denx.de
X-Gm-Message-State: AOJu0YzrMzE3DbCKEB6z1QJC60jf+bf8EEMorLqDhQtDbCGZVkS8ixyR
 uN7vtMzmKd4VYS7bQH1VGDQjkgmUKSWJeRac9urKqUq9pjDvAfIxPYYGp7ANxoLG067ZOcNX2jp
 5NEKbzIMKfJEGykq2UjKo1zrbWZSCKk8gtfBmm/4=
X-Gm-Gg: ASbGncvJFgVeh/AhrpChiQk3A1L32S1JritTRqNFqYH8goYeJN+zIwzhOIsmpUjZTaC
 hVDn5w2mK9xTNVey1Vz2uO9te19VhT2w1dA/UNoCCCcvWQuOUqF3YUJsfI4pzkrczqqQyfERK7I
 RurBgf0mvbeVgDZ03H3h/KSjP60vsUHfeJlfPIt/eP/NHhA9A9ddrMkh3JRaEbCcGNTzn64QG0h
 kaOK3gPiEEJGDd6gt1JsX3jOy6/tM4y3PS7OcRfCRwlVd5R1hFs+R+vdQpK6zZe2tywzA==
X-Google-Smtp-Source: AGHT+IEOqfOLEKm174iAAhJHZqP9KLCt3rqujNUJYxK2ihrXzr4srjF4dNwxYDdrMj7p/kvafAzf+POxb+qhPFx8AN4=
X-Received: by 2002:a05:6830:34a9:b0:7c7:8280:91fe with SMTP id
 46e09a7af769-7c7990bd1fbmr8488133a34.38.1764154855985; Wed, 26 Nov 2025
 03:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
In-Reply-To: <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 26 Nov 2025 19:00:44 +0800
X-Gm-Features: AWmQ_bmKsaNBT9TBBOfXsL9NPkYDIGlMLXKul8GLCHHI30hllblEaNHoD4yvHHU
Message-ID: <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> CMD_CYCLIC is enabled by default ("default y") if its dependencies are
> met (that is "CYCLIC" as specified by "depends on CYCLIC" in
> cmd/Kconfig). So when you enable CONFIG_CYCLIC via menuconfig, it
> enables (by default) CMD_CYCLIC as well. But you can disable it if you
> don't need it for example. If you add a "select OPTION" in an option in
> Kconfig, you cannot disable OPTION anymore.
>
> CMD_CYCLIC is not required, so you shouldn't "depends on" or "select" it.

Yes this patch had removed it by cross-check via real board on the fail
calibration issue. But CYCLIC and CYCLIC_SPL still a must to fix the issue.

Brian
