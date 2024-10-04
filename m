Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC08CFA773
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 748D288DA9;
	Fri,  4 Oct 2024 14:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qNt8ABRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3090988DA9; Fri,  4 Oct 2024 14:47:04 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EDD88CEB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cea34cb57so1376948f8f.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046022; x=1728650822; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j7yg/K63bTckbXZjnzgr8WwMPKXmfjLKJbA5QWoIgDI=;
 b=qNt8ABRJLuCSes6HasFu3EHK4wB5MnBGa9Lmw7J9SvmJzqO72HPoDJ9bcd+Kn9UG9Z
 XSTN4cc47RO2qs6hK31SjdXH5hyilANc06Hq2zWeicLtRRebWtTe2m7FxA1hnjVeaYEJ
 6AZ9+vd8wOpi/QVkdQ44lQuchLBL6eWqZcmZWPFx6rqPr0vjBxcgLQe7dZxmO8zzALOe
 QdSmWvcbENupYv/1ot5g5fVOrvrX28Hy5jwRhmqIWWGWyzfVUShxVGBFtn7HmAtrye2h
 3hw4L8+v79jUcZDPSxQBzEmfrXFit0RmRfkgArIoeHak1USh9Reydfio4ODK2uxQN/jG
 CwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046022; x=1728650822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7yg/K63bTckbXZjnzgr8WwMPKXmfjLKJbA5QWoIgDI=;
 b=f02BWnT518KK1J2/H1y65wkvlTKU+PFKi/I/qhUl+2nX+G7oM+HZn11qoTQ+fGDgyB
 6CiVlaMiE5TjHcWlWDHh7g5cJAr9MBV7gioTtvCisbfjrKRgU7m52kk8xfUvVz4RLOT7
 IYzfLxXdc8/x3buYl6UGQpGgsjJZn3g3MQow8RYtb8uh1pdw1VJcWbmATeYfmFMgUdYi
 uuCUdIZZFrNtsBt2WMqtY8WmELrYYnFrSK++7TyUNoIwO6dA/c2cM8+UXu4R2daCrcxp
 mltje4CDhCpD8NNn4e40yleL60JYnV/vN6FxrYj5JGSLBwuMfBSsOToJG924COxLCf4p
 KQeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1p+f3js7nQbH/45NtScIJ/qd1FQh1SGjsP7L3PzskMJst3/pVrk3b60hQGFQ1y6kV1tkcL0M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz91fz8aWT/n6Nqk1rIQlOSfXR/0np5Dj7DxeudUI+ZX3mkkdPs
 12RRNkJcmqHfjJLq44X3o2Rq+NOhe1CKP+Duhp3gjTPQyXxmGiHwfT4lmUE4+Xo=
X-Google-Smtp-Source: AGHT+IHb333W7mx08fg5/CU5gvM3e5CpC1uR2QqWhgm+TX7lwYR5usmZUP28fASyZ9bx1fr1qpuTxA==
X-Received: by 2002:a5d:5ccf:0:b0:374:c949:836d with SMTP id
 ffacd0b85a97d-37d0e7b9d9emr1650035f8f.37.1728046021653; 
 Fri, 04 Oct 2024 05:47:01 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d116asm3177348f8f.90.2024.10.04.05.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:47:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 04 Oct 2024 14:46:52 +0200
Subject: [PATCH v2 3/4] bootretry: check for bootretry variable changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-qcom-phones-v2-3-c7ab67ac3043@linaro.org>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nU03hvEw0ouppXvKET2WJ2tdYr2DZyukndQI6MSww20=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm/+O9coKoUybq/TVOhWwYdsUGCD5RR7BfUe/81
 GcP87CHqAeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZv/jvQAKCRAFgzErGV9k
 tiblD/4jtVlZPiOAK0H7+EXMzfK+Ouh+C8b8emYiPd2QeL59KPTrGCeJBMcv20ZfCllCzgK0qhC
 M1n/hMeq1iLyFfNMZJpeIKkYXYLLYzc4JBfZf7N+F5RfcYs4aoRnWg++Rdkv4R1tzDRwTH5YAex
 TxppuxYZ72SwLVJHth22s6i5BpIBUeXbAlciBCo65FSaqRREJJtQd0vRNuSINZ2G68w7ahp+dxQ
 oU+/VEcmmDwANuBYeMEptAqFMs0NqfeZiFGPX0f1qGY6UwABMKtDSauZb8L9njGBE91fWkg5XAR
 w27Z7gC8j/uEq2SfgLP1rkoWN8QURR5nFpiVCnPw2nfxIVeN9fm1Th5WVfBI8HAUWdF0x7JlzVP
 jJWemXu2S8vjIvKgYz/qv16vsiQOk/Zo7hMTKg9fv1lv/RMRd0/WXGXFzKF3+gTmyC+S5MoHA6r
 YTB0R0LgijNBMh0mse+FS/tDurgKu+w89aTEeFrw+LGy6c2XtNeJ5KEE7o8oyJsLgi2bPZUgLCN
 wMgvtjzkuPmWuLXmKhZ9xFUGiEUICeeES6XrTAYwUPyKzUn5gLpgWSPU1JtyGaVoVq4UmMiaOLR
 9Z+1THnMVdpJfo6DCPJQrZnGhkwXrx3ds/2btgbDCqgKafjrwgevDz6yfXV1qqG6dorbBggy9VP
 LN3bKpXUMAyIAXg==
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

To enable more complex sequencing of the bootmenu, autoboot, and
bootretry, handle changes to the bootretry variable between tries. This
makes it possible to turn bootretry off (e.g. to drop to a shell) and
then back on again.

This makes it possible to have a persistent bootmenu (the only way to
navigate U-Boot on devices like smartphones which lack a physical
keyboard) by having bootcmd be defined to launch the bootmenu. This
allows for menu options like enabling USB mass storage gadget to return
back to the boot menu once the gadget is shut down.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/bootretry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootretry.c b/boot/bootretry.c
index 587b2de7d6b0..a60767eaa2ee 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -36,8 +36,10 @@ void bootretry_init_cmd_timeout(void)
  * reset command line timeout to retry_time seconds
  */
 void bootretry_reset_cmd_timeout(void)
 {
+	/* Parse changes to bootretry */
+	bootretry_init_cmd_timeout();
 	endtime = endtick(retry_time);
 }
 
 int bootretry_tstc_timeout(void)

-- 
2.46.2

