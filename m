Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37ECC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4720874EA;
	Fri, 17 Nov 2023 23:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qu21UA1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19D9874A3; Fri, 17 Nov 2023 23:53:21 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5417E86ECA
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d0760cd20so21427036d6.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700261594; x=1700866394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H/EFh44Yvd+naarztA3lFz/ozKgCpggYElrXW6ZoRx4=;
 b=Qu21UA1XmPy1wzz1kGxWmnFlhMcLGPCEx3k758bgXoJpzYLDF4MsUmyTToF58T7qsJ
 APMY8ngU2dnSSGHPDm6I7LRk4oyzCf/Q5YBf7t8K2SokbkFZZueZ77orWvk1D3J4hYKL
 UMfWtoXVwXCC2T44Xha3KQru8Geys8waf20Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700261594; x=1700866394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/EFh44Yvd+naarztA3lFz/ozKgCpggYElrXW6ZoRx4=;
 b=OAyD7QXpsUYGDsH60jVufLC285hA2i4fTJvrsHySxt/2LTCSL7w2npcfgL6I+tONHI
 FTj+plvQsd+rDTApOSIlv5gIPP6ye1DP9U4F7x6td8GlpW/RlUhILwsJ322OrSOj9aLX
 4iSKyAbWJ3WEwjnZixBs8GzcePuTXOcPAXOrN11UPPFLh/QEg8FV7iICcrVOS2xs7Neh
 96ey2anyGDseH90sK860wMUA4rPSj57U01sTQggum05x00ZyLcsruyzy6ZP0mlqvKQh4
 /1qVHfmhSH7bpvqEXf5DMmzUi2tm4ShVuK337j+5X3MhcJ2LO4ayD0lHrozr3xf+CKrg
 hLdg==
X-Gm-Message-State: AOJu0Yw7cwuf+eThL/bbxj+l/LBaNghTDWaJun6lD6QyZt6VTw5YQ9pY
 vhpA9jsd+82eHJ2ZAZ+qxQ8glpKn1jDu2+6ALjpBcA==
X-Google-Smtp-Source: AGHT+IFrGthmlZd1tYc4ZA3KxwovSsD3obFqN9LC0ZWwIQ60TJJ9EGiehEXN+3C7a43oQGxnXmiMgQ==
X-Received: by 2002:ad4:596a:0:b0:66d:5a3a:c5e6 with SMTP id
 eq10-20020ad4596a000000b0066d5a3ac5e6mr736463qvb.18.1700261594734; 
 Fri, 17 Nov 2023 14:53:14 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0065b08bb01afsm961084qvs.124.2023.11.17.14.53.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:53:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] qe: Add <config.h> to linux/immap_qe.h
Date: Fri, 17 Nov 2023 17:53:09 -0500
Message-Id: <20231117225313.2144665-1-trini@konsulko.com>
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

