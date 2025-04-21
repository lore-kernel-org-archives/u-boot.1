Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166BCC369D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4BB820E8;
	Mon, 21 Apr 2025 18:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vYdJO1d1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4CF481F0D; Mon, 21 Apr 2025 18:26:31 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B138197F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E20B40006
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252788;
 bh=JIdSCG7RxchTyd9kL2u4nrA99x9/0NYpBSGxxqP0QNQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=vYdJO1d1v7dxYdV/3UaeoF1R7IOCpw2BSPRHXY8LNL02jPbf4Px+uNG2H1vk5CkNo
 6e2mqoFJlmiEs/QZvjK62Bqy7pIlvFjcAma8wEJeWcrBEexedgmpTeds5d07Vz0Wq2
 kojfSKyCz1pY40miqUR6UAjGdNqJlv+3rGLrk2lncYHLD3ndsTa3tME3AWY3vJZxad
 m9ReES2+k2KNNiDunExiexXeSon6n8EAEaFUNpD2gfhVSj7pP1xCwiNzvgdRbxvhAB
 CrMCnjn1zESbmJm6bF4rHb32SSbxTUcv/HwNMztYDoxTMZ/Bf8r26+lk2QbVdSYBh/
 dTMXThkfo1xpw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1115463f8f.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252787; x=1745857587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIdSCG7RxchTyd9kL2u4nrA99x9/0NYpBSGxxqP0QNQ=;
 b=At+Cu56MDAI/0nC7FQlGsUWuq8rnE4wMxQV6639AlH1BJgMW66FnNbDWEs+GHRzqWc
 AG+XVqrEvoUityP1dpHqlsQGPrzsJ8C6HF13uSIzbg/RVH7ktQIoMEy+T4eynGU6MWov
 zRk4FaMdAFy+N0EydymCmmU8ZEjdcZFdD5zjgUiLnZ8g+3Wer8SF+bTYrpR5IdWHKtC1
 xW7CttIFQgrUy0NdUlgiL/rmjYq1+pf0etDjqqNcqKQSXew7WybwTQ5KzwpJ/703YJBh
 K33QtY7vDMT9V2z5msvayZkNSsdFqpt6X0UeBMHp5o810tDDpp/qAoH26yjXRHEOkjoq
 cETA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZcr3Rq6K8/i8gPCrQAmLF59V9WKVM9YY3n3WoZozW3LuUsRkNKwoohEwCf6Pdodcfth1pvbg=@lists.denx.de
X-Gm-Message-State: AOJu0YzTBG4fF/ZNd27cph0YBVmJeNtff7DWkAGLD2XK5pl4Ax5a5jHs
 ZKsLSWADHa0YiGLcl01GQOwPKbwfa4iGMVlfXPU8ivznLaMR/cVtLcQlxYr6HqB2oFaZdwel52Q
 ZwWvqvUxAqbY7bAJ6TpFulRxyD1a+8tFDR6aIEsb9b0QEYK+8s+5HIBRi+pGiFqdp+BM=
X-Gm-Gg: ASbGncsAHGcUud7gqoaqiDW9321o3KfgtwC2G4V1/zddkIj4dazEjWckR5aj7s1VskW
 UzviFUswHEHio4Fngfh5hfTWAGtc1NJg4hQjkuh1mF9+nHWSf8vWjFw8sjjc0uDW40i5dddv0Zv
 2vVUhs2JHn6LGWv1FErzhBEfIfXV4bIF/olD0eVX6I960yUAHBPu5/c2/L2e/3YlPkd+/sH8Xm+
 6pBPOBZ3Ol61qYjaXtwdfStWiOnkHO40ljmWvihppe6O9TXPPTzme79etI/Gu/bas0xJhPsHdM8
 sf7Ukf2MpkiVFMVgasNslRzCpa1bZ8XFSFMdLn1auUgtfbV2x3Sa8vGzdgdo8U2b/bVLS61co/U
 3PUvEUvwAZ+DPqg==
X-Received: by 2002:a05:6000:1788:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-39efbad50a9mr9783293f8f.39.1745252787618; 
 Mon, 21 Apr 2025 09:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrQDZ+D80ydgVSCpsEdH29hcp4EUaOzaTO2P/bE1ijUDMguuEhJ1JYF5NMoBgrXXKENdgwaw==
X-Received: by 2002:a05:6000:1788:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-39efbad50a9mr9783275f8f.39.1745252787239; 
 Mon, 21 Apr 2025 09:26:27 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:26 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 8/8] board/emulation/qemu-arm: enable EFI boot manager
Date: Mon, 21 Apr 2025 18:25:55 +0200
Message-ID: <20250421162555.1200687-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

Add EFI boot manager to boot targets.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-arm/qemu-arm.env   | 2 +-
 board/emulation/qemu-sbsa/qemu-sbsa.env | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.env b/board/emulation/qemu-arm/qemu-arm.env
index fb4adef281e..01d363baf2c 100644
--- a/board/emulation/qemu-arm/qemu-arm.env
+++ b/board/emulation/qemu-arm/qemu-arm.env
@@ -12,4 +12,4 @@ scriptaddr=0x40200000
 pxefile_addr_r=0x40300000
 kernel_addr_r=0x40400000
 ramdisk_addr_r=0x44000000
-boot_targets=qfw usb scsi virtio nvme dhcp
+boot_targets=qfw usb scsi virtio nvme efimgr dhcp
diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.env b/board/emulation/qemu-sbsa/qemu-sbsa.env
index 88fdb0ec1c5..010c6172bdd 100644
--- a/board/emulation/qemu-sbsa/qemu-sbsa.env
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.env
@@ -11,4 +11,4 @@ scriptaddr=0x100000300000
 pxefile_addr_r=0x10000400000
 kernel_addr_r=0x10000200000
 ramdisk_addr_r=0x10001000000
-boot_targets=qfw usb scsi virtio nvme dhcp
+boot_targets=qfw usb scsi virtio nvme efimgr dhcp
-- 
2.48.1

