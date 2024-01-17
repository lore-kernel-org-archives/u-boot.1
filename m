Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C050C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0230D87B49;
	Wed, 17 Jan 2024 11:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J09TAAPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC2687B63; Wed, 17 Jan 2024 11:18:15 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027FA87B49
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so9600483f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705486691; x=1706091491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oi8CWpyPCnS+eLPwKmQKO9MvedaZGlJAQEtkE4HKq1w=;
 b=J09TAAPOM1E53l0nUMerTSKpvIZbTWYF1QDDHiyvaoWKY4CAg4hFBSUZpFkTAo1Cuh
 XfkGWhpJL7szmnC6VGMkXC3O2ofCljEs9Wz7CKhlNibAiETcakiDvfV5jWPLveSqNBOM
 agFMCZoCgztM7G0DQpj+pSNbFAZA7xqSm1Scdvq49MSgeo5fSp2jfbY26G8rl1fICwDq
 p8NsLjJzF72FwjryIfJo5rIccyM/Qx9TPhodzywYAG2fe6PT3BZLK0ny0zBm6zyryuMn
 oGYqnZc08aW903MP0nHTrrA7WYuJ8INU6Dg49qPXuFC57gEXiC0JBrCxE02btkpXOp1e
 /Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705486691; x=1706091491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oi8CWpyPCnS+eLPwKmQKO9MvedaZGlJAQEtkE4HKq1w=;
 b=GMlC2qmm+MtICtdI9Zs+IufpVnN/rV6mRuG90gXKdyVTqg8C3WMp7iBPYybafIFng6
 QQMOzQ6hmMEHujdGXw0z3ghlGMQHD0srnM5mkDQJFHp1f/kSy2Wmt770zWbsimtb74zf
 9OAOqqxILpWXI92kv7UPyy3S23swR3UO6O4wuJnSO4nQUOQPD03Nt7+6v/VmMrqEiGtq
 e/F4zzXj+47TlF5p+zNb87yrSv7LWXgSQ1vpnwy1YGwd4/mmpaC08CQhRZkCmi+B9PNq
 DxhEFhwEUWkMTNCF2ne387bAMVA6jdHfu4KPZtO+vfChiap1TB2HcYkJfOamd9hDXgE8
 VUwA==
X-Gm-Message-State: AOJu0Yx/hwNvODVQeQABoXIDtzRT3ADDWUYNc4IfyoxJGNEgfwoHG9fX
 pVGBZ07V65+yQ1YR2lTiB9gFc/Qre8Y=
X-Google-Smtp-Source: AGHT+IHe6WQjNZ4difjrbax4DSC3R05zp/B6qAh99tA1ka5GksnA4L/nUCH3YxY6DqNOrZbH8JxOCA==
X-Received: by 2002:adf:e7c5:0:b0:337:c2f2:1eab with SMTP id
 e5-20020adfe7c5000000b00337c2f21eabmr263812wrn.245.1705486691417; 
 Wed, 17 Jan 2024 02:18:11 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm1305849wrw.60.2024.01.17.02.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:18:10 -0800 (PST)
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/4] arm: mach-k3: am62: provide more soc feature info
 accessors
Date: Wed, 17 Jan 2024 11:16:48 +0100
Message-ID: <20240117101743.3955852-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117101743.3955852-1-max.oss.09@gmail.com>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Add two functions, one which returns the SoC speed grade and one
which returns the SoC operating temperature range.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/mach-k3/include/mach/am62_hardware.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index ea5bcf5d3de..54380f36e16 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -86,6 +86,22 @@ static inline int k3_get_core_nr(void)
 	return (full_devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
 }
 
+static inline char k3_get_speed_grade(void)
+{
+	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 speed_grade = (full_devid & JTAG_DEV_SPEED_MASK) >>
+			   JTAG_DEV_SPEED_SHIFT;
+
+	return 'A' - 1 + speed_grade;
+}
+
+static inline int k3_get_temp_grade(void)
+{
+	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return (full_devid & JTAG_DEV_TEMP_MASK) >> JTAG_DEV_TEMP_SHIFT;
+}
+
 static inline int k3_has_pru(void)
 {
 	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-- 
2.42.0

