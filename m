Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8DCD5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B201889021;
	Thu,  7 Nov 2024 22:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rra2X/gS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D99E988B55; Thu,  7 Nov 2024 22:32:23 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C691288B0A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6ababaaa9so5835765ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015140; x=1731619940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x6nUERGgnxaokPVGNQ8SzhVd3ye8k7onJ6lP4YpOd8=;
 b=Rra2X/gSfZZ1hPvWUc+viUpRpA98UQIdFoZjlaTL0taMj+EG0rJMCCnxPfSlgqnEje
 cyMpny0rpI8LZS1actgQ8C5CT4gb6TMcPtOavIg3si/WAWHfyhrR1TXDDd4GnQeUgtxP
 dqZXr/jsfjJNWfk8xFpylsbr21PhJapDTQvYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015140; x=1731619940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x6nUERGgnxaokPVGNQ8SzhVd3ye8k7onJ6lP4YpOd8=;
 b=rfSX9YyKkk1YyCy5j47brlyfyNMotKTgw5bX6ZlOthx93qA9a1X8RBzy75gFlUa1DB
 XfPHNNLJlWp7C7pOTXI2lwrJfTIKawrofxzHXqSppJvF1IJvgEIFnH/rYKHFeVs+xr6J
 /wW6vD4EeVbGgU/uf/XYcL8IQ1J0MAZ/BCMxdu72VvQ8R4m7G5dovxB6JfhwDTH5PV5w
 COyRu2MJylVWCe/fIu33xiPDd8JXAVC7VImV2iyz56qp7apCOw2Sg53loODgdvSrMLWU
 OR1hx76zL9uQiJdkFRqR4Hp6XyLxF5yBZ4fxJV5g5Wd70umzNKN9l50wFkhJrm1YlwdY
 igPg==
X-Gm-Message-State: AOJu0YwuCMz8HJv773sSPajRybWEOhqvNSJXzqR354JYArE03WGeAIW9
 8nYUDFW3Vhdy5uojBPT0W2qYRmfbs4N7WNiquQVg6wxKO2CTnLpBaUyWu5qdNWPutJrc/rupFw8
 =
X-Google-Smtp-Source: AGHT+IFzRa+MpT/UlmnlV/B5P8yWNu1VuyhX3e/z9HR0vZkXdZN4cxYZHYcyNzmvNx95iXSxH9LCLg==
X-Received: by 2002:a05:6e02:13ac:b0:3a6:be66:ce53 with SMTP id
 e9e14a558f8ab-3a6f1a35505mr8370055ab.18.1731015139966; 
 Thu, 07 Nov 2024 13:32:19 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v10 07/10] efi_loader: Drop sandbox PXE architecture
Date: Thu,  7 Nov 2024 14:31:47 -0700
Message-Id: <20241107213150.1711962-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

Rather than returning 0, just return an error, since sandbox is not used
with PXE at present.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v9)

Changes in v9:
- Add new patch to drop sandbox PXE architecture

 lib/efi_loader/efi_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index ab5678eb66c..bf96f61d3d0 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -91,8 +91,6 @@ int efi_get_pxe_arch(void)
 		return 0x19;
 	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
 		return 0x1b;
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		return 0;	/* not used */
 
 	return -EINVAL;
 }
-- 
2.34.1

