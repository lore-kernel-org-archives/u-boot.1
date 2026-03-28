Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE5210F3DEC
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B8683DA7;
	Sat, 28 Mar 2026 18:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W/JStxNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F068083DA7; Sat, 28 Mar 2026 18:17:00 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0722180077
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so25152255e9.1
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774718218; x=1775323018;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gI9NPjgvG3jfqA9wtO4fse8fxDtOhFx28Vby6zIrCo=;
 b=W/JStxNhRpwA8Yd5A9ZV4fNRwRbF/7V4pEYh6jXkS7hoACx74F+G2FaTZg+yNNnmWk
 WwzDj6//IA4KeW5cKvck1YDxs2xQtiIZdjBZ/qRbhjXyo1Q5AV6rVvJXyf7vwLCuotY2
 PygoyFLWbSmwaAKEciiQiKpd7rHVqDYJmKyQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718218; x=1775323018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gI9NPjgvG3jfqA9wtO4fse8fxDtOhFx28Vby6zIrCo=;
 b=ikIzx8wo5sLHl1Bc3GF5cDoAUutZJW1e1qHZCYl3FV884e2lF5tbNaE7qkbnLZhues
 vLPqd97fTtcpNviZDJqCVYGkPf/T0P4e/3iHDyBYUSkJn5wMOtTE21117yInrJBoGGrJ
 WSJCriZuNa+5WmLlufNHvxMu2E/woJjmL+/jqrMArmXaXrsSG6D6z8bx6l2/4U9mWP9t
 ZTIW7C1QuzIardLu3k1QmcreG+mzStK18AIxPGMkw3mxLyMj7ddU9GHC+88weX4CUqVt
 4M2MM18ptDw30hFXrQ5DTcyIEguGyarshW0l934iPj+5CtJ3ZW5o56g6pWAU4q1cNPGL
 Citw==
X-Gm-Message-State: AOJu0YynRdtKJ1dLRQNMOJvuuAAPPK4jHA+cr1T9CoFgRXG2bke5zjBp
 tLZWBnK7nyh+dcln2KU9VlTH5IFkxDG+VFPek2FJpwNGJSsAcLPKoXnxX5j8TZ7HqAZzyHBMmqM
 qv3JB
X-Gm-Gg: ATEYQzzESXrggfjEuTAyQe6JqmxfID8C+Kq5DTnfGfR5bMCkzhSIF+Qv0N+OPJLHyor
 tPDZzIIAUJmqd+pmMq1hblCbDxyhu8yl3NWkqY3+QJ4FUmyo2S1oTrKiXiUwCtZm/ztpkKEFHXz
 /ib6rLw+KoXA4D7v6APk5jt8xnemTB98OV6Ysf/2RAGYIPjlRZDYNfy8wt7ofBxEXYuM0YAa/5T
 kkrISom9LJ+S0djw3W0KtBQk1MxrER3UFYlZrPyyL7M1a/FLRRrIQL1hmVaqlmUlYYGscywZ8zL
 vL4zGJwWVIipzzFLRKF1iYF5cxmClpL1WIODbHyc2MLzJV4uWq4abl6gG2j9ny+OolUd2wSTMZy
 7u5iO40Obptp7bKkVvkIJ9Spu/7sVGQARFggkHTvNe/GhcFsdcl9Z+qelLHdwYzTGT4ajuRxHu0
 +5iiREJojatmkWyYqFXrzbpk1Ep54ZKY+ejNbrWrYe3vNhIqKQ2d5/ar5EbBlSMA7JuprYeeyuU
 S8P2UyrScYUEin0Jr7GWOsF9JqFdAktw+0yBUiR1vslzIWU6XqsqBK/UhmRoP3eXH2oxUzeH7dr
 E0CN72ZrCqPH9k0Gz1H5M7eS
X-Received: by 2002:a05:600c:1e2a:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-48727ee9f5bmr122096135e9.18.1774718217723; 
 Sat, 28 Mar 2026 10:16:57 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b105sm332432465e9.1.2026.03.28.10.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:16:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 1/4] lib: uuid: add partition type GUID for extended bootloader
Date: Sat, 28 Mar 2026 18:15:14 +0100
Message-ID: <20260328171624.2377527-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
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
resources outside of the EFI System Partition.

Defining this GUID (bc13c2ff-59e6-4262-a352-b275fd6f7172) allows U-Boot
to correctly identify and label these partitions using the "xbootldr"
shorthand.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

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
index fb402df6f13e..afb21569c932 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -59,6 +59,9 @@
 #define PARTITION_U_BOOT_ENVIRONMENT \
 	EFI_GUID( 0x3de21764, 0x95bd, 0x54bd, \
 		0xa5, 0xc3, 0x4a, 0xbe, 0x78, 0x6f, 0x38, 0xa8)
+#define PARTITION_XBOOTLDR \
+	EFI_GUID( 0xbc13c2ff, 0x59e6, 0x4262, \
+		0xa3, 0x52, 0xb2, 0x75, 0xfd, 0x6f, 0x71, 0x72)
 
 /* Special ChromiumOS things */
 #define PARTITION_CROS_KERNEL \
diff --git a/lib/uuid.c b/lib/uuid.c
index 0a166320e077..cf5f8be48a32 100644
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

