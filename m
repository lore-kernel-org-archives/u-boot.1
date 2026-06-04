Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6867CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632A6849CA;
	Thu,  4 Jun 2026 14:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eF23WVX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6179D8486A; Thu,  4 Jun 2026 13:26:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E8B848DC
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CD887419C5;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B065BC2BCC6;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780572355;
 bh=6bv2c4x/0i/NSFmgxy1Qd/CXBW7vdNbMA4/AJH5Jn1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=eF23WVX0ThOxciKrUgkb7fqIi2N2S5GjadBeJAhYcH4DgFLWwC2FoECXCF81+P4Zl
 0FvfRH5scjeoesggDsDxtd1ZibQksWTb7CwhMmt3UTEjIcqnXwAWN5ExUW7KghmYsn
 kQ4KVNVDmA/dsccEjpYjU7NvaWbKvQVmZ65ydjFz33IRyr+hkTBMp6qt+OXmXE0Sox
 kBuhSMSU9e11Cr74IAXykBxn8Gvak9WOYCS9alfex1BDv+pKK5xHDnJ/Y+Puwn98ZI
 s68SR5iZqFWMxMNz9fuLEeNMJ4QhFHuGrtb6P5j8FSbhw9MnvH4GCBlQwcSKwUW6rZ
 ypyqrN6J6n4TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A8785CD6E4A;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Thu, 04 Jun 2026 14:25:52 +0300
Subject: [PATCH PATCHSET 4/6] ufs: ufs tool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-ufs_tool-v1-4-741ed00232c0@mobileye.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
In-Reply-To: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=GnlL/4/pQDP7in6hu11fTcMrI+4JPLRJwwyVK2AzrSk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqIWDAjTalekaekAAVt5pDKHU7kfQx2K76VJEWa
 R7zSZhGDTOJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiFgwAAKCRCfmumUluiO
 OagyD/9mUUDW2hyDFuoLXb1R6a6m/h+kZ9KmV3kmf0rZ7W+g8bQvb0y6/1IcO1YKq3+0IrolNer
 9TzzwsswybSWTNGv22Kr0wdl727SnkhRfFgOkLHD5AKHNrBMm/F5W6VzY67t0R4P1JKkBgq2H9w
 7ZXTnrXGxHqicdGPyx77BFBDsgcdNMDajeC1A0K8qo2pCof0x5jCq5MI1T3k2WkdwTxjosOvuCe
 ymCXUrlLZHBk488SBeKivYsr+vGyDW/eWNpl1/0mat1zn3ccoQh+b7PNzoH0JxPcCCBTasCe3aL
 ueJbSKRWbQyxyp9TLKOnGTYPIiJK/pUFOMfkQXvP02iSrt53hpXCaJrpo1V5PE/KZO2Qkl6njy1
 gJxGb54NvdP9ZEyutnYWJWNCpn7eWAZc6dJfB9Za019AW/bAAwbkPtdqXyjjm1DUFSa5ikaA08K
 KWnCnesMLii0gZ9ZGsHY1RVyDYAV/MiFbIBUN5DAHCOZ7blPPznU74k3OccOK33KImqgdHhTNE9
 okqPq8SGEhzTWrdTqsNBoVbdePbWpkNS71a7973ufaa8fVnR8F5lO+K5odoqlY3POH8vUPlTS+c
 ssKP+SMSAJLkeM3/6l/U9ZJpzrcWUpqdOF4/oKqaTuTbX7/mVC7jpdvBQKfnrxvMkuB6svw0kZt
 0aj0nlXCJdIKclg==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

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
 cmd/ufs.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
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


