Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25525C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCF581E0F;
	Tue, 18 Mar 2025 11:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rXhj62GU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CEF81DCC; Tue, 18 Mar 2025 11:47:39 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0153B80F70
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so31942825e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294856; x=1742899656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iz+pWSRan5RcbHuOAmgsyvPmB2L2wa+fNWwBN2HgjWU=;
 b=rXhj62GUnZI3xliqAtn+DqXZdKNCYGhm1AEB+1dHsiX9YfjOMngYsM8aB/W5dZmoQE
 CYrQJpf5GbWKowcAoCzIt7GlYVupOF5qzXDj3unNgHS4khs5s31SGymR3RXYMo9w47Sl
 4OZCJ6MGSKxcL1sHUChnoLJ+zxeYTawfFWo82FBZZwhSmsO9yY4dkSW/Yuzq7MFC09Jj
 F/M2iCH+6H9FRUcru0pA/4zo3cTVlh/bqwk+xR0Q3tZ/u7Js6NXHxdA2uhT+pr1pN1vA
 KLDLvCEARzz1v4QdEayXUkj0ldDc9NC/IvpJ247yndobR8Kj7UAZGpPZW63NkP9gSQqN
 eOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294856; x=1742899656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz+pWSRan5RcbHuOAmgsyvPmB2L2wa+fNWwBN2HgjWU=;
 b=UFmzAultk3HRx03Fnumt0bNtl3R+YOC9Bdrmx7pZ3tfBc4tLQk75r/K68pdOXyGBAk
 RtRNrdDFvjyrnBnehQ6nBeNErUP+UixnDLUl3gI10vt0bTjsFKmOQTDYhT29KU8t46UJ
 Kea9dqZ7BtRp3ECXOuihhVbSU/9aNTML0mg/OahsCcCF9gyGRr6dHsXofSWLP0KPe6RH
 fqWfUIsGEDEf2GZb/R4YAAxDzguMusexKBABmDx27i7hCSbG5MwA5N2x5/Gya5QOUfvz
 X3DJ/QamxPx91G5ZGjfyWgdPH2La5d5PHdXnOpazV4kZ7PHLaBYnBnOrOHAbr3SkwyIw
 nQiA==
X-Gm-Message-State: AOJu0YxPIXPCmCzYmNC3t2b8OscjqZBsDFEykXPuGe2j07WboM6q5bJm
 w2xAmxChji5mWTYLHj5tnICU7hE8ol6bBcydpVC3tBROvofiFOn04VLmjFtbbdKSjfEADQi9XVx
 IOjMbmA==
X-Gm-Gg: ASbGnctgUxhw6vqiWsnkEXvKpTFjhCj8vcyFH9VFnQ1yaFRfQY0+14cEau5EXWRnra7
 qkBvEVNrIEDpXiyH7eKyqBTiHQJ4cYxST2EJx2s2Ymp5PPxqjO1b9dBzj1A8WRS3h/DCnS3xLjo
 EB1bNE6oB+d75MMq/wExayO+JzZE+ZnV57T6KZ8ZEAKvJ9al9lCfRhX6B3/GXKkXZA3twpvSakH
 luDR00XBRDdjxpwuMA//PaAhF3hGLazpCnIBJhEFtnn/j3wisGoHZsUvQGJAlAXrjnLYxvE7JPn
 Ub2DAEfonsy16oE9TYecczhfIJZY9+ZRFuoZdXrXZskFYxABmo6Wew==
X-Google-Smtp-Source: AGHT+IFdhPWKHA/NYCfqbHQrdelKLAgSj4RpWMPPvf4A8kNWnZJEdaVLw29pwGDF0gks3XEPfgdjLA==
X-Received: by 2002:a05:600c:1da4:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43d3b962508mr15307565e9.6.1742294856282; 
 Tue, 18 Mar 2025 03:47:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v4 14/14] MAINTAINERS: add UTHREAD
Date: Tue, 18 Mar 2025 11:46:50 +0100
Message-ID: <20250318104659.1114340-15-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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

Add myself as the maintainer for the UTHREAD framework, the spawn/wait
commands and the associated tests.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92d4a158fd0..4b6bb7dfcd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,6 +1817,15 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
 F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
+UTHREAD
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	lib/uthread.c
+F:	include/uthread.h
+F:	test/lib/uthread.c
+F:	cmd/spawn.c
+F:	test/cmd/spawn.c
+
 UUID testing
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 S:	Maintained
-- 
2.43.0

