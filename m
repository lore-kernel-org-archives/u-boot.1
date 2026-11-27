Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17A606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k3A2cOof;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwYeUpow
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C286E40AD7;
	Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D8HZOST1XdMI; Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 10E0140AD9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804155;
	b=PtkmwBpvdkImabRKOa6/ucWRfwhSelzV0pX+8/M/oXJaEdV+rAXnTY68quhIpuE4RX/q
	 3dkLXAqFonlDzWTmvoOEfRmMok/hQSOwxOeuMf6oBowgzRbqpPJUD2pMvvAtM9vb0ZSH0
	 Ebp8tRszqj+lbhR7N1oGFxk3O/fRJRJxzYnaVYn1WiZC8n0aJ02zJKcxkDeal+l9rQlPP
	 u0X/8CW7SuS83FC143DoC3KKnFGe92+jms0t8wv8dGIJWheZ7NgkcJj+FYCl+UBchefQL
	 rZwzCBZ5e6lri0wbngp9NJuShvBQQidD3j0+sUUtH7VdjbKohqMZLD7NJ3zXjBMmduQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yXp5Y2j3I8OZJbDv3CP6APCdFbXBzvsodR7/9TSe84w=;
	b=LY6inyQ6oYap+jXOizROZ7zuRREaqiN6MnfyvmyjKgJEhtJ1mvQ2vRlNGsoq+pOLZbnL
	 teAKw/fQoRyqn9ziUA/cylFO/TrLjkIuKQkt1YNtyf7nLiDPvSew7fEiskEcwqjEKDUyn
	 afSB9qHHi3Vb4Ah+llaaoLDTSyW43TPYQUNZCtbEAjBgdwtFhXg+33CU0LE5Gw+/sYzLD
	 pfmmaEHjZXY7VBLyOFmwOChYd9yhyazPdawKMsHBMsxmJ7Ow1c4nNdxqc+BLAsqI0gX0p
	 1nYAgYUOA3Fcv1JVuauKrZkB608io8JKRZKheb7AoBAGO+NvV6Ldl2UxfIKrLOZIGrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804155;
	bh=yXp5Y2j3I8OZJbDv3CP6APCdFbXBzvsodR7/9TSe84w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3A2cOofxi44GLw+e/c2vn/KdsOQ5qz+qNMWLKqFPA2NwwA8OKkbnE8nLmzXAxa8x
	 YLFux04uqDsg8s+UziEFZpk0faM5t47nuB/ieihmJQm7FqJT2YTkTg/nAgaKz54VKp
	 MWKnbfRWOPGgVSvpDJQLG97RP4aPOesX1K+TB2Xc9XLqEcJmFF+csj7ZMK1XippvVY
	 6WBsSTU3KrxaJnD+I0tv3oO5J8D8JhOA0kKaynY5h8wa5arlICgPaepRvAZRiWYXO8
	 3VZTmb4B35lxZgwV0Q9CJPYJKASzZlNhts5V+saefBxsIYmgMByRy1AGzBdAUaCqnQ
	 vKvQAsHTTuo6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10E0140AD9;
	Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22734373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2021660A63
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oK4GRpb5f1hB for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29787608CD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=TwYeUpow
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29787608CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:10 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so5544343f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804149; x=1796408949;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yXp5Y2j3I8OZJbDv3CP6APCdFbXBzvsodR7/9TSe84w=;
 b=TwYeUpowBMlGi1lnNcm/Ffmq3tNtqnD3HemsD0Pqu8d/Dl+c5YV1N7ecvRyJ9I7b1S
 TQpPeCY7zdOsWmHqBxWVFFcEOi5Mz/gynip7Fv5INAnhy6M29k3647qPX0ulNYZwYvLF
 vUmADr58/NJrfthuVYENd6fuesLB3XHzHk0pmCcp4eav1CIgSIe1hv96y7zZIrql8W0h
 9TiOMtWAYWZsvKZetkSOzMceZDiRo5WFhaT3iQiCWpZKNbHCuBGlcXheDdQh6N6TOQ9S
 No1mp48F3OCctH7CVwRv50gw764oewbCub7R0OUlB/PQdt6HY5h4mJ9G8oYzGz0D5sLR
 3Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804149; x=1796408949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yXp5Y2j3I8OZJbDv3CP6APCdFbXBzvsodR7/9TSe84w=;
 b=ecwb3bw/4UP7zfDkcFNBYVDdIDMfpRy4vIt1PkGO01q9NdWBnukYCQ2+h1CvKkuQHn
 FIXTF2dP7omtXa8c4BBdTEy980uuSUC/UcNmly3a1LipgiA0xNmVr/43HgNqj80XYoFV
 QDLIbJ6D48zKi2cberHFs0HJeixSsIBiKus0G9Nz4zzNWU3giKj728mrsxBPAu7Fn2HL
 3ngH93Pg/gSncsLjnl8QMDAvh0vRukmNgt4RytYRnI1zNEuV0l1I93dGJuxlWPaQ2dpc
 dQO/yLYL7gnkwdXTfA99jiDtLaiMNIJN9dhbuBZ0RHjyQAWUamaxN2U6gzP0U5R669wM
 TE6w==
X-Forwarded-Encrypted: i=1;
 AL+hErHoYhvFHsrRqhfaah0URmet5++t7Ts5Fozge75/zi7QDlQ74lMtWskbnDtwmXM1epr142zf8zI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nG+rIOCwoLzqUUiNMb6XSGRM9ipgFGSK4RFN3TdCqFcl3AKFA
 5IWnrLBh5m38/riznMH8W96gJ2ePxIU+ghRb0dzclAGX2rYHDHkG1IoL
