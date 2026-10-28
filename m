Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28695606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tbdBN79U;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YaOAVJ4g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD11B80CBC;
	Wed, 28 Oct 2026 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FksYqn-QpeMs; Wed, 28 Oct 2026 13:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C28538108A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194593;
	b=o97tymyhI43qqOG0vhQv5QYtRjKaQcLHmEUQh85QrLb4BHeNetMDcdT76MKfTGsIOsa/
	 t1sMNP/8SwjPCKqtWJHxZSQPNzhmOA7QDw10s5UvSEPKKqaCvu9+Jf9A/0I8mZKngSgDE
	 eFTatjjEOQyvLr02rpobOk8caO6VjSijNPTx4XqfxbOuxlMYoUNKBj+ZK5ut6UXIcbOtO
	 xHEhfQLdrcc9sz2RV4u2d/p0gqLfnHWg0Zt1OKJq/bbaBghadFit1BehF1a4y36y0HWfi
	 WjYDyNvf3qNq/Sar2GTFNe8Ue6Sr7RpWV/IZ4jBOoC1YYrion0U2rISpBdOaNrOQpUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2pRebntRodZtRWeNj8qszisqpkJPNIfBNVm5vBE6WYc=;
	b=c/4PN6HzlFj83S4C+auARRTE4EjvRXiO7/+j19ntDH082Zx0/Jfh7bwbrJ8brJIH6rY4
	 1CNWIifgmgpDgvGQFsf2H8F9bHpn+hzKH77iRunrdnx6PrFOWwGr9mxDug616f/5/7aX4
	 5b9Yqopajnk//r/bN4qi8IfeRUbhBhwzMFrQhDLIhOAiZBRVZjEFAgF0SJt1ORhu10ZUc
	 gUSMyRVUY/x0tc+3NqAfRZnpOOHNBHGUVsT6tvhDUlXpgY7dGaMXcsaVkXOMemnZBmaPh
	 cQxbSwH6G5qSaE143Kmr5lwa/Shta4qS9VVZJ949A8leOeaML3j0+d4NvAscXVk7DgQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194593;
	bh=2pRebntRodZtRWeNj8qszisqpkJPNIfBNVm5vBE6WYc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tbdBN79UEci979MQ9uMF0lk+KCk8t5qOmkx1YQkWbnWAWMOAKvHbmVbtr7nY0Wq1a
	 e9zpc9AfQBXLchwjCjpUVDkmBs3eH+nz2B3PNpd3Fn0pm19Y2t1ipva2mXFPeCSpRN
	 Dc7utJgT1kmseWl9Z/N0TlCnfGf/i5npEBb95u9l/YWeOcHm9txLbuG8C5X0cAkQvY
	 wzvr3ndebq+l48ArWaeazLhBTZIu5qm5xx3kEUT3zi2tn4BPR6N6FP3mlSlGYM80cd
	 54fZ8XiexHUvV++B2J22vNqV1pvecDTs/hEYdY0mYzM7L1p20fSUgIsBEeJgMzCdT4
	 PIdRo6Q5swHvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C28538108A;
	Wed, 28 Oct 2026 13:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0C292E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2EB3605E0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OaD_EYgzFRJu for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72BAE605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793182923;
 b=d04EcbHskpMATBZm5rof9nDRz5u54ROPRbUbSImS7ckY+RWVYKdmoqbrpyhZ+kfakeq3
 sm9PI4240WGGnWrIQ42AuhBcLAVd4urWPp0sUledjdVylo2OX2/fAeN90LfhUbPHCd6lg
 aiLSHu8w4sGiswbxMaZqt0Qg331lkxblgd52gq99eAQqkGIyk4Xo2nnPCay2nzd1W2bRh
 gmXcv5KRufXmF9KGV+Lm7Ag7YaQUUurwr3xff6sF1IUtlxGm2AihnlzqM1ofmKv9hqXpg
 8+VZ7A0V7UGUUoyOYgYg+eZwcQPPx1d6+8ZLr/SFE/5e7k675jWg4BhBXE1xfibbJaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793182923;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=2pRebntRodZtRWeNj8qszisqpkJPNIfBNVm5vBE6WYc=;
 b=dcO1LLl9xAdv/Gmt2mIAKioYNwghkzqenvxuN9uvIv7GaBFjeARrW5HANyhfGhBCHQMT
 0w+mrwDO4iRBi0ccBmjOrF5DCkFGwd4pDc2sxkkSw5a93DmKYdMoyIwifOWYcCR0vi6Kt
 PiamSlF2k4wvgB2u78klLUKPM7Oyb53Sa0NBYn73/re0CFqWMksEencz2PAXXKhZyuzjs
 IE+EBy+P6JzA4w8ItXgHtXYZ4NXNAFUsYqNpt01lNNoErStCy7NiaWa1RRNH3HlxF4GCQ
 sKW1R38vMGkEQLbTg2pwGc0U0Jgj7ZAARxW+qIe9x//wdURLvDlaMOqMxlcc4PAB1gA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YaOAVJ4g; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YaOAVJ4g
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72BAE605CF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:22:02 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so9489925e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793182921; x=1793787721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2pRebntRodZtRWeNj8qszisqpkJPNIfBNVm5vBE6WYc=;
 b=YaOAVJ4g2Y2IeJ2hsj5JUJ6JNZ0hFrRoZlQ+pEpL3t3waPFm3+qeOSrpNL35ndKcZp
 3X2SIVUaIdHYAkOV3gFxOb1wzMos7STjym/e5AOWf1S2XDvmD9WZkLuW/CoqqaAQ0tDW
 g3q9v3fK6nG07ScAyHJmTq4Il7jGjuf9r73tNGO6S1Pqn7HGF6gQezWk141BoIbPg/oh
 KM8NlM71kulQ8FzQq9skxAByFOmjQlNUZf+NKShnhE4hAYLV4dRXVn4OTw7sGPvwvSS5
 iBog0FmadAX58K+hnjVidNCvqeRVIbqG+qkGZuIpdtX/pdKcdRjJzqbk76WBZSElEQ6m
 3xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793182921; x=1793787721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2pRebntRodZtRWeNj8qszisqpkJPNIfBNVm5vBE6WYc=;
 b=lSR4gi7y+zd6u7IsfN4MJ2sfgk/ZmzINSs8Hns95j1UD4vUq211270SDeORy5Ld7sp
 vbQhHDSIt6eogVFBUKVL7roQMYb9AGxsqIv8fsx5bJsVDJec+UTyhWNZtWZhJvqT72qk
 iZVy66zq7QDqiSd2dM4OU75mKJWX5/2GDBwNMO8BWYGruS65HFZi7k3MOlHA+uk35vsX
 HLaKK70sUpoBJMu3TprJ4JbXc3VTdFsuHnBRfQMitpBthgtv+r11ELsQyhjJZPk9n10I
 SccitdhI9PHYSSsI8eo9uBcI6wCN9fYuEiIf5YJEx9Fyia0HyHrBNEiMRhJMg9Hloghu
 boVg==
