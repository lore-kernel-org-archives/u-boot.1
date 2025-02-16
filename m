Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F46C021A0
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 02:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE47780F18;
	Sun, 16 Feb 2025 03:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eu0MlV5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E73C801B0; Sun, 16 Feb 2025 03:04:14 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2A6801B0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8555e673b2bso110219539f.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739671450; x=1740276250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhrUu9c/RDx9MQYMxpsOXbt5oUb5XGHyT7dA12UtqWg=;
 b=Eu0MlV5X/pDaKnUPEQBZh1bFw8mCxKzS9A+VfKpBl9FIEKnN0E/+EOFECklOwMGEDA
 YG0byxef8Xjnh5Tk/A9nE0IUQKyg4HpaKI4USAm+Eyd1jj4Fjpau/EpYI1l3uEITT0Yt
 YXI16ppWYL+GT/qeLv9C1lxLgDJenEbYCVsdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739671450; x=1740276250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhrUu9c/RDx9MQYMxpsOXbt5oUb5XGHyT7dA12UtqWg=;
 b=ZxtvileCYcJSu8wUW82huX+aGMrnRhc1fvbZqq6lBilB4bqlR19yHOEJRpc4CJmGTy
 exFv94VlLfH/dym5XQBnvD/ZOVC8hJW3CCdvQNk6ArS0ffmiVQxNqa5OWfKGPPJIt2Ra
 MOFrtz77Btj6ka51bwX5nHs9TKbQ9rKCVWEju0DYG6UKj0mL8Tm/ACwvBshakyXBCziI
 hrEC+41YXQP7XD8F6VFHJ1AtJaSc4UtCiUrlu5GloCnQ+BxyjlL+Fj8JK49wg98GKd1d
 FZCWTv9JV1JqTtJ8bofLIVDB9ulkVBpv3pk7K/9FgL0csR1LXghQu3m46EPUVvWscL6J
 G+wA==
X-Gm-Message-State: AOJu0YwGFDPnxMsfgG9cRNoM1ecs51AeTVTVz4Gu4ti0y8jhkw6UIzXI
 uzQd/EMk/n6bl9V+o5zcCq6Fh4XIOCqpAXJF5RIBI0Tkg+SsF55jDFjMJ4HAuNMtnB/iy4AozqE
 =
X-Gm-Gg: ASbGncskKSQe+R4VJpEY/zt+BSEuSHtAU8t2bfCnIi5a9BdWMVauqz5KERKspHeH1y9
 qM1fIRhIbELmIF5SPTyYQ0DcfxGmkdJt08VDqtEJ0z7zOz48HyaJ9LD1BHMDzrPraJBiN6ZQ6cz
 mAyF9c6klsz2gQ8YS0w12JDYtqL3UoNMar1tXE5FEwRLywZeg4shCRcQ72EgHqJTsfIfq5qKWq8
 /pp/WWLc5mOH8kOCxZTg8E+mQbNUFLFW0F3COLgl9yrZkUNPqm/8ap5DG+SrjKKeCyhSUvasS0i
 t4rMoqzCI7Vu+x9nYq39TuB93ysd3bqm0qvfqMEs7qG0eS4x77RL
X-Google-Smtp-Source: AGHT+IHt8VzZZLXOV9A/yxYQDwcUSOCw6bOEVMRXTCSDKVl/vSKC5gvYMG1QFygfiWM4qZbYPJ9Wbg==
X-Received: by 2002:a05:6602:6413:b0:84a:51e2:9fa5 with SMTP id
 ca18e2360f4ac-8557ac70ecemr306089939f.3.1739671449666; 
 Sat, 15 Feb 2025 18:04:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85566e63bb7sm133525339f.25.2025.02.15.18.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:04:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] x86: Stop working around skip-at-start
Date: Sat, 15 Feb 2025 19:02:35 -0700
Message-ID: <20250216020359.3878546-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216020359.3878546-1-sjg@chromium.org>
References: <20250216020359.3878546-1-sjg@chromium.org>
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

With a recent Binman change, the skip-at-start property is now honoured,
meaning that all image-pos values in the affected section start from
the skip-at-start value.

The x86 code works around the old behaviour at present, so update it.

This fixes booting on coral

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/intel_common/intel_opregion.c | 1 +
 arch/x86/lib/fsp2/fsp_init.c               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/intel_common/intel_opregion.c b/arch/x86/cpu/intel_common/intel_opregion.c
index 78caff0dc12..4a2717b3584 100644
--- a/arch/x86/cpu/intel_common/intel_opregion.c
+++ b/arch/x86/cpu/intel_common/intel_opregion.c
@@ -31,6 +31,7 @@ static int locate_vbt(char **vbtp, int *sizep)
 	size = vbt.size;
 	if (size > sizeof(vbt_data))
 		return log_msg_ret("vbt", -E2BIG);
+	vbt.image_pos += CONFIG_ROM_SIZE;
 	ret = spi_flash_read_dm(dev, vbt.image_pos, size, vbt_data);
 	if (ret)
 		return log_msg_ret("read", ret);
diff --git a/arch/x86/lib/fsp2/fsp_init.c b/arch/x86/lib/fsp2/fsp_init.c
index 1a2bf46c5c5..e4a87d8b2e1 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -141,7 +141,7 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
 		if (ret)
 			return log_msg_ret("binman entry", ret);
 		if (!use_spi_flash)
-			rom_offset = (map_base & mask) - CONFIG_ROM_SIZE;
+			rom_offset = map_base + CONFIG_ROM_SIZE;
 	} else {
 		ret = -ENOENT;
 		if (false)
-- 
2.43.0

