Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94E606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PavquYdJ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AIHFj+6l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4BE86071F;
	Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IE1AhmUEKGHR; Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D2FB60726
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795429366;
	b=jkz8xohkEiUnuWyudfM/BhHTenL3C4qvW6pSDDdEHT1WhNuQ0keRn+ncm+3fpzbYd9U0
	 ymxg9R2AKxFfFfm0YppBOqBm49FLQ0UHvzf73b1IRS9O0MMXkRvDzrO9b1TXoJ5J7ey+w
	 4+12hRmYueeL6V0CbjPUJmZdFru/xAd+L789s1R2b/AHqrnVFgflJbkAXPyb9H/vtR/PS
	 R8aJDPEn2DZgaPSoMz+x0Qm0iz+x4iC6/b16QMhHlRkNoBIecxtgwNhMKnwNpmuElB4wZ
	 22NfA82UioZmUXcP+Sr4I/z2IcZucOzrH/cMkWQxVge8WnAdE/Yj+duEBYg9rm5B2Lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795429366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jLJJweLJjtBw0NmeVGr6DY7FoL2U6GIdgnJbUQ/CF3M=;
	b=jhXu0s/xqnR2BOAPscTVd7g/xn1RDttKkEh3fmTRfQMAvHys7ApGCYCsoY9sGGVRkWFb
	 1bztLMTInEmpBTbx1+zcVhhkePtoIAEPMrfYxUg5pjyuX1bBKJbssw9y2z1HK6ymLAq3K
	 lG7PbXkyWJHtm+fD31aB8vEpOTi/6Y7DbrbBH3YjvKKYS7lRaQibVVLIwvfARHjruoPgk
	 e9PeFYZlO761EXJk+Il3Vdbnl6RCT+GBGD8t7Gc6sjf/6tIJOipR5e88grCy/KQgO5PZd
	 10HUq7n25lp4fDi0aRo6Bn183H+u+YJgNbyNXu+rG3tHuzWduX/kH8qr76Bz8l6eNCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795429366;
	bh=jLJJweLJjtBw0NmeVGr6DY7FoL2U6GIdgnJbUQ/CF3M=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PavquYdJhQVgOQXax4ESAaVjonxDB1jaJF/qKY2ThNAGYpsp/1OzShAJDWw12ZR02
	 etOtXMap9eF6xoUEsg2sUG6Ggfrdhb/PSeMtF7t127ucyQJEBp/2wNyWEhWEiP5AFF
	 aTrtC/5RGV+J+3fEIuHRUyLcASneJA1LZNUo8yDsSaVit2FkXwiN5XrMjtVH2y3alj
	 j7ZnwmlV10cSZx+JpZKVBbTQELD9ME1mC0fq9nqw8y1zXsYaNKl/KaKFNB/CtP8rmX
	 wWuBCJIjMR1DdzOZQwJgHSrrPOgYUtEAwzhTLjr8h+0HdSv7SovhCw2V1KXlXVGU9m
	 rqsDwSb/s+bjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D2FB60726;
	Mon, 23 Nov 2026 10:22:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62C54260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5473180DD9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYq-uoaM2oyD for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8267080DBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AIHFj+6l
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8267080DBC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:22:41 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so28872435e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795429360; x=1796034160;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jLJJweLJjtBw0NmeVGr6DY7FoL2U6GIdgnJbUQ/CF3M=;
 b=AIHFj+6lQUlDL0SXXC4fJr8zzsUJwS35hVf1PsN1pBofmXJTFpgxYz+gQwNXgPvyMA
 HZF7++8Fh9nOQwY0FKrBvzqUcL2cJy+tKSZCJACZB8OtcebrFGPlIVrZuFIqkBwlLpvf
 yWtpf/l7uYdqZ9pc6duETH9hiT4eher1pRCwEeMtuLo+WwuUKOr63WnW59T7A1mv4l0w
 Ck/wY5wUG8sz/r8yDQHkT/sluOhc0iHfYkM2ogWeHv0P42v3pr2Zxi+BzlflDyLIItaf
 75B5ZDla6YeOMbplklv7tNcVQ/si9ffsrK4404DWR2E4fjndTHl4gpk2xA5tC5JxAV8N
 cjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795429360; x=1796034160;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jLJJweLJjtBw0NmeVGr6DY7FoL2U6GIdgnJbUQ/CF3M=;
 b=jCXjT1xB2dypdcMZf8E6Y+QXLYZehvohKJIY2RqFNqPZ/ZGMBJl6dLLBwSqboMyT4t
 tKtTYh+I7z+aT4o+QCnObqYDifn/z3SAaefes23z2MEN+qsLj8n5woFaOJ3kxuL1fLKg
 cOGmHfq5yjpsqEpL+2f8fFJcagGZJsygMyaf103VjzJLlBdgdFpsafLB3TctadKON8tH
 FwCmllQYZ1jFsvXVVLqQ3ez3EPzHUCm8emXlgJD0etQ1EgEc1zGrHG9BmMddji0A7YeJ
 x9erfXhDpuxl/uL008cD3neyas0nWgF5GI7CJ4dZtZW5fsOCTPZ4vPRt2MKpAkYXyVPd
 TYmg==