X-Gm-Message-State: AFq9FYImKvsuk1VRlRW8nTt7NC/VNbsCzwHPRDM2gy6cIVSdsA5VJ1+L
 zFH1CaTQiVBbjJbg/Z/Aic2Lv5vXzMpSu1jNmOo6CgxAT25vano/vjWl
X-Gm-Gg: AYBFou2wIpT0ueiSX/op4vvMxhJwBLkjrjakCJEkD4jbPoognPZDChu1j79iajHQ2uV
 1R8QMaVJYhBO/y3ZYQFM0FG+U6VRzyqM9+p17BbpS57+GHA9nn+wbFo83BCJOCFa+4BvognLWpS
 9Ruq16boKMWJwbVhoLUY1wPHx1EOV8TMxh4beTMdVtxZEdcfE9vRdDFuq2BIa3Et6Bdx7/Sw/YE
 qKPvUVK+q/bJ2lu/k5skypsLQYv4/EF2gGOc0tMGjKUGNLBjatNN2R9A9b+vD2v9NldYQvPT3JA
 iCR7aoOXp9ciRR+MuUmLWHqYvXEyco3pEnWamO3+LXrcV5rKYR1j+PVtxKyozefGLxXtgxAG5JA
 9l1Zqj+Efl19lTqoL0TK0MiMFAIyADAjHO8S5aMs+k3+W5Ukmpypd6kj3UL4ng6cQMbSnxJs48j
 TYaVIM93Gb19HNgPKL5PvIJVSfD3oodDywYIh63nZ6hNMIViS1vnQSzPCTPCygVvXCiDPmXpTXi
 DIQY5EfA+qv1m61bV48TJuX6gSmwnSrnFAUUABPpWNuEaNbt19EoaoQeaiBhBG6eUhWw3xJ2dCE
 FfstLox3hGcPK/JEZstmLKd9442BRQDD8Hfhp2JMCG/7ClPOowzpuUCWcGSXxxsr+Ipp/m9jQ30
 ISCe0iP18zgVhX8XUyerTNDT85TAIy5Y=
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4a9677c92d0mr31846575e9.35.1793182920956; 
 Wed, 28 Oct 2026 03:22:00 -0700 (PDT)
