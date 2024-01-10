Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99F1C4706C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 01:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E368756F;
	Wed, 10 Jan 2024 02:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wAI93oYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA2587708; Wed, 10 Jan 2024 02:17:13 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3284987A35
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-205dc844e5eso707921fac.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704849422; x=1705454222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLu8RNfQOxa+r7scNxZe5YOo/ZxWLLZ6QlPdhb7HAxM=;
 b=wAI93oYj7/jemcDLwvctcQvttCCpOfM7X/mU33iO9aJTSbMQ9Q6E8D6QN9WPQ1eoet
 jkx7kiIzNeQekpUpII+jDljZZGWONnxYa133RQInbXIwxOJtFRlSObeFEDZpJYM9hlcq
 zUl1IpBSslsvum+9b5piMxPYpRSK151klGD2uJ0biwFjO4ueGJnQYHtzX9/lLZUvY2t9
 BqRDV55tl9ISWDJXvxiDu5J38Bf2K8tAx2zJmlWAEhtfodFIOIcfRMhRtjQ4UcKb0yIA
 3pXLRxwEgkjks11D5ws58boteoLoz6FYOdL0Qi+giIPf/SdV7wsMc1SO1fbr4Y6rILrr
 yCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704849422; x=1705454222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLu8RNfQOxa+r7scNxZe5YOo/ZxWLLZ6QlPdhb7HAxM=;
 b=bGVqGrUGsk4KoA1En+11zhBQ6On07HZkNdmm7198FcpOrSrJDQKzLCept7oZa2dnGM
 J+S3maKxXSIuYYngsuOXv5Z5CudJ2u/zWos/n4z+ZxHVbQ4ryJmz4c8nhGRT4U+nlakF
 ykv5Tb5BasCQB6sYhPi4zFiLSV+/rb7v/WVS8oHXeIKreSqdHDQKPHE+g1aAcigzM1eB
 EfgURbLgkY/Og7fMs3bnJ0BdV9uue18pVnSXc1n6eIXCuki6PCQNibxCGEP0gfLMT/KN
 LtxglnQd9MkL42QdT6CHbeTcEiq9NmTPWcWFU56314E1sgChIFU/YsghEjxfPcEBojwY
 xKJA==
X-Gm-Message-State: AOJu0Yw5gM5oWs9iqAEwVlSR4JWDwCJwK4/CU486Yb+rWvovz3I5T1P0
 MGlCAmnFhlrpK2QvXOo5fkgjwwftaNvrSQ==
X-Google-Smtp-Source: AGHT+IEZRgwbxgIJ5Ia63OIubf+bf7B4JnO1VB3F3s/ir0QV6z1EAJm0G09m/owOmSNOAo7Sp+CVpg==
X-Received: by 2002:a05:6359:45a0:b0:175:a1c1:d200 with SMTP id
 no32-20020a05635945a000b00175a1c1d200mr526451rwb.3.1704849422315; 
 Tue, 09 Jan 2024 17:17:02 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e32c:1ab8:3100:c37f])
 by smtp.gmail.com with ESMTPSA id
 a36-20020a634d24000000b005c2967852c5sm2166833pgb.30.2024.01.09.17.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 17:17:02 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 4/4] fs: remove explicit efi configuration dependency
Date: Wed, 10 Jan 2024 10:16:37 +0900
Message-Id: <20240110011637.174710-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110011637.174710-1-takahiro.akashi@linaro.org>
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 fs/fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index f1a0b70d1d57..acf465bdd807 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 		return 1;
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
-				len_read);
+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
+			len_read);
 
 	printf("%llu bytes read in %lu ms", len_read, time);
 	if (time > 0) {
-- 
2.34.1

