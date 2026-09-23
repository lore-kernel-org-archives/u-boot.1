Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9672C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA7268098A;
	Wed, 23 Sep 2026 13:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CuNtMEK_o-n8; Wed, 23 Sep 2026 13:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 98E9E80972
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790168847;
	b=RjecBJAyuodHbwSznLIimduL31cY8CvBt1H0w2jW/kIDrDo12MHMbJpuqwNvU/VsZ/3v
	 k6kGghgdgxg9voozi2ENVIYJ4VSqIza0Kaj7Yk/0DW49tjo4+y4bGxXaWZAV+YRsdp1kJ
	 rs7BSXzEpC+EKDjx3BAF9khvh1R+QVgKW54RnVvcRhRpIcRnlYBnb9z7Bs1IfrtJDTSD+
	 S20XZbf6qOq6DcDG49IoLxzAVypUgR5RXaOai4DwuM+Xa/dLJ7a4tCnx7p5BUhj67n6cm
	 0jbrGqWVrGDQG7rjfapL3itUQllnxtuSiJl7TrORW9gswVPGdkfqW2TCxlVjMiOOizQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790168847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IuKG3rPH1D7qgixc7l/ISyXW2EAkDqVo5VmkDdPvVgM=;
	b=kXDc4X7ogPQWX6C41fAA28UHS0mGX8mlg3epxfc2oouF7f+ukvGV2MAyLKbrF2fnzZQF
	 C5DjU0gmv/+8U/UPd+IAnEuFSpa8cc0Ujf2UeiABSNIMsUUXu8pbKA3Nly3REHNxWwQIR
	 fwrqWZhzPPMOH4/iiN1wd60hHKRqXPWu7jjZadKuugL/GkyOcGOKdiPb3w3hwXbTl9DzH
	 UhEGvuFnBRGl5DzF2VIBfaPw14mHficF14kcI7Y1eBUiPpxjIWGWr26DrshHfpVU1IDHZ
	 A25lqi0Otr0Wz2LUdmhipkYtqAHfGDaMnVBBzy3Sk73KDcJ8JdQejHhUw4IzfJhtWVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zji9QgTL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790168847;
	bh=IuKG3rPH1D7qgixc7l/ISyXW2EAkDqVo5VmkDdPvVgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WJIZ6USyM1GRo5pBFIo5auLDH62gmex3ySdRoLEvSIzxa4ll5ONNKLEOhNjpVtu6Y
	 86sSAhG5pN2lSoT5JNdKYYF1dWB8dX+meorP1ST5Ohp5jvlxxVKW6domDmv3VE6Yww
	 vHUC8HD8q/wpzIVp15ZYac7BWYGtuYqubOJodEC8pJTdHLaEB7e0U+K/7j7LMzBXoB
	 XqptxjTWRxU+f3Y3p9LSUfsRHKWqdF0B2aSDLiJmfQ3M0Zs2xgaWf4DnCitZG+uQ9f
	 TDuWelz8X9rkkCcQKxnE/WL7BMeCIqPlIlg3QDiSRBVn0oWQ6t+1EBM1NcuFJCuOQY
	 ytiw0wzSAuNYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98E9E80972;
	Wed, 23 Sep 2026 13:07:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9317334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F37C80972
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1BY5IKNmdLH for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A12180934
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790168844;
 b=j7M3UXvJWKfdC8TLIjeW/op/pGK8wBEdMa0o3uDvLPCb8DRlx1+Am9l+WtB7M1VTqCvG
 mIpNxOEcsd0B8lMsm7ku+Rd481RVnUezhWNy14RS1iF3gFyiQ0f5raR4xLU2/GIwLZnOT
 qM5CBcbcma1ZGZ1i+94VxgNcRALrrTcyOLI3RoyC5nFHeEthmYxKgmVClRhWPBDFtls/L
 IV92Bbg3wt2dGp7tWHxhAs5YlX17GWG7EkBYnXvqitTsZ84QoDuXy51uS7txOcIcEQcr2
 AWZq3+kxmMz6HcIqyhkyBhO/hgQfI0df66pjUnL5O/ccOP703q3jVPowzAIFFTO6v4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790168844;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=IuKG3rPH1D7qgixc7l/ISyXW2EAkDqVo5VmkDdPvVgM=;
 b=ghrjwYuPJdP8YyYfBtQSFjT9vPU2g9tHbmiXd4W8OBf8RbkTVFyZmf+ZNh/0gr2UDAmv
 wMvxTkATiY5z2pgLbqofj/M2zReviiOovH9/8Dyxh7Tm6r3OKO7NHFCMlUt90MGt9UWyj
 OLNGd5wANUup7vgth4znX+/Q/X7DYp0Hl0BkUEeRZpY8drhXphgsRj4k+ZkTSOJlNwpts
 0o/9KbIf1L649/MFtbMRxlOixcVSOtDeeZV+5jdwhr8PSpyTRWQEY3aBrO4jhwn+SV8N3
 aQue89tvJV0PQTg/hnV6fBNl5J2rOmH0+ipW1XGvTCGFCtiFn01md2x3cCtf0JpNZUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zji9QgTL; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zji9QgTL
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A12180934
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A621760231;
 Wed, 23 Sep 2026 13:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C321F000FF;
 Wed, 23 Sep 2026 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790168842;
 bh=IuKG3rPH1D7qgixc7l/ISyXW2EAkDqVo5VmkDdPvVgM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Zji9QgTLB48S3qCfKQzbw7UWWvtU02Hw8SOcxp9bh7LG4Hk1EpfDPCcSq18ytI1aF
 mQHzzDMD+gg/nhs5Gy9wvpUpYYaEw8R2RFcSS5rps4mgc5Zh+dH6HbNgifhulhbWuC
 pFoq6UmWVaukUu7J7yhu2nRFSZ+rZAL8/mQSSO85Uf/RS/MKpfFSndpSvmTSondfoc
 VT7zO8YDCj7vHFNk89aZV2/qULCU3iQaHNP+bgLOyNvEmiQB3XBwlYJSNx0ltr9D/8
 AkrVtU79p1FmAj6Mhpmw5orrLGC7Wmda/WD76zL7HUBuQ8yFm3Bf0BFs/WmiUKcS6S
 IKJj5kDrChlhQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 13:06:53 +0000
