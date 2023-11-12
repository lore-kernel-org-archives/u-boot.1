Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62371C4167D
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F1F87813;
	Sun, 12 Nov 2023 01:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WTcd/JZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E7086F87; Sun, 12 Nov 2023 01:10:48 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF3F86FF2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35932aa21a3so13142735ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747797; x=1700352597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtJxs0VvjC/vco6jJIPrkukwzWs6TVjEVzRWawKaWHc=;
 b=WTcd/JZnawmVwzGsac18rednHIoOvK7S0kT67pZ9zdcXxtcnzjDsBJvrYg7bwOma7g
 lTWEDYN9DJ5eZxKIz58uoU8TG0KaogCFJQLSWOr5r9YfbuxhS0W9zvbbkYL45M/d6bQu
 5N3Cer2CyM4aUGOKe7/5R+ktx/7sUrJleLR5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747797; x=1700352597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtJxs0VvjC/vco6jJIPrkukwzWs6TVjEVzRWawKaWHc=;
 b=JZa1EyI5M1hTLMK/N6EECXtqvnCFhCeh4QbdV/hQjgONjx/UNBONZTxB9GU+5cqMkv
 m7evDaHdjHotbCKSGQ7Fvc5VeAK9YZpPJybbHOSb0VDUFm+pQcmVBPOTsHZm38n0Eeym
 UX8uv0nACTVVBDss28IAJpfAPiA7TnD2w8W5cz+eUWP3vgc9waSmbLwu4Sp2/+VHr11T
 zlCURMo40jq+TeA82LKBnEpiixL5BPYIY+Jnmiu6qI3GkfvWXdOPENmv2JzxPke0+w40
 OvoXilHe7lf+ygjxKdUyOgRl+2eSCHUUzAAz+kIzAFVPilniPwnr8rVUVjxP3KNqJSki
 QlkA==
X-Gm-Message-State: AOJu0Yxef0Ukxj+oBCw5vPkXqA2OA4iA6NxfqIYMU63fpZ6fzSkD4mZc
 7yO/JFlgCUWa5vskRi/WMIPs4damWEC8hBRtKLxLUg==
X-Google-Smtp-Source: AGHT+IGUDuRaSwFSCEeKS9UGRXHKmnK4dRxrc3CZGepJ19Zj0mW9AdtOV6n+7LUeX+XpaZvNoBi7Zg==
X-Received: by 2002:a05:6e02:15c4:b0:359:38ab:5a55 with SMTP id
 q4-20020a056e0215c400b0035938ab5a55mr5178794ilu.22.1699747797011; 
 Sat, 11 Nov 2023 16:09:57 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 29/29] bootm: Reduce arguments to bootm_find_other()
Date: Sat, 11 Nov 2023 17:09:14 -0700
Message-ID: <20231112000923.73568-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

Rather than passing the full list of command arguments, pass only those
which are needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index a803b0749be0..b0eecbb0dd3c 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -571,19 +571,16 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 	return 0;
 }
 
-static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
-			    char *const argv[])
+static int bootm_find_other(ulong img_addr, const char *conf_ramdisk,
+			    const char *conf_fdt)
 {
 	if ((images.os.type == IH_TYPE_KERNEL ||
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
 	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
 	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE)) {
-		ulong img_addr;
-
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
-		return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
-					 argc > 2 ? argv[2] : NULL, 0, 0);
+		return bootm_find_images(img_addr, conf_ramdisk, conf_fdt, 0,
+					 0);
 	}
 
 	return 0;
@@ -1012,8 +1009,13 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(argv[0]);
 
-	if (!ret && (states & BOOTM_STATE_FINDOTHER))
-		ret = bootm_find_other(cmdtp, flag, argc, argv);
+	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
+		ulong img_addr;
+
+		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+		ret = bootm_find_other(img_addr, argc > 1 ? argv[1] : NULL,
+				       argc > 2 ? argv[2] : NULL);
+	}
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
 	    (states & BOOTM_STATE_MEASURE))
-- 
2.42.0.869.gea05f2083d-goog

