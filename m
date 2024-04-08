Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC8C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796C088126;
	Mon,  8 Apr 2024 22:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=loftorbital.com header.i=@loftorbital.com header.b="GBa2is8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7BA88151; Mon,  8 Apr 2024 22:13:28 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AABE8813F
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=loftorbital.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=charlie.johnston@loftorbital.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e4149e7695so10758985ad.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=loftorbital.com; s=google; t=1712607204; x=1713212004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvBhbfMo/cJDhK1/IH9uCTwfBAcOn8BW74QWSuy5Axo=;
 b=GBa2is8xEEcIBM5F8xEZluXLq7hY3udRoltDEM950IMRSXbjyl1JOLmQMQ5WyYS1Vu
 YC1MPV5FYv7eMdhH4VllLI6x1OnDNzSFGpcnPJ334891ZMt/Jaoi6UyGAsazvZvaLXT+
 vW/VE8WG6N1LT/YY9wG5LgN/HMXq2vOZBazRDGk1U6hykwkawZrzXPLeLao14z7Xb/VO
 3zt7/yKFBPKbQiFsLY43rTEoozuHvt8ywFfOWVqVLpt/vGRMDLQ7tA+xXXbFCtzfwwO1
 dPnk9bYrtHkYWcdTW/BDHhMx4ADVbfQ2rPLIjX1PWgaDoCfSgDO991zqiUBc+lVER5KZ
 7MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607204; x=1713212004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvBhbfMo/cJDhK1/IH9uCTwfBAcOn8BW74QWSuy5Axo=;
 b=YXJbs5TJTlULww0/6rfwlS3we1WF1LYK3mLU0tUhHSOSEkz5ioVhk1n++MGdc/LkRD
 s6pq3L+9s6BdfrHeR4Xu5UgL9ibVokb34h4t1osomEVHq3aSnP8Lk8oJUY7hQ+w32ytJ
 5DCAyIcVtxSqHN5N49iWzhTfyvLhpZkENKbTNc1efaK4lGGgidSNdBns0o31/0H0zQAx
 85fqrlQtJfNkR+CfZpbr4F2Q0QJvYicNVvfoHYCm/ulhyli3p/kZdJD4NoJKdS5q69q9
 dtl/sZ22u5ojZiEBcVbKbayIZQ73Zl7lZhYFe4C9gC37v0BISk1X1wbLnt7JG3ZbNPQA
 u2rQ==
X-Gm-Message-State: AOJu0YzvlEDb4IcSltQvqCanXlmk1klbi3o5PWj/1jX/nElzNFrDZ2xL
 9wh0kSnzVCCc7E2ZKDAlI4zoWNBqqk8YOSEwf/7z17TIVhOupet0BWTnesJrBBRiuVO6nmUOoDe
 5li0=
X-Google-Smtp-Source: AGHT+IEzLtiEnrhlvaOZ/rTN6kAABCd6i/qT9CdyFDff8s251uags3B5fYHncP+2tNVLLH2saqd6iA==
X-Received: by 2002:a17:903:2349:b0:1e4:6253:75db with SMTP id
 c9-20020a170903234900b001e4625375dbmr2238579plh.17.1712607203953; 
 Mon, 08 Apr 2024 13:13:23 -0700 (PDT)
Received: from cjohnsto-vivado-vm.. ([12.172.216.189])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090264c900b001e3dff1cb4bsm5150982pli.19.2024.04.08.13.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 13:13:23 -0700 (PDT)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>
Subject: [PATCH 1/2] board: zynqmp: Move zynqmp commands from board/ to cmd/
Date: Mon,  8 Apr 2024 13:13:12 -0700
Message-Id: <20240408201313.10183-2-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
References: <20240408201313.10183-1-charlie.johnston@loftorbital.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Apr 2024 22:22:35 +0200
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

The zynqmp cmds.c is currently tied to the board but the commands
contained within are more closely tied to the architecture. To
allow usage of those commands when the architecture is ZynqMP but
the board is not, this change moves the cmds into the cmd/ tree
instead of the board tree that would only be included if the board
were also a ZynqMP predefined board.

Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
---
 board/xilinx/zynqmp/Makefile               | 4 ----
 cmd/Makefile                               | 3 +++
 board/xilinx/zynqmp/cmds.c => cmd/zynqmp.c | 0
 3 files changed, 3 insertions(+), 4 deletions(-)
 rename board/xilinx/zynqmp/cmds.c => cmd/zynqmp.c (100%)

diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 204e4fadf0..9ab50eca40 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -40,10 +40,6 @@ $(obj)/pm_cfg_obj.o: $(shell cd $(srctree); readlink -f $(CONFIG_ZYNQMP_SPL_PM_C
 endif
 endif
 
-ifndef CONFIG_SPL_BUILD
-obj-$(CONFIG_CMD_ZYNQMP) += cmds.o
-endif
-
 # Suppress "warning: function declaration isn't a prototype"
 CFLAGS_REMOVE_psu_init_gpl.o := -Wstrict-prototypes
 
diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a..7afb1c9a7c 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -232,6 +232,9 @@ obj-$(CONFIG_CMD_SCP03) += scp03.o
 
 obj-$(CONFIG_HUSH_SELECTABLE) += cli.o
 
+# ZynqMP
+obj-$(CONFIG_CMD_ZYNQMP) += zynqmp.o
+
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_SANDBOX) += sandbox/
diff --git a/board/xilinx/zynqmp/cmds.c b/cmd/zynqmp.c
similarity index 100%
rename from board/xilinx/zynqmp/cmds.c
rename to cmd/zynqmp.c
-- 
2.34.1

