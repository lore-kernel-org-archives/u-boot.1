Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C651C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8F88753C;
	Sat, 18 Nov 2023 22:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBv75+Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A3F874CA; Sat, 18 Nov 2023 22:06:22 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294FE86F95
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7afff3ea94dso114785339f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341557; x=1700946357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV3uk5jzXBxZvCRVh8S0FcaozmsfcHtrLvA5auJzVao=;
 b=YBv75+Aj/Lhycp4I50Bhj68ImjGGw921+evyJ4PFvkQD/9oSm35fd07duqsqRef3/8
 M7dqa+9O4lNkdC5DS7abEJdTfXe2yomzDTotCIXWZLMTDnQwwN9BFvq9y6G4/f9i11/g
 6Rvm/SGD0ntlC4EX9x+bMOaA4i0eXeDwabkWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341557; x=1700946357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sV3uk5jzXBxZvCRVh8S0FcaozmsfcHtrLvA5auJzVao=;
 b=n69HsJnwPsrgPPu8Het3SwMK95pS7GU641ANpNGshWnhZzLryePMX7VU7uVPtaJkcN
 PuNEgJrfdW4leYTtn6y7ZzQKgn5e0mMe/yqx0UC1KyR/8B7Fgztbs560WJ8lQJotg1gQ
 vKwAmJHKZXRhs/XGQvo6XGPOsm2EdRZa2NXn/JRTrJBWkCVTHhoRHp6dty3s+TB+IXGB
 AHZTcvsjCRwwUtX8RMtCr837qznGHIr3XUz8l7A5uIn28u1iYlHemR3LRjIKLNlPvgYt
 ooH3KMGvhTn7m5oPLiZLw3UP6RxaCFY3m65hHSsmgG5EHG+rm4SaEhN5RyCFly3v9mm3
 mTEg==
X-Gm-Message-State: AOJu0YzoR3SvquHzG8V3xWoIwaHpBu8Ia7zd1v5YXna8YQpP0pJELXM1
 kGfWid5nnmKDWJcqTc/xbKgGzTXUVpoRyp0zo0J0SA==
X-Google-Smtp-Source: AGHT+IGE8Pl/LtNRusX6grsu2mBJOtsuXTryIQ8wBc1kE2/TOlTnrpsNTNDGPB9K0a9TGk/Tuqp6YQ==
X-Received: by 2002:a05:6602:c08:b0:7b0:ae56:bd8a with SMTP id
 fn8-20020a0566020c0800b007b0ae56bd8amr1496863iob.14.1700341557385; 
 Sat, 18 Nov 2023 13:05:57 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:05:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/32] README: Correct docs for CONFIG_SPL_BUILD
Date: Sat, 18 Nov 2023 14:04:50 -0700
Message-ID: <20231118210547.577026-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

This option is defined in both SPL and TPL builds, so correct the docs
related to this. Also point to spl_phase() which is normally a better
option. Mention VPL as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 README | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 00d422737fbd..ab4cda54d2bd 100644
--- a/README
+++ b/README
@@ -1544,16 +1544,26 @@ Low Level (hardware related) configuration options:
 		globally (CONFIG_CMD_MEMORY).
 
 - CONFIG_SPL_BUILD
-		Set when the currently-running compilation is for an artifact
-		that will end up in the SPL (as opposed to the TPL or U-Boot
-		proper). Code that needs stage-specific behavior should check
-		this.
+		Set when the currently running compilation is for an artifact
+		that will end up in one of the 'xPL' builds, i.e. SPL, TPL or
+		VPL. Code that needs phase-specific behaviour can check this,
+		or (where possible) use spl_phase() instead.
+
+		Note that CONFIG_SPL_BUILD *is* always defined when either
+		of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
+		counter-intuitive and should perhaps be changed.
 
 - CONFIG_TPL_BUILD
-		Set when the currently-running compilation is for an artifact
-		that will end up in the TPL (as opposed to the SPL or U-Boot
-		proper). Code that needs stage-specific behavior should check
-		this.
+		Set when the currently running compilation is for an artifact
+		that will end up in the TPL build (as opposed to SPL, VPL or
+		U-Boot proper). Code that needs phase-specific behaviour can
+		check this, or (where possible) use spl_phase() instead.
+
+- CONFIG_VPL_BUILD
+		Set when the currently running compilation is for an artifact
+		that will end up in the VPL build (as opposed to the SPL, TPL
+		or U-Boot proper). Code that needs phase-specific behaviour can
+		check this, or (where possible) use spl_phase() instead.
 
 - CONFIG_ARCH_MAP_SYSMEM
 		Generally U-Boot (and in particular the md command) uses
-- 
2.43.0.rc0.421.g78406f8d94-goog

