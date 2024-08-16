Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56586C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE2288BB2;
	Fri, 16 Aug 2024 17:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CysbtbRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5412288B9E; Fri, 16 Aug 2024 17:48:13 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC38288BB2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1d436c95fso129126885a.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823288; x=1724428088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVf7hnW/CWCw+wIuQTVTjnx+lOMOhT0zbAnyezrbVrk=;
 b=CysbtbRy8ueFlX4VnCgJ/+Z9lCCf8O0LH3FAK0KkgoMRsWGgwC7H5bQEIkCBLYpYel
 tTQD3FAnjWbueblJV6E0kBekxvQc0f9qG5l6m9+17cu3u4IQJtgHpTHKiuYzq559nFOY
 FEm6XImCrCsQWwDlbu8VsOcM4UG77I9U8BA7wjEfifdFSowr9AwoQiJ3qKn8TMYgWeJA
 /PkeJjhQre67bhvT5DHE9ZsG6TuizpqyKY9iFmhvPvNcPDPxsq+xNO6BiqOXUwDyvMhf
 0MwM4JVt4TKyJabdSgxWdUN4bKhAy0nV853r1nxZLwLxbYsYqacMhzjbBewbQllhZNed
 N7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823288; x=1724428088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVf7hnW/CWCw+wIuQTVTjnx+lOMOhT0zbAnyezrbVrk=;
 b=sSCb7XghQH6tjxwnHmOWPcgZHusC7miY4dJmkvQetSFd9IMROOACjnTqLHXAMnIuZk
 IgCuoYjjg1gPh6wuElKGUaClsIWjlrlehT/zyGidiS/KHjmzAyQbcTHCYNcTXTUU2X6a
 a9TvHha7vPVjuTwLf9+jlpXWVpO04mIcuo7LrgSvPXhQcetHZHeEWLHJ2M83P0LHhFmk
 9bRRiRGH5UXnYyZbCPTuhmTLgmUwF39oqCvdDbIr2Cnir1Dxw5OPHOcTojBBZMcdTrWw
 1UXHmDvgvw6FTB0NZbdJMf0LV2S/tmds2JJrKyCcmXuerN+4ZmXxpLxHIVCK4RHzifAF
 Vugg==
X-Gm-Message-State: AOJu0YzC4oDONzHK2zyBagwDNSrbyZAHyl3rGEaB8U6FWQXnP7kD7BEw
 Yyre9krLL0uozBuF0BC6aK2c/qcfEX+GMPxgu5obpCGszph8TkHslrQMRmBMxmmwZ9zeCyb8wtz
 RdVs=
X-Google-Smtp-Source: AGHT+IErkTkvjXPXHV9o1+k9Ie0nDL8Isj8SVtpl5xFY5voECKweGLtBFCmyWe46dAqBZ2bvTybLwA==
X-Received: by 2002:a05:620a:2986:b0:79d:6d4a:a964 with SMTP id
 af79cd13be357-7a506905517mr331249585a.2.1723823287830; 
 Fri, 16 Aug 2024 08:48:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:48:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 07/10] smbios: Add support to SMBIOS type 7
Date: Fri, 16 Aug 2024 08:46:50 -0700
Message-Id: <20240816154658.1866186-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Add SMBIOS type 7 (cache information) write functions.
Link cache handles from type 7 to type 4.
Add SMBIOS command print functions for type 7.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 cmd/smbios.c |  82 +++++++++++++++++++++++++++++++++++++++
 lib/smbios.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 8e2bf46a09c..38651740451 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -91,6 +91,43 @@ static const char * const processor_upgrade_strings[] = {
 	[7 ... 80] = "Other", /* skip these definitions from now */
 };
 
