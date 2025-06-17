Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1777C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 13:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C329F82E0A;
	Tue, 17 Jun 2025 15:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JuFRCXA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F027B82C2F; Tue, 17 Jun 2025 11:23:50 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BC981760
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso10106568a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750152228; x=1750757028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7zQbU6BSb5g+l0SBUW87ymZ8jtWfh8wZHRLMZjTanRA=;
 b=JuFRCXA9f7EIs7uz+ChTSjlp0nBKnfmN2cy6XDnqtM+LcfdsdADfPCALxIUQwo4N4b
 gsVeYIlxPeu9B+ypxMGtXWoLruVeZrifi9sQ74l6GZCDfvbJS3+t2wHfjsb7s05dNrlc
 NVqC+zo+hrtQoFDV0NbkeehOfsShqJk9LlHKaeHi0LnxjR5zkVmkMx5VvMh1zOiSprTf
 OAt8HgmdDr/qZO5K8+tCL0vm8b1VIPrHbajehkKirKxXrguiq5SSXm7g6fA+VCTIHm8H
 gvStLoTE8IJ4ic7k5IUh31vuPH2zMwCl1STfGY0B8YEjzGWYCt8XD1lymqFQWqXwMuYk
 DUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750152228; x=1750757028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zQbU6BSb5g+l0SBUW87ymZ8jtWfh8wZHRLMZjTanRA=;
 b=eIpHa6kTAME8M/XPx+/8WL+KizojhYQaoZ8qzWUuzIFqUNSP2l0HzIDKv9PdCNibys
 3uaAV6JHQGYwdHI/V4NL6HOrNIekadjJYphU61kjzvVx7QKZtLCkLf4PCuxuVZd9UujD
 jnuEcqOkfwxap2gBhDQ4Q9gO4p74gR0qwFzOHmkw3RY1nKjf4Iq/PZY1FQ344KrwCWca
 BObCX2gcLDCXymg6WDl75E80jXnWt4paJUQFsGKGDkqi4oLlvI+M1WpwfzpNxiXmPk7/
 ZnWRl6izXA4esONn3eblg6wMV+06GLpZKCkDi62vw5pnX0hM/txvofE9U1dniB30iI8F
 O/5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7v0strM3tCM8oD0lkSoQiBZyW2jpyf+vMatfYtSZ2FjscCWk0vykJTh04Y/kUbLGbZQL5fO4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3TIoch1i65grVdFzDnc0ERwF7/A1/m/1lHAXnzbgeF7l+y1DN
 NL5TnVl8Qjk7w3//97qSgDyUsweTCgMspNZ24G4bxxxLGe7AJgHw9ka9
X-Gm-Gg: ASbGncvCmK5tR2UY0ftFKrTsanTDZf6q3DeJ74K+PAsdCFF+fjZap1PgiLFqu8P/hOa
 Bkqxx+7xzWX5ubMuwXvHe0JXH1GG/rU5OJTF3r4OutNNOoa3BWbgiAW8dQ90VXEwEZCvP7zlx0W
 Ue+S9jtNMCy1P+ojS8mahwIllwpL11l5kzK9njGgKH1B20gTOmxY0k/jBRCQhA9xx90es+gxtai
 MA/iTuUyWn0STxvFlnol5AZpOnHyDfQu7/pxIpB6GuYDcK3520ayaOuiR78l99/pktf492KJN7k
 yBtLkVAow1fQVDMC9jct4K528cJCbJ8H3Y/h0DkiuyF4WfqJWZw4ypunIn5I2jq/
X-Google-Smtp-Source: AGHT+IGZPwdgWiKiJiyMy1S9DzYYJK3vfnbM+9K8BTw54/gD5el4DRlCP+ElSBvr2ykPW4g3DtoNIg==
X-Received: by 2002:a05:6402:5cd:b0:607:94d:9bb0 with SMTP id
 4fb4d7f45d1cf-608d0963d50mr11858285a12.22.1750152228065; 
 Tue, 17 Jun 2025 02:23:48 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b48a95a7sm7618211a12.12.2025.06.17.02.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 02:23:47 -0700 (PDT)
