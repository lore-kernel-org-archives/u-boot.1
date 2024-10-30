Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04971D5CCA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3409A88FAB;
	Wed, 30 Oct 2024 14:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Qi0Hxcl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62A588C05; Wed, 30 Oct 2024 14:11:55 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22F988FCB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so5380895f8f.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1730293913; x=1730898713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ajF6Jt3jTFuJpKEsoLkcRLVg8AFGm9gpml1V2f2SrM=;
 b=Qi0Hxcl9wvd+mdBKNF0kNYwOBI6wS2V7IqtA1Rm3Uem0+hGhzO+l6Bk8xf3Rp4a2vD
 LS/Odwr4/KNwli5lFDrtihfN1dR54lNcoeuW4IPaPo6oUbgBJGTQkhGK/6tSmwDrguUV
 y5cg9MVVFienmGGXOn3SCy9vxIOjXOsvI6cC41aDi0hacORdfxSZ4dgnT2W5bAjbOqe9
 D76wodWgo/ZZEZ14YEC3ryiSRZgCnWvtUGVW2PDanPPYnNmrYp2D26D9E6KLpXRcYTb2
 SiXPPCVH9xv+K0rUTeec5gL0ukifBMf3mdEu/uWtOIYtGOZxefTV+SGaPhp3bCvkP8Ox
 HhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730293913; x=1730898713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ajF6Jt3jTFuJpKEsoLkcRLVg8AFGm9gpml1V2f2SrM=;
 b=WQKG+k72TxeliGbDl9KzRc0/9GRji3U8jGHtU5G1ZY8nFTSp78hB/RPxtiUxVoF9PF
 8Xm+7taWIpu2UWzAum3i/IbbzA/rMuaZjKYHCO/+5XKX2Y03ftG3jpIaYa6KajCvUdNw
 DhhMWWu53HdjQDhFo63y6gwGQ4cI8zYX16sqcQF9DBwe7iOAcnoFMOzN7sdNAekQDbe0
 GHgP0RcrBoF8C+Rwgp01XzPRWO1vwuxnjGxUcPLKpSDhZZliG3dAhqv5abUlux9f+0s2
 wHV39v0vQpxZf6de7ZN0d1OzbqehoWz+55gpCmLFcWkmkM8yyiDUr56vDynUR0WByOXN
 3HUA==
X-Gm-Message-State: AOJu0YxtiyHXvhDKfikHsJ5qJCeDMtw6b55FCIKVGxt6PIwkCsuNrIAm
 DTSzfnhnq3wUZS1b6OWjGNaw0mvLMa7DaXQ+1gN+lJmE/x4sQTxfW0jQQgGZbgfksISKzVq4rRB
 T
X-Google-Smtp-Source: AGHT+IFTfxmiNo49/qmx9mjKmS7Vcr3AxLi9NUrLWSTiyUAAeUkKaGjv7OgmbScTwQMg9aw611zw2A==
X-Received: by 2002:a5d:4106:0:b0:37d:612c:5e43 with SMTP id
 ffacd0b85a97d-3806101335amr14821144f8f.0.1730293912985; 
 Wed, 30 Oct 2024 06:11:52 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b1c354sm15323257f8f.18.2024.10.30.06.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 06:11:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] acpi_table: Fix coverity defect in acpi_write_spcr
Date: Wed, 30 Oct 2024 14:11:46 +0100
Message-ID: <20241030131149.3005320-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
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

Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
Cast serial_info.reg_offset to u64 to prevent an integer overflow when
shifted too many bits to the left. Currently this never happens as the
shift is supposed to be less than 4.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 lib/acpi/acpi_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index 6473d95c10..150f75027a 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -420,7 +420,7 @@ int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
 static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 {
 	struct serial_device_info serial_info = {0};
-	ulong serial_address, serial_offset;
+	u64 serial_address, serial_offset;
 	struct acpi_table_header *header;
 	struct acpi_spcr *spcr;
 	struct udevice *dev;
@@ -473,7 +473,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
 	}
 
 	serial_width = serial_info.reg_width * 8;
-	serial_offset = serial_info.reg_offset << serial_info.reg_shift;
+	serial_offset = ((u64)serial_info.reg_offset) << serial_info.reg_shift;
 	serial_address = serial_info.addr + serial_offset;
 
 	/* Encode register access size */
@@ -495,7 +495,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
 		break;
 	}
 
-	debug("UART type %u @ %lx\n", spcr->interface_type, serial_address);
+	debug("UART type %u @ %llx\n", spcr->interface_type, serial_address);
 
 	/* Fill GAS */
 	spcr->serial_port.space_id = space_id;
-- 
2.46.2

