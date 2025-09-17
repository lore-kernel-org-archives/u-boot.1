Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC51CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1E783666;
	Wed, 17 Sep 2025 17:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b+WMBQRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0128368E; Wed, 17 Sep 2025 17:08:20 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6EA835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-621706e28faso1103284eaf.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121696; x=1758726496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQnaRde7HKCFze7+TictFy0bDYuUb0KE89rfUaAGTro=;
 b=b+WMBQRrpF+12sxLO28jo/ZRbTNnv/zDM1XdoRHiWdBcfEXNAVO0uaKDTYL0+CewH/
 Zx7I1mP48iz8UbEr7oAqz3d5shCYLZ0QMW4Yd0helJa6YmPIlJXKqNzGMJwSqBiFvx0b
 GlwInHCUr/M+IaomdFCnkX+IC7MFfFIqFEV4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121696; x=1758726496;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQnaRde7HKCFze7+TictFy0bDYuUb0KE89rfUaAGTro=;
 b=BwHH9VOw/14pPU/JMT9hXsS0jto5SgQfBtSj2jwKUcirArNG+wwpg51TX6BfJecXwU
 htuwpFCYgL7Xatw4XkDiIl+HXOMwXXFXowSSWsk2nQnKFVbhOpvDJjt7AGA52RQn2/xs
 GibsGLvIi/utdcZJblUwN7XQpQbCq+hJEwykG2KdBfmp/k8qh/vqX1iLKiXszjLqUiIx
 1oiFRjT/gUVVNdkTbYuHdZqUUSUJ9HFeIhTX4p1K9HjVWO4OzJjJNDV7Zf3BTxcHtJHX
 LSVSNjHgJAnUyua3Rp/UnCrQpzu9dG1ZOB+9uc9CHEhHO5xzG0PMyDkZN9FLspCTi+jV
 Bang==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCNquoCXj8jGFYVI4EOFa2VpVGx/fX4KzSW2l0cEGGuiYlvK+GbNbsJJGRTmzDttinvw+Vxho=@lists.denx.de
X-Gm-Message-State: AOJu0YxdV5de1O6uUZM/LELxrWgHFxeiRuDmAjnwsnsPk77uluc7hYYc
 KtJSosw7f76bIM3fW3GB43ROeu8dcKXsW8T9f+lAe4fpUHxEfP6HBf+H2QPe1gYDoiA=
X-Gm-Gg: ASbGnctk006uvp+vFPhk5Dk4DJADzoOplQBNadmX8b5FH+vYNR/Q76kIrg58aps44JU
 dnJNjFwoP57ynerdxW3evCnHHVx3PMc1c9m+6gLnLbTgn8z8gV42CFDZayHOzpy88YePidO5QJA
 v5mKKB43eQNjd0UWoPD24uoMG81W5c/YT8ortOzZy1CQCr8q0KZ15mb7EPFlTO+sn//9b7eltSx
 81XpAhU+bBd5RfaJy/jfi5JKwqYfPOWD2TmQPOEyFoAR9CwArB7lSyA+Twi5fIkcHmVbkWEwSTK
 kT8l8ZTDiitEfEiKQehACdNPknDJ1Z4jUY5nPBzWIIpZc6EdB/z+UzwFj/1OIGiUV/hnuV9MBYj
 otTg3624n0ufjanUlHjrO0t+yVRAfrKV311oMBZV+mtPpJcmJw+T1HJyT8wNhYOeB7Q==
X-Google-Smtp-Source: AGHT+IG3Y4qE3SeQ3eCyn6wvbIxSrDCIxPu9hjHAc+NYYsxyflEZNko7CFlzE1p/XhvR/J+7Z7427A==
X-Received: by 2002:a05:6820:1c87:b0:61e:78bb:ff16 with SMTP id
 006d021491bc7-624a4ea2983mr1416971eaf.1.1758121696419; 
 Wed, 17 Sep 2025 08:08:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250917094659.3922343-1-a-dutta@ti.com>
References: <20250917094659.3922343-1-a-dutta@ti.com>
Subject: Re: [PATCH v4 0/4] Hyperflash boot fixes for j721e/j7200
Message-Id: <175812169538.761188.12913544010466679526.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:15 -0600
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

On Wed, 17 Sep 2025 15:16:55 +0530, Anurag Dutta wrote:

> This series introdues a couple of small fixes that involves
> enabling hyperflash at R5 SPL and u-boot proper stage and
> Kconfig changes that are required for HBMC boot on j721e/j7200
> 
> Test logs:
> https://gist.github.com/anuragdutta731/0f56e8d9bdf0cfe3d221c69d09a58704
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC driver
      commit: dd4039e380db3558319866e5f03a3949d88af9bd
[2/4] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at SPL
      commit: 96cbe36c0bad28fadfdd34e52b8ba87c7918c5dc
[3/4] configs: j7200_evm_*_defconfig: Enable HBMC and MUX_MMIO at SPL
      commit: 517744041f37751de094ddef3efcf7a1c5fe1e71
[4/4] arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC in R5 SPL stage
      commit: 6d4320d7612b6bbb907b2f157c503ad9175a8d43
-- 
Tom


