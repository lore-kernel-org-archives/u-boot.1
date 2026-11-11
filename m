Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE90606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kc/6L2za;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NtzUEYAL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F746408D2;
	Wed, 11 Nov 2026 09:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LzTsWEl_LrEQ; Wed, 11 Nov 2026 09:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6710E40818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794388658;
	b=pux57+rL4OBQo2PaD1StT2o+2rSZ2n6cJXsQC12VlzNk8KIu1SaX0cMU/FcRTa4P4OJS
	 TamYuB/M/Os68/0XKpK7yeRafQScpThFCcAHdgh85vqk6JMnDSYQ+8IYxgRpsQJwXRzDO
	 pdrfZEulB0nNhzGO7BRp0SRIWGETa0KVfsfq+nHhYxbILNQ8CVSqaK1VPOKy14kUDBku8
	 PLzpdZOtbHz+f5HJjlIb5QRpGoEzROxJ8Nh8HW5BHWPF4Tq6zcpLlxzxTF5yNuI96XfG0
	 db6AFqrzEpwEFaToORPKtAgfEwnb6QTQeygj5qemyD2QCGTNtZP3OvvIDn5v2/uRsDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z350+9sZ1DRZA7AXIZqZSjVhYO26jkM+56bhrA7LoQs=;
	b=RiWIoh67kb1F8lMAb1RlsN7VISuLpgYQh1q8Ryq6y9u5twHDkEJv+g4oCDy9obsfhG7r
	 K7XjZdKWZywue8VNxzSfPmf/CQ5kTWBVrKBV2Bf6nkIkm9tlT5YiCwtTxGvX3Hb9V+se8
	 Q2DZxm8QFTL/B2eQQLSewGYgCiRcPW4t27/BNCn1h+LyIzO5hL14gu4KxjFo+rE2RM4HX
	 +xvmPqRpTZIDacnQV2EshdhEb1V6H1P3/tJWL6q7DEJYRPMJU1SaoI4ByQCU0+I6jjV5/
	 3qrv7l9fyQ9YcoUhl//bljrz7+3lfkFyOAC1QVRLyyjfF9hoiAnvCWqmAL1CQFrisnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794388658;
	bh=z350+9sZ1DRZA7AXIZqZSjVhYO26jkM+56bhrA7LoQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kc/6L2zaNNu1WNmCAxroEMHNbu2VhBW5xct7Rww8sRWfadckqV8vtq4vtPDIJVxau
	 DmUyHHKf8SIYfIhcmA9uLqnymcGqT4l1x8ErND4kjj/01A4ZW5g1HmmsElswh64p9a
	 nHaK83O1yVlysGgFpFP3DdeAYS/JVOsOh9D8KuBmy9uQ4EH+7scDzD7cj2npgxlvqj
	 K5HYQBsSMW80mm9Fb0Gqp52SJLXUmtadgmbjZpDWjblNnA4+jMUv7kSb7pOdEiHFkD
	 5SSL3/x7mGYiuKwTZgJQbHnBU9phSR3iOItWxtIqP9fuNuhYFzAcJFOsdvEed+5Is1
	 Oo9KAAW0CMaVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6710E40818;
	Wed, 11 Nov 2026 09:17:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6890117CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58B5E8119F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bmbazm-U0e1D for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D9CB811A6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NtzUEYAL
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D9CB811A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:17:35 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20311045e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388653; x=1794993453;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z350+9sZ1DRZA7AXIZqZSjVhYO26jkM+56bhrA7LoQs=;
 b=NtzUEYALJM7yw/61AvwSA8uLYSpela0MIsWcbZ7m0dLJu3Y9EZUnZwV/VdE2hr6CCw
 RGnAltZWtAmA+UEsRo/s2j17rF8gi4Te9x6ooV0iwBUlNt+UOcXzyla77s3GW9rgau4d
 Lwi4GbCdiAj2pFZ9wqxUOtYAsdZ/NPTALEyUHb5I30gCW+OUjzOf1n8GHSI+NhLHSkG3
 3AZ+miFZz5diuPa+AIbhw4fJ+LMUlaaYcCDMwPP0RFe/PU94oxs/TpNUjfPp6cmnv9AN
 QIMC0e5WrytI2ib5xFD+jgB7Zv3TKqtDzNDhSE3lQyNkXonA/JqEnuc9mLBRUTuuqWnj
 CYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388653; x=1794993453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z350+9sZ1DRZA7AXIZqZSjVhYO26jkM+56bhrA7LoQs=;
 b=0G2PjXOKARcYuio5iFzuwJwJw8Or6dEyIGhNe92tc2XvKMs/SX+r/HAINTFCTyTyLf
 wTp0eO1d+QX8oLgA0RBeUIPzX8TF7/RJytMV+PyCN2B9uB+1j9R77wtZySVfSjniUW7L
 /Wztmcxskwvq5kcSv2yi9ZRpSVxbIUbF1M0HODSjrWSjqHNCIB2P0l8g4KwaogcuC4YG
 27fWXaJPcvQxjCtd9oJnVgm2iknE+rg0z9C59Whprft67NSNpyrP035YyWwQk1+LLSP/
 APYyZzFvPpSbY5SOkBVcwWTF7V6A0mXZ2WZYaLVzZwfcfyaQa/enmNtUsAEyw7iW5lkq
 0waw==
