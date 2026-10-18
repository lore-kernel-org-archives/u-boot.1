Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC09CCF2CC
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52CD740A1D;
	Sun, 18 Oct 2026 08:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQl8ncuF_9XV; Sun, 18 Oct 2026 08:36:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84A9940A23
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312560;
	b=eWuTP3P40IruAo6lORZd0xhtS0RtriBcw/1srGtPltfDqtKPWZtLi1dYMc1LiRhFd2ke
	 DTlUX/PPG9CVWC37qCKjWZOuKL3zfjVRBqxC12atlvT4ZHdfP/AWOJfA+8zr/wCbVFVKI
	 n4dbCkuESVUoZa5VCvDrzMnsCwD7YAC+v5WH6s+iJFwfHwHSdlODPIW7GN+04VGrz/KZL
	 oa7qvlZjOGhWWi7RbuU3x4p6KnzTw7BZgvmiw3CJypOWAmyjHE4av6NAzd3FT2KDCcf/c
	 +BlXGvNdpssgHJV8TbRqecqGEXqV3DRKtFbNq1/lssHUg4Zo6jYos/raALNit5BUv1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
	b=Up6qXNLI5qWSeDCbxj7RWlHY7sZJuqR2wpOghLmOqmmh2wkMlOud068glIC+kKwfs2dQ
	 wGmP6r1YLesPsxemZvmnHNUmBJ3jtsDunB60ajHzyv+37edJGvlW2K2wUEvIWA6qcv6ww
	 as4KtHYkKhrnPPzyb1ZJlPY2kChptVMGdMDHYJlm0NSzYT1Otl8EqAzQQken6LAklazgj
	 0gBrleez5SIU3UMic4x+ID49NVnIK9pfxK53mF3V9XkUDsvkrNtT5CCS0m2zsJzrFxhHs
	 FrzlSnhEDZNPDO7k/X22evLsk1nFfVVbCnS6T757OWHMt6iw9PZFdkTpxEGlOQ+UL4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312560;
	bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=shR43AeMKtKoSt6+JIPF8ao1dTWe/mibArvQpN31+Ra+F5lGc/uVI5tofx2G2lW8k
	 MrL6UPBz0Z+x4oW/A5huASLfdt6QYHKSu2C6SzLYBL/LiESESgi36TQmETjsRiGA+K
	 FTcx94nVD34txpJ9lJmz12EvAXrr9TTQgJ47tnWER+z87gqN77zBrsUaV+j91UBRYG
	 jMLkJQ7AEcW9Lc87g6b7VRVf9wU7iBPPl34X5molGi6f52MJA6PS/V5L3heeHumFft
	 30iWFPuu3dtNtiEwbP3ThADjqFKB99Saqjuxrg/8FSfmmepwrVq4B791ayfhsleCOe
	 wDVDQ7ECYal1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84A9940A23;
	Sun, 18 Oct 2026 08:36:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20A4675
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05C166072A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBWjzK4a0seB for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06C6060725
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312541;
 b=Kxj0tbE+T45GD6hzGvbpqdlCb0DL7/IS98WtOdORd5x3162TQeJzQ3TIbuKTIsGFEXIv
 fyo5wFgSmxs7XDiPmREjFv3oWXv2b+1pVPxogQF9n5DHk7eTEwIZckzdqq5hSJvzod0E2
 x3RutfwX3SookN0trqnvK7XvHbycVP/bpS1n7R2cRXSOxYPdbF8qVsOnE1MTiLWgC64p+
 5JpFv4f1zi+bSb9ppd7YbPLq1gGx856wcWzzgqM6AHglS0ejd8kYl2cd4l++H40QK4G1h
 4XkxNK/0ZZDTAOZyO97QbcbV9NbdUN50kRcJOXLMJ24usQMMmzy9HKZVWwBj/SdraSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312541;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
 b=qphIe8yEVyOa8k3JgowDBRRzRtDl5DrFnHyRUBhoU/flqaA/Gh9defZelFVxHJi8tYh/
 O8OXyxBdNP6E+SZQfTjOCBsHU90ZcKbqHlu9K5DFaPD6/ISvavWaDxafsZ2aub9DNSC8j
 pHAis9HYUjARBgO9l+JkLbPmt1tkqa4DCyE9pQFEDF6SKcXg8/chkvfztO6rYC8na/J7p
 2k6ZCVih/Ug3QIuRuN68PshuW9hPWhS1jS/euDey3izKcnC8OOa2Q6gWgKbKg0SeU5V1i
 LTr4zH3+A9GeSJ+yZioAPNgR9WJPgrvUV90DwfcPqAmq+bA9Sr1lco7k99On1x7ZqnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZDiA9Jbv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZDiA9Jbv
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06C6060725
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so8157415e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312539; x=1792917339;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
 b=ZDiA9JbvLTvurP6Ek/IeaULQvoCytVvFQbVrDGnJ12cVxrb/e0RoCHvmoxXxd2RzLs
 gznif3IJmM3vxm695GitK7cX6i7xCvYJ5s9MxP59EYASRq5KfA+mFJFgQdmMgfPq843u
 +nRUtQnk0eRnepc0ogQ4RcFppauYk08M+RjqZglroWgrWXZDp62XuA50ET0BL1E3vQN9
 Z0KLE0+WGC18Y5y9M+5oS+cKkdWB0Xe8zX/hX3D5aIsBY6vFgbINDQH+gn9bH9/bKS9d
 MpywZllTQ8WizEfdDbpUwsEAdTGD1ObMlUvC3W6UJOxSR4HrKfhgb85F0btaq8qSsNmz
 zgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312539; x=1792917339;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
 b=BpDk+wdN5ITVjSlDxPSEi2XMfY1vHG35gpbTLZTMOjHLx6nhcUOfYnBGlRoU9pXXQ/
 XmMLt/tGwf0kplm/8SMTw7f+r1enBi4ZZwdrVnxN+GzlRLbk5HnphEbGy2cVQ1HAcvCb
 912NFtuAtRQKVll1M5r+CF+8YnB2EYU2ewz46wBGyzmscrFIbYAJHJ5WgzVGYR0ZWAIu
 og3gb7FLUhnAR0fZI7f0GQtVNJtE/XCL8q/sBRmhHtWKYOFfuWHbaVtieYAPbCUOQXDB
 Ag42DtMZGVTe9uReOGfZD6xC5xBoVf/erKuy/BbYhu9FkLk0Al+EePz5Jsb2KNjmt1qB
 +VeA==
