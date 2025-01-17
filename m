Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B024EC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC9F80761;
	Fri, 17 Jan 2025 17:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwZKH/0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60F780771; Fri, 17 Jan 2025 17:40:50 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E8A80717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467a1d43821so32099621cf.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132046; x=1737736846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GlYNkS/aIgA0nRXWBt06llIOEZcijUzB8V85l3gO1c=;
 b=HwZKH/0OWS69CCRvcypNcyXwdB1iOO9fRkaN5k74s+xTnsTjAdzPyOjCo/OgquDh3A
 v/OF9Gm3tng/Ds7gjziGSk1U/kOw7tSWmzTBDqxGV3XljqSFwciwjQXGq0UnGGAQdY/B
 KEBKw2Yv/P2HV11949BGBTG3m0manBRirmjiWMmRBXyeszmameuQ4oLf1/q11NosKPQm
 pL0YRW6vI2D10ed+LNUudk5D+wql4JbBtgqVL4f/PMGBFP6xureVAHxFEnaoL/3m1T9y
 laVWMEqZlAY5evS3VpHgO0AlPGynn87U9RlOJzGZTpSl7dyr0nFRf8VkAjfsRnW9sOK4
 s5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132046; x=1737736846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GlYNkS/aIgA0nRXWBt06llIOEZcijUzB8V85l3gO1c=;
 b=Uol4RLFYsz3tmF64B/HUB98HRWIDdTWoRb74tPaB1CdIv/SSNG8341zmArhBH/+M3j
 KzL34vnR1mm6EpuNIHd1qo5MKP6w3E2XzwEktrTBIBEsktyw7zKWVto/mUMrDEsFLhYx
 /8cFOZmnO3G0F/RaKp8KCsiIumUJbMyfRKdEuv5SYwOhzYurRAsSUe6h9ftJlHzEzp1R
 sbokj3ywyD9UZcS+Zxc3es18atS+lH+YRch/l9Q5qb8ozpsR/22vGmrZ9vQnZ3JY9TgH
 PhYJLX5YKYe/oaJvWJmPboon2Ho3cBjt22PdjjtL4lDdrqnYxKtzCMD54QF9CwG0DMzR
 qQAQ==
X-Gm-Message-State: AOJu0YwfVGA949zHR6V02kp0T0O41S6mWhhkwICDY7yWrHlL6fLpu3S1
 DLY4aPmQyfvzFPPU0eE0JlfM6RBxV5VKp4ukOXSJ8tV6fllktLWRn3GUqQouwbXC7iLonBuiCGr
 N8pc=
X-Gm-Gg: ASbGncsDItGvyL2lO3V1hHHm1956Yki5IEoZiVU1I7wzGRDZgwlqxSwSL9IpL8lAIWf
 emtV67nmoWFF23dWeXkiYwZWffMiAp0We4BGBc5nI6kKrHRlHblS6kIAgH9EaJcxw+XIsduyzRp
 ehPkD6IEVkJNpMjAYezkFZ2jj/sThFi0sxw0MMLwxubDDw1XKehO2xynNQ4Clxjz/j0uGRzD/Jj
 hM+uu6pnN2PleF/OfG4PT9Dv05W8GZy6ZY6LUZDRXMraHEHZhJ3bB2cNdJqiuT23mAqHqKsmNZR
 fo1T7oE7opSKOsYYIlhlFPQPoTSro4U/oVdZcQAwdeq1uNXUl5Aeo10=
X-Google-Smtp-Source: AGHT+IGSHRbw6Vno+6Ndb9uVy3olnN1wji4Rqs0mRYFv18oUjeDi2a0ee7lG3MOwGXz0Muor8vaEnw==
X-Received: by 2002:a05:622a:148b:b0:462:ea1d:9e2 with SMTP id
 d75a77b69052e-46df579741bmr172884071cf.16.1737132046635; 
 Fri, 17 Jan 2025 08:40:46 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:40:46 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 1/6] tpm: add TPM2_Shutdown command
Date: Fri, 17 Jan 2025 08:40:24 -0800
Message-Id: <20250117164032.88942-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117164032.88942-1-raymond.mao@linaro.org>
References: <20250117164032.88942-1-raymond.mao@linaro.org>
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

TPM2_shutdown command is sharing same structure and logics with
TPM2_startup, thus this patch extends the existing startup APIs and
cmd functions to support shutdown instead of created new ones.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
changes in v2
- None.

 cmd/tpm-v2.c     | 14 +++++++++++---
 include/tpm-v2.h |  3 ++-
 lib/tpm-v2.c     |  9 +++++----
 lib/tpm_api.c    |  4 ++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 8517833f86..a6d57ee7c4 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -18,11 +18,14 @@ static int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
 	enum tpm2_startup_types mode;
 	struct udevice *dev;
 	int ret;
