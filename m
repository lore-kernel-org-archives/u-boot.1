Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E4C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88AC87B4C;
	Thu, 14 Dec 2023 19:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MdWKENCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F256687B60; Thu, 14 Dec 2023 19:17:03 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863BE87B4C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e25d1d189eso8131927b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702577820; x=1703182620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4FSaWL+w7GAFox6pRmc00WNVEqdJBijpJ60CeIYOj88=;
 b=MdWKENCiFzFqA93LWdtAPA2eo2CyJGXC2QvhXn6g0h97eeJJEIZDQFh6QB00oSZaHd
 D5ngukeUAPfhFvikIJ5Oa60BF/I/e5Pr8busbrJl3idoKI0pw9SuQfjek89HGn8JFi1m
 0tQt5r2ILsLCywnDLn29O9b949F4tOpp9ws40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577820; x=1703182620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4FSaWL+w7GAFox6pRmc00WNVEqdJBijpJ60CeIYOj88=;
 b=ZT4KjVuxLr7PcYpcgXxv0pzVU2zCsiMQkLKNoo3xuMaMxNd3uJdR6i+QpUykRE8JsL
 2a6oDeyKFW6Xd/toXGG7nkkU1oDLeINgC60oqOhb9bSgI8EzeYZS+mG/8nAV7gBfnm0T
 J/pcQf0hl9/HX+QjloKEMivO5FGrAYR28gkuQhCewzunZdeWbR1P8EcnipKKi2wz7boR
 FaLe17/eTWJyuGDn6ucO8RfMAaB1Qv5hWS7HtaqZIdy57adeo5SWWo/Pzv2CyODCoWtp
 GRlNNA3v2JshGI399eF/6iUzLyVLYyPF4OJnmot+SedqMB5QgjPj4dNK8HaoVXsrE2Ah
 rPew==
X-Gm-Message-State: AOJu0YypTai1nFRphkKfgg/KqrIxhwC/ps1Fu25WoeEoW8/TwpHtencC
 YY15+P95zjZHdMg3xK5+5gqJvmSJ+pyaIXuivcc=
X-Google-Smtp-Source: AGHT+IGQnkYLcsGIlrwJcTXgdo0uriGi3dv1q5Sm4a5skZmi1liRyMTXoxr/5flpJ4OGYjB55fswdQ==
X-Received: by 2002:a0d:df41:0:b0:5e2:8830:7261 with SMTP id
 i62-20020a0ddf41000000b005e288307261mr2675855ywe.0.1702577819559; 
 Thu, 14 Dec 2023 10:16:59 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a0dd087000000b005d361dd6454sm5665698ywd.87.2023.12.14.10.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 10:16:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v2 01/16] qe: Add <config.h> to linux/immap_qe.h
Date: Thu, 14 Dec 2023 13:16:43 -0500
Message-Id: <20231214181658.3359902-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Given how we define QE_MURAM_SIZE today, this header needs to have
<config.h> added to it.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/linux/immap_qe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/immap_qe.h b/include/linux/immap_qe.h
index 45307f51c103..a692f5dfb373 100644
--- a/include/linux/immap_qe.h
+++ b/include/linux/immap_qe.h
@@ -11,6 +11,8 @@
 #ifndef __IMMAP_QE_H__
 #define __IMMAP_QE_H__
 
+#include <config.h>
+
 #ifdef CONFIG_MPC83xx
 #if defined(CONFIG_ARCH_MPC8360)
 #define QE_MURAM_SIZE		0xc000UL
-- 
2.34.1

