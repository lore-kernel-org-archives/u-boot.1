Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F669CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65EE08362A;
	Wed,  1 Oct 2025 22:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fFwRRL0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7CF836B4; Wed,  1 Oct 2025 22:30:53 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6507983666
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7b6ac55cf86so207155a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350650; x=1759955450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jcy1FEz/iRH95SPMbDr63qSnxFMOV5IT7wEb69da3+8=;
 b=fFwRRL0kaY/QEAtnVzsdvhGXXgI/79EPpsl4YlcQMRexjwuX3uCTDc0emy1e9+PX76
 96uKDjsMek9Z1196c+9AoBY/SRZmg9Bfo3RE6LkEAWeNefbanWfVo17Y7CfMPH4ftYPa
 3q9GB/suQzW0T+wVzJoH445tsbulQr6gNo8ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350650; x=1759955450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jcy1FEz/iRH95SPMbDr63qSnxFMOV5IT7wEb69da3+8=;
 b=wzsm39qxRYjve0IEuiwJeh1+bNrR3tBGsdt4sNeV/e4zc7t7+0CYQmpSnQkl0avVMw
 5FO5C7ZrStVb3UJejo1apPgtZ6lseh5zpkmbsSx/wXPj4h/+q8JB0Y675dPUETSkGJ+g
 E5/y6qIxBpjhge9+pUPrWasC4B8kjLYPubNQsZXESlDIHkZWxpdMzIjDJQFVsV0UWHqx
 dpMVlkst3hMUxSiwJ8m75Qf/KeEA42m66+ZWjdxzV8VkhpQ+fEM2KrnxmV+FoPTOCc/P
 Cop75Cy1ZqKEgbzVfmPshVyif08wPEVPK2rfZdqvLVX50EUjiEMKa+2/IVz29dQqzxSa
 ShDg==
X-Gm-Message-State: AOJu0YwQbzn/OE9hplp2tjf/2ermzpilPUyl7nmAjYeMUoU5iUMcFtQj
 hcOTv24ABKU2+4CdKMu78cz5QRO+CulveU8K6w1bUPEvCedpcWxuZqb8VCRj9sfI7NUDOXrIayu
 jbw7sssQ=
X-Gm-Gg: ASbGncskDa1VCLjyf7sBljaG56UXRD5MmcHphlQb06/gX6SZCRfXQDl4KakqZE8g111
 /PJgR83pT/3Y9pAyEzsDusrD+IJLL+nYHGRjhrlzIoEY4Sn4lyziDWGllNoTrK73eAGlpsx6nz5
 zhKXCikkxyxY/VRgtPilM56w3JqlpMhs0pkWvyNaj802JZU9DBUJT+kLuss/85uhBaLk1EN2Iel
 Tg4CN2GIcrHlCj0AEaiL5n1BPviHq4Vc3JMjtoOCBaokkjnS0X4f4ZASleRwjNM3Sq7zGxy+PtE
 pc8bqyHnPojX1hl/ecIxI/seR49Ha8gymTyiwtBPD4cCZd4Km/J9vOEWK3YVVsJu3k1Kx0a4kvo
 2vypE5pCPLF+FtqH4uZR0z63YBfZki0koAvz4dIzLCDvv3BAHasVtU2mdDAGYIMFxmnFjGsXDpG
 jm7ald6N+N7wPL74ydtg==
X-Google-Smtp-Source: AGHT+IGfbbB5MXJcHyQdDj/qXaeKdPRXNqwDdi2KLJDWXZXRllou3kZ8Q+HVPXqtkFxUsyzgTxMtSg==
X-Received: by 2002:a05:6830:3508:b0:745:a390:8662 with SMTP id
 46e09a7af769-7bdda569708mr3774160a34.13.1759350650069; 
 Wed, 01 Oct 2025 13:30:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf439d2ccdsm113398a34.35.2025.10.01.13.30.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] dts: Make xPL_OF_PLATDATA depend on !COMPILE_TEST
Date: Wed,  1 Oct 2025 14:30:48 -0600
Message-ID: <20251001203048.2828430-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When doing a COMPILE_TEST build it makes more sense to disable this
feature and test the common path than it does to test the uncommon path
of [ST]PL_OF_PLATDATA being enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I thought about this a bit, and one thing is that we do uncover a number
of drivers today which have partial OF_PLATDATA support but we have even
more drivers which assume OF_PLATADATA is disabled and then fail to
compile in xPL. This choice will give us the most overall coverage I
believe.
---
 dts/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 4e2622d48d04..070ffbfef587 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -455,7 +455,7 @@ config OF_REMOVE_PROPS
 
 config SPL_OF_PLATDATA
 	bool "Generate platform data for use in SPL"
-	depends on SPL_OF_CONTROL
+	depends on SPL_OF_CONTROL && !COMPILE_TEST
 	select DTOC
 	select SPL_OF_PLATDATA_DRIVER_RT if !SPL_OF_PLATDATA_INST
 	help
@@ -542,7 +542,7 @@ config TPL_OF_REAL
 
 config TPL_OF_PLATDATA
 	bool "Generate platform data for use in TPL"
-	depends on TPL_OF_CONTROL
+	depends on TPL_OF_CONTROL && !COMPILE_TEST
 	select DTOC
 	select TPL_OF_PLATDATA_DRIVER_RT if !TPL_OF_PLATDATA_INST
 	help
-- 
2.43.0

