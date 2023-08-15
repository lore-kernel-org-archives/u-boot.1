Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EC9C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E60869E0;
	Tue, 15 Aug 2023 18:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rGDmaWDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7665E8671F; Tue, 15 Aug 2023 18:27:52 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED67869D6
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1c5046642b4so1385290fac.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116868; x=1692721668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMo2EMs3c+Pz7rioGFr1PCou8iiqIrmb+EhLCpbRpPI=;
 b=rGDmaWDJTlsPrQzj4kmtG9k2Uhhj5PngCg8kAbIfn4jOBf6/up2y+KS7PRR+xsAj6t
 UDoqdGUaNxWwv3tGfVbT+fsLfEL3j+aGLWmDtuuDQbsWhbYOLeEoHEWUFq4NiSF9v4WU
 FThoRkdPRORPr4na8dzVOq4eiMWXU0VTOiQeC4D9DKGYDp5fI33tAMLD7sGAjgmlNpwb
 j4lQTuy+5UFrk5vOifCYq4t2V1rMngaHMzGczPsWXpB7gaSr9ic3m7vE5705zyVjU58p
 dFrP8//r+246nwjfKV4fF48a+CofmnRopxBS8dzfw+LQJ9lykshZwlsQCroo1EyT6m9i
 JJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116868; x=1692721668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMo2EMs3c+Pz7rioGFr1PCou8iiqIrmb+EhLCpbRpPI=;
 b=C5mtRzAaNn3jXd8gKvyCukosjGsOP2T8eYTJZX0S3QqHBWs+JJMvqLaD1OGDUdgYFX
 gn+Utldh2grElk0jXu3u9E3Eifc7ThBGT6Tp9RbndTKF1RmNTiXxlKjzEbQaJXOvWOnn
 L/La6pXUHkirCDu05JxTQARssVukkWqonNPerbw+42MrdCZcFXjtOQZi3XT2OME98G/j
 e+V+KVGtGaPnvnbWUb5vWMK8qgizu0f2YO2Y7Ds/QnfvFlBZ5cTU78A2kYTjxj7JCkuT
 637Eh+Qw1k07j9su5nVmZZiOpug9RfVSVBH1lB2CRAwPCVXYgyQo224/3kHzaV6izAzT
 bkeQ==
X-Gm-Message-State: AOJu0YymZ3njFzh2IitdLuJtXNy/k/FDiLaQ6hyB1L2lCrkWy5wRph+O
 c4Hc8MRw/4o9SPYXYLQU9PJm919rIIQ=
X-Google-Smtp-Source: AGHT+IGEAaHaJkHn4P3e2zzi3+z+LCbM7d1PUA+zV3qTGvbNpfBsJLlAlDVhE/v0MHLy4OCb6B/ydQ==
X-Received: by 2002:a05:6870:80d3:b0:1b4:6d3b:3e15 with SMTP id
 r19-20020a05687080d300b001b46d3b3e15mr14503426oab.3.1692116868498; 
 Tue, 15 Aug 2023 09:27:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 3/6] cmd: gpt: Add gpt_partition_bootable variable
Date: Tue, 15 Aug 2023 10:26:57 -0600
Message-Id: <20230815162726.1524958-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230815162726.1524958-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
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

Adds an additional variable called gpt_partition_bootable that indicates
if the given partition is bootable or not.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index a4b8b2b286..bc08799512 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -723,7 +723,7 @@ static int gpt_enumerate(struct blk_desc *desc)
  * gpt_setenv_part_variables() - setup partition environmental variables
  *
  * Setup the gpt_partition_name, gpt_partition_entry, gpt_partition_addr
- * and gpt_partition_size environment variables.
+ * and gpt_partition_size, gpt_partition_bootable environment variables.
  *
  * @pinfo: pointer to disk partition
  * @i: partition entry
@@ -750,6 +750,10 @@ static int gpt_setenv_part_variables(struct disk_partition *pinfo, int i)
 	if (ret)
 		goto fail;
 
+	ret = env_set_ulong("gpt_partition_bootable", !!(pinfo->bootable & PART_BOOTABLE));
+	if (ret)
+		goto fail;
+
 	return 0;
 
 fail:
@@ -1133,7 +1137,8 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	" gpt setenv mmc 0 $name\n"
 	"    - setup environment variables for partition $name:\n"
 	"      gpt_partition_addr, gpt_partition_size,\n"
-	"      gpt_partition_name, gpt_partition_entry\n"
+	"      gpt_partition_name, gpt_partition_entry,\n"
+	"      gpt_partition_bootable\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
 	" gpt guid <interface> <dev>\n"
-- 
2.33.0

