Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75706C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 10:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C210F81F44;
	Thu,  3 Apr 2025 12:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RLLkO9K+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4601181F69; Thu,  3 Apr 2025 12:15:23 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7359381CF0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 12:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso274304f8f.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743675320; x=1744280120; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kert7Z3g5jYoLnam0hmTc2VbyW3iKdO/3Ynpu9CRU+s=;
 b=RLLkO9K+erVhmPH7u/eenasTk3G0UWuqMx1v0xHQz2SN7laLEpmSK9oxgc+Lozvt8q
 vc5QgjJFGwKcs0iXhX9OXv/icI45t0nkXSfgnfveN2ItYp4L2bZcj1WHWJ5b3swX1DbV
 d6p5xYweqVe7m7QR8lBU2ILceLbvRjvnOmEulS+TrudGedGbv+LQA0AAAEfRm8sBf2cr
 A/BzaCmmAuss0blZs6rWNRfqZkKcTKlUjPG0E6DCCqDkw33DYIQ9GFUlLtoIb/rnkluC
 51shYLVCE0eAPkhHyx2PnlCFXZhtZp9XC01eU9d48glNj8aZyfF2TVUYkt69kHjLt2ky
 BTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743675320; x=1744280120;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kert7Z3g5jYoLnam0hmTc2VbyW3iKdO/3Ynpu9CRU+s=;
 b=Zf4Q66rBZPlcRSZZ8JxqF87QzEZocPWJJDIDgTxwLmGr46kIYq3DH3kyssvkc+BbCr
 K7/SWCv4U9ul9ZujmLUtRHwPFAXv0oJCmllwOIWFMHTxwA4ftRlwJpi5L7UbPRyZByEL
 ee0CS6WtS0ob5tGb/1EcZ+314K7jYPJq0WPQR+lEBUEEP9OVgN8qiwHKRx4K55aQzFqK
 NK5bCRpuLBNsl+3wOUDhCUotL6xmlG4cF5sa2rKy2ixiSdlqSseWWr/zbhsTvNkjjQzf
 qklJv+Vl9m98S4J1Bi3a4yQ9SYUyXYC6/2ksHbfW1OaKXUSzqViAhR6dYGd78C6svldq
 OqZQ==
X-Gm-Message-State: AOJu0YxuvvkQMR8QFNEIEpjgkST+aVEX/zIBK3icFkPvfjEDhfyqNFaH
 qIO9pI81lHwyTaQ+4ZySroSvG+ZCydYXvAoD0C93XpjRcGmZbhv+doijpPt97y0=
X-Gm-Gg: ASbGncsbIE0jkGvpu3E/knOQKORBZuxneCG45nYrsvkXy3N4XuGiGT5Ua4sZo+kCK/8
 j0TbuxsKCjzBb2+KyJAiLldLPj9PXbPeqPF+GCSXwOjNsOVVhFMSOE6OyZOF09yD9qMNdmAnqXO
 C6GtIO/IBkxuw2SzgWuGFogXWMwX0kZRCAbwA1XOXBv18N9x9YcyiacCuRV5K+EXQ7MKgFO1jyW
 WmwGDpMqsm8PX1qSkzSluu2+H7yr+ur+ZOhW5uPuRHllk9zQ1R0HYguadq08qJiXwGRiYL8yLRB
 i9uuEteB9bD/uYOOSbPV8/2H0riHDl/L91nnhDwR2bBj9zI7UdqI
X-Google-Smtp-Source: AGHT+IELtUdOjJL+q4g2WUF5OmYIMTvj0BHBY4SnGY3/pJW3lNTMIiDMJiWpZOWmS/tdOjjE51XfjQ==
X-Received: by 2002:adf:b64b:0:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39c2f9444c5mr1604167f8f.36.1743675319814; 
 Thu, 03 Apr 2025 03:15:19 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6a60sm1344828f8f.29.2025.04.03.03.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 03:15:19 -0700 (PDT)
Message-ID: <fd4216c2-d450-4e47-aad2-b5986c68f157@linaro.org>
Date: Thu, 3 Apr 2025 13:15:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-fixes-2025.04-a
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

Hello Tom,

Please pull tag u-boot-at91-fixes-2025.04-a , a late pull with a single
fix for the reset command on sama5d27 boards.

Thanks,
Eugen

The following changes since commit c17f03a7e93dfbbe5d32f5738274187065d9493f:

  Merge tag 'net-20250314' of
https://source.denx.de/u-boot/custodians/u-boot-net (2025-03-31 07:39:36
-0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-fixes-2025.04-a

for you to fetch changes up to aa7d628b78df74faffeaa942b61a0d75d3526eb3:

  configs: sama5d27: Fix the 'reset' command (2025-04-01 11:36:35 +0300)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2025.04 cycle

----------------------------------------------------------------
Fabio Estevam (1):
      configs: sama5d27: Fix the 'reset' command

 configs/sama5d27_giantboard_defconfig          | 2 ++
 configs/sama5d27_som1_ek_mmc1_defconfig        | 2 ++
 configs/sama5d27_som1_ek_mmc_defconfig         | 2 ++
 configs/sama5d27_som1_ek_qspiflash_defconfig   | 2 ++
 configs/sama5d27_wlsom1_ek_mmc_defconfig       | 2 ++
 configs/sama5d27_wlsom1_ek_qspiflash_defconfig | 2 ++
 6 files changed, 12 insertions(+)
