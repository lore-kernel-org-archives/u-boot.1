Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69CFC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 02:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662C0879C5;
	Tue, 31 Oct 2023 03:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="X54/n98y";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VtvMZU47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2CE8799B; Tue, 31 Oct 2023 03:07:38 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C05787548
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 03:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 9D35A32008FE;
 Mon, 30 Oct 2023 22:07:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 30 Oct 2023 22:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1698718053; x=
 1698804453; bh=Nvvmj9dt5LdS5SJt0Bmr8y6dU58CamIO0gE1GaUbp/s=; b=X
 54/n98yTFmFw01NH40Ycf2bR6LuFCVqvw6UOC1yeDnBhUl4cXoLTaTV9d+89byqN
 Kiih1CsTaEWSY29YET9NWNrO0hrTlbwUAAkNWBXb0kzZuWI24+DQjysWO9ifcrM9
 GFIN+n+9Y/NrBSxZG9kLtaywq8Bjjcgs6qx1g8w408FejMjzkQtS9HSQDOPXmnBV
 AF6o6VVfBLKB+ZscjTR/onIPE/vrSr7zhPfBq1Fs7QAnbm9ADhcXVj2FClHDtA5b
 o1PPaf0CSFPuEhfE+qKwfASEvuJF7guhJgFVdjucxF8Tclk4UMxGTn7x7jdlWW/H
 hPjbI96gyHFsB8GL0/ZnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698718053; x=
 1698804453; bh=Nvvmj9dt5LdS5SJt0Bmr8y6dU58CamIO0gE1GaUbp/s=; b=V
 tvMZU47i2YN/8eUb2jOmTaPh+0z58UzFY/dh6uUYBKeyMyKU7l2zErACKV6MHL7c
 DnuHtgYrBayutm0vsHIBkSj6gGwY/V5inCnpitx58A6jdUnSoLIlaOBJIbUkUgVE
 cYdHAFJgTp+X9noMXwQV+WXyIzRXUq7Oassz5+O+39VbeIkL0DEXwArogo7SJyG/
 ma1cc3GFV2hW4cxkIr+voRawRF6sQ7EoabRO75vn1bfezADAob0FmBqLoze/Ll+L
 ixGQ1PFKyfki/k2kZ+Y5Cn/zzoTqPF/Bce1LJ8Fbb/wjNvdKI5Kcr2F3L2+uaLCK
 JU1Jt3Ojl5ps31UatOrzQ==
X-ME-Sender: <xms:ZGFAZeMqNtDk3is8na50KrrSTHX76DSH-aE-TyH5fw5nLgAKxYdTNw>
 <xme:ZGFAZc9Q0vyURo3L7ZfVQws4-UTkPV-yFVqMVtjLqG46QUHBmAeE22v-uLRYxOKp8
 qi_u5we2Q>
X-ME-Received: <xmr:ZGFAZVS6WpIYpHcmPJsB_1JpSsf3J1NHjd1kp1Eoo_hTIu1zdDfcfQ6xQH3b6Kq4cNJ6AEepfb_2ceI-jzACwZKY3hd1taKhgdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:ZGFAZes5XLbf2XuDmioPC3OJ_Xetev04hazRvpITCEKNHI69MbU_8Q>
 <xmx:ZGFAZWePNez6zTjb2Xfxs9txD3iI974Sbbpe7yRxWFPFLHpZDzPG7A>
 <xmx:ZGFAZS01f7coL8DS3us2rg52G1YC135_nEnA1TfB2QpVFJOQSPWS-g>
 <xmx:ZWFAZW4zljFLmeRH6qln712no1If9pP2YYxi_kCOQZkc8QLPKkIhww>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 22:07:29 -0400 (EDT)
Received: by feathertop.org (sSMTP sendmail emulation);
 Tue, 31 Oct 2023 13:07:26 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>
Subject: [PATCH 1/2] rockchip: otp: Add support for RV1126
Date: Tue, 31 Oct 2023 13:07:14 +1100
Message-Id: <20231031020715.684460-2-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031020715.684460-1-tim@feathertop.org>
References: <20231031020715.684460-1-tim@feathertop.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Extend the otp driver to read rv1126 otp. This driver code was
adapted from the Rockchip BSP stack.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---
 drivers/misc/rockchip-otp.c | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
