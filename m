Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F7606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tqCDPlPI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3TmkL8m
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19A7240AEF;
	Thu, 19 Nov 2026 13:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wyB88tFiExt6; Thu, 19 Nov 2026 13:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3ED1940D0F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095228;
	b=c6ZoYMDP/TkWinQ9PKASQAZze2bOO+DtwZ6HABabBzvezUz8eWWiCUQtzC9nDSXleqvt
	 zk8SOpqNNGz2nUMh2XGFBIwIFtZcHW0Rnqgjn8c71ceQLmcHBJ3rcBJ9XmTfPlIp3UW6h
	 9omGuauG481HmGzubToHdx5Ejpx73z8DTF4UtsdjyKLP/EiSG6GHe5uEN467wL7wzt6vP
	 A1R7WaaYh1QxRc3exzzcohpSQKoYhomfdWFuQOGzBJj/d1vxdgMXtxCXB6EuI7niMJwhg
	 i6eUpeqeH3Rj7dJPrHcEE4+i/rF0A9K6YtBhuOXGM5O8YQqoC4YUJeSt79cXT2Att9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095228;
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
	b=IlWw0LQA0E76mXxqE/OqsfID85pIOQGL2RbzumOef5DNId9+Sukyt3tWLV1bGHLwssVC
	 h6ykwq2OERvCegdiry2LJ2ZCMpbpFbhq0gFEVPqdp4tLOgqqXD6keoj8A7kUJuEjMt5U1
	 x6daU2URed6eezafUQOe29OT3gsKzxhYaZE5CeHOxdbO52O7gQYnImkWCYFgjiydosngV
	 T4jmxhgroYTzUBk48EaPOWYlNBij85SifE53CCkijAjJUU1ZcdEC0UFLii1oDmaFLSDe+
	 KsqI5XXHYcatvM2IYjGP95UV/fkccQbAR2zah3bPbtqCx7/kVInjStM8BeMqFzERlhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3TmkL8m;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095228;
	bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tqCDPlPIiNiTc2hWb1EvbPWW378gpJO0/zK307U8d2KfycJ/GlQ7Gx8XZqhphNwn3
	 1qzLVgoklZ3gIUHgs9Bmnb/tPr9wVTF6G8eVLwixwseEt6KRqkWwO5zCVvw8mr5uw7
	 o3cv3O3UxVZ5X4IYKt6qDlQWXz8EuNJtNIqgYAQtpubjpBvg6ROgF+1XyHYgYF3ciE
	 brQuWldsv9xPopPCowbFgMuqZYQSt1an+l1UE5gsic+rpgrtp5srsXFWtldBE37yL0
	 K+2s0H+ZqHv8Dt8aC4Jfk3h28mXhd8JpOm9F+X3SbOAKeM3KZZ38KRuf4eIyiy6ovf
	 g5cdFalbT4DCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ED1940D0F;
	Thu, 19 Nov 2026 13:33:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C3029F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45DFD40CCF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TCZEckfWdCUC for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1CE2340B0D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=T3TmkL8m
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CE2340B0D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4a5506f09f5so1444370f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095212; x=1795700012;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
 b=T3TmkL8mm7k5PU+p5a9IuXblN/+wtC2b2wATemnNm8v6vlvRMMZ3Bj8qlJM7xDls/+
 MPBV/Qy7mIfOmmick8WZL9TACUTcg+IPyqrH6oZd3+MKck2qjwu+SDWvkAQQz2ttYZhN
 HXfTkgyF4c3PWghYxJNMEdTHVZIIsmrAQ1KagvpxNtBQY648qUmTph/P6+aaY7RXHbsd
 8nIhttIPbJjTIUVPGUlC8qeT3sbI1GXg4YBAc5vUsYszi2VpXFki5Qn/QQ5sZAA+/nvl
 8CTkyWDA+ULiba/LHK1qXZJrm58xip1AjYR6bvr393OMVCvtDlrwU60DgKTU55fBL8E4
 f+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095212; x=1795700012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BggugqlrWTcQAKdmYWySSvQCrS9avaGBgJCYAwuNCDk=;
 b=i4d1J8IrpUpxgeAPiOW+eRzaBF15otMbglpAS2hTk1uOLDMnS+64K0qFUzHFjqrfnj
 xDlXTf2WJcgkRMBLOc4kXz233Y6cUredLr46cSRC7euCYCNdMxb4uqxm4zhGpSh/fnDL
 Vk7ywAvEl42wgPOXokSn/9+sEWOlGueHWcHti4QQYBEAgg6r+oAwaQgTfP6W7BXXDJgG
 D9NWfBDzNavRk+QTbKhAyVTyrwutV/yXOmuP1FTDLGs+vuonC1pPObWT9FIzsbhaQStp
 e9CQBO01tbw5yU+KylQ7F15DIdyTQMsrY9HBRAEWk/MP3qDtw4RQN+NSgKo9FmRdFQiv
 3fRQ==
