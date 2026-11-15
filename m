Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE0606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DvTOk1Hf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8NzVqqI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A760D606D5;
	Sun, 15 Nov 2026 03:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdLiAoyJE4C4; Sun, 15 Nov 2026 03:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 90C3F60716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794714643;
	b=OmimnaXgM1Y52/QaZer+6CB0DbO+Hg6Y0oFcY6TSaGmn6noXmeI544XSk/mohPN2zP43
	 u4et/MqBa4Dxw6ENY7tAbqLc3W5fqs9Olvm0GVWjSsxRi9l/7MXrt1gFsbTse4/5nBtsM
	 ZRt3sF+vfmpTbMu4ogtTwXaycs656BioftWwH+zSW6fyL3df9MR57ED6yG2DVLbtXsmW8
	 y+VwwFhzCTAViDZMC4Of5tfsqmF93SgzF5tXK/izxr2koJ0+RIM8W5l8x4eGeGcw3Tems
	 uKAKjRUZnoI3Fc5XmxUmIkjtmksK3bzr+qYMi171DVCWZ/+7qF3c80FrO73xfVAyK3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794714643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=5qk9tDHzol00P5yMID0ol1PmjZ9dxwhS0CNKDUDwj0o=;
	b=d2gUvOzCei1+rvDaF5wMjN+AMJP2Vgb+MIiKEfymZj1yoz0nJFj/gO4fbNNYUjJ7PLNZ
	 V7UjRb318p0sINdpmcgDruY/fzvZ0oMvnWiGpt/IK31TJ+Wgfw0cQAboEGT6RmIHTc24J
	 f6C7FPZMxn/JOr6HEyHaDYZhXL5kO1ntMMYjGsarIOKMPJ6bGqkt5syJQI++/zI9gHeAv
	 HApCxhKGZNot2BTuG2j9YisuYybkRhDmarao2wZXQ2C1Df9HyvF4nt+HaRMN6xY/1fRyz
	 ilsz+hf7yA13+3mSw1WmB75RzA0KsqlfKl9ZEBrCYOIDQXmpfwUQIw/UmXFSsMQJiNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794714642;
	bh=5qk9tDHzol00P5yMID0ol1PmjZ9dxwhS0CNKDUDwj0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DvTOk1HfasheAiIh0dWVGvHXw1nLyo6U87C0PdouPH68Z+bwWWvYi3emyPOs80w7w
	 fACfn4s3G0hWCc1s6IAnMa3V4xIP5g+2vFReW7EP1CZa5sipFKgNpn71bOmsWpsrp5
	 IkuSSS9dq3Szne/pTEmNdZ7BhCMQBZLNrRYXDD09JlC6MfS0OQLZHboqDtWMijwliJ
	 FrB8vjkczQs791jTXd1SzQPF93dYzAAxAEB9gCDqDRYRpv7TbLMeRiuDKe59RchRi3
	 cUvbTlXLGHa5a5od1jTA5d7cdHyQ52qOpu2c+CH9J7OLHRbirNdaHbSSTionpMuf1e
	 GmfWeq/kmt8jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90C3F60716;
	Sun, 15 Nov 2026 03:50:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A6892FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BD9E4069F
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2krIhjK2Ld_q for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 03:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55FB140693
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g8NzVqqI
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55FB140693
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:50:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD125612A4;
 Sun, 15 Nov 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E6CDD1F000C6;
 Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794714634;
 bh=5qk9tDHzol00P5yMID0ol1PmjZ9dxwhS0CNKDUDwj0o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=g8NzVqqIXoN/RrL/HzPa85k3KD5ZICyQZykfTvQQr0OJx6/AR/9zKD+7ZWzd/W7iN
 dqAVRSqq2i7d9bnct0qx5oBaxrcUZEJG5+De6HjpcBu+hOR9Jb9DvkqyI9oyWt2NoK
 aiCcdqzjxoEGd9lAGBOhGadDgqj49T2K/39+V4o+OlRbtO8DroVTbWuxD5zc4b2esn
 AnZx8s1wUODaSgUFhyAbfelyfNln296iy1da18cCjASNSAA45mMFes3LIcaeev+1Lf
 ZwwY6OdtX1yGZHFE4tEmjJtxiQ8dUzZIhqHhkSTCcbocGh6IL5Zub+K5d8jXU8tRnD
 2JDMzI1oa5HlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7543B49F5D;
 Sun, 15 Nov 2026 03:50:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 15 Nov 2026 03:50:31 +0000
