Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092AEC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 09:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78B81605E3;
	Mon,  7 Sep 2026 09:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCvaiXGbja7l; Mon,  7 Sep 2026 09:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D7156605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788775070;
	b=gcfrLp+dcmpj35eMXglL/hTXxMrvUgTHKfOxGYJSMFpwICnXfHF6tulTOiIQDCBbj4fa
	 iD7F09CImo/T8u4pjDNatdFhQYxtohMpRGYbbGhiLl3dC0yjJPJiazlFW8GmoRtXIdTdY
	 BC9flkuTLlRHCNpTgfrJ+zwCsYkH7ftO7Yqkeg9ReyjKnglRoOrZsQt/Gj0dCUwirYcO+
	 H+zL569v7iAXhhINIcOmYQ095l4COVBZRUBHGASP0Mzy5QaS5iH+erGDh6l2/agHyybl3
	 h3xucA4BO5WDKrrc9mzFtk+ldH+WZkBuSiB9Q/ZAFhczQcfgqAwXmXej2yT/NdZk7Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788775070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cQNgaFX0DX1aUZ5XlwItxvvZvfeoFLMtUUBmpDAIf3g=;
	b=d+ql0gI4/aiVK0cbrN5eJxTXK2MUKd+dnTgbM9bkrW4G/ZacHuUrjoE2J2gVvWgIWcFU
	 8dyrv5y4H3Y4IbP4oKoYku/EyOyKFRmqsnzZ3+JKiSfbwYYS1XZs1xG3OKGS24kh3Rz2W
	 NDMROCf8DyT3c8zxdpnqADjruztTj9car1SF9mkGXLBy6rYn83HQJGl1XNF731QZXNiaq
	 CacWM3+9ZsBs4dntsi9cAJPN6/smzZNWi7rln7KZUduuMfJIeKgUZjF3fefpJI8nMJpyI
	 xCdN8lQLIsUp2fEfQ+yVekanBjVVYxjqBSeq4FX3No5U5YoKmPqt1W9K74VcnONQHKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788775070;
	bh=cQNgaFX0DX1aUZ5XlwItxvvZvfeoFLMtUUBmpDAIf3g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X5L5hgCnX7yIkDib5+MgrXh8b+zrrVq+c9ZDhlpEd36bPZHbnjYwTExIUs1glUMi9
	 Qwvok86E2nZvJvJsxIIw+kUpnntbjlk1Zhc4JeUCxSwzW8qNFLgpa2SdP715gQkDI9
	 F/SdoKbMhltMlTugvxZpt+rft5dnsND1y/d6ex6eI6OghO767YDpYUWn8ylM+NKJE+
	 U0ID1UXioWYpTp1rZuETtdAL8mc6qeh4VGCwvfmiskO08GPGa/i4RdjVthXDyJlcQR
	 qBSlZEI8ooZ9G0xw0QC8KST+vIB4iTKoElRFy6L2RP4QCdasAhic+UBzHAhlWCxsgv
	 QIc99mNfErDUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7156605E6;
	Mon,  7 Sep 2026 09:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2C5E49D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E477040532
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnjQ9N8x8JF2 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 09:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E004140506
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788775066;
 b=CBNOGaGc31CXBoG5mFfjbtSrVVZVdwypjiJ8VDM/Usclp5dM58ShhVpAPCt2p5eFXDYn
 CsbeJOgwMULW/fRtTd8TxOTXzzPJyHNfxbO95NjWRObfNvzDTBA/O7Jr6Oe0uT9FW+4zZ
 Hqt3JSjyLA5nwLRtPzL+6FlbLgPnhuvN/vUB4vWY9LTes5GQDkDq5Ajne6D6zC+K0RV49
 Rdv5KZnblUIvZOECewpVyHL0adU0MKxkOvC+NvshMeMhmRBcjRZmMT7T70VV+/P7FcT03
 yyxWZ5vIUc63+DuG3fhufmsH713ajfCGRpsIv12y6xAyhXS05PU/1ivDQ9KP3yQ1OGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788775066;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=cQNgaFX0DX1aUZ5XlwItxvvZvfeoFLMtUUBmpDAIf3g=;
 b=rcFrryXQZE82tArvta5Q46t7M3AVlGPSfYrNZGMDTaGoasFJlQ/vNZfHanm3fu5fgN4O
 5w1lNe7mdDwbPzRsOL5SwHedGFh+cZl6BMesNvwZcY+wBoB+LbtwStJCmlHRK1X/Z62W4
 bibezUX2SDSnfjN5+8GW+iPwJ3BjPbxfg0d7yr72pHbVbfMijuqyqptEpY4ci8WpW3gKA
 mNv+UBd3+aDolJXoKKXPCa9a3b1SJni15WtM7jmG2D7v89KVJvScVi8iMHUDpxrsgfVaJ
 THAFJuq6NjpdxsCo7DaL/vEuIOV4Hpe3xeIlOZ+kJIHhsUsoHMdGeM9ygCYk/9gqniA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ECty1ZBE; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ECty1ZBE
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E004140506
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=cQNgaFX0DX1aUZ5XlwItxvvZvfeoFLMtUUBmpDAIf3g=; b=ECty1ZBE2uJ64PEtnlAp5M9sWs
 ThsBymmTtud2QF0mkukDJaOMgnozF1s7mESl4KbJ/7xdlgxDcmPnc6baJ+tpLRT45wJ27fpgyeEkf
 gWApQ2ZIkB8aOCG60Ym7KN8VYibPCPXwuokpVdwdF6pG0orz32Y0N6A/sTSSJngd3OWWcYDGThfDv
 TgFs5IHPkb0EDqIIg2SP/figS+93lYx77NWbMuQplJgqSL1gxKFvjs3V6OGPZRenO4VxGyqetpRre
 J+CmavnGHyG+jn6z78UFz1LOGVwyHbxzchO4Dkv6G0A7RNR6BV/HJL5jqpcQ+gEk7X5pwcJStF1q4
 jVx9MqBw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3W6g-000IJu-2x; Mon, 07 Sep 2026 11:57:42 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1x3W6g-000ANR-20; Mon, 07 Sep 2026 11:57:42 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@ew.tq-group.com, u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH] net: phy: dp83867: fix register number for extended read/write
Date: Mon,  7 Sep 2026 11:56:41 +0200
Message-ID: <20260907095641.28754-1-nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)
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

Actually pass the register number and not the PHY address to
phy_[read,write]_mmd.

Fixes: 614ebea14bfc ("net: phy: dp83867: enable extended read / write for driver")
Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/net/phy/dp83867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 34c871857e1..f100ef35a43 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -131,7 +131,7 @@ static int dp83867_phy_extread(struct phy_device *phydev,
 {
 	if (devad != DP83867_DEVADDR)
 		return -EINVAL;
-	return phy_read_mmd(phydev, devad, addr);
+	return phy_read_mmd(phydev, devad, reg);
 };
 
 static int dp83867_phy_extwrite(struct phy_device *phydev, int addr,
@@ -139,7 +139,7 @@ static int dp83867_phy_extwrite(struct phy_device *phydev, int addr,
 {
 	if (devad != DP83867_DEVADDR)
 		return -EINVAL;
-	return phy_write_mmd(phydev, devad, addr, (u32)val);
+	return phy_write_mmd(phydev, devad, reg, (u32)val);
 };
 
 static int dp83867_config_port_mirroring(struct phy_device *phydev)
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

