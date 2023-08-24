Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1937C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BAB86A7F;
	Thu, 24 Aug 2023 21:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8yOhwHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAC086989; Thu, 24 Aug 2023 21:59:38 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6B5868B8
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso2218039f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907173; x=1693511973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9peYQf4lvqShlPRku1svIkliOeLwYisjboIpvNOgtg=;
 b=e8yOhwHZd65UTh706ZL27ngnLwORyhRqlD12CTDuTkQ6ogK7twfW8ssl0oSU9zZEuf
 DdPPe12Wts61gdSaoifXipSnewlA5wWzCKRgPb/364JaKJjbov1x/pTfyuEUe2q+QAA1
 SY1T/j1e3ZS3FumZHi4H8046+6P5SOYBPMcFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907173; x=1693511973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9peYQf4lvqShlPRku1svIkliOeLwYisjboIpvNOgtg=;
 b=h1n7iBAoY8ZOeZYF2dvWwAaCTd051vs31ObkccoIouF3rKHgzA0yjIjdawRLDqBFkf
 GNGzKJd4up7vnrPWdLjQ4Kx7y3p4alIGWbUfUZYF6B4mEk9Nra92LXBPz+HcVb1BEoq7
 2n0F4yCgPA//D+GEaENpTScIAKzdj2LY7qE5BNdB4vi5fTfCrFyo8uLMvnbRxDaEXpc6
 mEmLjbgINnmyYQ8egq94U5Gh1zH6bB/w1+ooKB/TgkpWKfiN0/fIW9drMgzyGxpGeizT
 LFrO6EndiMuHhStuZITnNs53RpXPzClGUpDHe0EtIJvVvaLGmamsuG26H/32VaZv4x+l
 UOZg==
X-Gm-Message-State: AOJu0YyUAswPLg1Q0EgWpJtiulw6csfOkqWLi8Nqum/NZSs+VPOZrMBY
 +ULg52Tr3EINS94cjsVtXHGT93FB3nVnOehBrx8=
X-Google-Smtp-Source: AGHT+IEzwZbpQDl9bPTUYCSV1AFFIK5xGqIswBZ4w1DYjPUdDmkV4uPOEOQ/fUEXU04ZPRb1soXKMA==
X-Received: by 2002:a5e:c003:0:b0:790:8665:d9e2 with SMTP id
 u3-20020a5ec003000000b007908665d9e2mr6824539iol.19.1692907173046; 
 Thu, 24 Aug 2023 12:59:33 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 06/19] FMU: Avoid showing an unselectable menu option
Date: Thu, 24 Aug 2023 13:58:57 -0600
Message-ID: <20230824195917.1687886-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

Use a menuconfig to avoid showing a menu which cannot be selected in many
cases.

This option should really go with the other 'Update support'.

Perhaps we should even consider a top-level update/ directory?

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Kconfig             | 4 ----
 lib/fwu_updates/Kconfig | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9addcfab3734..bfab2f3165a7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1118,8 +1118,4 @@ config PHANDLE_CHECK_SEQ
 
 endmenu
 
-menu "FWU Multi Bank Updates"
-
 source lib/fwu_updates/Kconfig
-
-endmenu
diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index 71f34793d926..be35ad29fa32 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -1,4 +1,4 @@
-config FWU_MULTI_BANK_UPDATE
+menuconfig FWU_MULTI_BANK_UPDATE
 	bool "Enable FWU Multi Bank Update Feature"
 	depends on EFI_CAPSULE_ON_DISK
 	select PARTITION_TYPE_GUID
@@ -10,6 +10,8 @@ config FWU_MULTI_BANK_UPDATE
 	  multiple banks(copies) of the firmware images. One of the
 	  bank is selected for updating all the firmware components
 
+if FWU_MULTI_BANK_UPDATE
+
 config FWU_NUM_BANKS
 	int "Number of Banks defined by the platform"
 	depends on FWU_MULTI_BANK_UPDATE
@@ -31,3 +33,5 @@ config FWU_TRIAL_STATE_CNT
 	  With FWU Multi Bank Update feature enabled, number of times
 	  the platform is allowed to boot in Trial State after an
 	  update.
+
+endif
-- 
2.42.0.rc1.204.g551eb34607-goog

