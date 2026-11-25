Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A7606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0lwDREmt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Re+yJL2h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3DB480D0B;
	Wed, 25 Nov 2026 12:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9bBRVxdRk2hT; Wed, 25 Nov 2026 12:20:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD51680DA5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795609258;
	b=VTI1XqlXhfCdcjX5IZXu6ogNQIXCLCXIM0JqFnoiWdHlmYL40aS2or3ob3ql3kaxgX8E
	 4tHqooGW7JNhn25/RYNAQbcXGyBXP4f8sq8gCsPXUq5DyXBwEbIRjgmlHPwN6WTITDK7W
	 7Tf8WiQ03FC+SAwCSjNqUBPnM6xF5zW6GBzzRDNPOgP9SqtRIkq1/Uft7Coq9BPPTayOW
	 tj0FWPIUaEeTDh42KhguGf/JKJDuydVmOX8B9zuTeTORj3vbo4AQ/iYYdVTPxp28a5Asf
	 xGUpoxZQwWAsxQi11HgXgj+8RUh/3k7UCsWEPp+zXw24ER9W7/B+WoeplOa+7bgz9Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795609258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aZb+qpPr4GPdLR13IyO+x9tt2yQTjBFYko9/1WNLzSQ=;
	b=bpjpawZ5bqHTFu7dkpN4oVmRJIQ0g/kUuKvYQWvdO4p488NKh7pfk1iM+VVl+AYOxGML
	 MhuerhTUR6crNWGpOEaQxHSYlZiAWzArdJsLuZfiY10v7YQ1YNoObkPg2JfZn3RwOOAxy
	 m5+BvdfYrrw3xomfmWrTYleF9kIxqTNz+U77cJ4do27KZfo0B/VchPW7gJQPJrvd2re/I
	 qZnWc6uUPW3DZyt8pMWsjPVPQVOL2S5/yQQhX6pFYeQFDLbFRZlhfW27jfbdmaUj/cOXB
	 R6aevzNY0slsc6NIecC4G02xBHDXcOnU4+/2EAoi8OGBKmewAYLr1q/5d/oJzBbd97w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795609257;
	bh=aZb+qpPr4GPdLR13IyO+x9tt2yQTjBFYko9/1WNLzSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0lwDREmt2G5d0xGsuVriNJ7I6v417ZltGYOu0Ua0FyVA5bkohtOHqUWIKtsJ42cc+
	 6A2+ieK5rZyBqTdx3jMYFbUgKmP0LxxS3NiHOOBXTUpugZZGxLa4mcOvE8HR1ajRDb
	 ZcstzKFeepDB+G7oOderuK3kDpXMIb6twzU1wZmh63nD+jfIK7QjdkYm21mv8fY2JB
	 B+OZ7GVMzBh8E+cqEDO8owl50fZdP/jQZDFidoyT5ZUNB4fdpplWvHq5kMucIZseao
	 vsixq5HwZPNpeBquHhTU5j/JkReePi8pkBeGmn16thJIjibC/l51od67RgG9Ka8OS+
	 tfUV1/mwBCDSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD51680DA5;
	Wed, 25 Nov 2026 12:20:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE79325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CED4240394
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2t3rl94cuuoX for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9200C401FE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::932"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Re+yJL2h
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9200C401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:55 +0000 (UTC)
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-9906a5410f5so5318022241.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795609254; x=1796214054;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZb+qpPr4GPdLR13IyO+x9tt2yQTjBFYko9/1WNLzSQ=;
 b=Re+yJL2hfhMQEu5z/0yzkJqoJlvisZSt2N0Q1y2JTZm/bVPwdeA4fugC0zP3jSm1BD
 MlLBS8qS+Y/WDR65G91seh1tTblSctKubTqbpKmQSPw+tMLkL4qVeKHJGYkh5KGsdJRt
 00AsZufFhMR6rrEkE6RtIo4VSFsnCrK5+Tuev8DmisPCxfEsY6OjPMMWG67ZmR0FiNGE
 eUaqQkDYKgYHm/NE4uieaD7Yxr2nEcm4QVLWc14hxaCmDSXvX8HwIUbVYAWmF8ezChh5
 fak4gdA5WiO3cn7K9GMCiljvBCQwrQ7C6Ij+F42OeC32vi1PlxInbSecb1sAKDHb349L
 OTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795609254; x=1796214054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aZb+qpPr4GPdLR13IyO+x9tt2yQTjBFYko9/1WNLzSQ=;
 b=dXpmR8gP7wsfelgeVurQbG+7J7z0AsMgtOHX3T2QvfIWO02HMUWMlMo/GYyRn1DGVs
 WMMobXXQK/42YYFCAQNkJDN8x88d+6hiykwNHDbzrnm5R2GtIO3ICeQlpBN4+MIJrKGk
 K33DxTrKVWaSgyoz+saPXbj5D5/apS9kP6tteWv4qLil4ZZtZ92VDKG3xaKJf+Y5Crtq
 BLHeMSL00vJbDnaX/GsaPttbqEksKN857UXmqqLVKqM+0mJ14fgerPfkdc8QsGghbdZu
 G0v10OJqLWINGTw3vUcZvUfdt2zSt3B6jS7lQqFC5cgJeu4UC9oA4GkNAF2r+BbAp7/o
 2DjQ==
