Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96A606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kz8Mi/ML;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=hVWU3mA8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48FFF60843;
	Tue, 24 Nov 2026 13:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ass6eZePnDzm; Tue, 24 Nov 2026 13:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D69B56083A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526578;
	b=GV5F7wBqPMbVbPibRr3qdy0ob0TcQWLntEJ0rSTGqGfGt2NLG21bFh/fVIXFl3/VeYLj
	 TBNcLd5qhux0VbicjSw8dFxGZWsN9s8jTsERJ41zprjo1hJVMOfrHApJe1y3yVJV/9x77
	 CWpqavQV4yq5eSh46F4pk2K9ajtbQPzy7n1IZIEgOqbVHJB5SBFcK6lqPE+duGi9WbhLe
	 +45XrF4x2ml9OwjFqz/zpdD73dpyRcowK4np78kxuZaSgh10WyNSBDD3Yht6/ZYWl6JSp
	 zHsMT8feCwiyo5+xy7FjANoo/c8rf6Kxbx4KOEpiIYDNEr/pSCHTBRwBwqLznYsiBGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-OQ-MSGID:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mV0fT0aUR56Be334MQIyJiEEQO7irttlw5V2TcaGYuw=;
	b=PEAFeScZ5SUpJKztYDuVeVVssU7fwDgb+2lN8hAwvp9IzfC4qFEDQfUdbFdncrfvEVgk
	 lpvSWL8yTdfvxk+8+Xa7Z3kw7sRmHlSYnsaoqwyBaHk+bPBd48MElbI4Yp78yPBoyNIhB
	 zjOklGgVklnCzwQOj5AlaRi9xfhhaaJVZVktZ8N0ttheO9Nhj7lDdLGiXh6zTf8aFoNAU
	 yPxIOKhi7ubXwinU2ZWZyv6K7PHTZxNCSgCNrob6mYKXv7Au03r9KBgvg59ZlrBz/7Ddz
	 5fCiSiwVd+sTDBHcnES0eP0aVkh1llxG7SM06VYLwasWmEgDvBXdH3bgG8ybcxYMd2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526578;
	bh=mV0fT0aUR56Be334MQIyJiEEQO7irttlw5V2TcaGYuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kz8Mi/MLOtbHbhk+wzjYkK/+/9UfhXpOICjk6oE9X8orn+ptNybEBq7sjxdl5JiDr
	 ljLzidQy+RTnIIM61RJzUP9ZnVX0RYIO3OqPCWIkVx8cL2WowhkTQ3eJxMcvLIqIwB
	 N89w2+Muua4keuz3uSlyELRv26gPlXkh8fSWX+TzDusFVznoprNET2X8AwFvwuysrL
	 YUEoy04O1DJ460FJE1XqCjyLT/q78yhCLUvqTvPdR5njK7uho7eL0xrC/1+b/jr5Uu
	 kwdUfasDivfKepBAyYutPFXKCEP558hdqaKbRhcvKR8YtnBN4qVjNKjgei6Kdq5KKp
	 7ywuIly9ObI2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D69B56083A;
	Tue, 24 Nov 2026 13:22:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52512260
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31FEA80EF4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGgNy8DTeVk4 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE7C980DCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=203.205.221.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.205.221.233;
 helo=out203-205-221-233.mail.qq.com; envelope-from=fragrantorchid@foxmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=hVWU3mA8
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com
 [203.205.221.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE7C980DCA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1795503631;
 bh=mV0fT0aUR56Be334MQIyJiEEQO7irttlw5V2TcaGYuw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hVWU3mA8FNJMcMVYil5BZevO1FmQKP71MNrb32It6ot4YfNTObHSGOdMmZaCfmUI6
 rxZgLmwDb2/uHTHiKFyUy9quDXayM5eD9SoRscn67m9X3PwrqF5cMqTD0uOHG7dvCy
 e/vqu8j3AF9W3bsR09vmBT0sTo0o52T/ZS7cCOno=
Received: from [127.0.0.1] ([223.73.111.26])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id E4D2D205; Tue, 24 Nov 2026 14:57:13 +0800
X-QQ-mid: xmsmtpt1795503435tzn2uwc4e
Message-ID: <tencent_EDB869F35E344CE2610E36EDFD771EA82408@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06iCAwL3mQ0etwfkvU9Aa+8JxdRfybpM4PfEXVRRLBaRhkEBXKJPj
 itQpIdzdP4fMYAmS3qGcIN3TljUYzf0nr7SWYHRlfp/jPD0j7pKSruo+ifcvm+WzVvxvL24RF1Qg
 +JfIqnua5Y+B38OCfcmXQPjm7QEmC8irt81aFmXQYBj7tRuwRWwNBMlNU18jwRBloEwmn9HFiB38
 GEV6UNmgmCTTftzpPVnAUA7S9b6yPXqYvonHyOcgaqauK5pIa1rbBnfHwTAtUy9BFhLStyHiuxWP
 2g2jTuAiLUXSAjgAXzsQ9lIVfcofy8XKtFif0QsyMtZ4WauqLyH5p4EPX4nfDu9fU2QCeqdN2Njo
 U+vh4iJOlUNAZhhci0XRmjzhy6Iv4pPZ7Wz+u7XJ1BGUTMavq0xwkENJW3C1bGQcFPvLRtEsZmd2
 HeQXGM2yOHuMbUQCPlOWfr6zxeWaYGGQUlRa8GdNmkGulPPIHb8ZQLMQtPrsm4S7NY18KovS7aFL
 QBlAMGUbRWsMfwMzmqv37PLDXQ8biIW5cJOFTYH0rwHvinIFZQopBJ5hEOlN4bxTw6RK2x/oSGaN
 VTw2hUf6XV21CBDXytMh/nSb3MZmAyQRaZxSo6DzZWz1/h4BvZ0Mkc6fCtKRx9ZYqmMqCq5WGaZ3
 hdvjnrUssz1dWVq98Kf1MQLvDLXd5ojsTOQuvKXJT7vhMCPd+jeQWbxEbVPk3CdXVCjucnR8IFE6
 MrvCv6ecvShnUXxuuBZ7tY24QdpG4yHtklLqdf0pndQ2n3HaIOYPcCiCut1YY34viD4T44MOVeIF
 i3850nlUV3Yh/DZY68bIWuLnG3u9EFigCntmOGbHGNdiRoNX99s9OvKRlHiQmxZA1WJBYeQsNHf/
 2BcVVqth1FNdJGhu8yZxLl4w7tPl/iQvzph2F0S0A/JKR9t7eMlAULpl+ki5TF7AB+ulU4DwhZQH
 lXXDQ7rPu1tfhv1LTbztOhlym70dVVIkTfLp0EoH2nq4dM5yw4yuSIFJdp/0CbKju26RJhUmUzx+
 pR+cfOGTq19P0Cp0Uw2ePkAB59dAuHT81icwLR8w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Xuechao Han <fragrantorchid@foxmail.com>
Date: Tue, 24 Nov 2026 14:57:15 +0800
Subject: [PATCH v3 2/2] mmc: dw_mmc: support the cd-gpios card detect pin
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20261124-lckfb-tspi-3m-v3-2-2ade6e655544@foxmail.com>
References: <20261124-lckfb-tspi-3m-v3-0-2ade6e655544@foxmail.com>
In-Reply-To: <20261124-lckfb-tspi-3m-v3-0-2ade6e655544@foxmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
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

Rockchip boards route SD card detection to a GPIO rather than to the
SDMMC controller's native CD input, so that the controller can be
clock-gated while no card is inserted.  The board device trees mux the
detect pin as a plain GPIO and describe it with a cd-gpios property, but
the DesignWare driver never looked at it, so U-Boot always assumed that
a card was present.

Add an optional get_cd() callback to struct dwmci_host, implement it in
the Rockchip glue by requesting cd-gpios in probe(), and report the GPIO
state to the MMC core.  When no callback is provided the hook returns
-ENOSYS, which the core treats as "card present", so existing users are
unaffected.  Failing to get the GPIO is not fatal either: SPL device
trees only contain GPIO controllers marked bootph-pre-ram, and in that
case the driver keeps reporting the card as present, as before.

This is not required for booting: without it U-Boot simply assumes that
a card is present and the SD card still works, so the change only makes
card detection follow the device tree, avoids probing an empty slot
until it times out, and keeps the behaviour consistent with the
operating system.

Signed-off-by: Xuechao Han <fragrantorchid@foxmail.com>
---
 drivers/mmc/dw_mmc.c          | 12 ++++++++++++
 drivers/mmc/rockchip_dw_mmc.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/dwmmc.h               | 13 +++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index c2424d7875ca504dad1698f1d4ecca343d7cc77e..732a60c8f43739f5026fbb41ec70ff1f9fe188e0 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -740,9 +740,21 @@ int dwmci_probe(struct udevice *dev)
 	return dwmci_init(mmc);
 }
 
