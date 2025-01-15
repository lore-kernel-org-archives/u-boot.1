Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35381C02189
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4FEC806DD;
	Wed, 15 Jan 2025 21:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="moZ1gNQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0648070D; Wed, 15 Jan 2025 21:02:26 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A069580726
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso1892136d6.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971341; x=1737576141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8uSetEODNCMy3NieiYS6bKTGf5YmGZkcU10USW+y64=;
 b=moZ1gNQR6KQIoq2fdNTKu7jToS/Ryp1jGq3ZI3kSw5nekUZRbGPqeSIlQQ2dBYwJ0W
 11B3H4RsnOsC0mqX1MYss/XQI0VwDKFeGbasayw1TO2FVXlMZiSQ9ViTCXKbLYC9aoB0
 oiXEicQBCmQBIbnNu9TAJLQ9il6zqZ2z7oEUIRhp8ob8B3HBqkC8fKUjI6VB0ONEFbxM
 Idy6zu4aDv+wgkwgr37usHqDBNzgXZmRA50WZ3IZZD93XlplpIerodVoI4vyG/aHm/cs
 7VMhs9xbEx+schxCuRVi0nSuleY3Sk/i2nwp78Xbu859szeciMXb3Ob0lAVPWAS5LFsp
 cWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971341; x=1737576141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8uSetEODNCMy3NieiYS6bKTGf5YmGZkcU10USW+y64=;
 b=n5b069ke7Ha5ccM8hc1yP4TkN2rXJvx2lugufYTC7TZXxUVtcsDNy3Lw0C+QNMceo5
 mgjaddw+v4sgGdFx/x4HCoD8fw5UDiCyzVGpztf/ooNBdhlbGtDRMnLr99ekex2/TEg9
 n8OGwehxEc9mrdGae7RGa3+W0v6+v9iIrL7S5gnDY/oMuh0twI8E5rEp8eblM/ktg9mv
 9sq3P0KzZ9efe7WfhcTX0aD7KR5CMJFMrlV2w5t6mQYq5f+4CDEKdt9OCctcCP8on7gp
 DpZeJN6o65QNDn92ceW+BZ0jarOSPIhBUFCaiFPO9oU4LovWKrhICqKSCA7sRrHlq4Mn
 ZtQQ==
X-Gm-Message-State: AOJu0Yw20kEkCe1sVBjCHey27CPSY0zdz798eHyJme7bhoJ/cmwDGbIN
 rpqpmW7nymAWUA2XWw+EH4s+YyTy9ieDGKXeFx4lM7bbjmlTybsZ9gLhpSd8GTxby9nmSAigtT/
 ReI0=
X-Gm-Gg: ASbGnctUL7/UKK8K+yzFwHODekgTrZXtjRXKf7nx5tM6bq/o+2XBf1HVmFN+9KpPDfM
 O42xYLzu1yPOga/f1CDr65qAX2AmLB4+SND1d8DMqxEAAqhlfC27CZZcFsLpVEJRfxY7rDr9CSz
 YSps6CJQnPNGHxJf+h5f04JrLOi/TmNYKxjzUsPOyRkXN8f/x+F7iJ3TQTK+zH59lw658B8Cy+L
 zwbAoPnR+K6Ds4LRO0sYcBP/LSDDVoyzR8sSeVz51Qxd+/x1kCp/YtsxVsKp0nu2RB/ORZr8vfz
 wTCEoORckOltJbdmomTx6XK0f3UtTUpooXEz4fPVrk1FxfdkS4277kE=
X-Google-Smtp-Source: AGHT+IFjmf4sOMDpLOI6I88ke8hYELsGAFO93MO6H/1rQH09w1zj4kApYjs7YPCxswmh8XnzmiwXew==
X-Received: by 2002:a05:6214:501a:b0:6d8:9074:a823 with SMTP id
 6a1803df08f44-6df9b2d99eemr471172796d6.45.1736971341102; 
 Wed, 15 Jan 2025 12:02:21 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:20 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
Date: Wed, 15 Jan 2025 12:01:36 -0800
Message-Id: <20250115200144.951530-3-raymond.mao@linaro.org>
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

TPM2_PCR_Allocate command is required to re-configurate a TPM device
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
 cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
 include/tpm-v2.h |  29 +++++++++++
 lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index a6d57ee7c4..2302e8e94c 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -232,6 +232,86 @@ unmap_data:
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
+		 * Get current in-use algorithms (banks), PCRs and mask via the
+		 * first call
+		 */
+		ret = tpm2_get_pcr_info(dev, &pcr);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < pcr.count; i++) {
+			struct tpms_pcr_selection *sel = &pcr.selection[i];
+
+			if (!tpm2_is_active_bank(sel))
+				continue;
+
+			mask = select_mask(mask, sel->hash, true);
+			printf("Active bank[%d] with algo[%#x]\n", i,
+			       sel->hash);
+		}
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
@@ -401,6 +481,7 @@ static struct cmd_tbl tpm2_commands[] = {
 			 do_tpm_pcr_setauthpolicy, "", ""),
 	U_BOOT_CMD_MKENT(pcr_setauthvalue, 0, 1,
 			 do_tpm_pcr_setauthvalue, "", ""),
+	U_BOOT_CMD_MKENT(pcr_allocate, 0, 1, do_tpm2_pcrallocate, "", ""),
 };
 
 struct cmd_tbl *get_tpm2_commands(unsigned int *size)
@@ -481,4 +562,17 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
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

