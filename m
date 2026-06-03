Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBD3CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A347B84932;
	Wed,  3 Jun 2026 17:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="tmz7nMJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F72184857; Wed,  3 Jun 2026 14:46:08 +0200 (CEST)
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com
 [23.90.104.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D1F8485F
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780490763; x=1812026763;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pucPL4T1jFXx1f7dHhwm1EIuPp+ELddAT4ZZL6nnXvQ=;
 b=tmz7nMJBdOvjpnuTNgB1rcMSEehcMlXti5tuyJ7UMqFIWPw1sJUxPFma
 X6cgSDFo3bwvEdU85/dbbRuxab0ep/mNpFgC6wgUX5SLK3txnoVc5ySKK
 ICbXMTgT//3K0oadMEcDjloWW7Nkd7xoIoCBIEGrVUklplvBIdXLQOKtE
 bfCz7cbC5tNWOQg+up90thpiYRaFWVbhWYmV+adeQRLx9uOvyAWS7Uo4u
 TpiwHWDpfbNtfZcaeG9+FBhgg1rUdOZd1jcBEw2VSYv05z+R+8O7hFR6m
 BEHJ2VhuF9+82T/9fmkWFLmJmbf4ZGXXHzUxQF3hNj3nKNXN3F+qelMEB Q==;
X-CSE-ConnectionGUID: JywyuSJ3Q3qEQOdmmsdT8A==
X-CSE-MsgGUID: CnEK6VTWR9OJ8dfwvaOfwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
 by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 15:46:02 +0300
X-CSE-ConnectionGUID: jNtyiD7wTG61llNDra9hSg==
X-CSE-MsgGUID: 0EoMBconQCS2fl9sz4Whnw==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.2])
 by ces04_data.me-crop.lan with SMTP; 03 Jun 2026 15:50:45 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Wed, 03 Jun 2026 15:46:01 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 3/5] ufs: ufs tool
Date: Wed,  3 Jun 2026 15:45:37 +0300
Message-ID: <20260603124553.3763516-3-raz.benyehuda@mobileye.com>
In-Reply-To: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:19 +0200
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

The UFS tool provides utilities for querying, displaying, and modifying
UFS device configuration and descriptor information.

Features:
- Query and display Device, Geometry, Unit, Configuration, and Power
  Descriptors
- Display LUN configuration and calculated capacities
- Modify LUN, Configuration, and Device Descriptor fields
- Configure WriteBooster-related parameters
- Query common UFS runtime flags
- Commit configuration changes or clear all LUN configurations
- Decode and format descriptor contents for easier debugging

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 cmd/ufs.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/cmd/ufs.c b/cmd/ufs.c
index 790dab50f18..c8bafcd5e1d 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -24,15 +24,100 @@ static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			} else {
 				ufs_probe();
 			}
-
 			return CMD_RET_SUCCESS;
 		}
-	}
 
-	return CMD_RET_USAGE;
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+		if (!strcmp(argv[1], "query")) {
+			int lun = -1;
+			int idn = -1;
+
+			if (argc <= 3) {
+				printf("usage: lun idn");
+				return CMD_RET_FAILURE;
+			}
+
+			lun  = dectoul(argv[2], NULL);
+			idn  = dectoul(argv[3], NULL);
+
+			return ufs_tool_query(lun, idn);
+		}
+
+		if (!strcmp(argv[1], "set_lun")) {
+			int lun;
+			u32 val;
+
+			if (argc <= 4) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			lun  = dectoul(argv[2], NULL);
+			val  = dectoul(argv[4], NULL);
+			return ufs_tool_set_lun(lun, argv[3], val);
+		}
+
+		if (!strcmp(argv[1], "set_dev_desc")) {
+			const char *name;
+			u32 val;
+
+			if (argc <= 3) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			name = argv[2];
+			val  = dectoul(argv[3], NULL);
+			return ufs_tool_set_device_desc(name, val);
+		}
+
+		if (!strcmp(argv[1], "set_cfg_desc")) {
+			const char *name;
+			u32 val;
+
+			if (argc <= 3) {
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			name = argv[2];
+			val  = dectoul(argv[3], NULL);
+			return ufs_tool_set_config_desc(name, val);
+		}
+
+		if (!strcmp(argv[1], "getflag")) {
+			if (argc == 2) {
+				printf("usage: getflag [flag name]");
+				ufs_tool_help();
+				return CMD_RET_FAILURE;
+			}
+			return ufs_tool_query_flag(argv[2]);
+		}
+
+		if (!strcmp(argv[1], "commit"))
+			return ufs_tool_commit();
+
+		if (!strcmp(argv[1], "clearall"))
+			return ufs_tool_clearall();
+
+		if (!strcmp(argv[1], "luns")) {
+			ufs_tool_print_luns();
+			return 0;
+		}
+	}
+	ufs_tool_help();
+#endif
+	return CMD_RET_FAILURE;
 }
 
-U_BOOT_CMD(ufs, 3, 1, do_ufs,
+U_BOOT_CMD(ufs, 5, 1, do_ufs,
 	   "UFS sub-system",
 	   "init [dev] - init UFS subsystem\n"
+#if IS_ENABLED(CONFIG_UFS_TOOL)
+	   "query [LUN] [IDN]\n"
+	   "set_lun [LUN] [parm name] [value]\n"
+	   "set_cfg_des   [parm name] [value]\n"
+	   "set_dev_desc  [parm name] [value]\n"
+	   "luns - prints luns\n"
+	   "clearall - zero out configuration descriptor\n"
+	   "getflag [flag name]\n"
+	   "commit - writes luns configuration\n"
+#endif
 );
-- 
2.43.0

