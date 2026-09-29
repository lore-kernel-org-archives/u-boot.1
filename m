Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22618CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD4C560819;
	Tue, 29 Sep 2026 20:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDfKnxpwf4zx; Tue, 29 Sep 2026 20:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02D6B60801
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713987;
	b=hs96Lu65sLDQfypTe+OaRfDm7lupt0TdzaJxzFGbgHSgnWvhkjW1w3roFTI7IYt4pdjk
	 3UmJA5DhD+Qjz4U4KIDqnoOvfakQi9TFPyUshFeKrm9N25NFE9ZDamQpFeT2l53W4UU5w
	 OvhDfuuu5j9Ps73D8q1VRHtLTLfiafzsSDxlIIzzlxZiG5RgGZV3Z407wicY9Q2LzWEPK
	 hF8vyuhQCWdxf7J1h/w03Ldug4YJmrWFPIKtK2lc4D+d9cvzWNCU+/tzivf/LTRyg5Yp8
	 0OeIaAfJxINmA08bWST0+LCgKHVEuCWAb38292pW2WYOpYjHhSTX6XYjBFag2kg9NfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
	b=NGSrVgsdfPP7QUPpgwym/4FM6X9k+q7er+U+Hrp0Ptg8mlKjx6h+Rg2ORx8bvcoHwNkv
	 paxANqT43zUoThiT+wO5fJJgqgQ1kMEBZ+Z99QT9ipuCINzTRgUuxOKUEqDhT4yy92IoY
	 /6/ku77zVSZzRIeQEwDjNGShgYu4eGktClU7YtSeL5OGzK1bZsFcb9O0gyB8z4smPMQLT
	 vlX6UNv2IMAE226K3HkQfcJrW9KyM7RkIVc2CeNAQD0ZDvHDz70b5BM6pd0HGCBSImHbn
	 EownpMRxgdAuoSS4XnSXCZT+dYDR0YaE2I2UDHuyvXqb4LMLsHtXilPHOcKOBWncUJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713987;
	bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZmvQo0few5uQi2qXC43zxgHICdLzEdy2jHMAWyr8fNoGJC/UhkcprKShUXmJmXUn
	 Q7ERvo6T06L/8YupHhXDz3wQzIcX0KGvKDzKgiDheTj+2Ee/x6/il6we0t601M1K0y
	 KUxg+81DvtbHK4kmW6XbljR7Ft3HssrqKvkZRpBtQkqqwIOtHXBUPIo3g9iDMq+Cw7
	 /WMLdBJUR1lXHt8rxk5DyUXWilCDHygyJaxUfJKE08LnMdC7B4MmB8ykuxYb2Ot5Nb
	 Qhg79C8IfhYSNDAOjf3aJiTYuqSK9dQQGP28GL8rq0csDAMppazfi4z9ChuIYau1Bq
	 TEx3FQlztv4PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02D6B60801;
	Tue, 29 Sep 2026 20:33:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB5CF2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C186780AE3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UU9b1BYK1hca for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9A64980C12
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705256;
 b=J5r9FJOy1BUCUkpiPPD+2VVlNyTn+I1aLy2BCVIc+6o1rS2jHYwlBvfD7UnM2uuKrvBR
 kB60ENf6QtJw/Kr8qVngqI7xQfzpQppvcSRzYgLon/5nVVEtIAkjwZEYh0ceWKyX4BhyC
 YZ/ik5xA5c92e/E/buNBC2fD8oAsNi2VmFPVMDNv/y62AEnsxOPWLce6wCk8QIBPKvmjE
 UjebGkNEeYqjWIdsu8jzPrZfVtVCVQ8tYUt43gXXcUgRiVILl4+nU2wZACZFutu68sRnD
 756c2tAx9XxqmxhGRitqVsotVdQoe0jkZowhE5+w9qoqsDmfqBB0xkC5kKaFowF2Tgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705256;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
 b=Qy1dvx0IOzTEv/YdLbqvdAAofsFxYEZQOox7M/A/X/gB+rVoSXjzN06lawcE/OjpCCPE
 YKleIouce20Z6YKntkhXNoQBO0zfn8giOhhh4fb9Ee8uBfcEJmiyKP3D0+AtwM3pB4Nb+
 NpsM9j/voIVwlDw7prvU1w1pHkscH6inLkdDU3LvC/gpHyHWVns7+/xAQHSQvXE9wuWSM
 0rSLn8/H34ymeh2yfRR+m7GtKwExSjNGh414u164n2vVq+sh+98uGPumEwyRGQPv9omCL
 bPbz3mtRUrGRp+yKJLQjPrbR7ltr2Ra0TYytTdDwOn5H1GHayxoz5C2H12SY5XhClTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=h6EPwiRn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::d;
 helo=mail-qk2-x0d.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=h6EPwiRn
