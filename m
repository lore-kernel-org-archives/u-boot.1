Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD4CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C2C883B5;
	Wed,  3 Apr 2024 14:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="shKD9eEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3608C883B3; Wed,  3 Apr 2024 14:08:08 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D8F88391
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56dfb52d10cso1340034a12.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146078; x=1712750878; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=shKD9eEhdTscW7Igv0DkMp6XYQCJOohxYnjsowwP13Eci9T4/TEzbI+jNM1SBZNsZi
 WFKaQVFkrBwPGOaEl2Vcp09EHOOR2R6ROYy4HvbAjz9s8J47qDEVXQcuj1Nk4v+GVSAk
 O70V7LlZTxDFTwg0HTMn5Vs9fG3WzqAUj7LEq3VXbw3ciD/OjnBHcsXqsjbM6v8yKeiW
 WECiXzJH9ot4YUp56OEanWMnjypgkCscWpxyqrAyO67FzNyXXW44Et03hSfLYSa3uAw9
 fLh7YoQtfdipHKlHKC2YoABzOE/z+TgXn5isNFU2yzyyNRG2Us3IwcPRUxUM+LFUNjL0
 zd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146078; x=1712750878;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgGFkOv1r6ZqedijumR44euV2V/PWTObj0uui6365Yw=;
 b=Zhjoa2qH7tKzQPTIjH7Gm1fJQdt4LSuIBaI4cpFAE2+AKKbaNd9oxqiWCK2N2UfyCD
 2KMj9gKaZD118skGP1CG0RcQpSV6/7wiog2Fz9jndcKZol8UjaDNW2zPfGUfd3YjFAow
 hgUev1H4fpQsVqgYu9sn6WWDdOfzUBheyU4slSZHzA4Nm8zC5LjSqOj7qtvGkYkFrdOz
 zdl0DdRF13oi7Si4W3heSbMgtGPKsjayX7WOMEp+zbPWilFsHUrgEc4VJwf8W6saPvIw
 jKECTMt8cFo2q87UsnKhkQ946Tl2C7L63Q6HI/sTLRaNab3vnFHUfgweOJHc/9CyyWDv
 LCcA==
X-Gm-Message-State: AOJu0YzGlqNDYInC4SagvL5JK+RwXF5jSgIVrfXHAFtWmvvhgxbAUFDo
 W00qyEJjoIkGm9tbFqnWPffOb8sGDf1YoI+zCz4TVo9X6O7Aj0zTvRha+/aUkXg=
X-Google-Smtp-Source: AGHT+IEuPTqlvtjGHa/UUEpwXl2sr9dPmdeEfqC+C8abj9oqxheIZTJmdtzyT718mhdD85J1Tm5L0Q==
X-Received: by 2002:a17:906:f54:b0:a4d:b960:7b8d with SMTP id
 h20-20020a1709060f5400b00a4db9607b8dmr8946057ejj.18.1712146078552; 
 Wed, 03 Apr 2024 05:07:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:44 +0200
Subject: [PATCH v6 09/16] serial: msm-geni: support livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-9-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e9QvEtgQXqVS65y/B+mDQKCzyUPIH18kPws1KWRjbZI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRmWSur1rzD8CIDcVepOfCj+IadBnFRwqJU
 ZSG4RNzQVqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tpvSD/sG0z1sTuSAmuBleFC4+P/cgyaEcoGPMxViiMakB22iKyycA4n/al263SlA/VlA3lwQToo
 ucxnbdBObtIxA/ejqIGZGuMi60vaGQkIe1nT+/JE4t149V7KUWDCDmW8UeLa8GC9z1YU0u6KSEA
 AYGxaCLgMDkgNodqiwK8DNs/DT620DSWOIwnJtdCiO/WV8bfqPUcsWmpl2N8Fy/74O2blD+XVxR
 hNfVPe/ldsUc11UzVopvxeQHm+QEO5Ne+OfPu8dS+ERDTgngSkwTKkPvBR+4WUy9gOZALPPEfqz
 tFcBngvpEcpGFGI4bHdnz57PFBchz8SIfPa7K8ihhI1DZNA4wJbMH0o1jnUzKBpr/xdZn5jnkfs
 mhUKsfvVvmQh6IMAAd3papyRKbrGcSM/8TsbaU2sGKZyN1nAxHfBn9cLLn6dx/T6vfPjGbBE7WR
 kvqh6MODxLlMduj8JvCEFXk4BORjJeaVoiArCESgmUlK1VHmZcBJCV7en1KOoq8LXgYp/2CGpxx
 2B+EiYSCZdFtb7PX0twKaOR04lzrxKGMcup/lNSOGwxCygxqh3n3RvOH2S/t8f6mowusNYcKrGH
 iH1s8C+oW5Bjqr/4Iy0qTxvGmoYHYcP2cTTivsNpySxF2/sDnaBFHl4FWyrA15xtMIKbX6+yTuV
 AqJXcFaSsArRwaw==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

