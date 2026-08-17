Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CA6C5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE33B8109F;
	Mon, 17 Aug 2026 18:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9n6tzGsBJ2mJ; Mon, 17 Aug 2026 18:17:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F29F3810D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990644;
	bh=6hDoyXp3E5ydoXZqHrsd62dl6LpOZQ19HdygnsWau0U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ycu3N7oyAsZb5eTvjxWNV9PMYYqSBq+H9tsfAMqtBoYXmpT4jnSGc67xkORNt4Y4Y
	 d6y/dvf4IbA+fWbEtCzyOg6oQ+HjY4XgGpmpDTSVSL8TEqIl+GZOmcEt+fo1LUXKSv
	 MDVfStShWvfuX3CPorPb3yPfdY/+mOaLAYBskws67881RfmqZzkiXEACEbGE4rjlJo
	 wpgXFJ/05XhPrUNRbyCf4HHINoj1auLj7hJ2vqHzq9dBGtrZ+XC7CTtv3jY7ldhjkt
	 EpJIIKPJPuw4DLqOQLBdqiXfPstOqkH5GBBf6okzT6CpGQpb3nvC4H/IszYsqnQuU1
	 SG4MWUkuUeJlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F29F3810D5;
	Mon, 17 Aug 2026 18:17:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30BAA282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1340980E1A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXA-yiKQ0wQ0 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:30:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 49DD2809F6
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49DD2809F6
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=D6ZnDug9
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49DD2809F6
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:30:53 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-9061a795d76so37115416d6.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786984253; x=1787589053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hDoyXp3E5ydoXZqHrsd62dl6LpOZQ19HdygnsWau0U=;
 b=D6ZnDug9ogKDfkGpKYRlMbZGJZ3Ip1/NB9UpCA9LeS5aAivVrOWnR77JEfl7+VCqkS
 /UPkpgIQYWlWCx5s3gou0CtZjjzzGAh/MdmiU6jp5rPSIry4Jnau7GW2Rx4ev9OyPG4c
 Cy0/QQ0feNrF0K0c1n2WiyMwfOrSdLo497uzHis68tLCdVXZONyNOCnuxXFa/AX2XbNm
 Ld4OtLYCxUZN/vfZ01KM9Ot/EA5I/lx7AVLalsrPhtFdkwupeuwIBXZNXRtYAgyPlilF
 qeezHdNjfOqWHc+rR9rcnZrrRMN99lrMv4g5w9KLuPX4jKDfwtveNhWqY8a788tEqace
 S7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984253; x=1787589053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hDoyXp3E5ydoXZqHrsd62dl6LpOZQ19HdygnsWau0U=;
 b=d5I24vzj+0kqOtX9h7Wx6Mul8t9C9Qlk3rz4pVusBlRSepvMgJMYbA5gFAKduMu/rr
 9LZM03VTU3hZ2/YdeGfZ53Bv11th5TeNIv6iHf4Pk0RQe26rsZvSKoBx41B2SuJ4XiY9
 VxapEI5M31sV3bGzMdL2faR0htYVoouY+0E5fpsuglnnRp+8JSRn3DWOcEJiMoK3cSMZ
 PJU8aWYpMfUkEGYuvsfdFHdDN1brLdTe+PskP/n/Vo9nn+Gv4AvkVcQID4eIMX0OYvt6
 JVuywbPdkfJtftxHl8iQGsrp0rP7qHezbF5gtn7IP68xszz8jFWGZBSyF8MYHoyROSP6
 jmPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY7XWrNoxUgijeF0XYdRBNxAo4OkM3zY2OISb5mFXc/B9M7uph9vAJQ54u4KZ9FqSS5Wp7s+Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyQvkKZx1CqLSpFBL2NtquHedB0uQiV9WEyU7mkVIqBI4O7n7Xx
 /usP2VuoFljyVgFUdqdZkMECyfzNMQLaCLlBR0LrKfjby0IzarcLZ8cdt4l6pg3y41qufdhXzfb
 YYDAvQLKu8TmfrPMRoF/xjAoz4Q241EDnRKyPRjtcSNgkvGkjfHLijziOPPk9oIu00sjX4hRWkn
 7xsoQ=