X-Forwarded-Encrypted: i=1;
 AL+hErHYLvIjVSmmZT+lZ9z6hQ8euCsbU59tMmyvKfV9Yj3Jd1Y9ivzIDMIkkBfjdiZEWr5quk3YOyA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8vWGpg/eVzDlfgePoEmiPnaFH1WZFW58jytLwYPi8C+nycVlrR
 IDoUE0qpnM/doJjIG8LQY27+N3EccMPIxhbUGe7csGjeikh7iSdDwUhjyROe/Q==
X-Gm-Gg: AYBFou0XyHK50m7UCRE1BC9LPbggrte+fMhGQqOUexG5bLTD5rCbS9k/mcp9AErJPn8
 Ugq8GWn5eaJWg/Xyu31NNgUgftaUioXuV31Q1hBkzcFoeS4bRIrtBoO63VpHcBEF9qnSCa5l4YW
 rg0iXf4IqVWc9k5FUHFkbQqO77rk9/K1esgFq70V4doZ0OCz2QYf7G6ZCDbPrD4WJeXepKC/OU+
 4J/o2je1ZpiL3dQamkteyAMY9zNahqPx+VY+enncoUy9WVpJxlAyBHRSq6ZHPM0oaL6QS2Z89ed
 lAUpMkMIsKu1DkJgmr+8CuXrAzxl5GsBlCpd9Ws0b+o5M2+Dyg1qHa4zSgI3RRquE72lkfPVL4Z
 D+AAmQ7f/IHorqk7vuftgaDHFATXKUdlY1E2q6dxxHADIfEPFrqNQ0UV7suRjm7BKwQImdOA47d
 6nhG4LEev7cADk6iR3VMMCxzaJ+WxUutbjvrHWizMXoAhpxvnTIqmQ3FKGJixUrZZQmyRLEaEGl
 NRgNzaXPtgGr4RmfzIEl1f6qXgKj0MyDVVDNM8iogaqqzPDzgsl/tTgB4ZpU/oyN3pfxCZSe8uX
 T1eK1ITHAq/o+yDUR94bROcgDynz7sCxJ+SH01DTanuJhlDCs+rMVP8uNnVobY4BtFwkUgZ3iRC
 Ix3/FMd6tISHmr1cjAsONy3Lc39FkNX1RraPaKw1LZB+qGN5uMjEj7dT81fUyxNZ7+jP5RL8R17
 VwDYfJc9zoVcqP
X-Received: by 2002:a05:600c:3f0a:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4ba09379befmr29084115e9.5.1794388653127; 
 Wed, 11 Nov 2026 01:17:33 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10209735f8f.18.2026.11.11.01.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:17:32 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/1] Update maintainers and mailmap
Date: Wed, 11 Nov 2026 09:17:24 +0000
Message-ID: <20261111091728.3388905-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111091728.3388905-1-pbrobinson@gmail.com>
References: <20261111091728.3388905-1-pbrobinson@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon update the MAINTAINERS file
to reflect the current situation of various subsystems.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 .mailmap    |  3 ++-
 MAINTAINERS | 32 ++++++++++++++------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/.mailmap b/.mailmap