X-Gm-Message-State: APuU4Z9nwj/AjRN3IhxCVWnPMrfWN2vEaCNBReHcIN0G5UeNa2Q6CKHL
 jRZINF1vbPccPREZZf6MvrJMIx0n3/ZJEvsotqaenGwdASM4YXrv9ncU
X-Gm-Gg: AZFdTZdOgH11mzBbY3uiUtJZ0/gO3lke9TPq+2ZU3KBBtz8XC1RHNxGOTQTz9FVvP5q
 RsTNaE85lOZbPnFbBKFmVqXInGY3NOuTk9qJ+CHp4al1QCOM7yUMGzxRSaE8RGpW/TgbzYRuex1
 3cR7eXXKxlRTrkmRtZjgszhKmoSKzx3VkOeDe/yfYc0b+NiByxBfLotivDNIK1Xl3C6c6tBhdtL
 xe/QwVII2FRstOQ5F4MfgBEYe2BdRrAL0CfYKn5pUQrJ01KabF7556Hkciw1Z3tGgGrpsxSsU3h
 5iwtJ+3Btyco/r+NN6veGvYSCvSyYM0lDZ1xoggxeO0IwQSuNsizDJ34xSwLKJOLOc7c1YEVdbX
 hhl6A/NuKB7Ar/8r+w6WD5w7UWt4ieikyHu4DA+ao/nafOWUGTiTeRgcZJp+pb+XnRCuWiAU/J+
 nn89vQomBXL1VQqJA/QG6NMRfRdrr9V6QU5r8AWrGjnJRv3tk5bKDlV6wjqg6WxpQBtH+W1b45Y
 4MV0ZucJUtg38q77Xff0WFEiMJD/N95Su0LTXtTZJzskk4QEQvAcyq6Z+Wsh48xmthv7XPEeoNF
 +/DUsv7QpjdxfF4BdO02HheCs3oAc5WrZr5hlRCeBhNsGxdo6VtJQ3mDUl5HWBDAaqA=
X-Received: by 2002:a05:6102:3ca5:b0:7b1:3ecd:3d8d with SMTP id
 ada2fe7eead31-7d6db98950emr6868993137.7.1795609254239; 
 Wed, 25 Nov 2026 04:20:54 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec7cb5sm18636534241.2.2026.11.25.04.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:20:53 -0800 (PST)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Wed, 25 Nov 2026 09:20:29 -0300
Subject: [PATCH v3 2/3] board: sophgo: Add support for Milk-V Duo S
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-upstream-v1-milk-duo-s-v3-2-9ed94b63cbbe@gmail.com>
References: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
In-Reply-To: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the Milk-V Duo S, a development board based on the
Sophgo SG2000 SoC with 512 MiB of RAM.

The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
IP blocks, including the CPU core, so the existing CV1800B support can
be reused.

Add a separate board directory, target and defconfig for the Duo S,
based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
common Milk-V Duo board code. The defconfig uses the upstream devicetree
via OF_UPSTREAM.

