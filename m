Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E85AC3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0374587805;
	Mon, 25 Dec 2023 16:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MkeUzDsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E556587805; Mon, 25 Dec 2023 16:42:05 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31288744F
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e49a0b5caso4171368e87.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518922; x=1704123722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnYpx4HXF0svwPxtFe6zqQqGLbu3MtOtMdMlY/7OJ0c=;
 b=MkeUzDsdOezZbPjP1Ofn/4+ZyQea9tlCpBmMSXToGh9ddE0PFtyB/NQUuViteEqO8D
 jbHlPFhQz3g3cmGs1Wl1II9lhXRhpze7vyAKFERHnzG+WeRKHeKHuEfnyLzHLbhftkcH
 Jap34OWDmmd5NvLjw2ZB6j8i/a+/dW/H17KtsaqMGrkwhnVVrat08pmP5nXAeclNhDAu
 VxLmEuqj0Ta5VW3frEgs3ymon+F08JfPAAYByYFzVoCwFl/wVswDGhebU3KyGgbf8X+S
 EoyDJGI1UTZlex069K7Fg5LjrowRWtgHbnnDd96Q8BMVgYciURk4uAgKgBkNDjB+07I/
 IyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518922; x=1704123722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnYpx4HXF0svwPxtFe6zqQqGLbu3MtOtMdMlY/7OJ0c=;
 b=VkCDm3N4HPngc5VLc98kvnuYxcdwGKJv+Qi9jwL50UrTJKzAONPj2ZcJ5opmj0fH+7
 TKI/GG+h9VYzzwNNICnwdvPJQB/K4bgECHQzPSTj1ypVlRJ65FAvO0WwvoJBBYf/AxnC
 7zQhKGVTU77SbQxG1MnRhdPKv4wEFS9/b+LdbACcpp9cpg1MB5n5ZPTl3/W2yAQ3usN5
 utN7ToPKfTXvIbbolmxTD6Am1QaYC3wINdEhQmH6La9AQGNIzgDZZ2C7QfVlVulSkHOg
 e8bAlA6dceYSGQ0+oG2ICW5Xlkj6yU7oJs5PwcUKpQNP8Ei8EK1jbmyoY+e/ML2fO7jC
 YA2Q==
X-Gm-Message-State: AOJu0YxM6IrudCB4mLF+nIk74HatlGwA2cR/qaNnlnULmwdo5tDaodoD
 DbANdW12XDPcg6q1U8FrEzwGgsl/eIQbUzZPIT+FeGIYEAw=
X-Google-Smtp-Source: AGHT+IGLLkiUKDIemghOJcDtMDwspr60d/IMByHcu2cMZ2qQc/4t5hDSpXc/mNA1Wn1iuoLnLvLRjw==
X-Received: by 2002:a05:651c:2059:b0:2cc:80ec:5dc5 with SMTP id
 t25-20020a05651c205900b002cc80ec5dc5mr2008424ljo.31.1703518922555; 
 Mon, 25 Dec 2023 07:42:02 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:42:02 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 5/9] driver/net/rtl8139: remove debug print
Date: Mon, 25 Dec 2023 21:39:25 +0600
Message-Id: <20231225153929.8284-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

debug print delays reset of the driver. Finally I see
bunch of "rx error FFFF" errors in the screen. CI can
not handle many prints. While network works fine there

Reproduced with:
make CROSS_COMPILE=sh2-linux- r2dplus_defconfig all
qemu-system-sh4 -M r2d -nographic -serial null \
-serial mon:stdio -net user,tftp=`pwd` \
-net nic,model=rtl8139 -kernel ./u-boot.bin

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 106bc1c7ae..d8f24ec81a 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -453,7 +453,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
 			  RTL_STS_RXBADALIGN)) ||
 	    (rx_size < ETH_ZLEN) ||
 	    (rx_size > ETH_FRAME_LEN + 4)) {
-		printf("rx error %hX\n", rx_status);
+		debug("rx error %hX\n", rx_status);
 		/* this clears all interrupts still pending */
 		rtl8139_reset(priv);
 		return 0;
-- 
2.30.2

