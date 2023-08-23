Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1D4C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9A6864C4;
	Wed, 23 Aug 2023 20:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R0oP5kfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FB186445; Wed, 23 Aug 2023 20:48:03 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FDA86434
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79243040c2cso86999739f.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816480; x=1693421280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g19pHIxHIt+B41cocTlgAXT7AUhzyofbbk7x4IJHpcE=;
 b=R0oP5kflhPY/HyfjHc+fb/hR1tyP4BZt6YnlgHPNLCUDOnbsC3sDILDk0jMYpsXhAE
 nwVwVMWCdlN3iFhrGWjBDbnSPhwRAAvYIlILqAthDkvTbWO4HfUnF0Vrz4V+gNkdaRy7
 3rQZ+mFj1/NfEiYYwBXVSC9DI/+YoFvoH2dDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816480; x=1693421280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g19pHIxHIt+B41cocTlgAXT7AUhzyofbbk7x4IJHpcE=;
 b=SBi7lSEuY1H+0sstdEbTAwn/u5for2xaqGvitW6qeTwhpHHHYHl8sLYllHgSAGqd5n
 MXFGf/lDXUx34wdqWWDCQ+7ywjAACpbJlF67WZb3mcSwcvG6wd3V9ypMKwoP+o564Zz1
 AFyw6rMoOt8bioumwI67Bh8+NB8ztx/UzpH0imUgGGzFuhQfY69eKvXGoG37mfvEPZgg
 SLo2ZhXjc/JDrsHSEJyKVYVyLYI/jq35yG41YWPXTaf0iu7onJNNB+SJVsOX3Na63RFn
 I3AIN5/JZDH2V9wuh+B5DQwJBxd66Cb8hcPTMZS4xcXw39AADc4KCaL8sxenE58iccy2
 Go+A==
X-Gm-Message-State: AOJu0YwKK9jXqXRleSfgAecICVokCygJLeG138HLujlsiCcOxpk+daA+
 I4dxuVCMuj1glGS4UTY/iOaZiBc0yEhD9ZkxlS0=
X-Google-Smtp-Source: AGHT+IHjswD1qvqc+QnDP+JbxOSi6l96xD4Mi7cw4DdkdjKmqqxKiLENaYxFmzrpTUgacGmeLRH0Rg==
X-Received: by 2002:a05:6602:1783:b0:790:d6aa:5921 with SMTP id
 y3-20020a056602178300b00790d6aa5921mr3921136iox.6.1692816480473; 
 Wed, 23 Aug 2023 11:48:00 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:47:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/8] x86: samus_tpl: Correct text base and alloc sizes
Date: Wed, 23 Aug 2023 12:47:36 -0600
Message-ID: <20230823184746.842091-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

Make sure that CONFIG_TEXT_BASE is the same as CONFIG_X86_OFFSET_U_BOOT
since this boards boots into U-Boot proper in flash, not RAM. Also exapnd
the SPL malloc() size a little, to avoid an error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/chromebook_samus_tpl_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 4cfaf4bc5c7..6fefe2ddc25 100644
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
2.42.0.rc1.204.g551eb34607-goog

