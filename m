Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47656C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D16287FB9;
	Mon,  4 Mar 2024 15:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZB0yT4Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C065087FAE; Mon,  4 Mar 2024 15:43:15 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800EC87FAA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so38969865ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563392; x=1710168192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IC7fwBnVFr7LZXSeRRyncmjuMuUcEgwgdmAWQJbhy2M=;
 b=ZB0yT4UyG0NDeyhQkQXH0KRYt5uhkYlyhnH0cFnoPXYWZ4aW+nHVm9zqKU30OB5tqx
 0APzmOHpuIa33xVoJ9WKOIO1ibnPSTlenLPB1WUYm8Rfeo8Lq7mf7n8Z5ZZ6iQ7wAwPv
 FZfc0CzCnECiCBPfa2IraZVx/mwVbHx+H2ywzXgkuzTIHJsU3RYOEVk6iwt6z2RGyUXy
 q1x+Ci8fe0vNFGa3+5W7NJ5V7jOzzfJeqg9gHXKzl8riAc5oOvRwIrojGkHL6ujjHEJ+
 hD0aVy9LdHmagaFARN3Y3jlUu5gc7BFxUvDqwtW16bblYzCppdIOjexSBL5WSsjEsNtl
 ankw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563392; x=1710168192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC7fwBnVFr7LZXSeRRyncmjuMuUcEgwgdmAWQJbhy2M=;
 b=c81pxqoV4jxgzJZjeRRVQGIRwEZrrwf/+0G4EUDlzzipzVk5s/mA0zRA0LglFsY9Re
 ID6Zi8xZyYQKfMe8FNwukJSSm+Ov1LfczDlLoCP9+ez82VkZDKg5rA6TJguTDR+iCVTF
 vhfXtSwOEX0Mnt9aoIoWWc4g16HAW9O5/astABK3nkgpJTLCgXgvLbAQ3N0XiYT0Jy43
 BiYLrrUEjJGnNDUkt7IFm/xwhjP3ZHHtv5x+7x+U2cgfz9EC5ypyvoi81HR13ISv2qnM
 lw/qiF1MJJKfvBzUTYVZ5oGwxgzdD3bbO6dqsUflhQkshFZ4v1WjDi1YzfWHFpOlzjof
 6mzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBmSbpHHQ7lbJ6mPDuMGDJql7tWuTv62wS/H4O844h5L0+6FCEKkil/JzwrHbr4uqDEFUpTUcerj9c613WJciGGdJiOw==
X-Gm-Message-State: AOJu0YwvHidJ9XRYDnrkGJGGKztFEByTD3K0uvqPDyj/CTIYAGN2g1DZ
 rl64R9/CIQ56IVhjNHJh04zrpXfYKYzCnyMn1xk8wiXb6h/n03IU
X-Google-Smtp-Source: AGHT+IHs1D3NAdT/9s2hyXFtiZ0ttPD8NcVLY4e9DDCeHFTOtljR7FMwGL3BHPb0mEuuH9cxKohtNg==
X-Received: by 2002:a17:903:32cd:b0:1dc:fefe:8050 with SMTP id
 i13-20020a17090332cd00b001dcfefe8050mr7209705plr.29.1709563391648; 
 Mon, 04 Mar 2024 06:43:11 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001dc8923a2c4sm8629529plb.294.2024.03.04.06.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:43:11 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v4 3/3] cmd: rng: Add rng list command
Date: Mon,  4 Mar 2024 14:42:42 +0000
Message-Id: <20240304144242.11666-4-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304144242.11666-1-o451686892@gmail.com>
References: <20240304144242.11666-1-o451686892@gmail.com>
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

The 'rng list' command probes all RNG devices and list those devices
that are successfully probed. Also update the help info.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v4: update doc/usage/cmd/rng.rst
---
 cmd/rng.c             | 23 ++++++++++++++++++-----
 doc/usage/cmd/rng.rst | 14 ++++++++++----
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 52f722c7af..b073a6c849 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct udevice *dev;
 	int ret = CMD_RET_SUCCESS;
 
+	if (argc == 2 && !strcmp(argv[1], "list")) {
+		int idx = 0;
+
+		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
+			idx++;
+			printf("RNG #%d - %s\n", dev->seq_, dev->name);
+		}
+
+		if (!idx) {
+			log_err("No RNG device\n");
+			return CMD_RET_FAILURE;
+		}
+
+		return CMD_RET_SUCCESS;
+	}
+
 	switch (argc) {
 	case 1:
 		devnum = 0;
@@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-U_BOOT_LONGHELP(rng,
-	"[dev [n]]\n"
-	"  - print n random bytes(max 64) read from dev\n");
-
 U_BOOT_CMD(
 	rng, 3, 0, do_rng,
 	"print bytes from the hardware random number generator",
-	rng_help_text
+	"list         - list all the probed rng devices\n"
+	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
 );
diff --git a/doc/usage/cmd/rng.rst b/doc/usage/cmd/rng.rst
index 274e4d88df..4a61e33d27 100644
--- a/doc/usage/cmd/rng.rst
+++ b/doc/usage/cmd/rng.rst
@@ -11,16 +11,22 @@ Synopsis
 
 ::
 
-    rng [devnum [n]]
+    rng list
+    rng [dev] [n]
 
-Description
------------
+rng list
+--------
+
+List all the probed rng devices.
+
+rng [dev] [n]
+-------------
 
 The *rng* command reads the random number generator(RNG) device and
 prints the random bytes read on the console. A maximum of 64 bytes can
 be read in one invocation of the command.
 
-devnum
+dev
     The RNG device from which the random bytes are to be
     read. Defaults to 0.
 
-- 
2.40.1

