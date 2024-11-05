Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97740D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82988922D;
	Tue,  5 Nov 2024 17:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e9Q+oVWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518338920A; Tue,  5 Nov 2024 17:08:10 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A65A8922D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a6be369d23so12057185ab.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822885; x=1731427685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8g4tS4PXCcMosjAgerRQEdNgX+TFlFVHSNmSM9TuiV4=;
 b=e9Q+oVWYoXVEXb7ELiAS6dgiooRzi2zfvr7zEZ5A09TEw5noaiu+MwOTCmynDs+axr
 ATd+MS8lKANnPGU+YbM+Jw0OqqZP3AjQmuuCZ4uk9MBmXQ0uuJhqfhGk5F6eLqL2/dt0
 uJ+u/SnSdPq/1G3vmwAfh9sN0JXMjMvxE53S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822885; x=1731427685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g4tS4PXCcMosjAgerRQEdNgX+TFlFVHSNmSM9TuiV4=;
 b=lkumtdQfJfaxSf0PKtMMIwBUndMO6wyMfpFOoADXaXaB6wvMWWXXM69iscAh6V6YwD
 S4nknBSEFEGlu07XbEczWVWqqL9wf9qtOWW1mh/oiid9WRbKa/D8aU0BIn3tFLgB46kM
 4rQckvQxx2raY0v1WL/fzgilpdcOUSIOusJXCiL4sIspgFYc9l4szbCve7XISIDpLCv+
 IphqY0aTkCKiqVjEINviagkYjazGOGnk41Ow9xo+P+JNwuyLeCty4j6sVWkwd1Xe4kvX
 tCXITtJJrp0NRAbf5+FdIKdjBmQIbInAXAJzefY0/UMds38HIOb6swsZESN97ljITsI9
 eL/g==
X-Gm-Message-State: AOJu0Yz3aY82SshDSoWvIag3L5foTf6WVbD08TMlwCSCXo+3bLcgzota
 WzUsgsbJnJIFUTs5kXKbYvwp5yHHT1DIsN701M4nzytUzKoEKXm+qr3jUgjfh77Ghp558u8jS28
 =
X-Google-Smtp-Source: AGHT+IE4ADYvEc07FR0w+Afo/1uR0Qqwn2sjNkVyIbW+td/fcvXLFoWWNFXTS0YTuIZO6G9G9zpKkA==
X-Received: by 2002:a92:c26f:0:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a60f219a0emr200897305ab.11.1730822885189; 
 Tue, 05 Nov 2024 08:08:05 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:08:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 8/9] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
Date: Tue,  5 Nov 2024 09:07:37 -0700
Message-Id: <20241105160738.3795497-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
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

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 9eda6d8d402..72844d2c50b 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -306,4 +306,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.34.1

