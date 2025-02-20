Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437C1C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6046810EA;
	Thu, 20 Feb 2025 22:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSg1s8IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5939580F67; Thu, 20 Feb 2025 21:59:17 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6B48001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22185cddbffso37298435ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085153; x=1740689953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSfygOoWFkeAjTsDCix2VfhtAPSIezEqw2RiMU3XzuY=;
 b=oSg1s8IFu1A/YSkeA8dHmtkIxQLjH0qUTkUUTpSGaV0oMplijsvJv3KMODaCYKT2Ji
 8ZWevF5o2ZNzpTyu9fZ9ypxSJl7hDemcLSoAHhemEDZ+h9RVLIqb1PEpkLfUqGh3GyGv
 OcCq5Qu2F8sSlXDftpqoVFhz3dJcI2pZfqJOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085153; x=1740689953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSfygOoWFkeAjTsDCix2VfhtAPSIezEqw2RiMU3XzuY=;
 b=XZxvL5MPN0LONd4y/K2rPmgRmzBDq29o8Zy3kJCZwdTcG8NNkHgtuISwwC/qNUhVCJ
 xAvkRp5VrXWz7cCDW9aTDzgY2wFnx670U7ueliE2FLoyPtl8kMQUIFIErNdvNGyxYgU9
 CQa6rKo82xQJd18L4sxoWZYP+9Ns6rz5QuzZz38Dzow/pLRkYLJyPAE3G5UQFwHkDpSf
 i8cLNzKIYRdhVSaJfupUSKQB5YzJRCfl4eLE4EE/GLs0BglSWFkRDKmW2z0oLavlFL5a
 +LgUFlGyAncyLpjmBSA/b/RGDZYi7q2HyVyQyPDdjuROVKwOcKdXK0n1O6yla11530TP
 30sA==
X-Gm-Message-State: AOJu0YyzmybSUUPrKGSjAsbkJwyfGA42ksM1t5RaMRAhPWFrYB76dMNo
 oMzwGFDe4k3EQTZKF4oi6BDQclhl5iWCkX0DMQPih8eMV+Cn/isfkpO4JWsqQhZScDSBQ6ObBI4
 =
X-Gm-Gg: ASbGnctok7aJW+M1c6udnbhdve3CaXlvijszbR7vVUKMI+WfM3JirNQdJi+XqtHA5MW
 HN3aV5aupb1Rg7iEoWzv/4QqOmgxaq5ELBrWKpq+uPrzipnpSZ51Tj223nuxorP862PJMIdcRNP
 5QeXQG3HSx3TQ0aHL2l/5kbkMs9AjImuUr58wSHUViz9qYUGcX1w22igB5bIDVr1wL8H52lKNXY
 gsmjNjIkB7lYvPX5PfsYn5WWFcg19+dU2jzumyINd24sfBI6fB07mxtMwmGyMU0dN+0rznTe5ME
 Eg3il5U5C5CihPzjQP6p/pye1YWuLIxtGNL+mMnnw58QPFNWBvt5kxk=
X-Google-Smtp-Source: AGHT+IEm9HEU04/U7aLqvUvWU8tXzVg4C7beS+0TNg6XspU5gRlRFPrBl9N0eWekXQtsUJxoA/o02g==
X-Received: by 2002:a05:6a00:1888:b0:730:fb0a:4842 with SMTP id
 d2e1a72fcca58-73425ca1ff1mr880393b3a.9.1740085152320; 
 Thu, 20 Feb 2025 12:59:12 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7324273e30dsm14660158b3a.99.2025.02.20.12.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:12 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 07/12] cmd/cbsysinfo: Allow on ARM as well
Date: Thu, 20 Feb 2025 12:58:49 -0800
Message-ID: <20250220205900.3127680-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

This command isn't x86 specific. Move it up one level so that it can be
used on a platform that can find the coreboot table, i.e. x86 or ARM.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/Kconfig               | 2 +-
 cmd/Makefile              | 1 +
 cmd/{x86 => }/cbsysinfo.c | 0
 cmd/x86/Makefile          | 1 -
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename cmd/{x86 => }/cbsysinfo.c (100%)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 864b6d464ba0..0f456e3b95a2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2898,7 +2898,7 @@ menu "Debug commands"
 
 config CMD_CBSYSINFO
 	bool "cbsysinfo"
-	depends on X86
+	depends on X86 || (ARM && SYS_COREBOOT)
 	default y if SYS_COREBOOT
 	help
 	  This provides information about the coreboot sysinfo table stored in
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb0..2e8034e9c5fd 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CMD_BUTTON) += button.o
 obj-$(CONFIG_CMD_CAT) += cat.o
 obj-$(CONFIG_CMD_CACHE) += cache.o
 obj-$(CONFIG_CMD_CBFS) += cbfs.o
+obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-$(CONFIG_CMD_CEDIT) += cedit.o
 obj-$(CONFIG_CMD_CLK) += clk.o
 obj-$(CONFIG_CMD_CLS) += cls.o
diff --git a/cmd/x86/cbsysinfo.c b/cmd/cbsysinfo.c
similarity index 100%
rename from cmd/x86/cbsysinfo.c
rename to cmd/cbsysinfo.c
diff --git a/cmd/x86/Makefile b/cmd/x86/Makefile
index 5f3f5be2882f..870e941dcf00 100644
--- a/cmd/x86/Makefile
+++ b/cmd/x86/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_CMD_CBSYSINFO) += cbsysinfo.o
 obj-y += cpuid.o msr.o mtrr.o
 obj-$(CONFIG_CMD_CBCMOS) += cbcmos.o
 obj-$(CONFIG_CMD_EXCEPTION) += exception.o
-- 
Sent by a computer, using git, on the internet