From: vtpieter@gmail.com
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	u-boot@lists.denx.de
Subject: [PATCH] Improve user feedback in case of FPGA bitstream load failure
Date: Tue, 17 Jun 2025 11:23:32 +0200
Message-ID: <20250617092333.335908-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Jun 2025 15:01:34 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

In fpga.c, change debug() calls to puts() for important user
feedback. In zynqpl.c, change 'up to' to 'above' which corrects this
confusing or wrong statement.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 cmd/fpga.c            | 20 ++++++++++----------
 drivers/fpga/zynqpl.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 9dc7b63db5d..2c2a63524de 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -43,7 +43,7 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
 	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
 
 	if (argc != cmdtp->maxargs) {
-		debug("fpga: incorrect parameters passed\n");
+		puts("fpga: incorrect parameters passed\n");
 		return CMD_RET_USAGE;
 	}
 
@@ -51,14 +51,14 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
 
 	local_fpga_data = simple_strtol(argv[1], NULL, 16);
 	if (!local_fpga_data) {
-		debug("fpga: zero fpga_data address\n");
+		puts("fpga: zero fpga_data address\n");
 		return CMD_RET_USAGE;
 	}
 	*fpga_data = local_fpga_data;
 
 	local_data_size = hextoul(argv[2], NULL);
 	if (!local_data_size) {
-		debug("fpga: zero size\n");
+		puts("fpga: zero size\n");
 		return CMD_RET_USAGE;
 	}
 	*data_size = local_data_size;
@@ -78,7 +78,7 @@ static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
 	memset(&fpga_sec_info, 0, sizeof(fpga_sec_info));
 
 	if (argc < 5) {
-		debug("fpga: incorrect parameters passed\n");
+		puts("fpga: incorrect parameters passed\n");
 		return CMD_RET_USAGE;
 	}
 
@@ -100,13 +100,13 @@ static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (fpga_sec_info.authflag >= FPGA_NO_ENC_OR_NO_AUTH &&
 	    fpga_sec_info.encflag >= FPGA_NO_ENC_OR_NO_AUTH) {
-		debug("fpga: Use <fpga load> for NonSecure bitstream\n");
+		puts("fpga: Use <fpga load> for NonSecure bitstream\n");
 		return CMD_RET_USAGE;
 	}
 
 	if (fpga_sec_info.encflag == FPGA_ENC_USR_KEY &&
 	    !fpga_sec_info.userkey_addr) {
-		debug("fpga: User key not provided\n");
+		puts("fpga: User key not provided\n");
 		return CMD_RET_USAGE;
 	}
 
@@ -248,12 +248,12 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 	debug("fpga: argc %x, dev %lx, datastr %s\n", argc, dev, datastr);
 
 	if (dev == FPGA_INVALID_DEVICE) {
-		debug("fpga: Invalid fpga device\n");
+		puts("fpga: Invalid fpga device\n");
 		return CMD_RET_USAGE;
 	}
 
 	if (argc == 0 && !datastr) {
-		debug("fpga: No datastr passed\n");
+		puts("fpga: No datastr passed\n");
 		return CMD_RET_USAGE;
 	}
 
@@ -390,7 +390,7 @@ static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 	fpga_cmd = find_cmd_tbl(argv[1], fpga_commands,
 				ARRAY_SIZE(fpga_commands));
 	if (!fpga_cmd) {
-		debug("fpga: non existing command\n");
+		puts("fpga: non existing command\n");
 		return CMD_RET_USAGE;
 	}
 
@@ -398,7 +398,7 @@ static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 	argv += 2;
 
 	if (argc > fpga_cmd->maxargs) {
-		debug("fpga: more parameters passed\n");
+		puts("fpga: more parameters passed\n");
 		return CMD_RET_USAGE;
 	}
 
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index 3e86d854a01..7495ac2a69a 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -360,7 +360,7 @@ static int zynq_validate_bitstream(xilinx_desc *desc, const void *buf,
 	}
 
 	if ((u32)buf < SZ_1M) {
-		printf("%s: Bitstream has to be placed up to 1MB (%x)\n",
+		printf("%s: Bitstream has to be placed above 1MB (%x)\n",
 		       __func__, (u32)buf);
 		return FPGA_FAIL;
 	}

base-commit: 62d24441e0a29c828fda6fbda3b10710ce714094
-- 
2.48.1