X-Gm-Message-State: APuU4Z9RwE8mvrgvgk9cBSFDyQpqiYgCkxwjgGL9wDc791kJWWZB+ofq
 7mEsQKoWZKJbl9wu4LiC1zB4gIePgRRErDdU11XO22hdIa3bpvdvB6gpYyk8mUlq
X-Gm-Gg: AZFdTZfxAX6bh0fm2qx6OQuQcWd6cAxH0dvKnAE+UsTQ9p8LQX5Fw6gbxsM/ZQa3O23
 byxv7sVWygD7RrgWg1YfduEhHZ4NGOqhUnFAAGqtqjjwbt0y+VNWjAn6oG7ZqxrQfB9u//ZEcPb
 ynqO4zRDrBzrLN9r4+G1oEfvNt5m2wbYYfZoen44g178rUJvRMTh1O1VMCuGXSiNIXtr+Hs8pdt
 S6Yq2Jk+8rLnoSyDJ1+c+U1jvItze3TJD4sAVsuqFqoJfNx4WSXsKdas31uy47XMGEi36n4tZVK
 TsZ6llcXfro/LZhf0L3p2By9ApaYrrh/MGoz8IypMGkVPeJeA3qjL08nsY/wqmqhgRoKJCG/fSh
 aK16bA6f4A0iccViC8RZu6W8ELjV2VdeXxvs/gjzbmx4mlFCt7X4+72Zei1bJ2fjDjNhMog/p9s
 9QJAySM70CxUCJoko7NzMpQ0Kic4UM3YazkS6GCjsBTtoHZ4cJrovS7O7THkpGsYHnj5DmQdnQK
 Od4EZmRE/Z8a461TjTa5/UPAsV3eC2Pbtx/wbRARafdt3fdXaa90GoEGXseBtQpuT7yYCoOewlu
 gaNMMeAtY9pYnNgpJcFAPOGLP1DlN2wJlsUBiJq9Dvn3fTTw6P/7mN86wCSExmY7kFrrIJZ10xC
 bM1UEEzECQzlnIUXftkkTODAV732uTUCsMcwaJ2TLx4rIzbp2qkKplyH11P9YHVRm8ScjMgFBuL
 29mc+sNVU0QQTxHIffbp0x1b1t/1qC62i6UXGUVjY0JDcwO1K7RCcj
X-Received: by 2002:a5d:4f10:0:b0:49c:fde4:1af5 with SMTP id
 ffacd0b85a97d-4a63bbc41c8mr10469028f8f.54.1795095211938; 
 Thu, 19 Nov 2026 05:33:31 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:31 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/14] board: CZ.NIC: turris_1x: Fix up MACs and serial
 number from OTP
Date: Thu, 19 Nov 2026 14:33:10 +0100
Message-ID: <20261119133310.22732-15-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

