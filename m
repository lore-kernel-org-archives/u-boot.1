Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3B8C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66ACA80792;
	Fri, 17 Jan 2025 17:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MXdiB3VC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912BC8078B; Fri, 17 Jan 2025 17:40:56 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBE780717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so19542846d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132053; x=1737736853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeGgZOUQwrbfkIwvvfJQxONb5O/8BZM88i2WGDUfoV0=;
 b=MXdiB3VC66uzMatqJLXN3QGo6oLjdzXKVujUTvAFl2mT2d8Cqre95ku73LnSYMgKRy
 dxaOHgpqaW02BjxHUi0gW3rfSPoQiFcF5m60tBJiNu3np5MGGw3Cv4p3uhpwAa7bsbRd
 Uu8/5mRbIX7OFHSu7qkBDsq1g3TWuqMsOKz1uIdr0pCd/UMbSxbc7K8uh646+CgsonqL
 2C8l/sRtgDawecC79uWVPMnNXQ/11aMmt0Y9xJrqMwU+32DcUFmWW7IkO02bPLzQrRlm
 7kIG6nRGcoKg2BJnhLpdHNPOtKkdlIQ5Sjz+VfXmk7IOeu60DuxIQbmCFI2nWs30wx65
 eBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132053; x=1737736853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeGgZOUQwrbfkIwvvfJQxONb5O/8BZM88i2WGDUfoV0=;
 b=hEnoAzhzVPxgvwUzyS3rsCFEskJsckOeMUq69MKBStd5X60pNrTW1d6nlt4VmbZinD
 aC8mqBGvFlPTyO23efuwB9F1sWwNH32oIAUn8c/TxcOPHxRE6Qunnzg2Jf4fiVR5W4cz
 h+zxuCqZO2xah2Wy9zBvY/hkD9s4TW+CqnWcJz6j8t1pIwVCwZEBF+FhJVYCiIWNRluo
 RqLEjd1Ph8b1tbdHugvV9uU9IaiAyTmKKy4LkZx57rt3aMDy2W4yWXLxYwYqiW5sh6EB
 d8ti10AYcOJy4FNzIsSTKKZ8M+BBuamAPUhgU5B/mn1+Z7Anjq32Ugrb02sc0EEmCkXy
 h0ug==
X-Gm-Message-State: AOJu0Yw9AeZE6P6yApBGGQ7cs1tUvC4DIBe+dIzsEgPnsS2Q5Kw8Ld3J
 6TJOV2kQlVFx7O2rnh+VumZi9bOUqsHxi1h7Nf0uP0N3x61VJ9UjPX5WDMKxBRHU9qM8o6izQT5
 +O8U=
X-Gm-Gg: ASbGncv1/rpODRonEozMgo0ao5VaINqlB/f7R2wW9eIT7xOEwcrZCWFfNTHkpbUtNOo
 ahDlBMr8KDEbMZgglDhjbIGBQyUErSAmEVcLg2rQzSy38v+Ib2ZrJp3pjLeVQe8kb9H7S1Ox7aJ
 gEH4x1CxDWoAxm6jL+dWbJdHxEUxlb2dxsWNcGGVoBCzCnp+P0dfJyzQl2JAEwo0XVDizUYp7N1
 /bvewisVTQFzE0jNVtxWZ8CNdJEK8tvPpfolZcbMlvVbGMOSIZvW/7KsIPp+kNhn/BwYtolxRG4
 GO6xUSLpwNzXF2jzhI5oQLjbZozYf32xAQDFyMkef8YLClNvWNtjb04=
X-Google-Smtp-Source: AGHT+IG44ZbKgWJkPS8avpBcf63r+dTGilLRlG4AiUJKQPlOxA+KCKMCvmRW7fen2p+W6bY68Pty5A==
X-Received: by 2002:a05:6214:d67:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6e1b222f30dmr52001466d6.33.1737132052718; 
 Fri, 17 Jan 2025 08:40:52 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:40:52 -0800 (PST)
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
Subject: [PATCH v2 2/6] tpm: add TPM2_PCR_Allocate command
Date: Fri, 17 Jan 2025 08:40:25 -0800
Message-Id: <20250117164032.88942-3-raymond.mao@linaro.org>
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

