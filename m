Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F4C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAAC8129B;
	Fri, 28 Mar 2025 13:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=beims.me header.i=@beims.me header.b="cPLR1ld4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WisPGA7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE5981E1F; Fri, 28 Mar 2025 11:21:59 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5A381CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rafael@beims.me
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 909AF25401BC;
 Fri, 28 Mar 2025 06:21:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-13.internal (MEProxy); Fri, 28 Mar 2025 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1743157314; x=1743243714; bh=uwpIpUZEbfR8RTm0mZDnB
 acgt5J3PEpAjwP+qBltO90=; b=cPLR1ld4HmUijJhFvl7viziOyts3/HDhwhGVz
 5XHx4MITbboEtIAx2bT91TQQuZmVjQgWrlnT4FZKz1Dt5DF8Lgckn3zsG0qvOPC8
 6GM7GuCpSZVMzQwQXfXlqRGkwq72B3xjnhJq2F03vzJjgHcsDRJX0bDTNXuyzVxG
 5kJ+Z6Ccgsz0brzrj1ld4R3D4vnK5JQ7hi9FDHummRDNDK37jtGVCgov3+mEhEhj
 g9439b7qj3MVy+6q89/HQpzFNpBbsbdmgqVlWELRiXbZVH84tq+QRdbfasz2ybLA
 xJSW1tbbpOSu2s3rchqTaS98XLDWzcVTvY2a7iz4FMEWhA+MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1743157314; x=1743243714; bh=uwpIpUZEbfR8RTm0mZDnBacgt5J3PEpAjwP
 +qBltO90=; b=WisPGA7kpnqeRZ30UI7CPV8pZUUAhebWaEu3Q65E2K1KF8BxtGB
 TmyHZc5tH/iNCKZgjaSuH8T2U1DgMLubQkg0cyDV8oIYQF1LuhxCw+5kwp005ErX
 wbK5BvTQiHEdSFmifd0TWiTGUHvWBV1MygJ/iG2gtE7Rufcl3nFvbrxJosF+jMop
 robwa1Or7k1+7+HTLfA7SoGSVM9LHpv1g8KVD57n0896NjFPECIYq40HJlmLlawg
 SIgscjIi9pemtU2uSPIhss+i41tkzSDqRFHr/TNw9zuUC97eKOk8roQXK88mX3ph
 w3o4McE5yEXJdJD/EEkIefsVK+L4dyJCqww==
X-ME-Sender: <xms:QnjmZ5prFEQIHw2AMNeJb8to0Inwj3NSiArvWlKcpoqiA5-C_hNClQ>
 <xme:QnjmZ7pITFsW2X2_p7vyZdWtcXcs9o-PbuB6F8uTWQj7eLY6LZbVo9Sy8o7u4OGi-
 DyAxA4cKSJYIVC2fYg>
X-ME-Received: <xmr:QnjmZ2NrqrcBl13z2IsrOh4QP2zIhJ-ObCqca4bvlg4iZp1T4sTaPBa9g-w3aForWFiGI1yIzSbR3s2uc_YZ4cd8IRFIomZS8siYGWOvZtqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedutdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
 ucfhrhhomheprhgrfhgrvghlsegsvghimhhsrdhmvgenucggtffrrghtthgvrhhnpeefke
 ekgfdvhefhfefgleethfduudeuffejvedvkefhgffhleejgeelkeehtddtieenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhessg
 gvihhmshdrmhgvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopehfrhgrnhgtvghstghordguohhltghinhhisehtohhrrgguvgigrdgtohhmpd
 hrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprhgr
 fhgrvghlrdgsvghimhhssehtohhrrgguvgigrdgtohhmpdhrtghpthhtohepuhdqsghooh
 htsehlihhsthhsrdguvghngidruggvpdhrtghpthhtoheprhgrfhgrvghlsegsvghimhhs
 rdhmvg
X-ME-Proxy: <xmx:QnjmZ04XMm4gTaNAOy4uX4prDBXm5sCgc8ywGCbgbFsSfaPW8T3DSQ>
 <xmx:QnjmZ47Eb0jc37tDJtNnepex4GYsdDkWbRJfFJKGxb4YSwFBlXFc8Q>
 <xmx:QnjmZ8jg_BnuFx567z8DAzsj_aJwXNlNBOAhrnyqzmJ2MllSPmoXMA>
 <xmx:QnjmZ672nF0TTzqcpQVkZY3PDNMwtCkAq3-B3_ZhdEd3BTjG8pgk0A>
 <xmx:QnjmZyRHLe1NCnCJ4ga8Rf9tPQHgv7lguA0XWf6O9dXmyrm8A8_jDwg4>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 06:21:52 -0400 (EDT)
From: rafael@beims.me
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de,
 rafael@beims.me
Subject: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
Date: Fri, 28 Mar 2025 11:20:40 +0100
Message-ID: <20250328102051.2614040-1-rafael@beims.me>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Mar 2025 13:42:48 +0100
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

From: Rafael Beims <rafael.beims@toradex.com>

If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
enabled, the build fails for the Apalis iMX6 board.

Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
---
 board/toradex/apalis_imx6/apalis_imx6.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index ec0f223c4aa6..0329563761b4 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -463,10 +463,12 @@ static iomux_v3_cfg_t const rgb_pads[] = {
 	MX6_PAD_EIM_D31__IPU1_DISP1_DATA20 | MUX_PAD_CTRL(OUTPUT_RGB),
 };
 
+#ifdef CONFIG_IMX_HDMI
 static void do_enable_hdmi(struct display_info_t const *dev)
 {
 	imx_enable_hdmi_phy();
 }
+#endif
 
 static void enable_lvds(struct display_info_t const *dev)
 {
@@ -496,7 +498,9 @@ static int detect_default(struct display_info_t const *dev)
 	return 1;
 }
 
-struct display_info_t const displays[] = {{
+struct display_info_t const displays[] = {
+#ifdef CONFIG_IMX_HDMI
+{
 	.bus	= -1,
 	.addr	= 0,
 	.pixfmt	= IPU_PIX_FMT_RGB24,
@@ -516,7 +520,9 @@ struct display_info_t const displays[] = {{
 		.vsync_len      = 10,
 		.sync           = FB_SYNC_EXT,
 		.vmode          = FB_VMODE_NONINTERLACED
-} }, {
+} },
+#endif
+{
 	.bus	= -1,
 	.addr	= 0,
 	.di	= 1,
@@ -586,7 +592,11 @@ static void setup_display(void)
 	int reg;
 
 	enable_ipu_clock();
+
+#ifdef CONFIG_IMX_HDMI
 	imx_setup_hdmi();
+#endif
+
 	/* Turn on LDB0,IPU,IPU DI0 clocks */
 	reg = __raw_readl(&mxc_ccm->CCGR3);
 	reg |= MXC_CCM_CCGR3_LDB_DI0_MASK;
-- 
2.47.2

