Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8801606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dZmrcUfY;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=UqzSXqy5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E8A40718;
	Tue,  3 Nov 2026 18:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxVJ0I1jOWj7; Tue,  3 Nov 2026 18:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1F3E406FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793731882;
	b=Er+gp7rfbvoXOYl9pHPFT+hsON+3V066UYS3CWHhWx5vPZP98/7JsFqcRJKjHYF3H2Z3
	 4csuuP6E/9QJGPSY7DmP3TH0y4LmH8lOsY9cmaJCooBGcQC/S+VYIVDsomz+PZfXBVZPZ
	 ii2bn+yK2c7kkV2vXxBwcChwJ0OigODzfG2oZNWAoDzCPGGaX9XKQc9yw50vYyvxZHH8S
	 FbRo237hBBuvKHYJ7wzROZ2wDAW9Tf/fYuhFa0891TVe71GZ62aMA60XW7OVhhnDo6+by
	 iVArSNYskGEXVAOpodkzWTbjpBPBIwTEJl6ncei0HCgVQ1C+2/OoaSF5hiqXKk9Nh9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731882;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pH8+h3FI0/sZ9KxrdCHqmkQi7DBRwq3atdmo9R/bD30=;
	b=HUS1ojFv3+nBXM5CdQtsuRb8ifllvcIGqBZTJpzV3a+tJ+udYTTtTUOJFASiPwbFGJUt
	 9/jG3d8Da4lXlKYTwTuwCjoilEx7Mh8aGaiAYqexQckcx0XhP016CMs0VygAkbLShb/Vq
	 Oi79dE54BhXGblvYyqogaBbEMU7D9IuKQgN8LdRRzWqJpTGX52DemyoppjA9jNRfNdjdl
	 6YNcTTMbwC8dloxPninXm3tOaMgxWS3YOo1HkeP6MEPMpU78flTMKNmbBbzneRJLf2ctJ
	 nvGM0ltCD9D52f+KNd8rMRLzWTR7v9q+BUxyBbKGKApdyrCmcQOrdxxe1eYZoNc2xaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793731882;
	bh=pH8+h3FI0/sZ9KxrdCHqmkQi7DBRwq3atdmo9R/bD30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZmrcUfYp3Mv+85m6tXvA9YbZtRBdGFeiFgGeZ6uK6b8ptdLL6pxLwlbWI32KHIs7
	 5soqT+YZUsH02+0KDX0Bbe+MXiu7IK8STQOm6dSNIlMLYXulMGlij09w18kiRFUB4e
	 bfjlLSOS/0Usu9TBevSWxy8JQtJO3g1PVv8FUFXN9q/IDSIfSYPXlipmBZNXiGCwMt
	 ECKRF7bYl69nIQm81cvn3topDwD3SLZkRXPGfjox2E0o2fHTBHOUbWy3V7OfsQUGvO
	 jA0T59GmUZyU4rVcYC8JuDXOd6FA3wM/T5h+OTXkVbl/+nBx+qOiD4+qbOifSin3Yu
	 mVgDtdqike/rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1F3E406FA;
	Tue,  3 Nov 2026 18:51:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5895784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6A1280DA2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qP-4RXxrFNLB for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E399E80C88
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793731471;
 b=DmcuMtNvqIMHldwZnb7AAaydCypKc2BfLYjzn+VnGjxGacv5FYmSRFeFHdwtVJe4zXxa
 2KhdSDoDIpff3nMhrWnAK33SH8WvN/hpJoRiwYY8Fu6FPCTJdd53qPtAtk8xxJU0+KolR
 QD86tIqSh7CEdg4tipgnSm6Nc1gW7KZUXkXZ+tsvnvCQVrHps6IKa16a/1SpdkmRLQWlk
 Y0iOdQC3q4Z1Cjmd+D/ltoAALpK/kxBeprtfMz/YimBolxXTfHHVaPeYxaejOZggVIJ4p
 qoGgC204ffLoFmcaXICfMUkEWNYtqv/iqygGF1E/L1CesEY+B8UzQwuqb/aMCgfFX9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793731471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=pH8+h3FI0/sZ9KxrdCHqmkQi7DBRwq3atdmo9R/bD30=;
 b=I+9ikJCrZlowrWCJtNnAoG7io/bbvQlm89CG/f9ypqV84U4oWH2k+MYejIobdsttGYH/
 1zWZn7Tr5xUi8eiILVnRFp8wwe92G2iFQXcAO8Bmyt4FukW/uvO1TbVEaVii67KEFRZTP
 UtUd8g3wAguhzVguP+ptj1c6/HGGEWSY53CxJBJnxDxnvsEVnFmzBbI0XAl0T8WDzQZnX
 n2x1mF5KG1Q/PVopSP8iKjVE7Zh1TmJ7WUDa5cHP+KXp3Zn8vB5Pzs7FVteB/cLQItqWM
 rW6C5BSClQRLhY2cx+GksS90D67B4+wanFuRjpOcECQTNoq/9NOQvRt/jk/r2gjq5DQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=t0.technology;
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b=UqzSXqy5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=UqzSXqy5
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E399E80C88
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cdb2893531bso1448694a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793731470; x=1794336270;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pH8+h3FI0/sZ9KxrdCHqmkQi7DBRwq3atdmo9R/bD30=;
 b=UqzSXqy5tyz2JJvMVpI7MIPyYDfcUq/vXJHunGr/4D1ykzj9/oVHPQ0y5/e0qJm3yK
 vDLDvEj+OGKY/NftoGlF7+tkMlAtm9w4fm7AY6aW423hFYOOH/tprKG4cSQzifczlC76
 1vpXShaGlQ4M/qs3fJ67gWgwRakQ+hDowjKClOQcoY12tteZ8aJmy5F9Ni753BXoelbp
 RMZjCTbkR1IaGZVzP3b+DjxGkV4lgNpgvCKDMhqr8GBO7W9smidWbmyMn4hbl7SqXcO8
 z3ZVyOIz/fNGpmtc/F2nmSSKIzmUhH43QxT2uoChM4aIMsG1WEn50cr4med8hXuzGe1T
 ReqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731470; x=1794336270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pH8+h3FI0/sZ9KxrdCHqmkQi7DBRwq3atdmo9R/bD30=;
 b=LYFv8IsUTY0MMxpNnMG3B3kdQYRyiGWV4UPQVACRpJbdvGqR1W3hkYMyZ31TJaIOoF
 zRWg3R3nP+LLCW335UDebuX6FgVLwMKgs8rQWQxtojt4aYQF5jGVoc7U9at1MxQ9aPc0
 a7UbmhkNandIUHwcQXRKJE2D8INzRb0opHUEcMtwFeImRNF1197BE12xXnUsNG6PV/qj
 jT2AHjqxhrcfcdU8MZbuJkUQhy+TYXdk1hQ1dOeOy4maVuk2sgY46Z0MNAv70FFj4V4p
 Fhw0qxh0YRefiz7Pk2jEhkr3lwGDVotID9p12nWie3bSXs0qnVhM7J+txNCCIe+wzMP/
 IAwg==
