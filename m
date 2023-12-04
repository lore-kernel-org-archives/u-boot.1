Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D8887717;
	Mon,  4 Dec 2023 01:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IUMHEtvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74C087717; Mon,  4 Dec 2023 01:27:17 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BE4876C4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d0b0334ffcso1092275ad.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649634; x=1702254434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+bMWC3gW608KuzEsb7SpeSTW4SS4T5+hsKtGa8fGcU=;
 b=IUMHEtvqbvc+g4DsaQN5/FhReZ5Pyqz63JTzPqGqVMuqRxX7w3llgiSiiaIMjceKCv
 YuphKAzvCbrSZw4iIYB5SX/5ckmG8AS2X1LbmRLS6PHF+srAN2qGrubs33qHc6ywRogG
 idoXsnDUWtEO9OBe9+P88MNLC7RF/Oy6nRgrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649634; x=1702254434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+bMWC3gW608KuzEsb7SpeSTW4SS4T5+hsKtGa8fGcU=;
 b=Fqr74SpI2nNaKlvcO+/vjWdl6yn1DGSIPOIIxzXydr9mOaaFqZUBkt2OZV8RzEIJCR
 EPY+1mSscR+8ab1nQpGl6XZOElgy24t4n3hPfjpin/ICOxPyF4kwiUliCj3/LoSrKeEh
 0/I5J5T1RSJVMM1DoX56Q9xMFkr+ua6mmUtoCQ932PV1xMV5bSqcsiIkE+HVP8mZXzO9
 m+UeWrhla/R/BTVAeKrgNZL/8G7msFEU29n2+dvrDLWuvzmGB3Ta4wnsiQgz6OrMjz/6
 Mp8M+eRAHo0X1fcGitZsdovvyUXhVI7VQynHrLbKxUxgZjy5/mTTx58lQkrqOkUKLozL
 tkmQ==
X-Gm-Message-State: AOJu0Yz/92p6Fr2CaHlqs15LXB6Cpinlg+XznlxbmRr4zA2XOwiuFlYl
 +FUddItFkdacOsjXernJUC19S0nYMdwjPNy8E38duQ==
X-Google-Smtp-Source: AGHT+IGbsTz0aZaKNoznJgNu1HU3iyc3hY0y9kQgHCXU/wBbAyuojIpQb2xY1dosa8qV6dCsVNvPcw==
X-Received: by 2002:a17:903:1211:b0:1d0:6ffd:e2cf with SMTP id
 l17-20020a170903121100b001d06ffde2cfmr3159572plh.105.1701649633847; 
 Sun, 03 Dec 2023 16:27:13 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH 04/18] nios2: Drop separate parsing of bootm args
Date: Sun,  3 Dec 2023 17:26:20 -0700
Message-ID: <20231203172622.4.I786baf70a4f8d91c3b9ce38c2501b714b03b94d8@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

This function is supposed to boot the OS. Parsing of the arguments is
done in easier phases.

The code to handle this is already here, behind an #ifdef on
CONFIG_OF_LIBFDT so rely on that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/nios2/lib/bootm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 06c094d0f1c7..823d524c9a2d 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -29,8 +29,6 @@ int do_bootm_linux(int flag, int argc, char *const argv[],
 	if (images->ft_len)
 		of_flat_tree = images->ft_addr;
 #endif
-	if (!of_flat_tree && argc > 1)
-		of_flat_tree = (char *)hextoul(argv[1], NULL);
 	if (of_flat_tree)
 		initrd_end = (ulong)of_flat_tree;
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

