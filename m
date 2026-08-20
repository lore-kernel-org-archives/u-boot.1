Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1BBC5DF86
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 346CB4083D;
	Thu, 20 Aug 2026 18:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXae5ViN9R-c; Thu, 20 Aug 2026 18:09:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787249347;
	bh=xTj7KgMxTFfFEsbnyV+fDIofkCSq8yPkTg3fiSUQ/Ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHeXWc6JEkMBH5UXsHP+b9Bn+WQhhMTqKNFneYbZPr/eBia3sxbHYrO5sjKYaz+It
	 drAF421BXQipKiJOSQe+fCvK0kMmDn7S5Hk7EskocXAnUhpjmlGUshk0B1oM0YYmhu
	 gspOZoqiYo1aFs5PymHShSvSYRqKcUz88dBNDuuPheaU4piGqbZ4/SoqekIgvARxpJ
	 2JxngVfoKvEwxHNcFj2oIJ+f4Y0ZYkkopT2Spc6D2wrsqlQ4DL7h723vr6sn1acyFq
	 lIFhzPhJGPSFHwIZJ5TUtLoziDkoW8j/zaVc7j8+FCDSeb8itZ1DIS2BDfvU7rZwO8
	 CmY2k+y7SdBFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85E6240830;
	Thu, 20 Aug 2026 18:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B91FEA3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BAE84024D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Y0nvGi2v5GT for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:09:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RnhfGy3O
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D024401EF
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:09:00 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-480001972b8so73213f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787249338; x=1787854138;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xTj7KgMxTFfFEsbnyV+fDIofkCSq8yPkTg3fiSUQ/Ag=;
 b=RnhfGy3O7TTNenSBWO3PFK0LWytDCAOpfiJMoB5mhuzjvUtQx4kQOV/dUxkWqAJ1RN
 H5AFDl7/8kWAigQ9GzxBKuV7ovFWbF0Zo+XOQVOuqmAAc3qq+fViXeuDDjDwWTk/E8Qj
 bRHF9N5KG9hi+UD7e7nasuHF6H8xmzpOtodRpwCn+ZOT28brYkwuYRxHSt7YjNf8OXLc
 7+Sl2ey5OPpH495biaekTNS0LqtGj9SKdKPr8T74bF/19VuhxB3MA+QSrOtoeTVMyYoW
 Rd74P2JLAZTu3V6WddxKaOoP5FZRIZaBZT+qpvO8j0O904H2imBM2i2TmaUMcZ6tNZVT
 Y2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249338; x=1787854138;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTj7KgMxTFfFEsbnyV+fDIofkCSq8yPkTg3fiSUQ/Ag=;
 b=TkcqmTIjCxFgF461Qf2pol56Pjbw+PLYJIl/PPZAnBhJuQLQh9EKWNkSb2eaZHfbM4
 q9nTQ1RodeIDEwJwJpqvh40ssw5gd+7lKQCQGZCyYbgy+T013MVd2AGbUdKygmyNnvx3
 K9/sEtVqv8ocpzZ5sO2qx/JhVLlykuZkOWAQ3yaRfN+aivn/BmdMwC32QeCTTcJHDO4r
 59OY9GRzIP5IfgObWX4P6iEhaE/mpMWz54Ruq9GknBgdlQEVEAy2QecIipsgbt0lUA5x
 YzeHrQ97N5iX79nQYz1+kAwEIiCm6qqsD0iQ/Mz9ISgzVfsOsTGc6fuljsMw7UjY4pd/
 tOxw==
X-Gm-Message-State: AFuF++kBQ5hfX5hERA53WV/VxGKbNQK/R8PqIj6hv403pL9VehyJUSfG
 UE9Nu55CJG8mTkgHV98ijjv5r3nJ1vcfDSIcf0eiuaF3s1GEIiK5iMRuTvjlgrrCqFc=
X-Gm-Gg: AR+sD12XCiDHUXzQXaFWR5/zIAje2HwEO92miwz8Gz6PXcgwrU15XuFxvU1F4kurnAI
 4DLVgfukjKy/DjERaSpZJ292977aCvmG6OYR3ZTWGAyQny7YnmH0i4sHsDgSOIUlZH7n1X5EsRA
 aixzLjtv7oVO/x9sYech6hM29oIu6pZtzeHnIR1CyMvy8GAn6yAvxAczSHX8K2nMC4TWmmXYJWO
 BrThv22MxY/goU+qY6dhQf/CJiZVVj26Jz+Fd3WkKn/+8JO8NB+IW/KZD3VXCv07vbeRT3HSAuf
 dqvk0tfDsElfAL4tJWC+1JNMimKwUsGzIPVSkcgkjCmCTawQgQmnYhYenAO8g7BqB6FoUuv8i1Z
 h3XqKw8o/0S3ifULZSUwah5sxhVMbfl37FSTlwKS+VWqds4x1ZncbV50+urTrLLl/8zUGR03R5R
 pDAesVPBjE5/qJOmV4ZiSzO1AbHFOEWonM1gbYxjw4iy0xK2bwp1g2mMuHT2ixToRMwH0cpNIoK
 w1bCBjOMBfEVOa17eBboal8BreP9e84DrDequ3oTDn/61+z7nl9jMP+0kL2AXrL6GHbkBNZa4EU
 JUJXGQ==
X-Received: by 2002:a05:6000:60c:b0:482:abf6:e3ec with SMTP id
 ffacd0b85a97d-482c0ba607dmr1068786f8f.21.1787249338170; 
 Thu, 20 Aug 2026 11:08:58 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13443810f8f.27.2026.08.20.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:08:57 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 20 Aug 2026 20:08:26 +0200
Subject: [PATCH v4 2/5] fastboot: use the common handler for USB reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-ccaione-upstream-spl-fastboot-v4-2-57e5ef71c74d@baylibre.com>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
In-Reply-To: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

USB fastboot resets the device directly from its request-completion
callback, while the network transports route completed commands through
fastboot_handle_boot(). Keeping reset policy in the transport makes it
harder to support callers with a different reset interface.

Send the USB reboot completion through the common handler as
well. U-Boot proper retains the same do_reset() behavior, while
execution-phase-specific policy can be contained in the shared code.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..471c0e87042 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)

-- 
2.55.0