+static const char * const err_corr_type_strings[] = {
+	"Reserved",		/* 0x00 */
+	"Other",		/* 0x01 */
+	"Unknown",		/* 0x02 */
+	"None",			/* 0x03 */
+	"Parity",		/* 0x04 */
+	"Single-bit ECC",	/* 0x05 */
+	"Multi-bit ECC",	/* 0x06 */
+};
+
+static const char * const sys_cache_type_strings[] = {
+	"Reserved",		/* 0x00 */
+	"Other",		/* 0x01 */
+	"Unknown",		/* 0x02 */
+	"Instruction",		/* 0x03 */
+	"Data",			/* 0x04 */
+	"Unified",		/* 0x05 */
+};
+
+static const char * const associativity_strings[] = {
+	"Reserved",			/* 0x00 */
+	"Other",			/* 0x01 */
+	"Unknown",			/* 0x02 */
+	"Direct Mapped",		/* 0x03 */
+	"2-way Set-Associative",	/* 0x04 */
+	"4-way Set-Associative",	/* 0x05 */
+	"Fully Associative",		/* 0x06 */
+	"8-way Set-Associative",	/* 0x07 */
+	"16-way Set-Associative",	/* 0x08 */
+	"12-way Set-Associative",	/* 0x09 */
+	"24-way Set-Associative",	/* 0x0a */
+	"32-way Set-Associative",	/* 0x0b */
+	"48-way Set-Associative",	/* 0x0c */
+	"64-way Set-Associative",	/* 0x0d */
+	"20-way Set-Associative",	/* 0x0e */
+};
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -364,6 +401,48 @@ static void smbios_print_type4(struct smbios_type4 *table)
 	printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
 }
 
