Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB3606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t0LlGXQ5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TylIhB7w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FF66606D9;
	Tue,  3 Nov 2026 18:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMTVR0rkYXRU; Tue,  3 Nov 2026 18:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2ADE2606DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793729311;
	b=D8feG5UTfpwfrEkbcLyXwXJWoEXHf3i+I33xPQbiHWxOxgROAoBbyD9whUNwmSKVw6Jo
	 uYfPlcTapBt6/uWUww0mN7vyt98XNm7n24JoX6DfSFotBLbaOyaB6kLAjy1nKjgrRprO4
	 JaWYr/hWaYaASF4SAimCEVU3CiiZj/UkOijFihSlO8Q/E3xJ5ioeRMr0QExc5xoWwNWXb
	 LhPLCDY3gJs/VPOrpxU61LjgUyHqnYo4BdfxP9TzX7VE1Eb8MC3co8HFaaBrOAMz3yEcg
	 9jKFu4NahZ5vKaKq7N6LNSPbTTimf4BwgOGsXQBshHIesx8ZtjSdGJdtbZrIlVjaBFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wb/vqyYzICLLVpYOsEN3dZINCUj5WB9IoRreIPiC0/A=;
	b=KRf0MT0b3gxG/6wxGg/0JuzMKE6xCTxbQcDJo5McGtLrg1JIwu4cH/x3UMMHLB7qaG0u
	 I/0AD7ETooo6k0KFFMBIdDsY1cMqV1bymysbDaq60y4CfRJ4gI4IO13baZXH414YPJsJ/
	 5sWhnrVguzyF4v9wijByM4bSUOJkAVnuItDSMu3t/+ql9ZUe89UaEUjgk53ax8zcdqOTg
	 DeA8LnGRX6R6N9GQnOeR3FVqhyu5WjX/FyifFc/FwZRxd4+oCeGwgqvmQ5Q2rbHagUHkF
	 R4JNqt/k7/ftjW3WiUcAb02JcgYy5PS6sTqDnNyPcP96JkdHOAq0WUM5YUDaHzFhBnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TylIhB7w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793729311;
	bh=wb/vqyYzICLLVpYOsEN3dZINCUj5WB9IoRreIPiC0/A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t0LlGXQ5Vy7+7tcvMpmBDLeNluuYS6gKpK1dyEMjDN03t+AUhWo19xoTcRInix1U2
	 UqV7a64pq3cBFOhkjkmq8m+vXTl2iUw9HDrtJb0BO2R6VcdpG9E15abVTyVuNdXldx
	 LIvhSiASy9pe+rrOznzssUnInyNAbIzBUT3kJolYyTN9ExXTi+HyAxc1chjG/OmBEN
	 aTcZ3hxgJyxlr7hpe/6gUkBkx4Qj7Sk9VWUA1pOyD8L79lnS4NGwu5h2qkADf411CF
	 Iv+IWiRpGEIhUXDvhvE0LT4INJvFFfm2VWHl4zyXqbJfyZjXkwEfM65m3ZRU34Q9n6
	 QPJ6OhEBl6rPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ADE2606DA;
	Tue,  3 Nov 2026 18:08:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E3B7784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 043AB606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqeFnXIGHDIT for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E4BE60611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793729036;
 b=eJVQoFUJllc39V3lzfDpUdra//9pS9tC/qsjIIqtzRNPBTREFB2fASy/OKUi7c+Bs1aW
 f7VLor6Fn9vmgk+8mZPum/RPpQZ1ul8HLeKLTEnrnxYUFqV5Z//4M+GrvrFI2o/GyzCEb
 PEXNwhHBomaaRVP/0tbb1fOC8UVKYwW9fzhaNQUWOWxi60C7IDR5WUShdPTThLlGeDRrd
 Xu7AV5DWZ16uv1RKMPXx9Ys3ExEm1L6nhmj+wU5G5K7J2F/OOQM+L4ang4M9kVdLxRMwk
 15cpKmpB8+606rppe2IuXbjIL2qjsdXoFQribXXmQkrvw6XLpNh/FNbXB3dO08cTurA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793729036;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=wb/vqyYzICLLVpYOsEN3dZINCUj5WB9IoRreIPiC0/A=;
 b=BzagNwfDU1WXJ9aY4OxXqTJdml/N2eqa57h9e8SSXK58yUPTYjHNCvTLVSQK/SGcsaWe
 8NICdEnAyJyksL0te4bRjOTlZxKrKn4BaW71iJrnlNMUBIapropwX9U3gClikzeLSJLEe
 4dUd9Mc35FOFE2OUCGuVuwTQreY8sSUo+wb9Bn1kBvfuMUukJ9BlI1wypeCmLJv/bXPN2
 4/RObwKLCgwqz91w0EbdQUcLb6JIpqY6oTn6tcdsYQ4aq4pd5nsTf0MZgYxCqFDerU5Cg
 mD5YTKimr8Y3gwKjeAvD8ua6YkktPAn2UGCNwMUrgpYbxL7x6Pg8Qs5EPPdzN2C66MA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=TylIhB7w; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=TylIhB7w
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E4BE60611
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:03:55 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-54465f79af8so33496111cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793729034; x=1794333834;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wb/vqyYzICLLVpYOsEN3dZINCUj5WB9IoRreIPiC0/A=;
 b=TylIhB7wcDSLUTL8YGRzOmgkZe1vN4lcVX0V5+8tKKIZBPbYjG68H1iITdVz+PTMob
 J9Sbn35ysjvUZoFtj3FVbgGIfQKhvnbqfGwZrPwNut42gBgWzUGai+YNSfyDSIYzOkV2
 BmmAZN+fzZ6IBoM2f+BFpPjSyP+5SqTLK18lz332/0vUG4/xSLQs6FHuqdaB5LlsF6QU
 fm6FR+Lc7LB6HgcTfxsY1gestgqgy+uIkiflN4HJJU/e9KnT1xn1AP3QWWVi3XDHO3Vh
 fICXumYMmBVqrpDAoJVRGbV76myCR3/g7/cpLWSiHllKW7xc2ZdJL+drbif6NkRdMnTj
 rqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729034; x=1794333834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wb/vqyYzICLLVpYOsEN3dZINCUj5WB9IoRreIPiC0/A=;
 b=B7eaPhFduaChmkBAO7aLYGe4ODkOv1vUISs/hh3zJU/qCqtbsFEmL/DVDSVxlojnLt
 5OX4uR36zht39Px6BoEUvvtf5wVkHvY4a1fvodd4KwhfSjvfW+I4Bml89/dukuE/pZmL
 hnvEP11Vr/kBArsjvLP2SSx5CWAjS2zany6YX8nu4NPKBn4rSpYwYDH02zV/LkAd8ojS
 6/qup+RoI1tHZ8dgRcd5V/haV7kpNMw4K+HkulwrP5PHKdQ5MscfDVdcf18j80uUN1GO
 K5pW8WkldDlXBjILvO26+QB7ffmn9JLq4MfjJXbVOoGgyejUzL0WVPIz9spKdjpuoOOU
 uLSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1FYqoeIjtX/fXFEt+kCl2lcw/2HyKGTxl5HOgcipbxwob4n5SljD/wg+MOuCVeZRZe3rE2Lo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tS7eQE//YSn4Yi0IK3zG6xMTgBj9M4Ys8bly6facgdMbHAXSQ
 0fOHYDduAxIHHlkMETB9akQOpQQGmVIvZnkjCTKGBzEYGIl/nS+DQhRq
