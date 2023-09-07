Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464A4EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0208786A94;
	Thu,  7 Sep 2023 17:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TyHfjRhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3C386A6B; Thu,  7 Sep 2023 17:58:42 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4B786A63
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-794c7d95ba5so46483639f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102314; x=1694707114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iRGmvdOVYal8Qaong8UvyC1zRg6DTFiEgv9/rnu2vo=;
 b=TyHfjRhNmy96qf73teNFileUVZ1Z2syTqPbtujQcN6KAMPq3jWPLRi5CKnD+EyNXDM
 qMT8/YKbx/MWqk1+PJ81QgIpD/hr/qCMN2MnU624roEEIXbW+Im1rEHs2DAhu4WhNVNv
 raqmgctCVGLwCpV1cQBninU0BWFHOxR8nBh0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102314; x=1694707114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iRGmvdOVYal8Qaong8UvyC1zRg6DTFiEgv9/rnu2vo=;
 b=hLZ4EMSepgZBKEiYI30LBZwK3drOTQ7lCVky/u0HW/4ROFdFqXxV+lAw88WjpyMM+z
 AXlWnWJIkKBZ8kwEjmYZmykYZeyPSrQrTeeLRkiBi8Nkrm1P2J1xpEmT4YbJECQAmSKV
 R0L0jm9avbd+mcHOKaS1khbfBPrYVFgp3ShVdHcL1sO6Q7xPW4HT3QpeDCdWj7OUCrdh
 1PYFq62Wq6fbe5uLf/y4M9VzwSEWZIiiFpMmNmY6ucmYYfTMNEZb35QaxXJFvunv6BdF
 DjBtKAVPs+2Cv1STv4DbUI4TUf+alhHRUd1A/7wSMX+XpIyGiMt7w/H/9yhK+JctsnJu
 sgVg==
X-Gm-Message-State: AOJu0YygjBORqBhQ+YC26QLsTB0rpFKDS2YqjRVjA3HJbV06GdmV+AaM
 hE484zw3EG3CcPdnKqr9d57Dv/v0gC/+KPyi8yI=
X-Google-Smtp-Source: AGHT+IGEAlPvg9JGDZf6uf9AJrWYeT8JTH/7jdo4/+mTDqcGHk78X+FF9AmscraoY2ZDneWGRvSyzA==
X-Received: by 2002:a5e:8f06:0:b0:791:3db9:c97b with SMTP id
 c6-20020a5e8f06000000b007913db9c97bmr92246iok.17.1694102314025; 
 Thu, 07 Sep 2023 08:58:34 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/9] x86: samus_tpl: Correct text base and alloc sizes
Date: Thu,  7 Sep 2023 09:58:16 -0600
Message-ID: <20230907155825.48056-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

Make sure that CONFIG_X86_OFFSET_U_BOOT is the same as CONFIG_TEXT_BASE
as it is changing CONFIG_X86_OFFSET_U_BOOT

Samus boots into U-Boot proper in flash, not RAM. Also expand the SPL
malloc() size a little, to avoid an error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v2:
- Reword commit message for clarity and to fix typo

 configs/chromebook_samus_tpl_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 33ada9fe4f93..9dd29401ef12 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -1,6 +1,8 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xffed0000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x3F8000
@@ -19,7 +21,7 @@ CONFIG_HAVE_MRC=y
 CONFIG_HAVE_REFCODE=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
-CONFIG_X86_OFFSET_U_BOOT=0xffee0000
+CONFIG_X86_OFFSET_U_BOOT=0xffed0000
 CONFIG_SYS_MONITOR_BASE=0xFFED0000
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
-- 
2.42.0.283.g2d96d420d3-goog

