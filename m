Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D832CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C305380C1E;
	Mon, 12 Oct 2026 17:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxiEYRrHuwpy; Mon, 12 Oct 2026 17:37:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE85480BD4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791826648;
	b=iyVBQQGRF9XNaTfUt9o4cksaGFy6aO67mrLcCZ/LNueHIn5gb8RlQpRmKUrhSzvaO/45
	 5do0GyPe8eSADc5mAFmIn19SANoQF1d7D2qE2dzVCg1qOS/G87eMx3w68qNeoMTc1Oowq
	 c56kbeTaOmRWwV/rrgqBEYsQOwNPn5jk/lLzKSah/r5Fd8/zN7CsC53BF2i5ZSaTP5Im/
	 GG/l6MjAV+doOH3pbyv5/35huTQWIdhsNXDnShqoo3QBrD/gKgYpkmBNORx6q+MJLuPIp
	 NvHhYZ0sPlKcY04V559EPRMjOnG/0/P9fjls5Lo1NMLK5isStHjEqZ95k3VARWecS9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791826648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jcr8QooBew3gVfI7+pnUzXBlB+OoChXw8CMvGsPhN2U=;
	b=Zprm1oAJm/B04CdnikT2TK+6dSbgr+GWuOirlYca2aZWa6Af6Mj+xNP0Tda8Nglfnqop
	 YTDuC8UQCt8g1uTuYKiVnr0RFSnafSNyuRfpXUHjKLD6NsUG5UcD9jarvSr/pAHcolS/2
	 DYfmzFexN4LpgQpc9o7pmQt6jp5roaI2GAJIJijLemrXdn2Sh9/U3ZakiCXUUMAeoQTlk
	 8zdyHMEpGkjs6wpdNKGRvK42/Z/YlJ6mPtInoP8qyD2B9SiU2FftTJlaVpdFCUnO3eubM
	 Rznak5ofKh4xYKFTH7MAbLVxOlAM97ltctzRBUxTr66/7GT5lMbYQF1fFJCGnDb9HLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791826648;
	bh=jcr8QooBew3gVfI7+pnUzXBlB+OoChXw8CMvGsPhN2U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tg2TiSGBpJDkqvRfvqGTwYSi9BN52uAnzBxl6kjvrFivNK+CYA0XoQrbH5i64GlBP
	 s6515tJt5ovvOGpvG6OW/o/ELFX8F/mLi4Qkg0vq+oXL2Sk7HtUn5r5PuWQhufPQ7k
	 bo2LcxQPCsk/WILnHwiVn0+nBsB7Gr1jb6DxdgpEjZUOSysRa8vh3O95hf4BALXa3s
	 bLKXdGBSDyAT5WJ881kVvQwyTbvP14g5fumJJrhh8129zesXcDI05L8gHhmUV4Tqdv
	 kyU91CbaBef3E9J+/bnr8zUsUDd4YSiaVDjqYUBtbA4dObWorzStw0rSauxflpBsHy
	 VXfNfOX4Djerg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE85480BD4;
	Mon, 12 Oct 2026 17:37:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F4162E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32F0D40206
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6kEyScGsd-Kf for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 39B28401EF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791818136;
 b=UMWZ/V5Ayrxyb6okJye9NaBQVH5/kqHvgb9bcHw/DQMG1+wLGVIKf+vS0dXUXsC+c+K1
 6mLXyeO3PHOns6qCuBJHjKXYqy7TGWThwPcNoS+K27Am04a56mQ45Njq19cuk9PXDVxmK
 UYqcKxq50HaxDYU+yLply+XOuhtTmzzMe7heP5s+xtlNWAwXd+epiGHhWOck2H3HUWiCn
 KeTnVzkwEJXs4lIzsFjZlMKCHCz8QMJkVGU0sK3iqKARYPQzGRrUUAK3oYgUwTZ5bsTvX
 bT7aDfzQJwdEdhZOz4HYmSKHl8Tfie89q4AYCCsuA7ZmFMq1ey4RTg1rAkdzhzITD3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791818136;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=jcr8QooBew3gVfI7+pnUzXBlB+OoChXw8CMvGsPhN2U=;
 b=n5nbENLup6318M6+1UuiMAcS6ri+tO5jckoOjSYbyEDcRUmPAJgmKkUGuE32RuyovHuH
 pRE5R/2qH9H9l+J+F8+6U2ufjS8tAmM5FQfOi6pVNO1o4griJw8hE/aBLDpQsNWu4Jn4g
 Hb6qk9A/HPy7VU/W2rmMu9+ebOtXqTenUbMN26Y7xnvcJ5ZQ6/nRNdM3BH0BMiReEPDtl
 6sGldtBgg9TY2KFkXbhKJ19PWbgxQ/wNsvyIyv4hRghTZKN70v/zbymIyMUU1IbQJzC3j
 jZVPpw3Hj+Gz6/24yM4fl8gSt2GdoXvfcE7XbdBg5UWivITCmZuDIYrjujDFAnJGm2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ig2sdYRu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ig2sdYRu
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39B28401EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:15:35 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15354aa70e8so1536966c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791818135; x=1792422935;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jcr8QooBew3gVfI7+pnUzXBlB+OoChXw8CMvGsPhN2U=;
 b=ig2sdYRuKXrbJSmty7lqB8yqJiNhWO69P4/LZdHWxbrIAYcbOi+18+5oDDMBSY36FT
 nT0Sf+EwxRqAh+Teu9uOqOHaXxQ9f1czJ0yLqt/HvXUXPnJySl7DF2wTJ68A0deoIY5q
 fbN9E9jCFoIgITGwnaNSQ9OUYeN8CB3fHwblFqrZlsgTF4n5+zIwzcV12bfRLJKgxy2+
 oirmk2eV4DlG3rtcZozb7x2nXvqAMj/9IQhdBbVUNR8qZxzLRRtbU4uBXCnAYyZYZUpL
 aTt2dLVz1A1udegywIxRtEVCfWB62gyJWODLSuqnscrM8N3iPDhmrwo99UUPTVI18Pcu
 OXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818135; x=1792422935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jcr8QooBew3gVfI7+pnUzXBlB+OoChXw8CMvGsPhN2U=;
 b=0njOFEeFJx40TTFKlNkJKbdINa5CjsnZ6OF1GOMTmuEzSdh4mTSDKx970FO9WQcc1d
 eeUT5BvOCVD7mlYDVuGvsm8bs3SdAz+Bux3ZlGMprFhveEUFtG9SkO7bT0oeBZN01Moy
 K2o07LxYzxNlT+RWCh4lZ2zleoNzPd+hII8RrOq3PvnXaFNFBavRLUSSl0fqU1HrN3FT
 BGxu4u75o1/zsKeiXyTRhliFCjGvaSRFaPdqMo8oh9i0lmdR/i/Qk2iQW9e8Q0lj2H/H
 gxdpIOu89JXgbkOteuKjByUIBSByrTE63Tfx2AI2XhIH/z9dl9fkwk53M400sLZYPxtM
 /LEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpuBAjuz7HPh4v+SNrtxsL1BcIbPSTQRy5uvBvOBrky2qlO2how6BTOCl6lCSw2RHYDrLph6g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDLzVBBOT+AZsOKHcZgKlXz5nuZJE5FgsjVzp14+opXL2G+GPv
 6VFCnvXuqIrEWT0Rzj0Xei8m+Jru4kUoyneyv6M2sKBBizDkBiREHwrn
