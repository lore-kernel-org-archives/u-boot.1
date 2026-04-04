Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521C2E88D9F
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CE983CD3;
	Sat,  4 Apr 2026 17:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Mdyvg/Gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2790840B0; Sat,  4 Apr 2026 17:26:58 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C46E83C14
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1583261f8f.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316415; x=1775921215;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfM9pZ7vPeeh5Styn60By8lkkp5tu15hnsn5aEHMUx8=;
 b=Mdyvg/GpKu0oSfjdS+UmE1/Xe39GJs2ylHo9gtCKIC+O3xaIcguNHHhwKoFr1nmoTN
 ot27BGFWthQZxVJ17jMPKy0uUd+lqnaJbxZP/cvEI85A+LAeCrJr8yBpT/GfNMcoADuy
 pazPSSprMQq7I9+cEdACP2SYIPEXPVgmLbgbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316415; x=1775921215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfM9pZ7vPeeh5Styn60By8lkkp5tu15hnsn5aEHMUx8=;
 b=ULOWEei+eJhtxdtxM27bizPjLiMhimpU/OTrfisu+ZdewfqeiJ1tVaouwYONiVP7g6
 uEIrO4kwSxavyRLHGxXoGXkkafzLFCWsLAPoBF2+JVgc6hYsju4exaVv0yz2Wpwk4/TT
 pKCJ1B0ecDH/xQlcH01NvuJp/SbSnpUPcxu/7xUVJZTpF97GVfy61mswdUnfo3aKgkLS
 mqAVB7fqByZF64iuzrw6gKsCFzZlgjAEYKCMhPnH60ZXRk8M0eTYNkQZrIp9SW82TUOn
 gwgjbvTHfY/P9LCVunDcvHBikl0prxw9j5ZZWKBwaKqHuBNkkBXsh8qYViHksqfzfcA9
 bgBg==
X-Gm-Message-State: AOJu0YweAMLxY2asPWAJAMiDKhNcVOr+NExl6Y6ob0tuTHwcWzykjcZk
 d5s3WRQcoK/urYFR0Ys+/Hz12awB3iBVvmAQ9RSMSMRtEzhWriZeDF7EuS1SJI07De1u4wIuES+
 VNmHY
X-Gm-Gg: AeBDievVof+M7azg3T7n/gB13NPzQhDYMgCAWyuJeUdGCU4yU08h/u/94lca1hh+iPH
 +tJ5tyN8ZHwzbgY2SaWYWdIkre2Mc+vb2ytaOvh0MBnKl6Qf0PVKRdiDHsPQ2JByYH5nOVDmTbf
 g7dDerY9BZqukMcjtsfVVmqtt2YWip0us4NdSOM5vvklvt7j6CsSH8Cd+53sFfIS3SjQmqQo8Bo
 Ryv7Nqg6dNBFQdw+FreMTsgxW/LGCeqyEkdvubDYsUQXdav9nG7SVfqfKiQxM/mFeNbNkWH5TCl
 itb3WcqsMC80C4eZWGdsIffBFisxjoTCzmlyfdjtfoMD5Y3EZ4oNXlsDRNfXgCHzYF2fQnvhsJz
 hOwSmRGHZglarxzlX2BcMQR7tGHiRITK24CIjnnKLdG5piYs6NTKqr3hodwhutZy/omu7j7SpAp
 Tn4q40p1PbijAzzW9xs0bBVzxm9Y6rza8pDnoo7OPZ/B8YtJMmO/4pQ2JJmg48JUA5y+/fn7we2
 1tcEIn5vRuTBgaUs5SfalwzRNhbSk+KYKQbw2H5+KHo6z7ylsFHNHj6l+p04K5eEoslooX1DjzA
 /D+yIU9AD+TgXAEu1CjphTui
X-Received: by 2002:a05:6000:2885:b0:43b:3cdc:941f with SMTP id
 ffacd0b85a97d-43d292a4b47mr10019440f8f.17.1775316414652; 
 Sat, 04 Apr 2026 08:26:54 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:26:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 1/7] lib: uuid: add partition type GUID for extended
 bootloader
Date: Sat,  4 Apr 2026 17:23:28 +0200
Message-ID: <20260404152640.3297713-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

