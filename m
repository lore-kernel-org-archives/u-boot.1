Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AE0C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 12:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFEC87250;
	Thu,  7 Dec 2023 13:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="efYoRrYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CC887250; Thu,  7 Dec 2023 13:36:42 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E0687185
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 13:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso865693f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701952600; x=1702557400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=okhtmQk7THfQQG6Mwhe/BBQxa8lXBiFZZmSgVs+fIUU=;
 b=efYoRrYmAjn1QmGszXorB0jmIHtI6bRO0HtL9LcCxAWcTgNgrH+eOUR4oSOnstDxIq
 D5JOYRip8p9CV4cQszHMZaky203U2eB9qUaA2emKEJvLrDDJQ7+Vskkbn6gX7EwPiY49
 8o/O6KG7Ua8iw51WqQGNGe5Kr3tzu5sAv3uQf87CCj03f6b1Z4mNWoT2XrB8Q0Mw4yJi
 QTgTP2Xdpv1uiRMvg9jw70D5dCThZ99iatryKrdh091zXvX+/lnEdQsVfCEyjLLXBK4A
 g94n0sz4XJygTHQ75V3WmHVpTQSCV+VY25eVTIEU62DofpMu8EAy3LjRfCbvvWGJDMhr
 B3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701952600; x=1702557400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okhtmQk7THfQQG6Mwhe/BBQxa8lXBiFZZmSgVs+fIUU=;
 b=SSdKY6nkpoiqD+OIITAHzEia7hYlSdQN1cpWuyXEBA7WXBvVmugv0dU5z4lbTyAQib
 GVtsbsenrlzw2uUQMRpoM9C/BfZDKai/0VSj9y0eoA/m6i/Sn6nmBMZt6kVcdRZthed2
 aVcd0Dy0/yBmnLYknVGZCN7UAte7oa9caBIA15aoWFvB7umzrWl3QNaLCL6ENIOkfR/X
 qK7zJtYjgHQ/z/eokz/h1EGNVPYHtfWOzgQ+adkCLgqRDunpeQ4XmUEf+8JFVCVEqyT6
 VoxjxMdQuyQ0UxbUUblLzU/ycsQiL5RHEuimtcH0odVs2yMKMfPVX972gdzR7nGuBWtL
 nS5Q==
X-Gm-Message-State: AOJu0Yw6x4QRJlUAxCYHf761eo72xg5j9NQrnLIngwlEQEuQrn6+nCM2
 wWmzTlRqYLQIebB9O4+LyYFCkQ==
X-Google-Smtp-Source: AGHT+IG3Pfd0Xfzj42ZVLmTRqlHZZn3kigoDevcUKh5aWG/nQfah78jiXZ8u63MxcLihwdoBSb/xEA==
X-Received: by 2002:a5d:4208:0:b0:333:2fd2:4ae3 with SMTP id
 n8-20020a5d4208000000b003332fd24ae3mr1588825wrq.95.1701952599840; 
 Thu, 07 Dec 2023 04:36:39 -0800 (PST)
Received: from localhost.localdomain (ppp046103111243.access.hol.gr.
 [46.103.111.243]) by smtp.gmail.com with ESMTPSA id
 k18-20020a5d5252000000b0033330846e76sm1325848wrc.86.2023.12.07.04.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 04:36:39 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org
Cc: heinrich.schuchardt@canonical.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: [PATCH v2] bootstd: Fix a memory leak in the efi manager bootflow
Date: Thu,  7 Dec 2023 14:36:36 +0200
Message-Id: <20231207123636.26264-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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

efi_get_var() allocates memory which has to be freed after the value of
the variable is consumed. Free the memory properly

Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Apologies for the quick resend but the previous patches wasn't compiling due to
the missing #include <malloc.h>

Changes since v1
- Add #include <malloc.h> since it's needed for free()

 boot/bootmeth_efi_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index e6c42d41fb80..6428c096d7f8 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -16,6 +16,7 @@
 #include <dm.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <malloc.h>

 /**
  * struct efi_mgr_priv - private info for the efi-mgr driver
@@ -65,6 +66,7 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
 				&size);
 	if (bootorder) {
+		free(bootorder);
 		bflow->state = BOOTFLOWST_READY;
 		return 0;
 	}
--
2.40.1

