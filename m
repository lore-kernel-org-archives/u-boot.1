Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F2FA375B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 15:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F64B887EB;
	Fri, 13 Sep 2024 17:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KQL/IrYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928AD88D95; Fri, 13 Sep 2024 17:42:21 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19453887EB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 17:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so9849905e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726242138; x=1726846938;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rbeht4Mq8e5C5nAiScVblGlZyzRuMJoMhGF5dUQxIMs=;
 b=KQL/IrYFmS0JmnptvP8Xg01iBVqR8vM7btkNSMHy7YuvxTFVJF7A4H5mDN0JS+JecH
 HCR+vJVMN0zf2lqNq1lR6wj1u+mCkREIupcUMZB/HiD4AvCHIOd2SY14gbUuj0fvGRlc
 Uhm1UVMknnedBqSFRvXkjiK8YJEXCmKOo8roP7L+P29EZ+0UNKvkLpeLPfuf/Mjh8Gns
 WgEavMMmrpHpmZcKCrc0uCNgrxMkwPMftXNhwVD9nXW1OtcomwuABBtrQL+yidHoWCmd
 WDQExEdbtMV9lZda7Myh9fOavATT7NCr0e6zmfZ/HW1NfI2sawvpkGqGYGz7NcFv4w2j
 A71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726242138; x=1726846938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rbeht4Mq8e5C5nAiScVblGlZyzRuMJoMhGF5dUQxIMs=;
 b=dvc5351uwEt+OSL3oMV5iF3LJgoY4XZXZDQGlhEiB6HvZKM8GFhFQAbtVYbJNuQbSK
 dFlCg1MfZn+RB/g52xP3+WiVSLPaNpqQ5fMh9lzv9FffoWxjejg3fH8tszONDUOXNvp0
 yNoKhdn65Ns/YHjDTrb9NGH3JiWJBdYSLGQH7go1Xts+rY+uHBk7V8VxhmBtVCFuL6LK
 BD7P3hqBdKnGId91twFDgsWZIxCICUIlwEceLkevDzxGde6444eISVDSTrJZ4FehI4yO
 E+AlowvQ2ZWbfW//BT1PObWfEt728C0mCkFVkKL7CKZtxGgcUVM8p3IPVKYQ1M2CMiiR
 7Sjg==
X-Gm-Message-State: AOJu0Yz9i1ecZT+whiJYGWSK6pImPAaG9x6hCB3DeiW27iWKtnxbtLt/
 wkveJHqB5W/sqhOyMzxxrq14PH/UYTOwOIdA34Ahw5pplRELnHLipOq0eCWkKK4=
X-Google-Smtp-Source: AGHT+IGlb98XZa2APNe16qU2FLpHRgu5UqFRMlCCzIAW2KJn9PU6kYOGkNWKWm4PfFSG0m/c2RIMSA==
X-Received: by 2002:a05:600c:354b:b0:428:36e:be59 with SMTP id
 5b1f17b1804b1-42d9081bb39mr20845545e9.11.1726242137491; 
 Fri, 13 Sep 2024 08:42:17 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b189986sm29283075e9.29.2024.09.13.08.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:42:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20240910102751.3182982-1-jerome.forissier@linaro.org>
References: <20240910102751.3182982-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] dfu: fix Kconfig dependencies
Message-Id: <172624213645.2123016.3742309567261739307.b4-ty@baylibre.com>
Date: Fri, 13 Sep 2024 17:42:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-b7dec
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

Hi,

On Tue, 10 Sep 2024 12:27:50 +0200, Jerome Forissier wrote:
> Fix link errors caused by missing Kconfig dependencies:
> 
> 1. DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
> which is implemented in drivers/usb/gadget/g_dnl.c which needs
> USB_GADGET_DOWNLOAD. Test case:
> 
>  $ printf "CONFIG_USB_GADGET_DOWNLOAD=n\nCONFIG_USB_FUNCTION_FASTBOOT=n" \
>        >>configs/am62px_evm_a53_defconfig
>  $ make am62px_evm_a53_defconfig
>  $ make CROSS_COMPILE=aarch64-linux-gnu-
>  [...]
>  common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
>  [...]
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: fix Kconfig dependencies
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2f9c472dd7a91bc2d6e7840a550edcd257ff8b57

--
Mattijs