X-Gm-Gg: AYBFou1kXl3uloLlS1JzjA1XxHtHDkByCZTK1VNL+c8yN/ovI0qV2q09G/ZWGVdRQ6D
 G6Zx1RGr98C3fhOBnEWxCAvv1Zfx0RlAwl09vScB8djjCLqM7WpwHUJmq59R0VV73Z4OUKbHxC0
 s/bZPjjZLODWuQPRiobtpdYG3rK4SYykRgHL9pHBTb4iZ+jVliQsb0BnhINMY15kJi0W7Zk5ZyA
 EIEE7FUTENEWe/vCSW/BEdvy9ziGCzrm9ulfE+gvPX99AoSOPtRDltYPTHy8as8lUHd4dScGlNH
 ottye5Sv+VEl5EtaizG7a5njwEiARlpMmpK8DPf4FlyH5sMFfSWH3LPABp9gfHHNK9NCwx7uiwM
 Lwv45H+pCE9cxLhyxUszAYoSJZU2LkoGzyY6U+D7Tt0G8SQKPP9ESiixgdT7Pwgw10eA6KDgjUx
 m+paj6NBZOOkg8HzevOnDcKEjP6mpjtAKRCx4jZi2rQuR8oUUVVoyQXQqh/RpqwmDxCa3b8CT0I
 rd6eUXzvgu2zW8AQaREegOb2U/B/A0kFSZpdFib4tmfj61wxy8zabYpXfz4r/w9y6g2xx6AZ/4X
 GDnirJEr89rB+mZPnU3XiYAo5oHQlSupAxNAEBUhJmqNXnYY+WByQA==
