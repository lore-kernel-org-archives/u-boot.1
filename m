Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70059CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E4B893DA;
	Fri, 20 Sep 2024 09:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YIJyvwym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84AF4893E4; Fri, 20 Sep 2024 09:25:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D1A893C4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so15603985e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817117; x=1727421917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jH8F43frAIKheMZkYQWkw5X3N1NQoQ9h0liNmv9e5OI=;
 b=YIJyvwym14oL9FrcATpxF26DEtQTawhB5ua9bTH3zgNF+ILt6J3w1wWKL2aNziAZYK
 NvFUxMJWtzdCm9dqcsFiqvCFN+rITYSilq30/Zu+EJlidg7Y8pldjmJoOQDTM8iZaxNL
 7mmmkASc6GlLM+IZ7kDAsPWkN19gjooKCuvus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817117; x=1727421917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH8F43frAIKheMZkYQWkw5X3N1NQoQ9h0liNmv9e5OI=;
 b=PH5JIacGdclu7n+jPrPlHnya442ybVW3Ezrm1ZokGaBTGaNx91BVNxjGHIG5y3r0++
 uKjfh8HqUY61jZGVXmUEmTDfdYmqwI8CpbTWxHBXxy0wrwjAvMuu3YSOJPWY93sO04zn
 Jzo2PjvOKZR2bfaUYhShH/M081rSZ6AL1u1GnH9sO2lzEUT3IvJKYjXNmjTGgcnuBmlL
 bAoUcbBsy5Qlla0xV0c7HWj6+0vlQghtN4ZFcpker+miGMmf23E11MRGuHZ/7+i1hQV1
 fsGvwYK+citC/7jqopyfgTFY2R+202P6AKN67XBMgeYXxfqt8P7mJCssJDU6N6AZL7c1
 kUxA==
X-Gm-Message-State: AOJu0Yx1t6HDXHd6fum6jusPIIucnz1EBONTMHRSD/3lBUM2XaRsIV0d
 29FkByms6XCOK8EJgowRCAyY7YfSJ4om6EJIUhzAeY2plKcVJlLsePZMoEnj/wfLDDotzVX63Th
 B+tHF
X-Google-Smtp-Source: AGHT+IEcPKM/rY8pIzDW3rOCd2LkOW9Xp5o5wRDXSGy1PU2hKDlYadZBIZvk6T6bfdIjWUNMvxEgHQ==
X-Received: by 2002:a05:600c:1d1a:b0:42c:b995:2100 with SMTP id
 5b1f17b1804b1-42e7c159bf3mr9706725e9.6.1726817117510; 
 Fri, 20 Sep 2024 00:25:17 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 14/18] mmc: Log the error when init fails
Date: Fri, 20 Sep 2024 09:24:38 +0200
Message-ID: <20240920072444.134997-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Add an error-return log to the call in mmc_init_device()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mmc/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7e702c3ae85..e8870e30689 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3188,7 +3188,7 @@ int mmc_init_device(int num)
 	if (uclass_get_device_by_seq(UCLASS_MMC, num, &dev)) {
 		ret = uclass_get_device(UCLASS_MMC, num, &dev);
 		if (ret)
-			return ret;
+			return log_msg_ret("ini", ret);
 	}
 
 	m = mmc_get_mmc_dev(dev);
-- 
2.43.0