Subject: [PATCH v2 2/2] pinctrl: spacemit: k3: add K3 pin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-pinctrl-support-v2-2-e76a917ee252@kernel.org>
References: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
In-Reply-To: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12493; i=dlan@kernel.org;
 h=from:subject:message-id; bh=gmnc6gbjJh/edTCdAQ3Z9GAjVnVAwE/wCEmOyqMxM5o=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs88A4kMbSvTckz2WqRZVklGQBwR93oinYdhE1
 GgRraNzcjeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPPABsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3E7hAAk5ma9lyywaDAqUIg+9hO5SE7GiTh/R7wetv/I2Ok4t5qo7OlIhXDc
 4o37NhzOgd2H9be+wWWrDPweReejHpGrTx0y3+nTrrZrcveaGMXlxxkaZgvoeF+onGKVv1DmIzX
 BIPiBVCPmrd5jA4T9mOcF77wyZ0jJptC1sILme6i6OdJj0GLHeJFxexrZDq3wa5tdVuAnXRtpAX
 MdSaj5RcMC0StIb8Gi6WB6GQkkn2Y2KfDcmrdAYUDDBisQk63nxnLDRkdoL02DbuxHpLN1NYb0c
 sH6I3iZfhOU8jsVPKDyq6PdmTSD5cP01sbe5bGvsB0YpejmzaeQtRvzzacXBhpVE05opZXYoGCI
 Em0ShYTXKpGspTkoG1YHA1wH8gPVaHS0YJcvwtXFZoJC6F0kCTkf4Rq/o9zgsrBkvPcapp/jXHd
 ck3FHNVYbWyJ/1miM+F7w6t5mfix1LjbOfS08+jnAJ3lcLIvxhyx9A+Y1aRhWACPrZeYsZyysXc
 L3WQUZTkSCa9Q9W9I3tbS9tSEG5G8zAjMKSqvaScAa2jZdoekzA4ORgEDegE2WClGZUlU57EueH
 jWvUPASBfgfPSB9SFUrM/zcxbhMOp1mVDP41v7vFOt92N79mBU1cCtAvcxcXrRypfGRzGHoIrki
 qqmGqSl2ujzS82LiX3Ot7mtYPdn8ys=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream Linux:
  7412311c4655 ("pinctrl: spacemit: k3: add initial pin support")
  3f20bdf71518 ("pinctrl: spacemit: k3: adjust drive strength and schmitter trigger")