X-Gm-Message-State: AFq9FYIjst/SSITJKAaqEGMYztyGJRrhIj4jvUHWecNEWUk1W+rJItIC
 6ZmwLRIumBRugKq1z5n1WJ3ShGXmXTbw8GL4QW2idv1KDy3r0iQZ2N0h+5TNh2KJ
X-Gm-Gg: AYBFou20PLpsOmJIYuQ3x50yxBND9Bk4tez91PBFigvuvGG99susRcIcNR8l/tlIB6e
 CWH2zX2x33odahmYiqoe1DJeCEtPcUzJNRd3KKV3gH8yA57hQ5Iew67dXRZxTvxvbJkguYF5MzR
 XYzlaRbzF0ObJw0zosMezMhL2UzKIzpuVbMBLapxpcEJi5Gv6uTvaztQNeQjR+yy/B8zkm2xjHf
 RCMfBq3mz1zWz6Zzfw2Ooxr9z0yTBI6tOPmrFxeCjdcqKya/QTcwEokY+l6x9kGMZW0gEH6MnZi
 fSUNXQ9C/GTYqSlUW1VgrebJsr8d130QhFuikbIb15M81WkcTsdhbSUuxgApXVo42h+6tKaTMyp
 C8snOQPkTM9w8DOXLC5RSGilqy+fI4FOwGB21NFcQT5apf2g2QdTmnfwa0lyRwwhq/445FriLaI
 WbmqT43q74C/lB8XbJczVd8DrTFXMcYL7mD/etzC+e+NPxk5oi0o3Cb1A9T77OfYHAbtpZqP/3D
 Zufg+y+iE9yC6iJAwjaSP3dwSrSDMvyNMqUQ1w7XS7YJR+3F+h7Zcsge2HrajxItc/AoJZXvWmj
 6Eq6WP7rKA8t0zgDFGx2o188mALc3/3Q/rtaBEAFuyjYpai0LuEar3QZx2a+XFhy6PUKbfOjqFE
 TnXBCJuyLtf4c7XAQKM0WYQ4=
