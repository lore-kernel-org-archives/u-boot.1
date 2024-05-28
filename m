Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD43CC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6500388126;
	Tue, 28 May 2024 16:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pcsLSl5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7034787D33; Tue, 28 May 2024 16:19:17 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A98884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-794b10641b9so54334585a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905954; x=1717510754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niF5imNgcGNHMd1+PHLS5q5Yh+S2sHgnGqxqXbWxcb4=;
 b=pcsLSl5ASWjfoR4M0LYjG4udOpMR1sfN0Ib7A0q63hrclpAurqvCpNrl+ZtNVN90p5
 TEJTb4zoh7HSg1TmViKDdHsSohoU/u9+2zjwaGbxZ4YK4XPoD4duDDIQGvDEF0KIb7r3
 38kopWEvFyoHVSjNe5HrPeqeVX24C0Xjq1jA6OPmSI+l1mVbc8wWYNh3eH6JxDil6YZR
 LaBsPX0cJZUa0xEVNB8kPIFHeKnIDSbjDArXV9UWhlDtHN30bcpRI9uS6orLha4pd2qm
 9RXOmWui4uXJqy/kQFARQuMBNi8uaIyPlCbmgatoOiQVGTyeU7Ms3siI+QbKirBacD8b
 u0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905954; x=1717510754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niF5imNgcGNHMd1+PHLS5q5Yh+S2sHgnGqxqXbWxcb4=;
 b=d64BQ+s2UOBeqBs2VyJuuS36IGDqeFYBbEe2PyPlgBGTllTmyVwH2uvEMKb1lThFXK
 jeRzk9i83q4C7jKjBs6mrWMAyAgLaTjMRDPxdYMux6Rv6w7ohn8xu/a/BeQqkUBJcJzM
 lqlhHbOO8tpZr4rxYFZSn41ayKOvr5lNA0M60aKWr1Flkc6ZqcDlJkLNTNwXNMv65YIa
 6gBAiwJfYpldKi1lv9roT61cLXiE77ERfv5GRLt1KRqgB+vX6P061fVU+yUXcBn8d4Iu
 iJc9J95Xi15dkBlq6JDjth7U82oVn6/4rExmGvx2hORYefpPFVaQPMDhSKSJ0S2c5Ucc
 ehzg==
X-Gm-Message-State: AOJu0Ywb8URdfw//trDkIgrLgHhQNLsKyTSFV7piyxdvw7KVNXqpM3P9
 0CmJigaWfg+SqLU/VXgqA5cBRhKpauzLkK1SZILjTb3PMERDFFPeD2Pi9jJjPrH2pSwm9xRASyf
 zFu0=
X-Google-Smtp-Source: AGHT+IGuS/uDf5yrAWtg+4FaUTrFydBvpJQqFDKDXyNGq8vn57w+oqtmcbeQQ66bI+bkfnPkoFwNBQ==
X-Received: by 2002:a05:620a:c46:b0:794:d0d5:e615 with SMTP id
 af79cd13be357-794d0d5edd9mr341921585a.55.1716905954084; 
 Tue, 28 May 2024 07:19:14 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:19:13 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 25/25] configs: enable MbedTLS as default setting
Date: Tue, 28 May 2024 07:09:36 -0700
Message-Id: <20240528140955.1960172-26-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

Enable MbedTLS as default setting for qemu arm64

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- None.

 configs/qemu_arm64_defconfig | 5 +++++
 configs/sandbox_defconfig    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..587a3fb9123 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -67,4 +67,9 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
+# CONFIG_MBEDTLS_LIB_TLS is not set
 CONFIG_TPM=y
+CONFIG_EFI_SECURE_BOOT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5c..6f36fa0ac86 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -343,6 +343,10 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
+# CONFIG_MBEDTLS_LIB_TLS is not set
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

