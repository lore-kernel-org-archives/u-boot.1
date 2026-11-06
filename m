Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E14606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KUh8hVtU;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=J3A4oFhS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06D19607BB;
	Fri,  6 Nov 2026 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53OKyLmOxS56; Fri,  6 Nov 2026 13:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 55F79607C3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793970007;
	b=sUDmqjSi4ifa7d4umSrBmwa14m/GAleZlK19XFm5dKfrXZ9G6iNNLzfSAxbix3JRDUjy
	 l88NwcFv+vyE6pa7AAixaIz8uqfgkcNpnDiUYxz/GCAr+67V+S0sQ6uyiX+ByJ4pjoNjX
	 KDaNOMEEeyqD07eZ0A2u68/hUcfAdViKGp50ddVUUCPT/PDQxG1YPWuss/SjBMIK8XCFM
	 wWKDcJgE5Jo33kvL2kPuHWPmnkMvLqbQcfXlZtP7PeK6nQjUsIG7VJz2EgH656MTP3b28
	 jE+URXuqh/MJFMcCHZzntqNE5ji/gWlZ8Qdx2Icjv8acLDXJW27c9BADLePyfQC6vHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793970007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W6awl1mjKZjgukThPp9rvcH8mr+V1BKIuwNq8EgzWcM=;
	b=g0efcN+u42x+1MVD5/mKJyRCjIm4RRwMiVm8jBytGLnsg/ZU4cpdGyw8sefT5NoHFIHm
	 G9BhKU82OkVlrUfNUM5Gp6KRxPdD8ZXxDvb9934Pzuvpnua5q8p9TeiT9ZdMwg9qm5FK4
	 YHSMlwnNhj3TU5HB3dHwpA0JcURVxkgZjzksN0EX1CFZocm4gwd7wlp34G7jfuJalellv
	 w8WY4bqhIooZWnnTDojvHyY+eIitARf9P5SXRHaHUlVDk22pHTc7eXMUBXY6b4W+6Ggif
	 ThdJSlc+sYbZYmzMmybPXXOVhce9iEMfLPmLW2HNjBE63Wxxsec2uCXKzoAKZnMqkPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=email.cz;
	dkim=pass header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=J3A4oFhS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793970007;
	bh=W6awl1mjKZjgukThPp9rvcH8mr+V1BKIuwNq8EgzWcM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KUh8hVtUCftQUS8dvuqjdZQLzme9YUnI7m622yrxZleUmOVPUBRjCT6xJ0+9xqBN4
	 v61wtlGHgQJ4ijr7lwBQ9PNOAJNHR252+J9ZsvfSs/nVFw9TkVNLz0PfBNDasAVLQg
	 inhavxw8hx8sgUD8fZY9I0bJcn/ay9QhgyOShSroGSDQiaDXaF6B2NfXVFw2km/V9G
	 i9btJauqQ+ui82TdwnC6BBzIfKOXunEmrhJnSPxpLDaYuCRwN+92XTr1qDpqS5AWkK
	 zPaM3Ct8yMTSFALMwLERf+3aWnIYxQIvrELYrf+9Pqx5+h0f5f2WBBDHqxZNXzGjtc
	 +FRV/r2/Np3XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55F79607C3;
	Fri,  6 Nov 2026 13:00:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 445D331F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35F46607C3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ve1Ysqh4-AA1 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:00:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65819607BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:96:8a00::1200:7b3"
X-Greylist: delayed 175 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 06 Nov 2026 13:00:03 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=J3A4oFhS
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:96:8a00::1200:7b3; helo=mxe-3-7b3.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Received: from mxe-3-7b3.seznam.cz (mxe-3-7b3.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:7b3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65819607BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:00:02 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-54d86748f-pf28g
 (smtpc-mxe-54d86748f-pf28g [2a02:598:96:8a00::1200:7b3])
 id 33550722cda1b58833db893a; Fri, 06 Nov 2026 14:00:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1793970001; bh=W6awl1mjKZjgukThPp9rvcH8mr+V1BKIuwNq8EgzWcM=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=J3A4oFhS4Wz9OcBV+1JcosgYTWbB5y7BjXAVBtwU5gnI+TSxClj/6v5BIip6mH1MF
 aeyv7lBYKUQITLpju3GMQ11gsB/COGMnsMK8EmOM4IqYvfZ0QpXTy2qxGjT4KHq8wu
 gtczmgygSHi4Ro0gfHQhRVvVgVdfZUjxhnxJbT5WOI/Eat4fOFMKY0jP+t05n24M/H
 +3L4yAwYWUOa94sw6kHVPq2lgm8Yii2RPadg8wlVnO7Qk7zZipMMb9mW6slDPCuYHX
 B/ll2XZxuGvYUNSDC14RxJbqvq2kUfoFZYUD9nDhye/g7pOl4QYR0C+N2UEq4E3vik
 abw0Gp/ZJpKhw==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Fri, 06 Nov 2026 13:56:57 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: <jerome.forissier@arm.com>, <sbabic@nabladev.com>, <festevam@gmail.com>,
 <uboot-imx@nxp.com>, <ye.li@nxp.com>, <peng.fan@nxp.com>,
 <trini@konsulko.com>
Subject: [PATCH] net: fec_mxc: fix double free of shared MDIO bus
Date: Fri, 06 Nov 2026 13:56:57 +0100 (CET)
Message-Id: <hs.ZqKw.1dv4GnBQOIK.1gxSwP@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When two FEC instances share one MDIO bus without DM_MDIO, the bus
is allocated by the instance which owns the MDIO pins and the other
instance gets it from the eth-phy uclass. However, both instances
unregister and free the bus in fecmxc_remove(), which results in
a double free when all devices are removed before booting the OS.

Fix it by remembering whether the instance allocated the bus itself
and free the bus only in that case.

Fixes: 6a895d039ba7 ("net: Update eQos driver and FEC driver to use eth ph=
y interfaces")
Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/fec_mxc.c | 9 +++++++--
 drivers/net/fec_mxc.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 3d32bad0831..fdd304b67de 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1430,6 +1430,9 @@ static int fecmxc_probe(struct udevice *dev)
 	if (ret)
 		goto err_phy;
 
+	/* only the instance which allocated a shared bus may free it */
+	priv->bus_owner =3D !dm_mii_bus;
+
 	return 0;
 
 err_phy:
@@ -1455,8 +1458,10 @@ static int fecmxc_remove(struct udevice *dev)
 		device_unbind(priv->mdio_bus);
 	}
 #else
-	mdio_unregister(priv->bus);
-	mdio_free(priv->bus);
+	if (priv->bus_owner) {
+		mdio_unregister(priv->bus);
+		mdio_free(priv->bus);
+	}
 #endif
 
 #ifdef CONFIG_DM_REGULATOR
diff --git a/drivers/net/fec_mxc.h b/drivers/net/fec_mxc.h
index 8e95b539cd6..c4f63418f71 100644
--- a/drivers/net/fec_mxc.h
+++ b/drivers/net/fec_mxc.h
@@ -248,6 +248,7 @@ struct fec_priv {
 	uint8_t *tdb_ptr;
 	int dev_id;
 	struct mii_dev *bus;
+	bool bus_owner;
 #ifdef CONFIG_PHYLIB
 	struct phy_device *phydev;
 	ofnode phy_of_node;
-- 
2.43.0
