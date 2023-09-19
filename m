Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E8CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 21:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2F486BC0;
	Tue, 19 Sep 2023 23:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgDi4UR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D88186BDC; Tue, 19 Sep 2023 23:27:48 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359AC86BC0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 23:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59c268676a9so38853637b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695158865; x=1695763665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NcVqTg1uj81hHFD2+rfmf/CyEy4o3Ogv/Y6EUhfKpQ8=;
 b=UgDi4UR9/FwxWd61mhsDHqCX1YHjRS0DwZJjeNgP1QJTAyN76FVWAQnozPeRVMYaAl
 rbmU3Z6a4Etauc6pjvEg8mzGsO7WgBzCP6LnRDxeKjmpfto+8n+6ucG7KDcCL+8DOdxH
 0qlBvF2UucBuC3SE6b/RCcPgeZcRD2+Y4hL9hLMc6fZlbJrocihAP8ESEwanbbAMf7XD
 6xmDh/EP2YU/4DwccVGzsOYLvaI6V9Vf2+RLQweBoGOtbAkjQ699kUzDv2KiAoGOvZ/K
 TBhNPQj3NvSa0j261bLc5+a0XqQiY/OlXqHwcNDOG7RbQ78B7TFlEAWzda7FmFBkhMNf
 3X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695158865; x=1695763665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NcVqTg1uj81hHFD2+rfmf/CyEy4o3Ogv/Y6EUhfKpQ8=;
 b=BcIDfmswYvFoVyp4ETpC+jKnv4Oscdqn1gh2blznqHyW0qoydsGmtUL1bjA26kapjO
 UJXv3zHmNdVLDbYcDTBGK9NvNTdMM0GLREzYEf6BI+nWPBsHcD8YhI4mAohqnmOflta+
 AACP40xz8nYZC1VLlt2Le3+Xvy90jeFaKx0WmXEH9bs3asEzPHt0a+GVLrYz/GerExT0
 YVOyWPeKRcpKM8i4bh7P59AhJzctsCyJHZPgiO/eotKnomYVxhc1w5Y6xXLuXtTOaDQX
 bwPBae8HVr8bsn1mv54r+nrXWGeFRmrulbxxsIQx9FIOqfA/l5N1olVjeqkdUvPaXn/l
 imxg==
X-Gm-Message-State: AOJu0YziTwYTMpY2SpPziWdRW8QP+fGPhqt6oVcec9LN+PcjLgtVrMeU
 KlluXHUWVubJ3DDuSGkiQUQ=
X-Google-Smtp-Source: AGHT+IE77pigjuqf9hmqceS7x+QcC0g7yqExu0MFirrvpugp2VdHM9DuFwdZZZOvHLSR4t9At33vYA==
X-Received: by 2002:a81:4e95:0:b0:59b:c847:bce0 with SMTP id
 c143-20020a814e95000000b0059bc847bce0mr745767ywb.42.1695158864844; 
 Tue, 19 Sep 2023 14:27:44 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d64-20020a0df443000000b00592a065e2a3sm3420492ywf.87.2023.09.19.14.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 14:27:44 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] bootstd: use ARCH_DMA_MINALIGN in memalign() when allocating
 memory
Date: Tue, 19 Sep 2023 14:27:21 -0700
Message-Id: <20230919212722.16216-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Use ARCH_DMA_MINALIGN in memalign() when allocating memory to read the script from the media.

Ref: https://lore.kernel.org/u-boot/CAJaLiFy05F3Cr4X4G2mVkppXnBEFZrHQ+5CngYN8eJPg8ENWkg@mail.gmail.com/T/#m26daadc2463fe653b814a94e6309e5e6bb6be1d1

Note: this patch depends on the previous patch
https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 boot/bootmeth_script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 96e0ec5efa..de2e510da1 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -99,7 +99,7 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (!bflow->subdir)
 		return log_msg_ret("prefix", -ENOMEM);
 
-	ret = bootmeth_alloc_file(bflow, 0x10000, 1);
+	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);
 	if (ret)
 		return log_msg_ret("read", ret);
 
-- 
2.39.2

