Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58769C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B2C8216C;
	Mon, 28 Apr 2025 12:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RNUJ8tfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24288216C; Mon, 28 Apr 2025 12:00:04 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44C480EE5
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so43717205e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745834401; x=1746439201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SaLYNFhTlW/gDh3+v5EsdSgENpa7+7sLxpGwYcbY6K8=;
 b=RNUJ8tfJOd9oxC0KDqAPnDSZd2juSyzmYwgcUwIBnwZnVlcoVf98Oz7ALGCGKq9DZL
 tZPR+00XwuJuCB5Cp7PAXwNPQeQECmb3ItAaWSmMDtIuSEk2bGe/s4cEeT9YlGDnZUrv
 VXTA56TWrmUFu39xlJh4XMZg9relpdXrCwxNZx7axg9MWeedultAVWYT8a4im7qSRbGc
 hNQu7ZmmckEtZL8mll3DdfkTM4mOJe+jV/Hb8W8RrnL9wekI9+pvpqAwTCCHiRvEntvu
 XaiVoJwI5N1bM63+IE4azMg4hBjC0tbnJLbT+dVBiRYbjZU3/0M/bVsH5g+t3Y1abcZ4
 vHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745834401; x=1746439201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaLYNFhTlW/gDh3+v5EsdSgENpa7+7sLxpGwYcbY6K8=;
 b=XZQ7DFDUUzNkiBrhpQLL+8pwaSkcRwzMrFp0Qgm24nVHHPUjS8DFqnWB93sjeq3Krh
 9nfOKZeD1FDr9XxlNqn1r35AEAhR+OXr90zp7N8Sje/kjqXpdqfShbvOQ+6ZfY1TYOYN
 IQw046ay9Jj0iSFgDUjRMBmVCJ3iptiR59bKy9+R/pQW5V+utgIWGw3evpjvew/u2DVe
 JaMz9PfOXjZOBWDpT/paF6mgzIk8dBIjlRyNlVu8Qk+bLYqQi1vXmirjqXT1VpRCg1Wh
 8g790Uwf0UF6c22Dp/9AiUreVEcEl1+FdSktPxXgrLkOgkMrMTFYDQOsGvV7P42E8UmD
 X/SQ==
X-Gm-Message-State: AOJu0Yx9XQPJRAd8Di/77ftfdBXg+LRg8XBz1WcRlk6kFXZaEFRcZyKw
 MQu+/G73fq3rwBY2GK29ukqHiJtUI515n1PHrh0Zbe9jeBMMPOeAJyNGx2Hd
X-Gm-Gg: ASbGncv1DrtqcjV/6UaMv4vX+FLySBVX6J6CXACyhLynbdsW+PGay5B/g6PpwUP8DoC
 KdD+9BiWnrNI20H9twDexrZ/RQD7wvDdGie8cAuWZW1qPIs4Fs89T8xrpXs0nlwdygvHi3zkovp
 ypaDJyOSw2nc2rScMZ7rt5zKGdmHAmrNJ/WbyzjLAuPeyvV/U85tFBMJuLR7h8ccNCjPVvoHNmM
 K3QRPm3wqDzc8mEg1Kwyw1AwnYnAqfVTP6ZryyZFNFo5wYwkDL9glrkNsNHdMMz3o9MTNO3besk
 F43tcNjAuy6d7Fj0+e2uZxjabJEJDeZ28f5NpTy+0OMVmqLSL0d1RNJbbg==
X-Google-Smtp-Source: AGHT+IHDvMpgdS7iBJ6qIfJalywqp4kXRib0F8WgTuTa8DjSfe94J8X9IoRzMhI7itISCPYvv9/BdQ==
X-Received: by 2002:a05:600c:b8f:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-440a65ba234mr82559545e9.1.1745834400499; 
 Mon, 28 Apr 2025 03:00:00 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e351sm10425267f8f.100.2025.04.28.02.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:59:59 -0700 (PDT)
From: Heiko Thiery <heiko.thiery@gmail.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Walle <mwalle@kernel.org>,
 Thomas Schaefer <thomas.schaefer@kontron.com>,
 Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH] net: fsl_enetc: fix imdio register calculation
Date: Mon, 28 Apr 2025 11:59:46 +0200
Message-Id: <20250428095945.1432389-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Thomas Schaefer <thomas.schaefer@kontron.com>

With commit cc4e8af2c552, fsl_enetc register accessors have been split to
handle different register offsets on different SoCs. However, for
internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was fixed
without adding the SoC specific MAC register offset.

As a result, the network support for the Kontron SMARC-sAL28 and
probably other boards based on the LS1028A CPU is broken.

Add the SoC specific MAC register offset to calculation of imdio.priv to
fix this.

Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

---

But the question that now arises is, does this code path work on the imx
SoCs as well. Now the imx specific offset 0x5000 is added here and was not
used before.

Can someone please test this on an imx9 and confirm?

 drivers/net/fsl_enetc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 52fa820f51..97cccda451 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice *dev)
 /* Apply protocol specific configuration to MAC, serdes as needed */
 static void enetc_start_pcs(struct udevice *dev)
 {
+	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
 	struct enetc_priv *priv = dev_get_priv(dev);
 
 	/* register internal MDIO for debug purposes */
 	if (enetc_read_pcapr_mdio(dev)) {
 		priv->imdio.read = enetc_mdio_read;
 		priv->imdio.write = enetc_mdio_write;
-		priv->imdio.priv = priv->port_regs + ENETC_PM_IMDIO_BASE;
+		priv->imdio.priv = priv->port_regs + data->reg_offset_mac +
+		                   ENETC_PM_IMDIO_BASE;
 		strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
 		if (!miiphy_get_dev_by_name(priv->imdio.name))
 			mdio_register(&priv->imdio);
-- 
2.20.1