Received: from mail-qk2-x0d.google.com (mail-qk2-x0d.google.com
 [IPv6:2607:f8b0:4864:34::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A64980C12
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:33 +0000 (UTC)
Received: by mail-qk2-x0d.google.com with SMTP id
 af79cd13be357-93bfa7b2093so506001285a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705252; x=1791310052;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
 b=h6EPwiRnSo1q3qNx7v6gG4jqca46lCrsvTfiIBUwZoWRFWNkybSV6as1H1taMMy7C0
 oL3x/uNDjjBFvzUaA4vJGV27a+v7CQrTmtvDMopsDnceThMX6p4OHDc1g7d3q5l2XcGl
 VBzlS4p2xmy/AaarzVS3PYxaQAVe6gL/RGkw9vMJY1xnPBU8hOgTMDCJ8R86ra8CTpmH
 FcBh+nbNecOlWyMYbxzl3kS27m4kTeJjncwYE8DwkcNi7Cj/+AFM1ChiKFN9pzjLgAEv
 ueofHqhYyBBW+YWiZ2dYNh+SHUnvpeIqHB52ggm4stRaEKeuw0QUcGJcyQwYgrGQPCfJ
 dDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705252; x=1791310052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DggZRdlvkhWaFtZdzLKFvI6qjxGBysmXATvs//XVH4o=;
 b=ymkXMorxd7tU5L8Tv4dGGpp4OhAv+lhw/qcqSHtCR5tGKnUTPxu/Cy20vFwISugbxR
 9iYbHRM1LvCKjeLCLRd/uN7yP+kGys4hYTjYpX5FQlY9hn1x31oLfR9D593CDGUyadN8
 YVW/ghVLOMfMgpkbcIqiCH42ZQhIxUbZlS1kx3dkjMakddQ2kjxGtUM7CR44Qci4YGIA
 UZ56sCXTeX5FZju8Aecg74V7F6tJ55X/gEbq5/tlxyhYl3f098t48B/O/2CGsxpxBwnq
 Isg1+YZCTbspFn95iBtCu1uaCYLKpkKnjVkttKf4eOgfyB+t399txrmJU+GrkKhNHSIl
 wIpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuyIup+F2iAgICE3sWDaxgFIZ4aeApCAiiAbtEcK+vhAQs0dIKnOi+yDKt8/FlE++p7uEvccs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nTTQ8Ivap/aMgBSjFBPYKaMjtSPBeBLWc4t34lRRjy1caCOC96
 J/DwkUdtnT1ORL+iYRhUzUld4l5NoKZqAG87mVV/VMzblupU6Q+87BejpSBmdzVk0+VbCaQbzgq
 Nl9/EHVGQEaY/sa/5JvgTLEh284+IzKCunouG1543/9pneiT6hh9hacBqQCufync=
X-Gm-Gg: AYBFou3gOeLYQ8nL3xuJwsF6i142/1bwUcgHE4I5SoudF1lRt0WZnZrJ4UgUGObz9rl
 9lY/YwlMSyhYEmU+rdXfCZKhrQnO5zLgYSjBNWKB6vHb79rcoYTFOhdqq2UNOV9V25nq2Z8tUr/
 DqCQuFo3Y1cGNN855d2Mexie3+gc6Qd83ekm8x+4Q9V2opL6e4xklF4Ai6Y9XcPT+mR8a5g0KFk
 oqnAj2d0ubZRBE91xVkIYRxi/RXO+vqSJaYVhT7wwEjd+Ji6pmZ30bPc8WlrA0yIgM3hqCwYiC1
 o4t60Ewp1lI44LJm2kweFike09VDNPCZAsoVCdf0AjTdIqY8+qPyxuw3d0fG8VHy+4ZYHCWNNug
 KWKdf6BJ+A2+kk73Yaa0CHqNRtIxPrVjK7LK7z6Pkto4RgIy4gebzrzlhR9zSEFKRoG0SGRnSa1
 FlIsx5NzW7GRxOiT88GqyNndAH5mWAjAFTXD+QOl/GuiA/m+Fh+vchuNLnHk3X1slI
X-Received: by 2002:a05:620a:4384:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93c9f8d51ddmr74015185a.43.1790705251989; 
 Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH v2 9/9] meson: Add Khadas VIM1S support
Date: Tue, 29 Sep 2026 14:06:31 -0400
Message-ID: <20260929180721.3440839-10-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

This adds basic support for the Khadas VIM1S [1]. I have tested the
following features when booting from the SD card:

- Distro boot
- SD card
- Ethernet (tested with TFTP)
- GPIO/ADC Buttons [*]
- RTC [*]

Features marked with [*] require v7.2 of dts/upstream. The following
features do not work:

- The eMMC scans properly but I can only read zeros. I've never seen
  this kind of failure before.
- The PWM LED does not seem to work [2].
- USB is not currently supported in upstream Linux, but I do have some
  patches for it locally (adapted from Khadas's tree). I will try to
  submit these at some point.
- I have made no attempt to get HDMI working.

I have submitted the stdout fix upstream as [3].

[1] https://www.khadas.com/vim1s
[2] https://lore.kernel.org/u-boot/20260929175239.3298566-1-sanderson@brivo.com
[3] https://lore.kernel.org/linux-arm-kernel/20260929163457.3237394-1-sanderson@brivo.com/

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

Changes in v2:
- Use our own board instead of reusing q200
- Enable more peripherals (buttons, LEDs, etc.)
- Use defaults where possible (commands, distro boot, etc.)
- Set mac address the same way Khadas does
- Set config/stdout-path so we can find the serial

 .../meson-s4-s905y4-khadas-vim1s-u-boot.dtsi  |  5 ++
 board/amlogic/vim1s/MAINTAINERS               |  7 ++
 board/amlogic/vim1s/Makefile                  |  1 +
 board/amlogic/vim1s/vim1s.c                   | 26 ++++++++
 configs/khadas-vim1s_defconfig                | 66 +++++++++++++++++++
 5 files changed, 105 insertions(+)
 create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
 create mode 100644 board/amlogic/vim1s/MAINTAINERS
 create mode 100644 board/amlogic/vim1s/Makefile
 create mode 100644 board/amlogic/vim1s/vim1s.c
 create mode 100644 configs/khadas-vim1s_defconfig

diff --git a/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi b/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
new file mode 100644
index 00000000000..9dcc9391eae
--- /dev/null
+++ b/arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
@@ -0,0 +1,5 @@
+/ {
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
diff --git a/board/amlogic/vim1s/MAINTAINERS b/board/amlogic/vim1s/MAINTAINERS
new file mode 100644
index 00000000000..f774f348e69
--- /dev/null
+++ b/board/amlogic/vim1s/MAINTAINERS
@@ -0,0 +1,7 @@
+VIM1S
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+R:	Sean Anderson <sanderson@brivo.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/vim1s/
+F:	configs/khadas-vim1s_defconfig
diff --git a/board/amlogic/vim1s/Makefile b/board/amlogic/vim1s/Makefile
new file mode 100644
index 00000000000..bc4b9dad861
--- /dev/null
+++ b/board/amlogic/vim1s/Makefile
@@ -0,0 +1 @@
+obj-y := vim1s.o
diff --git a/board/amlogic/vim1s/vim1s.c b/board/amlogic/vim1s/vim1s.c
new file mode 100644
index 00000000000..d58f3b6299d
--- /dev/null
+++ b/board/amlogic/vim1s/vim1s.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Brivo Inc.
+ */
+
+#include <env.h>
+#include <net-common.h>
+#include <asm/io.h>
+
+#define SYSCTRL_SEC_STATUS_REG18	0xfe010348
+
+int misc_init_r(void)
+{
+	/* This procedure copied from Khadas's downstream fork */
+	u32 val = readl(SYSCTRL_SEC_STATUS_REG18);
+	unsigned char addr[ARP_HLEN] = {
+		0x02,
+		0xad,
+		val >> 24,
+		0x01,
+		(val >> 8) & 0xff,
+		val & 0xff,
+	};
+
+	return eth_env_set_enetaddr("ethaddr", addr);
+}
diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
new file mode 100644
index 00000000000..af9d14644e0
--- /dev/null
+++ b/configs/khadas-vim1s_defconfig
@@ -0,0 +1,66 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="vim1s"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x0
+CONFIG_SYS_MALLOC_LEN=0x8000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_MESON_S4=y
+CONFIG_SYS_LOAD_ADDR=0x20000000
+CONFIG_IDENT_STRING=" vim1s"
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_ADC=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_RTC=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_MESON=y
+CONFIG_LED=y
+CONFIG_LED_PWM=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PHY_MESON_GXL=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_S4=y
+CONFIG_DM_REGULATOR=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MESON=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_PCF8563=y
+CONFIG_BAUDRATE=888888
+CONFIG_MESON_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MESON_GXBB=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.53.0

