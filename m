Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0521091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5DD8405A;
	Thu, 19 Mar 2026 22:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHrN/3U8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E11208405A; Thu, 19 Mar 2026 22:36:39 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D7F838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d75ed779bfso1130913a34.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956194; x=1774560994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+QfwFIk+nx4YJAlK5NYm6V5OG13NOu6p5ItcgKSPxk=;
 b=aHrN/3U85ebJ61vYkGdSQpblY/7rriWxYMC24jScJwSwO+ip7NKDeuFy67KFH/V6Oo
 2u4VFqhpEqxtvg5aldPsAD4/uq2vSiu5wyuRUv02B5lPqDNobu5Weiexem4udG1BcV63
 M4n1RPH2XVBhn+tlbMCXmsLbXi/Q9y5XWFW0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956194; x=1774560994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+QfwFIk+nx4YJAlK5NYm6V5OG13NOu6p5ItcgKSPxk=;
 b=WldB/tPADz+P0FA7irjkAwe+j7NU27+/CCzghbzi2HELpc4uyxUr/YxML0Iachm8Mz
 DiyOGeqkQeS8PHuM67PZv2V6PJG7PsRz1G9ppxHX0gfYpcZpNXthBp2fhHWRBLqReHkL
 029QMcb+wEGtcyqEmy4zKiCGj+uPeOJX5ZnmIV8EshP4r3sgiey0ElIpwnThJvE3aj2g
 GIDMBCvHoeS3asC1Z39+Joeph9EStpDFdhVwu+4jFOK+TxRmoQKEQCzvWPCLUa0TVi41
 icMDYX+7iD/WPuNc3pVGfuijlW5F9zEFJ2vsaCktwVNUfsY7RPUyGI9Wzh4aOnoVCh5L
 Ce9w==
X-Gm-Message-State: AOJu0Yy5+tC79NkcgsQtUp5HKSad50b/AOBUerOQwM2kvVW7W8zhW2IR
 f701ugBwYC0u/8qA8xVEFcMr6oAPaOSxrhn+azvIEnoOqL3zbspTYjf5vicdE/6CgDw7AwQPucJ
 2pJBMoA==
X-Gm-Gg: ATEYQzxTi3OkI0raxPg7Dh+93JpA5D3VrBV++RtiNTj9+mZlTTYkg5EtO6hF694+Xzx
 0MKy/+RWsA2V/Toy4autg7aCheZCLB94p8IunlJl1vo/Z9Ucc1jjQ8nhMbZpwsy7MZNYS2H0dg1
 odgH2ln2NfNDQkShNEN7Q69kD2nlNCBtEU3OURtaENo5TQ1795YpTuPIB/Qc7msgbQ4lXSk3DTA
 MUN9JdANg5QuX3qSXPQfIMgfT5GziG76ftFz6m7iNscr92dio6j1xcxKyWpFgtAJYUl4JoQmQSI
 F6JIylM357ia+yf7Wc1mcs0+tzCX/eTuM0VB5QOKWhcETM8TpUL0wTU4qAwXX419VERVuhPyTJm
 58L7q1DLZzRA9i0+GkllK8V2BabrdlYlmkDgaRlb8u7ipj6rc7bpMeKmzhKxd2Vr1AfbxG2zx/M
 iOwnRv5k8/jR43QG2FOQ==
X-Received: by 2002:a05:6830:3805:b0:7d7:52c3:89bd with SMTP id
 46e09a7af769-7d7eafa795bmr553198a34.16.1773956194165; 
 Thu, 19 Mar 2026 14:36:34 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 03/15] dm: Add a way to write the internal seq_ member
Date: Thu, 19 Mar 2026 15:35:33 -0600
Message-ID: <20260319213551.267031-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a dev_int_set_seq() inline in device-internal.h to wrap writes to
dev->seq_ from outside the driver-model core. This is the write side of
dev_seq() and should be used only when absolutely necessary.

Use it in pci-uclass.c which is the only external caller that sets
seq_ directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/device.c        | 5 +++++
 drivers/pci/pci-uclass.c     | 2 +-
 include/dm/device-internal.h | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d5..a55fdb1628f 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -1179,6 +1179,11 @@ void dev_set_uclass_plat(struct udevice *dev, void *uclass_plat)
 	dev->uclass_plat_ = uclass_plat;
 }
 
+void dev_int_set_seq(struct udevice *dev, int seq)
+{
+	dev->seq_ = seq;
+}
+
 #if CONFIG_IS_ENABLED(OF_REAL)
 bool device_is_compatible(const struct udevice *dev, const char *compat)
 {
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 83b76d01f24..016a3c79220 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1161,7 +1161,7 @@ static int pci_uclass_pre_probe(struct udevice *bus)
 		ret = uclass_get(UCLASS_PCI, &uc);
 		if (ret)
 			return ret;
-		bus->seq_ = uclass_find_next_free_seq(uc);
+		dev_int_set_seq(bus, uclass_find_next_free_seq(uc));
 	}
 
 	/* For bridges, use the top-level PCI controller */
diff --git a/include/dm/device-internal.h b/include/dm/device-internal.h
index f31c4702086..4f86ab5c8ed 100644
--- a/include/dm/device-internal.h
+++ b/include/dm/device-internal.h
@@ -437,4 +437,7 @@ static inline int device_notify(const struct udevice *dev, enum event_t type)
 	return 0;
 #endif
 }
+
+void dev_int_set_seq(struct udevice *dev, int seq);
+
 #endif
-- 
2.43.0

