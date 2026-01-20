Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15851D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C7883A8F;
	Tue, 20 Jan 2026 14:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jP4Fyq89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6B583AA0; Tue, 20 Jan 2026 14:36:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137F183A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768916207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fgCj3kIirxMMy9JiJTJFUP8W5q9DshUgVIWOJ2zmB08=;
 b=jP4Fyq89GAs+Co7vA1qFAACEdfuXyfhkFAllJ3I2O7fLCX6RtsBgHUn5lVJiIWFLZqduIj
 5SdmHCW2LI4FCr1jrKrKLi0jG3/9sWmq/UJMqDRBLiQdsQTkcFkGfitTlOucFCBfvthYW+
 llfT5Ubdlqgcr2MBImur5qWQBFiKENw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-zAiHF1g-OK2Ypf442_mp-g-1; Tue, 20 Jan 2026 08:36:46 -0500
X-MC-Unique: zAiHF1g-OK2Ypf442_mp-g-1
X-Mimecast-MFC-AGG-ID: zAiHF1g-OK2Ypf442_mp-g_1768916205
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4358fe2e7e1so553942f8f.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768916204; x=1769521004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgCj3kIirxMMy9JiJTJFUP8W5q9DshUgVIWOJ2zmB08=;
 b=Ayt3C8qhLp+SHsHBSWPOdCKn6VFaDuMnXh88HUpRq8NOC9gNYWTqF2PWOIa91Z77F7
 LadixWz8B1I1FseC7wIZ2ZDa3hpBjjf5MnnhEGyAjvKIpFyhB+jUT9kCZZOS15zQdnU/
 Z9d4q1JsZBlD5jRVu7AEuqwaUr1zas5chBHmezXHC6H8wxS4Cw2CyReGatwHG9sYmj05
 nFekZZEIoOHVFVOfy8ccmCzebB0LJzgU4laE+A9b45Fo5d+SUShchzTSKx9TKMWsBwtS
 yhz1Ix7YsgI1njTZx5BoKbdXLEXwFIo7d/jpYNiui8qk/3lW3E2ATfm7SMAgqt57BOjd
 DCXA==
X-Gm-Message-State: AOJu0YyImSt/qrTaibYQBQcSFV4WdaKs/0mFiWJj8AxUxGx1ymrTkVqQ
 AjKcRXDMVwudYFRD72H82NflVU8MMsx5Ph34jxP/+WD3JbYX/748cX/Esg3Go/Dh+ArmxncHnHm
 MGCIB2yE5+kaDz1YNOTCbP+gf4Nc8r6voFiEJj2a0nTBgoReTsUnGl0QM+8vZ4poYGJgQ4UCTaW
 dlnhY4MgVZJkZJXVo/skqa+f61hKsIF11XZIVqvQ==
X-Gm-Gg: AZuq6aIfczP7OyYZijBArMEp8Wdpc9X0cZVsTAEP529e6Phw/V33YxDpGKnCSC9VDko
 i+Fnrl3/ZEyGxVNrWyC2VzpkoR+nQrim/lAfcmb1wohnyyHpuIjjt3fFpQedmASrPJtsXy81zwm
 HmikzWSfN7HRQhFFedrFihhDkxFBYuk11/AExe0MDjkCt86grOT2o3NL8TRksaH4wUUehD5FBla
 Gxz7I7MqPyR+c6Q6JOKI73wBL/RnEp6GsW61iueX2WOUEZfC1nMvxo/TJE0zN6scRRvJ/B6ihsx
 uVOM+lmTmWGNp6fmvR4H2rtEA6yc19lC1TyjQd6qhrznP5vBnX+9mOhzahxooUrVFzpG0H4jSm4
 mZwDPQVbrF56apPdvEQfcO6YIla8Pw0WvQ7I=
X-Received: by 2002:a05:6000:2909:b0:431:54c:6f0 with SMTP id
 ffacd0b85a97d-4358fed1181mr3280949f8f.4.1768916204562; 
 Tue, 20 Jan 2026 05:36:44 -0800 (PST)
X-Received: by 2002:a05:6000:2909:b0:431:54c:6f0 with SMTP id
 ffacd0b85a97d-4358fed1181mr3280890f8f.4.1768916204047; 
 Tue, 20 Jan 2026 05:36:44 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb1fsm29551255f8f.35.2026.01.20.05.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:36:43 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 0/5] efi_loader: disk: Add EFI_PARTITION_INFO_PROTOCOL support
 for MBR
Date: Tue, 20 Jan 2026 14:36:09 +0100
Message-ID: <20260120133630.1695055-1-javierm@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W3PpstMQnoAIiqEdqiumZCL1-ezjGx9_nzeMKY921ng_1768916205
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This patch series extends the EFI_PARTITION_INFO_PROTOCOL implementation
to also support MBR partition tables schemes.

When EFI_PARTITION_INFO_PROTOCOL was implented, only GPT support was
added but this can cause compatibility issues with platforms whose boot
ROM only supports MBR. This series add support for MBR partition tables
to the protocol, making U-Boot compatible with systems that require a
legacy MBR table.

Patches #1 to #3 are preparatory changes to remove duplicated definitions
of data structures to store the MBR records.

Finally patch #4 adds the MBR support to the EFI_PARTITION_INFO_PROTOCOL
implementation and patch #5 enhances the protocol selftest, to check that
the partition record data is correctly filled.


Javier Martinez Canillas (5):
  disk: part_dos: Move header to the main include directory
  disk: part_dos: Align dos_partition_t with struct partition
  disk: part_efi: Remove redundant struct partition definition
  efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL to support MBR
  efi_selftest: Enhance MBR test for PARTITION_INFO_PROTOCOL

 disk/part_dos.c                              | 77 ++++++++++++--------
 disk/part_efi.c                              |  4 +-
 include/part.h                               | 14 ++++
 {disk => include}/part_dos.h                 |  6 +-
 include/part_efi.h                           | 19 +----
 lib/efi_loader/efi_disk.c                    |  9 ++-
 lib/efi_selftest/efi_selftest_block_device.c | 12 +++
 7 files changed, 86 insertions(+), 55 deletions(-)
 rename {disk => include}/part_dos.h (87%)

-- 
2.52.0

base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
branch: add-mbr-efi-part-info-proto

