Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15EEC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3F982BF6;
	Tue, 10 Jun 2025 10:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="n8Yhn7Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DF080C83; Tue, 10 Jun 2025 10:02:39 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7478682A39
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso827413466b.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542557; x=1750147357;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dB8EvI1VQfWjNtOEojhFRPEK2rfBsEDxBaFV5d+bZew=;
 b=n8Yhn7BcbwqwDUULnLeQ57PkXGwb+5WsKe7yE42SYA3/7dsrEZpUKP1/3QYielfU6O
 340j+ZnewqautQPZqsbn9L9Lvbor4vRYGNP1LD7U8TA1EvIfeDdr5CPEHBIfopHFQQxo
 aIFq33qUP67GVdGqw4RR+sp52tAFSZ6nKnzqrA987F68eeXC4RhZO3A7AdXW48YMMiK9
 eCmi0GPYqt8oSSgxQ7CdI5osSoIIOi9O1Ns2ktr2kzn/IiE1D5aAEHaqebxKuA1U26x+
 VBxRTDxaLBJfZDIGSrx3c3OlcnDLSBbjw+DGzqunZRbkJktvT9PF0UcxbggDrjh5ZK0Y
 DZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542557; x=1750147357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dB8EvI1VQfWjNtOEojhFRPEK2rfBsEDxBaFV5d+bZew=;
 b=jOu8wDHGPPx+EkQzHiTDaCUvEX2dAuJ04+SP25dntKs9C5GK9hGpvwrgHCIqvRWMv4
 TjeO7ObCkiBQLxQfOi/5XWBlne91Hb2rDlJn7rTyrUsrVK1Rak9tsUUJNL+RMTs5R2DP
 CDpk8ngB7b43FmNCSAWE9ICfralJouysyf2/Pn02cooC4OzmcmfrO4XD978YCI5svUz5
 QFDWbBkq1WqstPPmZUJTtOnfLnbGaboIiQ5MKj1VBQndA08u/10uEPnU0dNgk5KZaJFp
 7rMMNeUw/+lR7zO10fpYqyhKl0KpIBjD4Xj2kN/8SIcjvTDWGst07/WVO6gfboVtomZp
 zohw==
X-Gm-Message-State: AOJu0Yy/qGn7y4s3QfeEZQ/6ZGD58LI9IhPkhnn+1D6+MFYC8iRB2NQw
 PpJzeGvBPPYqTKAt8VYZg4UIDLLfWOfmWnfV93qxgHrYADauhuv6HhEUBP4uncs4Nd4=
X-Gm-Gg: ASbGncvnh3kQKqrnn4TI2Bhr9WFVHL03ZIGTgOUF+4eujNY09IznBENVKXh7MztGKhX
 sQ2GB3LimDhYHJ8m8qAlli/fCI4JOBIUpJpuPBljnrwaDm1Dhb8NvhiOX27oyVhd836tZ2ZNsPn
 XLXFF5DEoHApBLJa17ACGoACpWQx7KxxMTKVULTS4z+gQ6Shm5D/QnWxuATj7c9hXy8EslAbvU0
 KnMkWqRIZJj7Gop114wfpWKUmaHEEpop/fBUnD09E812V6ouvcUiXxDglqwAJdkosd9v3AA7STA
 M3gEvNUoZeddhrE2/24T50k/m83T2nBn+/BFo1l5llTcl4mTPMsA6JOkZGI/o4l0DsDy/7ZfPoc
 =
X-Google-Smtp-Source: AGHT+IFX4vqO60d3PkqF5ksWp5h1N6j9VmkYWRFAzKmBveCam+ciNdfNIbvIF89OW68437OqVN06cA==
X-Received: by 2002:a17:906:c112:b0:add:f0a2:d5d8 with SMTP id
 a640c23a62f3a-ade1a916faemr1357190966b.11.1749542556824; 
 Tue, 10 Jun 2025 01:02:36 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:36 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Jun 2025 10:02:13 +0200
Subject: [PATCH v3 5/5] usb: onboard-hub: Add support for Cypress HX3
 family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-5-53f03dbc3017@thaumatec.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

The HX3 is a family of USB3.0 hub controllers that comes in
different variants: CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.
To support this hub, controlling of reset pin and two
power supplies is required.
The reset time is set to 10ms, based on the datasheet [1].
Power-on delay time is not required, so it is set to 0.
The compatible strings added to of_match table are
compliant with usb/cypress,hx3.yaml bindings.

[1] https://www.infineon.com/dgdl/Infineon-HX3_USB_3_0_Hub_Consumer_Industrial-DataSheet-v22_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ecb53f644b8
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 273b626dbaee..eb0694f1a44b 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -271,6 +271,12 @@ static const struct onboard_hub_data usb5744_data = {
 	.supply_names = { "vdd-supply" },
 };
 
+static const struct onboard_hub_data usbhx3_data = {
+	.reset_us = 10000,
+	.num_supplies = 2,
+	.supply_names = { "vdd-supply", "vdd2-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -281,7 +287,14 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
-	}
+	}, {
+		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
+		.data = (ulong)&usbhx3_data,
+	}, {
+		.compatible = "usb4b4,6506",	/* Cypress HX3 USB 2.0 */
+		.data = (ulong)&usbhx3_data,
+	},
+	{ /* sentinel */ }
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {

-- 
2.43.0