X-Received: by 2002:a05:701b:458e:10b0:14d:c7ae:85e1 with SMTP id
 a92af1059eb24-16a5ed3df03mr13432921c88.21.1791818134609; 
 Mon, 12 Oct 2026 08:15:34 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd5cb5sm29383590c88.6.2026.10.12.08.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:15:34 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH] spacemit: k1: add Milk-V Jupiter
Date: Mon, 12 Oct 2026 23:15:30 +0800
Message-ID: <20261012151530.1564771-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 17:37:26 +0000
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

The SPL already maps the Milk-V Jupiter EEPROM product name
"k1-x_milkv-jupiter" to "spacemit/k1-milkv-jupiter", and the upstream
device tree for the board is in dts/upstream, but the board is not in
CONFIG_OF_LIST. board_fit_config_name_match() therefore finds no
configuration for it and U-Boot proper starts with the default
(Banana Pi BPI-F3) device tree.

Add a u-boot.dtsi for the board and list it in CONFIG_OF_LIST. The
board is close to the BPI-F3: the EEPROM is at 0x50 on i2c2 and the P1
PMIC at 0x41 on i2c8, with the same buck1/buck3/aldo1 rails, so the
dtsi follows k1-bananapi-f3-u-boot.dtsi. Like the MusePi Pro, the
Jupiter has an SPI NOR flash on the QSPI controller, so mark it
bootph-pre-ram as well.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Not tested on hardware: I don't have a way to recover the board if the
new boot chain fails, so this is compile-tested only. What I checked:

- The FIT built from spacemit_k1_defconfig now has a
  "spacemit/k1-milkv-jupiter" configuration (conf-2), and the Jupiter
  DTB carries the bootph-pre-ram and regulator-name properties from the
  new dtsi.
- On a Milk-V Jupiter running Linux, the EEPROM at 0x50 on i2c2 holds a
  TlvInfo product name (type 0x21) of "k1-x_milkv-jupiter", which is the
  name board/spacemit/k1/spl.c maps to "spacemit/k1-milkv-jupiter".
- On the same board, the P1 PMIC answers at 0x41 on i2c8, and the SPI
  NOR on the QSPI controller at 0xd420c000 is a GD25Q64, matching the
  nodes this dtsi marks bootph-pre-ram.

A Tested-by from someone with a Jupiter would be welcome.

 arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi | 132 ++++++++++++++++++++
 configs/spacemit_k1_defconfig               |   2 +-
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi

diff --git a/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi b/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi
new file mode 100644
index 000000000..24bc87669
--- /dev/null
+++ b/arch/riscv/dts/k1-milkv-jupiter-u-boot.dtsi
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ * Copyright (C) 2026 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Based on k1-bananapi-f3-u-boot.dtsi.
+ */
+
+#include "binman.dtsi"
+
+/ {
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&osc_32k {
+	bootph-pre-ram;
+};
+
+&vctcxo_1m {
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	bootph-pre-ram;
+};
+
+&syscon_mpmu {
+	bootph-pre-ram;
+};
+
+&pll {
+	bootph-pre-ram;
+};
+
+&syscon_apmu {
+	bootph-pre-ram;
+};
+
+&syscon_apbc {
+	bootph-pre-ram;
+};
+
+&i2c2 {
+	bootph-pre-ram;
+
+	eeprom@50 {
+		bootph-pre-ram;
+	};
+};
+
+/*
+ * The kernel pmic@41 nodes use the standard regulator-* properties only;
+ * U-Boot's regulator framework looks up suppliers by `regulator-name`.
+ * Carry the U-Boot-specific names (vdd_core / vdd_1v8 / vdd_1v8_mmc) here
+ * so SPL can program the bucks that DDR training depends on.
+ */
+&i2c8 {
+	bootph-pre-ram;
+
+	pmic@41 {
+		bootph-pre-ram;
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_core";
+				bootph-pre-ram;
+			};
+
+			buck3 {
+				regulator-name = "vdd_1v8";
+				bootph-pre-ram;
+			};
+
+			aldo1 {
+				regulator-name = "vdd_1v8_mmc";
+				bootph-pre-ram;
+			};
+		};
+	};
+};
+
+&qspi {
+	bootph-pre-ram;
+
+	flash@0 {
+		bootph-pre-ram;
+	};
+};
+
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 39c490438..8e8ecbb6d 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
+CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-milkv-jupiter spacemit/k1-musepi-pro"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.43.0

