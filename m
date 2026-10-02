Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A8CA5FE6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D557C60DD4;
	Fri,  2 Oct 2026 21:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIrMcvW7pmKK; Fri,  2 Oct 2026 21:38:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A512860DD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790977132;
	b=fpu9gsBqlDSKa+tNO5dNBG+3gy8LrrlHQwkb2ascoW9Qi4ogVZ4xjwy3ELYo1XM8w2Z4
	 zMCiPi6jBBmsH20QtAtiryxxdgniWvOVZnAAWqbJ5oBj7t450r7YwAw1J/8e8zsZRHoGb
	 Wy+Y1axoO+zJcsl1SFyTU8jPWp1ZHrb1cjqf3HVMB3OIN/2Ovp6eek+4rbz39dF8EnEVp
	 qH/iAVRTClO+xZggwuTkQ28XOzDMdo4J18m3yBVzA0AXSZtX2M1a+HScMVz4Wtb64T8r1
	 7XtAHWIvpZx5Ym5qdTbmMgweZrmNi0v+gEM6bH7dkypLfUbH94tMPjv/8pLZh9tc9Fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790977132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0nCVZTCSwhZ+fiLx1vJ3qVRUt6LqogkuiR8wVkbxR4E=;
	b=Ljr5ZLC6fuo9zzaqwT58Y1PjZMoLeScEnUGT5+HTbjS+/i4ZAkRWW6OJ6EYaY2T+TJph
	 4qjLdau1HaOYdgty/O9Zq6TncllOEafQUvw7nwrRtsn49ANgLjDc+ZX9jow5yp+ga7muV
	 H+Ah4EsNGK2P4c4TQyP8vLnX5NQtZNzTkwRL4D42ehCsSNiEO/JXpiEQFGAo9N7yHje3K
	 C/OkDJfHCixzpOUnsduCepvRJmXgZxKvJVEdX0zsXk9c4A2C6ne5ujKaK9nyMOrfJ240f
	 KUiyGu8lsc9Ym2BNr6JYCXBlO6OwUzrpCJY2epWQkILbuKXOlJXxzT63CnFeYbhNtBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=MpThgKPC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790977132;
	bh=0nCVZTCSwhZ+fiLx1vJ3qVRUt6LqogkuiR8wVkbxR4E=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XzZVvdgo7K3MVZK0cnzhr5d5FR8ehj8XCE5QPl6B5H3HZUuCdAi804kWIJarp0EiR
	 25jPQNZL6AORMnJxXz2g04EiBIweJ7cGIOndY72LX/L4xW29AWTZS8xSUR1iI65Mwi
	 cL5IWrjTYo0xwEgLFT7T0ktjZMa5SYGRiWeB6gp9GBton/uw3ieJ7SLoEd/wYa1kTI
	 66qivcx4h7+wUDkyUIE/aUh5URoYXYoHHrds8jsSPEPoUSZ/R+DjbFXQeFMlATtlhN
	 3BkqS0kLGRSQ9Q3w6bS9nnouD5HhnvyozSDnYh6LzQq7C/A0B+VeX7gRfhKgKACw8O
	 voYJbTakQep/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A512860DD8;
	Fri,  2 Oct 2026 21:38:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E19F34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E865F60D93
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1QztFVf4a7v for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CEBD60D96
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790977084;
 b=mjZ0TU+4RBZxTCBukeTCM87pn0x8VCOEbnvRFEIXaJyoqvGXjxAKWmVC+HDrOVa7yjvD
 e9odPTVrOi4/CPsGczHam78xhws771sTeUXoSn2zzH/WHu0UyMcLE6iWkiaqn5v06ATdT
 nsfPFhZCfAZHx+TIYK0v+vXL32zqn27v2dsqWDXDu8McSAO151loXDZm5gD22qawUHRj4
 QGfByP6sCnp9+dNA/W7vkmY4ECWJbErRk62y0TFKbWidGDcbS7ryhorM1F7ZecPK2/pDw
 8gqQgNDzpnP27DnkHnKgVgb/lO1Idc5Ikux4w++FStVQjfa9Svos1sRtS0xbuhSTweQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790977084;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=0nCVZTCSwhZ+fiLx1vJ3qVRUt6LqogkuiR8wVkbxR4E=;
 b=gNLhPR2hKd9BJX1QLuwwdRr31fNdk3RxBUGRb2RatjZ+Qi1M00YEQMGqGwBaO76GpmLD
 AJEPTfscC65N8Hyx2Lyb/KAmIee2b1OQlrSdsdnnqIgz7BPNQUqUbJ+ec6QV4byyUopAy
 zpctqQmpXijskSiyVwtbmF70WKOz6u5LR4VdaiirNeKI8MjV86lqMpd7IQ3jmzX/UZ+M6
 SEQLRwyqeiKxQp62QKWBcg2UkrXPQhWtCN63Re7tm8mZq5w/cl1f7tVeXLM4UHQIEQAhI
 dlh8U2oAq9ut6qKqksLrAdOPtL0maRmU7F68g0JyR9qVMT+YZe+moY/O8AA+TpTCPLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=MpThgKPC; 
 arc=none smtp.remote-ip=185.70.43.27
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=MpThgKPC
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CEBD60D96
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976622; x=1791235822;
 bh=0nCVZTCSwhZ+fiLx1vJ3qVRUt6LqogkuiR8wVkbxR4E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MpThgKPCTP3HOpFylGrZJlJIzI9eH4GZZtvYgsa8NEpHjbjCzRXLEoJT0/s8tBcMw
 zZsUZrAJxMzX5vPF/ciporz29szhF4UgEn67rRfB91AH0I2YfZ741EAB6es5TBbRmh
 1yg/X1iFn4AV4N7A5KyKwDHRV8d0wGSYrdPehr73bBASAfrdnSvBecQ4X+JDRUnvHx
 oiVAgoWVZrbObOq/DWpeVEUOoARMipGzRLL7MtE4krUPc25KfRQfGPkFq/4E4bX1ze
 smW5DpqrfHC5iXS7OggLVtI0HbwL1QvOhvyPAdVFvKWXfCB7EmfUEeRCdsC8xclqrq
 nuHvh54gmqJFQ==
