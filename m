Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1897C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE88580DE2;
	Wed,  5 Aug 2026 17:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B97PLsqYTibd; Wed,  5 Aug 2026 17:53:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0A6580DD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952386;
	bh=fR2B4PkwjhQ+0Z3x7mbMgchYp5yWpYjfWbD2NGusNAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMGmMp9Zf5c2d3cm4HiGoHGrwb9U8AX+YgqvNbFXCUjmqzpU1AXF8/M5i/FAu6aU7
	 aSGZh/TV0qpIpfesYT18CsR59t8UXaemAiThclbRqikJM0wg8AE99DDOB3WDt1NXL9
	 t0HMUhmyXvhWtWY9y7hKGrsM9o7Jowx37yoKnBwkEEaEiMTba3T7cqRBnNee3U6T/U
	 JEO3g6ITsI0+34d5g90FkR9aZ93NFEMRPlAAELWzwKwpJspdnEi588WMPwZwrq2KeS
	 /V8Cpf/USN2ovb814c78pd5Jq3pQLBzS92zn8/cBmkY+hWy+5xpsvNCwOIDRCx8ryN
	 +tytwawM6UoPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0A6580DD4;
	Wed,  5 Aug 2026 17:53:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4EC0397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6C7B607D2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtZSSKZWV_IF for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:53:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B70CB607D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B70CB607D7
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B70CB607D7
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:53:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376cf5694ca629d62bc3b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 21/30] sysreset: rockchip: Implement get_status() ops
Date: Wed,  5 Aug 2026 17:44:52 +0000
Message-ID: <20260805174509.2968252-22-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952380; bh=fR2B4PkwjhQ+0Z3x7mbMgchYp5yWpYjfWbD2NGusNAQ=;
 b=Ys/OxFnjwbwe7paAVFNPdG4YLl1Z8QtwEL6nwQBaD4zSEbrqHVMHzbOX6SCNGPUM7NbKJTt4T
 gFSKvpQoKrAHDl0pxIcHaWQzFz6sdfh2d3YZ3cDMtCfmqAlb9BO3Cc7cHnvPvkGLNnNwPQ2b5jg
 qmT6xIh8gQ11rMn0muVfa1KDPhIJ4MVw5ei5Is3NjlYi5LmmEDIqSg7fz4Yz+8Br/ikrfFYUNyZ
 Hg4BbtpoqxUd4nSi5F6rdFpDr2fYrpCOppkGP7MQLAmEotJrklU2YJXP6wMqdU4WhfGC0R7Aj9K
 SeEdtSfySkXa7tjfmVdZ5edDBW62QDcxp1xKGEGV98wA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Ys/OxFnj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Implement the sysreset get_status() ops and return same value as the
existing get_reset_cause() helper used for DISPLAY_CPUINFO. Only include
the ops in U-Boot proper to avoid increasing code size for xPL builds.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/sysreset/sysreset_rockchip.c | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
index 27ba4ee0667c..4b10d6bb762e 100644
--- a/drivers/sysreset/sysreset_rockchip.c
+++ b/drivers/sysreset/sysreset_rockchip.c
@@ -11,8 +11,19 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
 struct sysreset_reg {
 	unsigned long cru_base;
+	unsigned int glb_rst_st;
 	unsigned int glb_srst_fst;
 	unsigned int glb_srst_snd;
 };
@@ -38,8 +49,48 @@ static int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return -EINPROGRESS;
 }
 
+static const char __maybe_unused *rockchip_sysreset_get_cause(u32 data)
+{
+	if (data == GLB_POR_RST)
+		return "POR";
+	else if (data & (FST_GLB_RST_ST | SND_GLB_RST_ST))
+		return "RST";
+	else if (data & (FST_GLB_TSADC_RST_ST | SND_GLB_TSADC_RST_ST))
+		return "THERMAL";
+	else if (data & (FST_GLB_WDT_RST_ST | SND_GLB_WDT_RST_ST))
+		return "WDOG";
+	else
+		return NULL;
+}
+
+static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
+						       char *buf, int size)
+{
+	struct sysreset_reg *priv = dev_get_priv(dev);
+	const char *cause;
+	u32 data;
+
+	if (!buf || size <= 0)
+		return -EINVAL;
+
+	if (!priv->cru_base || !priv->glb_rst_st)
+		return -ENOSYS;
+
+	data = readl(priv->cru_base + priv->glb_rst_st);
+	cause = rockchip_sysreset_get_cause(data);
+	if (!cause)
+		return -ENODATA;
+
+	strlcpy(buf, cause, size);
+
+	return 0;
+}
+
 static struct sysreset_ops rockchip_sysreset = {
 	.request	= rockchip_sysreset_request,
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	.get_status	= rockchip_sysreset_get_status,
+#endif
 };
 
 U_BOOT_DRIVER(sysreset_rockchip) = {
@@ -68,6 +119,7 @@ int rockchip_sysreset_bind(struct udevice *pdev,
 		return -ENOMEM;
 
 	priv->cru_base = cru_base;
+	priv->glb_rst_st = glb_rst_st;
 	priv->glb_srst_fst = glb_srst_fst;
 	priv->glb_srst_snd = glb_srst_snd;
 	dev_set_priv(sysreset_dev, priv);
-- 
2.54.0

