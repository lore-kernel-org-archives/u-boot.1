Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B8CCF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE6A88DC8;
	Mon, 30 Sep 2024 03:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GzKudl58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3EA888DEA; Mon, 30 Sep 2024 03:50:15 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A8688DC6
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a3445ab7b5so9161785ab.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661011; x=1728265811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggfIB5p2Z65o1SeNhmxaWtT2AOgfse97URRvyaEyZyA=;
 b=GzKudl58yVsljC2VtWPEwDu9Ypy8v7ELlj3BjRkJjtReadRm+7WMG6wN20Lv5BwAeX
 qRF6TGWZ/Wji2kKrpn0yjujXTekUSJo09YY1otFpFhcN+jpvVSr1bDTRUpy72vb2/Ppr
 sE5G1Bau4u6fiypok7fjrCBLyIXSw3bJbG6JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661011; x=1728265811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggfIB5p2Z65o1SeNhmxaWtT2AOgfse97URRvyaEyZyA=;
 b=saz+fzQN7rzRxLu+gSj4D/8A3S8m0nnc1lDZhfDLwiT9B/Vv2RW1eqyYpScM2jeOlO
 9W1FmdU1QEBtcrUbGspgLn0ebp1H4tCmsw5ez+CG8m9Jds6LzelqlbC1MEJu8WGaZlol
 KavijHhcBeRhwWRcK9vzQj30mR2bYr0hG2DoMkDE9+8t8VfowmMwdkoTiTNhgNQcFhK2
 Jbc/FHo9iX3sOoUooGqsftKQn57gv8J1L9cJYBfdfkd2JxSUw9PkpmWN9EGYzOGnoo4X
 jDFaQN+8T1LydFRxlKcLPu4On6Xk4abwZN0wAFwWcpYbR4QMvTEOoX1wWHgC8Q6Pz7OU
 zBgg==
X-Gm-Message-State: AOJu0YyEwPl1orzLeGqVg9Z+nLh6gv9bOYHo1ze2KFMpxV9Dmv+vz739
 NIRo4lsCw1HsTu8aa+foyMJwpQ9OukSS+khmnVYheJc4U6hsNvIhsBAKGZ4DxKfO6OUb81vc3rp
 j3A==
X-Google-Smtp-Source: AGHT+IFF4249TbxgpMrGVJxaeVE/eGeqySGQ7pw9onKeGFTVuGMN3gdp6rmF3j+Ztd8HzPCItqcgmw==
X-Received: by 2002:a05:6e02:1546:b0:3a0:9f36:6bf1 with SMTP id
 e9e14a558f8ab-3a27689e49bmr97433185ab.9.1727661010738; 
 Sun, 29 Sep 2024 18:50:10 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v3 05/33] serial: Make use of the SERIAL define
Date: Sun, 29 Sep 2024 19:49:28 -0600
Message-Id: <20240930014956.1434060-6-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Move earlier in the series

 common/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/common/Makefile b/common/Makefile
index d871113cbb9..c52d4c39f6b 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -65,15 +65,7 @@ obj-$(CONFIG_DDR_SPD) += ddr_spd.o
 obj-$(CONFIG_SPD_EEPROM) += ddr_spd.o
 obj-$(CONFIG_HWCONFIG) += hwconfig.o
 obj-$(CONFIG_BOUNCE_BUFFER) += bouncebuf.o
-ifdef CONFIG_SPL_BUILD
-ifdef CONFIG_TPL_BUILD
-obj-$(CONFIG_TPL_SERIAL) += console.o
-else
-obj-$(CONFIG_SPL_SERIAL) += console.o
-endif
-else
-obj-y += console.o
-endif # CONFIG_SPL_BUILD
+obj-$(CONFIG_$(SPL_TPL_)SERIAL) += console.o
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
-- 
2.34.1

