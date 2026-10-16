Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EE2CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9687C61197;
	Fri, 16 Oct 2026 13:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZehWwvIeCvGs; Fri, 16 Oct 2026 13:24:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18105611C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157056;
	b=auKEnwVLzv8OYj8Wm+s6BP8swxHUY+QMz0EcVS9Wq6xr9rds7knNBNx0sSagMzsiNWFU
	 Ci5q2eBpBspx6glygtmsK3isGCKUXYhOuMxIXuePWBpry430FWfCAwTL8xGTSO8KujsOl
	 7cOOOTnOsJin7xyp5E3tgAzsl1deYiRV0mC0EHPEPU6i8HI7fifA9fnn25y8OAakhKv+Q
	 xC0u5jr8X3QVvW146cUcJkjLEs+SIi8FbdXGAvJ9xcNtE9T29IK8H5zkIX7fd6b4ds4bl
	 c9GgrY8pR+VKq93vGMXG2jhm+hkk//0EOUSJkoDHTghc3v8eZmLulzWag/t/TzWvbxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4KTdYf650btZ39bV7YwPDv6HMsfHiIuQdDKLBGUjjZY=;
	b=X8hxoAic4nkpb8qwdO0C5Y+gH5qzs56e8QorE5zHDef2hxMYoouNGWrAxCBuKqtAUOsY
	 3x4xNVTVa4W8MXN0ONxbh9MB/7Y9ZV/FjA6AeU9EMlAmUFyvS/dqzTFH9jrIyXON+NRbO
	 KkOmh2tTBxq8mr9POe6qLkTnlp7rgL26gjNusPLWJoQ2DXwZk3ekAHN5JKnHlauEFXN3Q
	 ztJ/LPZ5K1O8hoLz8EKQDrj5apsigsMnl1eOBE/FkmIsRzCe/OPK4YboD5Q8JpuHslWD2
	 TCsShdzptZTN7ipbirqAWkivVOZLd4yt6tKN1PYL8THm1ZRsNOiYJPgwHv3xA2PiqFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157056;
	bh=4KTdYf650btZ39bV7YwPDv6HMsfHiIuQdDKLBGUjjZY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OEkaAsbX+20NSg0CnxuksUQejg5ayAHSauwf0nq0NH8dH09ZP8acXCyf6Dao4QBMA
	 CLfzJ1m2W5PKeREnAW0xp7+LYGOYgmPLuiEMSm8LWg1EOJqOFO4ZZ2JnjgOlkZhgB2
	 ZuSl6T0S8nlMBG7qroamNFp8pK4r63WVeosB1BWa1koUpFvJIiIMbVZU0VqPNN9m0x
	 P0qVq4nMRxL3I5Tbn2f5rhBR8UrQdblMxYDWUN/XR7zr/E+a5PYn6GlK3L3tN4TivW
	 GEKfZJ5CYHLhEE9M3VKtWrEoyIHGcM8DKX3T03g+Us/YxUvOc43YW/WzwLGyg8em3W
	 34F88lp9SxJtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18105611C4;
	Fri, 16 Oct 2026 13:24:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B323E362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 998AE4046E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JlzMWrESAqBr for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8BA8C40100
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142212;
 b=ODGSLhZAi4M8CXAeWEERdvrNhacj/78B3xn4H7ax2iiA4fvgazwxGXy2zMui3UR77tfL
 uL2axN+bFqRqBBKnhQlKWTtFv5gdn0QavnoFuju+DN+sN1+MLf3aNe5l5KkQ6PrFrGvH5
 McgZopMX/+Lp6xZj6MeTbS9mm+ZU7aAb/0f589VkzP7Lk68OmUYUyTyWW3xK1Dn9GLLCL
 mVCvAOYLvS0DkQkUSgpO/HjumwRN0zDv/5MX7ZBL+DNS46T3+78NS64c8HaVUiKd9nyfC
 +WM1vAOzpP6ruoIAunbxPwYBE8JppRpSLNmu4MtsHDvLCMhU4i5eLATZT2fxc8bCWFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142212;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=4KTdYf650btZ39bV7YwPDv6HMsfHiIuQdDKLBGUjjZY=;
 b=MQQC59QGPemiZU751vwDR2nXc/WPC+wPnvtk/atDossxiuAFglO8S/tBdKo2F9HWzYme
 QraBuFDdiaZBDLlKaV1bD1OROwYjIgA62zfFQ8mzNkcGv16Q7uf1YGMIE5DC6PpW4cbSG
 6OxCSBojF2LA+javbU5UmCU1f9mGKV+gb8IM7AJ9aUnmjXVQFt3IZrZD+UOXKw/0FzOHh
 bAdeiCFm0YW5mbbZhMz9KMM6E05G27VMwj6bVHx5snMp1YfqkzaWca5j1NTfd1rASpEee
 f6UsE5ftynvkZSgG3qm11Mx89gDKj4mn6x5Vuv3/wqph/LTOTZgoYtO9mx8y2CXEEcw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IUMjDWNh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IUMjDWNh
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BA8C40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:16:51 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso223046f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142209; x=1792747009;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4KTdYf650btZ39bV7YwPDv6HMsfHiIuQdDKLBGUjjZY=;
 b=IUMjDWNhIyyFpeHeFESlM+Sa50tCq6EHxzsThPFG9WrF16I5UQ/x1cXnlsOFM4TSWS
 CYSZEkLAYkEYg/KQnZyQfXygfZOc79hKnsmgDt5NwY1AILGA0Flj1hv8/a1fV8ettP75
 G0tB417EWrllvBvE3qxumyI1eNLZf1i4sBv78WYZeJFTZzWc6suX5ZpUPy7i/rw+d0ln
 fXKT34BCkBDEUfGl79r+n60IQ/6q4Abw+1p2LL+mRSi4FpSt0ySUhkJhqiA8N4awQTed
 1nAVed8OK0tCP2GE6tHJeNfBLI+aHA0nx/yA5LDEtNm783EOEobp8vnWXzdcgfEohB2m
 IFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142209; x=1792747009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4KTdYf650btZ39bV7YwPDv6HMsfHiIuQdDKLBGUjjZY=;
 b=b/skGx3hg4/NdAiMLoVnh3tpcqKlKgMDj/5Nz+YM0/EYTo/cLMSDqdHf8BBdevuQNe
 Rz0wM3yIBi6wCxZeI6wQZNcfOXcL7HGB0ZEA+kmKGsvQNYolfRjQsOtFXsSwuf+dBNQD
 4ZQ84rWlsR4+5GYpynWZGzZgbj73K7pOrVvDHUmWc6WBRRKx6T7RGf52GXl8AFVNb0MI
 9yfok6HSkMB4u/JWTyzrGP8ejNhiztHpIrn0APNBaMr/5DXrNvYiwY3om1tsTQe0JDw+
 bg/I9B/ZsnYOfaJXph+HJnG4kr+/tbyDoH5Ho6R/+tDShA4tGYWg2uGQtvb5yYMY9PhF
 v8Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4hBNGdQ8Nzkj/OZj/DVPFaby4vXc21L1k2vYefivDDN4lIzMfl3LQ7tEz8+StNoj7e2tdGoU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJCM3qWvGL350UJmpiZtIhfdVZI9QstBuFmYhFrYs7WTv7+2aVU
 gHKwNANBELvG6dhU+M5DnEVfa0dN1fpFxVIYAaOsKWtuRxuJuxa6nvvtTbx1AilFX93dqA==
