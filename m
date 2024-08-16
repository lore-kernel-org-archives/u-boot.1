Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56BAC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2247D88B40;
	Fri, 16 Aug 2024 05:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YYa+Mn6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BABC88AC0; Fri, 16 Aug 2024 05:49:18 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B72E88B63
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d5b22f97b7so1260672eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780148; x=1724384948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zkK3fEHrnJGWIaWPfToBtoGkCdoaYhNYh8Tg0NxeqeE=;
 b=YYa+Mn6KKb3JjKnxMlSv5CAMI3aepmuwgPTP+gr25TaflEfwq7N4OulV1y6ZonuBxr
 4F/SsymNZi3SVXkthdj5IX5lDfFhZ7l0rSjW8fZJX9CFyT0bIKg8GwRYFpgS6c4jctXF
 T/dj2hh8vKqtU6z07fhi8DbwXf1ZyE/dc1Jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780148; x=1724384948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkK3fEHrnJGWIaWPfToBtoGkCdoaYhNYh8Tg0NxeqeE=;
 b=D1NaPZ2oFnyhPWgi1IRmoRg92o5oIDdA7jdJ8uXEtCz3zTJ0hw16WfLG2cYEcexACt
 g388iVje7v4I7hMI8bdqKCUxSThIGvOI3GqJ5rxbxppJPL1OYSIFWe14yasPkSJnycdy
 FRh50zSPxpMFvp4S2wg3gC19wYsUpirn/GVazF+rqMtidYtMj5SJfQS7XKL1akM2kAh4
 eHNdw1cvsuy3Cq67h6h534CKYiQ0TMGoB40YMyGXJvDsZzj4K6rrLM2TWLzuTvgleLmz
 oUiXMXY7S9P9w0tG881eroEbIWhRH+Sn6A62XujoIoYHJ9PAJM2T1+biwhe5RLtS62g2
 Lt2A==
X-Gm-Message-State: AOJu0YzDUuXKKV3FN8s3eHm+AtnWFNUsvxOjpiVioYsiKtoOYlaWqIv0
 rDIJMMVDOFk4hLM+ExGNE7pzye/fu5+lufkoa43/T4MDhocoigyUxPlABL+t6j+HPEeBkhJEJuk
 NAu4=
X-Google-Smtp-Source: AGHT+IHChDmEyuK1kO1+tKkTSQVIU/FpaaF6WDFv76bVbULCVmHzMoVdL7mJCG0iN/UWVV+Vgq5UdQ==
X-Received: by 2002:a05:6870:80d4:b0:25e:170b:4470 with SMTP id
 586e51a60fabf-2701c575149mr1654213fac.50.1723780148492; 
 Thu, 15 Aug 2024 20:49:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-236.totalplay.net. [189.203.97.236])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65af728sm550730a34.37.2024.08.15.20.49.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:49:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] test/cmd: Move wget test to under a sandbox guard
Date: Thu, 15 Aug 2024 21:49:05 -0600
Message-Id: <20240816034905.3541020-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816034905.3541020-1-trini@konsulko.com>
References: <20240816034905.3541020-1-trini@konsulko.com>
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

This test is sandbox-centric, so guard it so.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/cmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 478ef4c6f057..8f2134998ad0 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -30,7 +30,7 @@ ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_MBR) += mbr.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
+obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
-obj-$(CONFIG_CMD_WGET) += wget.o
-- 
2.34.1

