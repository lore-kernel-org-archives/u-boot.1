Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C120EC2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CC186C1C;
	Fri, 18 Aug 2023 02:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RAm0/+I9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A37B86C18; Fri, 18 Aug 2023 02:27:22 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A9686968
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7909307ecd1so12608439f.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318437; x=1692923237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fUBrkeyUqQKaQBK2KVE23VRuLQ3O0qrjQ+PCDkt7r4=;
 b=RAm0/+I9mUEJ7rlRl1Rw/Vq2gP1Nu+yz1AbytxJyaVLy3idX9UrYrYg5oFpgeY6T2b
 RgILaYqUKlkyg5+JsK+Jm0gbyI4EwgGXoLkaAcE/0d0VKbGFbx+FTLG7w3LAZq11VhRy
 jmgUInec7Ul4DqtdvTwZr06NOUYRhLH5DpRsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318437; x=1692923237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fUBrkeyUqQKaQBK2KVE23VRuLQ3O0qrjQ+PCDkt7r4=;
 b=EVnDnt3QKA+7Y+kZ+X/KwyV77oZtSPfu6n5ELVRZBIBjgX66GJb3Jt/N88s81XPUac
 74YvcAyQ/PgKjmSX8qdLI9pc2+ECqt4GW9gY9eVjzdRou9zutZ2mQKJBCb0W0eGvz3Mu
 Ywo5wtEhq1TF8SBJduY3pg52Ot7VP2pVmmjVirXVYd3uT0qrCj2PTDKoAuXTXUhNEH21
 Rd0W0vSYBhp4iusGNzGsWEC/bkGE5ieEYsqHMj6gUrL+l471N1dXGfnTBCE7FW373Tov
 eFdACPaa/AjTKv4SScmdilR+Z333CWVOIGZHSJDTDVUU5Kpp39qLjTwC1zu8LhX8qN/G
 l2PA==
X-Gm-Message-State: AOJu0YzOqgAAKk+3FkAUvqAHZ0yhw/mXK5derRbL+pK4eVunqyJzlMAZ
 xPpte6J6qWjMJAF5P0j4rYxuKBgYZGaljylRUKs=
X-Google-Smtp-Source: AGHT+IGigl/VFh6bcu1Xvnq7JezGL+ZBkqnamnpSkL923Hd5HFvpORemhoqZObU0h0bLrs6ZYYX0QA==
X-Received: by 2002:a05:6e02:54e:b0:34b:ad7a:384f with SMTP id
 i14-20020a056e02054e00b0034bad7a384fmr1290644ils.20.1692318437058; 
 Thu, 17 Aug 2023 17:27:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/20] x86: Set the CPU vendor in SPL
Date: Thu, 17 Aug 2023 18:26:43 -0600
Message-ID: <20230818002706.853550-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

We don't read this information in 64-bit mode, since we don't have the
macros for doing it. Set it to Intel by default. This allows the TSC timer
to work correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/x86_64/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index d1c3873dd6a7..2647bff891f8 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -8,8 +8,11 @@
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <init.h>
+#include <asm/cpu.h>
 #include <asm/global_data.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int cpu_has_64bit(void)
 {
 	return true;
@@ -38,6 +41,10 @@ int x86_mp_init(void)
 
 int x86_cpu_reinit_f(void)
 {
+	/* set the vendor to Intel so that native_calibrate_tsc() works */
+	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	gd->arch.has_mtrr = true;
+
 	return 0;
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