X-Gm-Message-State: APuU4Z9LvuwbSgQ9gG2OzxJFhKjND9X44zM43yj1DNMYcTpWvo7ahF/M
 PsEWdq5UKOFWjJxi8rzQTIE528NbtZ77bbUIArRvSJT/zWS0TxHK14cQKoi9anjpL+o=
X-Gm-Gg: AYBFou0hkuUC4NaLHcPI7yi8g/jf8RSpx6qF5M21vPu422a794uf2SF1qDLl6/lM7dG
 PlJpm4gKviS0UVtgnb3yauL4sbVMBwzLbgrShUe2kd8wlu1kl/dPn8IiDG/bRB96RYAFoyQO3Mq
 xXUV9rs81kK73YExBK946sucDYZfUcDAbP9UnT8HIm2d80ssO77jprGkMqWpEMGIxFd8wdLCsgb
 KzQ4a7HTYiTlQvaJBvdgCWZbawPa9W0d6BGZoB1nyi0H42f88LxEKn33kYsaDS7EG5IGtrk2Zk5
 4MN5UZvfgyewGlb6ztIX5eqyaAdouMVeEcNSMUH3hXF++AWxgWnqpzq5Y0+jXaIjOdjvzi/ETMS
 kXnhCFVtAXlBp5BSx2N5aKWJbwJfLrQXxMi5GkrC26FrptSNHWGCUMzhacOPTKq7mScUbe8ZHfl
 7yjmLTNVliyaR9aWZ7ftuBBvP/B064XRTPCZTUzGdsvH/sKALkDX/+NmrWJBLY/08Y22xDcaoKW
 oIhQ5DHzU9PnNYbgZOiRBPng7Y9YvsvbBC83V6Md96sU4PbHoP4U22QMD64+PVSghItBD7hdSDK
 ZrQBH8v8BSd12v/y8Tn/+jZVoOQx2Sd5Z4dKd4vc3j7bg2iygCXQc9LMnBOy7oWVhxLYwrybm+G
 7