X-Forwarded-Encrypted: i=1;
 AL+hErF0UrfbRlDQALR9fmW/sKVJUE8J5ZAPllmS1gAiaqmHu5nD/wErckAzc9nABxWt31ybkYVcQC8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Xfrua7dSquQPlERBfRATbI+32FrKUaLAMBxrpVUd77a3wxw4z
 vdlm/BcBPBJI+TPwdhvczLcL5hk1fyA8GyuOjRxddc0gqI/n6y/y54zSfVp1h0O573o=
X-Gm-Gg: AZFdTZekT/FQD3kB+fsf7MyHItOjnip9e163e+3DMm4tlveeJZY7jC8PhvCTPy1QG0O
 E8y7rpO1qepFxbuk3eB7364ptxbwbSkxP+HExf69OqN71AFrJp5y9mEecdlUUQYoGwIXPs7vY6B
 I6tRm5MHRFo38qHyhh6WlEBLEI4g7r4nA0JoRltkW3aGCPTzo8yiSg4hrTmg3YQA5XQkIUdPHzo
 LJT2GaFyYc+OGu9x2kzXq/IDQ3WMs8hyIfu2/EcETdq4GJZy8X0pR2rSsYw9zH+05xC8om1Iobh
 9BpYFxAgvaFAkvKcDHwi+Yz+Qk6zM/YICprPOIV0QM/qaFo7MhrP3GALQhXkA/KiIZLOIgr2/xH
 1B09MKWXDvqqQ3E63wLBGO4Du1E6/BYDLmrmArEumFWvZs1OdOOTnUHYVTKh8NCC5RBkf5WpRHu
 lfbwz6TXv5kH9NzeKRkSunFSbTXobbwBxBNPHitR653SDY9IE1K7ltmKsfmhC5wBlw1jbYM+lMO
 1fJPltyorZXpoeTYtEyDeWYnErNo7+wkBWvujuXrL45o+YrtJUW4IXSJkN1kmFFUOuNxIcYS6Qx
 TkKXIMV7qZ0/kGC+MDM8BDgJkhQGP7Zt1uKhvCneGO+F2q4m52ed22V2cE1cVb5dc3WrLUagTtB
 US/sejtgu+FT2qRwB0tRBuo3uxbBZJQuy/xzTgIXEQKRWyg==
X-Received: by 2002:a05:600c:4e02:b0:4bb:8636:dd7d with SMTP id
 5b1f17b1804b1-4bb88817f77mr226910365e9.24.1795429359931; 
 Mon, 23 Nov 2026 02:22:39 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm400342655e9.11.2026.11.23.02.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:22:39 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/8] Enable I2C on the MediaTek Genio 520 and 720 EVKs
Date: Mon, 23 Nov 2026 11:22:15 +0100
Message-Id: <20261123-ccaione-upstream-mtk-g720-i2c-v2-0-7d3f843db7ef@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/42OTQ6CMBBGr0K6dgztooAr72FYtNMBRuUnbSESw
 t0teAGXL3l537eJQJ4piFu2CU8LBx6HBOqSCezM0BKwSyxUrrSUsgREkxSCeQrRk+mhjy9oC5U
 DKwSpqlIbXdiGrEiNyVPDn7P/qH8cZvskjEf0MDoOcfTreWCRh/fv1iIhh0pq5zRi6aS5W7O+2
 Xq64tiLet/3L4gcMHnfAAAA
X-Change-ID: 20261118-ccaione-upstream-mtk-g720-i2c-12986a67bfeb
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 520 and 720 EVKs share the same I2C wiring: an MT6375 on
I2C4 and an RT1715 on I2C5. Add support for the MT8188 I2C controller
and enable both buses. The series also fixes clock gating, pin pull-ups
and DMA buffer handling.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Split the DMA buffer alignment fix from 36-bit DMA support. Put the
  address-only probe fix before the new controller support.
- Correct the MT8188 timing calculation and limit the clock divider to
  its 5-bit range. Reset the DMA handshake for multi-message transfers
  that do not use the combined write-read mode.
- Give each MT8189 I2C clock wrapper its own compatible and gate table.
  Use the MT8188 fallback and an explicit clock divider in the SoC DT.
- Set I2C4 and I2C5 to 400 kHz and match the Linux pin group names.
- Link to v1: https://patch.msgid.link/20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com

---
Carlo Caione (8):
      i2c: mediatek: align DMA buffers to cache lines
      i2c: mediatek: skip DMA for address-only probes
      i2c: mediatek: support 36-bit DMA addresses
      i2c: mediatek: support the MT8188 controller
      clk: mediatek: mt8189: index I2C gates by wrapper-local ID
      pinctrl: mediatek: mt8189: fix the I2C3-6 pull resistor offset
      arm: dts: mt8189: describe the I2C controllers and wrapper clocks
      arm: mediatek: enable I2C4 and I2C5 on the Genio 520 and 720 EVKs

 arch/arm/dts/mt8189.dtsi                  | 150 ++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi     |  32 +++
 configs/mt8189.config                     |   3 +
 drivers/clk/mediatek/clk-mt8189.c         |  38 ++-
 drivers/i2c/mtk_i2c.c                     | 375 ++++++++++++++++++++++++++++--
 drivers/pinctrl/mediatek/pinctrl-mt8189.c |  16 +-
 6 files changed, 582 insertions(+), 32 deletions(-)
---
base-commit: fdc9a05c74e01db407e538ebf7024eb9e332e0b8
change-id: 20261118-ccaione-upstream-mtk-g720-i2c-12986a67bfeb

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

