Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7F9D0D795
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACFD8931F;
	Fri, 11 Oct 2024 16:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AtC3U8+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF48892F8; Fri, 11 Oct 2024 16:38:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC97689333
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so19190835e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657511; x=1729262311; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EGzVAs/C70qEnt8Ib5tkWIzYZG5avjdcSr0nGfnNmqE=;
 b=AtC3U8+D2kqe89bK0mb5BClsiE6wpdO+YveyIYwe6+7FKp9Kc2HQcZ9EsbFHM1UoiP
 v2Rd5VI09hlhV6VtenfrWIDla4w/mxjlgxHQZzJSyMKX8bh8mQoXLXCHZOepkKvZ4MNZ
 bd1cOXkX+lKQR82j05QHyabIPvmu6Izu+c5elEZW5olx5tVZ0IiEm22yevDxqVlrcuYh
 QjkHvPzfUKl/5xVReKClt8KpnB1+uu7wNz00zM6uUmu1ufizcL0XEZK147HFexjnjvD5
 hvnQ4i99UYAeY9mvAiEHPforu9OoLyT1dNLU0Xboia7x+r5y9RO/lXyUS7QgvAeBKT/Q
 veIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657511; x=1729262311;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGzVAs/C70qEnt8Ib5tkWIzYZG5avjdcSr0nGfnNmqE=;
 b=IHrPvc4Gjy5Dzcj6E5Jm423WR4Jv7dmTRZR+5/4Sjfh6lqtJkQxemHOfR8/9EI/IrC
 hmHpK4Vidn/mxg5bEPXg9tBUN7hYqvqxgLKumnyM1Kh84zTm7PRHJYpPvw2mxD6UTiSF
 VC7Q3B9ePiSUjjSkLnwhFIsOQGkSFP5pnRREDf5KhhVzUxYs93VvS2Ptg9wgmIoSVfmn
 1PD0Kdrm6c1HuxifOGnQXbn9tk5QE29BWWO7N5+ziXjRH7XNy9dAmLs8o8E8Y8yjX0bY
 xxstspBuVOGbn8rcvP4gaT6pett7dTY62zaQdubXuAqSlGdFduiq1GqzSJhZ+KuV5Oza
 B2uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Xfms4joZYtKlLW+f7f3CE3gdlp+Zb8OFgid0rgsrAHuNEUFW1GclWbnCxfmqAv7vgGVMvnI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxej+vrlLVHj7gL1wa9ZXYJSb7ZpV2qiJe/N1nRSR/aOKZbdOHx
 RHQNwqFqvzS2aocLpq5e7HGzHUKsCycqUOKFYw2CkBmOg606nII4RjaCSuDMcpY=
X-Google-Smtp-Source: AGHT+IH9lox+fdoSEtNhYYmHW6YhYYqobTzYRXsABQNB0vrTTe+PJB/BcL4Msc7ORMJ6UuR4xfCDmg==
X-Received: by 2002:a05:600c:4f07:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-4311df55cffmr22536985e9.33.1728657511041; 
 Fri, 11 Oct 2024 07:38:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm75991815e9.24.2024.10.11.07.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:38:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 11 Oct 2024 16:38:26 +0200
Subject: [PATCH v4 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iI21rtikGKorJ7BWBMqn9I5JapH4U68HHGHBK/ZyTJY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnCThiYXV6wjBn5vHmvr0yi/EcIFu074jkYEOmQbZz
 hPXNoVeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwk4YgAKCRB33NvayMhJ0YjkD/
 wPquam+MhFn4MGAnVBBvgVkqKwL5gZTXwozCrxscWQH1V4enhmJwS2ueC0UaeX7eCiD7YccHb1j4ha
 Sl2ujss1X3Iq0uqi14DdKdHboJbCfk3rHs5hzw2bbiWMAC/SkeEV2QbYxch32I1QOdgOWwu5mx9xvb
 yVu+9Ygzgr/uj+YjEKDhf0cJWX9DPQ6qZY301XSMnlw6/dLZjVglrm732DGVUkeSveuw/uDjhvLwYr
 2M32uV4miVlOER7Azcj7VuaBcY0RmMsGq2hEzGiSTIDvJXmbGVVDWBsNsPUI1usSITfPT30asmHSry
 rLAWyFlmGmKpoBFKU+OPjL9XD6Y95kbAJhqhzhiueBy6EzuoVzjKWVviYkvQkszpxJvDgfRIG9/rl1
 Q5YmfXnqdMOskZFIp9ksJ/20dvbLoFcvjX+wDkodNcjeWGJCHtd0Ggj/lltqsDzWrPFk3dGczORGjU
 55oFaKYfush3w/1Y4Kmi6i8m5EyFE7HbYj/QChzwt5R4iJ70W9tdDgWvZ205gJ/kUSQ2rJ0KYm14y2
 xJOhQe9aRlx+QG+dfLzSYsg8NDd1LkRR5lS/H/UsZDC/yNNOmhwCPQ9w2F5l+LSE6B7jQzRGaDI0Xb
 V1IBK2tobML9/RG9UEIi73vyF7Wm63sPBykj/rEN0jRaM3/dvGGrvWj5rRzg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

On Qualcomm systems, the setup buffer and even buffers are in
a bad state at interrupt handling, so invalidate the dcache lines
for the setup_buf and event buffer to make sure we read correct
data written by the hardware.

This fixes the following error:
dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type -1
dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type 4673109

and invalid situation in dwc3_gadget_giveback() because setup_buf content
is read at 0s and leads to fatal crash fixed by [1].

[1] https://lore.kernel.org/all/20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org/

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/ep0.c    | 2 ++
 drivers/usb/dwc3/gadget.c | 2 ++
 drivers/usb/dwc3/io.h     | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8ba5fcd5312..531f0b522af 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -742,6 +742,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver)
 		goto out;
 
+	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
+
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
 		dwc->three_stage_setup = false;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 19c3a5f5e58..e5a383407a2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2534,6 +2534,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 	while (left > 0) {
 		union dwc3_event event;
 
+		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
+
 		event.raw = *(u32 *) (evt->buf + evt->lpos);
 
 		dwc3_process_event_entry(dwc, &event);
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 0ede323671b..c1ab0288142 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -55,4 +55,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
 
 	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+}
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

