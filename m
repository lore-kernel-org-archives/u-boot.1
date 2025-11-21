Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E6BCFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C21983AE6;
	Fri, 21 Nov 2025 18:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LndQ3HdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6294483A5A; Fri, 21 Nov 2025 18:38:33 +0100 (CET)
Received: from mx-relay05-hz2.antispameurope.com
 (mx-relay05-hz2.antispameurope.com [83.246.65.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 827C7839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate05-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CVTbikrdv/+h0n9us7amrJA2PKj20HyeKu001JBbd+U=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746710;
 b=sVXCr65hkoHwEDb5s34raIL9VdZ55Zq+HlJnGNOXhhVDLfpBSXkoj9WbyjWxXpZSkbQhSnnW
 YsoXSL53YgGPBP6yop3RNzwJjN+lIWoMGscP7hlSBZG5NaCk+7bWHoKUmZsn3oH3PuxV3LrIcfG
 ue7By23bx/KQTh6afjrQkcB6FhuJCBqXkEmpW7IvnaTtENySGO3lhp6LWdGinQ8M7eQnf267xV4
 QMHTRlDLaIP0O/LC4NRSLH5egbAbU2Hu1jB7kUrqcTxvUniORsHJC7DjmdcBPU3zP5CONbgYzde
 UVh9znjEj8a17R1Txk8gIaOPZnvFfMVCSHwVGBy7Q4MJg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746710;
 b=W7U/PaWUO0/mCCR3iHByveXDHOrJERWbfvKKJxbpPYqSGM65kiZjEhTyQC6dgUtauMAblspP
 D59Mq1aFJ4GYZiRZJgsNNXa6D+2nF6PNkBfajacrsFhSU58jYhPchhDC+D+mH6+2zeBlxMx+6t/
 vYiVYAWcFfmoyznDr3IOFXbai9VcmZqz3KMPW6oUAJTnPlteyS07XuTZEAJxd2RufXmvN+iFcgp
 C/O3Km/e2UlmquaeBcubdXX24aB0ww37sjqrSo4HbmlniM8gUA3oJlKuLhS7KcO8kRUnFqKUWDf
 KmAcdBE/Yx8ew4sI/XnWRvypqwo+pSzxJAK1S+FiZCelQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay05-hz2.antispameurope.com; Fri, 21 Nov 2025 18:38:30 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id A1F35A41128;
 Fri, 21 Nov 2025 18:38:08 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH 8/8] net: fec_mxc.c: improve readability of dm_fec_bind_mdio
Date: Fri, 21 Nov 2025 18:34:48 +0100
Message-Id: <20251121173505.6235-9-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
References: <20251121173505.6235-2-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay05-hz2.antispameurope.com with 4dCj9Y2cJqz1L9vL
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 4cf0f6144a853857ec3d8ef868b76cd3
X-cloud-security: scantime:2.032
DKIM-Signature: a=rsa-sha256;
 bh=CVTbikrdv/+h0n9us7amrJA2PKj20HyeKu001JBbd+U=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746710; v=1;
 b=LndQ3HdQYH3oMDHT6Ra7n195ENqGMMnQIeeM9v3QxUPRS70dYttDqCnvA1olebOTLAv4mx8G
 TH6iQB8Es38sv4HgtSUURVo76HEZcWgGJdD5soWyrEk86JmL6+BETnjcZgMgQ6WbbEXhqM2UoWx
 5QaYligKeGrTmIfeHNba2xuXIedANMT8Ky2A7q6A2zckCTv9UQ6deTALWZLE2iN7zyeeX1bS4mZ
 7pGm1p5Sn1RQg1P5q1uAMxRRnyofO/Hg6bA9G4On4XIYz0pixX4TNnU1E9PC6XjwPNoWetq7ZQU
 Xg7rtllyNG4ULJObOr3jO/GPjii/jCNQCGCxronueO2cA==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The last parameter to device_bind_driver_to_node is optional.
Since the returned information is not used and overwritten by
uclass_get_device_by_ofnode just provide NULL as parameter.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/net/fec_mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index f6ca87cee3a..6f7ca0f8b8b 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1084,7 +1084,7 @@ static int dm_fec_bind_mdio(struct udevice *dev)
 
 		fec_set_dev_name(fec->mdio_name, dev_seq(dev));
 		ret = device_bind_driver_to_node(dev, "fec_mdio",
-						 fec->mdio_name, mdio, &mdiodev);
+						 fec->mdio_name, mdio, NULL);
 		if (ret) {
 			printf("%s bind %s failed: %d\n", __func__, name, ret);
 			break;
-- 
2.34.1