X-Gm-Gg: AR+sD11uYc4ON4TmrDzV1Du8UKoM0b6r/jJWbQnmjTsusCzMx2KheGYSkISSe8y3RUs
 0Liym9EBoJIyEYi8pF7phDJQGHmHna5SdJHlICzeEiGH0Azhh6BpL4pRoOIUiN6bcSRUeDAGsTZ
 uxcDrs/pbAJCW4/WAPeRlVOQIJjmIaRG3oRKxtdwFiU9uk2JA39reT4uCkfe+AA4QWXaUTYUwkx
 xRjzY3IWQmlx0+xE5HixE1AUab2qOrMd+XxXS9pCZvzABBKRxm1c4e3I2+gFvvvnVcR8wUVh4Vt
 goR0yYjhyPSRD0B/y3PuaX6k7Y47LJFdksN2IBK/rW62oqGA93oJhsd/E3Zyiyr89xg8a6yp2n6
 QsPLvR0tlAj34+4UEZX5g7KB1O862Cfikz7MWYCBVBz/5FPQJunuZAIR0SaXYN6TpwGiFUXMOAf
 z/+POkeRZ5QQ47GLuJZwJEazP8HmT6C2CNHmCKBUevMgy0dQpq/tXAFYYfOuumefMyh+qj8UjVS
 ty6yMoyVaCoRCJdHPbSjMcDU2M=
X-Received: by 2002:a05:6214:4b0a:b0:900:6ec7:19d9 with SMTP id
 6a1803df08f44-90a91c8ffdfmr340340176d6.3.1786984252544; 
 Mon, 17 Aug 2026 09:30:52 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4580f90csm12515336d6.9.2026.08.17.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:30:52 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 Sean Anderson <sanderson@brivo.com>,
 Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
Date: Mon, 17 Aug 2026 12:30:46 -0400
Message-ID: <20260817163048.1892107-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

These SoCs have an almost identical watchdog to other meson SoCs, except
the reset bit has moved. Add a new compatible and driver data.

This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
support for Amlogic-T7 SoCs")

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/watchdog/meson_gxbb_wdt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index fced8f3686b..30694936c93 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -18,7 +18,6 @@
 #define GXBB_WDT_CTRL_SYS_RESET_NOW		BIT(26)
 #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
 #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
-#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
 #define GXBB_WDT_CTRL_EN			BIT(18)
 
 #define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
@@ -28,6 +27,10 @@ struct amlogic_wdt_priv {
 	void __iomem *reg_base;
 };
 
+struct wdt_params {
+	u32 rst;
+};
+
 static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
 {
 	struct amlogic_wdt_priv *data = dev_get_priv(dev);
@@ -84,14 +87,14 @@ static int amlogic_wdt_expire_now(struct udevice *dev, ulong flags)
 static int amlogic_wdt_probe(struct udevice *dev)
 {
 	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+	struct wdt_params *params = (void *)dev_get_driver_data(dev);
+	struct clk clk;
 	int ret;
 
 	data->reg_base = dev_remap_addr(dev);
 	if (!data->reg_base)
 		return -EINVAL;
 
-	struct clk clk;
-
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
 		return ret;
@@ -102,7 +105,7 @@ static int amlogic_wdt_probe(struct udevice *dev)
 
 	/* Setup with 1ms timebase */
 	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
-	       GXBB_WDT_CTRL_EE_RESET |
+	       params->rst |
 	       GXBB_WDT_CTRL_CLK_EN |
 	       GXBB_WDT_CTRL_CLKDIV_EN,
 	       data->reg_base + GXBB_WDT_CTRL_REG);
@@ -117,8 +120,17 @@ static const struct wdt_ops amlogic_wdt_ops = {
 	.expire_now = amlogic_wdt_expire_now,
 };
 
+static const struct wdt_params gxbb_params = {
+	.rst = BIT(21),
+};
+
+static const struct wdt_params t7_params = {
+	.rst = BIT(22),
+};
+
 static const struct udevice_id amlogic_wdt_ids[] = {
-	{ .compatible = "amlogic,meson-gxbb-wdt" },
+	{ .compatible = "amlogic,meson-gxbb-wdt", .data = (ulong)&gxbb_params, },
+	{ .compatible = "amlogic,t7-wdt", .data = (ulong)&t7_params, },
 	{}
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_wdt

-- 
2.53.0

