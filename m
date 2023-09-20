Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E0ACE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB6E86C70;
	Wed, 20 Sep 2023 05:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jkbn5A19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF71186C7C; Wed, 20 Sep 2023 05:00:48 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34A586C7C
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-350f43b9c3dso2619005ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178845; x=1695783645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XHuvasCW+M4MKZTf21DSeskM8ShaOlrTLUpJ6N5Jok=;
 b=jkbn5A19PSCcfuiAH+3g9Ol4B28C4pwY6x+vl27gi/LPAMdIR9XB0FGU5mseSthJCq
 +8GjFrK45/6gYg/UKqwoPfFk8MpFPb51vmqqCh9SVrSrFHkeN9SyU5ecPqt5il+6h2NX
 pSWRqeZ/ZOW7kDh73+dmQnH3vLWw2qpjUmgbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178845; x=1695783645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XHuvasCW+M4MKZTf21DSeskM8ShaOlrTLUpJ6N5Jok=;
 b=AYhoCGeYrBh3ZRKT9efKx+KYT9Rk3Q24km9C4RouEx0RpqkHpH51+asnKA3JIFNuRq
 UCSB7tz3VrYEGBOeGZhX9pLovNTAJK6amdKAYCxpHjYu7RJzJVRkMfM3fCaQo9Plrq24
 sItQrsh7hWA6T6MOlrsnSMQC/8aUyq2GlZmijBtJpBmJc37iQmO/9TK2bnnXcOdU9/o9
 X0jgduMIUHDSuDddhqU1qvBFBxl+fBJKaGyibQjmqzxvd63fwQVAOkhIrIT1DfrTqPBN
 LDqTRKrY7wRvCiEh6/zz+cDFoJ0kDGXafKv4VWy6hYqJldYHfJrHLsf2RfJxczz6E1FI
 E1aw==
X-Gm-Message-State: AOJu0Yw/pFj+Hp51JRzci2m9hoDxTLPrD3Pb3zfojm5+OCa+yOvi8vy6
 Z7xkaedRpG3ww9zJLnqPHjjKUg+gDYkQiPoHrYM=
X-Google-Smtp-Source: AGHT+IGD59abfKX7aU1eTwcRGUZ75DIrOFUal3dhCwxNdSF4iA4zYDhWjpNXt2Z1dF2kOFtrrkfxog==
X-Received: by 2002:a05:6e02:4c9:b0:349:8a8b:70ca with SMTP id
 f9-20020a056e0204c900b003498a8b70camr1454650ils.14.1695178845416; 
 Tue, 19 Sep 2023 20:00:45 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 16/20] x86: coreboot: Record the position of the SMBIOS
 tables
Date: Tue, 19 Sep 2023 21:00:17 -0600
Message-ID: <20230920030027.1385833-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
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
2.42.0.459.ge4e396fd5e-goog

