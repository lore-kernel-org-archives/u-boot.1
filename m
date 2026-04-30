Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5682FCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A467684605;
	Thu, 30 Apr 2026 10:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jbuRn1pI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F5E8464E; Thu, 30 Apr 2026 10:06:41 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5E4845E3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44261378651so1107732f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536398; x=1778141198;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=jbuRn1pI2QwCJZ0Lz9ZrlXoXQ+8SROfRMEizqZToHVnZ/4XWNDDUvnKuv2S6dQtIAY
 u1hoNUqKqefU8hNu6L+EHKCVwcLCWn/W73X0+yzcdq5aX2KbiZHID0vPZ4UhVF2nzBJ3
 k6PRrbGt+/OH4jKow953QL+hqcCSkcGyA97sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536398; x=1778141198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=VYgSqQlpEUOMUVd87UeGGO4TGM4Lx1osmUtWImgp3kEHUgg3RhqGaFu2R5n8ruzP/l
 nFyuB3dMppQiFeaucpbe2Kq80QBcIVnHa5W3yXHSVx/N4xh/Q1/txcdwltfBCktfE6rT
 YiLAnLI46uD6mo7vTNUd3tw5kj6KEjl/grAvOEu9Mk+Om+VjRAekAV2Vur6OjsmeqtaL
 Q3f2xAxZTZ1MaIdegGSviHJxQpYeYbKhElZ+5PM3IDd6ntiVVe9kfr+M66IgBI+sNECR
 FO7uocIlhHFdKuXvjH1une9W/0ktEz07UJn2WItChmziR0Rz59g17gEeDqgiRu2dEgpZ
 NcYA==
X-Gm-Message-State: AOJu0Yy+oiFJsOYKvky329MwOazquZH30euDVgGqrCg7+IPWnH5k86FH
 +wxzo2uirjGQVL+XCLcBQ+OJ7Y7OmwUkMO61U4K1EEjiY/+kmetYcFByM/6usp3eSc/yhKI3R0M
 T4ESG
X-Gm-Gg: AeBDievRZctsHrqKJECXLTheaTg8Zo4h3BsESGzHRWmXMf2D0fGs+tX5WgU26xzk39G
 5t5KUN4AQ1L/EXvn+JIpIClJjb9Xh9ZVU/PH+llHsSg0qdVXwl4ucpBx9PFA00TjxcXr4fv4+QZ
 AGz/nFRvA1wdZb8DChdCjS0DCJ15hGh87/FZ8i0EK2i/Gdu9oe2rXinG65jrwyN4yMp728670X5
 d1f5OakG+7TKArCKuE6wIGVTD9W3Cu3BmVVpwzXNsqYKg9yj9+Xv5VadAmUd5lc76pSX3yQeN9j
 Uy3KADZK4zhcyH1qvZi/nr9wavT7SUho3nP8Fo0csaJ8mrFZHMDfN+4bDBpPNQqipyFLvIAOo48
 yO8aiL1cc+FiCCcltzVaNlh1z0VS2f2KCxjIjCLCpW3XxJMsuocc+nZWjxgDsdJAbspp86EkLIH
 Vw/cHWQQJKpJuFuByv/9tBC8lbf0obXFXF6ktWa3W39cRH1PzQmsnuwErS9rnwx/LE1uOJPzhTM
 P3W+mzNIOLgRLH0WPTVDSr66C9jVoNXEwofZ7HkwRS+pDd/G4dWRq3pPrYURSEYC4HFbn101aIg
 XYFc0Apsdj37zKPtnhHz4KkJSoGL71Z++14=
X-Received: by 2002:a05:6000:18e:b0:449:8650:954d with SMTP id
 ffacd0b85a97d-44986509648mr1007311f8f.12.1777536397660; 
 Thu, 30 Apr 2026 01:06:37 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:36 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v8 1/8] lib: uuid: add partition type GUID for extended
 bootloader
Date: Thu, 30 Apr 2026 10:06:02 +0200
Message-ID: <20260430080627.849636-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

The Extended Boot Loader Partition (XBOOTLDR) is a standard defined by
the Discoverable Partitions Specification (DPS) to host boot loader
resources outside of the EFI System Partition ([1], [2]).

Defining this GUID (bc13c2ff-59e6-4262-a352-b275fd6f7172) allows U-Boot
to correctly identify and label these partitions using the "xbootldr"
shorthand.

[1] https://uapi-group.org/specifications/specs/discoverable_partitions_specification/#extended-boot-loader-partition:~:text=UEFI%20Specification.-,Extended%20Boot%20Loader%20Partition,-bc13c2ff%2D59e6%2D4262
[2] https://uapi-group.org/specifications/specs/boot_loader_specification/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v2)

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message
- Add Reviewed-by tag of Simon Glass

 doc/README.gpt     | 2 ++
 include/part_efi.h | 3 +++
 lib/uuid.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/doc/README.gpt b/doc/README.gpt
index 386ac2e0fc8f..a6e1fd7ce8d4 100644
--- a/doc/README.gpt
+++ b/doc/README.gpt
@@ -286,6 +286,8 @@ Some strings can be also used at the place of known GUID :
 	                    (E6D6D379-F507-44C2-A23C-238F2A3DF928)
 	"u-boot-env"      = PARTITION_U_BOOT_ENVIRONMENT
 	                    (3DE21764-95BD-54BD-A5C3-4ABE786F38A8)
+	"xbootldr"        = PARTITION_XBOOTLDR
+	                    (BC13C2FF-59E6-4262-A352-B275FD6F7172)
 
     "uuid_disk=...;name=u-boot,size=60MiB,uuid=...;
 	name=kernel,size=60MiB,uuid=...,type=linux;"
diff --git a/include/part_efi.h b/include/part_efi.h
index 2cea50880465..5713b3018f42 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -60,6 +60,9 @@
 #define PARTITION_U_BOOT_ENVIRONMENT \
 	EFI_GUID( 0x3de21764, 0x95bd, 0x54bd, \
 		0xa5, 0xc3, 0x4a, 0xbe, 0x78, 0x6f, 0x38, 0xa8)
+#define PARTITION_XBOOTLDR \
+	EFI_GUID( 0xbc13c2ff, 0x59e6, 0x4262, \
+		0xa3, 0x52, 0xb2, 0x75, 0xfd, 0x6f, 0x71, 0x72)
 
 /* Special ChromiumOS things */
 #define PARTITION_CROS_KERNEL \
diff --git a/lib/uuid.c b/lib/uuid.c
index 3a666d0430db..d7c164ea06bf 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -86,6 +86,7 @@ static const struct {
 	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
 	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
 	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
+	{"xbootldr",	NULL,	PARTITION_XBOOTLDR},
 	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
 	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
 	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},
-- 
2.43.0

