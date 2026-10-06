Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9508CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C84A607E6;
	Tue,  6 Oct 2026 15:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypqAR4idaj79; Tue,  6 Oct 2026 15:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 60C58607CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299495;
	b=cCYECC1whxLdIYJXPOf2I7XqDkJTvyqzNQDn+AIm9MYvnTaBbpxHDpmIjahIOBNH+yLS
	 83cCZH9HhWAkO6IGJ2RH+HH86HTFqnCf/gA/4tzBX4yt1A0reD+23s9LepLmv+LGQiJML
	 Z94+gDWIBaEyQR/BPgYnvVQA36kBgXBiOd7bJo+maf//8vy3hZlvvY8sXVNR/3ggIY9mw
	 OMZ2dWkdsn9tvCG0IuojOjolKU2PQ1zpbdKfq6lEH1vwR3EibdSfvlCibZiL87PpnltgV
	 GolBKIovAT7bIHqYyI4kWcL0+YstJNUaeTqIp95Ow9l5tFAnvELJjjYV5jc2V37J5xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299495;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
	b=DoK8dZHoBhqu3ch4r3bD8kyYhPKcu47zvNcaDL8SnnB+AjjIJ8YrfQWP50gJFLAoKv/D
	 wQ9+ZAunNqbYFEHZGoFJLz1cbLdoHtTi1WOKrclo2HPfqV0tjxFpjHhuPZnWJui8YKMQ4
	 B2RDj69b0tffyghM2pONsX6HpDO5dO3OQ5SG7RHlD34t48EvJX70nW9elTSGcfQN5zhi7
	 uQeje0kdIoFXFmnx01LQ9NYaJml26gL/G1HEHqZvXTgz87/gwBhUfBYbX/SnkXFpV1bdM
	 gU7y3CBKtoeCkmMeFwjMY3dKFeizT22b/fGFJMFv7R5nXN+ZGeCI1aU+iZ2vqHF3YsQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pg2CSp0v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299495;
	bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQpHidg6L4dYqcR8+R2UiYTpfYbfVnOaCdvhajLh3CR7oZNwXVylzWkIp0/4qrh1l
	 /T6WZSHm9BYtN8UCPl2xDF0eVmF0djn333cKZmzAp03qk5beUxgsVfO3htUAe3KmJP
	 ZfvLm1XOcmvTfAy8gDIFtUG+vcQe8Hsdc3vSY9XIKl8xCiBlLSgJC/85c1AoJz/MUB
	 3TBz0rJ8HRq6zT5OonjeWYJLBqvSnEdFhYvCGACtvjpB8Ub/fk4KrKyTczor7FXMDs
	 xuS8lNRES0KAyK7arRpqK0XEjX8WY6mOqQQ4iwocSGMQPMuMWCq6+oDf5kMgKu+6p4
	 yV5JRpsY4BPLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60C58607CC;
	Tue,  6 Oct 2026 15:11:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F74A75
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65559607E5
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zE7RPa2X_bJK for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9C462607CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298918;
 b=LHaHpk9ZwmyLgSfagXJSAdsNBwv9E9ZBZYkdoQYXyxPY0/Wb8dR66MHtOkDOoVuE6PXH
 VPdcy8LARN0k3YjqxjiyVDBPCMZ3531mXeEwY3Fb7GQc5xSBKvhGzoS/z0PVreDYjylmk
 7ZrtEyHkyxN1anKkquedM6J04JhqzDfvH61CZPcyQjpvBQXrUESl7uFxjxru5/8QgW7XB
 N7dIRdGMpq43LcIPqfVLGTsyjgS0w8rIHsd5MpNx30TOeSsi+5Zbii1a4OqWsYXBHJcgp
 xpwyHVwVc3q1AdwRqIbiERSWlj2tdCMBS0zSDNRFzB91a+TmXaXfUDvcbJ+IyuqJKJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298918;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=aybyudqJqlPshzW9J5zAdVdWxOiH4Df8CX58rbD23oTGUcqLRVVc/3TOttqYpeJwtuto
 sNICA7YVoiUx92MnGEN6TYaQYIcB0jePniDZMllKyx69xj/SjAQvmqAjmV5xek/Qc79Pb
 BGguNWGvhPd0PFneR2BdNT3sFN8tQqbAMgCShMH2aig9w/OA5UFnm+h2vsRMH+53KcQ4W
 isj9voWQKwR92YhjxH5UJL7n8AdtsVtnAxYg6yCLdDw7CXAs7ab6iqeQRZKpVOq2J8sS8
 5vDj0TXUflOnjdwzyRhz8CVyF0QoAkTP3Ay8WsvPVq0LLjJtmsIEVzW7xauezqfTFcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pg2CSp0v; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pg2CSp0v
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C462607CA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:01:57 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so6163985e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298915; x=1791903715;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=pg2CSp0vmaUeGOTE2/UhhhvqxP3p0yQHF8F9hqz3KkwCfIcTI2Hb/jJ4sIpGpxNFq/
 Ocw1SaBuU7Z687Q2tUt70YDs0uvqeqBBlYkQu/f7CzNyrNjHhXkTdoylD6xm9JyCkjiM
 l2H+5CAWIOaFFITKRj7J8xGq95ChfXUsyYFtuVgV87Ofk7GXe1Udx5OWTdprfEUYg1Ha
 RWFptjbeLPN4GklFXv+l8UUryrb+xQx0SmKDincO876torVmgTc/CYZ1l88UMH8PK/qv
 lRhm8u60A9i+YfIDTEcfGf6YjMItr6lpBT0Z+y6tgqdCDosYDZG5nMCAtJy74mDtVDGA
 S4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298915; x=1791903715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=PocvCr0QP1R3zneaV8u0Z+MEd/3yCqcc8sStIs4kPRjs1LR9zCI5Si1I4bi8PSJl2G
 vDwpdApFQriR4UOa7UsQ1HLL4e/1Q2jlD6EpUoaQIIToxgGB9hZjwQ2bkYpG6jwySYvC
 qyeIyhEIsQglOekwzVGEgJDBWro9b4DxoNfkQ2lEq8lR48sWH+6K+3QpXv+BuFqTNCc7
 BBe0rZE5ULUlkomTPk4ZxX2xCmbtD5dkxqBIHSYS9fuD7uqxQHnicgDKS8H1gtIFZr8/
 1QEb883Loj/jDfDoGxzChClSeiPBiSE2cXkSwKC4UpSz9/AIMsbGG9J4Aw8Xzvbf46kX
 xkzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByp/5NR4+FWLrDtvRizxlIQL/tsPWrH5hme4LM60rt7xxY74X3hom5mLngF9vstnoAmOyFt/d0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nHlFlvizmRRBUOdtw+o8UHJ8amlguVrwTCpIbRjnjPYPS/sN0K
 Z3X0/v76PCCvHu/6LrrKYLtLmOSvqPff3MGCXvex6ZOs4MiAFEXfU7LpEzLaXdtQwMY=
