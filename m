Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AFCE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5127E86DAD;
	Tue, 26 Sep 2023 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/Hvb10l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3505E86E14; Tue, 26 Sep 2023 16:15:47 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24A586DEE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so7377339f.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737735; x=1696342535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpG1we+vFirVD7dtLc95+wpeHQ5VCSTqQp1moM56A4E=;
 b=I/Hvb10l3C+WYnlmCIl7v07mAuBo4q1r87MmLbaWDJVX4tVBWLI94oJsXaLshXtNWl
 YDPyCTJCo359AHefxx1xj4/+gNJd4FQqtRADW7nh5x76an4E64Z/Z6eyklg9qm3BA1sv
 rkdtPM+ObTt5kexrFvv89WpodQSwVFbpTn3n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737735; x=1696342535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpG1we+vFirVD7dtLc95+wpeHQ5VCSTqQp1moM56A4E=;
 b=peeJ9vXzrnA2SubDtf+7uTgMdGDghGc4m4zFs3DPHnf2vlebOg3DFVdCQVooWOO1s8
 +Ix9tYS16tE7S2GThDqoS1PR4oCr3AWTR4guOd3NP/V9+fwxHJP8yqTOIhK3IkWuOjdI
 40Mn512Thfm2W4W3vapN/hZWSU3flgF3qWSZ+Z9+Jp6uBjbiZUIZC+0A/ZR5ymGvjDCJ
 WA03nEL14i9Sgv9d9GheKZ2VNeapI7wKPKrTU+9z8O1qTJuH3K5d27bT/BmR5bRpVuIN
 J+6G+EtrUfs82RIAelyNvFabLs9jLeYQ5HeW+s+cb8AmN594WMIrogZud1c3fV5Llkk5
 fjtg==
X-Gm-Message-State: AOJu0Yy5J26uJpxB40mRCZi/owwJ314g44ryJv1/zD4txBPsSsvcvys9
 Hjcl0ottZQPnzvMBNA5FB46swiz4GljxpiLwGO8=
X-Google-Smtp-Source: AGHT+IHkJJVy7sTkiVzsu6kxnyhPb/tOPUr8P4YWKBmrrw+k8mPbRw9adnEYNBKW39zOnQsgPk6k2g==
X-Received: by 2002:a5e:9419:0:b0:792:70c2:9db1 with SMTP id
 q25-20020a5e9419000000b0079270c29db1mr10577407ioj.1.1695737735625; 
 Tue, 26 Sep 2023 07:15:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 12/44] tpl: Enable CONFIG_TPL_SYS_MALLOC_F where needed
Date: Tue, 26 Sep 2023 08:14:26 -0600
Message-ID: <20230926141514.2101787-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Enable CONFIG_TPL_SYS_MALLOC_F for boards which have a non-zero value
for CONFIG_TPL_SYS_MALLOC_F_LEN

Note that the default is yes in most cases, so no changes are needed to
board defconfig options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to nable CONFIG_TPL_SYS_MALLOC_F where needed

 arch/arm/mach-rockchip/rv1126/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 7382c5599661..a6e2b5903c67 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -42,6 +42,9 @@ config TPL_LDSCRIPT
 config TPL_STACK
         default 0xff718000
 
+config TPL_SYS_MALLOC_F
+	default y
+
 config TPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
-- 
2.42.0.515.g380fc7ccd1-goog