X-Gm-Gg: AZFdTZfOH1CI+1hYbVU8MUrZHQUHegC7E1QjUDjqz7OYJ+PAvF4X4DldkuPQ7WJPdjq
 aTUk6bcKqsJaZak0NX+QXLlM/e068oWQHvoi+nqA/ykoMGdn7J4Gz4tcUPjhWuthRHnqz9h+iae
 bI6TZXIq/5LnODYYXFBUGqubazhfmKtz90h4yCAG0Q4U75WHB1sQO011BZnc6RCktM0eigQpX0X
 drmpWOIPqGq91DOdhX8pfasFR39bDmc9PkVjt/JWMNI/pSxxUJYD1jhFD/LbfIcrRFSgiTTNH6V
 kNnIGKjWcgxUQRS5lZcZo4Or/WzqyB3ePsZrD+tJosQ/AO3vQwdAqpbdWSEK91MWkQc6k2X1L5U
 TtJW3B98HFhOe3MrlPuQhz2b91aUeHEFgxNafeqT4Ag6sB11dRJnC+uliAZJLCRc6MqAB6zasIG
 kN5c+gDdcTkxA2EkzDRbMXfIEIT9MKKPOzAONOv60dAJ6OFxQHnb7jKMIlC2Q45lvu/SZ9rt4wZ
 01viYEKKu/+Ly2DPIre/BOcVQ5usPjLl8YGZsnnQr9wn2YB7p3zs59dCl6nc97XxOMGfu3Yjq0g
 qFheDdF1e2U2SZwr/kA+M9DSdkdNt2gcsBM=
X-Received: by 2002:a05:6000:2893:b0:494:6f49:246d with SMTP id
 ffacd0b85a97d-4abb47b24e7mr49231276f8f.24.1795804148699; 
 Fri, 27 Nov 2026 10:29:08 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:08 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 1/8] clk: imx: pllv3: add the PLL types of the VF610
Date: Fri, 27 Nov 2026 19:28:58 +0100
Message-ID: <20261127182905.2836449-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The VF610 has two PLL types the driver lists but does not handle yet.
PLL1 and PLL2 are fractional: their rate is the parent rate times 20 or
22 plus a fraction with its numerator and denominator in two registers
of their own. The USB PLLs, PLL3 and PLL7, work as the USB PLL of the
i.MX6.

Add both, as the Linux driver does.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/clk/imx/clk-pllv3.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 4a3f1d088dd..517f4797aea 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -22,9 +22,12 @@
 #define UBOOT_DM_CLK_IMX_PLLV3_AV	"imx_clk_pllv3_av"
 #define UBOOT_DM_CLK_IMX_PLLV3_ENET     "imx_clk_pllv3_enet"
 #define UBOOT_DM_CLK_IMX_PLLV3_GENV2	"imx_clk_pllv3_genericv2"
+#define UBOOT_DM_CLK_IMX_PLLV3_SYS_VF610	"imx_clk_pllv3_sys_vf610"
 
 #define PLL_NUM_OFFSET		0x10
 #define PLL_DENOM_OFFSET	0x20
+#define PLL_VF610_NUM_OFFSET	0x20
+#define PLL_VF610_DENOM_OFFSET	0x30
 
 #define BM_PLL_POWER		(0x1 << 12)
 #define BM_PLL_POWER_V2		(0x1 << 21)
@@ -271,6 +274,27 @@ static const struct clk_ops clk_pllv3_av_ops = {
 	.set_rate	= clk_pllv3_av_set_rate,
 };
 
+static ulong clk_pllv3_vf610_get_rate(struct clk *clk)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(dev_get_clk_ptr(clk->dev));
+	unsigned long parent_rate = clk_get_parent_rate(clk);
+	u32 mfn = readl(pll->base + PLL_VF610_NUM_OFFSET);
+	u32 mfd = readl(pll->base + PLL_VF610_DENOM_OFFSET);
+	u32 mfi = (readl(pll->base) & pll->div_mask) ? 22 : 20;
+	u64 temp64 = parent_rate;
+
+	temp64 *= mfn;
+	do_div(temp64, mfd);
+
+	return parent_rate * mfi + temp64;
+}
+
+static const struct clk_ops clk_pllv3_vf610_ops = {
+	.enable		= clk_pllv3_generic_enable,
+	.disable	= clk_pllv3_generic_disable,
+	.get_rate	= clk_pllv3_vf610_get_rate,
+};
+
 static ulong clk_pllv3_enet_get_rate(struct clk *clk)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(clk);
@@ -333,6 +357,12 @@ struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
 		pll->div_shift = 0;
 		pll->powerup_set = false;
 		break;
+	case IMX_PLLV3_SYS_VF610:
+		drv_name = UBOOT_DM_CLK_IMX_PLLV3_SYS_VF610;
+		pll->div_shift = 0;
+		pll->powerup_set = false;
+		break;
+	case IMX_PLLV3_USB_VF610:
 	case IMX_PLLV3_USB:
 		drv_name = UBOOT_DM_CLK_IMX_PLLV3_USB;
 		pll->div_shift = 1;
@@ -389,6 +419,13 @@ U_BOOT_DRIVER(clk_pllv3_sys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
+U_BOOT_DRIVER(clk_pllv3_sys_vf610) = {
+	.name	= UBOOT_DM_CLK_IMX_PLLV3_SYS_VF610,
+	.id	= UCLASS_CLK,
+	.ops	= &clk_pllv3_vf610_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
 U_BOOT_DRIVER(clk_pllv3_usb) = {
 	.name	= UBOOT_DM_CLK_IMX_PLLV3_USB,
 	.id	= UCLASS_CLK,
-- 
2.56.0

