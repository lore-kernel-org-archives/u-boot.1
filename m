Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65708C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113C688BD5;
	Fri,  9 Aug 2024 10:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="DwUQfPj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210D588BD4; Fri,  9 Aug 2024 10:59:25 +0200 (CEST)
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5B388BD2
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193941; bh=GGp6lDsL5HZnr89c7oiE1uohsiXZBF1NeedqwU/05wA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DwUQfPj4uJl2lE55dPf/DwrEISaR774t3/OQq8US4p1eHfUiaPGoBovHRfL54LjGP
 m4wXE/QS/a0X+cZEJA+Ikt58kfqUXnV4/4ROaOnMS8OV6gKHB6I9o5b7YAZRDnv1da
 Tbsns1k7PqpWzXkmSAoEXT2MX9okUdebKrNCWQBg=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193937top6znw9c
Message-ID: <tencent_530296729B25FF3F25431C450033C6E75F08@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u6Rs4khUCgzQ6UIksu3Bn6kjAN/Sy1dHhloq1QsTCOgJhSMRrtb
 KUk3TpuurHc2K05T5I7x/ytGk3clEOn0Yp2akxb98bMbH4LlLifszyKeRPXFouI3a7mo/E2O+GT7
 sdbWN/R6G8QqyZIz4S0YW1gkG24wFmeer6QMXI96I3dEo3pdC8pAd9LE+3nD096QaXI8mBlNChDc
 ski96/s5IuAP+yig5bmpntapkiwu4mzrybA8WI278dCIw36K3egsjFwJckAjhvoj/62yqOAUUrwb
 FgG/s8w3Z9L6cPlM91H2eHUrwuUOCWBqq3mVziIMBACq8m6UDofn/lectV+qcXURs8itdW3oSNcp
 yV2NZxlnzn+O8HT7RGLxRzc40Ye4QUcsIivKLVNcYgfHiQq1eok2EvfhHTNCygTI0l1Rq+1XHmEn
 rU65JBBZwpI/HcO5ow1rEmsZjaWt9Ff1pjan8Q0jLvruesIoiv20DAD7M/PFzhQINQ8KxVg5KcmO
 GL7DiyvJ5TSzCI4B2jwRMwiQhBvBP6wcOtMxCJH3qRxvzfnemUg8Ie8TOU/xS5Jc3L3P+GyEPf32
 JQa5386P7XwQAsVxe9B1qJb4DEyRqgfGkELALJle54E3zC6tR1ny//EQwBVRCVh5LrE2o4cInwSz
 R2znxclwNcrIDYAuTClYFaIqlotzvHyfFyBe2ZlocXqKypewYTlhLwYYFEmyqsXSNDXHJ65e0eom
 gE99XRI2IdQiXxXUDKInRu0s1fh8If9frgdBBmD2TgF4KoJv52EyR4B6A00YzG8LFFmxBUSLFMNY
 K+o/9A7EFo7KZVIAPr0F15E0MjjZsw+1zGBhtlQe//ROflKioD3stihTuZVKzLhUgJj+hn2pGPcu
 vDWMuS1Ga6RCVrcTHm10gf6X0uZzEsSgAhROL6fhTAMyqXbcA6C60VyT62V4a5pO1aFeTiP0f9m8
 hDzp6w1eki/O3BE9hMQSXPnl+5/5+iJ2yd7LaQ6OyQl6J2LcWT3Q+5h2KGAo/zWMc12CkbADHo/t
 FV4Cn+ZEhnTdLday2sq9aIKuvyY2bML8Jo+Dd189YFU8kV9fygEm0HSInf3g2QbKBnYnswpg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 6/8] net: dc2114x: allow users to decide whether to detect the
 tx No Carrier errors
Date: Fri,  9 Aug 2024 16:56:59 +0800
X-OQ-MSGID: <20240809085701.22183-6-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809085701.22183-1-hanyuan-z@qq.com>
References: <20240809085701.22183-1-hanyuan-z@qq.com>
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

Some IP cores of dc2114x or its variants do not comply so well with
the behaviors described by the official document. A packet could be
sent successfully but reported with No Carrier error. Latest drivers
of this IP core have not detect this error anymore.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/Kconfig   | 11 +++++++++++
 drivers/net/dc2114x.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 41b7c66105..d79d8ad9c4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -748,6 +748,17 @@ config TULIP_SUPPORT_NON_PCI
 	  Say Y to this and you can run this driver on platforms that do not
 	  have PCI controllers.
 
+config TULIP_IGNORE_TX_NO_CARRIER
+	bool "Ignore tx no carrier error"
+	depends on TULIP
+	default n
+	help
+	  Some IP cores of dc2114x or its variants do not comply so well with
+	  the behaviors described by the official document. A packet could be
+	  sent successfully but reported with No Carrier error. Latest drivers
+	  of this IP core do not detect this error anymore. Say Y to this could
+	  disable handling of this error.
+
 config XILINX_AXIEMAC
 	select PHYLIB
 	select MII
diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 8a285742a1..dc28712221 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -371,7 +371,9 @@ static int dc21x4x_send_common(struct dc2114x_priv *priv, void *packet, int leng
 
 	if (le32_to_cpu(priv->tx_ring[priv->tx_new].status) & TD_ES) {
 		priv->tx_ring[priv->tx_new].status = 0x0;
+#if !CONFIG_IS_ENABLED(TULIP_IGNORE_TX_NO_CARRIER)
 		goto done;
+#endif
 	}
 
 	status = length;
-- 
2.39.2

