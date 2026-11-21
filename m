Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D3606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FylcDsFh;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xMYqXdQ3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41AF460741;
	Sat, 21 Nov 2026 13:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjdUY4mt_JLE; Sat, 21 Nov 2026 13:15:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6040660E9A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266908;
	b=cdQpeQ+awLaFKC6ax5xCvmLgpZvF6lJuCVbtbQdjGfISRFKFNfdCRz5pIIVC41SQLmL0
	 gj+35op3XkVJa5kDf+vWJpD5ZrQXzUqLrzIXhWfg6O9jW7/NSCZBPLCdCj01NY8BjTWaI
	 nedi/pS0mQ0BJ2ITzNyZ2T0hAIiqzxr2+FaUYnys2D6fWsSIMSjUfwaaRwCYJyKn4e+21
	 f7paui33VPnUnLPpVINkqUt0wzEpPCXrgAZtWwh+4RxXyKwJMqmozGV1soHqjaPcUw55u
	 2POoIMg8a7Jm5I/RTcegaLEttmg8j2y5J5nHj2roUzk8xWS5LcfhmWulhAH5BTZnIQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	b=MbbWdaMfV14hGW1mVSq3biDd3jOimDZE/CjSBoReaDA1azunpx8NTUlZ3lEEASekM4/X
	 DZu93CIErXiQMpFu5SEFd1808NInEbWuS975/56W3VQCp+vs3a6lJPrmtqypaMbfTGbzM
	 MjFH5NhY1L452Kb3XgMPVg8mloBV+qDTUQehCtCNvK/NTN7YEog8Jml3ZWSRkensDIXMJ
	 Cwep3GkaD6YoJqb2qHv9fk7xDLPDJomnI4riVhFLEtcn6FKknwA+Qj7bDBwfC8mPBP/Li
	 WBZ1fX/xgPW14dlrwelv2+61pOXI8Nb9nrQMBxSGOcnAcyqDy0xaCU69VLSGXNiI9tg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266908;
	bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FylcDsFhgvfAxfJfgA8aHKLYCDG3pNzk8C4Wh7R72cfkZbA3hNuIc9Ar6rE5UMDcJ
	 ltmrsMbozVWEuUng0Gl0LglewaZ8Ieb22OGTFj3sON+FSM7339i+iwAt6al2S9+7fW
	 A+szCJZkvPHLn4KWxlIw97jBV3+nLcxuifanua96ymmf7j8NCDQ37Uo/+Id+VCGRa+
	 PSvoPUHnihnaZkGqyFlCsDpILELNit7Vy3TSz1xfcGP0LdHBTK8EVSV7Bv4CQp+c0v
	 NJRI0leIVJTIYS2crt5JVIFnHIe49QRsa8lgdunRAjdL3pZ+sXLlu0Fd3fETGBJOk4
	 9wN53MvJXcDAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6040660E9A;
	Sat, 21 Nov 2026 13:15:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D73F1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F58381403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMlkr2HOlU_c for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9051981404
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xMYqXdQ3
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9051981404
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:56:18 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c408e21e8acso40219466b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262176; x=1795866976;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=xMYqXdQ3Ipx6qFiv/iMhRemRK8a7A+HFjgOkN5HnpkewPJnJQZbM26ERtgBSCxym8g
 kvt9MYE60O7ceur9u/r9KZd/sLsDq4otcpwym0KwrzO6L5lST3gc6amnpL6DgybPJVMu
 SYZ08l8VlT6l3nPmbtROuGQR0naEvRY6ahcgiRxxJjJm/hzna+tqgumS+MOzIGWWNQLP
 GJXbgpNsRdh2sXxDDHqyyWPs96wa6WkMuQ29GQ7JG+2pVjq2gdwEoDi7KUaBCa7uGs4d
 Hp7tXSwFaDvfGg70qUYtLLrC1SdXRxL8XxJdCrChbIh9A1xak+3R1CM/BeTH3q1amgOy
 suEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262176; x=1795866976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/XWSC8MTlEiQv9sydP6YP1Yc3LJ+Cph2PrN0/OFhESA=;
 b=kG7nI45K1oFLaeDhYz39ePsZUQbzmC9exA97Y8IILO7lk277Cyv3Yztv1c2zQihf/i
 LOskdGnXNkCwNuuthncwvY50RVB4m6dz3Jnvp/9/P7DKZlvSHf6ujpqhM49LQHGpxrER
 YuWPMZ3WpeMGRiRUTYzSn/OlesucVNhoJ2oRIoBGLyG/3La9uTBr9MswJDRDrkZ7Viww
 Y802bhdc1LUbNNya7Os5DXeCUaI6WmQKQ4V5Ymh36k5krkv/GAG0gT6oP0Y36F2i5Z6G
 kEbDzm2SpYOIZOTD2pN8yIItbOIWRUowqOT6vpxl/eYQ77mlK8IcLrR8hUoXV3WZh00Q
 ibsw==
X-Gm-Message-State: APuU4Z/ImJJqhlyJHKP6ZBZIrdVU5iJ4r9KAc6Aq9s6JOIsh5ehconSc
 jhCvYmMe2ohWqlR5zdL/wH2UHvAyVrEHu6cYChjMW7rKX+x3QVt3jFaMdBe6mFiu4WXHmx7NyUG
 S4Vu9
X-Gm-Gg: AZFdTZfuH2SdDhiWrn0nDTE+RDx/LKUlksj7x6XEnZE7T4H+GKX45Iv4278/a1q4bGI
 QxnCsnpATUsa5qgZRbdL1jG9EUWZfRKgAWCm9SGZ8jxD7FSQku+oL1LJHiRjrgV2GDck4HTQ2Jx
 ONR3580tU2rLfWkc28jVrV9VwPoTKY9xbM8Jxr074aqb0OvfB4ANxu+LzSkw62wQIgicvGmIAc6
 8aU5pMrY6ztHzOOdk1T6mQwULm7aU4d3RLXfDTuRW900zXcA/aTTBNmMnhMCsvhr7bGpX1iFdZW
 wVK6QHsp1bbdjQIvr0+VBRKcpQnOzPRqgGK/4PeVObsi/mNVQCEWNwdSA83miA178yaOPt1Mwtf
 ha+qCOabDhSrDw8rxxpDylePJzKOwAuooHzbwKK5ht3vufJXaGf6aaxSX0RXb9w2aQxR5Be5NZk
 TnvnYmqeSEtP3vhar/M9nCCbhsugFgYwfo8GgijkMD5yApUmellakrowSe3tEBSyp+ViI49qelf
 ZBMDrVXlx617HJjbIF64PKDjx2lUUiGCKQd610WP6AtadOIDufBh307xJ1zXIG4NRJdPRidHiRj
 t4KEMuzuB/HYngC6Xk7NA0meFWtRHRoALKzZAPmGs6IuNOHM51CHImKquRecgOIgIS2eHRkc+uY
 j0oQle0k8Gg==
X-Received: by 2002:a17:906:6042:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c513a5f04b2mr528193666b.3.1795262176317; 
 Sat, 21 Nov 2026 03:56:16 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae88143sm184577966b.32.2026.11.21.03.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:56:16 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v12 30/31] usb: cdns3: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:34 +0100
Message-ID: <20261121115335.548142-31-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

