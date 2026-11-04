Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11973606A338
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y8trIN+D;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Dmj9+54K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4512606EC;
	Wed,  4 Nov 2026 10:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buRcPV1FIQnQ; Wed,  4 Nov 2026 10:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 167226075B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789968;
	b=rGnf+53eENes0mNx0BCDAxUGLSHqehw3VhGYhQLR0ZnTIoUj8c8ayWFGMecdbLqQVNXg
	 s0Xn/jQRvw+AjldW8FiL9kl5NrBVBKabJIJ3TZU9YIIqKnsF8jGxAaF9yEZMDQNK/kC/+
	 OW9L1T3cFdZHa81K13C3hLOG6Nm+6rrUM0B6Qk1vPMUry9umjrDTW7gRdHmWgs31063A0
	 94GpjqBRoya9/7Yj9JpV5uW5C8F/weHD1QcZxeQ+fvWVBpM4G6upl/276soSHg8YJ3I5W
	 ZVl2Ip7qPCLqLiteza4AraXaltO5eXqd5NGSHxNecsBufhJODEGUSo3JtMLLhh9f/Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=akRCKUj4CJ5fDLZFeYlhXFODo3D2Ld+skT1G1QIfJE4=;
	b=ZXBJKfueRnE0Tzz1veQ41oRWInRuZGvhwQHVxLmwFBBb2mYRlpmjwjXL8uE/etMM8o46
	 gH2wXSim5pqXFD0VT7CZqJbmEwd0azNVJcjNDnDzygE/N+4ctZuMDs/GMFf2gnEZOOuJ2
	 p62ifwI/R4ImkpsvbnKaxK3fiaWD+J/Bhs+J3siMgELFGySE4Ddfw6AhTFLDBcszr7Lu2
	 R3VSj4QQHEwGcEywsnukx/lwfp13CS3k4gA0zb87GiNjDUVduZyI7D5iOZ5y0mM72LtBM
	 laMARDnCBpL+OCBRu6Fh0xOOTh0VlQdWTCmQhgTeSySypXJTayZrCrQbfhLdadkyArQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789968;
	bh=akRCKUj4CJ5fDLZFeYlhXFODo3D2Ld+skT1G1QIfJE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y8trIN+DEbLuihoCLhJi8LfTVYxSu5b/fRO08lgKYFandYhtabwx1USkx3Z2H7Vr2
	 2o7yVN5lr1TInshQFWvsJox5yz+E5AbcvS+yIcGFCluGb4YgJuOtXJTtMKPHM1McjY
	 fPlLRXNAPBzsnEuricBKJXVpAxH6QvpBHrR39EilKDBK11+baJIg0S81eNNF+Pbjn9
	 b+LAadOFODEFK4Ue062u7MnNCS0QoaSRbjVDFOFXUl2NSqT53WWdatD41E8Yfziq0f
	 ILD0kxEhYXbvCKxZsBpko9mmy9/37A4t182C0OS+dMmeCDGl3BSrB4e7rv1YX1jmNm
	 pLMWUhBlyn1qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 167226075B;
	Wed,  4 Nov 2026 10:59:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8F5E341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B69E2402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K01N1hZvpHuS for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C2380400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789963;
 b=cQ+vrmO9d/bkWWOESshDa/y1SwUJoSWpz1K75oOOsWIy9t+bZhHjZafirDv3OxfNQ+w6
 txEdZreIxiIbBIO+9esg+IsnTzCDzizvojnAbKDmGL1ML5ZDfq69xig20mzndqTpCa5VM
 5I3ToXIQf++gY2lZrM6+78SFQ/N6WsJDpvs9TM2qVgmEheqtNoH03P9zTa6O2A2/xbm5I
 oER15odd0F0VFJj9DIpj3T5eldmI8RZYve/hBt0XM2bkAzOM0+aSltoBJPzOIIiBcEx0E
 TKbArLtxgSfP5sFIaRlZVHFfaB5k+Rkx5KYJ2x8HjcfMKNzjMsc7aeHF2sW5I3yF27Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=akRCKUj4CJ5fDLZFeYlhXFODo3D2Ld+skT1G1QIfJE4=;
 b=bWMhqFRQRx//1tszG27Yn30HKD5OGOsnJ0CtaV/Ki7/efgI8VL1/BFZy7Vy7Ma89S5gV
 DAQVdJ+icLyqOFncNeXFUxuA8iZaAmnQXsnU6OMyaISxhaDVmyccqJplGYdXNCrSYQ4Hr
 mlTCyYvBYF68rD2EpiSe+kNljyf98EcA5JCxoHuLseTylJcdHsRultshjj8WiVTI6+BT1
 YWVdUYWM+imKOZgd+e0I9Jh7g+BcanFTqfwUJ+pyY8jzjKwO425v1g68qqM6KwY2vR0Wg
 S8OeXpklrXKuDK0+yk9WH1Lqle7Cw8eUHr6PEMdw71/Lp0i2b6vKuPyJKR2NU3oFFaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Dmj9+54K; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Dmj9+54K
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2380400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:22 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so311707f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789960; x=1794394760;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akRCKUj4CJ5fDLZFeYlhXFODo3D2Ld+skT1G1QIfJE4=;
 b=Dmj9+54KThRb+yVm3cRE1yaMDHxzHf9ZFvhH/zv1I/V9b8N6G4GSIRTifOICZOoGHl
 3wACqeHBl+UNPilIyv5J1ADdrsQcOVcZu5hmf1F5IpHvj81kaZFk1wGybOwAXeN/oxw6
 em5UMmi69YGsTO1iCqBAMa2cqk+nJzuTo3ZstCRFrmtVDpUKH8ATYezKbcYCxImGhVf0
 16NaX+uh7VxVI2XWW2DXGo0lJA49gw3BJqweFdhS8t2VGRWMZ9LyX0Sm8O0kX+zUGsQK
 OZyOvHCN/F8zv7rX+Z/bV8Uxn4rJrDrSLE/BiCZn1OhVR+2OR28/O+lF4cNjNwE7ySNR
 lxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789960; x=1794394760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akRCKUj4CJ5fDLZFeYlhXFODo3D2Ld+skT1G1QIfJE4=;
 b=wm8rdq7T00wJSyI3PjYG8wRCicA/jxydJXPxsyReT6s6Ym1sQvVwKxHgf6SdOddd3i
 RdlcX+kOYg3R0RFIgwsokEoSSd3QF6P+zuvSbV2Y3lGTzmgB1InA6buM3Q2Ygnl8iY14
 jnrpnSBJ3Mr3oYonk8CejQGdPXf5Tw6gTRbO/3B/O/WXvPQ3lrFmQk6IOonHJhnSlIsY
 JjXvVSxi8F7fglxu+2I+Df32IBGa6bJCpPii+OonrrULKlIGYd3z7J0uKuImUOUlQV90
 0tnjCwsLJwF2yAz9+9OaGM3BeTo0KOkFXh22FHqt9NlzNTRGFAXb9HZlOVati9jJvY1b
 fi4Q==