index dffeed3238d..5632778fbf3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -147,7 +147,8 @@ Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
 Shaohui Xie <Shaohui.Xie@freescale.com>
 Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
-Simon Glass <sjg@chromium.org> <simon.glass@canonical.com>
+Simon Glass <noreply@example.com> <simon.glass@canonical.com>
+Simon Glass <noreply@example.com> <sjg@chromium.org>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <siva.durga.paladugu@xilinx.com>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.com>
 Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fc6614e519..0ee3ef000a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -63,7 +63,7 @@ F:	net/9p/
 F:	test/py/tests/test_9p.py
 
 ACPI
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	board/emulation/configs/acpi.config
 F:	cmd/acpi.c
@@ -77,7 +77,7 @@ S:	Maintained
 F:	drivers/net/phy/airoha/
 
 ALIST
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	include/alist.h
 F:	lib/alist.c
@@ -820,7 +820,6 @@ S:	Maintained
 F:	drivers/spi/spi-aspeed-smc.c
 
 BINMAN
-M:	Simon Glass <sjg@chromium.org>
 M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	doc/develop/binman_tests.rst
@@ -836,7 +835,7 @@ F:	include/blkmap.h
 F:	test/dm/blkmap.c
 
 BOOTSTD
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	boot/bootdev*.c
 F:	boot/bootflow.c
@@ -870,7 +869,7 @@ F:	fs/btrfs/
 F:	include/btrfs.h
 
 BUILDMAN
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	tools/buildman/
 
@@ -901,7 +900,6 @@ F:	drivers/clk/
 F:	drivers/clk/imx/
 
 CPU
-M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 S:	Maintained
 F:	cmd/cpu.c
@@ -939,7 +937,7 @@ F:	include/linux/usb/ch9.h
 F:	include/linux/usb/gadget.h
 
 DRIVER MODEL
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	drivers/core/
@@ -947,7 +945,6 @@ F:	include/dm/
 F:	test/dm/
 
 EFI CLIENT
-M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
 W:	https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
@@ -1005,7 +1002,7 @@ F:	tools/env*
 F:	tools/mkenvimage.c
 
 ENVIRONMENT AS TEXT
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	doc/usage/environment.rst
 F:	scripts/env2string.awk
@@ -1020,7 +1017,7 @@ F:	include/erofs.h
 F:	test/py/tests/test_fs/test_erofs.py
 
 EVENTS
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	cmd/event.c
 F:	common/event.c
@@ -1065,7 +1062,7 @@ F:	include/fpga.h
 F:	test/dm/fpga.c
 
 FLATTENED DEVICE TREE
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
 F:	lib/fdtdec*
@@ -1169,7 +1166,7 @@ F:	doc/kwboot.1
 F:	tools/kwb*
 
 LOGGING
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	common/log*
@@ -1207,7 +1204,7 @@ S:	Maintained
 F:	lib/mbedtls/
 
 MEMBUF
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	include/membuf.h
@@ -1398,7 +1395,7 @@ F:	configs/o4-imx6ull-nano_defconfig
 F:	include/configs/o4-imx6ull-nano.h
 
 PATMAN
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	tools/patman/
 
@@ -1567,7 +1564,7 @@ F:	cmd/rockusb.c
 F:	doc/README.rockusb
 
 SANDBOX
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	arch/sandbox/
 F:	configs/sandbox*
@@ -1821,7 +1818,7 @@ F:	common/spl/spl_ufs.c
 F:	drivers/ufs/
 
 UPL
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
@@ -1870,7 +1867,7 @@ S:	Maintained
 F:	test/lib/uuid.c
 
 VBE
-M:	Simon Glass <sjg@chromium.org>
+M:	Orphan
 S:	Maintained
 F:	boot/vbe*
 F:	include/vbe.h
@@ -1900,7 +1897,6 @@ F:	drivers/watchdog/
 F:	include/watchdog*.h
 
 X86
-M:	Simon Glass <sjg@chromium.org>
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-x86.git
-- 
2.56.0

