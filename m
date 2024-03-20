Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0AC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C0887DF8;
	Wed, 20 Mar 2024 15:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AsI7Uahu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB708811E; Wed, 20 Mar 2024 15:57:26 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629DA880C5
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4140aadfe2eso29488975e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946643; x=1711551443; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kEz13nWXRuHlZEXkiuEN7qJaHiUYR80xCnoZj/IeT7g=;
 b=AsI7UahuB1Q8SFF73KTZFI7GPPu7FvEI10S7nMBcvJfYMfs+1R6q/hxCqKktFmjY6K
 qJg7af+cEGBuK0u4UDplf2Y4Hlgsv+XWIheVfgxsxE69hD0w0suSE7vlC79EGMQ2AjHO
 KVBlkiBRaGZW8hPouDAFwDGRLoXbbPJewCL+j92ClwV1M8nnrhh//PRbiRJMa30JV7c2
 uK1jM0SznU87O80Skx8fOd3+ihnoGDDDGQnCuXnVBkBRgSkwoMKK2Npq8pO8UZ/xEyao
 LLqdcH+S+P3lhwfrYS93QkPX8T6sW8pr900iCr9Jg1gatg1VDjA+PypstEvgKnI4MwOP
 Pzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946643; x=1711551443;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEz13nWXRuHlZEXkiuEN7qJaHiUYR80xCnoZj/IeT7g=;
 b=O6rD3/JWitjTvEAAe+U1zg863azTZKxMZzlkDrVqQ+77ozhkY+HTA5hf1OMNl6NDyq
 eDI/bxqVHwyna3NH9mnnz2mzDbyzVS891lpuBO4J8G9Q8qi1ZqFZa9Ym9HJqvB9Dmpa0
 h7YqggAzjlJrAcx68O8RNU0bfnW2gHmX02cVs/sZLe8s9P7OCtZ8OFZ5n5tJ8dFL4XUG
 O54AwvqovchXYmJVC62WFePBzIxdkMT8ZGVIQNWBXZfIkBVF3gS/pgs6HUmNKDM9aOkc
 3fW+8TzDLf/3/eSkN7A+DHyhnSClEqD7m83xE8jzp+CKWEHHsw0t5IpRi76UMN0Klshv
 3jWQ==
X-Gm-Message-State: AOJu0YyxTWp2DNcRjSX7ZFxut4tsGDVri9iCom8fYST4eutIirEu0c3L
 xN4co6GypiDUWhEMZhNdvuBtBhDWkunMDhgDXj6eP1+XAIzirboSCEPAcjmJxhU=
X-Google-Smtp-Source: AGHT+IEIl55vSOw6FLz9NcyCp+eR3gOg6H8egEZqMjsomGMH81BMSMb8rHjruFFZ1RyRzhxI/cF4mg==
X-Received: by 2002:a05:600c:1d09:b0:414:48f:a7ab with SMTP id
 l9-20020a05600c1d0900b00414048fa7abmr10467040wms.30.1710946642962; 
 Wed, 20 Mar 2024 07:57:22 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:15 +0000
Subject: [PATCH v4 12/14] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-12-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=P3zFJf/5CUKVArcFXgOYqOHgvkPJ6VcbL2V/992pzjo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP50+Vv7lsTmvvLXmRoRPiXlltX1/7vq/ApXMRw9PW
 as+95FNRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIub+MDI08O9lm89q5LOH9
 cuzPx8VG4rf6X1068PExv1mYJzfr4m6G32wTe7Yvftm9dXZZuv+W73vaNRVlt6eLvZguKKHvZ7h
 t7n8A
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

The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
This is incorrectly modelled in Linux where only the PCIe dependency is
expressed. Add a U-Boot specific dtsi snippet so that this supply will
get enabled when initialising USB.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
new file mode 100644
index 000000000000..8d55d5dd7632
--- /dev/null
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Needed for Linux to boot from USB, otherwise if PCIe driver is not in initramfs
+ * the VBUS supply will never get turned on.
+ * https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
+ */
+&pcie0_3p3v_dual {
+	regulator-always-on;
+};
+
+/* This GPIO must be turned on to enable the 5v VBUS
+ * supply on the USB port.
+ */
+&usb_2_dwc3 {
+	vbus-supply = <&pcie0_3p3v_dual>;
+};

-- 
2.44.0

