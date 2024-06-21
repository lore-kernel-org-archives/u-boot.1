Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B8FC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853E3884FF;
	Fri, 21 Jun 2024 22:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jn1ooAsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9540988059; Fri, 21 Jun 2024 22:46:44 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE678845A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eb895539e3so94105639f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002801; x=1719607601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNrnuY9yrBYlnFhzQC8UMGqRbSpLi2JGWWqh3sxbDgE=;
 b=jn1ooAsfy3xGYHz2ENYlCxjPRKu/pubrTjrN50EbyPVlysGGCVB6NG1FPFiv+LW3DK
 IoLwuaw2gTKEMUr5KyKa5IP4OsxL3Xu/Tf88VCEYcqsx+wMqcXetdkr6ISoXx+xa/dpu
 D1Nrt0tKB8C9PJpXp80E/vPDuufsljZ00f+Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002801; x=1719607601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNrnuY9yrBYlnFhzQC8UMGqRbSpLi2JGWWqh3sxbDgE=;
 b=e8YM87PL9MmMXDSvcNg8NqgWDNvBXso/MP5/RjZ6oKd0kNw0k/uaCqrt7FnOLbSva5
 mk1pO4k+5We7E4DVK7z8bHdWQg5wcQUQbMU6CnpFynAouviX15ufVCBT2btIKRHhLYOY
 /vOy9bXt2hYp1OCAGrfloWILhT0Fr5M37awbOxt6pVEzMqrQVMiGqgfomYdsDyh0HcmE
 bJXccj5LSBYHV6YemNzjY8NL51w9ysyOa0nTwGrXZ9vx9/OmYvneuW9NyF55GiVBzA0Y
 /P78fRkw5ic+jkGM/5a8ZTwK1c3/5BY0bKDc0AaK2vjzbItD1sluYkTifsEnp2X/N6ZD
 WJ6w==
X-Gm-Message-State: AOJu0YxPlUZpcLDZ1bCHjMWusb7N7pZLdOyLUMmRM9j0tpAd59mMou/A
 sJ45A2p6gT1ZsdtLHrwULUCXTTblKrreeehs7P1mOPt9vXbfak0t9p0M7JkZg0V7IG1sASkCLCV
 auw==
X-Google-Smtp-Source: AGHT+IElFlRKmNHeIxXI4O74j575WWC0LLSCzDyAVlf66jHDwChDHMAAbuwtHr9IxkVW2H/S5y1vRQ==
X-Received: by 2002:a05:6602:6c10:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-7f13edb2453mr1153547639f.2.1719002801140; 
 Fri, 21 Jun 2024 13:46:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 02/11] binman: Regenerate nxp docs
Date: Fri, 21 Jun 2024 14:46:23 -0600
Message-Id: <20240621204632.2706813-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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

Regenerate the entries.rst file to include this recent addition.

Note that more docs are needed here, to actually describe the entry
type.

Note also that the entry type needs Binman tests added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index dc42a9cb97d..1b9b868e33f 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1521,6 +1521,28 @@ byte.
 
 
 
+.. _etype_nxp_imx8mcst:
+
+Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
+-----------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,loader-address - loader address (SPL text base)
+
+
+
+.. _etype_nxp_imx8mimage:
+
+Entry: nxp-imx8mimage: NXP i.MX8M imx8mimage .cfg file generator and mkimage invoker
+------------------------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,boot-from - device to boot from (e.g. 'sd')
+    - nxp,loader-address - loader address (SPL text base)
+    - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
-- 
2.34.1