Subject: [PATCH 2/3] board: amlogic: odroid-n2: tell BL301 whether to wake
 on LAN
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-b4-meson-scp-wol-v1-2-80c3e9f4deda@iav.lv>
References: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
In-Reply-To: <20261115-b4-meson-scp-wol-v1-0-80c3e9f4deda@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=3fdHEF8KsKvIXWDttHsUdkfsf3IxMKZP/SPsXxR+yF8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/ddgrvZ5c3qqfNlXL84eRfNaWsMXqt990WF07sLU07
 LGV1m+djlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjAR+WJGhpdMOzQ+TuTJeit5
 O2bTveeTveS/r3a5lbHh5PGCaTppW1gY/scLaTJNu7s/Wun6xicHl7P9cVnl8yF2Wpnsj2pL+2U
 XKxgA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Unless SCPI client 7 has been set to a non-zero value, the Hardkernel
BL301 for ODROID-C4/HC4 switches VCCK_B and the 3.3 V rail off in
suspend and does not add the PHY interrupt (GPIOZ_14) to its wake
sources.

With CONFIG_MESON_G12A_SCPI, send 1 when the Ethernet PHY in the device
tree passed to the OS has wakeup-source, and 0 otherwise. BL301 keeps
the last value, so it is sent on every fixup and the last fixup before
the OS starts wins.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 board/amlogic/odroid-n2/odroid-n2.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index ae953d0e4ba..94aaa6ca9ad 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <adc.h>
 #include <env.h>
+#include <fdtdec.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
@@ -14,6 +15,7 @@
 #include <asm/arch/sm.h>
 #include <asm/arch/eth.h>
 #include <asm/arch/boot.h>
+#include <asm/arch/scpi.h>
 
 #define EFUSE_MAC_OFFSET	20
 #define EFUSE_MAC_SIZE		12
@@ -24,6 +26,9 @@
 #define MESON_SOC_ID_G12B	0x29
 #define MESON_SOC_ID_SM1	0x2b
 
+/* Hardkernel BL301 client: 1 = stay powered in suspend and wake on the PHY */
+#define SCPI_CL_WOL		7
+
 int mmc_get_env_dev(void)
 {
 	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
@@ -138,3 +143,29 @@ int misc_init_r(void)
 	odroid_detect_variant();
 	return 0;
 }
+
+/*
+ * BL301 keeps the last value sent, so we send one on every fixup: the last
+ * fixup before the OS starts wins.
+ */
+int meson_ft_board_setup(void *blob, struct bd_info *bd)
+{
+	bool wol = false;
+	int node, phy, ret;
+
+	if (!IS_ENABLED(CONFIG_MESON_G12A_SCPI))
+		return 0;
+
+	node = fdt_node_offset_by_compatible(blob, -1,
+					     "amlogic,meson-g12a-dwmac");
+	if (node >= 0 && fdtdec_get_is_enabled(blob, node)) {
+		phy = fdtdec_lookup_phandle(blob, node, "phy-handle");
+		wol = phy >= 0 && fdtdec_get_bool(blob, phy, "wakeup-source");
+	}
+
+	ret = meson_scpi_set_usr_data(SCPI_CL_WOL, wol);
+	if (ret)
+		printf("SCP: setting Wake-on-LAN to %d failed: %d\n", wol, ret);
+
+	return 0;
+}

-- 
2.43.0


