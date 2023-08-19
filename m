Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D47EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE8387051;
	Sat, 19 Aug 2023 23:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kOfjDnbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCDA87045; Sat, 19 Aug 2023 23:23:33 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DF18703B
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79227a7aef0so4902439f.2
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480209; x=1693085009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a10TyUljXKKY46ZnF1BaFOFqE9jbkO7x6CVyXpsuobI=;
 b=kOfjDnbIcDuKAMgr8toL6ZeJX1YWQX9OttsgsTNbfmOah1bvfpmkwsjOPZMBbj3NSO
 KQEk5hrr1yK4Y5RNEO82Hnadei64ryatCuYD2FowSIa09WzoGe62ORSNCE4FUW1JaRSL
 s4tXot4Aa2vLAWFR5j9i4gwi7bibjmMbDS4bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480209; x=1693085009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a10TyUljXKKY46ZnF1BaFOFqE9jbkO7x6CVyXpsuobI=;
 b=aX9ETf+04rCIL6WHjJtOKi9BLyhvpYWH3Gb8sVqZq3oqMl4M1EAQL9rbsh/95cUyxR
 lohP0AC4y+MmFPZnXjMqgdiiFv872zdS8t0QQrcz1WNi+aswNNt7jMClF+Q5o86z/mhG
 JcSHahJYVXfW9eVqcBoLGTrmxfvJTwGzTibBuf564tL9NbcADxCRYrgIKeAeEig15oBY
 Ta/dYmHzUXXdBzo4x/kg2dI23im7vqH/aPgmD59BJQ+nDpmpNXWlXpn21lKAKC36kBYF
 RF3fJ4RNqyswf6dTCMqU50z0buRaiE49lJ8bXLpGTeKcWv6NQcuFwoB1/bTHnZH2nwtv
 W9cQ==
X-Gm-Message-State: AOJu0YyJewKEl9TTSkYgyY5XPpfxdPBFcgoR2vLY+JZ7rtCLPSa2s6t8
 xx+huQdbNKqaAxSs7uOgUFDo3XBaz0JEeYAuaMw=
X-Google-Smtp-Source: AGHT+IG1rQ4foge8QQzN/MmpCL+4rULYsAr07fbIlnLRqIVzNl4OoXg6+XyFQqJw5z7F/y+xsx69OA==
X-Received: by 2002:a5e:de01:0:b0:783:5452:e343 with SMTP id
 e1-20020a5ede01000000b007835452e343mr4283873iok.14.1692480209553; 
 Sat, 19 Aug 2023 14:23:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/19] x86: coreboot: Record the position of the SMBIOS
 tables
Date: Sat, 19 Aug 2023 15:22:53 -0600
Message-ID: <20230819212309.1094440-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Make a note of where coreboot installed the SMBIOS tables so that we can
pass this on to EFI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 arch/x86/lib/coreboot/cb_sysinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/arch/x86/lib/coreboot/cb_sysinfo.c
index dfbc80c430e1..f7fd9ea5bcbb 100644
--- a/arch/x86/lib/coreboot/cb_sysinfo.c
+++ b/arch/x86/lib/coreboot/cb_sysinfo.c
@@ -471,6 +471,7 @@ int get_coreboot_info(struct sysinfo_t *info)
 		return -ENOENT;
 	gd->arch.coreboot_table = addr;
 	gd_set_acpi_start(map_to_sysmem(info->rsdp));
+	gd_set_smbios_start(info->smbios_start);
 	gd->flags |= GD_FLG_SKIP_LL_INIT;
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

