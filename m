Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AEDC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D54E88B8B;
	Fri,  9 Aug 2024 02:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T38HgojL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA04988AF4; Fri,  9 Aug 2024 02:48:59 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B3888B09
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so149540066b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164537; x=1723769337; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ozzBbMV0QmkNampH7bqGU016FQNtqxe+zTuFfricKLM=;
 b=T38HgojLzUmOxbn9u269NYstOaJoO+6+CjgwZKPoBA+7VJabGWO5KtGL9YeVALcnPp
 1yU1kUlCNNXMLC9p0m26cwzFMpVHWqs23daCdAZkxnNtbLxBigTmVIkMfUwtpH6kyq6j
 XXoZCeavVUHZiOWeIdDmhm4f0PdsHwUotV12SzwOlayvq5ocDwdKqyztVjvt864X63O8
 YET4NiGF4DnxSeo6XOMxJanhiWTrpWtRHWMPdZwoEMhZjcSHyriE+iHUyoem1te0wkCy
 T36eIAAleoBVYuADaHXEzHJzpArGr9pfLb3juYhsyvV3NuoUr32Cimp4/cwBtRblN+9d
 Lsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164537; x=1723769337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozzBbMV0QmkNampH7bqGU016FQNtqxe+zTuFfricKLM=;
 b=H4QT6qlI5aYHtwCjM/7CbqM9ycM3OJJGOrF8ftEc1YERC/FhpxjtO35mfSjRK3QJ8A
 jEvvodgkgNuw5CPkPUiDWLRV7KonCH58lfQAm0eppHorSHwv6yzIAxG4ehJxs4j71b/J
 llE3uQTobXx97HN4XpQilX1CEaEwbeMdohGTzqgLQ+UDO0bZHX7zS/3qPdDHR8a2xNkl
 eBZp7srfbFl6BOzJzlmSYZYjY1OXZqC1KYfHwjZaJvOAar1MyVD3Q8T5cZAMESgPuSRf
 jnceR4Y6IggDsu4ZPXartlBAXKUgoG800WImDTlEP3DvC2JpL5e7lUbA66yKsM6gEAQ9
 nrAw==
X-Gm-Message-State: AOJu0YzaUE4mL2eG0V2uQEJWQec8zw0+JCnnLUOQTj6IE49vfDTVEjgW
 tsFW+dFuf6B24irAxyDj1nMyGYYbV52UtQ9RjW26Oms3Tn96vWyKDgIJUW8wsFg=
X-Google-Smtp-Source: AGHT+IH4a1U7euTQY3l+Ph1B4xkc57UW+tEPQHvY+ZqUsT74H67qfghMZx4Exc98MqypaagcZm2Ilw==
X-Received: by 2002:a17:907:e93:b0:a7a:a5ae:11b7 with SMTP id
 a640c23a62f3a-a8090e41996mr277731866b.49.1723164537194; 
 Thu, 08 Aug 2024 17:48:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:49 +0200
Subject: [PATCH 6/7] configs: add qcm6490_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-6-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gUVH5jOKulVjjbsx+zTpjMHg8G3TBxJ1JzT6pmREvD0=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGa1Z3Cjlj+SNg5alDahemBmvoEd1hw31xpaN5TdpGzHx70cI
 okCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmtWdwAAoJEAWDMSsZX2S2yIkP/jBq
 +0vr56asKbu99JxTmXIqI2j9myhhArtB1A5AjwUUtVPLWESJRzNldWm5C62aiQhpRwxlLoBGDkf
 7jAoUSUAn9DmW5+M67mcLEghOMtSiVOJJ8Khi6/GSKsAumabdeWd3sfqt1c6xwPBIqSWHnbywVI
 RlzD3ckbJ0x+nd3ZWa5Td+f9eqRIwSxcImDmcuFjx4LjEBljviMHd2PYxV8a4a1OwYh1rfJvxDM
 ctdUVmLQsShaDVt4+/Kp5XU0mS550e0OnhzDU4ZjaNBw6uAKnIQAk2Wotx6zPbMu89SUzZJlIWN
 7WO4q0Dr0+1stKTu9s1rnGHTtEmz6oHjIRLTXXh/CjlBrQdformtBf8EAse77qXwfGIBSTuOBk1
 Cf7md0Csk/hhoSAYAYClPdNxKopXs8tuv1K/kfzvn5bP/BrcuwY5Ze+LryYpjuoi7FhzY1y2cue
 j1HP7pN4AiDi+hJ/qtBAjT3i64tvSYHpwgP+MxeoSTPI0QynbjioGAaSuEeUdin6NwRLeropZqj
 wjXSInZEHbtk5Ck7RMqOVPd9KwOI9gxX3MFwP7a/EmuoLwysgnvC3X24AD4lED0s6ts8e6NxhUa
 dEoWaGCFVRHGKcY7WEi8R6LRvroM6j+hwEmTSnWoisLmxBEiSaVAUtSrQaDzY6l6pg5jYSmv3oE
 O2YOM
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

Introduce a defconfig for the RB3 Gen 2 and other QCM6490 boards with a
dedicated uefi partition. These can replace EDK2 entirely with U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcm6490_defconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
new file mode 100644
index 000000000000..25413ac9ed5a
--- /dev/null
+++ b/configs/qcm6490_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9fc00000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"

-- 
2.46.0

