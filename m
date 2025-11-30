Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9276D116F3
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 13:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80D5838E6;
	Sun, 30 Nov 2025 14:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mKv8fnf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A33838FA; Sun, 30 Nov 2025 14:58:19 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA618312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 14:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e3dac349easo2120884fac.2
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 05:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764511096; x=1765115896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xl7OTceyffe1ihoofjJbUtv7cnVvOkm4xwAX74lI3Uo=;
 b=mKv8fnf7OVfvcKRXEMKL2slx94U3L9bWNxLRu4IpZClQOxxHhedxXqesdGEJwSUrqQ
 9bV7qB9XeoDwva8C77Bni80GP8z/WWHZHCLCunYln4qAqXEuE2kqptLyu64RsgGajTti
 swgsK0bB9v98gQW5Yo53E0RsgQcqOQG9eh5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764511096; x=1765115896;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xl7OTceyffe1ihoofjJbUtv7cnVvOkm4xwAX74lI3Uo=;
 b=FKT8QfLaP9C+8iH/P6YukPkRXJ73EnuWlbV40VFPAQrWwnThe/cRvvHKgDG9nwEX7T
 KQ2A93HInSXMqxIQEjnZbPW8+tvJ5lMxQRw/w/Ltcbn92LQUdKU6o+U0FVCXFFFJ1Bse
 tUMzj3s3MYzYhUJubZgQchdMyvb6AsJ2GGXFvSbT5qdP7YjGuUT9fZxteyfMRPUvSDKm
 8rhPNB2Gw1G3iIHo2pXzmdW3SR8UsTWmBs/0NQmw+suyInmelF6TK2dLtjiemjeAhZrO
 WKIL4VaCCvkRN5ygBZa7UBtPTwgOJvpLN2gThuDxT18XcxIXBYZx4r6HY+GVoWdoYcN5
 k5FA==
X-Gm-Message-State: AOJu0Yxi21OdJNAwQrc0M5zs2r32F4MopQHjIPVIsLdU3qOwHhV6k8+p
 a3Tzbs4Jqm/iwS4bFTmJaEyZWQ40yOAC2TIIkk3KRj4+T9+3GlMD8nl3PmAk7Q4gZPI=
X-Gm-Gg: ASbGncs2M16SgiwdBmGnf5GFYbmiRQrRZs+FBk7Pebmt89gW0FrwhbKYcXkCdGeya1a
 Zvl7s01ZJGes8bsJe9bgX888U1s9cZN6nGAe+fEFvPENLkV9D/RzIGWbR31SVSnnb5WjoSqg7Vh
 QD8vBggA6+wjBnybWrAHvdOD9BSKVAZONEoGWmtUMdndvjDdzknN7GMBWmFAI6xOu74yfbyz5md
 JsuSwQiWr/ZiehXjIdkFh9cgp4NAvLcaZwH7m994KqmVdsXJmjNHFenJwkZpSTeyFCySoqNGltR
 +ckGZKYDQGTPXbnr6S3k8qk5rKq0G6VHsCFgMOqZcrrlg+IpTw3BwomwGEcbpNvAFSyaFe+Os4+
 znef9FPa9dYYacQZ39ElJs1mbsmj08cY8a9zQtVUPr/NucxAsWvkyM/zAIvYGZ7alsn76TIMm3Q
 ifdvdMDybkSy1YCEOhznG+pzA4RWgkJ46yMwmdoPdrVFFLE2dN
X-Google-Smtp-Source: AGHT+IHFz71jaBZIpiOCd7oeYRxLMuzrrYrnH/gFZ1dSax8JHL3w7bZQeqpMe7xq1EiMspBUuIP5kg==
X-Received: by 2002:a05:6871:c709:b0:399:58c2:2e5b with SMTP id
 586e51a60fabf-3ecbe52543dmr15705469fac.51.1764511096141; 
 Sun, 30 Nov 2025 05:58:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd021aa4sm4113367fac.15.2025.11.30.05.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Nov 2025 05:58:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251129211708.2995513-1-festevam@gmail.com>
References: <20251129211708.2995513-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20251129
Message-Id: <176451109502.784214.10092394214787312841.b4-ty@konsulko.com>
Date: Sun, 30 Nov 2025 07:58:15 -0600
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

On Sat, 29 Nov 2025 18:17:08 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 7af532a8ef1c6685eac58d587c9502ab31855aae:
> 
>   Merge patch series "Add support for two RTCs" (2025-11-29 08:37:26 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


