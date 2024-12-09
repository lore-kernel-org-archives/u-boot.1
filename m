Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF32E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AA4897A5;
	Mon,  9 Dec 2024 20:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LFf7wVko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4188A897A5; Mon,  9 Dec 2024 20:55:40 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105F489792
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8418ecda199so171451039f.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774136; x=1734378936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/p5IHt0E0Wr1Y4d5wifhdhAIg/qHzjEPSxguph1mEk=;
 b=LFf7wVkodJ856WRI/sT/bARjjjJmbdmADQm7NRV0aEiUxfveqK9Cr5gxrH5J+F7lCp
 5X6AIOh7IO5EI5VG1s73Sy/to33f7NkcyDjJvsO2YP7dnxvIGbI+VBsbU7ikzLeIf19g
 5OOVa5u5q2X4XvI7aaLH4T2Ood6rqO8U5aEms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774136; x=1734378936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K/p5IHt0E0Wr1Y4d5wifhdhAIg/qHzjEPSxguph1mEk=;
 b=Mz/iahWYNFConWzgruvPiKbdhNz0svlFySoy+4iofGMUmzPYNoJDd2Eb/BhVQbOW4x
 usJf0vXkWS7OhklLdLPDOYamuo7nmGxZSlE8p5ln9ybuDPYiIJrQ6Tig4tTxwfnARRCf
 FL9scl2F0G8XTTUH07ROluA4bmmu9C+AxzVoHernuobo2dIDXhgTXOF63V+2vn849tEK
 VZucoX9bYtAhsGHn3rm+ZXROm614uxG6ozaR0uiIqqfftVRNifWsCi4Lcb+HQ8AM9Y2e
 HsOuS7btdMrVzZQ5pnOBlrB1Isf1SAfZdORgy3vrcCmEvEpsKZyUyb9YUxKybxTBbO3c
 PkLA==
X-Gm-Message-State: AOJu0Yy1UzFac1CvSlwWNZvS+Ilih3qlpL4Bqofg55xKYoNiqA9BDyd1
 jT1IL27zPMAScE+d2cEA1E2LvjVWNRLLOTgYb+nmImk3o0ct0TgEGydmffutjqjASqGD8muWeFU
 =
X-Gm-Gg: ASbGncuiSOKl4cJmWjbxQvSVishbhtLM6OyW7eDKMjsxwgsk/hwwR+JQo5xq6+a0ngt
 zOTsuezny0tc/TN1IFP0toMirKnGmB2ZFeaHWN7xY2a0wDk4hrFqgAdCGKdeH9/F4R+ubLBIitp
 VK+EJ2Sin1PGB5O62xDOMBUUqy6W8mGb4QcVgpiKZ81jw6slUE8o0oavhYCIejBv7jDSxu2AtcB
 RFngfS2TJ6uJEIfic6mlPgT67VCPHtv7QK17OVLEiTwbM3dVo8SuYr47cejq6ddNI94/Qja8FRa
 3l4X6seQGyuDx7E=
X-Google-Smtp-Source: AGHT+IH3lCxQfe2H9CqC3JkGr07MEpx2M/wjh61kv9tJwM+NAuIzFGj71qSzIY6lV5nsmCtP4A9Tgw==
X-Received: by 2002:a92:cd8f:0:b0:3a7:c5a6:9822 with SMTP id
 e9e14a558f8ab-3a811e589b9mr145547445ab.24.1733774135901; 
 Mon, 09 Dec 2024 11:55:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
Date: Mon,  9 Dec 2024 12:55:24 -0700
Message-Id: <20241209195528.730260-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209195528.730260-1-sjg@chromium.org>
References: <20241209195528.730260-1-sjg@chromium.org>
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

Set this option so that all boot images stay within the bottom 512MB of
memory. This should allow us to drop the fdt_high and initrd_high
options.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Add to the existing comment block

Changes in v2:
- Add new patch to set bootm_size

 board/raspberrypi/rpi/rpi.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..a327fccc77f 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
  * Even with the smallest possible CPU-GPU memory split of the CPU getting
  * only 64M, the remaining 25M starting at 0x02700000 should allow quite
  * large initrds before they start colliding with U-Boot.
+ *
+ * Limit bootm_size to 512MB so that all boot images stay within the bottom
+ * 512MB of memory
  */
+bootm_size=0x20000000
+
 #ifdef CONFIG_ARM64
 fdt_high=ffffffffffffffff
 initrd_high=ffffffffffffffff
-- 
2.34.1

