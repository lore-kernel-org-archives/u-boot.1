Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D713C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB40C8863C;
	Thu,  1 Aug 2024 07:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cDPZrHNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB5B88ACA; Thu,  1 Aug 2024 07:33:45 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0F388A9B
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59f9f59b827so9641976a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722490421; x=1723095221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siDGD527myJBJ/mJBS46QFP8C/jqB6HD7sA4jdUzJF8=;
 b=cDPZrHNt32SGFCxRnHe/tnzVzN2OvhFsbvix/C0Y98IYRLGqGr943RNjmwa1Gdjhnl
 JQyQYIdvmhHW4ChxqMEonQzi6wKJdHIulPBawtCjJgA1+aMjI9050DSgj4QNt8BlYpDD
 cMjuYYei7ToyW+At1iqnA4hikcetx4387DDKiHX8wyJpl3L91lK61VwvspEWFh4Gp/BS
 LLkgixYZ/40JyYwgZJg6MBbFuhoG0J04FzT0eutXPPDrciESrOKppb4His73Srr0KPTR
 ij+6AeUmfCo9ZAbVwknnjreAU9tpV2q1xKyAsPZOQM07VwI5YCQUKeKYJMS2cJ+J7TXb
 noGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490421; x=1723095221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siDGD527myJBJ/mJBS46QFP8C/jqB6HD7sA4jdUzJF8=;
 b=l7u+HN9bKpBlVpVLmjIJL5onOXe0j1dL3Z0MjFTXea7CKRJFv55PBz+E+C2PzGuZ9/
 OnVMNrnnUyz/xm1lA/ALoXmbzG/GBxXQTiXMgG+XkhqZZYLLphTZOi/JgIJauzPDTUXx
 ZylYrSehx1pMVlXk1L8J+ElBBuiG0Y/MxI988Jpe1uSTl4rFvo2hyAsvAuhF7speYcel
 vA3HfJ0IxdATxRMwOXfYQ8ypq5iqZb87LCuAfS8FxYdqZbENLUxTYsTr2Pog4bxyNx9C
 dHQxd/JxNfpkj+tTmKkjLXpHc1pHSkcFVBPc21c+qPrMCwYsUBVNZ3eFPKqZJkGE6qDy
 l79A==
X-Gm-Message-State: AOJu0YxGnxwhVyzACetd6mkltIlNEsavanC+/iCoa2ZiKPd9YnsWf9mr
 BCZ/C0XeD189sUjz/BC8eZEq6wiXEcPt2J1YdylKQPMPXTXXA6Ld
X-Google-Smtp-Source: AGHT+IELnM6eIIDMtTmlKUrnvzR/gy0yM0dQkHFLZchG7oUde8IUMZy3k8ra16oMfJU5tysPJZtygg==
X-Received: by 2002:aa7:de90:0:b0:5a3:3062:36c7 with SMTP id
 4fb4d7f45d1cf-5b6feb13eb2mr691648a12.7.1722490421300; 
 Wed, 31 Jul 2024 22:33:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3a95sm9477990a12.61.2024.07.31.22.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:33:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] video: tegra20: dc: remove DECLARE_GLOBAL_DATA_PTR use
Date: Thu,  1 Aug 2024 08:33:13 +0300
Message-ID: <20240801053315.6428-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801053315.6428-1-clamor95@gmail.com>
References: <20240801053315.6428-1-clamor95@gmail.com>
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

It seems that DECLARE_GLOBAL_DATA_PTR use is not needed and video system
works perfectly fine without it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index accabbf4db..d24aa375b3 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -26,8 +26,6 @@
 
 #include "tegra-dc.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* Holder of Tegra per-SOC DC differences */
 struct tegra_dc_soc_info {
 	bool has_timer;
-- 
2.43.0

