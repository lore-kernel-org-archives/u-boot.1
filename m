Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02689E7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489C2805D7;
	Mon,  9 Feb 2026 19:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s042K3lZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9CD83BF4; Mon,  9 Feb 2026 19:24:04 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DDD80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4042f55de3aso3721219fac.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661441; x=1771266241;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XAmpeCJQ7wwm29icFfLbAkATbp/XJ7SWyw5w2or9qvY=;
 b=s042K3lZqBwaBJeXIithy8M4N0btO/dlJz2a3Eah0ONEpRM+mQFanhcz6wrwv9e+J0
 Itzdo+ZtnO35rCEGhIMGrTLGGSyQI5VhwGKeueWmsnxAjQk48EXL3fK7HES8Q4S9Oe43
 UCOAMR9zdUS6H7Ywb/g52/HspYUjP0pHEYf5ltLDj5X1vY/uViTR3CcNDgewxTSRCDxp
 nB7gjsADUX4DfBTTkcKkRg91dABGGrXlSzTYPpOOUlHgbCMLVy+s7J4cw+j5jJsgAL5G
 k+OtYlc6W6YvId7+K7o3BEgkPzXHkjnwKSVJrLsFWbTCHMDIQQPTGgOnXqOon3nUbef4
 FrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661441; x=1771266241;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAmpeCJQ7wwm29icFfLbAkATbp/XJ7SWyw5w2or9qvY=;
 b=tXbiV1prlQ2R4JgWPlMTIS82ChBsr5RTD/WPfdCzYXosQ5hCoAGawJNv8KeExw8A6Z
 e9P/+HJXdIzkJdx/toiXrqscSRQjlCPLK7wKMDT+5hJpYTXkhEb6HsCQzKfIAuRPIyJs
 c7E+ZVsZT5XXFmiUBArIsW83eqYj8XeDW+1D/ouC+SvJj+NnkUTnz/YHcOkcV+JqDT94
 magu9EkDgCaW3a0VrPgt5fV3/rRp3fMGGhavBGk/wtIHcxA3LyFi3sY/Dncw+yfdXo7L
 YNV9nN7GOJQz7QVlYU3jDvG9a/hWpPFy4cPl7jRDh4TvpgdQSLbGku+n8qzasHJQkdAG
 9B2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85PTIG6TKWc2/bXjwE2giTrk4EMaYGlyIKhzRHXKwke7gWHC247ORQc1TcL/8GvNORrp7Ejo=@lists.denx.de
X-Gm-Message-State: AOJu0YzLvXgJrN3CtYijuXQ/ZBhws19S/kq/QQLNdevsOuYQ8Rd4EoOl
 Jt5D0FO58Y5GyeBZ2OlhsnXeF00M+L7PIHYT7Ob59yq/VaH09ukee3qh+v83nDp+bY4=
X-Gm-Gg: AZuq6aL4EeCXT+byRBZY1CqBFlaFspAeXRVhF0ua2KtwY2Y/3rZdEgor+pxzpY1AB24
 501/qJha9ZBvIk5qHXIF+8nG1rwUS5z6p+qTC+RG6sLNA3PPbT89K/hZpGaa8Xnob5RPOdxz0Sh
 9wylTpcaW/RfIbvB2mnobeGHbR2erEx6ktvctse6Wy0bGpwxntTqpzrNb7nzzQoqoPwCBsRefUL
 oYgM5bFtvbKMqx9UTBOE8qP/MWeRHPouCOlksC5w+LN22+rfo2K/grLByJ/wgiQf4glodaBQuq6
 gtLL9NdBgRf+iwDUIcIfb7cksbRHu9j07Wj+hoS3mHKRrdgt3DDoE8nYAQN1guGaZSrI5TnIhrf
 ae4uQosdqbee2cqTTO1CwklyLpM1P6SxMUa6VlsZYX6o74GpnLzXdOUSCt0IFZeiEU9GtKhLvr4
 ltVgmeW6bIgpbJ1E0=
X-Received: by 2002:a05:687c:271c:b0:3f5:b7e0:8680 with SMTP id
 586e51a60fabf-40c10e9e4c3mr195020fac.1.1770661441091; 
 Mon, 09 Feb 2026 10:24:01 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99359eb4sm7993335fac.9.2026.02.09.10.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:24:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] boards: mediatek: initial support for Genio 720 EVK
