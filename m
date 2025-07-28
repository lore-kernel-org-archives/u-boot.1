Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60210C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE4D82CBB;
	Mon, 28 Jul 2025 18:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bOkwHsQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D24482F6F; Mon, 28 Jul 2025 18:21:33 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F13B82C84
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so1339598f8f.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753719691; x=1754324491; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGeq4H+SBgB8QucEKkUb4UXI/k0pdthF0rYvWwB+maU=;
 b=bOkwHsQRtwsYWbbf2KgrfbOl7KCpMCmYZc6XuUgCWXn8bXU65/nNEUbJ+CyPJSTz9t
 jcv2aZQivMVHEbmMJ3IJNl7Nz3xR1JgvnTAHBjEC9CAFaNOvmMgcmcrsczWeZVdbceSF
 S3OayJDmM53GyIsEoarQf66ZKro8dYPCYUiNjc1qEYiJqYthInmB0FW36yEKLOTAEjl3
 rf5liQA6V7omN9BOqHVdvP/8CfJRNBm8wnFAaAuCK1aft94onylaWLSfN+V2GjT/Cx8C
 hRiwRnaAWkbB9aX8lwGADL3ftaCtF3KG8Z5GEW2WLZ4Z3HhpPQFFM5SKjY3Gxx1lX/js
 ereg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753719691; x=1754324491;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xGeq4H+SBgB8QucEKkUb4UXI/k0pdthF0rYvWwB+maU=;
 b=Um5VuGPT2BOK2Thac/qPOG+tUUDjD6hWLf6KXYcE7aDX5GbphZfm9XWcVgry27A54b
 61NboudtLkLBd8WdzkNfnyom8tnZy+d1+A76oLfoQBdbGnOldYRYJE0ef61+uqDVuyyo
 sqpCx05GHqNXZC20FJ5jXwo+f3RGwRMC0EN2anCd6D0lWbFXzPt24DHJBYhdR/RBD+dQ
 9IHpc4W6PRzgxm+Z08XK/8VBo/an1SPF1M36h2xxQBmefMy/WAWgxYlVRwEqBqDW5XHg
 TqIiYL0aksEMfc/dh3fdguSTyXpV2Ni0vHLa0PPPwAOD3ik2ipjO7eZH8fbQLONbiCAR
 logA==
X-Gm-Message-State: AOJu0Yx3OvgY5d5bjzombIa+75v7TU0lGinAc82zTXdowa8Bd0VPoN/8
 vlGfoLjwNHhtcUaBhNCMLQ40cdkcIq5ffCkLOQ01/j4DWDLK3n1WAtRkMs+UDTXaR80=
X-Gm-Gg: ASbGnctIiQSWL6NDDY0v5vhTNUZ2go+swsTmf3Tt6Csn5/rzS8w5rvAy0J10F13ZlHr
 pqLx8BL7ENlom3khqb3zdrQiM3YQmwqd8iHrwJzgtJ3CV410yti6G5eDDx2VAM89nChrku/4A4t
 PcZGdDcD+UB97+75L1Kqu0FTQZVaZ69SR24nbFvp5hZ6tVNCBYu3ty3NRsRF//o6chRzyAH4FX9
 LCl2we6Fk7rkyYKv4QmDHni6XphO+gCujJnGdleHpbLGVNEqL7N/mRQaQPptj4UL/toSlj062+y
 OHEXD2+sItLiPWGCa6xjhwWy8CYDuNnHFkjBgLGaUFrB11mbafvZAyG3ajSnTPaQF9UQMu04CSs
 NZ3ugzaPQjbIrQHe3DEk0xNj6bl+8dhb3qZ/12leiBFxPLz7/vrrMaBLT6BQsxTEVn+A9UFONxR
 0=
X-Google-Smtp-Source: AGHT+IH5b36NkhQETGLee0wN/eysf87FuYSIATgJqSw39/qZ25I6D0SF3J7vL/FN1CMyaw9DAc/0Pw==
X-Received: by 2002:a05:6000:2f87:b0:3b7:8af2:f721 with SMTP id
 ffacd0b85a97d-3b78af2fbabmr1916847f8f.50.1753719690511; 
 Mon, 28 Jul 2025 09:21:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3?
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458704aaf20sm167037595e9.0.2025.07.28.09.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 09:21:30 -0700 (PDT)
Message-ID: <29fe5f62-c99f-4816-8ef9-42a8d152dce5@linaro.org>
Date: Mon, 28 Jul 2025 17:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Unintialised variable 'offset' in drivers/misc/gsc.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Smatch reports this error

drivers/misc/gsc.c:330 gsc_hwmon() error: uninitialized symbol 'offset'.

It is not clear to me how to fix this problem. Could you please take a look?

Thanks,
Andrew