TPM2_PCR_Allocate command is required to reconfigure a TPM device
to enable or disable algorithms in run-time, thus this patch introduces
the implementation of PCR allocate APIs and adds related cmd functions
for testing.

To test the feature, ensure that TPM is started up.
Run pcr_allocate command to turn on/off an algorithm, multiple calls
are supported and all changes will be cached:
`tpm2 pcr_allocate <algorithm_name> <on|off>`
Run startup command with argument 'off' to shutdown the TPM.
`tpm2 startup TPM2_SU_CLEAR off`
Reboot the board via `reset` to activate the changes.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
changes in v2
- Fixed typos.
- Print the algorithm name directly.
- Check if the algorithm supported by the TPM device before allocate.

 cmd/tpm-v2.c     | 114 +++++++++++++++++++++++++++++++++++++++++++
 include/tpm-v2.h |  29 +++++++++++
 lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index a6d57ee7c4..a62862e94f 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -232,6 +232,106 @@ unmap_data:
 	return report_return_code(rc);
 }
 
+static u32 select_mask(u32 mask, enum tpm2_algorithms algo, bool select)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(hash_algo_list); i++) {
+		if (hash_algo_list[i].hash_alg != algo)
+			continue;
+
+		if (select)
+			mask |= hash_algo_list[i].hash_mask;
+		else
+			mask &= ~hash_algo_list[i].hash_mask;
+
+		break;
+	}
+
+	return mask;
+}
+
+static bool
+is_algo_in_pcrs(enum tpm2_algorithms algo, struct tpml_pcr_selection *pcrs)
+{
+	size_t i;
+
+	for (i = 0; i < pcrs->count; i++) {
+		if (algo == pcrs->selection[i].hash)
+			return true;
+	}
+
+	return false;
+}
+
+static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
+			       char *const argv[])
+{
+	struct udevice *dev;
+	int ret;
+	enum tpm2_algorithms algo;
+	const char *pw = (argc < 4) ? NULL : argv[3];
+	const ssize_t pw_sz = pw ? strlen(pw) : 0;
+	static struct tpml_pcr_selection pcr = { 0 };
+	u32 pcr_len = 0;
+	bool bon = false;
+	static u32 mask;
+	int i;
+
+	/* argv[1]: algorithm (bank), argv[2]: on/off */
+	if (argc < 3 || argc > 4)
+		return CMD_RET_USAGE;
+
+	if (!strcasecmp("on", argv[2]))
+		bon = true;
+	else if (strcasecmp("off", argv[2]))
+		return CMD_RET_USAGE;
+
+	algo = tpm2_name_to_algorithm(argv[1]);
+	if (algo == -EINVAL)
+		return CMD_RET_USAGE;
+
+	ret = get_tpm(&dev);
+	if (ret)
+		return ret;
+
+	if (!pcr.count) {
+		/*
+		 * Get current active algorithms (banks), PCRs and mask via the
+		 * first call
+		 */
+		ret = tpm2_get_pcr_info(dev, &pcr);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < pcr.count; i++) {
+			struct tpms_pcr_selection *sel = &pcr.selection[i];
+			const char *name;
+
+			if (!tpm2_is_active_bank(sel))
+				continue;
+
+			mask = select_mask(mask, sel->hash, true);
+			name = tpm2_algorithm_name(sel->hash);
+			if (name)
+				printf("Active bank[%d]: %s\n", i, name);
+		}
+	}
+
+	if (!is_algo_in_pcrs(algo, &pcr)) {
+		printf("%s is not supported by the tpm device\n", argv[1]);
+		return CMD_RET_USAGE;
+	}
+
+	mask = select_mask(mask, algo, bon);
+	ret = tpm2_pcr_config_algo(dev, mask, &pcr, &pcr_len);
+	if (ret)
+		return ret;
+
+	return report_return_code(tpm2_send_pcr_allocate(dev, pw, pw_sz, &pcr,
+							 pcr_len));
+}
+
 static int do_tpm_dam_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
