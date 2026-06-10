Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6787ACD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0061C84940;
	Wed, 10 Jun 2026 16:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngS6m8N1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C0C849C5; Wed, 10 Jun 2026 16:41:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DB084940
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68f0fc103easo829891a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102466; x=1781707266; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RXf7aJtHZpXg940vh94AEKYXBb/XVNIECFedeexJq/w=;
 b=ngS6m8N112KLg9hC6u8vCzDyWsSedhL4XsT2J9Rk+JuQ6IW2GiK1/Njq4LNPojkHAl
 tF3Hv7iSrHqAxCjB4d8axaY3eJrozC124ZM5LRsJu7c4J7OLUpjI0fxHG+9qHTgE7pSK
 GFk1hNH+4fjM6kTsmyU6LiFn6yM2INKFdGtYKLGXowC5Rg5h3dr1Qnw6fQf+nmjHcfKK
 yjUZQU5+IlFwvpJ2EfV7g1bQbQe+dVD7r/7mi0q9YzG30p5Ew+L1sidQQhEKEJ4IXxH9
 zG+8TU6VLMY4mg1EBkx8qXcD0IFgNw7bDrdF9Ved6PIIJ9cgd04LE82pwVP3KwERbaTE
 fe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102466; x=1781707266;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXf7aJtHZpXg940vh94AEKYXBb/XVNIECFedeexJq/w=;
 b=PP2TRjIwRog98Tk8Yvxhw4l2RQxjPnGlfdE1pbsAnMfmHXVT0sBVr8+uFc5lbwok0T
 YARpewyJyQgaFFWHY9mBWu7W0zXn1bxUw25aZNkcq4m5HARC7/O+JBI5gajZUzMb+XF7
 z5/dxJvFQs/UajB8h/2cU3L3Xp3I4rnXdfkg/NkNl1wirv74khs3CnraYBvS7F4Y9moi
 TyD3kHxFyF5j3mCo7eII00seMP+f+pYn6WQ+YyUDD5esnsLYXPeGU7VlIepDjDe3FCfR
 AiKY747a9Dyc4WKl8bKJ0R/DiA1RvyhJEcK7EPUr4KYMjPpkUtfVnaT38+Zdf6eVi1x1
 G5cg==
X-Gm-Message-State: AOJu0YwOHgCv8qVE21rNd8FUQVwQ4y5kX2eKKH0XctmEh4RHOURTpX00
 hhNL6v6k0VyJ8Gq5Rq5shQrFslukZaGapRPhwjYoYpk5xma2JId41sT6
X-Gm-Gg: Acq92OE1e4FIy9n+3nH478nNj36mS1TxE2u5nI7nDJ0Tx9oXVuDSR+xbxxzUwiU3sXq
 G1kMa86GkFC3HZ9RwxKDBrCjNFHD9e9CGF5ab6/GAVMtNT4FrHIcm4igHE0glROgwX/fT/D+bfj
 qB3BMHhPd4I8aFa6NKgHGKexgnGpO64PrhUSO/UO0bNeTvOw10oPwIW1JQkuPBc9VAwm/tBkC5w
 qoK68U5vE5KmLLwrgB6D0FtL7Vtwq9i+YRdlJgGZRM2KvU/7ljv6eqGBk9Ub9oeS+IsvXO0i+Kn
 5Ag2C00uiAqS+Whw1mSu32BY/Zcwo10BxGsP/JwyQQaBLHm6C6fVPxcHEfngFKWcuWXRiOqC2Fx
 q3pTvwg4bzG4ezUPCtv74cJ8gQziO9W5hzIta1Nc4TqG/lQ0AGQ7r1RbOsp8TRW0p4t7iBIqldF
 hca6ngxeWaPCDunGi2AaEyI6RClmNlljFq3LEX8nAoYILAE6B2hCyPCEpJr4UmN633SN0ojsTd
X-Received: by 2002:a05:6402:3551:b0:67d:4eea:a29d with SMTP id
 4fb4d7f45d1cf-69237ba01camr2073726a12.4.1781102465871; 
 Wed, 10 Jun 2026 07:41:05 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770c7csm1210587266b.12.2026.06.10.07.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:41:05 -0700 (PDT)
Message-ID: <abea2dbb-8f1d-41fe-b5f4-c2d997c31ef3@gmail.com>
Date: Wed, 10 Jun 2026 16:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 16/18] Kconfig: gpio: add empty line
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Restyle by adding an empty line between configs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0b5466b39b8d..685e654c7220 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -756,6 +756,7 @@ config SPL_ADP5585_GPIO
 	depends on SPL_DM_GPIO && SPL_I2C
 	help
 	  Support ADP5585 GPIO expander in SPL.
+
 config MPFS_GPIO
 	bool "Enable Polarfire SoC GPIO driver"
 	depends on DM_GPIO
--
2.39.5

