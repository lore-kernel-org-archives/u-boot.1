Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E724C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A44888BBF;
	Fri,  9 Aug 2024 10:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="kDpdE2vH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763C788BB6; Fri,  9 Aug 2024 10:59:05 +0200 (CEST)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17E788B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193924; bh=4MVJ2w9JCTJjoVdXyK+UfuwK5yATTvXj6aTk1+VOwIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kDpdE2vHM1NyZAqR+2/Td3MnaTrgQe2XEO8KjklIMzCBnlhu9tN1d+BSEhdB2qsT1
 yrK7JuBQn6ISxN0Dai8w+q97M9scwXLZ/LUtAdWrvAKuaWWbB1OBggGfjfVETdx/mm
 sxdhQ92xGPxBq2mdSFRQaqtP3F141NfshyA7hJwg=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193916t2flw4fiy
Message-ID: <tencent_4B92368E75002463D6AF2B4BEA4DEB7FA407@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe7uQJveHYKG/KaJnypOQWX5P9OFOdTrP/SWR03DtEhQ0/oAhrrI
 pnEAWa19NUECFzY8WjkwMiVV/MCwwDsn2++Dw2ZKiZzSEmMZh0Hqyp45L5jn6Pfe5B0pisdH+FCx
 zkc4MzTnQz97OcbBHydB59zT2Y1gd/MjN2U1gFiAC47e7Cs3q88U2rQ1RG91iFjxFFDkBSFMfrku
 N9KcPbwU8gmEdAkdvZWbvUCr/ktEQFG/BUZ/WyGfhggh2xfsqw3cZyQ26EWv8SHWHrSyKaYMVcQ7
 txkGURZgFn3vLuV0yBTbMt5mGsb4xEDlHQTRoc5tzxm9O26A7P4KRKpdGTsE4bdI+/jYMf3kw3gQ
 N3SxXFtvSh6jZukFuY573cfrNjZ/fftabmcAXU6MwVfx1IDMLKHp4aRM69DOHZPDxc1VytGNtugy
 FsirPX8M24+Nfz4Znvrh9mb/akcDX69va3S6lxENRi1GvzKFMMKuEVTemgO8y4yXey8ealOTHlYx
 T0umQJl5Dno5Kqbembroc0R8zuEZSsCGaFtRGMj8hsR/qPpeDf33oC16YQVpmDP7921Oqt3+AB4D
 0fdcaYtKEtKBy6IK9uuLJEber60qJtkaUA3Zc67RdR8O5JDWorf7iz47nQ97QYUGXiIUgggZLtM0
 ThW8MmCjI+xYoXl6Ts03YffTTXjSF53OgRa+QeKflzV6mAoEORoFkdTAinkL2WpctLLon25ciDse
 b+CYh//FggdVWhzibcf6XELKEFVaEigjPV7QszudlOsVbZRp8zG4OOGMR2KRux3nuFo/CXOlvhBL
 D/p3rxFUkBh0GaggIIitkQXpsytgLriBuFgPiaDOc2NR7q9edsTFXHsWUgu45W3DJa15iwyNbie3
 5cjbdxR4SRzhFz4W2fTJpR1EaA5sMKYopx/r72uj3JK9T21B4fRGB4IKeMo3x1C6CEaYmheECPkC
 RwxdyKGFiqFXFuaSzy0PM9UcKG9W2uPnpxmI+VrHnxtqHNEyKYmmqGql/jYfRFE/1iPLbaafk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 2/8] net: dc2114x: get mac address from environment
Date: Fri,  9 Aug 2024 16:56:55 +0800
X-OQ-MSGID: <20240809085701.22183-2-hanyuan-z@qq.com>
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

Let this old driver work like the other newer network card drivers, loading the
MAC address from environment, which could be more flexible to set.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/dc2114x.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 3704d2e655..7f0715429f 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -478,8 +478,16 @@ static int dc2114x_start(struct udevice *dev)
 {
 	struct eth_pdata *plat = dev_get_plat(dev);
 	struct dc2114x_priv *priv = dev_get_priv(dev);
+	int rval;
 
-	memcpy(priv->enetaddr, plat->enetaddr, sizeof(plat->enetaddr));
+	if(!priv->enetaddr) {
+		rval = eth_env_get_enetaddr("ethaddr", priv->enetaddr);
+
+		if (!rval) {
+			printf("dc2114x: Err: please set a valid MAC address\n");
+			return -EINVAL;
+		}
+	}
 
 #if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 	/* Ensure we're not sleeping. */
@@ -574,9 +582,6 @@ static int dc2114x_probe(struct udevice *dev)
 	iobase &= ~0xf;
 
 	debug("dc2114x: DEC 2114x PCI Device @0x%x\n", iobase);
-
-	priv->devno = dev;
-	priv->enetaddr = plat->enetaddr;
 	priv->iobase = (void __iomem *)dm_pci_mem_to_phys(dev, iobase);
 
 	command = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
@@ -589,6 +594,9 @@ static int dc2114x_probe(struct udevice *dev)
 
 	dm_pci_write_config8(dev, PCI_LATENCY_TIMER, 0x60);
 #endif
+
+	priv->devno = dev;
+	priv->enetaddr = plat->enetaddr;
 	return 0;
 }
 
-- 
2.39.2