K3 uses a different pin-to-register mapping than K1, so add a
K3-specific pin_to_reg path and pin/IO power-domain tables. Drive
strength expands to 4 bits with larger mA tables, and the shared
pinctrl data gains per-SoC drive_mask and drive-strength tables so
K1 and K3 can live in the same driver.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/pinctrl/spacemit/Kconfig      |   4 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 291 ++++++++++++++++++++++++++++++----
 2 files changed, 259 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
index 6aab89e160c..87cba336923 100644
--- a/drivers/pinctrl/spacemit/Kconfig
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -1,8 +1,8 @@
 config PINCTRL_SPACEMIT_K1
-	bool "Spacemit K1 SoC pinctrl driver"
+	bool "Spacemit K1/K3 SoC pinctrl driver"
 	depends on PINCTRL_GENERIC && DM
 	help
-	  Supports pin multiplexing control on Spacemit K1 SoCs.
+	  Supports pin multiplexing control on Spacemit K1 and K3 SoCs.
 
 	  The driver is controlled by a device tree node which contains both
 	  the GPIO definitions and pin control functions for each available
diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index ff0fa3a4b18..002878862dc 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -30,8 +30,10 @@
 #define PAD_EDGE_CLEAR		BIT(6)
 #define PAD_SLEW_RATE		GENMASK(12, 11)
 #define PAD_SLEW_RATE_EN	BIT(7)
-#define PAD_SCHMITT		GENMASK(9, 8)
-#define PAD_DRIVE		GENMASK(12, 10)
+#define PAD_SCHMITT_K1		GENMASK(9, 8)
+#define PAD_DRIVE_K1		GENMASK(12, 10)
+#define PAD_SCHMITT_K3		BIT(8)
+#define PAD_DRIVE_K3		GENMASK(12, 9)
 #define PAD_PULLDOWN		BIT(13)
 #define PAD_PULLUP		BIT(14)
 #define PAD_PULL_EN		BIT(15)
@@ -43,6 +45,11 @@
 #define IO_PWR_DOMAIN_MMC_Kx	0x1c
 #define IO_PWR_DOMAIN_QSPI_K1	0x20
 
+#define IO_PWR_DOMAIN_GPIO1_K3  0x04
+#define IO_PWR_DOMAIN_GPIO5_K3  0x10
+#define IO_PWR_DOMAIN_GPIO4_K3  0x20
+#define IO_PWR_DOMAIN_QSPI_K3   0x2c
+
 #define IO_PWR_DOMAIN_V18EN	BIT(2)
 
 #define APBC_ASFAR		0x50
@@ -68,6 +75,12 @@ struct spacemit_pin_io {
 	unsigned int	reserved : 8;
 };
 