Date: Fri, 02 Oct 2026 21:30:17 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 5/7] phy: spacemit: k1: set CLKSEL on every lane
Message-ID: <f2a45d693e8b78bdb90b5dc2a9f5d6660fd44b0c.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 8af0d147ff73d5b34a66df8a5612fd9983e755f4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:38:45 +0000
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

CLKSEL in PCIE_RC_CAL_REG2 selects the input clock of the lane's RC
calibration. It is set only on lane 0, so the second lane of ports B
and C keeps its reset value, and it is OR'd in, so a value already in
the field is merged with CLKSEL_24M rather than replaced.

Linux's k1_pcie_phy_init_pcie() sets CLKSEL to 24 MHz on every lane,
before toggling RC_CAL_TOGGLE on that lane. Do the same, clearing the
field before writing it. (Linux masks with "val &=3D CLKSEL", which also
clears every other field of the register; this keeps the other fields,
as this driver did before.)

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index ab8349f7d1..0e18f29024 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -265,10 +265,13 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09=09writel(val, regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
 =09}
=20
-=09/* Set CLKSEL_24M on lane0 */
-=09val =3D readl(regs + PCIE_RC_CAL_REG2);
-=09val |=3D FIELD_PREP(CLKSEL, CLKSEL_24M);
-=09writel(val, regs + PCIE_RC_CAL_REG2);
+=09/* Select the 24 MHz input clock for all lanes */
+=09for (i =3D 0; i < lane; i++) {
+=09=09val =3D readl(regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+=09=09val &=3D ~CLKSEL;
+=09=09val |=3D FIELD_PREP(CLKSEL, CLKSEL_24M);
+=09=09writel(val, regs + PCIE_RC_CAL_REG2 + PHY_LANE_OFFSET * i);
+=09}
=20
 =09/* Toggle RC_CAL_TOGGLE for all lanes */
 =09for (i =3D 0; i < lane; i++) {
--=20
2.55.0