Received: from eichest-laptop.toradex.int
 (90.251.200.213.static.wline.lns.sme.cust.swisscom.ch. [213.200.251.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a976010d2csm36987615e9.2.2026.10.28.03.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 03:22:00 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, stefan.eichenberger@toradex.com,
 franz.schnyder@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1] toradex: apalis-imx8: Disable PCIe B without on-module
 Wi-Fi
Date: Wed, 28 Oct 2026 11:21:36 +0100
Message-ID: <20261028102155.18540-1-eichest@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

On Apalis iMX8 the second PCIe controller only connects to the
on-module Wi-Fi, which is assembled on the WB variants only. With the
HSIO configuration "pciea-pcieb-sata", a probed PCIe B without a link
partner keeps its PHY lane and PHYX2_PCLK1 running, and SATA then fails
on the non-WB variants:

  ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)

The Apalis iMX8 with Wi-Fi has a 10k pull-down connected to
PCIE_CTRL1_PERST_B, use it to detect the variant. Without Wi-Fi the pad
is floating, and with the internal pull disabled its capacitance keeps
the level it was last driven to. Drive the pad high, release it and read
it back: the pull-down brings it low on the Wi-Fi variants, while it
stays high when Wi-Fi is not populated. In that case, disable the PCIe B
node in the kernel device tree.

Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index ec30ceb3a68..ba0e05a5e39 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -17,6 +17,7 @@
 #include <command.h>
 #include <env.h>
 #include <errno.h>
+#include <fdt_support.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
@@ -43,6 +44,14 @@
 				 (SC_PAD_28FDSOI_PS_PD << PADRING_PULL_SHIFT) | \
 				 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT))
 
+#define WIFI_DETECT_PAD_CTRL	((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
+				 (SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
+				 (SC_PAD_28FDSOI_PS_NONE << PADRING_PULL_SHIFT) | \
+				 (SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT))
+
+#define PCIEB_PERST_GPIO	"GPIO5_0"
+#define PCIEB_BASE_ADDR		0x5f010000
+
 #define TDX_USER_FUSE_BLOCK1_A	276
 #define TDX_USER_FUSE_BLOCK1_B	277
 #define TDX_USER_FUSE_BLOCK2_A	278
@@ -63,6 +72,10 @@ static iomux_cfg_t pcb_vers_default[] = {
 	SC_P_MIPI_DSI0_GPIO0_01 | MUX_MODE_ALT(3) | MUX_PAD_CTRL(PCB_VERS_DEFAULT),
 };
 
+static iomux_cfg_t wifi_detect_pads[] = {
+	SC_P_PCIE_CTRL1_PERST_B | MUX_MODE_ALT(3) | MUX_PAD_CTRL(WIFI_DETECT_PAD_CTRL),
+};
+
 static iomux_cfg_t uart1_pads[] = {
 	SC_P_UART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
 	SC_P_UART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
@@ -290,9 +303,51 @@ void reset_cpu(void)
 	} while (1);
 }
 
+/*
+ * The on-module Wi-Fi is assembled only on the WB variants, together with
+ * the 10k pull-down on PCIE_CTRL1_PERST_B, a module input the module never
+ * drives. On the other variants the pad is unconnected. The pad is driven
+ * high, released and read right away: an unconnected pad keeps its charge
+ * (leakage is below 1 uA), with the pull-down it is low within
+ * nanoseconds.
+ */
+static bool apalis_imx8_has_wifi(void)
+{
+	struct gpio_desc perst;
+	int val;
+
+	if (dm_gpio_lookup_name(PCIEB_PERST_GPIO, &perst))
+		return true;
+
+	if (dm_gpio_request(&perst, "Wi-Fi detection on PCIE_CTRL1_PERST_B"))
+		return true;
+
+	imx8_iomux_setup_multiple_pads(wifi_detect_pads,
+				       ARRAY_SIZE(wifi_detect_pads));
+
+	dm_gpio_set_dir_flags(&perst, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	udelay(10);
+	dm_gpio_set_dir_flags(&perst, GPIOD_IS_IN);
+	udelay(2);
+	val = dm_gpio_get_value(&perst);
+
+	dm_gpio_free(perst.dev, &perst);
+
+	return val != 1;
+}
+
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	int off;
+
+	if (!apalis_imx8_has_wifi()) {
+		off = fdt_node_offset_by_compat_reg(blob, "fsl,imx8q-pcie",
+						    PCIEB_BASE_ADDR);
+		if (off >= 0)
+			fdt_status_disabled(blob, off);
+	}
+
 	return ft_common_board_setup(blob, bd);
 }
 #endif
-- 
2.56.0

