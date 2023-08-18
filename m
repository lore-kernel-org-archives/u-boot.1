Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BEBC2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AF186C58;
	Fri, 18 Aug 2023 02:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XlpjiUmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CE386C03; Fri, 18 Aug 2023 02:27:32 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0F586C04
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34aa0a1a2fbso1406895ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318446; x=1692923246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw+fXDGW0ORqQGpeFAJg7lg0B6ppN/S3FqAkTBvF5tg=;
 b=XlpjiUmBmpOo+LuPOl6L2Ea5eD1Kd0H6fCr8/4iPMHVQEAUpITXqEkXXFO+2/6jYQG
 xJS9PcEXQzEw+JnkFwmdHjWOUhsg/uiernKwXsxYOFjxEzqwVDJjzkk6YiYVTYYaijtS
 k0knV/MvntKXxJvBJienwIBAdiyb5BBreUUss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318446; x=1692923246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw+fXDGW0ORqQGpeFAJg7lg0B6ppN/S3FqAkTBvF5tg=;
 b=b76dbMLeCP1lx1MIvJzXFYroYEsGuGqYxOzkleTemtg4imJ5eIR+cPrIyetvZHuP6i
 5OEhp4dBcf6U6u8my5+T1NcZvabAkR/4/xaC+Z2VlJVFLA+gPZER0VShUzhXbKe5l/Bd
 YU6Lp1jvP+Z6vcaQphGrIjxA2g1y1B7257FYDiZK6NRxjhptu9J+2XbN2fiHphS0dujW
 QZ8b/8FO1Oc3AG6OtkZ+HtOtXQ5+mVR7NiY/TqfXNnAedZqC4QsE/gSpSNQFa35lAjph
 nrVps05g7A/lc4j9JEi/f+tTjsvlDfVuxlqRk0KPOqCGuXS5aT/SCcjCHOBRh+aR3k9c
 jk5Q==
X-Gm-Message-State: AOJu0YxyDwrAP69a4M/SVMOlYu7kIPInKseObtNgfBg+SRGSD66Nl4xq
 VogyeRfCGuCWaGYk0K3rouGly3jZ8lNRdljw93g=
X-Google-Smtp-Source: AGHT+IH0NNi33/rJs4Si6trGkkaHMJgM0JSTkx0G6dt47t+w+dkjimYFACxB/MsZt6aN3VFAbG5sEA==
X-Received: by 2002:a05:6e02:1241:b0:34a:a178:637a with SMTP id
 j1-20020a056e02124100b0034aa178637amr1222792ilq.24.1692318446606; 
 Thu, 17 Aug 2023 17:27:26 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 16/20] x86: coreboot: Record the position of the SMBIOS
 tables
Date: Thu, 17 Aug 2023 18:26:55 -0600
Message-ID: <20230818002706.853550-17-sjg@chromium.org>
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

Make a note of where coreboot installed the SMBIOS tables so that we can
pass this on to EFI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