X-Received: by 2002:a05:600c:4e11:b0:4a1:811c:8069 with SMTP id
 5b1f17b1804b1-4a1d75e37fbmr86572325e9.8.1792312538691; 
 Sun, 18 Oct 2026 01:35:38 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:38 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/14] board: CZ.NIC: turris_1x: Fix up MACs and serial
 number from OTP
Date: Sun, 18 Oct 2026 10:35:16 +0200
Message-ID: <20261018083516.49229-15-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the environment is reset with "env default -a" before booting,
the kernel device tree gets no /serial-number and keeps its all-zero
MAC addresses, so Linux reports "Using random MAC address".
misc_init_r() reads both values from the ATSHA204A into the environment
at startup, and the device tree fixups take them from there, so the
reset loses them.

Read the OTP again in ft_board_setup() and repeat these fixups, through
a new weak hook in the shared P1/P2 RDB code next to
p1_p2_rdb_pc_fix_fdt_model(). As in misc_init_r(), a valid MAC address
or a 16-character serial# already in the environment is kept. An
EVT_FT_FIXUP spy would not be called: without OFNODE_MULTI_TREE, which
Turris 1.x does not enable, image_setup_libfdt() sends that event only
for the control device tree.

Tested on CZ.NIC Turris 1.1 with the NOR and the SD card build after
"env default -a".

Fixes: f41582035cf7 ("powerpc: Add support for CZ.NIC Turris 1.x routers")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
(no changes since v1)
---
 board/CZ.NIC/turris_1x/turris_1x.c    | 20 ++++++++++++++++++++
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/board/CZ.NIC/turris_1x/turris_1x.c b/board/CZ.NIC/turris_1x/turris_1x.c
index 32535ed6ee0..8173e021f11 100644
--- a/board/CZ.NIC/turris_1x/turris_1x.c
+++ b/board/CZ.NIC/turris_1x/turris_1x.c
@@ -315,6 +315,26 @@ int misc_init_r(void)
 	return 0;
 }
 
+/*
+ * The generic fixups copy the MAC addresses and the serial number from the
+ * environment into the kernel device tree. misc_init_r() puts them there, but
+ * if the environment is reset before booting, e.g. by "env default -a", they
+ * are gone. Read them from the OTP again and repeat these fixups. Valid MAC
+ * addresses and a 16-character serial# set in the environment are kept.
+ */
+void p1_p2_rdb_pc_fix_fdt_env(void *blob)
+{
+	int ret;
+
+	ret = turris_atsha_otp_init_mac_addresses(0);
+	if (ret)
+		printf("Cannot read MAC addresses from OTP: %d\n", ret);
+	turris_atsha_otp_init_serial_number();
+
+	fdt_fixup_ethernet(blob);
+	fdt_root(blob);
+}
+
 /* This comes from ../../nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c */
 extern int checkboard_p1_p2(void);
 
diff --git a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index a19a98dd0d1..07c18117cbe 100644
--- a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -373,6 +373,8 @@ int board_early_init_r(void)
 
 __weak void p1_p2_rdb_pc_fix_fdt_model(void *blob) {}
 
+__weak void p1_p2_rdb_pc_fix_fdt_env(void *blob) {}
+
 #if defined(CONFIG_OF_BOARD_SETUP) || defined(CONFIG_OF_BOARD_FIXUP)
 static void fix_max6370_watchdog(void *blob)
 {
@@ -418,6 +420,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	p1_p2_rdb_pc_fix_fdt_model(blob);
 	fix_max6370_watchdog(blob);
+	p1_p2_rdb_pc_fix_fdt_env(blob);
 
 #if defined(CONFIG_HAS_FSL_DR_USB)
 	fsl_fdt_fixup_dr_usb(blob, bd);
-- 
2.54.0 (Apple Git-157)

