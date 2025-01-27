Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13377C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 734A181292;
	Mon, 27 Jan 2025 15:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g1E7sCHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367B081292; Mon, 27 Jan 2025 15:59:14 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2705814BD
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4678cd314b6so45263791cf.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989948; x=1738594748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZng9lrou7xmo0zuCpuHnnU9JilGEVpUEOTQfkrdw5o=;
 b=g1E7sCHou2PH4C9cHgmesfZm+W+D5ZwofPYUBEV3sz0lKUBPY6jNHkuibeYsx9M7Ie
 d6UXZFI1x7BtqTr6NbaSnKTxB//Sy9/95o0G5BMojNnVKknK4S25RLHYI+kXCmUGB8GU
 4gmqv7k6EXKE6fyedyY34f8ftV5q+3smApXbTqyLjIyRZNqiGGGfMk5rpHzvYHAP/35J
 oxP0DxrFB6axfC7hfMNOcpjYYy0Kv26in4ZO8JtcKEl7NwpT04wgt/3Pdj0zoDwE3/Dx
 FTFR3JYI58Y7VCd9WjG4aqd/P7uIj2UF5g0DczApKl+BVcJ9R9fCmVr31XZBuCjC7iJJ
 iOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989948; x=1738594748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZng9lrou7xmo0zuCpuHnnU9JilGEVpUEOTQfkrdw5o=;
 b=cYPwI87eSQNjVuH4XtSq9PTmncMupoNo1lzu/5Bq3Xbnntf2lFWUHDaLP8lefFcnqi
 h2yqnrAnUUBTWm1vR6fFTl/1IGpj2E71mOWP7GePq+PIf69T+WyxA4qOAalIvOIWaQ7t
 Y+xymncn7BoxhRonhuuHWmZvTKIc9QHwtzjwdeA/hOBoImtAUG8/th/nyjxMoSTgHlQW
 lvUPwt3oC/7bW91f1hBBH8qQec13eMt8AdJx7XQnAmJAOKh1Znay+wezUg0K95L3OJzc
 f5kKqthNU3NvVNFNqH/g55puoVEI0mQSX9C1uSBwnnO9r9XwUHHbsTAsqGexBifCf0Un
 cBQA==
X-Gm-Message-State: AOJu0YyoCqNByu5Y5xp/F5Fl5/2xoo3OiGd9MgTkCsweWNmtiprGA9f8
 c3uS3ibVfhOhZ8637DPaSnPSJeruAKb/ubLSIlovDS8JkGTcUAz5icDHamnEiopFMzb9ulKKRwS
 bX0I=
X-Gm-Gg: ASbGncugCxVEZ9bSYeq7KAWX7AnGXEI5tqYyA7cKcnX0C0Q9Dfjczl44B3X3sswcoOL
 oqyok2q4VtMWb2amFiATzihPI6IigkBkejnQ2FMArfKDo0DiJDW9KE64Pgf2aEFrMwfv+sTTPcE
 HfGr8mQEJ3XIcHvFTusUbRHg42OQdC3JkXRBKQvof01+EOw+TuFpWt4oat7Ovy/zcQFgfMVI5+c
 es+AByZA9sxyB2fsuzEjs1P5A7r9RiZu86RdmG/Y+ZVvazB15zwAuHIs+tlEb6rSFKjiB1TrLBK
 UPCi2LxF3EF6CmwVuPJf6w2ulXsoEon71V6ugTavXP7GtK0mGmn9fZnPD5T2HdnusVX4DqmBiOp
 Y7lo=
X-Google-Smtp-Source: AGHT+IHqpmm/fWvfIMexiuRqyyU+rR2AW9btf2/KYFh6A2LwWL2MxV6oas38DvseQwj7sPlkfZBSyw==
X-Received: by 2002:ac8:5d90:0:b0:466:a3d2:ae44 with SMTP id
 d75a77b69052e-46e12ad608emr660531071cf.2.1737989948337; 
 Mon, 27 Jan 2025 06:59:08 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:07 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 1/6] tpm: add TPM2_Shutdown command
Date: Mon, 27 Jan 2025 06:58:46 -0800
Message-Id: <20250127145855.645845-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127145855.645845-1-raymond.mao@linaro.org>
References: <20250127145855.645845-1-raymond.mao@linaro.org>
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
changes in v3
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