+struct spacemit_pin_drv_strength {
+	unsigned int	val : 8;
+	unsigned int	ma : 16;
+	unsigned int	reserved : 8;
+};
+
 struct spacemit_pinctrl_data {
 	struct spacemit_pin_io *io_pins;
 	int nr_io_pins;
@@ -78,6 +91,12 @@ struct spacemit_pinctrl_data {
 	int (*get_functions)(struct udevice *dev);
 	int (*get_io_type)(struct udevice *dev, unsigned int pin);
 	unsigned int (*pin_to_io_pd_offset)(unsigned int pin);
+
+	u32 drive_mask;
+	struct spacemit_pin_drv_strength *ds_1v8_tbl;
+	int ds_1v8_tbl_num;
+	struct spacemit_pin_drv_strength *ds_3v3_tbl;
+	int ds_3v3_tbl_num;
 };
 
 struct spacemit_pinctrl_priv {
@@ -92,12 +111,6 @@ struct spacemit_pin_mux_config {
 	u32				config;
 };
 
-struct spacemit_pin_drv_strength {
-	unsigned int	val : 8;
-	unsigned int	ma : 16;
-	unsigned int	reserved : 8;
-};
-
 static char pin_name[PINNAME_SIZE];
 
 /* External: IO voltage via external source, can be 1.8V or 3.3V */
@@ -280,35 +293,17 @@ static inline u32 spacemit_get_ds_ma(struct spacemit_pin_drv_strength *tbl,
 	return 0;
 }
 
-static inline u8 spacemit_get_drive_strength(enum spacemit_pin_io_type type,
+static inline u8 spacemit_get_drive_strength(struct spacemit_pinctrl_data *data,
+					     enum spacemit_pin_io_type type,
 					     u32 ma)
 {
 	switch (type) {
 	case IO_TYPE_1V8:
-		return spacemit_get_ds_value(spacemit_ds_1v8_tbl,
-					     ARRAY_SIZE(spacemit_ds_1v8_tbl),
-					     ma);
-	case IO_TYPE_3V3:
-		return spacemit_get_ds_value(spacemit_ds_3v3_tbl,
-					     ARRAY_SIZE(spacemit_ds_3v3_tbl),
-					     ma);
-	default:
-		return 0;
-	}
-}
-
-static inline u32 spacemit_get_drive_strength_ma(enum spacemit_pin_io_type type,
-						 u32 value)
-{
-	switch (type) {
-	case IO_TYPE_1V8:
-		return spacemit_get_ds_ma(spacemit_ds_1v8_tbl,
-					  ARRAY_SIZE(spacemit_ds_1v8_tbl),
-					  value & 0x6);
+		return spacemit_get_ds_value(data->ds_1v8_tbl,
+					     data->ds_1v8_tbl_num, ma);
 	case IO_TYPE_3V3:
-		return spacemit_get_ds_ma(spacemit_ds_3v3_tbl,
-					  ARRAY_SIZE(spacemit_ds_3v3_tbl),
-					  value);
+		return spacemit_get_ds_value(data->ds_3v3_tbl,
+					     data->ds_3v3_tbl_num, ma);
 	default:
 		return 0;
 	}
@@ -552,8 +547,9 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			dev_err(dev, "Invalid IO type (%d)\n", io_type);
 			return -EINVAL;
 		}
-		ds = spacemit_get_drive_strength(io_type, argument);
-		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
+		ds = spacemit_get_drive_strength(data, io_type, argument);
+		clrsetbits_le32(addr, data->drive_mask,
+				field_prep(data->drive_mask, ds));
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		return spacemit_set_pin_power_source(dev, pin_selector, argument);
@@ -707,12 +703,239 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
 	.get_functions	= k1_get_functions,
 	.get_io_type	= k1_get_io_type,
 	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
+	.drive_mask	= PAD_DRIVE_K1,
+	.ds_1v8_tbl	= spacemit_ds_1v8_tbl,
+	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_ds_1v8_tbl),
+	.ds_3v3_tbl	= spacemit_ds_3v3_tbl,
+	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_ds_3v3_tbl),
+};
+
+static struct spacemit_pin_io k3_io_pins[] = {
+	{ 0, IO_TYPE_EXTERNAL, 0, },
+	{ 1, IO_TYPE_EXTERNAL, 0, },
+	{ 2, IO_TYPE_EXTERNAL, 0, },
+	{ 3, IO_TYPE_EXTERNAL, 0, },
+	{ 4, IO_TYPE_EXTERNAL, 0, },
+	{ 5, IO_TYPE_EXTERNAL, 0, },
+	{ 6, IO_TYPE_EXTERNAL, 0, },
+	{ 7, IO_TYPE_EXTERNAL, 0, },
+	{ 8, IO_TYPE_EXTERNAL, 0, },
+	{ 9, IO_TYPE_EXTERNAL, 0, },
+	{ 10, IO_TYPE_EXTERNAL, 0, },
+	{ 11, IO_TYPE_EXTERNAL, 0, },
+	{ 12, IO_TYPE_EXTERNAL, 0, },
+	{ 13, IO_TYPE_EXTERNAL, 0, },
+	{ 14, IO_TYPE_EXTERNAL, 0, },
+	{ 15, IO_TYPE_EXTERNAL, 0, },
+	{ 16, IO_TYPE_EXTERNAL, 0, },
+	{ 17, IO_TYPE_EXTERNAL, 0, },
+	{ 18, IO_TYPE_EXTERNAL, 0, },
+	{ 19, IO_TYPE_EXTERNAL, 0, },
+	{ 20, IO_TYPE_EXTERNAL, 0, },
+	{ 21, IO_TYPE_EXTERNAL, 0, },
+	{ 22, IO_TYPE_EXTERNAL, 0, },
+	{ 23, IO_TYPE_EXTERNAL, 0, },
+	{ 24, IO_TYPE_EXTERNAL, 0, },
+	{ 25, IO_TYPE_EXTERNAL, 0, },
+	{ 26, IO_TYPE_EXTERNAL, 0, },
+	{ 27, IO_TYPE_EXTERNAL, 0, },
+	{ 28, IO_TYPE_EXTERNAL, 0, },
+	{ 29, IO_TYPE_EXTERNAL, 0, },
+	{ 30, IO_TYPE_EXTERNAL, 0, },
+	{ 31, IO_TYPE_EXTERNAL, 0, },
+	{ 32, IO_TYPE_EXTERNAL, 0, },
+	{ 33, IO_TYPE_EXTERNAL, 0, },
+	{ 34, IO_TYPE_EXTERNAL, 0, },
+	{ 35, IO_TYPE_EXTERNAL, 0, },
+	{ 36, IO_TYPE_EXTERNAL, 0, },
+	{ 37, IO_TYPE_EXTERNAL, 0, },
+	{ 38, IO_TYPE_EXTERNAL, 0, },
+	{ 39, IO_TYPE_EXTERNAL, 0, },
+	{ 40, IO_TYPE_EXTERNAL, 0, },
+	{ 41, IO_TYPE_EXTERNAL, 0, },
+	{ 76, IO_TYPE_EXTERNAL, 0, },
+	{ 77, IO_TYPE_EXTERNAL, 0, },
+	{ 78, IO_TYPE_EXTERNAL, 0, },
+	{ 79, IO_TYPE_EXTERNAL, 0, },
+	{ 80, IO_TYPE_EXTERNAL, 0, },
+	{ 81, IO_TYPE_EXTERNAL, 0, },
+	{ 82, IO_TYPE_EXTERNAL, 0, },
+	{ 83, IO_TYPE_EXTERNAL, 0, },
+	{ 84, IO_TYPE_EXTERNAL, 0, },
+	{ 85, IO_TYPE_EXTERNAL, 0, },
+	{ 86, IO_TYPE_EXTERNAL, 0, },
+	{ 87, IO_TYPE_EXTERNAL, 0, },
+	{ 88, IO_TYPE_EXTERNAL, 0, },
+	{ 89, IO_TYPE_EXTERNAL, 0, },
+	{ 90, IO_TYPE_EXTERNAL, 0, },
+	{ 91, IO_TYPE_EXTERNAL, 0, },
+	{ 92, IO_TYPE_EXTERNAL, 0, },
+	{ 93, IO_TYPE_EXTERNAL, 0, },
+	{ 94, IO_TYPE_EXTERNAL, 0, },
+	{ 95, IO_TYPE_EXTERNAL, 0, },
+	{ 96, IO_TYPE_EXTERNAL, 0, },
+	{ 97, IO_TYPE_EXTERNAL, 0, },
+	{ 98, IO_TYPE_EXTERNAL, 0, },
+	{ 99, IO_TYPE_EXTERNAL, 0, },
+	{ 100, IO_TYPE_EXTERNAL, 0, },
+	{ 101, IO_TYPE_EXTERNAL, 0, },
+	{ 102, IO_TYPE_EXTERNAL, 0, },
+	{ 103, IO_TYPE_EXTERNAL, 0, },
+	{ 104, IO_TYPE_EXTERNAL, 0, },
+	{ 105, IO_TYPE_EXTERNAL, 0, },
+	{ 106, IO_TYPE_EXTERNAL, 0, },
+	{ 107, IO_TYPE_EXTERNAL, 0, },
+	{ 108, IO_TYPE_EXTERNAL, 0, },
+	{ 109, IO_TYPE_EXTERNAL, 0, },
+	{ 110, IO_TYPE_EXTERNAL, 0, },
+	{ 111, IO_TYPE_EXTERNAL, 0, },
+	{ 112, IO_TYPE_EXTERNAL, 0, },
+	{ 113, IO_TYPE_EXTERNAL, 0, },
+	{ 114, IO_TYPE_EXTERNAL, 0, },
+	{ 115, IO_TYPE_EXTERNAL, 0, },
+	{ 116, IO_TYPE_EXTERNAL, 0, },
+	{ 117, IO_TYPE_EXTERNAL, 0, },
+	{ 118, IO_TYPE_EXTERNAL, 0, },
+	{ 119, IO_TYPE_EXTERNAL, 0, },
+	{ 120, IO_TYPE_EXTERNAL, 0, },
+	{ 121, IO_TYPE_EXTERNAL, 0, },
+	{ 122, IO_TYPE_EXTERNAL, 0, },
+	{ 123, IO_TYPE_EXTERNAL, 0, },
+	{ 124, IO_TYPE_EXTERNAL, 0, },
+	{ 125, IO_TYPE_EXTERNAL, 0, },
+	{ 126, IO_TYPE_EXTERNAL, 0, },
+	{ 127, IO_TYPE_EXTERNAL, 0, },
+	{ 132, IO_TYPE_EXTERNAL, 0, },
+	{ 133, IO_TYPE_EXTERNAL, 0, },
+	{ 134, IO_TYPE_EXTERNAL, 0, },
+	{ 135, IO_TYPE_EXTERNAL, 0, },
+	{ 136, IO_TYPE_EXTERNAL, 0, },
+	{ 137, IO_TYPE_EXTERNAL, 0, },
+	{ 138, IO_TYPE_EXTERNAL, 0, },
+	{ 139, IO_TYPE_EXTERNAL, 0, },
+	{ 140, IO_TYPE_EXTERNAL, 0, },
+	{ 141, IO_TYPE_EXTERNAL, 0, },
+	{ 142, IO_TYPE_EXTERNAL, 0, },
+	{ 143, IO_TYPE_EXTERNAL, 0, },
+	{ 144, IO_TYPE_EXTERNAL, 0, },
+};
+
+static inline int k3_get_pins(struct udevice *dev)
+{
+	return 153;
+}
+
+static inline int k3_get_functions(struct udevice *dev)
+{
+	return 7;
+}
+
+static void __iomem *k3_pin_to_reg(struct udevice *dev, unsigned int pin)
+{
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	unsigned int offset = pin > 130 ? (pin + 2) : pin;
+
+	if (pin > 152) {
+		dev_err(dev, "Invalid pin (%u)\n", pin);
+		return NULL;
+	}
+	return priv->regs + (offset << 2);
+}
+
+static int k3_get_gpio_mux(struct udevice *dev, unsigned int selector)
+{
+	if (selector > 152) {
+		dev_err(dev, "Invalid pin (%u)\n", selector);
+		return -EINVAL;
+	}
+	/* SD/MMC1, QSPI, PMIC/JTAG use gpiofunc 1 per Linux pin data */
+	if (selector >= 132)
+		return 1;
+	return 0;
+}
+
+static int k3_get_io_type(struct udevice *dev, unsigned int selector)
+{
+	if (selector <= 41)
+		return IO_TYPE_EXTERNAL;
+	if (selector <= 75)
+		return IO_TYPE_1V8;
+	if (selector <= 127)
+		return IO_TYPE_EXTERNAL;
+	if (selector <= 131)
+		return IO_TYPE_1V8;
+	if (selector <= 144)
+		return IO_TYPE_EXTERNAL;
+	if (selector <= 152)
+		return IO_TYPE_1V8;
+	return -EINVAL;
+}
+
+static unsigned int spacemit_k3_pin_to_io_pd_offset(unsigned int pin)
+{
+	unsigned int offset = 0;
+
+	switch (pin) {
+	case 0 ... 20:
+		offset = IO_PWR_DOMAIN_GPIO1_K3;
+		break;
+	case 21 ... 41:
+		offset = IO_PWR_DOMAIN_GPIO2_Kx;
+		break;
+	case 76 ... 98:
+		offset = IO_PWR_DOMAIN_GPIO4_K3;
+		break;
+	case 99 ... 127:
+		offset = IO_PWR_DOMAIN_GPIO5_K3;
+		break;
+	case 132 ... 137:
+		offset = IO_PWR_DOMAIN_MMC_Kx;
+		break;
+	case 138 ... 144:
+		offset = IO_PWR_DOMAIN_QSPI_K3;
+		break;
+	}
+
+	return offset;
+}
+
+static struct spacemit_pin_drv_strength spacemit_k3_ds_1v8_tbl[16] = {
+	{ 0,  2 }, { 1,  4 }, { 2,  6 }, { 3,  7 },
+	{ 4,  9 }, { 5, 11 }, { 6, 13 }, { 7, 14 },
+	{ 8, 21 }, { 9, 23 }, { 10, 25 }, { 11, 26 },
+	{ 12, 28 }, { 13, 30 }, { 14, 31 }, { 15, 33 },
+};
+
+static struct spacemit_pin_drv_strength spacemit_k3_ds_3v3_tbl[16] = {
+	{ 0,  3 }, { 1,  5 }, { 2,  7 }, { 3,  9 },
+	{ 4, 11 }, { 5, 13 }, { 6, 15 }, { 7, 17 },
+	{ 8, 25 }, { 9, 27 }, { 10, 29 }, { 11, 31 },
+	{ 12, 33 }, { 13, 35 }, { 14, 37 }, { 15, 38 },
+};
+
+static const struct spacemit_pinctrl_data k3_pinctrl_data = {
+	.io_pins	= k3_io_pins,
+	.nr_io_pins	= ARRAY_SIZE(k3_io_pins),
+	.pin_to_reg	= k3_pin_to_reg,
+	.get_gpio_mux	= k3_get_gpio_mux,
+	.get_pins	= k3_get_pins,
+	.get_functions	= k3_get_functions,
+	.get_io_type	= k3_get_io_type,
+	.pin_to_io_pd_offset = spacemit_k3_pin_to_io_pd_offset,
+	.drive_mask	= PAD_DRIVE_K3,
+	.ds_1v8_tbl	= spacemit_k3_ds_1v8_tbl,
+	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_k3_ds_1v8_tbl),
+	.ds_3v3_tbl	= spacemit_k3_ds_3v3_tbl,
+	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_k3_ds_3v3_tbl),
 };
 
 static const struct udevice_id spacemit_pinctrl_ids[] = {
 	{
 		.compatible = "spacemit,k1-pinctrl",
 		.data = (uintptr_t)&k1_pinctrl_data,
+	}, {
+		.compatible = "spacemit,k3-pinctrl",
+		.data = (uintptr_t)&k3_pinctrl_data,
 	}, { /* sentinel */ }
 };
 

-- 
2.55.0

