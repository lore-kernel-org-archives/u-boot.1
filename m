Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFDBC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D472A86532;
	Wed, 23 Aug 2023 23:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IoS1/49T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0205864DD; Wed, 23 Aug 2023 23:11:24 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C43C86510
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-792388ea4b3so112720139f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825081; x=1693429881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3tjpjQn6zetRj6319lRSdCTFZMSLxy8168h3jumlsE=;
 b=IoS1/49TNWihigt1sbQcSSyjlC6uk/ZyGZaC2A13ESUgkWiqiqSFuE6ZGWvARRIQhW
 0b7KUcGclkccL1N8S9dbjATjt9cZxU4ZvuKW78MG3wc/9bxUu2qfoLKIJooRXqDKCg4H
 95WLXQxibVnq1mZ3OpfUOPkI73CbEbxoNiH0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825081; x=1693429881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3tjpjQn6zetRj6319lRSdCTFZMSLxy8168h3jumlsE=;
 b=XsH0xvphjpolx+54Dzp2C5D1Dly7TpEXdWu2RalJ1meK6cdw0ZVWbC8u27SLGe4pNv
 F9hK4Tnn1xUSZ1T5RXnqt8MATwKe0TqZSOBKL7qFOGwSNibD46NRYTpTTPqz8vm+asG6
 kcYWoW7EzCBC3U1EFqnquOMRPAtyIk4z8GDQymW7MvkTs+VkCOkSESQEu/UGGJGDIdND
 mEDg0FU84MkpHPV6oDndNatcb0LjxTxFQV9wxRQhCwPN8eLfvVuLz21/vyHb+tC0mPGo
 U4+Gm9OGblWRjQszupNMo5p+7WLh6hlpMveHDCuYet6jpv3VuYOqxET2l/+nqjpEgT/Z
 vCdA==
X-Gm-Message-State: AOJu0YyDP6yAl/kptj1aD18hepOVX5JsVCMQ2FJppHtK0roOYeB+ek0V
 wEFzdoQ1VR0MFAfqW+inMrKJyp1vCW9joaLvxiw=
X-Google-Smtp-Source: AGHT+IH8Z5eLZDgArHXtqWJ5Q4WSFYpYXXNneATfWRyXh+jrXE6/+WsfX0Hr9lPZPTPLirdQe1O6lw==
X-Received: by 2002:a6b:917:0:b0:791:1e87:b47e with SMTP id
 t23-20020a6b0917000000b007911e87b47emr4097041ioi.15.1692825080844; 
 Wed, 23 Aug 2023 14:11:20 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 16/20] x86: coreboot: Record the position of the SMBIOS
 tables
Date: Wed, 23 Aug 2023 15:10:33 -0600
Message-ID: <20230823211059.1235147-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index dfbc80c430e..f7fd9ea5bcb 100644
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

