Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C18C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AC087F76;
	Tue, 19 Mar 2024 17:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A2534F1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 057EF87F77; Tue, 19 Mar 2024 17:51:37 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0B787F04
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dd045349d42so5041058276.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710867093; x=1711471893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HRN96wYsJE/TRQ5yJQLfCWeN3Mz3jKOWqUi8tAOve6Y=;
 b=A2534F1T9k46UTgmqXZfdTHoHBoeo3An4P2haQqdNfmn+hWi7Lbff6llFj0SNFrybh
 zTbZVJltf7XMC10RGIyby75YbpT34R5KRTXrDLLPes2tfJdlQPQQbZgRluJ77fQa2ifL
 rCjw2Ll2O277CKm5lqajJHEG0NAW/PpeYYE3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710867093; x=1711471893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HRN96wYsJE/TRQ5yJQLfCWeN3Mz3jKOWqUi8tAOve6Y=;
 b=s0gfOqdC83p1Dr4Zossy6ttprgfWwVatU74b0mcWq8avNm46F7tT/jAlftoga7Y4/M
 7PUqM9oCq7I48CUpz9nUlKSqn1e3w1gsjlnZW8LIhV9DhQl2FqVI09455Lk51SN0KhPB
 HKpq1ElFiWQHi9CYOndbio99JRObeRpcOQWw2eLTPje5BOGp6pFgC87GcG8Sm4kKAfjd
 vssbNEsrOCjxRpmc84u7O1vqUXapd2GkqSIwY3eP2Az4Kf7Xj64zvfjb8WpC+ds3DKVB
 wBHMUIeLZvx/LR0xDRFSFPvpKRYyXsPgBYdQEfw4NDX71bex8RZFal2I59zRDATOPp27
 vT1g==
X-Gm-Message-State: AOJu0Yz0iflqgYr8p/qB/pYVRfXzAki5cYS+DgHbSh9Jt6JxENfukvv5
 OgvJUiQZxUCez705NQzsQ3zmxspfUqBWGhuTrNpJ+v7WPIH4G+xcTjxd8B9MKMaR11a6axctiq/
 w
X-Google-Smtp-Source: AGHT+IHpFSjGwZoS7uIqyf/7dNqi8D4tp3knIh3DEWA18MDVSUzz61C45xgyYTb203qGRNQFG2hkGQ==
X-Received: by 2002:a25:ab0e:0:b0:dcf:3ef5:4d30 with SMTP id
 u14-20020a25ab0e000000b00dcf3ef54d30mr2452329ybi.17.1710867093433; 
 Tue, 19 Mar 2024 09:51:33 -0700 (PDT)
Received: from bill-the-cat.. (065-184-193-066.res.spectrum.com.
 [65.184.193.66]) by smtp.gmail.com with ESMTPSA id
 x12-20020a5b0f0c000000b00dc62edd58dasm2211993ybr.40.2024.03.19.09.51.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:51:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] scripts/Makefile.spl: Use 'sort' in SHRUNK_ARCH_DTB rule
Date: Tue, 19 Mar 2024 12:51:31 -0400
Message-Id: <20240319165131.1651802-1-trini@konsulko.com>
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

With configs such as "am64x_evm_a53" or "imx8mp_venice" which list
multiple device trees to build we get a warning such as:
scripts/Makefile.spl:578: target 'spl/dts/freescale/' given more than once in the same rule

If we sort this list first the warning goes away.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 scripts/Makefile.spl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index d074ba235006..60db38d5bddd 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -575,7 +575,7 @@ endif
 
 SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
 SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
-$(dir $(SHRUNK_ARCH_DTB)):
+$(sort $(dir $(SHRUNK_ARCH_DTB))):
 	$(shell [ -d $@ ] || mkdir -p $@)
 
 .SECONDEXPANSION:
-- 
2.34.1