X-Gm-Message-State: APuU4Z9Dmt7rRv/jkZ+P/TbGEc1fVc5Xaw8CSb0ERHQtHd2zQ2keAyUk
 fto5px3sZTZBFivDUPard4/ANxCXNm7QRO5C/QPQurBJft2djqhSRribuBqkXdMD8CI=
X-Gm-Gg: AYBFou0+kBXYsIa0sDrPvLHAFAvqeJNmVN2+WfQvUeLH81ULw8fJgF0pRfG58eMmnha
 3N31OMWaeQhLJujl606B+X4I56GDYsE+m5pwnKNDWC+GKhe8gQseg5BvVKNsq5amN1WeKGD9OVN
 bkWsJX+mWCV/10kwo2ku1Gx8viB9ctQkDqlQnQi+XvRdbxQ1LQhbTcyVdYWzoT3QOhYRmxf0AQf
 DU/3XQRz8qQnQshfELKmkhPlix0xHw1x1z8nxLUnzXmU9ur5OV5qSvGJEddWvbPdT9RJ7BVIi7H
 0wbFRvxEe/JDlc5FFMjvmDHCZM2dyjTw5nMJteYnRUVh2PASdzbuKBHllTMSVH/i8TA83YN2nvX
 3/k90sk9nS2Fqy9pISWaF9+cx120EmWDPXBAYVhigYeZMy/T6Y7BPRuDF8Eaule/VJaCve98akI
 6p4xeBPCuh4YoKpgxtL0beNg7mS4H3LJv01oUjXTSJ+wRpVaSOpepkU/2/zoGZqix9GSDYt13pk
 vaHovvQfkFzg2dfwkuUu4U+UPalJZQE/QBjmaU3oxFPshge2wIvlMvb1xSDiafhuv5JvwLCxu/Z
 Ac7dQ0o/GyFb9dVPZnvUZcbBaqC4jte3jC7cJq9ZOWx8YBW0Pw1HsEw=
X-Received: by 2002:a05:6000:144e:b0:48e:850:c0b7 with SMTP id
 ffacd0b85a97d-48e6e27ec17mr34331450f8f.1.1793789960619; 
 Wed, 04 Nov 2026 02:59:20 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:20 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:21 +0100
Subject: [PATCH v4 3/7] dm: core: Add SPL_DM_EVENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-3-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TGtdE+0UiE3xaHBMd9Ilhb/mu7175CsScrgWCeTCITU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/G9z7WJCHrStyZ8gcfDb78LlusHXg6oYU/nvSk6aM
 WuuvWNnx0QWBjEuBksxRZbOxNC0//I7jyUvWrYZZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqh+3MzI8OWHetcMy3IYn3TbfK8+UYXt5n717/gt1Z/6fv7jYe90Y/qcK2Jc3fF7
 YcoZtlanfazUNd8E56Wbhjy9Gy126p838hxcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

K3 SoCs like am625 need to execute a TIFS wait and register unlock
before anything is probed and after the tisci messaging is bound. For
this reason a spy on EVT_DM_POST_INIT_F is needed in SPL. Currently
CONFIG_IS_ENABLED(DM_EVENT) in SPL always evaluates to false.

Add an option to allow DM_EVENT in SPL. Enabling this option leads to
dm_init_and_scan() sending event notifications.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/core/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index ae0c34667723..22b72d6b766c 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -117,6 +117,16 @@ config DM_EVENT
 	  register a 'spy' function that is called when the event occurs. Such
 	  subsystems must select this option.
 
+config SPL_DM_EVENT
+	bool
+	depends on SPL_DM
+	select SPL_EVENT
+	help
+	  This enables support for generating events related to driver model
+	  operations in SPL, such as probing or removing a device. Subsystems
+	  can register a 'spy' function that is called when the event occurs.
+	  Such subsystems must select this option.
+
 config SPL_DM_DEVICE_REMOVE
 	bool "Support device removal in SPL"
 	depends on SPL_DM

-- 
2.56.0

