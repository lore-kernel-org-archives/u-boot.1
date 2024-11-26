Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEB2D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0D089BEF;
	Tue, 26 Nov 2024 05:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.b="YDrHgO3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435B189C0F; Tue, 26 Nov 2024 03:25:44 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA0D8942F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hau@realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ2PZq94286953,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
 t=1732587936; bh=pVzDGdT/SslbNu8mzSIalME50dk6CxGm/RW8Qc5RP/w=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=YDrHgO3dMltWZBmkb1VBMkWZmKE4azR2m+kw6/JwFRH4LdJxNyRPFADQoXHMh5rtm
 Dg+vZUil2q2XvhcwHhLrls3L8Z5aSxD/UG6SACKWttQkodv4pYGArpUH/1dfInmHCH
 9fBy9bqF1VfLJjkvp3yZfeUvQzaL+YrE5CoUYa/D6UlgmT8yJiOntyDzXE9snOFY5+
 DHjeVB+Hp+Om/mwXb3ZXIS1UcTxF/B4FkKThVZvBTG1CXOYTA8zOIQL6m35q+YNxe2
 DpMIcn8R1D2jCOfyFBSpCC/IhflQui7hhin25Q8hhqEPss9XMVRAkNm5NJlFtSCHXy
 bBo4vDTIZdFHg==
Received: from RSEXMBS03.realsil.com.cn ([172.29.17.197])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ2PZq94286953
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:25:35 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RSEXMBS03.realsil.com.cn (172.29.17.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:25:35 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 26 Nov 2024 10:25:35 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Nov 2024 10:25:35 +0800
From: ChunHao Lin <hau@realtek.com>
To: <u-boot@lists.denx.de>
CC: ChunHao Lin <hau@realtek.com>
Subject: [PATCH 1/5] usb: eth: r8152: Add helper functions
Date: Tue, 26 Nov 2024 10:25:11 +0800
Message-ID: <20241126022515.4043-2-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126022515.4043-1-hau@realtek.com>
References: <20241126022515.4043-1-hau@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 26 Nov 2024 05:50:13 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

These helper functions(ocp/mdio/sram) are used for following patches.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/usb/eth/r8152.c | 125 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index e3f20e08c3..294f7d776e 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -302,6 +302,131 @@ static u16 sram_read(struct r8152 *tp, u16 addr)
 	return ocp_reg_read(tp, OCP_SRAM_DATA);
 }
 
+static void
+ocp_dword_w0w1(struct r8152 *tp, u16 type, u16 index, u32 clear, u32 set)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_dword(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_dword(tp, type, index, ocp_data);
+}
+
+static void
+ocp_word_w0w1(struct r8152 *tp, u16 type, u16 index, u16 clear, u16 set)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_word(tp, type, index, ocp_data);
+}
+
+static void
+ocp_byte_w0w1(struct r8152 *tp, u16 type, u16 index, u8 clear, u8 set)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_byte(tp, type, index);
+	ocp_data = (ocp_data & ~clear) | set;
+	ocp_write_byte(tp, type, index, ocp_data);
+}
+
+static void
+ocp_dword_clr_bits(struct r8152 *tp, u16 type, u16 index, u32 clear)
+{
+	ocp_dword_w0w1(tp, type, index, clear, 0);
+}
+
+static void
+ocp_dword_set_bits(struct r8152 *tp, u16 type, u16 index, u32 set)
+{
+	ocp_dword_w0w1(tp, type, index, 0, set);
+}
+
+static void
+ocp_word_clr_bits(struct r8152 *tp, u16 type, u16 index, u16 clear)
+{
+	ocp_word_w0w1(tp, type, index, clear, 0);
+}
+
+void
+ocp_word_set_bits(struct r8152 *tp, u16 type, u16 index, u16 set)
+{
+	ocp_word_w0w1(tp, type, index, 0, set);
+}
+
+static void
+ocp_word_test_and_clr_bits(struct r8152 *tp, u16 type, u16 index, u16 clear)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, type, index);
+	if (ocp_data & clear)
+		ocp_write_word(tp, type, index, ocp_data & ~clear);
+}
+
+static void
+ocp_byte_clr_bits(struct r8152 *tp, u16 type, u16 index, u8 clear)
+{
+	ocp_byte_w0w1(tp, type, index, clear, 0);
+}
+
+static void
+ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)
+{
+	ocp_byte_w0w1(tp, type, index, 0, set);
+}
+
+static void ocp_reg_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data;
+
+	data = ocp_reg_read(tp, addr);
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, addr, data);
+}
+
+void ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+{
+	ocp_reg_w0w1(tp, addr, clear, 0);
+}
+
+void ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 set)
+{
+	ocp_reg_w0w1(tp, addr, 0, set);
+}
+
+static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data;
+
+	data = sram_read(tp, addr);
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, OCP_SRAM_DATA, data);
+}
+
+static void sram_set_bits(struct r8152 *tp, u16 addr, u16 set)
+{
+	return sram_write_w0w1(tp, addr, 0, set);
+}
+
+static void sram_clr_bits(struct r8152 *tp, u16 addr, u16 clear)
+{
+	return sram_write_w0w1(tp, addr, clear, 0);
+}
+
+static void r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
+{
+	u16 data;
+
+	data = r8152_mdio_read(tp, addr);
+	if (data & clear) {
+		data &= ~clear;
+		r8152_mdio_write(tp, addr, data);
+	}
+}
+
 int r8152_wait_for_bit(struct r8152 *tp, bool ocp_reg, u16 type, u16 index,
 		       const u32 mask, bool set, unsigned int timeout)
 {
-- 
2.43.0

