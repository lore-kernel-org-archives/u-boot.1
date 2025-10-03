Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3872BCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A2A8392C;
	Fri,  3 Oct 2025 22:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="no9WUK/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C3F838EC; Fri,  3 Oct 2025 22:39:33 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2527383919
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-42d8b15548eso12607625ab.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523970; x=1760128770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OjN3jrD4dweMTsrOmLcyAB82JOfCPZo2Ww7/6tTtNIk=;
 b=no9WUK/wC6cFZX1IomIJFYuqkZFOpuAujDc/xNp41CRqH2TUuDK7bX4+p2Xcx1lBgN
 JI9mZtnG+8FuFPrpqY/iJlHgB5UYpm3dABpe5gp7tTXirW+TtdVeitNB1slm/RUdQt6s
 5xEpnqESdTqB0fQ057OBtgg16HVQGonkMK9r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523970; x=1760128770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OjN3jrD4dweMTsrOmLcyAB82JOfCPZo2Ww7/6tTtNIk=;
 b=W5F+n67s5QZ8Xe12E+ni91HwJz0g7ER4ClPLVoIP+zz9danBBJ2TIqIEGLQDSG4gxu
 1oVJpZ6SgZ5bLk3JJgbGU18oSZicrfFMJuvQ5LB+7+7Lyt4tJcylo/BoUZzcEyMQv6fg
 TesemK8SN6WTPURlmeST4yiWYkN1T4O+teHpsfvXGjUEuqF1+UYiza7iQAqojHXUVw7c
 V9WdcbZ9O4YD72LGGvOKL5X/0QRN2slsPKO0KdD5mbcmr/qJFKY2m+mtlDl1Q6Q0lKMI
 N1zy5PcnGkQ3UJbSfY1/s7/q6T5MSTYyModdcUfH4GpiFg+yPUiQF/JnS86ot99+N9W2
 9D3A==
X-Gm-Message-State: AOJu0YwTTCXkNZbJz79aKqdDTpJ9OGkghOFKW7bpIiC4yf1cUoYok8Gq
 rfG3h+QkRQ1HfT1CKf7xoTvhOTFrKjXcB3VYKRXN+mKBQmIKM0LGzR3eqDxtBopeYxmoicgnX6w
 jrIaPH1E=
X-Gm-Gg: ASbGncuMM0kAWNH9ZfKkeSupMY+fCPCYl3I1NHug3ZwA/4by+HeHhpfvEm9uIi1+hEh
 engs5TUZaPCuMks+LNzzv21Vy0uLbcdt1MZ4KNxK1OUq7Cb99Li6jSIIR63mRNmndUwZNxNtAWj
 Y2age267ILVY/9mNXTONejBvY8RHPAgJoUPJheVQvTeGJbUVwHAqx7oTtEijzd3qX21FpHJQzXn
 jAt+e/lyZJQZ+6I2qzZrp97NR/joTEceiwcAWUvlEnBjest2Srwq9WVZu402iiIP6fGYZuvoe6u
 ksU9RwBiq7Z+D7kqMUIxRcYs8YgDMVawUI2evrbWVxPMUSpfcDedg5Eyv0qWWM5p0q4C0dFKpq+
 H1V1WZBYWnOpvUwhNsfQJYIS0AivTmJN5ujVLgMlDHMgcsyB0bamK2Apdj9Kb/JTAF9QciTDkQu
 wDJwgL69wUn4IDufBC09FIJpQ=
X-Google-Smtp-Source: AGHT+IHEQsexGwyeNMAkmakiKUdxnpKS2tsEWe5EmDMZhGk6Y42P3MC3kFnegn9N7r/ser4GfGvm9Q==
X-Received: by 2002:a05:6e02:228f:b0:42e:7273:a370 with SMTP id
 e9e14a558f8ab-42e7acd28f4mr51519055ab.5.1759523969882; 
 Fri, 03 Oct 2025 13:39:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b2163dbsm25193615ab.17.2025.10.03.13.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Subject: [PATCH] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
Date: Fri,  3 Oct 2025 14:39:27 -0600
Message-ID: <20251003203927.1030052-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This PHY driver is required by USB_EHCI_MSM and not useful on its own.
Rather than have it be a prompted option, it should (and currently is)
select'd by USB_EHCI_MSM. Remove the prompt for this option and then
correct the dependency chain (it must select PHY).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io
---
 drivers/phy/qcom/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 61e5e2fca413..0dd69f7ffd0c 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -1,8 +1,8 @@
 config MSM8916_USB_PHY
-	bool "Qualcomm MSM8916 USB PHY support"
-	depends on PHY
+	bool
+	select PHY
 	help
-          Support the USB PHY in msm8916
+          Support the Qualcomm MSM8916 USB PHY
 
 	  This PHY is found on qualcomm dragonboard410c development board.
 
-- 
2.43.0

