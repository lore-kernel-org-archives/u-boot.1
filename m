Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA51C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E720980C45;
	Tue, 25 Aug 2026 17:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmrLtVkwAMmU; Tue, 25 Aug 2026 17:55:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787680543;
	bh=UQKpF+BXg6yPC2CegGMaWVtGpCIxOy82ZCtISGsndAk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H0o0a1g1eXdZjrwyIhKWmG9pjIJ8QxBY+safAFSoOdooEgZS3wfXDTBcEm041dbzK
	 qy3eflo5oDYN3Ft3t9Hsai3cqrF0glEI4WsBA09ooyINM/zs5yxzAMWWZpJ1wB1fmY
	 UwzlGyZXlanGW4A5Mb9P0F9m8tFZw2pEx3QM9V4qAhg5uK15DiOaUUtYMp1uMDNqyy
	 Plf93fyCzFI82yI9ugi4gQDivN0Ptv7yYD/8ZGMiqNVDuyd8Gm108+46HLmx/xfQlf
	 mV8Sm25X7eOZHMdbby5oVwr7EdTx7Ll1GyS4RihjH6m6FEFMDEMyZMv8+mHCAncc5f
	 l7eAgzE/zq9Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3DCE80C33;
	Tue, 25 Aug 2026 17:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF58E118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C181C40068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id va-j-pYsp7Qt for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:55:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=k4fwJ9Gx
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26F714004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:55:39 +0000 (UTC)
Received: from LT2ubnt (dynamic-176-006-060-003.176.6.pool.telefonica.de
 [176.6.60.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AFE323FC08; 
 Tue, 25 Aug 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787680536;
 bh=UQKpF+BXg6yPC2CegGMaWVtGpCIxOy82ZCtISGsndAk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=k4fwJ9GxV4/oAo+XAVaG5iLGOP8Rz34BM24ZfEB+4fZNQBnnDTM3D0XcmWt7BDBXP
 jHuswZZnuCLc/wFePlmr1BKNFHR7IttAJfGj6yYT+U2N8PL3rfKXwlSzhLime3hX2l
 t3H4mqOrrWrA8GqHugyjleAQ5AybVq3SL4VAQ+BOoJJIAlPXWX1cxYXDwQzPnb4P6Z
 FPYaq0fx+c5AJoglRuP9FQAcw91mUNjPl3duuGYUGmmTJ83tGYdmOMKllrr+whbgGK
 7jJLaYgppK5Kb1crsBUYtqs5JK6ITGhiRgpIQJYek/vV2JuaUdbxC3pw8YjTgQcAWu
 GBEBIOuIAZzhx3x0Q1RbuYoU7WtleohVPOTwtvz33OFhg+mmdz5cuX1SIKLE+rO1w+
 or2AIAOpUW0XMsuSeXJsQ+ck/rU5RoLP1BgKYw5Smev0urVtf+6sRRxzsXe6pT2JMW
 FqBlrY/rK8zIWtkMVOqqxZe7MHfL2V0MGiLYyvIgwpjXkzzc6wF0uCVpKYRvnum41L
 jNKfUD0nS0TYQ72rhGEVCux3ngAxiDPtAKH7Q3aqxGi/Pbq+rvn/evlx4PgUTTnz3v
 /Vlyc3DGP3axHHpeVyFKJHCTtMTKg7ZIQON0lpttQ0YnS5TZsXjsplJ/r2/GaQE/co
 F3ZT53ZiZ3VcPQtRypYf237w=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi: avoid video ghosting in EFI app
Date: Tue, 25 Aug 2026 19:55:31 +0200
Message-ID: <20260825175531.27478-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When running the EFI app via QEMU with EDK II using

  cp /usr/share/OVMF/OVMF_VARS_4M.fd .
  qemu-system-x86_64 -enable-kvm -m 2048 \
    -machine q35,smm=on \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd \
    -drive if=pflash,format=raw,file=OVMF_VARS_4M.fd \
    -hda disk

every character printed to the console by the U-Boot app appears twice.
See https://gist.github.com/xypron/7214e785c7d73104f8541bcac363a192 .

The reason is that environment variable stdout has serial,vidconsole as
value. This is defined by board/efi/efi-x86_app/efi-x86_app.env including
include/env/x86.env.

Provide a standalone efi-x86_app.env file which does not use vidconsole.

Don't copy any lines referring to hardware drivers like PCIe, USB,
i8042-kbd as direct hardware access would conflict with the EFI
firmware that was used to start the EFI app.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Update the commit message to explain why we must not reference
	any hardware except the one emulated via the EFI API.
---
 board/efi/efi-x86_app/efi-x86_app.env | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/board/efi/efi-x86_app/efi-x86_app.env b/board/efi/efi-x86_app/efi-x86_app.env
index 106836af1ff..d2858b9cb93 100644
--- a/board/efi/efi-x86_app/efi-x86_app.env
+++ b/board/efi/efi-x86_app/efi-x86_app.env
@@ -1,6 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
+
 /*
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <env/x86.env>
+netdev=eth0
+consoledev=ttyS0
+scriptaddr=0x7000000
+kernel_addr_r=0x1000000
+ramdisk_addr_r=0x4000000
+ramdiskfile=initramfs.gz
+
+/* common console settings */
+stdin=serial
+stdout=serial
+stderr=serial
-- 
2.53.0