X-Gm-Gg: AYBFou2NtlVTKFe0kWN71gReiprMV3kY6jSWe8PFNDoqlNkN/A45Ch7uY6OF6E1SqBB
 AgNF3DVv2dQCbZC7UD4GmI/wvl06XVspk/zS0LvljVjxskNBkg1PUQqv3OHuD8lblDzK3l1Ncur
 Rovii+s7MlpzFQJFUvIO08hdRDsYhzEf27EczrHSgtjNDYh6/g9xftGJF33/URfJ5x0LtRpB5xo
 ViJc0HR/IySNdrbz84fe9LemCRs/o6rTxkPVucQG2OmAa6cSTv6WB14larO5XJ22cHXqI9yKwfj
 1YCBMuw1801Mc+T8L7RNZbg8u4RS64PquvW6f90T4gUL04PNEt1qX+aQBpYopura7ObGyao6QT6
 wHjECzZIKWXPOIb0zneXDhhOS3Kf4nneMRZPbQaiFh5+cg5QZkBvaR2dIYV7HAOsAAEx1gX5nkl
 c6sGuf2iSUEzjFYQjS+RazszmArW4wApZ0jIlEimhHAXcNEKAfwBMMrzKRyYz3LqSQdI5Q9bPnn
 jRB4vk9eXvVtCMQBSEguUBc+h6fkP7SntJteWj/I/ikJDvr+PaP2WBAacWpxcqlq08+5YQKUC4+
 gH4hQ/fcGaBuz9BFaIrL4dqnsQi+3xcRxVtGV7c6wUxJeZnCb4vGeUW6DyxJBiwken0lNKMYNw=
 =
X-Received: by 2002:ac8:5fd2:0:b0:535:341c:e2c with SMTP id
 d75a77b69052e-542b7145601mr220288931cf.39.1793729034364; 
 Tue, 03 Nov 2026 10:03:54 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b10cd7c12sm1876381cf.26.2026.11.03.10.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:03:53 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sanderson@brivo.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Yao Zi <me@ziyao.cc>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] net: designware: Don't cache the MAC priv in the MDIO bus
 device
Date: Tue,  3 Nov 2026 13:03:48 -0500
Message-ID: <20261103180348.1026425-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:08:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With DM_MDIO, the MDIO bus of the MAC is a child device. Its probe
method sets its own priv to the priv of the MAC, so that dw_mdio_read()
and dw_mdio_write() can reach the MAC registers through the device in
mii_dev->priv. dw_phy_init() probes this child through
dm_eth_phy_connect() when the PHY is on the MAC's own bus.

