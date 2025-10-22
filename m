Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E8BCCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E2883303;
	Wed, 22 Oct 2025 09:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E/jo47XC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE518323A; Wed, 22 Oct 2025 09:23:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C47A8334F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so23692535e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761117780; x=1761722580; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1OigwMGu2qUz/Wr6c2ZM9vzBqFmfffKLQu9kLf/6aQ=;
 b=E/jo47XCQU6/cOpccwVk5C17OWjn4k0QGIBLxenQlKwIu7HhKBcb0/yoPj5fTsnyaZ
 wDLyNLnFvgMaR39IXnGr0XDmXu3qiFUTM/7utAMaeNdoEeuQPmDH3EKh3r3VCuKu7Ogk
 QSWFpLgVR2BywwPSghNzoaeZVMJ/bOYN0rpmb/54Pnq3Rt+k/qi7jiHeveEgJSDuL4O1
 vaHiOVutjvmLcPZZz3rYVn2cHROtESJOo6mzElf+FNePpKsNpZMoP0lCDbMX3ysASfTk
 +KkT0zZB27/prY5kg7NOcBfuEnpx12T0oA+be0zH8WODdF48m5V/DMTa78xJoMJMap3/
 CrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761117780; x=1761722580;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R1OigwMGu2qUz/Wr6c2ZM9vzBqFmfffKLQu9kLf/6aQ=;
 b=qcKTC3zyqIXx4rk+UCeHtSUCduc+FgsxWW29wYTuL5+D/HzdbCJlPE66tF6a8e28Hj
 2Jzw7meFpARodVDWpo98bRQv9to4mnuduBuOtpVkpPOBwNgPhlYL4u21KF59nXJtCk1E
 DUcpKlgyFvKo4pSuqqL7Qt9sIOzFJrwMxrVkgASUhR4f7p+RrSH/R+4XNCqMSMmHoQTp
 dqYfActHsY/Kety8vaXR+V/TAqeLjgN1RwXXKynFmX/1cT2K4Z9Fp4yVCLITMeV2Tvya
 6ePcEp77MCXKRnj+55wCAifSp/QQKXAnwP+6fYzp0ExJATKQKv9xXKX/JbozY+UBZgy6
 obyA==
X-Gm-Message-State: AOJu0YxNhHiAkWD2vYgWP+r/93+jUESpBZCmIxWHnmzDStTeNLVyy5lO
 ZxW95ED5z4AWG0Fusm2p9XLVpT/pGjKLaW1freYbDnbouMsVIdz0hBX0+qQNunuLxRDHwZKAHLj
 3JVhuz7w=
X-Gm-Gg: ASbGnct0VYqpOPaeeROsvF3QiZnEw8yiv2H9LarCbk2YoV1oAphzuFC4p9qGZQ6BtCM
 OsjyFycNkNRjUWgLJc5/U/YewvGo+fHRsjdx7im3NMpkchANrX8tgFOyIg55PjAl4Yy0TfowaNn
 u2TtNgI9ZWwEb1OAUYmcw1EfwEikhyjECXPM65zRlY1bWF/oYEktxIi+7Zfu8+pXB58O47J0+q+
 sDGf+cfVUovsfZEydXqxH8PtLSpcoVMvrIq2oGbZOs+hjsaHmEzJtOKlRVuiV8z5EXdFEGGiddW
 YmX79tTCYt2LBB1Biro92y+MmV0tbX8y+mozWHQYhyouMWXQOleXv5FT39LTz+S0gcRa+peO5Kv
 Uk3IntoIZ2oydKcV1JEXwBCRyxhDKCtqDXmq+n/lzARGH0WsLI8HgXp4SLY/QEeQIIne7TgNvd6
 /RXVo9Hig=
X-Google-Smtp-Source: AGHT+IGTiWsqZTonEDBBs/g1TcBTYPCiK3S8rVKOWyKy7JDdueUQOBglpgeXCieg4nCC22dPX/DiMA==
X-Received: by 2002:a05:600c:4ed1:b0:46e:506b:20c9 with SMTP id
 5b1f17b1804b1-471178a1d2bmr144829185e9.12.1761117780447; 
 Wed, 22 Oct 2025 00:23:00 -0700 (PDT)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b1260sm32579815e9.13.2025.10.22.00.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 00:23:00 -0700 (PDT)
Message-ID: <8c1297f2-e6ad-4f2c-9cc2-49ad1df29e2b@linaro.org>
Date: Wed, 22 Oct 2025 10:22:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-2026.01-a
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

Please pull tag u-boot-at91-2026.01-a , the first set of at91 features
and fixes for the 2026.01 cycle.

This small fixes set includes a change on clocks register value and a
fix for the sam9x60ek default timer.

Thanks,
Eugen



The following changes since commit bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2:

  test/py: Update to a newer pytest release (2025-10-16 18:03:27 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-2026.01-a

for you to fetch changes up to 68b1f2aeb811e2d450051a0cc9c055f5c59f2cbf:

  ARM: dts: sam9x60ek: select PIT as tick-timer (2025-10-17 12:34:02 +0300)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2026.01 cycle

----------------------------------------------------------------
Dharma Balasubiramani (1):
      ARM: dts: sam9x60ek: select PIT as tick-timer

Manikandan Muralidharan (2):
      clk: at91: Add ACR in all PLL setting.
      clk: at91: remove default values for PMC_PLL_ACR

 arch/arm/dts/sam9x60ek-u-boot.dtsi | 1 +
 drivers/clk/at91/clk-sam9x60-pll.c | 7 ++-----
 drivers/clk/at91/pmc.h             | 1 +
 drivers/clk/at91/sam9x60.c         | 2 ++
 drivers/clk/at91/sam9x7.c          | 5 +++++
 drivers/clk/at91/sama7d65.c        | 1 +
 drivers/clk/at91/sama7g5.c         | 1 +
 include/linux/clk/at91_pmc.h       | 2 --
 8 files changed, 13 insertions(+), 7 deletions(-)
