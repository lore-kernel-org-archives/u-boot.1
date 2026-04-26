Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9520FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F018840ED;
	Sun, 26 Apr 2026 17:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZDHB1tiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C028407E; Sun, 26 Apr 2026 17:36:25 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C2683FDB
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso93890225e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217782; x=1777822582;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=ZDHB1tiNfMywSsgbzNgT0wsq6MWqOufeXoatMawEAeNynRZYXydnUsCcvXqa+itAPl
 JA00jNJzvyhqAlHbA+FnYBWBHNQlhIVdIqUgdx93K9woVa4DKKv76C8Iuf39SmdbslYX
 9vfh8tb5v30NguMebEXtMa7RfRnyD69U0b3p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217782; x=1777822582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=pBNI11tn56is6fpOVjABWuchwE3VTmAGRnkLxtqp0yvilHZbk4KUhLdvk4LyfH0/eJ
 cXlFSUm4irS9zhaS6mKHUynIbGG3f6v5t8dR6sCl9yvuC+VHM6lyxUxH34WhWxo6S79y
 Yi5b8elbKVAZSnerrUxQP6+OEeSPNIC5Dr5hWhS8ga6I0E8j9fD6OaXLl4lh+tDf9Cek
 WGry0lB9r4MGiXHBjRoEA2vDHW6/6Qtj/rEyf0ys2Js1y9jqA8HSLMXhvWjPPZSpzz1Y
 PdS7sdvvb2G186IBr5R42fQdvu3EE2Y7WMfJoGJQjyPKVNmxIIqxMNYtXilEoELTbsDl
 Zbrg==
X-Gm-Message-State: AOJu0YwMEjHE5ke3jnTzQowWX7KAESr+jH/Zrrx0IolBfS4CQZyekWEX
 eCQRtZBP/N/bCLFVZxoZjfDAU8B6M2+z8YqvvRckBczIHk0DA8XwOjrlffXgLyyCZaeavHaEHY6
 DRp5C
X-Gm-Gg: AeBDietU3rRdzQySW7Ok0U7U64W6gQuyyr4xg5rVhpVCpDWsJ5QKhBmuRTr5gypdeiT
 Ip9+OUlgHyuLi02AoSTJQ4p68Y2NveHgpKJx2QCMLTjoYSISS9Ol4gUOehcKz1SiXzLaRVouMZe
 soln7BoB2/vB5HhC4xbc4BJGxqEV8DCjaYbStp0wy2EesxfzauhxL4VhUtFPKhKYQG1NKVaKv1S
 fEoG/zEU6IwfOh+ksZhC1u2ZC+xyJJuLtceUaetbS2L3J2L4lpLc8PE3fu470snhDzWVelfftP6
 nYhD+yuX3IHkc1XFGzvmNE/oAVI4+7hhTerSlOlOYCtuSfWRTwxlzYoGjGunCexeqL9vkcrf2s5
 co3Csaqpo/tJz27S70O4EjP2flKBsOPTbsRhNZ/SVswa4atmshpQ38YHYPOKVY0MXOykkcyUEkH
 rpCzLvSIhXy0nk4DGZePDAOZwc+3ZwBgNMhvDsKN6i0SzDyigBOSYbsAkZtA1ftvNX7BDZ2785T
 LxgX/4x8Q5zsMXsdT5GWaxdm8QR3tvBRnNEew316DCkwvarJ49HtGA3oenGIBeVINH2Xi542Y9b
 Ei7bIBK4LfTs74hjLt4Q50lMa2D6OSTcurKfJjAJ
X-Received: by 2002:a05:600c:19d3:b0:48a:55ec:c007 with SMTP id
 5b1f17b1804b1-48a55ecc113mr320987225e9.15.1777217782390; 
 Sun, 26 Apr 2026 08:36:22 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:21 -0700 (PDT)
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
Subject: [PATCH v5 1/8] lib: uuid: add partition type GUID for extended
 bootloader
Date: Sun, 26 Apr 2026 17:35:26 +0200
Message-ID: <20260426153617.2039651-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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

