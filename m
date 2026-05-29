Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681BCD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75BD84671;
	Fri, 29 May 2026 17:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J++4geaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCD5846A3; Fri, 29 May 2026 17:32:06 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6157844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so677496f8f.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1780068723; x=1780673523;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BvPUaocj4W93q002AO9ZwxAvPoQNnuh8ucgFSanrbu8=;
 b=J++4geaX2wYGmZ/aRELo0UEdzF+CWp5cOhOPXaHr5nxBMyyf26kdEHnGvhvnTVWqsV
 k+dYWmhta8r1eSVjAsM1LmJ8N7KYuHtNYPLsG1f29C0/bYwhGqjnUM356VdruTtPJJFx
 CU7Q3hPO4sWUdX8Qund24/ZGveqOagTPtI4y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068723; x=1780673523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvPUaocj4W93q002AO9ZwxAvPoQNnuh8ucgFSanrbu8=;
 b=PuiDQ7e7UfmcrmeL38CJ1r2GLRULqRAx3YFvdoGoG4v/rJDcY/9qDUUNZZtwPRdmh7
 GCyoY/+vKJFdYJfm9E5bhUTOtkvui3pMgOaPHCJvVaod3KitWkgoQFji4RWTRVKOMTXb
 5HfE4RYvQz+gKWXar41xiRkSewo9jvtkZ9iJbOuSYWX2D3SpfYsKQujmFho91pbvVOt4
 SxrBCQdQckOFtTy1pwoYtGbeXO4BrEBaLxIeZSlnSuhbEPgLQLEBu7x2aSGscvYnZA89
 PFoeav1CIxkbp01QdZOk17jwxEt4YK1Pk0x7mLRB1pfH4lFwf2NPB5iQWg6AEpNGlMSh
 kI3w==
X-Gm-Message-State: AOJu0YwRSJDvrTWHcm5kKJ7Y7JCzIiBvEFd+0KXFrG8i8JM8fKguuVY3
 +Ry6x14VmCXsYhQN+dy+X02XWPivRTH2f4DfAPyRJ2pxs6HaTWAGJXqgIvz6wFDYV/W3CwWHNtz
 se0zL
X-Gm-Gg: Acq92OHWT6ZhIuiVivBXAjITGHS6PwYxEkTt0EyTSj8v8PNGXQaBoI/5CTOewyYm4wy
 W0ioHPlAWgP261u+sh+QomlcsasWs1QfX5dnGqBUQCnp4sqmz4iil1zr8Mu0M0XSKvDmzKs1gN4
 owzJcNnWTCrFQmgFIeUn3ZCP7cyacYf70LTqIYs+RUPmZk7qrIZFqgT9EbEqFEC0PLn+Rbw+BP/
 b/CXsoD6iOLh/zUOXWLbDU7E3G8XlLElmHAF7ebwCRYdQ8rXCfjTxRCC8rmyRPNQolv1XwjzCK0
 12fI+IvcfLgC2GH/ecHkDKVjZBUOk21hGAhPRViei8QjHhN0MZKNJoN1AYWkpwBOSBpjfc02zzG
 ZYVQWSgMsS2w7gyTNe/QDY1AZ5LkVVsKkgLIxL/oLE48PLUNa6uGAWxi5Fsu/U+mKsp6ac6xA2w
 D5ENWwXwjcy3Jzma7cFvPxFlhwuf7/8on7uKuSWMqm3vYIH0ES+zLH6ArAS0fJ5Ii/ov4AzrPyq
 vc7LvzFf0fUAiw9rpGTSFj7VdySE/p9dSeOLN4L8g2I+tqoJsqpDfpIroM=
X-Received: by 2002:a05:600c:4755:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-490a29335camr1903265e9.22.1780068723186; 
 Fri, 29 May 2026 08:32:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09ab75sm16713855e9.6.2026.05.29.08.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:32:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ARM: dts: stm32: add U-Boot specific dtsi for
 stm32mp157f-dk2
Date: Fri, 29 May 2026 17:31:54 +0200
Message-ID: <20260529153159.3944049-1-dario.binacchi@amarulasolutions.com>
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

The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
STM32MP15 RevZ cut which is the only one available for new product now.
The major differences in this 'F' variant SoC are the increased max
frequency of the Cortex-A7 cores and the correction of some HW bugs
(Device Rev.Z, see errata ES0438)".

On the software/architecture side, this variant utilizes SCMI (System
Control and Management Interface) for secure world resource management.
As a consequence, the underlying stm32mp15-scmi.dtsi explicitly deletes
several fixed clock nodes (such as clk_hse, clk_hsi, clk_lse, clk_lsi,
and clk_csi), making it impossible to include stm32mp157c-dk2-u-boot.dtsi
without triggering compilation errors due to these missing clock labels.

So let's introduce a dedicated stm32mp157f-dk2-u-boot.dtsi that directly
defines the fwu-mdata node. This provides the necessary FWU metadata
configuration required to allow automatic A/B bank selection, supported
for STM32MP15 boards by commit 560d8f32703f ("board: st: stm32mp15:
support dynamic A/B bank bootup").

[1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop the inclusion of stm32mp157c-dk2-u-boot.dtsi to avoid compilation
  errors caused by deleted clock nodes in stm32mp15-scmi.dtsi.
- Directly define the fwu-mdata node in stm32mp157f-dk2-u-boot.dtsi to
  properly support automatic A/B bank selection.

 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi

diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
new file mode 100644
index 000000000000..77805417bfa9
--- /dev/null
+++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+/ {
+	fwu-mdata {
+		compatible = "u-boot,fwu-mdata-gpt";
+		fwu-mdata-store = <&sdmmc1>;
+	};
+};
-- 
2.43.0

base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
branch: stm32mp157f-dk2-u-boot