@@ -401,6 +501,7 @@ static struct cmd_tbl tpm2_commands[] = {
 			 do_tpm_pcr_setauthpolicy, "", ""),
 	U_BOOT_CMD_MKENT(pcr_setauthvalue, 0, 1,
 			 do_tpm_pcr_setauthvalue, "", ""),
+	U_BOOT_CMD_MKENT(pcr_allocate, 0, 1, do_tpm2_pcrallocate, "", ""),
 };
 
 struct cmd_tbl *get_tpm2_commands(unsigned int *size)
@@ -481,4 +582,17 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "    <pcr>: index of the PCR\n"
 "    <key>: secret to protect the access of PCR #<pcr>\n"
 "    <password>: optional password of the PLATFORM hierarchy\n"
+"pcr_allocate <algorithm> <on/off> [<password>]\n"
+"    Issue a TPM2_PCR_Allocate Command to reconfig PCR bank algorithm.\n"
+"    <algorithm> is one of:\n"
+"        * sha1\n"
+"        * sha256\n"
+"        * sha384\n"
+"        * sha512\n"
+"    <on|off> is one of:\n"
+"        * on  - Select all available PCRs associated with the specified\n"
+"                algorithm (bank)\n"
+"        * off - Clear all available PCRs associated with the specified\n"
+"                algorithm (bank)\n"
+"    <password>: optional password\n"
 );
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index f66a8e1bf4..af3158f6e4 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -230,6 +230,7 @@ enum tpm2_command_codes {
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_PCR_SETAUTHVAL	= 0x0183,
+	TPM2_CC_PCR_ALLOCATE    = 0x012B,
 	TPM2_CC_SHUTDOWN	= 0x0145,
 };
 
@@ -702,6 +703,34 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 			  uint vendor_subcmd);
 
