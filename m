Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F93EC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239ED8808B;
	Wed, 20 Mar 2024 15:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoG2tk1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B8E880A6; Wed, 20 Mar 2024 15:31:36 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5872880B5
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ed7ef0ae8so2563881f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710945089; x=1711549889; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6Ao/BrHGxpD1C9cPv4fRTuqD3AMDzioaQtxFwiQPrk=;
 b=KoG2tk1SuIy9fOX9bgjYO7GLDAwa4slov/fCbaoNv49513WllbLLHy1y7+pzHF3Vau
 s2A/KbEPPdA/U9fhy5LNvPVeexlnDgVbbnGT7Dr6kT6Yvp5OMx7JxGKc5PWgv8iPFbeq
 BHOsZrod2Ub/SJUKufRR/FWsO7Pv6O27SqXPp5BohWCIUT4pjIRC1AP7mdRyditPIskg
 wVFgx2J2jMemX1QgXUy39z63Cwt4045LJ/53uh1kgob7wd6TCANZKAMtiE+w/2j8X2jb
 Ikk2WXhu7vPNgx+vCKqYg7ep/kyug9gsDA8/9lT1+XPAjkIV9U1Kt5IZA3ZxyXPlKdw+
 HStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945089; x=1711549889;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6Ao/BrHGxpD1C9cPv4fRTuqD3AMDzioaQtxFwiQPrk=;
 b=mVlxCPKs6yXJUdT+ton0lzV+HaLOwH+TTWIhGlB2WyQOfJPtBYDuPEogPZiYwO5Wax
 I0cD+gliGPwNqWuufEP+l8yfxwO61pOIgYl0DbGQEq+lsLzToe0mQsOo3Wn8qRbzIS7P
 iPWp/qGrUUVR8I4R7BK3ZPc+6fY/3Xm7pxM2yhQgrrpWmKsU6OQxtLo0zrfXlL25qaUU
 9Ihq17ezJXnX+RGZQleeHHdk6M1dd0VA5/uBNA2XdHmE54sFCf1LOYuMZYdRRUj9YrFg
 IpKBx8cJsCUvak5PHX8kSxEYYqjqodxtZeAFBUlGV3K4mw/DHxFaSvMXbjjvydgw9N5G
 cJKw==
X-Gm-Message-State: AOJu0YzsGtXnRshAb9XM01Xp8nrtv+rMIB1muoM0NjLc2rn7oJPhkUPh
 woxgTCLQaoIyWKUCaYGvdURkScmT4R3A7LSqcBQ1DwKCueicPS38bHbLYqyhmeAdqrRtD9Z5UFG
 q
X-Google-Smtp-Source: AGHT+IFna2Y+hc7OT7/B2VPBG0zz81WDY9VkFo5QY99n7iJypUP9UFPb9Iul58rfeZBc0ayr17ld2A==
X-Received: by 2002:a5d:5404:0:b0:33d:d7be:3bec with SMTP id
 g4-20020a5d5404000000b0033dd7be3becmr4131703wrv.58.1710945089298; 
 Wed, 20 Mar 2024 07:31:29 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033ed7181fd1sm12036571wrb.62.2024.03.20.07.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:31:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:30:49 +0000
Subject: [PATCH v4 3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-usb-v4-3-41be480172e1@linaro.org>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zOzCrBy5uJTh6xPbLEJbYeWWpo5eW586HYEeAes6w7A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfn21/HJ0jlfl5y2uL++uN///vKe2df6OzpX9m5PMH7
 O/XcVuzdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJrLvOyNDs+vjA1zv9nz+w
 vO0svTH3n5Zy7b0bMcyM670XXWj73BvD8N+hbteGbZPedr6/Ll3xy3OF7IoH5zlul4bu/ys5I/y
 bZVIbAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

To actually use the gadget the peripheral driver must be probed and we
must call g_dnl_clear_detach(). Otherwise acm_stdio_start() will always
fail to find a UDC on DT platforms.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index de42e0189e8d..ba216128ab27 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -622,14 +622,23 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
 }
 
 static int acm_stdio_start(struct stdio_dev *dev)
 {
+	struct udevice *udc;
 	int ret;
 
 	if (dev->priv) { /* function already exist */
 		return 0;
 	}
 
+	ret = udc_device_get_by_index(0, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	g_dnl_clear_detach();
+
 	ret = g_dnl_register("usb_serial_acm");
 	if (ret)
 		return ret;
 

-- 
2.44.0

