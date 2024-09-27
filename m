Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4513BCEBF67
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CF888FF8;
	Fri, 27 Sep 2024 03:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TPNlNR0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BD589027; Fri, 27 Sep 2024 03:24:27 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BDF88F89
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7191fb54147so1176853b3a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727400263; x=1728005063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W673a31e4nb22R1tTmcE82O7Ma5qqHtZKqr3LVHnpg8=;
 b=TPNlNR0yfHJbBYsymGmlUlIz7XDLl3201Wql5y7XkpPYBBnT1z6O9o2MKvTmNmYJ4f
 DHo1CULB4mCi5GUasyVlPHCaBUae1cMuAl0J1Nngic8+bpuBs9mS94cOn3qCz9zFdJMr
 mMJbGuOVdStbhQ4y6yCeIdg2HN/wSXJMr//ysLycst5OSahoGtX13gd5r+SKJGETYhrw
 KKRMFslI7Q7HOCAGHrpFQg1ljuM3EB9hTnduAYaasH3EOoi8nkpHQPv6Y2gwfkmmoO/1
 dgXDzXyQlf6QHsexnWTpLqLOy+U7as7farsdgtZJKx48H1NE/I/yZ3U6xayN8VXtKKKD
 FeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727400263; x=1728005063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W673a31e4nb22R1tTmcE82O7Ma5qqHtZKqr3LVHnpg8=;
 b=BlejQaCToUR/rous8GXJFPjVS0nLF/zzFXIGsmkGhJC+8XdF16zKx+wYpcN8uQ+DMJ
 v9VBmpfxvYSZEC8R7xvzjpay/zyZiaLX/+WNPn4RumvK/OViA6ES3BviCVO9v+kmOtzT
 njxfvE+OjZc2dXVlchedmMqSwttWrGvT4ee7JgNQ7OL90eqhRp2+w6Nf3nLR8++xHDDw
 TIUEMDW9xJiBscyyzK6NqKXrBF708oBmd1zBnMfmC86OzRPciV4OBjKUIOItcWD7gusy
 I6uxqoU3eqxTxoOre2jOjfRhNb5bTdspmPIYU3zfRVV8X4F3imj0zYxq3fA17pdwmi9i
 slyA==
X-Gm-Message-State: AOJu0YxLc3aayRaU3ioXR1hdKrv8J1DzTstfoWUfTOkU3xuhU6sEgkl4
 6kVA27wQ4wjxZEJDZLDdX8lqVPRdVjtm6knOPTDLjW41atwOsc3uWPg8Jg==
X-Google-Smtp-Source: AGHT+IFPj4P2GMrZHQZIb9YKQVMfgzufnnEq9VPZM4qC4IG4o2xthsbKIV/tEcTawVmp273YzzVCjA==
X-Received: by 2002:a05:6a00:2e95:b0:717:8ee0:4ea1 with SMTP id
 d2e1a72fcca58-71b25daa3bamr3254069b3a.0.1727400263392; 
 Thu, 26 Sep 2024 18:24:23 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652e609sm516341b3a.182.2024.09.26.18.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:24:23 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 0/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to
 Infineon 2Gb parts
Date: Fri, 27 Sep 2024 10:24:14 +0900
Message-Id: <cover.1727400131.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

S25HS02GT, S25HL02GT, and S28HS02GT are dual-die package parts and do
not support chip erase.

In v2, split the patch and add fixes tag.

Takahiro Kuwano (2):
  mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon s25hl02Gt and
    s25hs02gt
  mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon s28hs02gt

 drivers/mtd/spi/spi-nor-ids.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

