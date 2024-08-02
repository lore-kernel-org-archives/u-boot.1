Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E45C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1D588C18;
	Fri,  2 Aug 2024 21:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lObDDuV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DC088C17; Fri,  2 Aug 2024 21:51:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB8F88622
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428243f928fso49277095e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628316; x=1723233116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=leuubVYaLUtH4af1t6UlxW3hcQqwVo/36vprPcewXh0=;
 b=lObDDuV+HjacLF29+LMGxEu59BelxRaqhqVlGagrGMH5v3eM7lsimbdVngX2419rE8
 iN5GMmkxU6NOY98c/nA5ts7SHsPke9rL7hxbicln1H3n0p/AXQT7OYUSwqSRB8HXTlK/
 PE+EaRlW7sYOnhVCCmUFyVTwAPRS577QtZHfo0anFudIoy3GMH9Qja6LIHxtEhFmBVFr
 bmvlY2IDdLQ9k/+LF1ZlKXw8ZDvfrY9wG9tGwUb9eZKtLjh+KP+BcRCXRRd7smG0cBhv
 TvfdXjH2HLhXQa/n1HrQ0fiog4c6OSRh0uV6gAHaWKg+NMBtfmVGY/z3m20dIcZtEu4L
 MtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628316; x=1723233116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=leuubVYaLUtH4af1t6UlxW3hcQqwVo/36vprPcewXh0=;
 b=XK6XmQQTkbJWu6VRA+UZnQip7zTSgmimFY7UpFzDxxgOTwUuC9hD3WBSeqiLESaJrp
 B8RatOt1uUNhweXx52zvZM5N2cfPQx6g3QD09jluM7lmaO+hIQp/SDaDyequWtcPCjSt
 6cOy0qiIRmgbQ4a7SzSu4W7oTAkITtSGEkUFo4Q0NSA8Y6Wuk6Sw7cx9GP3meSCAxAZa
 tl/JPMW8KsG4aXKJEn/CqX7uj/7xNdo7iphI+B1gX9VXuJbl7qN+HnzrnsuiXfNLm2CW
 IrPfoVlEBPmF03v+YE3sQpUETarrgrirsm481a7Az/M7T1/O3g/C6js/9fVLxCoEX1tm
 HDzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+bOsXIUUCFAK55CewnMQNbOtoKsKZFXZiobl0Wq7n6xgHKn8cs9uZBoJbRY7tFgU1ZNQCK7blswMdVaBx6D45MLKKA==
X-Gm-Message-State: AOJu0YyaxFGe1z8y1dhYqtw4wudEX53XLOecGga1iCjvb4fUcRHfHPmP
 O7WXF5x1zv5Ie8DU0jHCnp6lZdfehgaJlTr+3IoCEyZ9uopW2tcr
X-Google-Smtp-Source: AGHT+IEbB8ubWXGXok7Hk4aRBijdUUsfIn2HnKINRGTaFvtsW1Ma9/vwW5aw0RFggzSxsngB8B5pAA==
X-Received: by 2002:a05:600c:4f95:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-428e6af2e72mr36311935e9.4.1722628315861; 
 Fri, 02 Aug 2024 12:51:55 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:51:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/8] clk: mediatek: mt7622: clk migration for OF_UPSTREAM
Date: Fri,  2 Aug 2024 15:48:24 +0200
Message-ID: <20240802134835.24006-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

These are all the required patches to migrate clk and correctly support
OF_UPSTREAM. This will align the clk index to upstream to support the same
clk implementation with downstream and upstream DTS.

Christian Marangi (8):
  clk: mediatek: mt7622: fix broken peri_cgs clk with XTAL parents
  clk: mediatek_ mt7622: rename AUDIO_AWB3 to AUDIO_AWB2
  clk: mediatek: mt7622: move INFRA_TRNG to the bottom
  clk: mediatek: mt7622: add missing clock define for MAIN_CORE_EN
  clk: mediatek: mt7622: add missing clock MUX1_SEL
  clk: mediatek: mt7622: add missing clock PERI_UART4_PD
  clk: mediatek: mt7622: add missing clock PERIBUS_SEL clock
  clk: mediatek: mt7622: add missing A1/2SYS clock ID

 drivers/clk/mediatek/clk-mt7622.c      | 104 +++++++++++++++++++++----
 include/dt-bindings/clock/mt7622-clk.h |  68 ++++++++--------
 2 files changed, 124 insertions(+), 48 deletions(-)

-- 
2.45.2

