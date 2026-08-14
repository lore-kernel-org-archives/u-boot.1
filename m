Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEFFC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1341C40D9A;
	Fri, 14 Aug 2026 13:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AAyQ1CR33wDp; Fri, 14 Aug 2026 13:53:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED87C40D88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715628;
	bh=Ifg/jXrczQjmdUxeAnGZfZ28rmsDTpKp9rMn3dwnfSY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Js1/eOgM1rM5hlp2mAbDbf4ypzf9hdzhqk47c32Ks//Sw6c1/lUtIAB5EDyorVpZ3
	 u1lvo8mLDLz9dSbsVPNdthkYoA7kH4TYoh0ggtXNTOs3BzGtipW8V1jEtllY5VHAT4
	 9XTq3N7AiuQORQbupOHHFXln90D61B91wXxZz8VKTTF/uq3EaIjEyuXaJIU4Gsgmbb
	 XEyhH3Db5pG9bC2YWUMVkR9ql4t0tMx/IVgwSZQ4yVuK0s8VVx4cT21F6t4uwxq9Zc
	 QV/HSyaR7CbuN5f3XgkURJAtxIyZq1RQCCHix1Rr35gnEJR4+VS4ZWR7vRCg6pY/cC
	 /Amw10JVzsZ5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED87C40D88;
	Fri, 14 Aug 2026 13:53:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5910139B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A056740C55
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3sYTS6chEYpw for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:42:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+ok563595.gmail.com@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E281D40D66
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E281D40D66
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ndqjodda
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E281D40D66
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:42:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 26BA960254;
 Fri, 14 Aug 2026 13:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D00B4C2BCB3;
 Fri, 14 Aug 2026 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786714976;
 bh=pRiTPnmxBpWi6l9SfxuxCRVE+bjLNIVTt5/D8cRHv74=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ndqjoddamf1ln+aS5Mgnc8W0snIfZ4D+Q9QRj9Yp5lOUSFkUU4IA9GlLnt3fR5JZB
 yefhim6BYaDfA4WE8iNZHcvvRbLFj4LHn6YLHhQ2jrUraoryTyRllMLWN9XwZF6Ct9
 F07rMdXNZU2eQM57v4E9ZDykkgFB64a9iV8cdlgdrJ4rYm2bh7qIBqtKTQurcMcNnZ
 JgKG1NVpsSXXKK1AK3sHw+w0Xaq2OfCOTfuRXFt9C10BLoq/ycU9OxbebWKYugFET1
 qFOykDhSmLi5xWtazif2XDfklxWVazZ+Eht9/TpF2ARKzpDREZblTWTmUPsHOomWIt
 1cK058CcdwQZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id ADB40C5CFC1;
 Fri, 14 Aug 2026 13:42:56 +0000 (UTC)
From: Oleg Kombarov via B4 Relay <devnull+ok563595.gmail.com@kernel.org>
Date: Fri, 14 Aug 2026 20:42:55 +0700
Subject: [PATCH] pci: pcie_dw_rockchip: add PCIe reset configuration delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-pci-rockchip-perst-delay-v1-1-dde1904d9b87@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm3CDEbAqxgWQylQNTBpgWgId
 3fU5Vv8v4OxChtcsx2UNzGZpwR3yoDGMA2M0iWDz/0lr9wZIwnqTA8aJWJktQU7foY31nXliyK
 Urm8dpDwq9/L6rW/N37a2d6bl+4Pj+AACBS1LfAAAAA==
X-Change-ID: 20260814-pci-rockchip-perst-delay-998233a71fb1
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>, 
 Oleg Kombarov <ok563595@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786714975; l=2135;
 i=ok563595@gmail.com; s=20260814; h=from:subject:message-id;
 bh=74wBb9m2GnuOkRHqU23/NIffQe3sJ6lsA4lNCCBSlvQ=;
 b=X4FxivtvX9HcEVsz7UYEeN44WQ0HFLggRa3fil3mraHUKXjLxs8mZf3oC+ZvbnbWNWk6VysXs
 U7DsQT9+Za4C8tvhTcijYTOG1tNJJxeOdQ0wnT4cFAZAgddXQSrudlz
X-Developer-Key: i=ok563595@gmail.com; a=ed25519;
 pk=BkA5Dnbry6YAJS4cn/HnsXFv/FmHKxoQUkfowiJxipI=
X-Endpoint-Received: by B4 Relay for ok563595@gmail.com/20260814 with
 auth_id=949
X-Original-From: Oleg Kombarov <ok563595@gmail.com>
X-Mailman-Approved-At: Fri, 14 Aug 2026 13:53:45 +0000
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
Reply-To: ok563595@gmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Oleg Kombarov <ok563595@gmail.com>

PCIe r6.0 sec 6.6.1 requires a 100 ms delay before the first
Configuration Request.

For ports supporting up to 5.0 GT/s, the delay is measured from
the end of Conventional Reset. For faster ports, it is measured
from the end of Link Training.

The Rockchip DesignWare PCIe driver currently deasserts PERST# and
proceeds after Link Training without guaranteeing these delays.
A fast-training endpoint may therefore receive its first
Configuration Request too early.

Apply the required delay according to the maximum supported link
speed.

This fixes PCIe enumeration of a MAXIO MAP1202 NVMe device on an
Orange Pi 5 (RK3588S), where enumeration was timing-sensitive and
could hang without the additional delay.

Signed-off-by: Oleg Kombarov <ok563595@gmail.com>
---
 drivers/pci/pcie_dw_rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 61117fa95e6..322b0be9771 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -267,6 +267,14 @@ static int rk_pcie_link_up(struct rk_pcie *priv)
 	mdelay(100);
 	if (dm_gpio_is_valid(&priv->rst_gpio))
 		dm_gpio_set_value(&priv->rst_gpio, 1);
+	/*
+	 * PCIe r6.0 sec 6.6.1 requires a 100 ms delay before the first
+	 * Configuration Request. For ports supporting up to 5.0 GT/s, measure
+	 * the delay from the end of Conventional Reset. For faster ports,
+	 * measure it from the end of Link Training.
+	 */
+	if (priv->gen <= LINK_SPEED_GEN_2)
+		mdelay(100);
 
 	/* Check if the link is up or not */
 	for (retries = 0; retries < 10; retries++) {
@@ -282,6 +290,9 @@ static int rk_pcie_link_up(struct rk_pcie *priv)
 		return -EIO;
 	}
 
+	if (priv->gen > LINK_SPEED_GEN_2)
+		mdelay(100);
+
 	dev_info(priv->dw.dev, "PCIe Link up, LTSSM is 0x%x\n",
 		 rk_pcie_readl_apb(priv, PCIE_CLIENT_LTSSM_STATUS));
 	rk_pcie_debug_dump(priv);

---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260814-pci-rockchip-perst-delay-998233a71fb1

Best regards,
--  
Oleg Kombarov <ok563595@gmail.com>


