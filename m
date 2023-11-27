Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946ADC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD19E8755B;
	Mon, 27 Nov 2023 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tMXqnU+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C2C87555; Mon, 27 Nov 2023 14:00:15 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E6887515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50baa7cdf6dso2394495e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090011; x=1701694811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idnSNrXcXTaTJVqLIsV71wx0ovIvLLqaLRJmXzFx1Zc=;
 b=tMXqnU+uKUT7esZwaQqCFRm686Bx4d+BvupciH2DpnB1hmCHG5xA89CKV/cXP4Nxpb
 3dWPJXVEN/7GSXYTPFdADnoCtQt0qdn3Wh0Rczy0sVwulMY1s/iRgZtApPS3X2E68fkc
 mfulI64IQb/URw1e/QcIe813f8J8woTaQCkQfZcgfEFGfo3vzVyqDxfTk4kKO3HRHcvs
 Buv2bXk8P7+08838bltQVS1oo4JZCv4YZLDCJH17TfTpDjvC68F1y8AiX9S6UqzH8klY
 M2M8fTulxe8NJyFwsupeDyA4uKvfJiDVavIgKIhn/fKRkLaXY89n72xjgRe+Xe1K3F8F
 IJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090011; x=1701694811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idnSNrXcXTaTJVqLIsV71wx0ovIvLLqaLRJmXzFx1Zc=;
 b=RAHlLRb/O/0cGBEu1s7xfhFUjVb3aDRrDwxE+Hu/LtS+hbfApOWt02jmbU2KYHCFFt
 kmHQMGeCawrb6fUrROrvZ7RkUFOkPj507ffd+UNRTDFw0WobKhucy8eCL/Og65nssrwT
 wl4AG029H8YHDASBykrJDtJ0YTDqSyp6X5eD/K2vaBUUixW6KXmDvwheafO9Cn/UpaUM
 OQIXutYtt53HFe+wAY/n5D4DaW0ln5SDwnIqGV13yukrvyw8AUv3r9alJLrfuuORn4p9
 Af3E2K1Fqws0c8sCvj3BbxyaQ6220rPWcbbwZacSZdZ7upz9Plhlr3wUh58Xioz2DVBP
 m32Q==
X-Gm-Message-State: AOJu0Yy2t/0VaNTkPda8uiJE1KcQzKK3MTqeIct48n76J4NlQ9O3def5
 KMRwYxqEDEO+Df75QaWtW5pKx3PaHm/yAzNKXFiNpg==
X-Google-Smtp-Source: AGHT+IGV2ebJqVQnQESD9GhBu87VJUvv8fWw68PY4gh3EKWCQgwzYQkvHmvDI2/hPz6y0SL+/1uwlA==
X-Received: by 2002:a05:6512:3d91:b0:50a:a6e2:ae73 with SMTP id
 k17-20020a0565123d9100b0050aa6e2ae73mr5442121lfv.44.1701090010803; 
 Mon, 27 Nov 2023 05:00:10 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:10 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 01/43] submodule: add lwIP as git submodule
Date: Mon, 27 Nov 2023 18:56:44 +0600
Message-Id: <20231127125726.3735-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

add external lwIP library as a git submodule.
Use STABLE-2_2_0_RELEASE tag.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 .gitmodules            | 4 ++++
 Makefile               | 8 +++++++-
 net/lwip/lwip-external | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 .gitmodules
 create mode 160000 net/lwip/lwip-external

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..7930a8b563
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "lwip"]
+	path = net/lwip/lwip-external
+	url = https://git.savannah.nongnu.org/git/lwip.git
+	branch = master
diff --git a/Makefile b/Makefile
index 08604ed3c7..132a60575a 100644
--- a/Makefile
+++ b/Makefile
@@ -1872,6 +1872,12 @@ endef
 include/config/uboot.release: include/config/auto.conf FORCE
 	$(call filechk,uboot.release)
 
+initsubmodules:
+	(cd $(srctree) && \
+	if [ ! -f $(srctree)/net/lwip/lwip-external/README ]; then \
+	flock `git rev-parse --git-dir`/config git submodule init && \
+	flock `git rev-parse --git-dir`/config git submodule update; \
+	fi; )
 
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
@@ -1896,7 +1902,7 @@ ifneq ($(KBUILD_SRC),)
 endif
 
 # prepare2 creates a makefile if using a separate output directory
-prepare2: prepare3 outputmakefile cfg
+prepare2: prepare3 outputmakefile cfg initsubmodules
 
 prepare1: prepare2 $(version_h) $(timestamp_h) $(dt_h) $(env_h) \
                    include/config/auto.conf
diff --git a/net/lwip/lwip-external b/net/lwip/lwip-external
new file mode 160000
index 0000000000..0a0452b2c3
--- /dev/null
+++ b/net/lwip/lwip-external
@@ -0,0 +1 @@
+Subproject commit 0a0452b2c39bdd91e252aef045c115f88f6ca773
-- 
2.30.2

