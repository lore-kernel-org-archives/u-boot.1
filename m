Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1466C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB2C8060C;
	Wed, 15 Jan 2025 21:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e1b4bI/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6511580702; Wed, 15 Jan 2025 21:02:17 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A978060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so2662346d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971333; x=1737576133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi2pitbv2+wweSkCBAp275DoVKFAouVzJ7Z8Qbe7fyw=;
 b=e1b4bI/iLY3IBJXWiya+pQ3uUFGTd9lINI3fBW7/GJyQ86h7vea6WB0f+bs8ZdKUNS
 2TQ+mDtZdTYJAETmaDi76WqAnJXXCQnBgEhJln1r+ZGReT3JQpGAKDsyGEJXCmLbH3Fg
 rJTDXprXQBcwX+/E1Mzkt9FMz3e4FNshmnMtMytsGC9XRpI1U4zGs4ri55pWYVyEPUfF
 W09MlDy08IZ61RnWr5uBUJWROOT1zf2g2uYTHA7QvJhbJLqR2GEXg+yycHeVq5npLK0v
 E8R6RhUewp10vi6JGKOzGbrx0h25tPttCAyu6djvKTse62AMJPAyHgQVcIBSDkk8rQ2i
 C8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971333; x=1737576133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi2pitbv2+wweSkCBAp275DoVKFAouVzJ7Z8Qbe7fyw=;
 b=Kx7qQMJkGjQ4+eBixNibERNxrH4/8SYr4fp5mJlEbZEFi3zDjDYnXA9jPKJHigFPFL
 Wj+RjT5dJC7cqZJ/o2ViL6f0xnZBNc5dfvRQLnayDdT4wKe2JlTsUQpgA3ptqyk35GZD
 WFpxBzX7K3suANejth7UashMNA9fuaalHWsb+I4+flawG+OK+ugITXpI1bmufMduZXce
 pVWTSWnCoQJG6xnL5v7k5f07J8+7TVMFT3PxvzuKAhVBG+rbZcZ3TLtrP6D2hETVBNvQ
 fOgINHgxCZ4XmwkcB0v/Z37fTcgsv4d3IGwVi9YNbk1g5ozEBO/Ggvq212LYbeUqvT7y
 lgnA==
X-Gm-Message-State: AOJu0Yzwkdx/bXxKCjD46degFFf1LLKxVWsgrGTfndMYo/AIgm2/LjGk
 3a9wFLAfOecS5eAQgp38dvQHlGu6Xj5YFF2Hd60DCv03TThfwpOEFyhLhHT/ji5gmpH9r3sM9yB
 lX+A=
X-Gm-Gg: ASbGncuRFvGbfF0o81CFGRTl5B4oUKPx7qNnLBb1JEVAcJaZ0wZy07nF6IQkv0RiiTQ
 V+He2O330D/p8VPCkDLiHYRnOZwWT0koagdvPKzwKe0x0Q5GrNy3dY9CdLpmIRa4iIvPKNcoYVd
 MCvXCGhdvD9QzPzMcvUnh5utbc5bPP49qx9XVdF+4S9WwePvDS+0efvL6HfP9wwqqX32g1MTyDe
 bxSRfUHRpGYf0rsPvT2HO0MvZct4SB5G4t/1ECs7MJZ2WUAZcBxgNSuIxDjz6SJQVqz4+8v/+GM
 0sjRx6zQ1tJuw5VZdTpeqFlgj8nURZUMCSA5pBYKGev2bTozTHVsSY8=
X-Google-Smtp-Source: AGHT+IFD2rLoAHFCKvRmcTKhVyuHIY7Tf/VHTMuooxbPLRG3ZHBWbAGZS241qRHOcIR3MoFVUAB0bA==
X-Received: by 2002:a05:6214:55c7:b0:6e1:89c7:bc7e with SMTP id
 6a1803df08f44-6e189c7bcc7mr119940586d6.38.1736971333205; 
 Wed, 15 Jan 2025 12:02:13 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:12 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 1/6] tpm: add TPM2_Shutdown command
Date: Wed, 15 Jan 2025 12:01:35 -0800
Message-Id: <20250115200144.951530-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115200144.951530-1-raymond.mao@linaro.org>
References: <20250115200144.951530-1-raymond.mao@linaro.org>
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
---
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