+	bool bon = true;
 
 	ret = get_tpm(&dev);
 	if (ret)
 		return ret;
-	if (argc != 2)
+
+	/* argv[2] is optional to perform a TPM2_CC_SHUTDOWN */
+	if (argc > 3 || (argc == 3 && strcasecmp("off", argv[2])))
 		return CMD_RET_USAGE;
 
 	if (!strcasecmp("TPM2_SU_CLEAR", argv[1])) {
@@ -34,7 +37,10 @@ static int do_tpm2_startup(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	return report_return_code(tpm2_startup(dev, mode));
+	if (argv[2])
+		bon = false;
+
+	return report_return_code(tpm2_startup(dev, bon, mode));
 }
 
 static int do_tpm2_self_test(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -420,11 +426,13 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    Initialize the software stack. Always the first command to issue.\n"
 "    'tpm startup' is the only acceptable command after a 'tpm init' has been\n"
 "    issued\n"
-"startup <mode>\n"
+"startup <mode> [<op>]\n"
 "    Issue a TPM2_Startup command.\n"
 "    <mode> is one of:\n"
 "        * TPM2_SU_CLEAR (reset state)\n"
 "        * TPM2_SU_STATE (preserved state)\n"
+"    <op>:\n"
+"        * off - To shutdown the TPM\n"
 "self_test <type>\n"
 "    Test the TPM capabilities.\n"
 "    <type> is one of:\n"
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 65681464b3..f66a8e1bf4 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -230,6 +230,7 @@ enum tpm2_command_codes {
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_PCR_SETAUTHVAL	= 0x0183,
+	TPM2_CC_SHUTDOWN	= 0x0145,
 };
 
 /**
@@ -430,7 +431,7 @@ enum {
  *
  * Return: code of the operation
  */
-u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode);
+u32 tpm2_startup(struct udevice *dev, bool onoff, enum tpm2_startup_types mode);
 
 /**
  * Issue a TPM2_SelfTest command.
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index bc750b7ca1..3946ac2dbb 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -44,12 +44,13 @@ static int tpm2_update_active_banks(struct udevice *dev)
 	return 0;
 }
 
-u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
+u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
 {
+	int op = bon ? TPM2_CC_STARTUP : TPM2_CC_SHUTDOWN;
 	const u8 command_v2[12] = {
 		tpm_u16(TPM2_ST_NO_SESSIONS),
 		tpm_u32(12),
-		tpm_u32(TPM2_CC_STARTUP),
+		tpm_u32(op),
 		tpm_u16(mode),
 	};
 	int ret;
@@ -59,7 +60,7 @@ u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
 	 * but will return RC_INITIALIZE otherwise.
 	 */
 	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
-	if (ret && ret != TPM2_RC_INITIALIZE)
+	if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
 		return ret;
 
 	return tpm2_update_active_banks(dev);
@@ -84,7 +85,7 @@ u32 tpm2_auto_start(struct udevice *dev)
 	rc = tpm2_self_test(dev, TPMI_YES);
 
 	if (rc == TPM2_RC_INITIALIZE) {
-		rc = tpm2_startup(dev, TPM2_SU_CLEAR);
+		rc = tpm2_startup(dev, true, TPM2_SU_CLEAR);
 		if (rc)
 			return rc;
 
diff --git a/lib/tpm_api.c b/lib/tpm_api.c
index 39a5121e30..576d601e5f 100644
--- a/lib/tpm_api.c
+++ b/lib/tpm_api.c
@@ -28,7 +28,7 @@ u32 tpm_startup(struct udevice *dev, enum tpm_startup_type mode)
 		case TPM_ST_DEACTIVATED:
 			return -EINVAL;
 		}
-		return tpm2_startup(dev, type);
+		return tpm2_startup(dev, true, type);
 	} else {
 		return -ENOSYS;
 	}
@@ -60,7 +60,7 @@ u32 tpm_resume(struct udevice *dev)
 	if (tpm_is_v1(dev))
 		return tpm1_startup(dev, TPM_ST_STATE);
 	else if (tpm_is_v2(dev))
-		return tpm2_startup(dev, TPM2_SU_STATE);
+		return tpm2_startup(dev, true, TPM2_SU_STATE);
 	else
 		return -ENOSYS;
 }
-- 
2.25.1