If designware_eth_probe() then fails, e.g. because no PHY answers at
the address given in the device tree, device_probe() frees the priv of
the MAC (with DM_DEVICE_REMOVE, the default). The MDIO child stays
probed, its mii_dev stays registered, and its priv still points at the
freed memory. Accesses to the bus then use that memory: the "mdio" and
"mii" commands, and another MAC whose PHY is on this bus, as on the
LicheePi 4A. If the MAC is probed again, dm_eth_phy_connect() finds the
MDIO device already active and does not probe it again, so the copy is
not updated to the new priv either.

Look up the priv of the MAC in the MDIO operations on each access
instead of copying it, and return -ENODEV while the MAC has none. Drop
the probe method that made the copy. The legacy, non-DM_MDIO bus keeps
looking up the priv of the MAC device in mii_dev->priv as before.

Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, on th1520_lpi4a and nanopi-r2s-rk3328 (DM_MDIO=y),
socfpga_arria10 (DM_MDIO=n) and arbel_evb (DM_MDIO=n, BITBANGMII=y),
with no new warnings in designware.c at W=1. Not tested at runtime:
there is no designware MAC in sandbox and I have no affected board.

 drivers/net/designware.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 9470804ebd1..5d4ae45ddbe 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -37,9 +37,8 @@
 #include <asm/arch/gmac.h>
 #endif
 
-static int dw_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
+static int __dw_mdio_read(struct dw_eth_dev *priv, int addr, int reg)
 {
-	struct dw_eth_dev *priv = dev_get_priv((struct udevice *)bus->priv);
 	struct eth_mac_regs *mac_p = priv->mac_regs_p;
 	ulong start;
 	u16 miiaddr;
@@ -60,10 +59,8 @@ static int dw_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
 	return -ETIMEDOUT;
 }
 
-static int dw_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
-			u16 val)
+static int __dw_mdio_write(struct dw_eth_dev *priv, int addr, int reg, u16 val)
 {
-	struct dw_eth_dev *priv = dev_get_priv((struct udevice *)bus->priv);
 	struct eth_mac_regs *mac_p = priv->mac_regs_p;
 	ulong start;
 	u16 miiaddr;
@@ -87,6 +84,21 @@ static int dw_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
 	return ret;
 }
 
+static int dw_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
+{
+	struct dw_eth_dev *priv = dev_get_priv((struct udevice *)bus->priv);
+
+	return __dw_mdio_read(priv, addr, reg);
+}
+
+static int dw_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
+			 u16 val)
+{
+	struct dw_eth_dev *priv = dev_get_priv((struct udevice *)bus->priv);
+
+	return __dw_mdio_write(priv, addr, reg, val);
+}
+
 #if CONFIG_IS_ENABLED(DM_GPIO)
 static int __dw_mdio_reset(struct udevice *dev)
 {
@@ -140,26 +152,33 @@ static int dw_bb_mdio_reset(struct mii_dev *bus)
 static int designware_eth_mdio_read(struct udevice *mdio_dev, int addr,
 				    int devad, int reg)
 {
-	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+	/* The MAC has no priv if its probe failed */
+	struct dw_eth_dev *priv = dev_get_priv(mdio_dev->parent);
+
+	if (!priv)
+		return -ENODEV;
 
-	return dw_mdio_read(pdata->mii_bus, addr, devad, reg);
+	return __dw_mdio_read(priv, addr, reg);
 }
 
 static int designware_eth_mdio_write(struct udevice *mdio_dev, int addr,
 				     int devad, int reg, u16 val)
 {
-	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
+	struct dw_eth_dev *priv = dev_get_priv(mdio_dev->parent);
+
+	if (!priv)
+		return -ENODEV;
 
-	return dw_mdio_write(pdata->mii_bus, addr, devad, reg, val);
+	return __dw_mdio_write(priv, addr, reg, val);
 }
 
 #if CONFIG_IS_ENABLED(DM_GPIO)
 int designware_eth_mdio_reset(struct udevice *mdio_dev)
 {
-	struct mdio_perdev_priv *mdio_pdata = dev_get_uclass_priv(mdio_dev);
-	struct udevice *dev = mdio_pdata->mii_bus->priv;
+	if (!dev_get_priv(mdio_dev->parent))
+		return -ENODEV;
 
-	return __dw_mdio_reset(dev->parent);
+	return __dw_mdio_reset(mdio_dev->parent);
 }
 #endif
 
@@ -171,19 +190,10 @@ static __maybe_unused const struct mdio_ops designware_eth_mdio_ops = {
 #endif
 };
 
-static __maybe_unused int designware_eth_mdio_probe(struct udevice *dev)
-{
-	/* Use the priv data of parent */
-	dev_set_priv(dev, dev_get_priv(dev->parent));
-
-	return 0;
-}
-
 #if CONFIG_IS_ENABLED(DM_MDIO)
 U_BOOT_DRIVER(designware_eth_mdio) = {
 	.name = "eth_designware_mdio",
 	.id = UCLASS_MDIO,
-	.probe = designware_eth_mdio_probe,
 	.ops = &designware_eth_mdio_ops,
 	.plat_auto = sizeof(struct mdio_perdev_priv),
 };
-- 
2.43.0

