Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF38C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6F887B26;
	Thu, 14 Dec 2023 17:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dg/SVTgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC3F87B1D; Thu, 14 Dec 2023 17:52:04 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68CE787AC2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b7020f03c9so338062639f.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572720; x=1703177520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ffa8db0IaaSajpxf1ZvNZr6FQPXIziqy0+8+XeUYcg0=;
 b=dg/SVTgvlVtg2S5IbMrlqHy2O2Jj/VR3gQGItiXgVNiMIqGMRvPLg+Dk2owlTsNWBo
 tXZom5P6LNZ1ptvbFA7HgF/ZdsSSW4yYJfHoUca+SO7K5yRInawfQw3kK91uBSvDErf2
 fbhgTO3p9ad4afbCXTlD/5sHyUvXE/a9zup3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572720; x=1703177520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffa8db0IaaSajpxf1ZvNZr6FQPXIziqy0+8+XeUYcg0=;
 b=UQ6n/kp2595snnMl80IWs1ckk16gSMjE43OOSSXTvRhBjzv1M8C5+2ifTiY8rPCi7R
 EmvzR9WYKb7l5vtu3thxf7M2ECFaiInExtXnPEtwiD4NpP+gzMVDm6AHfEiTs37fyMu9
 AjBGbfRLUIJfw3uV1lH/X0F+6WfxgeOUbUBqsm9MT1ot6lO8SMMHpU11AFZXZgDtVUJf
 taqpCgJjKa3mWBZA63JdjGIo6YQQsDt8/3Al/pbNTX2EaiGcfiP0veq/GIqWYXl/X96M
 Mhu4BC+i+THHvv6prZ4yeCO4TjTddC91K23ylkooxmw/rBIvnfsmZcfWXUNlR58+katF
 XcFw==
X-Gm-Message-State: AOJu0YySf8RPS75bUuBuyHGCdnLiOWYfjNxnrkAjb7T31qqRTDNUGJde
 fSiombhBQM3UPqrm5Oyu0OcNp0v6Ny/A4MFZkFyuGw==
X-Google-Smtp-Source: AGHT+IFzVyQQUJT2kImMb/ZeGuloJpOT4ud3RLTS9nC1ZbpiKqva9D0IsNNE2CBGP+xNStYl+X2Naw==
X-Received: by 2002:a05:6e02:1609:b0:35d:6909:3b5c with SMTP id
 t9-20020a056e02160900b0035d69093b5cmr14365645ilu.2.1702572720027; 
 Thu, 14 Dec 2023 08:52:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 19/21] bootm: Create a function to run through the bootz
 states
Date: Thu, 14 Dec 2023 09:50:28 -0700
Message-ID: <20231214165112.2182274-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

In a few places, the bootz command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
bootz_run() function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 13 +++++++++++++
 cmd/bootz.c     |  9 ++-------
 include/bootm.h | 13 +++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index bd1022ada590..1c5a99817a82 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1142,6 +1142,19 @@ int bootm_run(struct bootm_info *bmi)
 	return bootm_run_states(bmi, states);
 }
 
+int bootz_run(struct bootm_info *bmi)
+{
+	int states;
+
+	bmi->cmd_name = "bootz";
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	return bootm_run_states(bmi, states);
+}
+
 int bootm_boot_start(ulong addr, const char *cmdline)
 {
 	char addr_str[30];
diff --git a/cmd/bootz.c b/cmd/bootz.c
index aa8339318413..0d771a786a71 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -74,7 +74,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct bootm_info bmi;
-	int states, ret;
+	int ret;
 
 	/* Consume 'bootz' */
 	argc--; argv++;
@@ -99,12 +99,7 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		bmi.conf_fdt = argv[2];
 	bmi.cmd_name = "bootz";
 
-	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
-		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
-	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
-		states |= BOOTM_STATE_RAMDISK;
-
-	ret = bootm_run_states(&bmi, states);
+	ret = bootz_run(&bmi);
 
 	return ret;
 }
diff --git a/include/bootm.h b/include/bootm.h
index 871a44ab05c2..4665c7a24fa5 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -163,6 +163,19 @@ int bootm_run_states(struct bootm_info *bmi, int states);
  */
 int bootm_run(struct bootm_info *bmi);
 
+/**
+ * bootz_run() - Run the entire bootz process
+ *
+ * This runs through the bootz process from start to finish, using the default
+ * set of states.
+ *
+ * This uses bootm_run_states().
+ *
+ * @bmi: bootm information
+ * Return: 0 if ok, something else on error
+ */
+int bootz_run(struct bootm_info *bmi);
+
 void arch_preboot_os(void);
 
 /*
-- 
2.43.0.472.g3155946c3a-goog

