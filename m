Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666ABCFD658
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C11283936;
	Wed,  7 Jan 2026 17:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sjYcxdab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD3983A47; Wed,  7 Jan 2026 16:51:23 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919088398C
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso1671774fac.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801078; x=1768405878;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VsKlHX97nK4mCXaurY8n7nPAdB/oJsnMU+cNHzfSpKY=;
 b=sjYcxdabzoAVfMFnYMeumzqsOaKZHwaNLk7dO9Rbum3QjKA49F5J47Mr/oSa19dzJC
 fOTgrQDx8Xq0AznHACwj20r2/ugY7YMfGz7uDuTJsG+BkoAG/N3V+7PmUIcYQbmSNcj0
 XQ9HsqfaW9MIG0V02pjBQfej7PEiL0YWQpNk7/IxPpKrgXbDyxShNhcVPq6VhQNb/YUC
 f7A2EW6D8jbH31AlfX3Ac7cLGs/EUfLrhN+n7kyyWnVOLxJc4guNNH3JwjKPcttC/gzC
 i2YsuGAq54N1oHVQUQsX81ccmFQ2/rnK7eaydrzj2xne9PT7IamfW7FDKESLWVlJP7dR
 WWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801078; x=1768405878;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsKlHX97nK4mCXaurY8n7nPAdB/oJsnMU+cNHzfSpKY=;
 b=OdYguqXgzUzb3ApMrGLse72ZrfC+vrb0wrpy3deQxxt21z73zBQaF/j3MAuUkSBTjR
 yTmIH1lT3QE/3YH3enG6ZJMVsRRVRXmcAnCBrjzXopIt3yA9eenhuOD/xVaGB57sA4kA
 29O+/a9PMRK/0IQOoBva8QBA8Yu39AQukZ+R7JWagu38PgI1Yr7YD1WAmAxin9weH117
 mmVoqKrbjNqZiXa7tqRKhopwFPpBzmXyzSLtPvoY7r5lXK7MPX0PRC4DcR5z9hfjwE3P
 gz0H/P6Ydmb1okf4405UZt5lpU09Br6sXLEVYkmKP7Q7inUw0+79E/8GuAGAIrWIH79B
 dR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXzoEzitQfbXm8o5icPIa9YSCzDRANAf0Lq2OG2tVZFinbCN0+LvuSumfnTNFmupozrhsDlRM=@lists.denx.de
X-Gm-Message-State: AOJu0YzGHQj4uaE60yh4i/95C+KhG3+8Wy0TPTKC0ztzEpZXxZSRqU1x
 x7a/Lpy/+C1RR5MpWf8H6TVO2dyzOyv6+5vdnNf4wjPLVXNLG/4te2NBnXoO4APbWgA=
X-Gm-Gg: AY/fxX5ubl3YnHHCQaFyXK5XoPxXw71BIn1nLL7OiPBr1u+0vtuR8wVYQi229ovrJb4
 Rxsu7MbNgCvCAdq7lFIAlSs1xOnnebaYmWDmJ4Uy8NNa2bjHX1jcULCHH9gO85uFvgqp7KH1QaU
 pATKf8naJz0r9A/xvw0/Qs6Jx0VKtRVa3Dnz+PStKRHbt/cckiXSxUR/iOGvPWLmclMtZb21INI
 V8AZt66Eetns+dRUnuAySJYVNeAO3Aj7DfF/dR02uV9ycqg+FXZP3hVhIHTFhJC204PIh5zuH6M
 wTtVjSnSrOASox6NCsdjqXO5YKu9LCg4SckNcOvikqZljFxCoesVSrC+PmbC7OxO4IrAQg5TYJ8
 gcpCStZxBCpEzG1v3wzN/2IrPS10JMMG+2aqWz/yRlDO82N8hGzZ0aYxB+d2mMvnSqNX219dsiq
 ZpY3lHeoHpdyb4XII=
X-Google-Smtp-Source: AGHT+IFyju9lp9lK7cjjcYXxE+yjPfcSFJRakgL2ceeSpJqjQQdb48HIFwQ3WOoer4f51tfL/5hYZg==
X-Received: by 2002:a05:6871:80f:b0:3dd:6bdb:e741 with SMTP id
 586e51a60fabf-3ffc0a0ed7cmr1193164fac.26.1767801078002; 
 Wed, 07 Jan 2026 07:51:18 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:17 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] clk: mediatek: implement of_xlate and dump
