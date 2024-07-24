Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3F8C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12368889A2;
	Wed, 24 Jul 2024 17:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AD4HbJv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FD988998; Wed, 24 Jul 2024 17:09:55 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F179C88937
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-397580fa3bcso16625045ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833790; x=1722438590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umySgzg14Hj5caFHTAXnD9kfmnGkFSowCYsoJhEthFw=;
 b=AD4HbJv+HYdoZVNBQ7Hp9JA9VS2xCHvI8dGVO8TSGz+nD1Kf5HjYVZXeH7FjiqDqjf
 gXE1rHPf2KW19QQfU4ofMeOIsewnhje36WexI4lWvrxMI0kelCg/4IwdJfR7CBsFhq50
 WmUsC6NfCCv0GbQOIt1glL8Uw7w2ISdfPMeMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833790; x=1722438590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umySgzg14Hj5caFHTAXnD9kfmnGkFSowCYsoJhEthFw=;
 b=DBxthikpupAy8B3WX5RUACuI3k+B52q3TeyrJZb4t7dKSYwpnGw5XohBqg7F/fGPOh
 cbj/1vyu17P78evPWvuEW50bpAvFNGGzshlunAXWSpqh3qy7ao7UeY2obusA+79B8mla
 MMCDcr5TK11JJYwagr5lIQ/p9kQnDMrJjGHYTUKBK6gyqYR67hMpFbb1qErCHjwLAdIw
 vQYidRiUA9e8bCwhiPnPc7xGMlx/Oz2ov0U9RN+DqNJ0nFkfUmP+ccKYdRCg1AlP49O5
 tHMuZa1JFEq8HPbIvuVzyCdA/h/Yi/y+gSElJA8r9Ux9fs6SfW8nxmIl5bIi8thl38sj
 tVUA==
X-Gm-Message-State: AOJu0YwesE7rLq0Nu6+aQbVbHBeOA4EUSOt/pnJed56QCFKqNt3XBpfn
 CqIGs26BYqgLnezZZ9I18el82Fm4Ly/x5wjdX14ye7/DmMFQm9jfonMtHDssLH81ch3Yzng45sQ
 =
X-Google-Smtp-Source: AGHT+IFLeJvWxrWcvv1/djL8+ijMBfzG+RsFaotptzb9vV+iM4nIQC+SmRZmdnzTqabNKK4Kb1YGbQ==
X-Received: by 2002:a05:6e02:17ce:b0:397:2dcd:80e5 with SMTP id
 e9e14a558f8ab-39a194d8668mr30151045ab.27.1721833790616; 
 Wed, 24 Jul 2024 08:09:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Janne Grunau <j@jannau.net>, Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 15/35] global_data: Drop pci_bootdelay
Date: Wed, 24 Jul 2024 09:09:02 -0600
Message-Id: <20240724150922.2343249-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This is not used. Drop the field and the environment code which uses it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 11 -----------
 include/env_default.h             |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e57015365c1..d8be0654a87 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -296,17 +296,6 @@ struct global_data {
 	 * @malloc_ptr: current address of early malloc()
 	 */
 	unsigned long malloc_ptr;
-#endif
-#ifdef CONFIG_PCI_BOOTDELAY
-	/**
-	 * @pcidelay_done: delay time before scanning of PIC hose expired
-	 *
-	 * If CONFIG_PCI_BOOTDELAY=y, pci_hose_scan() waits for the number of
-	 * milliseconds defined by environment variable pcidelay before
-	 * scanning. Once this delay has expired the flag @pcidelay_done
-	 * is set to 1.
-	 */
-	int pcidelay_done;
 #endif
 	/**
 	 * @cur_serial_dev: current serial device
diff --git a/include/env_default.h b/include/env_default.h
index 076ffdd44e9..aa3dd40f3fa 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -82,9 +82,6 @@ const char default_environment[] = {
 #ifdef	CONFIG_SYS_LOAD_ADDR
 	"loadaddr="	__stringify(CONFIG_SYS_LOAD_ADDR)"\0"
 #endif
-#if defined(CONFIG_PCI_BOOTDELAY) && (CONFIG_PCI_BOOTDELAY > 0)
-	"pcidelay="	__stringify(CONFIG_PCI_BOOTDELAY)"\0"
-#endif
 #ifdef	CONFIG_ENV_VARS_UBOOT_CONFIG
 	"arch="		CONFIG_SYS_ARCH			"\0"
 #ifdef CONFIG_SYS_CPU
-- 
2.34.1

