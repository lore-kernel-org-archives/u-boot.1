Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4974AFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CB384255;
	Sun, 26 Apr 2026 17:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ppgaUvmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4951D84255; Sun, 26 Apr 2026 17:41:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF11284119
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48374014a77so123555655e9.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218061; x=1777822861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=ppgaUvmzbVlJtBMLSp8yoADuAXpNy2D91TMyIlbmRbBBApLCKk3gSqfyulu0YCG5vE
 uJozn/3WCqGryNRihwtN4TIEC6gLUSLch9u2QmsXNvrJdYtkG+dqkCg1z42wE7P6E62j
 v9ZF8LqyUAyo6xbCvyo9HwGc0zb1plShp/Z9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218061; x=1777822861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=otlF2CMakvFAy50iN5flLuSdsz0Pv2cGhl4XbRuZAI2k5rdpd0iNbml4SQXZCiQffF
 Zq9ACeWHhWRVwuA64w9hcgQHq5uw7hrdu8hH49qKdqeDi/Zqcrut0PhWHvPcqICPZoXw
 IIe3jc9LTuaAjQ2nvEL1cZRi9UyRspfEmLMhS9jW+8eLNOP5KEOBheFp5h0QNCwwkNdO
 pCOaGLuLInfaUyyN4d6H8SfPPeq3ON7Nl41ubRuNbyhHqBLGgVRh1RfUz4lMPPMb4O9o
 h/2xkwN1onZ4a642DGv6e8C5dCF1kSeQbn2qzJQgazynOO244gVxcrh826MjCwvtxzap
 tReA==
X-Gm-Message-State: AOJu0YzFUezohPifUphE3c1PbdJH91xa5oiZfmFNg9lSn8tIgQhDUrZD
 YQLRzcoiAVy97qdcdofevmv+pR0KHyYbaM74D44AcpIbrikquqc83Ad/uT6aLLy76wZw5iZlGi5
 yKaX4
X-Gm-Gg: AeBDieuv+F/C7pJiKDD5AEva24zkJV3rQPEI/oZut91GXVsiN3n0VR03kXUmlhSCgLw
 BxxbNO9jvgXh9uWtVhS1u4HfifiTQcvbNrVU0QrPi412Aqt68pOWyT4bI2bY0z5yJbdfOCgS8fb
 rdSUoJoDorjCaC8Y0jgefnlvPwUPj+M1vid7uj4gxwhIa4CekAiWN69ubEiCa31cQIrlksScj+V
 GCMVRPj/ZpCM8bBpao5Os31/fx7SQEM2XsiTYsQwaT5SL7m68CEd1+tBUyPuGLMBdISKa7QTduy
 54QvG0Dg+EJro7HdY+tMpvlJHG0MjY2OSTH28MicEl3oaRUBULfVXrfTowh22NAZKYS3uMW+n6E
 XvvaXuLu+CdPjYo5mAdZXEQZpvylrdtjnjdKmkdGheKYlP6RXSiJcv7mwxvZYss5lpnrrgjs/09
 LtWYcduZC3WZMGw9isG9qoPKJ+ESvF3P7v9IT87jhcGS2xbWLz0KZCJp5r2VhD5JZHpJzCrEIZq
 i9D2QtaRuI5JnLkOiKTnczu2JwOhPkYZh33qVb0d4d2YtTi4amkUhy4oBfLs8C1WN2p073gChqy
 PQQey/dPX6/2363X11wRg5RMJ7Yx3A==
X-Received: by 2002:a05:600c:8b28:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48a5c230e78mr277841135e9.19.1777218060633; 
 Sun, 26 Apr 2026 08:41:00 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:00 -0700 (PDT)
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
Subject: [PATCH v6 1/8] lib: uuid: add partition type GUID for extended
 bootloader
Date: Sun, 26 Apr 2026 17:40:33 +0200
Message-ID: <20260426154054.2040932-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
References: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

