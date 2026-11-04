Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77293606A32E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XADv7v68;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=OlQYjIuJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 533D16080C;
	Wed,  4 Nov 2026 09:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aK_vE2qvmNDI; Wed,  4 Nov 2026 09:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4281760768
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785362;
	b=GItC39LkhYzGpMF8a12bOI8rGOfBwJpj1ztl2bnAz9mR48Hl6kU32MDpoo6bYcZhYKTT
	 PzgBKjRRjqz0kpSdkq0Y3Fr0xELVP48eqQJlTLIcd6AT6zXXGaOviKPBVS7W/+hztCFoD
	 C1U1QlrhFq4/W4Z4Wa4PbGnw/fGj82wMh3ZOgvxyNh4Xa2VV2Uv+kBmg4yFaS66dM3M/c
	 Ud74qzHh3VHS18ppdJxISSAek+JiUV7Lst6r211ZIOlYsVRaKpspjxlHtAO2vXLJCnICV
	 A5iejfIGSmyjtm0MEsKkvCX+SoVEPpoqMDeRG2aD4Yv0l4d/Fa0vqRx5YGt7Caagj1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oWnqQHvxYdVhFhEtyXkEWOFlPg3KyUmFIUtZ14AgIok=;
	b=Mexl5abe3EOwceptttauDsCH+AdYvqmCtjQOjr2xGRHwoWXOJg7eAQJoO0drWTGwHtAa
	 DRGvgvQic+L2eSVBukkrbu1x7fxa/0CRu/+SfQc9PYFBjx6PTJg2TCVw+3l24aWu+mXzN
	 cTdUzydmOG9KTOc0bDFMWJD5QlhL8/kPW3fi7QfwyGiD1nZzlmJrKiyC7EK02V8L/HC0h
	 R7F9dCt8CQGPkpR0sex3PtJR1UMbzGqtzKRuoGx/e9RtVu3EsbOGjTdr+F5JoTZgTvSc7
	 PcQoO/thqO03ou7PX3C6f322kLIVeTIrA+dIeHKku/bzGTTkTqpa09xTY9hTtZhhhjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785362;
	bh=oWnqQHvxYdVhFhEtyXkEWOFlPg3KyUmFIUtZ14AgIok=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XADv7v68TcnqVPVo8fly1hKyvqvFZqgQGPjqRQkHOp7frXMz/3Njx4+UleWS4JaaW
	 MDZMBy2J9uG3/NQqwxwE6uSMSK6haJWNZPRhH9DlALqjOITkRHZhZsGP8T4FaDL/xH
	 TzoRyFOxYuzIQr1cni+bu3CJoyv1F/FS2P9ki4bo9quAuvile6Eg7it/v91dcB/H9a
	 KHqGiy/owgjoQ6q7kMf8jVcOuR/qQlrYvEP2/7XBXpgENT38X7d2Mh6XVoRuL0M1jO
	 WkKdaBl044ctLyIsh7SXu37pFsytDS8tY5tX8nNRz/y5od0Kqhx251Cy8RjD4gfXn/
	 ymR3LDjiMxeQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4281760768;
	Wed,  4 Nov 2026 09:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A872A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0033840535
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7Foyge6j9YO for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:42:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5590C40520
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:aa9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785359;
 b=VR9YmCDInQHuv/MPNwgvDvhbLVkQdfHe3GSLNcZa5TwCspF99aQv0lly261yTssTjqwN
 WkDas9VatzCJmS2K+jeU+mt/RSaOYV4mnhDco/WJ2XPd3YwUPTHo1rflpKuU9NN4q54fz
 nH4chnLnxmF2syxmjqd22zqSdUMwZGo+AyAEbb0mY0P4e8MrzhwQy9vAW4WYlYDVs8Hf4
 kx6+d5xIvn8vagVASLl9XuffWocJYVBSeVi0o0AjhGCCPtGLl0yoADMIJwwgRbGBC3xUq
 YlLDN1JFCxBVgjY7Ifa5ITPXJwxNo2wW6F0pF/soUjyeZeZoM4/W5hiKsmbxKHpbzFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785359;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:
 Subject:Date:Message-Id:Mime-Version:X-Mailer:Content-Type;
 bh=oWnqQHvxYdVhFhEtyXkEWOFlPg3KyUmFIUtZ14AgIok=;
 b=Q/KVt5Hqlku6ghUg5sxfqZUWF+QLF+kuCURSF9a2TWFLq9Hq48Z7uS76UccCIuhF10n4
 uw1SEmEibBBUml3d8U++VDtLPbavKzNyIr7+tbG9cO+g6ygAjpvocTItu21dR0tfSbgfM
 GG+DHFn3UETyKCGSU1n0hwbVPbbwE6DKZIhbY3L1VuaLiTl89RNRuEH1KZnkUvw93yGEK
 4of8oaCtqDkZz54nHqp22ThIvIXTXL095tW62hbDfSDzb8Fxbd3OBw14qEm/P8H5bRQPk
 oOKk50ifduDsN+Mlu5C6ufh6OHQzP+Yh3aR0PBRFbxaQ/SQT8BJepwSGzgJLWYXryFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=email.cz;
 dkim=pass header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=OlQYjIuJ; 
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:aa9"
X-Greylist: delayed 194 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 04 Nov 2026 09:42:38 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=OlQYjIuJ
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:64:8a00::1000:aa9; helo=mxe-2-aa9.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Received: from mxe-2-aa9.seznam.cz (mxe-2-aa9.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:aa9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5590C40520
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:42:37 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-7898c4c7fb-rqvr4
 (smtpc-mxe-7898c4c7fb-rqvr4 [2a02:598:64:8a00::1000:aa9])
 id 2ae1f326d415418c2a6f7d3e; Wed, 04 Nov 2026 10:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1793785355; bh=oWnqQHvxYdVhFhEtyXkEWOFlPg3KyUmFIUtZ14AgIok=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type;
 b=OlQYjIuJDCl6ybtRnkf4Uv5ropvx1mZSmNZMjiLwQ306Mj5TLhHTU9uDoFNhZzt6L
 L/OqfSOPZBOYmT+NN/HqDoxAV//xxExFoXK58c++Q4W65fxL+RtXXRzkqOD1QI1NYJ
 6ECfXc9oUoqJy1tWzcR7YFIfp9wIfynXZP5eq14tTXit8Gn4AKhvlJVCBRCBeM63aA
 CmMoKD8qvOaYXtp+SkCzAATaJRPeEExX9A8nylKkLP1qyE4+0Rt8wWuFmZUB2r3Q88
 Mzy7LNy2l8dp9jX5qgsAcjgdF9L373tCM7HXLoBUHzOR8Mhrmaau7Vy7lTWC2w9b62
 TU8neARPcmSzw==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Wed, 04 Nov 2026 10:39:14 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: <jerome.forissier@arm.com>, <sbabic@nabladev.com>, <festevam@gmail.com>,
 <uboot-imx@nxp.com>, <ye.li@nxp.com>, <peng.fan@nxp.com>,
 <trini@konsulko.com>
Subject: [PATCH] net: fec_mxc: fix double free of shared MDIO bus
Date: Wed, 04 Nov 2026 10:39:14 +0100 (CET)
Message-Id: <54G.ZqHm.6kfJQ4BsLim.1gwlr2@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: multipart/mixed;
 boundary="=_4b6b02d860e2d60939250fd4=4f14b361-f809-5f09-b801-0092c824b79c_="
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=_4b6b02d860e2d60939250fd4=4f14b361-f809-5f09-b801-0092c824b79c_=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64


--=_4b6b02d860e2d60939250fd4=4f14b361-f809-5f09-b801-0092c824b79c_=
Content-Type: text/x-diff;
	name="0001-net-fec_mxc-fix-double-free-of-shared-MDIO-bus.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	size=1717;
	filename="0001-net-fec_mxc-fix-double-free-of-shared-MDIO-bus.patch"

When two FEC instances share one MDIO bus without DM_MDIO, the bus=0A=
is allocated by the instance which owns the MDIO pins and the other=0A=
instance gets it from the eth-phy uclass. However, both instances=0A=
unregister and free the bus in fecmxc_remove(), which results in=0A=
a double free when all devices are removed before booting the OS.=0A=
=0A=
Fix it by remembering whether the instance allocated the bus itself=0A=
and free the bus only in that case.=0A=
=0A=
Fixes: 6a895d039ba7 ("net: Update eQos driver and FEC driver to use eth ph=
y interfaces")=0A=
Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>=0A=
---=0A=
 drivers/net/fec_mxc.c | 9 +++++++--=0A=
 drivers/net/fec_mxc.h | 1 +=0A=
 2 files changed, 8 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c=0A=
index 3d32bad0831..fdd304b67de 100644=0A=
--- a/drivers/net/fec_mxc.c=0A=
+++ b/drivers/net/fec_mxc.c=0A=
@@ -1430,6 +1430,9 @@ static int fecmxc_probe(struct udevice *dev)=0A=
 	if (ret)=0A=
 		goto err_phy;=0A=
 =0A=
+	/* only the instance which allocated a shared bus may free it */=0A=
+	priv->bus_owner =3D !dm_mii_bus;=0A=
+=0A=
 	return 0;=0A=
 =0A=
 err_phy:=0A=
@@ -1455,8 +1458,10 @@ static int fecmxc_remove(struct udevice *dev)=0A=
 		device_unbind(priv->mdio_bus);=0A=
 	}=0A=
 #else=0A=
-	mdio_unregister(priv->bus);=0A=
-	mdio_free(priv->bus);=0A=
+	if (priv->bus_owner) {=0A=
+		mdio_unregister(priv->bus);=0A=
+		mdio_free(priv->bus);=0A=
+	}=0A=
 #endif=0A=
 =0A=
 #ifdef CONFIG_DM_REGULATOR=0A=
diff --git a/drivers/net/fec_mxc.h b/drivers/net/fec_mxc.h=0A=
index 8e95b539cd6..c4f63418f71 100644=0A=
--- a/drivers/net/fec_mxc.h=0A=
+++ b/drivers/net/fec_mxc.h=0A=
@@ -248,6 +248,7 @@ struct fec_priv {=0A=
 	uint8_t *tdb_ptr;=0A=
 	int dev_id;=0A=
 	struct mii_dev *bus;=0A=
+	bool bus_owner;=0A=
 #ifdef CONFIG_PHYLIB=0A=
 	struct phy_device *phydev;=0A=
 	ofnode phy_of_node;=0A=
-- =0A=
2.43.0=0A=
=0A=

--=_4b6b02d860e2d60939250fd4=4f14b361-f809-5f09-b801-0092c824b79c_=--

