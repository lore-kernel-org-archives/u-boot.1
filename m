Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB20EC55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992A280E23;
	Sat,  1 Aug 2026 16:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i10ESStdKtDI; Sat,  1 Aug 2026 16:41:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4B7480DFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602510;
	bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qve+Ay5vW7gyYlEbAwL9uH24TG0yEknKc+y0ueiSGiB61bgbRa4SuSF+ErqjiQubN
	 3LU/loSnIv8UtcYz8QHs995hzqtGhUUA43sBvfLBTNvSHMcrzddspv4THYC4PAo563
	 ELMpwtT4V4NXuWXpv4/vsmryjb6vgt4eTVleS82tEENFlD4t66L/AeBtJojro3KCSa
	 In7+Z6oWxafv3y647u3Glk1LKJt7ryADIG0E+9SwkMrCIDsFTYDGIL7as1GVoX+VqV
	 f1o9MoaCaHGHvc2qBj7A30tdSsE61ZJg6QWNI3hi08NKDQWDpAyMW9+zqIU7axw4IJ
	 Syuvk/03sV0nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4B7480DFC;
	Sat,  1 Aug 2026 16:41:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 767F532E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C98080DFC
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9uW7KUSo9WR for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A41A980DE4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A41A980DE4
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A41A980DE4
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:48 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so2023487b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602508; x=1786207308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
 b=k2rsNT9oDW80oGyGmNDx2UAKzq/NEwIAWtmDmg6G8vlvR9P+32f3BiOAXAHySkpAKe
 kLT1OlDslv1gQ7zs4yUBuYNeFTwK5qOBx+4sN+9DuJPFhgEbjO5TfnzCLAA2OqhFOLWG
 cOAqyTJtWCOv+4Ilr1DFmy7B0HD8NlRybgob/cn2TyqwD4cHQ/jfMwHX0sTHOjhX7bu7
 vbdsXKIVUDEv+1fwYCgDG2Aml6w/oDC/CVxZTcj1x4ImXU7dfYthPrxJNypVNeT5k1Qa
 ePR6dXuiK8rjhWjCTLDUHKFFBKgx/+lmP/G4mJCCnmfFJJxKZ4voN4yTEzkdXWgXYEYb
 pRRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoB3blzy33LRTwMo3T101FZCx/Kbz/IhyUsufXDzvPZCG4IdW/HNwfFm/bNvWcKYBaaG8z3kj4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxEGUEJWceBlJbjm0Lrdu7LJrUwmees4C+eMu6cpqM1CYnuZ4qH
 mi5ddM0LFbdgp8xgvW0KYzt+4L76ks0xmwzSdpQAiUgvlXnS6A1awmOV4B25GNvbjvg=
X-Gm-Gg: AR+sD12AUJvfQTPewbTQrqoWFJ9GPZN+6Yii/uGvvJDGTFaurLMuD/MW8F+7h/u6k2H
 gsZHwmsXErO6OLwPuAI7vKg6OiZ6xFtHT6TiNsIaKOK3/yvDg3lGIxj0PPoZ2lDGo9nt9elrImN
 lqBnRHcRddRZHldWRnuRInf4YjaB0A7vlB/HR3iN/2CRYySnbm+fiTe/LN3Webv2B7OXa1GeaII
 CxkyrBfwZPVp8af7GX9sxm2o07H0i5Gpm6S9fEg0pn25cK9Do5DSECu6jRVHGk1u4p0WKjnDnLW
 6GNeyHbizMSbO5YEbkLZtzo6yqrC61USGV2WYgiBJNRDMuOkFwBNFXjEAWwz3DtQz9BhO1TmX7x
 B8mjYUgYGj397rMKfwism2zBdPIoPRFcqogOvW9s7uQPFOpSXrGfrfLJ4lXGccxFSic7Pi5Q3Zq
 5SAEHUs7u2q/gYO0CMEbmjBFDP7+0FOSntJZ7e3uSmxTWoaDz8PSd06OmdFBqrPpystNhDqDm9c
 cjkVht1XgvwQOXuSvJt481N3lQIWGddB+4eMBYA9BhUoSKMYONt+r28Wwrd0YfiV7R8Be956Wm4
 kjEego0DHOgXfd+Wvz0wisTgGw==
X-Received: by 2002:a05:6a21:1644:b0:3c3:b5db:cd93 with SMTP id
 adf61e73a8af0-3c92a5a7a2fmr3948685637.13.1785602507965; 
 Sat, 01 Aug 2026 09:41:47 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:47 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:49 +0800
Subject: [PATCH v8 08/11] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-8-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602508; x=1786207308;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uJQRrMlbLg3+wVrYNdX20krCDzsw3oKumSiqJW7NJ9w=;
 b=cwFMBmtcFxssvg7hxmUVLgSCvuuW17iJPjIgK1MkXqXih4Vk7hI75iknbCb/pgmhqt
 l+LhnLVxQw0PxkpI73vxAP3h5rv1xAdLS1qscsayrWd4iXSn2kA1L+nAWvE3BfBeeVlz
 Yx8fBaYsbmON9sAGbVbTYpjyeErRrVIvopoZwPNZJoDBI9VkQ910DGX5S43UrZRR+Aym
 QBAxHUFKI/9UBO1+5r5emcZlkZj41jqw/6M/12DKIh9/OMBrUDxte7qb0R2Iz9bNoNPI
 qF3d+noOVxZPW25jMR7bOIpmYlDXglGUZxNSeNYPXcqmp2mx9TCZN0RLsgRJNbcpYxAV
 m1ag==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cwFMBmtc
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Update the maintainer for Spacemit K1 from Guodong to Eric.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver.
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1e..4b2bc4ecfc10 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