+static int dwmci_get_cd(struct udevice *dev)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct dwmci_host *host = mmc->priv;
+
+	if (!host->get_cd)
+		return -ENOSYS;
+
+	return host->get_cd(host);
+}
+
 const struct dm_mmc_ops dm_dwmci_ops = {
 	.send_cmd	= dwmci_send_cmd,
 	.set_ios	= dwmci_set_ios,
+	.get_cd		= dwmci_get_cd,
 };
 
 #else
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 7a72abaa38a14a454cb27095fae40aa877b8050a..fba1be4971c9095519aa4acddf5805e065f71410 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -29,6 +29,7 @@ struct rockchip_mmc_plat {
 struct rockchip_dwmmc_priv {
 	struct clk clk;
 	struct dwmci_host host;
+	struct gpio_desc cd_gpio;
 	int fifo_depth;
 	bool fifo_mode;
 	u32 minmax[2];
@@ -57,6 +58,31 @@ static uint rockchip_dwmmc_get_mmc_clk(struct dwmci_host *host, uint freq)
 	return freq;
 }
 
+/*
+ * Rockchip boards route card detection to a GPIO rather than to the
+ * controller's native CD input, so that the controller can be clock-gated
+ * while no card is inserted.  The controller cannot see insertion through its
+ * native input in that state, but the GPIO can.
+ *
+ * The pinmux for the detect pin is part of the controller's 'pinctrl-0', which
+ * the driver model applies before probe(), so no pinctrl handling is needed
+ * here.  The active-low wiring is expressed by the GPIO flags in the device
+ * tree and handled by the GPIO uclass.
+ */
+static int rockchip_dwmmc_get_cd(struct dwmci_host *host)
+{
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	struct udevice *dev = host->priv;
+	struct rockchip_dwmmc_priv *priv = dev_get_priv(dev);
+
+	if (dm_gpio_is_valid(&priv->cd_gpio))
+		return dm_gpio_get_value(&priv->cd_gpio);
+#endif
+
+	/* No card-detect GPIO: keep assuming that a card is present */
+	return 1;
+}
+
 static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 {
 	struct rockchip_dwmmc_priv *priv = dev_get_priv(dev);
@@ -69,6 +95,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 	host->ioaddr = dev_read_addr_ptr(dev);
 	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
 	host->get_mmc_clk = rockchip_dwmmc_get_mmc_clk;
+	host->get_cd = rockchip_dwmmc_get_cd;
 	host->priv = dev;
 
 	/* use non-removeable as sdcard and emmc as judgement */
@@ -139,6 +166,17 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 	host->fifo_depth = priv->fifo_depth;
 	host->fifo_mode = priv->fifo_mode;
 
+#if CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(OF_REAL)
+	/*
+	 * Card detection is a GPIO on most Rockchip boards.  Failure to get it
+	 * is not fatal: SPL device trees only contain GPIO controllers marked
+	 * bootph-pre-ram, and in that case get_cd() falls back to reporting the
+	 * card as present, as before.
+	 */
+	gpio_request_by_name(dev, "cd-gpios", 0, &priv->cd_gpio,
+			     GPIOD_IS_IN);
+#endif
+
 #if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	/* Enable power if needed */
 	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 7e1a664651816872c87024208fc78cbe9ae7b1dc..11a7a78e26f77a9bb344dd7224790b2600e4e275 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -226,6 +226,19 @@ struct dwmci_host {
 	 */
 	unsigned int (*get_mmc_clk)(struct dwmci_host *host, uint freq);
 
+	/**
+	 * @get_cd: (Optional) Platform function to check for card presence
+	 *
+	 * @host:	DWMMC host
+	 *
+	 * This is used by platforms which route card detection to a GPIO
+	 * rather than to the controller's native CD input.  If not provided,
+	 * the MMC core assumes that a card is present.
+	 *
+	 * Return: 1 if a card is present, 0 if not, -ve on error
+	 */
+	int (*get_cd)(struct dwmci_host *host);
+
 #ifndef CONFIG_BLK
 	struct mmc_config cfg;
 #endif

-- 
2.47.3

