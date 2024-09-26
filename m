Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92403CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35EE18902A;
	Fri, 27 Sep 2024 00:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXvE+4Rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3A98902A; Fri, 27 Sep 2024 00:49:21 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEEB88F47
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-7a9ab8e5f96so100989285a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390958; x=1727995758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fX3m9PH+iHUhZ4CbhWz9WCW97V4EP8uw5fdPsEePvQ=;
 b=XXvE+4RbfrkURqY2HwFd5rm9bE7wWmAx9ZxXDHVJMs4wdTG/XRIUvD7RzR8XHoxkr9
 xbPoEjiWAG/yE7fATx+uF96SlPwLlv6L21/ZGXzFJC46Mr/GNPqDwQATELLbKjcWtdrX
 SbnbAaN/vYu0QeDHwqe8jlszVd491K5Sl81DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390958; x=1727995758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fX3m9PH+iHUhZ4CbhWz9WCW97V4EP8uw5fdPsEePvQ=;
 b=twgprYFSXQ6nm5t2cUvQyxa6GHxEzQSNGryhiDhWVXQaAEGJiwn+Ufn+/xdBKmEoZK
 ELu1+oTbG48JgLaDbbzKR2hb5FFMIClnAr3eKuNLqwzZfPEB7KwVH88U0OadHE24ZOlm
 v4ljKD5cKqWCQHMzXuF4IS0E1xl78g+kh0CHgEXJQWtubDeQvNOw0V5kNxdT1ENnNjPX
 jVi+7AQOi619z4TzOVXsykVUMubf/UeiUPmZ18QeWyRmPl6YU2ofIcBRdtuf1Y2cE0Pv
 p+CqFOp+t3cQ4SFHRUuuweKCChC9k2Y8qecMWY+fPP/O34HMe6iZaFonVJklSkEDKHpv
 IPZA==
X-Gm-Message-State: AOJu0YzS0OITcwvlhCsTdDYCaXA5Yg3kN0c++ig6q46iH9XGFVONlFuB
 W0Or45D3Hu1jrQBsHAHnxV3b27u6qZ+GMJ4dL9hLiM5CJnGgG5vEsc7wVWj5kCkeN0QMYOrYHD7
 ESFC9g/RHWw==
X-Google-Smtp-Source: AGHT+IEvWwefDUEDZhTmNHvKLahkNaf+7CL4iO8445WXr71TWIg2CJci43p3D8yGhwWuvgPZECNTKg==
X-Received: by 2002:a05:620a:4005:b0:79e:fc8c:dae3 with SMTP id
 af79cd13be357-7ae378dd6fbmr163837185a.59.1727390958036; 
 Thu, 26 Sep 2024 15:49:18 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3785840fsm31489585a.130.2024.09.26.15.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:49:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 01/42] Makefile: Add a u-boot.cfg file for VPL
Date: Fri, 27 Sep 2024 00:47:30 +0200
Message-ID: <20240926224820.1278608-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926224820.1278608-1-sjg@chromium.org>
References: <20240926224820.1278608-1-sjg@chromium.org>
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

Create this file for VPL as well, for consistency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 525576f987d..300cee2e7f6 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,7 @@ include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	@# Otherwise, 'make silentoldconfig' would be invoked twice.
 	$(Q)touch include/config/auto.conf
 
-u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg:
+u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg vpl/u-boot.cfg:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.autoconf $(@)
 
 -include include/autoconf.mk
-- 
2.43.0

