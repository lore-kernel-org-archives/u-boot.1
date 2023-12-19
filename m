Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85759C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD65876F3;
	Tue, 19 Dec 2023 22:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+M3envO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD448773D; Tue, 19 Dec 2023 22:12:02 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B92C8771E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42778277d9aso7609521cf.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020319; x=1703625119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfkwjanpdWK7Iucm7OAX0/5ZRbjtswz71YWELeosZDI=;
 b=m+M3envOGQwUhl9l1F5inu2IGUf80Qa4QXEqrkL8DToAVsi95oZp7izn4IRxTJuEqW
 FdsBZKxJBWr8eDmO2HwsxDHaX45z4w8esQghQqPbMEdc4Si8JT1zX5rPx83/mnkxyQXH
 fyjis49EmEJKtN68VdMXuYjb+AXrL4SSxoqxkM0A0KAnV5jlUnoJctERH7zxDc8ft0F0
 nVhd4UWE82LzZ8vv+AgtNc/2daI+cVDLoYqnXjfwOLfFXfLTpYGhXG8Ys8Bz/PikeIPR
 B2+DvOzPkYi2qPBVmBnTtfDNz967E9CDxQ3961FowKwIRkVcqtqNJBr0dDpxeyG0swsd
 EJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020319; x=1703625119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfkwjanpdWK7Iucm7OAX0/5ZRbjtswz71YWELeosZDI=;
 b=Ll9is13YMiqZb9G44LNhq6ZxuPWCRFrvb9ab9WmVAvUyipqeGv4SSGEXW/74KjVRz0
 oLMYD5njcpbBkqGDsIYdE7reP5W+juAIS9cKkaHYtxC5Jz1wUKME4fT5fjOE604EMgri
 u1y5iLJ19qYztD0vkRD6DS+gT4S8HLdmc2vdLWigSBk7t7hpf1WSfIHr7Bn3KCo1js7l
 3cpWBNIi+ExlHF1kA6WY8Vm8GF6HcED1fSkV2t4JTL58pa1M3JAdnwm5f1OobkrRQKS2
 s2+Kx5exJQ0Ds1P4HMadoxZ+wq6Ae3iC3BGXe4AsiZHKbV4QcKPIQVgS28djd0WHwiiu
 E0zw==
X-Gm-Message-State: AOJu0Yzk+kpfvwq6Mgr7Ztbb96mW2wxkGHgrWr+5ki727oxbKBjzwtnO
 44o6KYgvJZFOMuvh8HOxJd1hCUDA6RnWPZW/u10=
X-Google-Smtp-Source: AGHT+IFqhOXEC1gdBvlLpRE7dAtA4F+WlFtJZhIfs3YXvLEt+8XhvLq+GQBtqoKDdHG4/NrfhWdVEw==
X-Received: by 2002:a05:6214:27eb:b0:67f:c7b:d16e with SMTP id
 jt11-20020a05621427eb00b0067f0c7bd16emr13081142qvb.9.1703020318958; 
 Tue, 19 Dec 2023 13:11:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 5/5] qemu-arm: get FDT from bloblist
Date: Tue, 19 Dec 2023 13:11:12 -0800
Message-Id: <20231219211114.393193-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219211114.393193-1-raymond.mao@linaro.org>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
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

Get devicetree from a bloblist if it exists.
If not, fallback to get FDT from the specified memory address.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 board/emulation/qemu-arm/qemu-arm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 72e0a97567..455c042a9a 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -148,9 +148,20 @@ int dram_init_banksize(void)
 
 void *board_fdt_blob_setup(int *err)
 {
+	void *fdt = NULL;
 	*err = 0;
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	return (void *)CFG_SYS_SDRAM_BASE;
+
+	/* Check if a DTB exists in bloblist */
+	if (IS_ENABLED(CONFIG_BLOBLIST)) {
+		if (bloblist_maybe_init())
+			return (void *)CFG_SYS_SDRAM_BASE;
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	}
+	if (!fdt)
+		/* QEMU loads a generated DTB for us at the start of RAM. */
+		return (void *)CFG_SYS_SDRAM_BASE;
+	else
+		return fdt;
 }
 
 int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
-- 
2.25.1

