Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD4C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 01:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A34E88C01;
	Thu, 22 Aug 2024 03:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GLLmPOvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01F488C4A; Thu, 22 Aug 2024 03:10:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B487588BE4
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 03:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-371b098e699so116987f8f.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724289049; x=1724893849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKQJzbcYisUWHN7zgqZ6u7q++eJLhZioeICRJBbC9As=;
 b=GLLmPOvE53brCF3th9nhQvpSmaRiyh87A2wwYPeq3155KAfGU9/6vgDGLKQaxhozr+
 USgk/xncskJhmrdj2HR/LTsDomfAaJn94LGPZosJn9nV5tZsSoFQloJ+Ucw8jwcni9u/
 j5gbjwtX5s9YlIm52Ev/rlIvUGSs2Wbmx97epfQ6DlrJIx5bVd57A8Pt0Wc+TbV4w7lx
 Qrx1ActbvEUjpYP2Jg6irCjIW/X0XafeQl+cTbdfA9aQOhUoOd4oJksL9lv7oRkxvj7R
 sVT7ZgQXDfT++42Cn0mpQX3dGWisjNB6vyIO7ckR6BvN4OeaUAHOBzpav26ZxybeLE+a
 mosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724289049; x=1724893849;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKQJzbcYisUWHN7zgqZ6u7q++eJLhZioeICRJBbC9As=;
 b=HMsjguTfpBannUfLSfbhyHUAfqsaUL6LVL5wbes9XLa+mXUqXJWoRmE+9kORHH4obW
 T5TT2EO6qTEIUto0WDXqYr4P9iIrb5SH/SPX/5/DrS4Do7zsOLNEqAI/8rhP0+3XrbY+
 0C+KspkVCkuh8bUJJgcR21kRtpJW9xY4cnGYqJnCG+RYeXH6FzerTigDDSKBtEjEVKtO
 mHly0w3TqwJVk9qaff6iogU9ryoodq7hXkBHTiBzBptQPY0gmqvjhn8LdQW3L1X7j6H/
 kELK8OFX81PGTILWNvsYRQ5AzFYIqNnMv5fNjMzFXzKCVyqSnrrnPJnWUjaWPM2VlpzG
 iz4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDlp4BpL/qKpjal0dky0ztaIzBXLACUIllT8JiVg8642WfNLTqHs6ONcBfw8XaTOJXvSDqR8w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1QNQed7B4z0IyFU/QEFpNq/Y9FR0P0vpDUdyga6tvOF+AFZYp
 JSAR4U5n6Nhs+pcK0BHdX1TgCyeSrnWyJa7cZZ6NKBPo1TkPod0IuFig6ntX6hU=
X-Google-Smtp-Source: AGHT+IFC57rvwR8Ezsv2a3iVx7iTUovhseHrJQ6AY4z7MXPUVWGz0Tf/kZOs3JznMpRUOY7SQe+G+w==
X-Received: by 2002:a5d:4286:0:b0:368:3f6a:1dea with SMTP id
 ffacd0b85a97d-37308c03806mr126733f8f.6.1724289048898; 
 Wed, 21 Aug 2024 18:10:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::e7e1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f28eb30sm35624266b.51.2024.08.21.18.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 18:10:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
Subject: Re: [PATCH 00/11] mach-snapdragon: various improvements for newer
 boards
Message-Id: <172428904752.3615451.3511015182594013432.b4-ty@linaro.org>
Date: Thu, 22 Aug 2024 03:10:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Fri, 09 Aug 2024 01:59:23 +0200, Caleb Connolly wrote:
> Supporting the newer SM8550 and SM8650 SoCs unfortunately requires a
> bump in complexity for us. Qualcomm changed a lot about how the memory
> map is handed over to the "kernel", adding many holes, not mapping
> certain regions, and adding regions with 0 size. The SM8650 HDK has a
> whopping 14 memory regions, some as small as 44k.
> 
> Supporting this properly has proven to be a bit of a headache, but I
> think this implementation is "pretty good".
> 
> [...]

Applied, thanks!

[01/11] mach-snapdragon: refactor board_fdt_blob_setup()
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9e8c8769a076
[02/11] mach-snapdragon: parse memory ourselves
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/07f036907680
[03/11] mach-snapdragon: use 1MiB for get_page_table_size()
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4673e5c94235
[04/11] mach-snapdragon: set serial number
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4c7bc917e83
[05/11] mach-snapdragon: allocate fastboot buffer dynamically
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5f6c2202348c
[06/11] mach-snapdragon: populate fallback FDT
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8ab7b82c0667
[07/11] mach-snapdragon: set loadaddr
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1465eb4026b6
[08/11] armv8: mmu: add a way to map additional regions
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fc417bb2f133
[09/11] soc: qcom: cmd-db: use strncmp() instead of memcmp()
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d83fdebf0b82
[10/11] soc: qcom: cmd-db: map cmd-db region
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8b890a0f0d88
[11/11] qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/10d5f66dd826

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

