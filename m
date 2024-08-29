Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160D3C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E927988C8A;
	Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T3ne8dZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3595188C7B; Thu, 29 Aug 2024 16:58:26 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2085D88C39
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d46ae7863so2584065ab.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943503; x=1725548303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzDaMWdoHFXaO7z6pyFLFNlODf2IMqS2NYtlhl5U9eU=;
 b=T3ne8dZWNpl70c/yzbGi47GMHV3BUTTjGI5SdDXxvl/D7g2iCTFJoSrZTJ52y6tXoH
 TP5qaCMsr3O3MoF81l0fZG4wfn2sLvDR9i/iuTzP6ddOQJtXxI8leZMkHMlIIvB70dci
 gSPUvz5eOPkYihs6YIrHpvyqzbvIVvbvqsS6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943503; x=1725548303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzDaMWdoHFXaO7z6pyFLFNlODf2IMqS2NYtlhl5U9eU=;
 b=w2Y4NaG5RXP4SKS2wPN8EiCA+lFS2xs+b8eXwz6fmFYEduE/ifsXuJ+HMdEaNst1WV
 b41tN7v/7jMqV8tmmRaFlFGLYNUjxUFV02CYVwOv57JB09Erk8EDHTCb/HsbDUZzXHuR
 yUhYDhWRiypPRPwfQI8TagwjVSS7fmSZf94eGhDe957/lLn8BNS/FpOIHJY+oquYTFV+
 FAWFfGvqfWBsR7BFSJxFKe/XEJmfXWEvSsWFf7GhlqJKhvu5Lp51GCCmk8HqvQeyHDVQ
 iTapYgzrcpsqgYqU22SO5gOPxmLZYsExu3oZJciQw0vW1VZ19Svkar4HHsd22E1qaqru
 +EPw==
X-Gm-Message-State: AOJu0Yy7KSN1VdQBBobdFWii7LlADKvM/sNJCIg0zDXAr4P1LNSOIpxS
 g7XKVarlGr1XJj9+H4DbEbP9lz7mffXZjzEx3DlT8Y9QIEhd9r5rhCQp7UGs5VsyqOj6pU5ZFIo
 =
X-Google-Smtp-Source: AGHT+IGYuhKic8CCIOn9HHQHIx+H+kYS9or080aN10oYFx+rHlxPBZoYfxlo5RIhzx9f5EIoVxyw8g==
X-Received: by 2002:a05:6e02:1585:b0:39b:3a29:b860 with SMTP id
 e9e14a558f8ab-39f3b32c17cmr14313925ab.4.1724943502705; 
 Thu, 29 Aug 2024 07:58:22 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/19] Support setting a maximum size for the VPL image
Date: Thu, 29 Aug 2024 08:57:51 -0600
Message-Id: <20240829145802.1827952-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

Add a size limit for VPL, to match those for SPL and TPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/Kconfig.vpl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 3dc0e95e09f..eb57dfabea5 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -237,6 +237,14 @@ config VPL_TEXT_BASE
 	help
 	  The address in memory that VPL will be running from.
 
+config VPL_MAX_SIZE
+	hex "Maximum size (in bytes) for the VPL stage"
+	default 0x2e000 if ROCKCHIP_RK3399
+	default 0x0
+	help
+	  The maximum size (in bytes) of the TPL stage. This size is determined
+	  by the amount of internal SRAM memory.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.34.1