Date: Wed, 07 Jan 2026 09:50:10 -0600
Message-Id: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OMQ7CMAxFr1J5JlCnVBQm7oEYksaA1aYBJ1Qg1
 LsTCiPjs/S+3wsiCVOEXfECoZEjhyGDXhTQXsxwJsUuM+hS16ixVm3fKZ86xf4qYSRPQ4rK2dJ
 uHboKsYKsXoVO/JhnD8cvC93ueT19j2BNJNUG7zntiiB85mHlTUwk8BEuHFOQ55w14mz8Cpr/B
 SOqUm20s1ihNbhu9tY8e7ZCy/wFjtM0vQE3ERLC7AAAAA==
X-Change-ID: 20251215-clk-mtk-improvements-db0b9d1d3113
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3xEUj+0h+apFENleanmqQ6dIgq0R9JXOE4oR11iS+R0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoC4fG7+XuMckdZ3tlyWBbaNAjehlMyRNvv+1
 313NRpM+VaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6AuBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvQ0H/2AdfWm7QmJWlCoKq0yPFYA8zK0Z2qLB0uW7Mtg
 /M2qFz3On+ezVzoW5UdbPNSECf+gci893hUJomNOV8vGe5EDZK7O3EegYt/vlVePLhNV60Nq3y+
 35ua21xy4Ebn9YZwrz7g5HjrZ1px5wUDDQ59V24vXru4TFeCcq7jP+XisfFDZ7FE1prRTP46bDt
 akU93sShv3PwP7ZUbc8FBo4A8dalvbC/eiq58M4UcPlEPnABOC9nxRQr4gGRtZV8dbr238uv9a+
 e4r4ufl87+WkLBeOsMVUNQRo9vsiYIkZCJu1n2NXtlzAZKYBHSFBsA0QZ8pDDzIOl+JBhZADQyZ
 nmfE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

I started looking into fixing some bugs in the mt8365 clock driver and
realized that there was no way to inspect or debug the clock trees.

I set out to implement the dump function to help with this. The driver
architecture didn't make this easy since there was no way to know the
number of elements in each of the clock arrays. The first few patches
in this series are adding fields to the data structures to hold this
information.

Once that was fixed, I was still getting crashes due to other bugs. To
work around this, I implemented the of_xlate function to validate clk
IDs as early as possible and return errors instead of crashing when
requested IDs are invalid. This also makes use of the new size fields
to prevent out of bounds array accesses. There are a couple of drivers
that remap IDs, so there are a few extra patches to handle that as well.

Then finally, I was able to implement the dump function to print out the
clock tree information without crashing. In the v1 cover letter, there
is an example of the output (it is quite long and doesn't need to be
repeated here).

---
Changes in v2:
- Rebased to latest master.
- Added changes for mt8188 clocks that were picked up since v1.
- Link to v1: https://lore.kernel.org/r/20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com

---
David Lechner (8):
      clk: mediatek: add array size fields to clk trees
      clk: mediatek: add array size fields to cg gates
      clk: mediatek: add array size field for id_offs_map
      clk: mediatek: organize infrasys functions
      clk: mediatek: add of_xlate ops
      clk: mediatek: clarify mapped vs. unmapped ID
      clk: mediatek: mt7623: set unmapped IDs to -1
      clk: mediatek: implement dump callbacks

 drivers/clk/mediatek/clk-mt7622.c |  21 +-
 drivers/clk/mediatek/clk-mt7623.c |  24 +-
 drivers/clk/mediatek/clk-mt7629.c |  23 +-
 drivers/clk/mediatek/clk-mt7981.c |  13 +-
 drivers/clk/mediatek/clk-mt7986.c |  11 +-
 drivers/clk/mediatek/clk-mt7987.c |   9 +-
 drivers/clk/mediatek/clk-mt7988.c |  18 +-
 drivers/clk/mediatek/clk-mt8183.c |   7 +-
 drivers/clk/mediatek/clk-mt8188.c |  28 +-
 drivers/clk/mediatek/clk-mt8365.c |  10 +-
 drivers/clk/mediatek/clk-mt8512.c |  10 +-
 drivers/clk/mediatek/clk-mt8516.c |   7 +-
 drivers/clk/mediatek/clk-mt8518.c |   7 +-
 drivers/clk/mediatek/clk-mtk.c    | 669 +++++++++++++++++++++++++++++---------
 drivers/clk/mediatek/clk-mtk.h    |  43 ++-
 15 files changed, 697 insertions(+), 203 deletions(-)
---
base-commit: 53c0d5b387956bb4070a943b61991898373a20e2
change-id: 20251215-clk-mtk-improvements-db0b9d1d3113

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

