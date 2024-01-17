Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C6C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 04:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB37879A0;
	Wed, 17 Jan 2024 05:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMQQd1qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE7A8790F; Wed, 17 Jan 2024 05:40:10 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516488798B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d437a2a4c7so18673515ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 20:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705466405; x=1706071205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLu8RNfQOxa+r7scNxZe5YOo/ZxWLLZ6QlPdhb7HAxM=;
 b=TMQQd1qusedBsSS+OuKHTvjfJeSyYZaAaO/szjNIzqj5RSAZTfPE1nHRZ7NrcEEBFK
 53cohnMCPG3xzZlNIbvwaIsi0BzxDAXD8gK5al3kVoSH/2jzYjcUQ3srIWsm0e/MlHvm
 75YRJSy85vxJD01A1ZMps+LjKyeQFKzJwuIiTgmyqanGE3b6/PPS76F6QcOWhstj7NO0
 5SRfbIWAX+OcKug6ffyiOG+rhrx5bII87ttFXys6FawNs+rCOxFkLTcv27CERNaLJhsS
 a98nptdo35f/swXx6gxrWMI8npgf1kOVeV85YqSAbAREhzeVlIb9kUzpJzBhQ4ACFV32
 WNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705466405; x=1706071205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLu8RNfQOxa+r7scNxZe5YOo/ZxWLLZ6QlPdhb7HAxM=;
 b=C0j/cBZmuVJU3c1H+znOVcPbyZ051MMTpEY0hxIPsN6k/rwLHkXyBi59Rih4ilI/jQ
 MCpOoYA2FZpt4kdRW5xR8mR5d7E4yDfrkMprjeNviPHcMYL+Cljj6jko25IvL7wDbYFg
 FXFTSvxDvO8eGTwyR8Js2FMK1KiGdktbvIC7NKbZB3e89n6OLXhDTKCZ+kNtLm9XeCUL
 njLphaiUEhVhHzUP880IMHEfHXAId3jxxg7yxv5NH+fQq7Q2ZZoR4TS9PSAyhf99T50p
 4ygXcT6yYWZpPaHd7VHmjx3LRE04fKip8lhlIQCT643QoYtHblyIYgvPnOwYYbNxeJO0
 8KhA==
X-Gm-Message-State: AOJu0YxPWa3KAkOUvrKE2ssm7NjK9wYofuJ4NUll+EIMDrDoZZxL6SZF
 wwoxUqmaaHxsNDuT4Q+67brRZHloxh5R3vdxKYZxWAf7z6pfWQ==
X-Google-Smtp-Source: AGHT+IHCu6u+ff48VDfN6Dqf95QQG5BNIdbn4rEMXywDzfwIDfIKDaSBBuLXd+LBQuJnUCmEq99ECA==
X-Received: by 2002:a17:902:e981:b0:1d5:f667:10a1 with SMTP id
 f1-20020a170902e98100b001d5f66710a1mr2280718plb.6.1705466404709; 
 Tue, 16 Jan 2024 20:40:04 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e481:26af:1a49:433a])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170902ea1100b001d403969bf4sm10048668plg.309.2024.01.16.20.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 20:40:04 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 4/4] fs: remove explicit efi configuration dependency
Date: Wed, 17 Jan 2024 13:39:44 +0900
Message-Id: <20240117043944.477358-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117043944.477358-1-takahiro.akashi@linaro.org>
References: <20240117043944.477358-1-takahiro.akashi@linaro.org>
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

