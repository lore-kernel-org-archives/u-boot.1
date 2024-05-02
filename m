Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B483C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B423C88BDD;
	Thu,  2 May 2024 03:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFg3HvRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE6388BF6; Thu,  2 May 2024 03:31:51 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A5F88B93
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4365c1451d4so49275941cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613508; x=1715218308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mH2rYh8Kc1F9aEeqL8ZgMhOFWHYNW8kGf+3I0dkxmcQ=;
 b=XFg3HvRR9I5opFZTNmbJes6J/FZSSH+vk+pVxU/GABd4A5mO3VyUiqopiTVRmksMPy
 V0+bC8jfflCliqVfXjY9Y8ypxx/NUpioQT1Uo/liaBOCbrto7DHRVkVzatQ8pUPkLCJ7
 V/xVrcjaI3jU0zA6cA7z2G8WJmMMoFYn76VsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613508; x=1715218308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mH2rYh8Kc1F9aEeqL8ZgMhOFWHYNW8kGf+3I0dkxmcQ=;
 b=p85geAJSn9w5i3Ep1ox+LYHGC1x/cwg4zsY5cqGZHfpAxkxa5QCtaFbIklJrUqGuEV
 YKda5FqjuUTc313SeQHyL6fHizjKVnrOiNL5TUn1j9CUbtOmJFdXj8CW/tP+fQhkcV1B
 ubBGCo1Rot402VdioOCl6KEFkPagOYBk3fkvg6oyhmtdmSUVZEhts6RVdxJL8J9/zdR5
 F4nn9jiZqsNHkL64EdcUFqFpeu9KRZukeoHZbEhWagSIDwPaD7TfunLmNO8ITHn9Ane/
 CHN5lLwLYh/qJtpfgr9EHDZ4ZBqdpFle5dIlL+G8h8cf+zI3gHBSmrojJKDiVWhKVdGA
 U86Q==
X-Gm-Message-State: AOJu0YzJ7tCMSCfiVPzEexEhAy+N2u1aJstyaHt7SQ5ANcaymKodl0gH
 O39nq0Pw+vzKMu06lvZiyXILrBcG5RsEc+RJu0xoiiQL5T/mx9YvTKFleT0RMW43fBYH7WwVEiF
 8nPCntaVv
X-Google-Smtp-Source: AGHT+IHPA2i7IeHSp/ECvzKDu/5D17hwYpiB4igJCHlf9bS2JzxLcFQOp7Z+WITwfj87eEb4IGZZ8Q==
X-Received: by 2002:a05:622a:1307:b0:43a:ed8b:5a52 with SMTP id
 v7-20020a05622a130700b0043aed8b5a52mr5048264qtk.44.1714613507998; 
 Wed, 01 May 2024 18:31:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 06/81] x86: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:23 -0600
Message-Id: <20240502013138.2383421-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/include/asm/coreboot_tables.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/coreboot_tables.h b/arch/x86/include/asm/coreboot_tables.h
index c967e6ad0ce5..54aeffb9889d 100644
--- a/arch/x86/include/asm/coreboot_tables.h
+++ b/arch/x86/include/asm/coreboot_tables.h
@@ -8,6 +8,7 @@
 #ifndef _COREBOOT_TABLES_H
 #define _COREBOOT_TABLES_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 struct timestamp_entry {
-- 
2.34.1