X-Gm-Gg: AYBFou3fEknsardGGvDWIfpg83LNNwIR+HEtJ7/Vdz8Vd3Ppg9dAdtgRJvKdhBwXvgv
 LOs0/wz+WcGYdMs9YKea7IpLTa8jE/Gn2ltECqI+pVVcQ1kHugZ3Z+4j3YbFRlppsCBvnrLUOD4
 eHiK7poaZ+ndHA+WU6WPfbVCN0XNWjNuBmiHAsesgb04zqiCp/zgL77GfWtZqAsndfT2Z0jaieE
 TvFaKMh98fikHyg1jnL+avyd6nssjyUBkfgFH1OJyZGPnwKtL8sp3gyAAZSNXVgJHWQyeGOR7s8
 Sd9WwCZ9B5GmiGXUUI2tQspnXo7vqIuN5KylVbYNlN9+gpZX1M+d2f58azGqJ108/I5D87sva5f
 Q47T12VXCYtWD1c1iGpPti9Axf8EgUw5UqEAn2k6P5Qg0yQi+xJNQv6K2ZCRbEV4O6e1wPD88YV
 KRtTvLwQxCZ4q8wEbNvn3YMEH5lDxwX92I1WAG31kuufJIegyNcNpC1/6Yt08gfV2G39cCjM6uB
 A5MvtpFR6Pz8HQ4iHbpXGUsMhI5eqZERJS1D4l0u7gp6g+IlW1LglIypdC9Y/q7kcZl/JSt/qKa
 bOtkZzITTZ8w
X-Received: by 2002:a05:600c:3b98:b0:4a1:7d08:780e with SMTP id
 5b1f17b1804b1-4a17d087812mr21154055e9.1.1791298915110; 
 Tue, 06 Oct 2026 08:01:55 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:54 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 06 Oct 2026 17:01:45 +0200
Subject: [PATCH v4 1/5] arm: mediatek: simplify SPL boot-device selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-1-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Use phase-aware configuration checks to make boot-device selection
easier to extend while preserving the existing device priority.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/spl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 6f1ec052b95..125ebcd784f 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,15 +33,14 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-#if defined(CONFIG_SPL_SPI)
-	return BOOT_DEVICE_SPI;
-#elif defined(CONFIG_SPL_MMC)
-	return BOOT_DEVICE_MMC1;
-#elif defined(CONFIG_SPL_NAND_SUPPORT)
-	return BOOT_DEVICE_NAND;
-#elif defined(CONFIG_SPL_NOR_SUPPORT)
-	return BOOT_DEVICE_NOR;
-#else
+	if (CONFIG_IS_ENABLED(SPI))
+		return BOOT_DEVICE_SPI;
+	if (CONFIG_IS_ENABLED(MMC))
+		return BOOT_DEVICE_MMC1;
+	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
+		return BOOT_DEVICE_NAND;
+	if (CONFIG_IS_ENABLED(NOR_SUPPORT))
+		return BOOT_DEVICE_NOR;
+
 	return BOOT_DEVICE_NONE;
-#endif
 }

-- 
2.56.0

