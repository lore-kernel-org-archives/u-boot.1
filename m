Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D200AC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CC382162;
	Mon,  5 May 2025 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="abkMPVC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A978210D; Mon,  5 May 2025 11:17:15 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8681180F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DC68FA4C761;
 Mon,  5 May 2025 09:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32D0BC4AF09;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746436632;
 bh=zu00UeExt5X/b8C62DB94nfSqxX+nJUbvFnBFEWWrRA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=abkMPVC4OJGpFgF3pR6qMM98qgstyTdxkttvMRhvXOzRuBRzL4M6cbAp413e7Bdw7
 UbGphfm8nzo346LJhGj0FY4Dbh3OR5Bykyf5wDX2apW3JdWhzOU7SpMV2PkLPQoAC1
 v4JYHAdnTlNwAgHY7g+VDNeQ6cbIblWhY7lyILpDBRcR2gH+dYqFQTldGw+mUkbc+N
 qK+QIQY/JkRtEZbilIbGrh05SOru86cMR7Fe09q+NGzNQDtPEM3Z+rek+kOXQOPEbY
 13848Zg8qGmKk6tgF+BNoE4JHPWyKjmO0A6K3GJiNHN/u3INtTV4xAmBJ9a27Ehgf0
 jRoEA/BTL2U0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 273A3C3ABBB;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 05 May 2025 17:17:11 +0800
Subject: [PATCH v2 3/5] fdt_support: Add support for extra var for bootargs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-android-boot-v2-3-92dcb5bf59c8@gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
In-Reply-To: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436629; l=2151;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=DmXSjUEMzw7M2QHDPDGOk6gusoHWBs/ShF98ZWSfjjs=;
 b=7+a3a5BpZG7zWMUq7y3SKH31kmjwbt2Rn59DVewbDpXMUkbToHuRX/NaoCGc2BFAwUueQVpHB
 bsf+755lnYtAa+shcBS7NdabkmWHkxsFof1XcH9rDJudtnobp8ZYlWc
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:34 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Introduce a new env var 'legacy_os_boot_param' to hold legacy OS
dependent boot param.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/Kconfig       |  9 +++++++++
 boot/fdt_support.c | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 4bdac384181..80bb2eb7e77 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -17,6 +17,15 @@ config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	help
 	  This ignore kernel/ramdisk load addr specified in androidboot header.
 
+config SUPPORT_LEGACY_OS_BOOTPARAM
+	bool "Extra var to append bootargs"
+	default n
+	help
+	  This introduce env_var 'legacy_os_boot_param' to hold extra OS
+	  dependent kernel boot param, and append to fdt bootargs when bootm
+	  execute. The value is supposed to obtain from env file at compile time.
+	  Board dependent callback will override it completely.
+
 config TIMESTAMP
 	bool "Show image date and time when displaying image information"
 	default y if CMD_DATE
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..cc4d808eaf1 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -322,9 +322,27 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
  * board_fdt_chosen_bootargs - boards may override this function to use
  *                             alternative kernel command line arguments
  */
+#define COMMAND_LINE_SIZE 1024
+static char bootargs[COMMAND_LINE_SIZE] = { 0 };
 __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
 {
-	return env_get("bootargs");
+	if (IS_ENABLED(CONFIG_SUPPORT_LEGACY_OS_BOOTPARAM)) {
+		int j;
+		snprintf(bootargs, COMMAND_LINE_SIZE - 2, "%s %s",
+			env_get("bootargs"),
+	                env_get("legacy_os_boot_param"));
+
+		/* remove all carriage return */
+		for (j = 0; j < COMMAND_LINE_SIZE; j++) {
+			if (bootargs[j] == '\0')
+				break;
+
+			if ((bootargs[j] == '\n') || (bootargs[j] == '\r'))
+				bootargs[j] = ' ';
+		}
+		return bootargs;
+        } else
+		return env_get("bootargs");
 }
 
 int fdt_chosen(void *fdt)

-- 
2.43.0