X-Received: by 2002:a17:90b:5286:b0:3aa:6b5d:a02e with SMTP id
 98e67ed59e1d1-3ae89853ad2mr12041610a91.54.1793731470294; 
 Tue, 03 Nov 2026 10:44:30 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae880b1f71sm11496613a91.4.2026.11.03.10.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:29 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Tue, 03 Nov 2026 11:43:25 -0700
Subject: [PATCH v3 4/4] net: eth-phy: release reset GPIO and reset control
 on device removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-zynq-gem-remove-leak-v3-4-2f02ec0023f9@t0.technology>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731408; l=1489;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=EfoA4ogMtkQk3QXcbPaKP4l3LONIHTC10qqZ69gPuqM=;
 b=qRhij3N3D7adR9qv1hqNDYAH9i+9XVf13jTXFny9aG3jYKr7YdIwmGXHYLSFZjdlfXz7ywfqf
 ouCZlz8CwDBAkVGsm59+5yk+fW54xpKCWUQGoBvPP57innvLEKQGP0X
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:51:12 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eth_phy_of_to_plat() claims the PHY reset GPIO with
gpio_request_by_name() and the PHY reset control with
reset_get_by_index(), but nothing releases either when the device is
removed. When retrying a wedged PHY, any follow-up probes fail because
the reset GPIO is already claimed.

Add a pre_remove hook that frees both.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/eth-phy-uclass.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/eth-phy-uclass.c b/drivers/net/eth-phy-uclass.c
index a13e2fc7c50a239bdea4aaeb6d77496cc86b3575..7ac1876f846abbddd23117db235a535eb96d234b 100644
--- a/drivers/net/eth-phy-uclass.c
+++ b/drivers/net/eth-phy-uclass.c
@@ -191,11 +191,25 @@ static int eth_phy_pre_probe(struct udevice *dev)
 	return 0;
 }
 
+static int eth_phy_pre_remove(struct udevice *dev)
+{
+	struct eth_phy_device_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&uc_priv->reset_gpio))
+		dm_gpio_free(dev, &uc_priv->reset_gpio);
+
+	if (CONFIG_IS_ENABLED(DM_RESET) && reset_valid(&uc_priv->reset_ctrl))
+		reset_free(&uc_priv->reset_ctrl);
+
+	return 0;
+}
+
 UCLASS_DRIVER(eth_phy_generic) = {
 	.id		= UCLASS_ETH_PHY,
 	.name		= "eth_phy_generic",
 	.per_device_auto	= sizeof(struct eth_phy_device_priv),
 	.pre_probe	= eth_phy_pre_probe,
+	.pre_remove	= eth_phy_pre_remove,
 };
 
 U_BOOT_DRIVER(eth_phy_generic_drv) = {

-- 
2.47.3