X-Gm-Gg: AYBFou07JmpbN4Vt3Qt3ZRrPLlvuYQxp+Wik8Ne1sF7bS9v5AUAVo6hcsov281DZf/J
 1Awv2wsqGc3mH/ddP7G2Fp/bu3CLmn/0ikYnbES0qfcxGn/QDaRVwkdACgFQA/SQzBL5+uHPr+y
 tDlp311vxnhOpKkD3Brj/L9+UN0q6QTJKsoovz3YOeAASwdlmSq233JV/e0yNxZA+O0rr6w6Lze
 QqSqPuZcIwJ/namo/kTWxxXcyBB8W45ZKn6+dX4yCCE0ThSFtAS60zjTHaDmTFlC55qX+s++GT+
 A7IbGuy5RvblMhhbkjBUPNdkZ83RKmJev+f2JD2nsswQcvwUswj2+fiehfSts6lxbeGUsFNLN11
 nhNst7lU6XYUZMWanFOcgJUfUku5LgHeudPPfPAPgWwMV1wQG+c6uNxbVbTAkT57fh5ENEfZJgq
 tbwKAI4gjbGrYbqW99qSV2UCT9NnobvqpGlLBrpDEg6SvTdBoPhQM+13qplf4=
X-Received: by 2002:adf:e014:0:20b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48ddf064b52mr19497686f8f.32.1792142208964; 
 Fri, 16 Oct 2026 02:16:48 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:16:43 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/7] sunxi: add the Allwinner B288 and the PocketBook Verse
