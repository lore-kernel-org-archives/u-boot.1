Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD6DC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C671812BD;
	Mon, 24 Aug 2026 16:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJhhmWDICkk8; Mon, 24 Aug 2026 16:47:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589964;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXzKhLBE1DIRHc3xSdP5+wMFtBuKbMv+Dxg6pWTkFeTzt87ByoLTabSxjdhJu/sGh
	 +BIZiKFzORL3SU1eS1KSIV1lF38FCEEw2NuSn6h2IpcpOnf40juKWpjzcKTFp6BbUl
	 yVI1mBTH1KYitIFnSC+lydFT8YCUJvHynhoVt3+62DPSRG+7YjB0hUuVvU4qnwYoK/
	 VVw++yqnMp2oGi0RoG8jbFf8iZTVGGqn9ENoXtsPCzai/STAHFGqvaJrolBGRyModM
	 +Rvr1qs7qrmImbyecO59vsGEyKXTrITvpHDm3Dc/7vWNhR1RG+bBlhbXF7M0X72oju
	 UpFX22W5O6gPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B777E80FA2;
	Mon, 24 Aug 2026 16:46:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 117A72FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FD4140068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7COiJWPf6Myt for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=f7wFfEqW
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDDFF40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:58 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15f025146dso49481466b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586236; x=1788191036;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=f7wFfEqW7Z3NuqnswHDgVNrWNBF/5iUINA/w2nq6CL0uTUqYl5rkbP2HyssKF0fmxq
 O2Cv5IgwCCLMSwJHIMcimIE4cO4ZWI0Kwmgos2pkSXpP/SvXE47rXnqWCulQZXuhLP+m
 /9LwtwcEJBxR7w4T87iez7Deo/B5cI8V2ZXBXbLSxhZ6xwLcB7bkzGzLZVc0IX7eOHB6
 0N0iwf9Z/rEHbMB6WEhfCanO1lTvtbkHfvJ9OSdoajbq3RykM23w/VxG0c2ds/wJBeAP
 JTbJSJJ2NC8BnKVx0fq09dTKr1CP20T5ATS7I3pKBWsokve+ATxVW/fSbQYI8ZxeWYrI
 5CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586236; x=1788191036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=A5kDjQSD+Pgju1cBOPGo/LHzZhUalWS/s9e/X8tM7MZR2FHYZAuHYD6W6ndrWL3Nba
 hcHdIvPY4u2dSKhNgvm9UEkMAqp+kyDmWMLXXlzbp+clupr9gdHofyDiPzCdW/jQv/rq
 QsJcAdCbg4HEe71H/2GlVBnNAog1oqHhjYVQQEq53L4AxK0PhVp8qOFNDSTFhnNf3JQw
 xSmfireaMv4IpISFWUffHcngtliLLKTJbx0HwGVxrX1vlaq2F/y1NF7WVURfg4z4sX31
 m4wDkIuc1aokq2WFGNjOsv5C6tvoN6AIYAbhbZpsKoWrbE97ZVOXHrr7mxb8ZXzZhU6F
 HpLA==
X-Gm-Message-State: AFuF++lpxk9efPWFE0RKJLEUmqpJCMEf0QzTEaVn7Xasxk95vVCIhBu7
 v4zT7xw4CnhzQiTuxvvlWus/0bezicEtLM4Bjo1umRiBCdmI42jMv2fANrbSbeoqjegj9iUaGoq
 V549x
X-Gm-Gg: AR+sD10sks5e0hNkLKSKYkYLvamXrI9irj639JXCnC+IWJdsCf8M3aXCwe3qR5oORo7
 JBEgISlZ9wNKFp+3UV3RN6uHVYwqdjOiuTpxTdnhF0FTO9Moz1dZ5YJLSQZBm4eV20d/HFn4oU5
 3WkcvXkQRPWVgNhUBFf5uEubA+KhqTcnar2QPx6eFMIYIyPjDbyytzLWgAnArj1TN1nSYCKtWiL
 RE75GZElAJwvtiAODrgfPNuop9nRJA8Wr+BotaM9ZIyPKhSBOvHAR2FkyscCGhKuMpiuf+Sfv8u
 YNBHOLk1PZlNYsI22ZxQwwntnYZbr2Ln91gEstpmoMZX1u9IbGdEA53M+O5bCMWQUPoKqDtCVKL
 7dUYwjensn659W5G2otQrLJq+ddBMH8E4kD0Nx191Ww4xZj3FMgQ+QqL10liS6reD8qMuzajNeB
 4+gEBKyAPfsfzR5a8TCfNuxNvICHYQ+yGOS2jdbQ3f3J+BY/cnszzeGetbGm9ag1VUf27qcT2sX
 YvMq/1nQumNL6lky5srYj4=
X-Received: by 2002:a17:907:84e:b0:c20:7897:bc67 with SMTP id
 a640c23a62f3a-c246a6a8e0bmr1717109466b.3.1787586236470; 
 Mon, 24 Aug 2026 08:43:56 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1268749166b.62.2026.08.24.08.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:55 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 24/24] usb: cdns3: fix up after the resync
Date: Mon, 24 Aug 2026 17:41:33 +0200
Message-ID: <20260824154133.217744-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

Adapt the cdns3 gadget code to the new gadget API.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index acff79ae1ca1..40282cbc3234 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -341,10 +341,10 @@ static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
 			return -EINVAL;
 
 		switch (tmode >> 8) {
-		case TEST_J:
-		case TEST_K:
-		case TEST_SE0_NAK:
-		case TEST_PACKET:
+		case USB_TEST_J:
+		case USB_TEST_K:
+		case USB_TEST_SE0_NAK:
+		case USB_TEST_PACKET:
 			cdns3_ep0_complete_setup(priv_dev, 0, 1);
 			/**
 			 *  Little delay to give the controller some time
-- 
2.53.0

