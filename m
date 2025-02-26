Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6B6C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BDAC811DE;
	Wed, 26 Feb 2025 17:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VmOh5saW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40318141E; Wed, 26 Feb 2025 17:26:53 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE6B8004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-855bb6041a6so173990339f.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587209; x=1741192009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUvQ+gvgQoCfG374n1w2Nnb1EQTm3xQfrhoq9MB+g2I=;
 b=VmOh5saWbr8J/Is/+gvW5/QGs+zG/Hfk7MJKN60BfE8qgWiy3+M9kIEw6/sas9vnOA
 G8mtwpRekn6eWjcFjlCmkQ40xH0TiIm5DzIb3Hg5XOsvG2Oo97yy54g2eN79SQ1tAsz4
 72VLbnevrDpNrTAQX+77Syn6C9ZOnWXttP++g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587209; x=1741192009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUvQ+gvgQoCfG374n1w2Nnb1EQTm3xQfrhoq9MB+g2I=;
 b=vuBKqdlsf/C/ddtR20eIzHm7HtBq6WtEnF/lL86i9YB62cZJPBX+fkfUkGTFATbL89
 0Yw+iaywTQLCDTdPgMDyJ+FIyt1F0PSe2lxpsEe8ml+d56UOjpTdbQuPvhrg1BQXWLmo
 2hqqon6z3aqOp7REU/d0k4/ivPXqNNlPVNAy+NiFubOST9CxQwfK6jhAqVRQkWOS7BJj
 A0yUviYzn2b7f6bxlAacLmq0qJ6ul/TxlYCiqqQE6n086AJ/0YbAGdyKPSzIkzvUII8o
 CgK7+kz3jhGGYFNAj6RwATOr7NYTICH7hxFsQoTuFW8d/WThRy1ZA5MjbY1Z9GmM5ljf
 wSXw==
X-Gm-Message-State: AOJu0YxmguDohIcq5YE6ye4rOq3ONakWze6VFrthgOztstej7LgAPOka
 4RRkY8BbIXX0huA2MuLc/25oQaVB/i7AK+qwmGfcd1ZNkzPLeQqW7a7XUCT6uZXC0/50pWovHkU
 =
X-Gm-Gg: ASbGncufLwLvpXkmRh+aUX++mFgGEx9CH+1xxzzmegV8VtcjFB0UMJe3AmkmN2ELcfL
 3rBIJ/QXIiET1nq6sJwtQYLySYfRYrOqG4ofMu8cb8fiqDH69v2c3f8CKZMM0C8nziR+zCOI0tS
 OY+fLefREtfzNuik9sQkC/Fzr3E7t/Gkfc+Z1DQKxlaWBF5Pbl+3SaguCPjptTARzRuM93dTtYx
 ZhLZNoGCNorbwFmdyN5gJUxqK4MrOVjBtazlpZPrqstNHI9fsWEMNaBQtgzfcUbP+pGc2id+/1T
 1Md6NKyo+a7f9JCJJzRSM3REUPpo7LXB7b2wHS1ZS3arxGkclpmXcxpgRtObBmY=
X-Google-Smtp-Source: AGHT+IFtqgUu1q6tqtVzl0t24EigJnWL2KfpFrcAgQ/J2URkBTsq1SlBFhrqvH2Cpiz6Q8U9FwkKbw==
X-Received: by 2002:a05:6602:3f83:b0:855:78b1:8c1d with SMTP id
 ca18e2360f4ac-857c1815e62mr436062939f.13.1740587209617; 
 Wed, 26 Feb 2025 08:26:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] x86: Stop working around skip-at-start
Date: Wed, 26 Feb 2025 09:26:18 -0700
Message-ID: <20250226162621.2681677-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to stop working around skip-at-start on x86

 arch/x86/cpu/intel_common/intel_opregion.c | 1 +
 arch/x86/lib/fsp2/fsp_init.c               | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 1a2bf46c5c5..0be892b14dc 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -107,7 +107,6 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
 		   bool use_spi_flash, struct udevice **devp,
 		   struct fsp_header **hdrp, ulong *rom_offsetp)
 {
-	ulong mask = CONFIG_ROM_SIZE - 1;
 	struct udevice *dev;
 	ulong rom_offset = 0;
 	uint map_size;
@@ -141,7 +140,7 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
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

