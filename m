Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC1C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5055040F62;
	Fri, 31 Jul 2026 08:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9CROgYdIeyw; Fri, 31 Jul 2026 08:57:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AE6140F5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785488254;
	bh=nPIknYz9Ok+iGSA0bv0tQbSeElbI2fDbOKfZntQ6Um0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=LeafxCsRIIhZ7ph2E5xksy3fHSkmTgaVcpRaRHa82Ek0WKTSq1fc5wXjNAR554zl0
	 W4CnagPF2xBQGjFxEvxmIWoTlnzPnJWBjWtvsCgWTSvdo66UhUcP2L1LvUtcZxO1Y4
	 wLc2DV5z8O0tCkAVhAQtn32HNnxj53JaENUVQyDVmLwX3uro2CcK12KEXN/ZCQiGBr
	 2sYJbHlOlijlP+2nlxkpWPPLqa0bPwMj0OrfUoKd82/oexfIUn9GalQ4FMLZLlzTrd
	 K4UyjgGPIUZv1WP71wI8JEm+upYAudKe3naPcyUlDJtCq+K2L8jMbBbiAJRbU8WooW
	 lZPWjHHOeepUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AE6140F5C;
	Fri, 31 Jul 2026 08:57:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42C8026C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 292FE6081B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:57:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqMvOtDARKLm for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:57:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ABBD7607C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABBD7607C0
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABBD7607C0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:57:31 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 591923FA35; 
 Fri, 31 Jul 2026 08:57:29 +0000 (UTC)
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi: avoid video ghosting in EFI app
Date: Fri, 31 Jul 2026 10:57:24 +0200
Message-ID: <20260731085724.75729-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785488249;
 bh=nPIknYz9Ok+iGSA0bv0tQbSeElbI2fDbOKfZntQ6Um0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=R5W5/cqcZLHJoAKypUPYDTAOvHmCHaDWrgg8pKWOhTA1IvLOh3vdOrdxO7yupUgOs
 yx9GE74vDAYGCEuHHVBBK5dCbJ3L1kDAz9EkkvSqfBHMWhXXJx/uoSPXpjyF9qzFqP
 FhdzsskTAhdkSyNF6dIp0DGtkKx1C6/3hlsK9MSFdB9nHuHqHtEe9I7ttSlwZEDjBy
 NXxc4pi2Ip1t4qCi7rx6Nyf6DPWSeQutkpedprVM93krgmSIMjtEG0YamiacELjRkH
 gTF6raVo6cooA8VVzOknHj1We5I+NHwfgf2R1WKemk1eOBETfV9JmSdVKVFhMqTg7n
 bP7asiqGFZaH2/MguKKo0JQqOF21ZZ5LseeJPgl91on1bzBQkVQgz4Boou0YVvsBmD
 si3DQjVEmMTPfpoIbDNrn6xArCSmdE+C5fgiFzAJR1kxQfQg1j53q8Bs8dyC7xZIHq
 ummJYof5TkF5y2sdbmNnBLKwSVELRhaU/P03mXIdb1cJjcT1ycT768GU3P0uvlu+/O
 M8Eh08uIGV+vqkHdn5+udLRZWPFwCLVDvVIWR724Ij30EId+8Fj8vi/z953H0/jYMu
 z4NJ5wujyunxQwI9r+4P88b4gVkTpFSwb9MT1L2tmnWzHNbXv41eIggf2TRkdlbBem
 TR1APeQ/fcIrv1FhPUK1GTlQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=R5W5/cqc
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When running the EFI app via QEMU with EDK II using

  cp /usr/share/OVMF/OVMF_VARS_4M.fd .
  qemu-system-x86_64 -enable-kvm -m 2048 \
    -machine q35,smm=on \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd \
    -drive if=pflash,format=raw,file=OVMF_VARS_4M.fd \
    -hda disk

every character printed to the console by the U-Boot app appears twice. See
https://gist.github.com/xypron/7214e785c7d73104f8541bcac363a192 .

The reason is that environment variable stdout has serial,vidconsole as
value. This is defined by board/efi/efi-x86_app/efi-x86_app.env including
include/env/x86.env.

Provide a proper efi-x86_app.env file which does not use vidconsole.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

