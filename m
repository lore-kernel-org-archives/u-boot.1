Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90572C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA68188416;
	Sat, 27 Apr 2024 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MArFSnER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F402088418; Sat, 27 Apr 2024 16:11:17 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD788827F
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78edc3ad5fdso274571785a.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227074; x=1714831874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BXP0Ke+96v/N6rBhEfdSVw+/d2sIywLHK3q3sl94YUM=;
 b=MArFSnERy8KX53PHHKTzBVjA50dEyHQtXTic3BJzsiANCtCY8/FsV9TI2LWsJOAj7M
 zEQfnwgLeXHTUkupWyoVNEnd/QuS7BIOChtUZMB9XEhl814GxIMubej/HOnZrgH+la6T
 SCofvxFdMGubHd0ZG4pjXEO7FVPdy9/A1cD24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227074; x=1714831874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXP0Ke+96v/N6rBhEfdSVw+/d2sIywLHK3q3sl94YUM=;
 b=lmUEerbwq9nrFrb+fQjN3PrKc+rnQ2aobP6vpDpUYHP6E4a35PLrgYexdv8FGrUwkn
 Hm8cyB+PfFnvlFM7sxI2i8tLkL8DenHR/ylYYO1XkiKdHTSaNaydJg/7eyDrOb5VinTU
 s2ksYbRYh8POVXDi9LGov5a71NQpuhxkhAiDIt2pWiRruJrVG7HLeOFPMjdnvMJ6U69t
 DuZhdYsBuuzn94tRwWp0p/XlC2LE15/Vkd30dmdAUXEkNTGDYMGe4Rs8nS0s0I69L3b1
 aMzKt0xBcRLL6ocSETj6L+WYCSyxEhUtosj62VY/d/3If+tDQOpkUzbOSLVCVF9Nhu1X
 mKoA==
X-Gm-Message-State: AOJu0Yw6iJt0Jd0kvdIx6/oOSpq0Jhf5hKsMzzW6+C1vmCBqZTeAGNlY
 RzEgEUGWeKJss8VJtJo7L/YL8zN1CCwtFk189DCSN5igM6AOMTK7cFczbjV/3+875XR0K/Xl1Ha
 igbacAw==
X-Google-Smtp-Source: AGHT+IF7PkZoj0VWhNp2v+u3gTMe8XI/RnZYTyvN2HrHlE8JkpQuaqCdGaTL03WOAX5tf1VaIXsHsg==
X-Received: by 2002:a05:620a:3913:b0:790:ea3e:61cf with SMTP id
 qr19-20020a05620a391300b00790ea3e61cfmr147308qkn.15.1714227074517; 
 Sat, 27 Apr 2024 07:11:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/18] pci.h: Add missing <linux/types.h>
Date: Sat, 27 Apr 2024 08:10:50 -0600
Message-Id: <20240427141106.3406000-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

This file has many "Linux" style types in it, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/pci.h b/include/pci.h
index aad233769a35..ea3b73923d60 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -520,6 +520,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
 #include <dm/pci.h>
 
 #ifdef CONFIG_SYS_PCI_64BIT
-- 
2.34.1

