Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC6FC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879D587B5B;
	Wed, 17 Jan 2024 11:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cqNLe2tX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06AA87B4B; Wed, 17 Jan 2024 11:18:13 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FCA87B42
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337c62b5f11so42446f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705486690; x=1706091490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BsuGb2FvFCbiEJ87zMmwed+m8PTaD8MS1ObCaqP3f4=;
 b=cqNLe2tXMtfN7XxabVukN0EtFZrcyi6VAxWpOvhddd67Bywn20F6qYDH/3owXUDBUD
 w75u/T7GsMWGqmu/9E98ssDXI7vRu2JGcXiuKkPt2ZMTjeNufsW+RAnQYQh1gbW3mRRQ
 re35mAGgosF6sdTq6moej6re/UBvhUHSZZGMIhAz43ffj8iN/A37Of2O8Xgv80nSmDBs
 r/qFzxkCtBmhwOX7qqhFf9+T+cW5rEBfxs2SRKEVztIBNIgCWJmUJEBjuPjruNQv0Ocr
 hqb3hWNN/Mhy547OlAVHHIoxIGrMyrbeVQybZyC6ufeMLseJot1Fk1IijATVPK99AB1B
 ZCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705486690; x=1706091490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BsuGb2FvFCbiEJ87zMmwed+m8PTaD8MS1ObCaqP3f4=;
 b=sz/Pi9qyBEZTM9prLAs3+qZWkkAUWPXS11WJy/8lRw28cqkOiNVT5jIvJ2oKVSNQfG
 p/WMXg4jg/5y3I4GGMqHQglLbCn8LNy1UaQjurrhbe7mhXxrPKee7YeXdhrJdyj6IQOx
 2hv3qgMVAifx1KCg/Z1ADfVOkcqmqEUBQcEXkhOLBgpIpM4944rGDom/yDfOu2GDG/cm
 mfkUFI+HgqVcREpUnxGRttN6oX+nDCw7ul9V7ODIDR2LTtKNanwz9T/9ljm4i8feMKVG
 YdWq1gkpSBG7/U4zFSp78QFxIHiYcRfDQwitTPSQdfCCqC0HMncSol5nw+DDx0mfAD2/
 4/tA==
X-Gm-Message-State: AOJu0YyGbW370Fpdw0t/nzg9K/YE6LqqYVtN3zEhqSgiwn7TgYthMGsH
 bPT2yzqGUevq9TuiiletSCU=
X-Google-Smtp-Source: AGHT+IGYW3E+Hqo9DWUAj+5+D05yx9rf0m8S78G2cE6Hr7dzstlz2mRAOWj/4n7GiAvELrVZoW7+aA==
X-Received: by 2002:a5d:6250:0:b0:336:8f9f:c690 with SMTP id
 m16-20020a5d6250000000b003368f9fc690mr5137914wrv.16.1705486689533; 
 Wed, 17 Jan 2024 02:18:09 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm1305849wrw.60.2024.01.17.02.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:18:09 -0800 (PST)
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 1/4] board: verdin-am62: improve comment on usb phy core
 voltage
Date: Wed, 17 Jan 2024 11:16:46 +0100
Message-ID: <20240117101743.3955852-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117101743.3955852-1-max.oss.09@gmail.com>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

TI recommends to clear the bit independent of the used voltage.
So the comment which claims to do it due to the core voltage
at 0.85V is bogus.

See https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1252724/am625-usb-phy-core-voltage-selection-and-vdda_core_usb-mismatch

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 board/toradex/verdin-am62/verdin-am62.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index d09dda5bccc..4e912b5f32f 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -101,12 +101,13 @@ void spl_board_init(void)
 {
 	u32 val;
 
-	/* Set USB0 PHY core voltage to 0.85V */
+	/* Clear USB0_PHY_CTRL_CORE_VOLTAGE */
+	/* TI recommends to clear the bit independent of VDDA_CORE_USB */
 	val = readl(CTRLMMR_USB0_PHY_CTRL);
 	val &= ~(CORE_VOLTAGE);
 	writel(val, CTRLMMR_USB0_PHY_CTRL);
 
-	/* Set USB1 PHY core voltage to 0.85V */
+	/* Clear USB1_PHY_CTRL_CORE_VOLTAGE */
 	val = readl(CTRLMMR_USB1_PHY_CTRL);
 	val &= ~(CORE_VOLTAGE);
 	writel(val, CTRLMMR_USB1_PHY_CTRL);
-- 
2.42.0