Date: Fri, 16 Oct 2026 10:16:01 +0100
Message-ID: <20261016091608.121842-1-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
readers. This series adds SPL and U-Boot support for it, and one board:
the PocketBook Verse (PB629).

The DT is still under review for Linux. Until it reaches
dts/upstream, the last patch carries a copy in arch/arm/dts.

Tested on a PB629.

Pablo Mazzini (7):
  sunxi: add support for the Allwinner B288
  sunxi: dram: support the Allwinner B288
  dt-bindings: clock: add the Allwinner B288 CCU
  clk: sunxi: add the Allwinner B288 gates and resets
  pinctrl: sunxi: add the Allwinner B288 PIO
  mmc: sunxi: B288 mmc0/mmc1 run off PLL_PERIPH0 2x
  sunxi: add the PocketBook Verse

 arch/arm/cpu/armv7/sunxi/psci.c              |   9 +-
 arch/arm/dts/Makefile                        |   2 +
 arch/arm/dts/sun8i-b288-pocketbook-verse.dts | 114 ++++++++
 arch/arm/dts/sun8i-b288.dtsi                 | 292 +++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/cpu.h        |   1 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h  |  16 +-
 arch/arm/mach-sunxi/Kconfig                  |  14 +
 arch/arm/mach-sunxi/board.c                  |   4 +
 arch/arm/mach-sunxi/clock_sun6i.c            |   1 +
 arch/arm/mach-sunxi/cpu_info.c               |   2 +
 arch/arm/mach-sunxi/dram_sunxi_dw.c          |  97 +++++-
 board/sunxi/MAINTAINERS                      |   6 +
 configs/pocketbook_verse_defconfig           |  10 +
 drivers/clk/sunxi/Kconfig                    |   7 +
 drivers/clk/sunxi/Makefile                   |   1 +
 drivers/clk/sunxi/clk_b288.c                 | 101 +++++++
 drivers/clk/sunxi/clk_sunxi.c                |   5 +
 drivers/mmc/sunxi_mmc.c                      |   7 +
 drivers/pinctrl/sunxi/Kconfig                |   5 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c        |  22 ++
 include/dt-bindings/clock/sun8i-b288-ccu.h   |  82 ++++++
 include/dt-bindings/reset/sun8i-b288-ccu.h   |  45 +++
 include/sunxi_gpio.h                         |   1 +
 23 files changed, 827 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/dts/sun8i-b288-pocketbook-verse.dts
 create mode 100644 arch/arm/dts/sun8i-b288.dtsi
 create mode 100644 configs/pocketbook_verse_defconfig
 create mode 100644 drivers/clk/sunxi/clk_b288.c
 create mode 100644 include/dt-bindings/clock/sun8i-b288-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-b288-ccu.h


base-commit: 65a7532545336e4b73e049a69436e255da7df961
-- 
2.52.0

