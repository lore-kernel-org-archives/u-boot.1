Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6893CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EEC89001;
	Wed,  2 Oct 2024 16:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GnqFawC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3D288DD4; Wed,  2 Oct 2024 16:39:44 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA67890DF
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cdb6ebc1cso2808280f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727879979; x=1728484779; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HXGHuBI7DESo+MXQROKR49q8aImAvCPU6dR7n5FZxQs=;
 b=GnqFawC8L5Hqm/oohzb7qb7wC9EXpF1rbKkE+yHFYyccS3E/sgh6nHcz8u9TaGZPYF
 JlaSRF+qWALD6uX+xCc2DN/XzvDhxlLNjqVD/N+2JowY5HzV4rEJoPruwCTaupcuTyKQ
 gzz3/AKeWNOivfbGJ0xkXw3aJBGlGLt3HLsxO1fGuo1Jv+o6wrD2qcTHAGQSJQQJQC0Z
 49ywofNcE1hHhkc9YaM7zZ0efEDTEGwKA3OuRMWiVb+u2mdgia0tsPjfCKzfVGV9X/Yw
 hYPUXE95Uavr4VeBMhpls+cf/Y+1ASmU5cHlmQ4gHVsRoz2zj8xSDblkVNti5y8ldAAH
 KgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879979; x=1728484779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXGHuBI7DESo+MXQROKR49q8aImAvCPU6dR7n5FZxQs=;
 b=vfUfrwJAZ+a8peAJzevSkA/U9IrwyFRkogQff0++jy/g+kbT14aMeDdmoIb5mKrm9s
 +xjEoAdVPV/KtodC5FKq3Q06KFsJ0ez6zyReYLMysgtB2eb2iZQHgHsz5T/152KOUU3Y
 RWKk8leIbCtai/G/RJ+WGm2evNo452G8sQ6kW7pcqhYzukZblz02Qu9K8XrGt88SjlMq
 IA+bn1/5Vsb/wMd871lmo+njJ/77fJIHSEv/VYk/aieC49eOGGvhzyYdIDh68PpOq9O1
 NEJ+5/1QSiew8SkHxb4aAaRV2YM3q/nfQuYCE4q4qtsiW/w/UqUz2Vokw37SI9ITYhsB
 +kFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/XbL5jbuxG6ObAjQBupw25lckS/LJWKtTUyC2X5B5taenrOxvckH8udx2hXeoDtmv2uNGmvk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyghmj+fj9F9EEMs7eGmjNi+SfJklwTwuf0ClYTrdmQqATNRi7H
 qP9QbNiiURncgvj+b17TODmPxaGvWxiV1M+DLIBqzI6FzomXLE6ShF3k+lTuMuI=
X-Google-Smtp-Source: AGHT+IHuTHlB+UTttxLT9ZtGXGtAPCfnLKXwdr7Wufpul83RmuYVUn92Pmwl69MFTSGlIJX1YrNbxg==
X-Received: by 2002:a5d:540e:0:b0:37c:cdcd:689e with SMTP id
 ffacd0b85a97d-37cfb9d4541mr1868481f8f.31.1727879978946; 
 Wed, 02 Oct 2024 07:39:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e65c3sm14056083f8f.60.2024.10.02.07.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:39:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 02 Oct 2024 16:39:34 +0200
Subject: [PATCH v3 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-3-5398088ef93c@linaro.org>
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
In-Reply-To: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=a5B8p3C7xIZv9mgyWkU0YkXLsCnCIPXjs/MTJ6LPpa0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/VsnPRxaGopPKsFMdfeqrjFH1wyDJ7rDBeYGGQCE
 2sRf7kiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZv1bJwAKCRB33NvayMhJ0d6JEA
 C09w7wvW04GbO4Ick0NQdlB8QQptBIGnqvDVfv5fzmfwGf78A9Evl9W3URJWGmXBDCiiA+CDVdpKw8
 5Z+41HYRJDttWJ7mB9SBqJOTkC912jgLrgKkZDKlXS1DWwOhw3ev5NSrX/0ASHN8wjkKjJzPy1iSXE
 oLQdOh1LOCB2nO0aJxL3EuMOjCp2+u5vBGON2fe2dxNCnWJrvwt/0n2EEEVPhlM2c4t8pfPTsYiFYn
 zvdfnS+/VwZmUGOqyrDVk6zxQnbtPzt2TbLFC7tPwncLdi/5aaoGNYBD+VRXOFyNpu+xO1pnjE0Mlu
 wnzKFFXstKhhXc5BRElkVH1hf68IbMmU0zgLBqJ5vLfEXnug5d6UWNSy+tOxHI0bvJljbghXPcfU6x
 ukJk4oC/wskr9HYnvXuANqqqRBlPv5CnwaFISICkF295dtYqmkyOmCnPZWfFAdGFZ8rL5huwzLcXpu
 BtHDgRbhZVlsWR8hhaqbuzz9/c1JSsWyEsxMAJxceXRahS4ztxTcho90iCLBy6XExukMVbgQbJpNJU
 s11dYvAHqXx0wvzpBqGba9RyikNpKI5O+widNJybs/Rx+aPka1+uoINMYkstTBtHRNMzhseEuyk1Qe
 ooCOEPaMa3e3NS03kwZQrnl9EFxGbd9gKgX1mHvLtpImOdcwKuavs3Vgl23g==
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
index a6c2bb0f47d..b347a7f1fc1 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -54,4 +54,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
 
 	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
+
+	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+}
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