index 4814e0e501..4f757083a1 100644
--- a/drivers/misc/rockchip-otp.c
+++ b/drivers/misc/rockchip-otp.c
@@ -61,11 +61,20 @@
 #define RK3588_OTPC_INT_ST		0x0084
 #define RK3588_RD_DONE			BIT(1)
 
+#define RV1126_OTP_NVM_CEB		0x00
+#define RV1126_OTP_NVM_RSTB		0x04
+#define RV1126_OTP_NVM_ST		0x18
+#define RV1126_OTP_NVM_RADDR		0x1C
+#define RV1126_OTP_NVM_RSTART		0x20
+#define RV1126_OTP_NVM_RDATA		0x24
+#define RV1126_OTP_READ_ST		0x30
+
 struct rockchip_otp_plat {
 	void __iomem *base;
 };
 
 struct rockchip_otp_data {
+	int (*init)(struct udevice *dev);
 	int (*read)(struct udevice *dev, int offset, void *buf, int size);
 	int offset;
 	int size;
@@ -232,6 +241,48 @@ static int rockchip_rk3588_otp_read(struct udevice *dev, int offset,
 	return 0;
 }
 
+static int rockchip_rv1126_otp_init(struct udevice *dev)
+{
+	struct rockchip_otp_plat *otp = dev_get_plat(dev);
+	int ret;
+
+	writel(0x0, otp->base + RV1126_OTP_NVM_CEB);
+	ret = rockchip_otp_poll_timeout(otp, 0x1, RV1126_OTP_NVM_ST);
+
+	if (ret)
+		return ret;
+
+	writel(0x1, otp->base + RV1126_OTP_NVM_RSTB);
+	ret = rockchip_otp_poll_timeout(otp, 0x4, RV1126_OTP_NVM_ST);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_rv1126_otp_read(struct udevice *dev, int offset, void *buf,
+				    int size)
+{
+	struct rockchip_otp_plat *otp = dev_get_plat(dev);
+	u32 status = 0;
+	u8 *buffer = buf;
+	int ret = 0;
+
+	while (size--) {
+		writel(offset++, otp->base + RV1126_OTP_NVM_RADDR);
+		writel(0x1, otp->base + RV1126_OTP_NVM_RSTART);
+		ret = readl_poll_timeout(otp->base + RV1126_OTP_READ_ST,
+					 status, !status, OTPC_TIMEOUT);
+		if (ret)
+			return ret;
+
+		*buffer++ = (u8)(readl(otp->base + RV1126_OTP_NVM_RDATA) & 0xFF);
+	}
+
+	return 0;
+}
+
 static int rockchip_otp_read(struct udevice *dev, int offset,
 			     void *buf, int size)
 {
@@ -286,6 +337,20 @@ static int rockchip_otp_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int rockchip_otp_probe(struct udevice *dev)
+{
+	struct rockchip_otp_data *data;
+
+	data = (struct rockchip_otp_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	if (data->init)
+		return data->init(dev);
+
+	return 0;
+}
+
 static const struct rockchip_otp_data px30_data = {
 	.read = rockchip_px30_otp_read,
 	.size = 0x40,
@@ -304,6 +369,12 @@ static const struct rockchip_otp_data rk3588_data = {
 	.block_size = 4,
 };
 
+static const struct rockchip_otp_data rv1126_data = {
+	.init = rockchip_rv1126_otp_init,
+	.read = rockchip_rv1126_otp_read,
+	.size = 0x40,
+};
+
 static const struct udevice_id rockchip_otp_ids[] = {
 	{
 		.compatible = "rockchip,px30-otp",
@@ -321,6 +392,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
 		.compatible = "rockchip,rk3588-otp",
 		.data = (ulong)&rk3588_data,
 	},
+	{
+		.compatible = "rockchip,rv1126-otp",
+		.data = (ulong)&rv1126_data,
+	},
 	{}
 };
 
@@ -331,4 +406,5 @@ U_BOOT_DRIVER(rockchip_otp) = {
 	.of_to_plat = rockchip_otp_of_to_plat,
 	.plat_auto = sizeof(struct rockchip_otp_plat),
 	.ops = &rockchip_otp_ops,
+	.probe = rockchip_otp_probe,
 };
-- 
2.40.1