Link: https://milkv.io/docs/duo/getting-started/duos
Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Acked-by: Hiago De Franco <hfranco@baylibre.com>
Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 arch/riscv/Kconfig                       |  4 +++
 board/sophgo/milkv_duo_s/Kconfig         | 30 ++++++++++++++++++++++
 board/sophgo/milkv_duo_s/MAINTAINERS     |  7 ++++++
 board/sophgo/milkv_duo_s/Makefile        |  6 +++++
 board/sophgo/milkv_duo_s/milkv_duo_s.env |  8 ++++++
 configs/milkv_duo_s_defconfig            | 43 ++++++++++++++++++++++++++++++++
 include/configs/milkv_duo_s.h            | 12 +++++++++
 7 files changed, 110 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a0..df10354e9aef 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,9 @@ config TARGET_MILKV_DUO
 config TARGET_MILKV_DUO_256M
 	bool "Support Milk-V Duo 256M Board"
 
+config TARGET_MILKV_DUO_S
+	bool "Support Milk-V Duo S Board"
+
 config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
@@ -125,6 +128,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/milkv_duo_256m/Kconfig"
+source "board/sophgo/milkv_duo_s/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
 source "board/spacemit/k1/Kconfig"
 source "board/spacemit/k3/Kconfig"
diff --git a/board/sophgo/milkv_duo_s/Kconfig b/board/sophgo/milkv_duo_s/Kconfig
new file mode 100644
index 000000000000..02a34a927a22
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Kconfig
@@ -0,0 +1,30 @@
+if TARGET_MILKV_DUO_S
+
+config SYS_BOARD
+	default "milkv_duo_s"
+
+config SYS_VENDOR
+	default "sophgo"
+
+config SYS_CPU
+	default "cv1800b"
+
+config SYS_CONFIG_NAME
+	default "milkv_duo_s"
+
+# The vendor FSBL expects a 32-byte loader header in front of u-boot.bin and
+# loads the result at 0x80200000, so the U-Boot code runs 0x20 bytes above that.
+config TEXT_BASE
+	default 0x80200020
+
+config ENV_SIZE
+	default 0x20000
+
+config ENV_SECT_SIZE
+	default 0x40000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SOPHGO_CV1800B
+
+endif
diff --git a/board/sophgo/milkv_duo_s/MAINTAINERS b/board/sophgo/milkv_duo_s/MAINTAINERS
new file mode 100644
index 000000000000..435d4827fdea
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/MAINTAINERS
@@ -0,0 +1,7 @@
+Milk-V Duo S
+M:	Andrei Lalaev <andrey.lalaev@gmail.com>
+M:	Hiago De Franco <hfranco@baylibre.com>
+S:	Maintained
+F:	board/sophgo/milkv_duo_s/
+F:	configs/milkv_duo_s_defconfig
+F:	include/configs/milkv_duo_s.h
diff --git a/board/sophgo/milkv_duo_s/Makefile b/board/sophgo/milkv_duo_s/Makefile
new file mode 100644
index 000000000000..a1b6aaee1489
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+
+obj-y += ../milkv_duo/board.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo_s/milkv_duo_s.env b/board/sophgo/milkv_duo_s/milkv_duo_s.env
new file mode 100644
index 000000000000..4c9f53d08118
--- /dev/null
+++ b/board/sophgo/milkv_duo_s/milkv_duo_s.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x84000000
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+pxefile_addr_r=0x84300000
+ramdisk_addr_r=0x84400000
+scriptaddr=0x84200000
diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
new file mode 100644
index 000000000000..f08841361f9e
--- /dev/null
+++ b/configs/milkv_duo_s_defconfig
@@ -0,0 +1,43 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_IDENT_STRING=" milkv_duo_s"
+CONFIG_TARGET_MILKV_DUO_S=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_SD_BOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_PROMPT="milkv_duo_s# "
+# CONFIG_CMD_BOOTDEV is not set
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_MII is not set
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
diff --git a/include/configs/milkv_duo_s.h b/include/configs/milkv_duo_s.h
new file mode 100644
index 000000000000..f60aa23fc181
--- /dev/null
+++ b/include/configs/milkv_duo_s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif /* __CONFIG_H */

-- 
2.53.0

