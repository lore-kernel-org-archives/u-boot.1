Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD68CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 19:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A503883A4;
	Wed,  3 Apr 2024 21:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pBTDh1uE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65DE88359; Wed,  3 Apr 2024 21:07:38 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B3888393
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 21:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A0483FE1E
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712171252;
 bh=dVSIyVRFAlBfvInoDuMz4NzfBgRgywhUUJ/CmscLzb8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pBTDh1uEnVrKW+nuvfMeplVWjEW+XlWwQZ/3NP+QDcHKYENP46PEyqT7c3dNGoR8r
 5V/PQs+YWN/dVl+YAG9KYdopiS92+2zRjPwsBR5GiCQdnyXm+vZXlBlCcNsecx6tjI
 5o4A6BuJIbWMpC6hl5D+9ll9EQqOD4Tb8hS8Wrjk9KruCbk1Rvj+pKYE0vMJp9Xsea
 cwnBC1OCMx87h1pYOp9tZ6p/h1ESD+VbtIFIwsQ2gBxcTb2gTTMtBSuknDF26bINFK
 GrDGCHiquzB3B/JK3rhLYT4aVgdpMa6LJJEUGQ/m9De2C3eFY5n4jnBJeBpC//1hsW
 SyNxKMTf/+60Q==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ed71800f2so69901f8f.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 12:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712171245; x=1712776045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVSIyVRFAlBfvInoDuMz4NzfBgRgywhUUJ/CmscLzb8=;
 b=HdR6QC3vfJiTQxzee8m6XRtM/Jice5iw0AHp8TC+cZ/JMSA68kU1fZI1ke6MDFGyaF
 VvCbU+pcj3AsfMZsAlalWG+8q7EGKnOFm76nCrESfMrTLftaQWbCLjxakPWRBN129eKA
 5lhVlXBKY6HMXgukanpMdr/EVcA3cYpOOctFE8UPPzURN2ofEMD5y2G1OdGjsGpmfaAz
 OhcGHhdc+IxCiNiBaKzbhNdSraNnZA+4UqMheUfbwIOcXFAwgGj+CCNWhKfUxKuyOPE/
 OYbeG/a84ZTOiuaCkOrRW+UglQg1ubxWQY/lKPPc9CT3VpKO2Uvd7AMBsGsQmEjUhf2m
 OLFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaXhdPEsIFBhjDqU7rBjqq4urLjfPTCRrJUxF1WhprhGxBcVGpU0aLoINE5uAisqC9gPO6wXJ0lQ3Jg+CFAMYaj4v0wg==
X-Gm-Message-State: AOJu0YxG24YgOWjZbsm2w6PGfASkdb2aU5/U+k8FdQEvl5IaX4zZ7B5Y
 EnKPoW0VcLD+L/RixUSstDSCCiIiSJcnzRs38tg2DPWmsIfAjSIkFtqkOK13IVKtHFJ8cfAfcOD
 GQlmgLk3t5C1VladiYJ4QUrBnnGROOn5xaRJC15rvL2qvodUvuO/cou7Bt1ao8oLSjZs=
X-Received: by 2002:adf:e845:0:b0:343:9d4b:d920 with SMTP id
 d5-20020adfe845000000b003439d4bd920mr291805wrn.40.1712171245721; 
 Wed, 03 Apr 2024 12:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiTlxfahnx3nRcVVW8gQz/5cI2XK6n7nl4548W3yW/WZsmj9n6IRK24AAT6m85LNh+GTR6kA==
X-Received: by 2002:adf:e845:0:b0:343:9d4b:d920 with SMTP id
 d5-20020adfe845000000b003439d4bd920mr291789wrn.40.1712171245407; 
 Wed, 03 Apr 2024 12:07:25 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfef81000000b00341d84f641asm18042610wro.8.2024.04.03.12.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 12:07:25 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Shantur Rathore <i@shantur.com>, Mathew McBride <matt@traverse.com.au>,
 Mark Kettenis <kettenis@openbsd.org>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] boot: enable booting via EFI boot manager by default
Date: Wed,  3 Apr 2024 21:07:14 +0200
Message-ID: <20240403190715.144725-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403190715.144725-1-heinrich.schuchardt@canonical.com>
References: <20240403190715.144725-1-heinrich.schuchardt@canonical.com>
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

If UEFI is enabled in U-Boot, we want it to conform to the UEFI
specification. This requires enabling the boot manager boot method.

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Makefile b/boot/Makefile
index f0a279cde16..72c3feae0d1 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -34,8 +34,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
+obj-$(CONFIG_$(SPL_TPL_)EFI_BOOTMGR) += bootmeth_efi_mgr.o
 ifdef CONFIG_$(SPL_TPL_)BOOTSTD_FULL
-obj-$(CONFIG_EFI_BOOTMGR) += bootmeth_efi_mgr.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 endif
-- 
2.43.0

