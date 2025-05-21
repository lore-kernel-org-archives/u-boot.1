Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0904C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E55082FC8;
	Thu, 22 May 2025 01:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="thDCz8Ao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B7D682FBE; Thu, 22 May 2025 01:01:34 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7673E82E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-601a8b6c133so4334938eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868489; x=1748473289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kkt2aLn340d4qlcpMsay1hrgcR6YSVTyjRioUyvQ3n0=;
 b=thDCz8Aook+21/i3yRkTUW2UhM+HU6TUn3opOd+MnevHzDIQtkkWiPdQqKB/A1bbTY
 q/Tk1qfutz4BavSbBCAO12MCN8f3bYL7EA+4pTmvC/8NEt6UT5pJ+JxsL/wVo+4GP0LB
 cXA4Vzr54EgfFRjv/I8bjcpBVtulNQYcnYEj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868489; x=1748473289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kkt2aLn340d4qlcpMsay1hrgcR6YSVTyjRioUyvQ3n0=;
 b=GBGPrPLDQSZukUQbjJ823g+OebV+Xe3dmChv4SWcC+tBB/RGHBLulU2zSwH4eJpMdi
 wuHOYxwO5kSaIsttwAkA0B93yIDIwsJXcB4ktPyjC5mcvLtvquIxitHKJZkE8Tsoc4aa
 qjV0h5C85uMyMylfN7ZjKfp8bm1dIL6nDd38fTSVN3vtEbE8WKVmIfBDDc3ZCuBZGQSO
 vdcyfMautjeK06ha6vHMngy2nq0J5PvdfjQwTW3Z4z05WekXDnWU45E9b+nnoSb+JdzV
 L4UU3aUVB5nVyGFdDRfb1s8sCr2dY2GJQbpHahumx6ho4kG9ln+cvR2YgsOHsNnD4yfi
 jFAQ==
X-Gm-Message-State: AOJu0YwUahckW0NpEPISyFPOObQfAG0tnnmNRX0/wbzVTszLGOSIZPSR
 SwV5KFUKYdN5Q6zuRZDSL9BduEqqfbJjeMj/Oplmklwx+6IKBAPEwy8AndUY4WQKTQPRsc5SbPT
 KDTK8daY=
X-Gm-Gg: ASbGnct/s3pLWbC+pvub4GBCn+bapWR32sUXvtG/4YHFms1077u3K0cSx9r/DasN7UI
 dhBxUf6nobVB995oAMTwW59WpxI0xEfitFUipJooxrRKJqR3w7flEecF579irDJMc1NnlSIZCch
 v1YxAUeQ1glmxFL2Z94yzznOA15jh5P714deXvxz+xMiyd+uaF/ref3gzOoB6InLDEEq2PUhqDB
 48s62ikfkQt3AgVtBhRL7rS4roWwXPd04JPPEcqa/wJVPAYyQnbCCOaX5ySST6P2sIFNPm3g5HF
 JClkO/V43Fcv/7jC6MncECtRuszelWlXRgcO2U6+PtlyJXG3xYQCQrJHxqvvZ3fqUNL0pubfr86
 K+WD2I6RdD3Fhlug=
X-Google-Smtp-Source: AGHT+IF+sdnBHGIr5HyVEUGKXNiCXUVX9rEQhbnvX54hkwIWWiYuVB/TDc31CAC5N3oJZ1RaEXQFnA==
X-Received: by 2002:a4a:b283:0:b0:608:3493:b807 with SMTP id
 006d021491bc7-609ea157eb1mr11836051eaf.2.1747868489191; 
 Wed, 21 May 2025 16:01:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/17] include/bootflow.h: Audit include list
Date: Wed, 21 May 2025 16:51:09 -0600
Message-ID: <20250521230119.2084088-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <linux/list.h> but does directly need
<linux/types.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 include/bootflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bootflow.h b/include/bootflow.h
index d408b8c85bd1..5a9ac5ed3b33 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -11,7 +11,7 @@
 #include <bootdev.h>
 #include <image.h>
 #include <dm/ofnode_decl.h>
-#include <linux/list.h>
+#include <linux/types.h>
 
 struct bootstd_priv;
 struct expo;
-- 
2.43.0

