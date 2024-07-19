Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58CC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 13:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C547288BE8;
	Fri, 19 Jul 2024 15:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hjA0LV7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C55988BCB; Fri, 19 Jul 2024 15:57:03 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D339388BA8
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso642541f8f.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721397417; x=1722002217; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XC6Y1cpNpchY+zzcdh5bJH6Mn3r/EZmTDYKPR+8m8/Y=;
 b=hjA0LV7O5LBPccrqikk5ipdtONuNqS7+VmssDy5cC5ZBRawSeE4kj+WY+TzDgJ+phF
 j+Xlsyc6bVShHImPGTHCR1HLVk9wWwMsCOPBiQGpxkuPJtJND6vbqUQ7uiXbM48N5VCH
 O+ns2rHjhgmTGx3yF+UwlAJUfcLP/PTvsdpbZKcY1bT+TL/Cw77PfUWSGJ0sfAMjoEou
 Rht25VvUS5gu6VU30QUNcoZ0bNa4g1d3JSNUJS9ECUhv/j5mEh8+mLSU/dPNuP/g/Ic4
 iIMzfT9Yj5mG8HY3j2XaGIUDhB/Gr2ogdcPoZDh55IsAfH5EB8SrijtKRbF296o9h3wL
 IOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397417; x=1722002217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XC6Y1cpNpchY+zzcdh5bJH6Mn3r/EZmTDYKPR+8m8/Y=;
 b=JBF3vfrWhWRzHGM7DklTWpLHhKlHZzjYdCa77x2ckKJ4rYemoV0idO1WpzwtzT06lV
 CmfQJNTMMs8vALEpCn6ocNv8w7SYpuFPPNRDMzgF3pL9FrKjTL+6BDUojNeYZ8kvGJ4Y
 k4ldrZrQuatKPuM2yMOEKEFq4XnWqz2Te+RkeOqdJcESo26c/KJWy7QRoRmb1CzqByJ0
 L4N+jVbMFM4PijnOHnKHz2gRSZY8XYLWvaue1XyKC6abL/Mnf0GvCArtiCpz5chSQr1n
 YQzFiHqDUzKNXOLAuu3qOLunen9mBuBa6izV2tB9r5mZdGW142c15HLgrxS/0EQ88R6C
 f1sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJVy7JQmdRlQIKA481zvGF6lvb11VBmdOGUz504e5sFQYOhsfrHNcgV8qgxQCqrAHYv51neoex/btSNOYWMnn0fOX9Q==
X-Gm-Message-State: AOJu0YzkdNV6qj4liOYBqR3UAIL+SHstGXF5R/QbTl4d0njE2AL3pMnt
 TCHsNPnNvGLqMGjNnHpCP7fDpZM1DKWocJMg2r7pR0B9suUABzuRCkp1ud1VTQQ=
X-Google-Smtp-Source: AGHT+IHhyf2kZiFpnueDiZRVb1po4NJUgo7RKD1pJ4qcEbwqNYczBKz0tSBm2aPivUd7NGNzCFcfsA==
X-Received: by 2002:a5d:4576:0:b0:368:657a:6347 with SMTP id
 ffacd0b85a97d-368657a647bmr2726949f8f.34.1721397417069; 
 Fri, 19 Jul 2024 06:56:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc21sm1694083f8f.39.2024.07.19.06.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 06:56:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 15:56:52 +0200
Subject: [PATCH 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-3-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O5J25UaIoFRsnO+v0VukJ5RdDmbk6MuGwxOpVDPF6vE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmnClazlJj0WqLRfFrc+7CRP65tPRd8p7CpfhZbjd
 xeha/J+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppwpQAKCRB33NvayMhJ0UK0EA
 CodKdnPVSp6uLnVnqS2+F+5gLUR7NspBen5GdUogUMAnAhdJ1ye1HfrZu5hvnlirnE3Ba9L4EZp7XT
 z6iQXmUhMox5dL8AcsGOJF5vaHOailBehTO2ox483vcMODVznbp1TudsgLLCHWmPB1yaRnt5VWACb7
 /U5MvOpYsqr8qcxukiFar2GMJhNeVWG9HZKYYPlcO2Ub7KTTmVO3iFP03g6PALFPP8t/HZ+x+vUta9
 alCepAAuSe2Cq7JXCRw1ayQtUnVfP4ZAuAjmN3Wi95+as52mR2rwKS2UIjZroc0VSy/SFUPyirrQaI
 xIJ/xmTQYJKcRpfEP2gI8PCbpEMjniAGDzPBcSEno5+wYMi1OVfKlamn/37R647kJxaivfNyfeV10f
 XCHhYQIawp2MqxbsLfb7G3L9ewC9gecovnL/IdqNLRJ6OJ7iNH71ZvNP2+db7i5ysWvll1Dw19lMIV
 pNKrhgTqNwDvpciG1nRHUpURBweWcIGdFAIs6qOK58dnQ9sXfdGZzwePx0FRp+g3OJ23n6SeGDPtVp
 YMm3DMSnMP9otyuIlnn3hI6N6SkiSZG4CzjSTBW3XYMQ96oRZqPtasnkdzKGzpLS0F9y63zaiuUS3+
 TWms86YHTym0Y6ZFCMGfVzNyFqHOhwq74U9u3BpKiPx6sy45NQOUeein9h1w==
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

