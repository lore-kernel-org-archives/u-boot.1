Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0011C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 20:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322B5836C8;
	Wed, 13 Aug 2025 22:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qy+v9GFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F7A8365E; Wed, 13 Aug 2025 22:55:37 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8A0836E7
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 22:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cceb382d1so250598fac.2
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755118534; x=1755723334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMujfpzoE5Yp8poo6aqAFOiTBnHalp8kwpLa/V3tWSQ=;
 b=Qy+v9GFctUBZiWYdKsKd0peBDDMNgy6RxpDC18V44VA/tgtyfpc96y31kemjGZ0ohx
 bO2+eO97WrC9kIvFVeFB6Sde9jxzH9RXHj8FdsGsM+ehHZwnKoxe0jsPI7bKcjp3fPs+
 FGcnoYX9hqWkIlxJJYSmMnTY2rWjn6A++cdLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118534; x=1755723334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMujfpzoE5Yp8poo6aqAFOiTBnHalp8kwpLa/V3tWSQ=;
 b=kOdwed0KCSXo/vqXFKDWJ2Me7Fcb8O/t5FLAafwka/UMYGwrcPfMRaTFCsviH85zM2
 UZFpUU2zZ79j0+E1qkapEDhkE/57c4bu1CTbUKYgB2S/zQSdk8EvLYbUv3q2IWvBE2nY
 QQgQPSE5AzpF29z9dutsCEalhXnmU2+7AWDmj/vjhdD93VfXx2810PPLgVbdXif/sRa/
 49tLu6Y2BacZo0IGHuS4H036u2nH8wefOs6KCN2tbDx60KQBmGxx2JGDeN4ZK1QRd45t
 KBvJ7Mn/+xq4Z2+qMxT8aeVmuDZzApwk73sn8MFYO+aWtkkKThzchc4xF/Se1C1uX9lY
 164w==
X-Gm-Message-State: AOJu0YxaDprUU3/E+Lcbe60yEdfuKQkHUpmsxzogmaluXDxzJMLdSCYA
 3QN0ZIKSvH5ys52XOe4jTlzYSBNJconmWTrq0qlHkv0xvWd/eG3Bf4ql6Wazw3i8udc=
X-Gm-Gg: ASbGncs6Yc0bKzG5aPp1S6hL+n7HpesMZGCdA9SxmqL0Ogm6I0gcAPMk0i59DnlKQt8
 1IsbE1Jpj6gSh4Hf/f8hG0Zyh50fhWyZXYBQm0VykEb22L4EdnGnE3tufHQLiRCTvI176MucYah
 /2ZzlYzB/sw6A6Mc98pGnXiAX64UL5WyNomGXuWrhoeq6gxPCsTMwUaI4d97fkefg6PLWkBGU9C
 ds3kIIUDRaLjR0NWDlhYKIskUUmZw15EsdBMD9ZNu+FR9+fZSex/soGNfaM5/VKqWeaa/+GOLrA
 407pScTVpzshNk+gn+jUOf4X9ESeB+b476MzZghCMyPaOetVwFlvSLM+Kk1TbUTbm88rSNuMDxU
 1h8xstm+eZGn9ivqfK0B/uLMcGnm+eCGkKWBV82K5GNCTYk4hNFP8PJI=
X-Google-Smtp-Source: AGHT+IHPdnW4KCS6o40jwg2X44unqtzq42J1doz6Wowvxm45Zj7qYFIcNSfv4RR2Ha++Bya/TtNgFg==
X-Received: by 2002:a05:6870:c98c:b0:30b:9366:91ac with SMTP id
 586e51a60fabf-30cd0e34b8cmr426171fac.12.1755118533874; 
 Wed, 13 Aug 2025 13:55:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f96e0f9sm1073834a34.34.2025.08.13.13.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:55:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
Message-Id: <175511853286.3420755.11255995961537407021.b4-ty@konsulko.com>
Date: Wed, 13 Aug 2025 14:55:32 -0600
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

On Wed, 30 Jul 2025 14:03:18 +0200, Quentin Schulz wrote:

> U-Boot typically can be loaded from different storage media, such as
> eMMC, SD card, SPI flash, but also from non-persistent media such as USB
> (via proprietary protocols loading directly into SRAM, or fastboot, DFU,
>  etc..), JTAG, ...
> 
> This information is usually reported by the BootROM via some proprietary
> mechanism (some specific address in registers/DRAM for example). For
> Rockchip, that information is stored in a register
> (BROM_BOOTSOURCE_ID_ADDR).
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] rockchip: add /chosen/bootsource to U-Boot proper DT
      commit: 28a87c8e9bc889a875b7b4b84d99ceb905d9d2d8
-- 
Tom


