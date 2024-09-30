Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BCCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C3F88E1C;
	Mon, 30 Sep 2024 03:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hMkU5hRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAC988D9C; Mon, 30 Sep 2024 03:50:18 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D03688D9B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-82cd93a6617so153151339f.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661015; x=1728265815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRTeZP9TMaov+zTWAcge6tU8S67wWX9qBgffb7szHyU=;
 b=hMkU5hRtBm9Qx2zS94qgQgb+6T+PN8TWIBo1kg4X8RIVk/17tCzUjQZ0G+jTeYyXoS
 6Zw222cedu4iwZUGMzu3h/lIxNZRq+RFYY4tKCj0BSlhBsT6Bub+Au7gVbIp462QdYf1
 4Jlmi7svWo6K0g4OOn8WiUDg35ClvlIb9wDg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661015; x=1728265815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRTeZP9TMaov+zTWAcge6tU8S67wWX9qBgffb7szHyU=;
 b=Q0uKgDdHEfWDeXnj61ajpvRVUD471wiJtkGffJrBJcNvM9aiVmyV6e8eo/iJhpPF7b
 Tq/xYhlN1BtovT3t5jbOsifkITZori8o5lVUnDJXgDkHsqXIblqqJlL4AKkR/wTOr3MN
 d3Ru/4eSN93sjYjlQ966lo+jiJD8pdBtXRCUTXgFXVraTFk5TbQCYkvXwCq7nPtyza4D
 yozotahH+L71b5RcLqmFHp5wrIRxylrhWtj778/3ht5NadEQ+4ETf3aalzcn0rxvrN2+
 2QESUFFRrcIFzLzHam2KzI6Ja+ofiY9oKxdvW5yozmUh26LDnKSJY2cARUmJkF4L0JS2
 PR8A==
X-Gm-Message-State: AOJu0YzeamDDrKNnjcXYTSqPinVQdrJX/b2l17RlB8Is3ITb3b4cPAO4
 shgs6QhQO3zwVDnXOseBMFE6VRcArzQ4/10xp23NKhwhp+cgp5r514dLWxEwFVOTnexoC1VHIen
 2GwFP
X-Google-Smtp-Source: AGHT+IFQgbngDjK5T8SKmIJOxyXM63jgTufiQ5T3VQLGmsWDm+8ZthHW7b6c3xPARozVAfl6wY5r9g==
X-Received: by 2002:a05:6e02:184d:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a345155676mr71763525ab.3.1727661014799; 
 Sun, 29 Sep 2024 18:50:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 08/33] scripts: Add some comments about autoconf.mk
Date: Sun, 29 Sep 2024 19:49:31 -0600
Message-Id: <20240930014956.1434060-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Now that the conversion of all CONFIG options to Kconfig is complete,
these files only contain the xPL_BUILD defines. Add a comment to make
this clear.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/Makefile.xpl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 1868f1beef6..3091311a3d2 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -20,6 +20,12 @@ _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
 include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
+
+# This file contains 0, 1 or 2 lines
+# It is empty for U-Boot proper (where $(obj) is empty)
+# For any xPL build it contains CONFIG_SPL_BUILD=y
+# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
+# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
 
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
-- 
2.34.1

