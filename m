Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07401C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B71839A5;
	Wed, 28 May 2025 10:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BAcA98fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810968399B; Wed, 28 May 2025 10:26:18 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9A1839AC
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4768f90bf36so35813621cf.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420774; x=1749025574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsyPmBKf6h1/EKhMUelTl83A8RvpWXiU/JgM47lsTtw=;
 b=BAcA98fyLk7Zvk5ncdF+YbXNf91ZenqQNHZuVlNdC8Mi8Q8waQxBvyI7/RiQlqtld5
 sSuY11rB7PktNcfoJTIiDo66dgjAmUVQDPe0I+VC7A36EAA5wgRKhakN3ynSDoO/rO82
 3qQeSW3lyv6lyLji1FJON0FgmKE3UWa/942Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420774; x=1749025574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GsyPmBKf6h1/EKhMUelTl83A8RvpWXiU/JgM47lsTtw=;
 b=kZRrQxkVG4vkOOIn2HljH9S6EfDvMoZC6lwSrLx3aTrfqw7pveI/yx6jgJkIpuhrgR
 L8OVTKUm8U/Tl5CR4rjPAjKPxk+4FiNFvhcT62JwMRdXN55Kfaf9D6E43gHjMhNZzYqj
 3zsknqYQwVWdfpXR7w6Uv3CjT6xkFwh+ZNMIqh05ZjJUrDEPRsPAIqxSaXPkhK489VPp
 5PFIcMga0IkJqPxbIXSK0EVgR7+M6xI5QUdGelrMIUCvdNqD84qmdb0HF+rqTWZ6DPoy
 SaMOAJOcm738iDJLdQfllFv33RMP7jH5TksgPF5xnIAOtlfYqHIwGqeR2ik/r3Woox7/
 yaXw==
X-Gm-Message-State: AOJu0Ywbhdl9MXWcla1eZ2Ktn5cLVzGumn5wwcZVxQLlF8Zg5bn2AVme
 BGOSnZIEST7rbR+XkCeQgkP9LX2QJCCK9xE6CAOXcuUkJ+atNdvl/Lr3k9GX7QN1e7Ypi2BHZWI
 GcUV8yjLo
X-Gm-Gg: ASbGnct8TQBHbPtZusUNXHPevKmCH4qNQdVCPb4WLltTuOKHkOT3jYh8h9/QPeW/4Qq
 f9bZE88gRGO1WzmozNhG86p1QO4Y28wMLvSQpy+wlW/gvGiMFnZa9gIUoNPT/4W+7UGhpLMNsZh
 3jm45Vjxa0uxv5YtWnF24SBMMruCr8QkxFrc9Kp3PcytGt4zsz3taIwv/HMcVjmVKm35sYlKFLY
 vaPXFG/RVi1YUGpNoLodTYC8juVAUR1FO0dBK2WaRDtCcBqdmff3kmljrhix0AKj128xHDimRyF
 G83cKvxFufUdJrFvs9D8tsKURgezTbxX8RvmkHRfacLiuhd+ms2kMYld4nqsU83ghWDLTCABLUc
 366yNdIDfA25Q
X-Google-Smtp-Source: AGHT+IGOrrIo4pvyIkYlvZlmeJZbu6Puw6WbIQ1xTjOuCTSR/dZL4pAjo+kZn6fmThnx8VD683yecw==
X-Received: by 2002:a05:6e02:3b81:b0:3d9:668c:a702 with SMTP id
 e9e14a558f8ab-3dc9b6a526bmr160822345ab.9.1748420763388; 
 Wed, 28 May 2025 01:26:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/27] bootstd: Provide an option to scan any partition
Date: Wed, 28 May 2025 02:24:36 -0600
Message-ID: <20250528082520.152391-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

By default, if a boot partition is found, no further partitions are
scanned on the same media.

This can be inconvenient in the case where there is an EFI
boot-partition present (mounted as /boot/efi), but extlinux is being
used to boot (e.g. mounted as /boot).

Provide a -p flag for 'bootflow scan' to allow any partition to be
scanned.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 6063d9dfa7d..a8d9cb213e6 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -156,6 +156,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct bootflow bflow;
 	bool all = false, boot = false, errors = false, no_global = false;
 	bool list = false, no_hunter = false, menu = false, text_mode = false;
+	bool any_part = false;
 	int num_valid = 0;
 	const char *label = NULL;
 	bool has_args;
@@ -176,6 +177,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 			list = strchr(argv[1], 'l');
 			no_hunter = strchr(argv[1], 'H');
 			menu = strchr(argv[1], 'm');
+			any_part = strchr(argv[1], 'p');
 			text_mode = strchr(argv[1], 't');
 			argc--;
 			argv++;
@@ -194,7 +196,9 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	std->cur_bootflow = NULL;
 
-	flags = BOOTFLOWIF_ONLY_BOOTABLE;
+	flags = 0;
+	if (!any_part)
+		flags |= BOOTFLOWIF_ONLY_BOOTABLE;
 	if (list)
 		flags |= BOOTFLOWIF_SHOW;
 	if (all)
@@ -620,7 +624,7 @@ static int do_bootflow_cmdline(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_LONGHELP(bootflow,
 #ifdef CONFIG_CMD_BOOTFLOW_FULL
-	"scan [-abeGHlmt] [bdev]  - scan for valid bootflows (-l list, -a all,\n"
+	"scan [-abeGHlmpt] [bdev]  - scan for valid bootflows (-l list, -a all,\n"
 	"   -e errors, -b boot, -G no global, -H no hunters\n"
 	"   -m menu, -t text-only\n"
 	"bootflow list [-e]             - list scanned bootflows (-e errors)\n"
-- 
2.43.0

