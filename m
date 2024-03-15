Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3013DC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0148187FC6;
	Fri, 15 Mar 2024 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CWfHoTrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E22B87FC6; Fri, 15 Mar 2024 16:10:44 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C145A87FF7
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e99b639e0so1300532f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515438; x=1711120238; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nutu774W+e/po+yxFNGoCWmqr2yjHvTybNe5vdX7QhQ=;
 b=CWfHoTrwpmAU9XWsjMw1mZmHeJdTyfIiu+hYOvhhg4oBHvLS2/9lSKZe5Jup3CrepK
 P8oQn7L5zPhBrrSWo+vW7UyXHV9O2s8VyAuaG/QHMlVE6nGIO683y4scJPoZGV0WOzsK
 PAVlJVqweEKYKGtNLPE+IdgRqD0BobiCOpnqQu9hGBAJALVRlTPw5ewr4C6bZrjk0CZE
 lORvmjAI6keoGLKuyDyHIXIZEM92GrRb1a8dSYE7ap1DdqewjXdv1dC8zhvL4uzIB1SH
 Mi/Z5yx1uj+BKj89+9I2jtdkzLSJRU1SmlzoN6UWFU+RJ3Mvztk1iyW770IeXV1cNuLZ
 5k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515438; x=1711120238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nutu774W+e/po+yxFNGoCWmqr2yjHvTybNe5vdX7QhQ=;
 b=tqj1XTNxLmo5tTg2ATlTzA6tusodLMrTHghJPmEEkIqHihwrBxQFOdjP6Hq04bbTnX
 A2qYrAq2n6EhqtOhB97XsEnRMKDQqjjqncxI+PGfL6yvnc97seMOj8t2ZgmWjqJVChpf
 dR2Fuv4UxJ/1iDnI+wb3LrGGhv/H++DnUpLt2VtvOuXiSVZqS46YeEsP/dyJdh9JkGUo
 LqIcvsWgupp3NF26Bn3uYwYaK3iazkKGO19KkGc6aKci+s47m2399xZYgoltczumnOHW
 JyL3oJNKW16NUIwWMdwecmE4i/t6f/G9WF0dVtFLgXlcBHSeC70x884QYHG1+nqfgvrQ
 sZ8A==
X-Gm-Message-State: AOJu0YyND1QR28tJD1yCWox0MkhiFCfjaKV43kq3kNQTftTGdKpa3e8B
 WnWBHsNuXpx0bpAHtN36BxUyHypQ5VnqO61zluuJK035qXb0u4BlTMWWNLKTQxgB8WubugHJlab
 d
X-Google-Smtp-Source: AGHT+IFfoT81pyFs5HrUa7SwWpo/3NdlaPjNjP7Nf4q0e713lqEjwLz4TFsqQGvYTIya3z6lh6lFew==
X-Received: by 2002:a5d:6582:0:b0:33e:7c9a:9368 with SMTP id
 q2-20020a5d6582000000b0033e7c9a9368mr3349020wru.63.1710515438102; 
 Fri, 15 Mar 2024 08:10:38 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:18 +0000
Subject: [PATCH v2 09/14] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-9-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=B+jPfevSWWFNhepB84HKKi/onYAxuvjKNgJOEGpnD6U=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY9DbObHh5gYcszr3TH11VW1a4YOXNcmfZuZ2ppWH
 llmLRzcUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSEcTIsEgp8CpXeh7b2xjN
 ExX355i1OQVrrOBxeKSX/9gjWNbaluGvFNtfVY4dv+/HLXXifhbimNx7s1/Rv9yx+s+CnxNzZta
 IAgA=
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

When using OF_LIVE, the debug UART driver won't be probed if it's a
subnode of the geni-se-qup controller. Add a NOP driver for the
controller to correctly discover its child nodes.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 4aa0bc8c72bc..5260474fb9a4 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -605,8 +605,21 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.ops = &msm_serial_ops,
 	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
+static const struct udevice_id geniqup_ids[] = {
+	{ .compatible = "qcom,geni-se-qup" },
+	{ }
+};
+
+U_BOOT_DRIVER(geni_se_qup) = {
+	.name = "geni-se-qup",
+	.id = UCLASS_NOP,
+	.of_match = geniqup_ids,
+	.bind = dm_scan_fdt_dev,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE)

-- 
2.44.0

