Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07454C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD0183096;
	Tue, 12 Aug 2025 19:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YF+XCdzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075F083087; Tue, 12 Aug 2025 19:46:31 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C185682EB8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so7079160b3a.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755020787; x=1755625587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLS/kaQsqSLaE7XRnfmINVKhfz2wxALo2EKBS6I9GVw=;
 b=YF+XCdzh/TLyDiZayMCHajJWy/iwOrKBocIMN9FhfXMa9lI9mwC63nXEXj9aMenVOX
 UqV2yeh+UVGIFnzDwXSdnljUesd9FCJOeFv8x1vyfalXrMwhQMcloaUKSlzpu02Pf26t
 whL1hxi5XuZ3wf48Lxgs6kZu0S9EvteavJppaOPk5Nb6rIJUGvFWjlbIV9JZIS8CC9uJ
 xjRLI0p3zctLETb3AUUjwQ5bqAc+GFZnFtLt/u7+3KY351+Ina80HGth/wVzAtY/xdhz
 W6wE2aC3ypySzijyJh7//mI6tTuadbG7gmYyFQsPxLHxRl7RK73ce8UoEUxufDKm65Le
 EAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755020787; x=1755625587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLS/kaQsqSLaE7XRnfmINVKhfz2wxALo2EKBS6I9GVw=;
 b=cQbU8ifmQIJZIQG/fQDIP3pVe2+/HKU0F++Ks0rXZbneaMkVQgynCF+Jq/2LPZ9Vq9
 1G0x47U4NAGIyMXJWGV7UDU/D4kbPl8Ou1Xzqzo6p6rT6UTlINrTUBwgowvuOziw6Yg4
 myA4VBuGwEePe1OhfC9m7E2RC5lGnz+6NC2a77VWsM2NzXTfH6OTOJpAaYv2o8mDBFQg
 m15giADhumnyA5MBCdlgjfDlGwoMIpy9mG4jaIbzrZXaxwDUHwaRjPvqdNsBRaI293h6
 Hu/iqsqmgc7p1fATDoRU9A7Bft4G4T3RcGQyzEFBee7SPnhvU5x2wzMgRyARE5EZ/Uhf
 RIPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfuy61yWBYP90Ryy5OpUg1ePmymrUkCy1uQqTPQfzGPCvl2v+L9x3gCTyzwLrB4W3yc/EoWE=@lists.denx.de
X-Gm-Message-State: AOJu0YwiYjTjCQZ6AGpsOM47xx14Lvlv80+AdCXLySaUCZhKtLx+kZbT
 i/vug26SHOuNxi0mzVj0iZ83NB9yDfPbC888DliBxcNzWrT9Hd34y8LXI2yzbg==
X-Gm-Gg: ASbGncsvOTyQzUfjUTk2ucQuek7VjF0a+okKzUQeVdg7ZV98YbORcAroWQjH5G+vhs3
 7D00jU8iOlRR+8omxPW/Wa7/6C5mJzjPDh2rkysxZ+s9A3jbi2mlBsZGrDTq0EAZGgKCwRQM3FR
 JLq33FJ/Bc36ILzhfSs0gzRkorDVbXxLei/hZvlBf8cFF/AnmYm8yYnBVtRFJ9R4Fji7nopDMwl
 VMLdtKChtpLWRRQluwKyFtKEHYluLxIzVhS59miiUkmxa0naUk7vS3EQjjtDA9AQIhvxARdcxEF
 g3ldPQ695ZULOhIWcounzoztuH+PNW6myYeBIRkXUnNU59LBsvyhHjwoWoruOMJmPOmwT7FZI8l
 8Fg1S0HqbmhzpBFnToXaqbVions9brHozkpTa
X-Google-Smtp-Source: AGHT+IGmMBQSWEFeBXDtwB/TMs9ZIWoFtA5uC49zhlfOvFofrju+ZNkiGjj+2E9BY2AQaMUE/XaUkA==
X-Received: by 2002:a17:903:120b:b0:242:a0b0:3c30 with SMTP id
 d9443c01a7336-2430d1f9495mr815275ad.43.1755020787081; 
 Tue, 12 Aug 2025 10:46:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4c8c:4a84:8608:9a5a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7c30sm304527205ad.37.2025.08.12.10.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:46:26 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: joe.hershberger@ni.com, otavio@ossystems.com.br, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] env: ext4: Add support for NVME
Date: Tue, 12 Aug 2025 14:46:11 -0300
Message-Id: <20250812174612.1159634-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174612.1159634-1-festevam@gmail.com>
References: <20250812174612.1159634-1-festevam@gmail.com>
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

Add support for retrieving the EXT4 environment from an NVME device, the
same way it can be retrieved from MMC, SCSI, or VIRTIO.

To use the EXT4 environment from an NVME device, pass
CONFIG_ENV_EXT4_INTERFACE="nvme" in the defconfig.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 env/ext4.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/env/ext4.c b/env/ext4.c
index d92c844ea6c0..c8122b4d22cb 100644
--- a/env/ext4.c
+++ b/env/ext4.c
@@ -22,6 +22,7 @@
 
 #include <command.h>
 #include <env.h>
+#include <init.h>
 #include <env_internal.h>
 #include <linux/stddef.h>
 #include <malloc.h>
@@ -30,6 +31,7 @@
 #include <errno.h>
 #include <ext4fs.h>
 #include <mmc.h>
+#include <nvme.h>
 #include <scsi.h>
 #include <virtio.h>
 #include <asm/global_data.h>
@@ -156,6 +158,14 @@ static int env_ext4_load(void)
 		virtio_init();
 #endif
 
+#if defined(CONFIG_NVME)
+	if (!strcmp(ifname, "nvme")) {
+		if (IS_ENABLED(CONFIG_PCI))
+			pci_init();
+
+		nvme_scan_namespace();
+	}
+#endif
 	part = blk_get_device_part_str(ifname, dev_and_part,
 				       &dev_desc, &info, 1);
 	if (part < 0)
-- 
2.34.1

