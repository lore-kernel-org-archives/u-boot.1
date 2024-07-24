Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BDEC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7017888998;
	Wed, 24 Jul 2024 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ocD6TAR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172A688993; Wed, 24 Jul 2024 17:48:24 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD185889A6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eeb1051360so70593221fa.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721836099; x=1722440899; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ad0hAj3rVLkU6OtNt+velqlccTC1YGRAtRCzw7xbhg0=;
 b=ocD6TAR6OfCv7EJkvpaM+/GMim1EsPKs+SVxZdZZ7hp9EYRb1p829/lJA4D3ZPYBpw
 Mya1q2jaHnr3rg9gKBGe/ka5Rj2BCUyO9KyKcr7/UWCHrQWjELCv/n+MZnRSDzfJPTA8
 4pV5p4C363LWyJiZKytNEXp5/Qx3nIHZ0VEqOcZuWcxxFosKNCcyLIVf5PajTT+mFyh/
 RFRpeE6Cq7fIH307s5/IOQW9IXk/kifQuF2hddLyVPJ0Z/pG8vv3PK4n2gX3i45DAYcb
 NH0R1DdaIZNPXRNkvrCjkRcgRHGWSNvarLU5TdU5yRUOc6UHqZzav0yoeGnuEAg+zmE6
 8CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721836099; x=1722440899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ad0hAj3rVLkU6OtNt+velqlccTC1YGRAtRCzw7xbhg0=;
 b=di8RGjljSPGEyPqalsQdQQVPzZxUMRbhdomBGkOjFMpqa3v9C81Bu6Q+Ss6v0r9Sy1
 QZGVsI67J4KHGSheUjdUsCrRY3kDzKb+nRixt7TUGQy5q9JWyub3HvBsxB196y+1JpPW
 nsfnxl2j7nUiHbTSq0t27Hajy4vc9LfrjMCwFnicaSF6G7Vww59WQu8jfM9VVreBCZRr
 EU9vU5aIjtj+3ZwG5C4+DIGug9dlzPrCWRwi+tWt2C3/FLXHHyzeEvzeGBCIqmlDI3ts
 rrj9q98qHo8u97GoXNrzLiH1heSn+k3tXDQaYcwe916DJltStQev8WNz35MrR9YcYTPI
 x0tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1XtkMaSBjI9dcSj+SjZRpj8P9Y5rxLZbAteyLsTIK9EIJj2yzsQ/GD2oIY5SqS93Hl8yeonwQZ1dtP3GecTWXX8UKZA==
X-Gm-Message-State: AOJu0Yz82z7LRg+cDvVR05PhgoLYW2CUAEJArZxhby6/yJfaC1olACCF
 ldPZNFD3llxxxTLRic4UgxZjiBIlxbbZUTjrOuf3Ml7rVTXXt3DQ7hFleP+oMWs=
X-Google-Smtp-Source: AGHT+IFXxBJHEvS2LJNaeFzQ1lzgCq7BX5nda1OZYvmRAMo6nfBTBM/YgoOFaYmvH81LVvPW1kIflA==
X-Received: by 2002:a2e:87d3:0:b0:2ef:27ab:40e6 with SMTP id
 38308e7fff4ca-2f039e14a53mr1527901fa.49.1721836098656; 
 Wed, 24 Jul 2024 08:48:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93aabdasm33633015e9.36.2024.07.24.08.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:48:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jul 2024 17:48:11 +0200
Subject: [PATCH v2 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-3-65836d699a71@linaro.org>
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
In-Reply-To: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3gMDwcl9eQjahxC/asoDOOL8xiMqw5Kh1iWDspcId7I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmoSI8eQRS30M5GikS3/OKz+h1cEWPN7muwjRV87Xz
 rvEHjM+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZqEiPAAKCRB33NvayMhJ0Q7/D/
 44oY8AqIaM5pzi1/BUjjgo6GCINpEloU6TViwVNF62L0P7Y5BFn3atd6ruf7vd6gaNBEyaB5T3bDye
 wGicv+MyX4SW1gh0VeEgd4Q0puflqWloDt7md/IchPntWqYc6+3kwpbDYujruSQE1sq0pbvASeqofZ
 f3zMAGc2NffQxLzfrNqGT95QQcQujsQ8/3p9v1p9C0zm4QGF+xx3pzcKgRR+Srj1S+QwK9A9ozTGrn
 LwqN0ZOheVAp+1U8rXbFwJQKGi4GGqk03cuXQDnI5TbmPDs5VT/IDhukJUxPYifarps+3iNsAVnG/i
 ErJcgI7LUMUPEoWCnsPm77diM6B4FpY9yqKT3YY4tTt9bxUo4vfDQw/GDFhtKxaMa0O1pMAGYiVBzW
 RMCI7xanOjDjsxdaw31dJKysw1BRqWd5KYPgimVTBTV/UaLysAFEXwaEjIcPI9C9kUGcHw/smzchPY
 0AOVUh/ElgPctCZkKmu69wFJQ4vfAWGXKyIyZ5wdr1jSBbbywvgvic0x5RlJw7bX3jjE7lIcdEZXLW
 xE+9SUuqMdt9WaaMzJ2FnDEX+ovq4WGBsrJcZnOMna6Z3Herbpm/s6PRXzUvTklDn81xS9EQw8PH+1
 KjKV08D+Wf77WTmidX+UznRMp5XlCWhvNNoSdMcXzsTh9jo1OpN0iiH2vYDg==
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
index 0c7e0123368..fc1d5892106 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -743,6 +743,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver)
 		goto out;
 
+	dwc3_invalidate_cache(ctrl, sizeof(*ctrl));
+
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
 		dwc->three_stage_setup = false;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d41b590afb8..0bc9aee4daa 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2503,6 +2503,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
 	while (left > 0) {
 		union dwc3_event event;
 
+		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
+
 		event.raw = *(u32 *) (evt->buf + evt->lpos);
 
 		dwc3_process_event_entry(dwc, &event);
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1aaf5413c6d..7cf05203b0d 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -55,4 +55,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
 
 	flush_dcache_range(start_addr, end_addr);
 }
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
+
+	invalidate_dcache_range(start_addr, end_addr);
+}
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

