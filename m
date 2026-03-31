Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A59DFF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5D884099;
	Tue, 31 Mar 2026 10:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yr7fzUOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEA383F5B; Tue, 31 Mar 2026 10:01:40 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805B184011
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso48850235e9.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944097; x=1775548897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8qH+4/Z9p5lPWD2pDoZhs23SmQ5PbVpQBMoyMvrbOQ=;
 b=yr7fzUOvYb6p186PGnbZKQmI38Vamh/nWHtXS8j73YeMtX9tkdzGTHNdOFrV3l8xTs
 cZhYKr6Ezx7kPDBr7GNv6IOZru3qxGzp6tKC/Mhe3j/uIfPSUM55tymSkq5BdxdpBwhn
 Haky+CNrxASUS4P+iR1lwwTC4YGslAI68yxlF+DHYUJZAmX90NKZJO5EHbvi/0xxqoQK
 V93gF8qLsS1ikU/TwnG3WzTyIuH4vHSACXs16iJZ7Sw1WtNVmVYk5HuJMIM1DW1CxekX
 Aq/RAq58iyd8llP92JKTc/laCU3apgMSeFOaVMhoW7y71G0SAFtSpxTbW9Ydclulb91K
 Dxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944097; x=1775548897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X8qH+4/Z9p5lPWD2pDoZhs23SmQ5PbVpQBMoyMvrbOQ=;
 b=kDljxCFoLEE8UDezGICDzbkvK0Lm/P9pdn6xckXsyLzSkAwlbrAP0hadl66d/HbH0U
 0gBlCqQer+Q/pSGmS9Y5LTEIof/U98Ur8gK/YRr5IqmpxtJxunyQXFQw/KHDYcdJhLxZ
 FNTY+T3q1TLWyZ/QSU0TMH1HNL0o3ZyM90ZygScvJUQxEoMXukM2i+ZHUdfD2V88Jr6k
 jCllrSQ8n4XIoKGyxU+hs/s2T7wekDRbddX5n7cCbHhWkpcTKU2a6NEP4Gr2wpGoxBIJ
 +2fuOLmeEOk2Ywl1sWefSC+DyrZ4ciF1zrtmNURruYSxp27r9w/K8UkeNBRDkoLcjwWX
 7UeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQTq6YJsykIHlPboOwjFC96igjHDTssgdKVI1n21IKopDLEE/IUmLm9Mx0FkF0Ivf7TkCwUo=@lists.denx.de
X-Gm-Message-State: AOJu0YwP/7ZWVCq/Kcc4YeRRSBTATkYzhIed9Dyg2YKFD/ebV8V1ecRr
 A0hXFX/hfvKdJuxaZSUjdNMW8mllJ/aX4U0AlC5+1Baimiy9XrC1VOnE3KEO1GJsGKw=
X-Gm-Gg: ATEYQzzoMtCSNRT3gTZEetrGhZguMOyOMH+ektDh+9LtsFQKlDZy4RUvzvpvWalQrCj
 JXp0QRrAj6WuetN+euPXk9vANIbPf3nH8lsL5exhNKvULMnxxsn3QvoKJclB2DYGeQGE95n8Gx0
 KYLYHIHzbrY+svxDWbLqAtXtedM44Hz1IY+94hy7lRjbMYUf/RTK+cdF7pynkX0AWnzcvDK3tB7
 7KeFfMMzTAVj/E8x/K1oXrrjKmy84PuFMiNBvbROGAkZsE1quuYt/mPGn86+gBXFs060CDbl4/t
 ZxDhXvI1eDFfk5eApg3qyPS9Y1iw6y+rNXrY5UXx49dUuo1amr5YKvFUERLjzgYwAuNfGcSIDHk
 NkctowqJjdg66CxOh3fUxTsw9odoueYvBDrrHLyn6Vml304ue888uRhdKUDsNmSAcNzLbDKseij
 jxBowUQeFF6zef4NBdnMAKG/6iAwpAUpIarz/66TLQCc/qPxkB1rSvZHMUJ3Jsn9naPV1hYOzEC
 MgAaT0VYNVveR06GF9p5aJgavGbi+UjMjHmFYyAejiomjbqzq6vNnMzwa0zqXh+1T5V8ElObmR8
 GLHGVjCgReCYGxHwcrfA8s9i2xCg4K5ThvA8XIBMG2qnjWZpTp6Fh+jqQyC4aDSrcYOwgPEMHGC
 k5BXtUwXy9QY7luuSb8SbQ//+bgmaw6l/AwojuiRH/GO6DN2eGf6l2JLE2q5sKRhEfSkaCC3UCj
 Bm1riwf4V3IUf5nVrtK034pl120Yj1rgrrvzMFB1F6sciU3xpZl1t7mDnVZy4k
X-Received: by 2002:a05:600c:3d87:b0:487:2092:b2e0 with SMTP id
 5b1f17b1804b1-48727d5a246mr255110825e9.1.1774944096794; 
 Tue, 31 Mar 2026 01:01:36 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c9250afsm10087065e9.36.2026.03.31.01.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:01:36 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to determine
 the memory size
Date: Tue, 31 Mar 2026 11:01:13 +0300
Message-ID: <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
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

We previously added a fdtdec_setup_mem_ram_top() to determine the
topmost address of the last DRAM bank. Similarly the overall memory
size must be calculated when U-Boot gets relocated to the actual end of
all available DRAM.

Pre-patch:
U-Boot 2026.04-rc5-00012-g5789f787c8a6-dirty (Mar 31 2026 - 09:13:34 +0300)
DRAM:  4 GiB (total 8 GiB)

Post-patch:
U-Boot 2026.04-rc5-00012-g5789f787c8a6 (Mar 31 2026 - 09:12:59 +0300)
DRAM:  8 GiB

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/fdtdec.h | 15 +++++++++++++++
 lib/fdtdec.c     | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index 26e40c3cdb46..9bccd70bbdb6 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
  * invalid
  */
 int fdtdec_setup_memory_banksize(void);
+/**
+ * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
+ *			     all banks
+ *
+ * Decode the /memory 'reg' property to determine the memory available in all
+ * banks and populate the global data ram_size with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for the
+ * overall memory described in as the sum of all memory banks.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_ram_size(void);
 
 /**
  * fdtdec_set_ethernet_mac_address() - set MAC address for default interface
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index bdb26d8fb75b..715662d27a8c 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1142,6 +1142,24 @@ int fdtdec_setup_memory_banksize(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
 }
 
+static void fdtdec_setup_total_ram_fn(struct resource *res, int bank)
+{
+	gd->ram_size += res->end - res->start + 1;
+}
+
+int fdtdec_setup_ram_size(void)
+{
+	int ret;
+	phys_addr_t old_size = gd->ram_size;
+
+	gd->ram_size = 0;
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_total_ram_fn);
+	if (ret)
+		gd->ram_size = old_size;
+
+	return ret;
+}
+
 static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
 {
 	unsigned long base = (unsigned long)res->start;
-- 
2.53.0