+/**
+ * tpm2_pcr_config_algo() - Allocate the active PCRs. Requires reboot
+ *
+ * @dev		TPM device
+ * @algo_mask	Mask of the algorithms
+ * @pcr		PCR structure for allocation
+ * @pcr_len	Actual PCR data length
+ *
+ * Return: code of the operation
+ */
+u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
+			 struct tpml_pcr_selection *pcr, u32 *pcr_len);
+
+/**
+ * tpm2_send_pcr_allocate() - Send PCR allocate command. Requires reboot
+ *
+ * @dev		TPM device
+ * @pw		Platform password
+ * @pw_sz	Length of the password
+ * @pcr		PCR structure for allocation
+ * @pcr_len	Actual PCR data length
+ *
+ * Return: code of the operation
+ */
+u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
+			   const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
+			   u32 pcr_len);
+
 /**
  * tpm2_auto_start() - start up the TPM and perform selftests.
  *                     If a testable function has not been tested and is
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 3946ac2dbb..045b5dd9eb 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -400,6 +400,130 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	return 0;
 }
 
+u32 tpm2_pcr_config_algo(struct udevice *dev, u32 algo_mask,
+			 struct tpml_pcr_selection *pcr, u32 *pcr_len)
+{
+	int i;
+
+	if (pcr->count > TPM2_NUM_PCR_BANKS)
+		return TPM_LIB_ERROR;
+
+	*pcr_len = sizeof(pcr->count);
+
+	for (i = 0; i < pcr->count; i++) {
+		struct tpms_pcr_selection *sel = &pcr->selection[i];
+		u8 pad = 0;
+		int j;
+
+		if (sel->size_of_select > TPM2_PCR_SELECT_MAX)
+			return TPM_LIB_ERROR;
+
+		/*
+		 * Found the algorithm (bank) that matches, and enable all PCR
+		 * bits.
+		 * TODO: only select the bits needed
+		 */
+		for (j = 0; j < ARRAY_SIZE(hash_algo_list); j++) {
+			if (hash_algo_list[j].hash_alg != sel->hash)
+				continue;
+
+			if (algo_mask & hash_algo_list[j].hash_mask)
+				pad = 0xff;
+		}
+
+		for (j = 0; j < sel->size_of_select; j++)
+			sel->pcr_select[j] = pad;
+
+		log_info("set bank[%d] %s %s\n", i,
+			 tpm2_algorithm_name(sel->hash),
+			 tpm2_is_active_bank(sel) ? "on" : "off");
+
+		*pcr_len += sizeof(sel->hash) + sizeof(sel->size_of_select) +
+			    sel->size_of_select;
+	}
+
+	return 0;
+}
+
+u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
+			   const ssize_t pw_sz, struct tpml_pcr_selection *pcr,
+			   u32 pcr_len)
+{
+	/* Length of the message header, up to start of password */
+	uint offset = 27;
+	u8 command_v2[COMMAND_BUFFER_SIZE] = {
+		tpm_u16(TPM2_ST_SESSIONS),   /* TAG */
+		tpm_u32(offset + pw_sz + pcr_len), /* Length */
+		tpm_u32(TPM2_CC_PCR_ALLOCATE),  /* Command code */
+
+		/* handles 4 bytes */
+		tpm_u32(TPM2_RH_PLATFORM),	/* Primary platform seed */
+
+		/* AUTH_SESSION */
+		tpm_u32(9 + pw_sz),		/* Authorization size */
+		tpm_u32(TPM2_RS_PW),		/* Session handle */
+		tpm_u16(0),			/* Size of <nonce> */
+						/* <nonce> (if any) */
+		0,				/* Attributes: Cont/Excl/Rst */
+		tpm_u16(pw_sz),			/* Size of <hmac/password> */
+		/* STRING(pw)			   <hmac/password> (if any) */
+
+		/* TPML_PCR_SELECTION */
+	};
+	u8 response[COMMAND_BUFFER_SIZE];
+	size_t response_len = COMMAND_BUFFER_SIZE;
+	u32 i;
+	int ret;
+
+	/*
+	 * Fill the command structure starting from the first buffer:
+	 * the password (if any)
+	 */
+	if (pack_byte_string(command_v2, sizeof(command_v2), "s", offset, pw,
+			     pw_sz))
+		return TPM_LIB_ERROR;
+
+	offset += pw_sz;
+
+	/* Pack the count field */
+	if (pack_byte_string(command_v2, sizeof(command_v2), "d", offset, pcr->count))
+		return TPM_LIB_ERROR;
+
+	offset += sizeof(pcr->count);
+
+	/* Pack each tpms_pcr_selection */
+	for (i = 0; i < pcr->count; i++) {
+		struct tpms_pcr_selection *sel = &pcr->selection[i];
+
+		/* Pack hash (16-bit) */
+		if (pack_byte_string(command_v2, sizeof(command_v2), "w", offset,
+				     sel->hash))
+			return TPM_LIB_ERROR;
+
+		offset += sizeof(sel->hash);
+
+		/* Pack size_of_select (8-bit) */
+		if (pack_byte_string(command_v2, sizeof(command_v2), "b", offset,
+				     sel->size_of_select))
+			return TPM_LIB_ERROR;
+
+		offset += sizeof(sel->size_of_select);
+
+		/* Pack pcr_select array */
+		if (pack_byte_string(command_v2, sizeof(command_v2), "s", offset,
+				     sel->pcr_select, sel->size_of_select))
+			return TPM_LIB_ERROR;
+
+		offset += sel->size_of_select;
+	}
+
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	if (!ret)
+		tpm_init(dev);
+
+	return ret;
+}
+
 static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
 {
 	u8 response[(sizeof(struct tpms_capability_data) -
-- 
2.25.1

