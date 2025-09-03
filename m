Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D086ECA1010
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 01:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2F3834E5;
	Thu,  4 Sep 2025 03:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTBRBv/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AFE834EC; Wed,  3 Sep 2025 22:21:16 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41099834AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 22:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b476c67c5easo200065a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756930873; x=1757535673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1kvjhVuLgpPqPrNCE0E0v/q9j0YK+bA3u1dbkcJuXXU=;
 b=CTBRBv/4U2cMcdIBQKr+5GecCbtvdHznwDX8I1QMJ5LO/Xvkmo5qp2z7Gqo+4YKdOx
 XULICT+KVq5lPrg8PmpZgIQvET/xAArHrbGkijktAloSyu0daJ8kT07yabLlXT2y89fZ
 hJkGJyHDsZnkYwF6gmqibFACqx0XVjE+F5rrUM3UlyfMOPWlDMGEca1PkyfD7zx1T6jp
 Ma6wIibJq69zVuU/ENWeBPC0x0k2USfucg+J3ixB+tPzK7UGuEZSwDKZYws9ol101Ani
 Sh8CaTN6mjgybkVP2zgPJSQaHqHEsB39E3OO3sfrj3nzXl3ty3xI7QbJl3IkqP3nxXb0
 qKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756930873; x=1757535673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kvjhVuLgpPqPrNCE0E0v/q9j0YK+bA3u1dbkcJuXXU=;
 b=JwynSo2U66SCeOPIyGTUAsIQ+QK9JQ8pTIO3Wu5JX0OT1H5vAs4VkcIqvV0qjK4X70
 LGGEUdjhAPf9QWf0B4Vqm08KQMA+xE/yznTxLqhKMMiPiQg7bOYQNJnnLodULNS6gXUs
 qcbXmrCOvJkfQu3KG97nDsaGhflaQLbmKReYQnJX8Gqp4l0ZiymERGlVVFodCLs1+VPN
 cObPF3ZzeIoIXe+7ylhKeG8s0wOllkD5znhjXLVnLdjalAGJqY0hJ7Q4cwyqwn+YLEDy
 ddl41s5C5nb3TOFsoLAT/TaqF75piw4svTDaV/4/OHhxq9/8yscGhilIWV6EfpOvoGe+
 pc4Q==
X-Gm-Message-State: AOJu0YxTmcCwFTH19DlsWqCB6jzpP5exxQa8i7RODB60TGRyH8CEPZb5
 /zj0ZcXaiQ4BolWUhbxMo84KZPqELHjGuSWi99kt+ZQ2+sxUrwyiC8DNPwbeXQ==
X-Gm-Gg: ASbGncu5a3Q5XJI7Hfxh/66d2PLeXUwGmoict0sUvZBrRS6zwsAMwfKE9Q3sQSwcyRs
 iXRkIP4I8Ak7Q/vVTCvbfr9KgsJr2c8Koumc86PIiCslsFZIW6IkXBGl0YWf+PGVGuwx70PEfim
 MpWjwADNjBOaNpc0cnWHZJwkI7A/Mrxu3ytxgdtcSJbkXLz+uJ2bAVrz4uvuP5YJajBOLo06gO2
 9gZtdDThgqWYH0oUjtq7yCjs516cgbEL8Ddww/rZdi95QZLm8B+2/mBQnDjSpylSAOYCWNlYQpj
 mCWUfzibmXRk5pU5q5YktqL5w1i6CWIoTh+os7e2xu/zQk8z2fZ16KwiYBoYGqBuor8ke8n1PvQ
 L9wFHqU5hNsxAS1sn6pYNOhDMdH9+
X-Google-Smtp-Source: AGHT+IE2P6m/jebjMIxsYI8Bq9wnujWIOjVBrfJN5GouaJcy4DvaVPS14GgVsLUsaC0NMEnx7Znl7w==
X-Received: by 2002:a17:902:f54f:b0:24c:af27:b71 with SMTP id
 d9443c01a7336-24caf271a3dmr22864335ad.20.1756930872612; 
 Wed, 03 Sep 2025 13:21:12 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:83f7:459f:1fbf:fde9:f614])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32b747c2d66sm1956628a91.28.2025.09.03.13.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 13:21:12 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
Date: Thu,  4 Sep 2025 01:50:42 +0530
Message-ID: <20250903202043.285746-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Sep 2025 03:26:08 +0200
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

Link: https://lore.kernel.org/u-boot/20250829191830.GZ124814@bill-the-cat/

Add documentation for config changes required to enable Falcon SD-FAT boot.

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
Cc: Tom Rini <trini@konsulko.com> 
---

diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 7a3125d705b..587d38d986b 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -354,6 +354,16 @@ first.
 Falcon Mode: FAT SD cards
 -------------------------
 
+Compile with additional changes in config variables in menuconfig:
+
+::
+
+   CONFIG_SPL_LEGACY_IMAGE_FORMAT=y # to support non-FIT images
+   CONFIG_LEGACY_IMAGE_FORMAT=y # if commented then SPL Legacy support stops
+   # CONFIG_SPL_ENV_IS_NOWHERE is not set
+   CONFIG_SPL_ENV_IS_IN_FAT=y
+
+
 In this case the additional file is written to the filesystem.  In this
 example we assume that the uImage and device tree to be used are already on
 the FAT filesystem (only the uImage MUST be for this to function
-- 
2.47.2