Date: Mon, 09 Feb 2026 12:23:14 -0600
Message-Id: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QzW7DIBAGX8XiXFqDf7Giqu9R5bDANlnF2C5gq
 1WUdy+OVV/aQw4gfRxmRlxZQE8YWJddmceFAo1DGuIpY+YMwwk52bSZzGWdp4u7eEmnLZTgNFA
 k6HmYp2n0kbfGWNvUQolWswSYPH7Q1x3+fty2x885OeL2yByGAHdHlx12BVi7KoSquOlHc9kFi
 +A5r2xelKqSZa3Vm4bvnrTHZzO619X5H7H6jRat2ohhQ2kNpsxVIY2Ex1D1hnJmj1yRo5sgku5
 xxQqe2grUrW5Q6sewasOCOac+hIHPE7fz1JOB9FV8kSkWCy2lbKVpSvuXqiHgGuIodtno6UTDi
 4MQ0bPj7fYD7EQauucBAAA=
X-Change-ID: 20260202-mtk-mt8391-initial-support-8ccdd761918b
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=01f4UJb3OGMCSM9iUfD+b8jGdVS4d6YdjKauftd+q4w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpiiYeEw88JhvGG9Pmu/1TbRRsCEaZBCB6B2qvp
 ahN5Vj9UTKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYomHhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6Y4IAI5qE+KiHu0AXuLTG76PLSmhZsioxNPptvlJIUn
 OZdWAldvlHs2W0iBhNfJCWGr3Aj2lGC3wjg94vaktA6iXsrNjKc/Q3ch5By2HanDOsLYRn+rUlT
 HcGSs0pOgwFJUwYgVpiMcHkduykhwnFHS7kXaxovlHnaMd2Z65Fs2k11ay7DxHIoVo3D8Cd3P02
 if3YU2UrookI+Jgptlg9l5u44x/0c1/mTjHpG4c97vIa57sstNUJK1WwoXWbnOfv6BfAk+otB5A
 l/FXzsnlrBmocaDMVtHJBgFPx0EZdIkzm0ItGf3Eg+IATEHA47mYyVfv7L1dzmDGZ0ey1c2srpi
 a/NY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:39:13 +0100
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

These patches along with the listed prerequisites are enough to get the
MediaTek Genio 720 EVK board to boot into Linux from the eMMC (with a
bit of extra config that isn't included here because it isn't generic.)

This is currently being upstreamed in Linux as well, so we just have
some minimal devicetree files here to hold us over for a while until we
can switch to the upstream ones.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Chris-QJ Chen (4):
      arm: mediatek: add support of MT8189 SoC family
      arm: dts: mediatek: Add MediaTek MT8189 dtsi file
      arm: dts: mediatek: Add MediaTek Genio 720 EVK DTS
      board: mediatek: Add Genio 720 EVK defconfig

 arch/arm/dts/Makefile                  |   1 +
 arch/arm/dts/mt8189.dtsi               | 243 +++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8391-genio-720-evk.dts  | 111 +++++++++++++++
 arch/arm/mach-mediatek/Kconfig         |  11 +-
 arch/arm/mach-mediatek/Makefile        |   1 +
 arch/arm/mach-mediatek/mt8189/Makefile |   3 +
 arch/arm/mach-mediatek/mt8189/init.c   |  58 ++++++++
 board/mediatek/MAINTAINERS             |   5 +
 configs/mt8391_genio_720_evk_defconfig |  28 ++++
 9 files changed, 460 insertions(+), 1 deletion(-)
---
base-commit: 42b3ee7fa5248ad89467aaf2585f4a08aedd4731
change-id: 20260202-mtk-mt8391-initial-support-8ccdd761918b
prerequisite-message-id: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
prerequisite-patch-id: 5dbe4461fa3456f3c7d80a7fa5a60d52bc719f65
prerequisite-patch-id: fac65a0526e9c15e8a4b3f81d85e61d1947dfe16
prerequisite-patch-id: 0d12fae50ce6da8dc7b0d978e4640431038d5904
prerequisite-message-id: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 0414664c8d24f8303d238aa1c4389072ba9f8613
prerequisite-patch-id: b63492590bec532b0347be3b495cd1779b0ad3ce
prerequisite-patch-id: 9e03fea677d2d9b5ae6860e700f62b27db270e64
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: 4456ef9affb08285f1abab242e0cc665f7a026fc
prerequisite-message-id: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
prerequisite-patch-id: 83634da29eb12fa48edd45b2da3d666ae7e5c00c
prerequisite-message-id: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
prerequisite-patch-id: ae9193f433954e32e91389fc1b144a3a6c31d518
prerequisite-patch-id: 2985130c9247aa746578d0999ef36afae5bfe81a
prerequisite-patch-id: d7f2bde6b8c257d93ae3155dbe51c2b1e956a87d
prerequisite-patch-id: 68791866bda399c0744095f456da7e5e50f50a48
prerequisite-patch-id: ea092efba54b2558bc7ea44d1a53f5f1a6f4f291
prerequisite-patch-id: 5f11d6653f725af32874115536d08e0772e2c36e
prerequisite-patch-id: 4875497d56eaf57175465888abd53de2738b1099

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