+const char *smbios_cache_err_corr_type_str(u8 err_corr_type)
+{
+	if (err_corr_type >= ARRAY_SIZE(err_corr_type_strings))
+		err_corr_type = 0;
+	return err_corr_type_strings[err_corr_type];
+}
+
+const char *smbios_cache_sys_cache_type_str(u8 sys_cache_type)
+{
+	if (sys_cache_type >= ARRAY_SIZE(sys_cache_type_strings))
+		sys_cache_type = 0;
+	return sys_cache_type_strings[sys_cache_type];
+}
+
+const char *smbios_cache_associativity_str(u8 associativity)
+{
+	if (associativity >= ARRAY_SIZE(associativity_strings))
+		associativity = 0;
+	return associativity_strings[associativity];
+}
+
+static void smbios_print_type7(struct smbios_type7 *table)
+{
+	printf("Cache Information:\n");
+	smbios_print_str("Socket Designation", table,
+			 table->socket_design);
+	printf("\tCache Configuration: 0x%04x\n", table->config.data);
+	printf("\tMaximum Cache Size: 0x%04x\n", table->max_size.data);
+	printf("\tInstalled Size: 0x%04x\n", table->inst_size.data);
+	printf("\tSupported SRAM Type: 0x%04x\n", table->supp_sram_type.data);
+	printf("\tCurrent SRAM Type: 0x%04x\n", table->curr_sram_type.data);
+	printf("\tCache Speed: 0x%02x\n", table->speed);
+	printf("\tError Correction Type: %s\n",
+	       smbios_cache_err_corr_type_str(table->err_corr_type));
+	printf("\tSystem Cache Type: %s\n",
+	       smbios_cache_sys_cache_type_str(table->sys_cache_type));
+	printf("\tAssociativity: %s\n",
+	       smbios_cache_associativity_str(table->associativity));
+	printf("\tMaximum Cache Size 2: 0x%08x\n", table->max_size2.data);
+	printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
+}
+
 static void smbios_print_type127(struct smbios_type127 *table)
 {
 	printf("End Of Table\n");
@@ -440,6 +519,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
 		case SMBIOS_PROCESSOR_INFORMATION:
 			smbios_print_type4((struct smbios_type4 *)pos);
 			break;
+		case SMBIOS_CACHE_INFORMATION:
+			smbios_print_type7((struct smbios_type7 *)pos);
+			break;
 		case SMBIOS_END_OF_TABLE:
 			smbios_print_type127((struct smbios_type127 *)pos);
 			break;
diff --git a/lib/smbios.c b/lib/smbios.c
index 2f1759d419e..f5514661abe 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -703,6 +703,8 @@ static int smbios_write_type4(ulong *current, int handle,
 {
 	struct smbios_type4 *t;
 	int len = sizeof(*t);
+	u8 *hdl;
+	size_t hdl_size;
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
@@ -729,9 +731,25 @@ static int smbios_write_type4(ulong *current, int handle,
 	t->processor_upgrade =
 		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE);
 
-	t->l1_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
-	t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
-	t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	/* Read the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_CACHE_HANDLE,
+			      &hdl, &hdl_size) &&
+	    (hdl_size == SYSINFO_CACHE_LVL_MAX * sizeof(u16))) {
+		u16 *handle = (u16 *)hdl;
+
+		t->l1_cache_handle = *handle ? *handle :
+				     SMBIOS_CACHE_HANDLE_NONE;
+		handle++;
+		t->l2_cache_handle = *handle ? *handle :
+				     SMBIOS_CACHE_HANDLE_NONE;
+		handle++;
+		t->l3_cache_handle = *handle ? *handle :
+				     SMBIOS_CACHE_HANDLE_NONE;
+	} else {
+		t->l1_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+		t->l2_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+		t->l3_cache_handle = SMBIOS_CACHE_HANDLE_NONE;
+	}
 
 	t->serial_number = smbios_add_prop_si(ctx, NULL,
 					      SYSINFO_ID_SMBIOS_PROCESSOR_SN,
@@ -766,6 +784,86 @@ static int smbios_write_type4(ulong *current, int handle,
 	return len;
 }
 
+static int smbios_write_type7_1level(ulong *current, int handle,
+				     struct smbios_ctx *ctx, int level)
+{
+	struct smbios_type7 *t;
+	int len = sizeof(*t);
+	u8 *hdl;
+	size_t hdl_size;
+
+	t = map_sysmem(*current, len);
+	memset(t, 0, len);
+	fill_smbios_header(t, SMBIOS_CACHE_INFORMATION, len, handle);
+	smbios_set_eos(ctx, t->eos);
+
+	t->socket_design =
+		smbios_add_prop_si(ctx, "socket",
+				   SYSINFO_ID_SMBIOS_CACHE_SOCKET + level,
+				   NULL);
+	t->config.data =
+		smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_CACHE_CONFIG + level);
+	t->max_size.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE + level);
+	t->inst_size.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_INST_SIZE + level);
+	t->supp_sram_type.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE + level);
+	t->curr_sram_type.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE + level);
+	t->speed = smbios_get_val_si(ctx,
+				     SYSINFO_ID_SMBIOS_CACHE_SPEED + level);
+	t->err_corr_type =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE + level);
+	t->sys_cache_type =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE + level);
+	t->associativity =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_ASSOC + level);
+	t->max_size2.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 + level);
+	t->inst_size2.data =
+		smbios_get_val_si(ctx,
+				  SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 + level);
+
+	/* Save the cache handles */
+	if (!sysinfo_get_data(ctx->dev, SYSINFO_ID_SMBIOS_CACHE_HANDLE,
+			      &hdl, &hdl_size)) {
+		if (hdl_size == SYSINFO_CACHE_LVL_MAX * sizeof(u16))
+			*((u16 *)hdl + level) = handle;
+	}
+
+	len = t->hdr.length + smbios_string_table_len(ctx);
+	*current += len;
+	unmap_sysmem(t);
+
+	return len;
+}
+
+static int smbios_write_type7(ulong *current, int handle,
+			      struct smbios_ctx *ctx)
+{
+	int len = 0;
+	int i, level;
+
+	/* Get the number of level */
+	level =	smbios_get_val_si(ctx, SYSINFO_ID_SMBIOS_CACHE_LEVEL);
+	if (level >= SYSINFO_CACHE_LVL_MAX) /* Error, return 0-length */
+		return 0;
+
+	for (i = 0; i <= level; i++)
+		len += smbios_write_type7_1level(current, handle++, ctx, i);
+
+	return len;
+}
+
 static int smbios_write_type32(ulong *current, int handle,
 			       struct smbios_ctx *ctx)
 {
@@ -805,6 +903,8 @@ static struct smbios_write_method smbios_write_funcs[] = {
 	{ smbios_write_type2, "baseboard", },
 	/* Type 3 must immediately follow type 2 due to chassis handle. */
 	{ smbios_write_type3, "chassis", },
+	/* Type 7 must ahead of type 4 to get cache handles. */
+	{ smbios_write_type7, },
 	{ smbios_write_type4, },
 	{ smbios_write_type32, },
 	{ smbios_write_type127 },
-- 
2.25.1

