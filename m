Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF9CC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A53A87F5A;
	Tue, 12 Mar 2024 08:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dNP116/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2B887F4F; Tue, 12 Mar 2024 08:05:09 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5524E86D73
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso4364470a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227098; x=1710831898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG1GC6wxL1x5pDrw/3RIRAEWsrZ0f6+w53DGmTWmTLs=;
 b=dNP116/5adU50f32CDJKfuSJarT+4q8OHrjYxoz6xFSr+2abRhrOnE2qA1A1A9R/uK
 wCUx5xMxar7aF0rCZw6Ayl5/kHHm02SDJMpiQ92EiWTrGcUL9EKN/NgTfReoRJGJvrvx
 xASV51NWmKbvuZLY0A2se8Zayti1ifEYv/ghHVRCQdg6CeGJJF+EgOWBwzSD5mb4N0FG
 ll7pceyEzIWjyfjZy/pknl4GE+CYFYmDd5Z8G4xp/sxmESjZ9MI4A3+JLlB7alJ/cdC2
 VTvRyypGK7nfiz6obUh3cLc2uF5dRUWs+aLkkuK6eUHPBCIU/IlnKpAyn/ba1QrwH34P
 OjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227098; x=1710831898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG1GC6wxL1x5pDrw/3RIRAEWsrZ0f6+w53DGmTWmTLs=;
 b=Tx9S7cBF/Wb3yvLPnp7usTo+Dj+WgNpoKFsgf5OsR4lN61qrcW5yfw6Qk88KCMaiPU
 zoI6mL9xd1UF7ZJtxQUrw4MEprTa9QNoPVRCV8i7C3UA7zpX8wo3k8JFoivYJZkWrus2
 XNAGZl82UItkfJ4+XOAIKRUOantqrWKg99HqnBGjPuWFukfgUw/n8OmQJulGO5bSVI1g
 LPd50x5xXDKPYx967W+oYNVTF8v5q2qje0mYuayvDEd9KV5ODWEt+Rp7BIUzFxwbx31S
 gJSX56WANq0QAqWGKvRavsWLloalssR/aO/O4T+mxO4So7gv+/SUew9CWnepfwSdvwUR
 9zSQ==
X-Gm-Message-State: AOJu0YzltSb/hQkm8HQOt0Py+U5hSFOZ1QjeFAvCxmkvcl3sTKYPIZwS
 wNhkIW5rvwe7k0rG1oreo5qM/SoNxME3SgKQE6MwPwZ3eXtwcV7ykwIZnuCRjlnOxKoakBMAkuu
 3
X-Google-Smtp-Source: AGHT+IF5dYCm/UqgT4JSkJPrDL4fROJv1EVHADlrdLlKyVuf7TR35iMVFw8vZVp683x6SY8uoz9cmw==
X-Received: by 2002:a17:902:e808:b0:1dd:8c28:8a97 with SMTP id
 u8-20020a170902e80800b001dd8c288a97mr10081757plg.6.1710227098437; 
 Tue, 12 Mar 2024 00:04:58 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:58 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 11/11] MAINTAINERS: Add entry for PCIe DWC IMX driver
Date: Tue, 12 Mar 2024 12:33:38 +0530
Message-Id: <20240312070338.86127-12-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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

Add myself as maintainer for PCIe DWC IMX driver support.

Acked-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fbb82b3df5d..e8fd4644fb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1378,6 +1378,12 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	tools/patman/
 
+PCIe DWC IMX
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	drivers/pci/pcie_dw_imx.c
+F:	drivers/phy/phy-imx8m-pcie.c
+
 PCI Endpoint
 M:	Ramon Fried <rfried.dev@gmail.com>
 S:	Maintained
-- 
2.34.1

