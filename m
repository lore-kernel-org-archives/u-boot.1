Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB9BCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB1F761083;
	Fri, 16 Oct 2026 13:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfe6bZVmuuy4; Fri, 16 Oct 2026 13:24:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C387E612A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157073;
	b=VuI6zFTiSv8IrmnGv2T1HqXsHMwdKIpLAYStX6dTVh3f8+jwmDPgwgUIrH/+I7H0FcTg
	 VbCUBl6/U9AP/z6IPdmu8D7fPnHUbWfcBerR0e1Uw851sgUYj++ycSxaNSWJ31KAFyGsf
	 fObJDwbq0lEXDRE+AJNjZx26Xb8huBP/xXQiW8++P39NJCLv4x2lY88PcNmpP/bYXr5Ch
	 f1Cf7eeq9FpltfuJrGsInxWwJO0+GrRmoGDu5omObd5S6kYGidFRg3rrmDah6lwgLI96T
	 LGgaec3CGfahERIwBYeAXyeYToPFzA6bKW7dIsY0BVpRBOiFXX0SJWZnoqR8fp/zgeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1zmh19PAh9XHCeEhweAblzWeTz7pt9GV2b3FO8ktJOY=;
	b=mHr6M5sx0PbP1v1YGbWP+lCf/n7mwBt1MlVa9keP71BclSjLjswMo8iScuBwJQU3fMNl
	 YwaOwe/grpalmVVSkxQ6ul6LfhjMSlDRmpFE3VJFIsBAOe+PIncuZFjQPOeJ32nkRVwqD
	 F0aQXqp7bQzUHgiqf+oOt1mN8st/cOa941RF6d+vLp0R7eisgn0TBd/fz1zjKnBBmPBm/
	 Jhbz++5DBQXdkKi2UjmtaziZRu2IKYsTlzB4fSSKx+Fcy2MXW905huCdqfNSNMeaPhdL/
	 IodbTLG2Klht6hTy6NMJQOX6QvsY2Vg32tVhMwrGspDgJ5ZulnqM/SCTQ8WO7v6F+DQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A7dDNM05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157073;
	bh=1zmh19PAh9XHCeEhweAblzWeTz7pt9GV2b3FO8ktJOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUnl5N0hAeHTZ48A3y66+TfhJNgapWXLEveRJPs3wBdAuLFK/ZEHBDv5zk5hMGan9
	 3qr9WYIHI1HdQQKytwwbjubFQlyTtkDrkbFDoWMFiay2rajMDWroqTTc5AxQjq7BWR
	 CxI7Ese+uufes4V671DKPM11+FvH5+5Homq+afM4GrA6dzQopdUXh+9VGh1hznVicu
	 O44oBbyJgn57JCXqMYmtVhLcZnPztsUvq9dHLJQBs9Vo8un6n2SUelDSXRxoKVVyOw
	 sWXZxqbHsPWqmNeHz+99VUBpqu1di8wy5JKNAsj/wMVfxiLVjtlPkQmMlsF0ZXavnw
	 IQcb0gwUqF39A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C387E612A4;
	Fri, 16 Oct 2026 13:24:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 681E9105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E29160A73
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txNYyD92VyDi for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5888760AB0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142234;
 b=KLsnt5XiCi0AxG+kqBSzJG9wMJ59GRkeONqUuazX9fL4Obr4XoYUDxNf2wmZADOWPZfd
 fBfATJo34Y+AHcf1ePYt2ij8VVBhDTNL50MFmmlxQkOTG8p9hDAGf1VCUxuLl+F9Zc/yE
 EfeRXixFPiVQJ7dDWaJYH1lpEKLUTz7b6cJwVa9jFQwvK2ohx/A61DA6UXkBtRqowZkdW
 aGTFu2vJdne2MflrChVDIKmFy2op7TKAxz4tdjdBIf9QxM7dczcnnyo+QbD+vEgAx8rRA
 2qcKgZZyW7KKMfZeIUazFfrF/gxDgmIeQ/hqrIANaRFf9zgICqbd39IFo6Yo29Wq8QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142234;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1zmh19PAh9XHCeEhweAblzWeTz7pt9GV2b3FO8ktJOY=;
 b=ohdtQzccNXQRwtX0TygnvO9FhHza0YJIFd+/j3IF0upGZWP+RBQ/xX6fYdqSa6ymVZSk
 E7LIJW1JImebxShxw7PK/8Y+plVFEtb4WuHJHMAx4u1KqKPf+V45SAVj+HRMMPeOcJ+te
 cwUmYVQL4zGDoQrD7nJu4+Liyt5djtkIo6WbZ6fu4Ny8Dtl0NePaFM/oYB1ea7gfM5l/y
 mFYIBQMKPiKlx9RBUXite4RYZQTNM9BgqOAsSz6mNBRc6RHvJNlf4251EaZzoubddZfqR
 nd+rQmmZU39X6S4GKDcoYTadvtZx4SyVeYcokZ3UFTTWmNqL1Vu8cutb9bisFjQ4wBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=A7dDNM05; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=A7dDNM05
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5888760AB0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:13 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso3473360f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142232; x=1792747032;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1zmh19PAh9XHCeEhweAblzWeTz7pt9GV2b3FO8ktJOY=;
 b=A7dDNM05caDHORQcydIN9cYftkjI+MG5wysGoUyjP3De3cbnSaj2y777LLO/KrN4Ip
 ryy6BFdemdpNmnunIBOIcWve+IJTd2wkN7rUOAD5IZ9f0MSSgaCIR8qF/9fQ6trlbSRl
 eD4OhwzeVxkZReBFZfIK9jP6N0W8O1SL1K5Q7HPjk2wH8MQBuhZ0pZT4Yyxwse95bcZK
 xHS5OcMxURC1GRm4U3sjCVni+Bd+qgrKmilk2WaGuGQ87kPzIt6ilQ8xvN59GxBOJeCB
 OFZguKCUMjREWcLJrSwARLpEemFaAectpdWT9SRL5vC3vfBrTqi2aV0v1aXUJvF8/ExB
 Eg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142232; x=1792747032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1zmh19PAh9XHCeEhweAblzWeTz7pt9GV2b3FO8ktJOY=;
 b=0T46wYwhVeUkW265MbfEo7pTjY+o3sD7jdc5+pWkQx6b35GTleAewMI7g9HhCB9CZm
 c0bJMSch0CCQ3lDmeDAja+inNskl8YH1NNCy7V4JdxGzGm/C+g4qCHiVzRKLIyNThwwd
 XFYQxj5XwjrtmBAE7t5AuDdDCT4LbNm24oDSgKpGg4xQmRZR3KDbRPF6Tc2W5kv0rtIR
 3YVZA6XCEz8qAKpBDzbAuSWwjFZklWTgrS9CCtpUkDFaBc2XkEAMTJNMST8RMEjxRnnL
 KMk5MkioQKc+WCNHEELhTKQMF+AL9HvPJTaT2WvH7wtWXven9OK1rbO94Lmd58HoiGk7
 eWnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdk+sN0FPX9KA6HdMYgjDlINFKi+m0unYatZD55qSeGv41wyjvaetfADfyLtkVGaS93WBrWeY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOly4XV/a5JZcWz1JpiND/P0KEJFLDQUOVi5xkqLgzuBN69Rmr
 mqHdkeF1oAIzkRzZAcFajsGjkqsvQDFt70cOmyiiOQLnYKZ2nPUFizzB
X-Gm-Gg: AYBFou1mkTGYAOzsFHShf/E7MlY9p4XLNEFSbUhj2HfjnWAf0TAFVe+DUunMA668FOt
 SYjVfxGy7DirvwNA1D0LCb0xFLklkl4KhPlbYs0tjhq8g2bmG7T4pjeKPRUrEk2bBcPDoKhQ5D7
 PchbRuZdcuwQwRmGq/LTBNVzYYTWn9oTANN4opOBjuRF3g1GERlSF7O8W+ZvN8V6OYePqBj6K3D
 SyLPlR4aYXTqpH23faBgUPf503Bn2lpr2UllP76sthtgAy6S0QcTBvt0cjPgxBbRkCaz2d+QOPa
 xXSHfy5MpDGxThiWz2oPBhIkxhNkXtnKO9bXwJgtziAInEGhxTvEut6ggoVPkCNDXnMsf72eXyD
 YGNgekALiNHslF7fzf3sXNsmtEvVPLo2Qjj93px9zU7BM8wJfHCSvHlNYhAyZWH/6NRxN6bP82Z
 tS1XhdHmIMw22wCRU0F434ZQUyttmScA+a/X+HoZTuunGmwQiDXpwIo1XjcOU=
X-Received: by 2002:a05:6000:4b15:b0:48d:fbee:3dec with SMTP id
 ffacd0b85a97d-48dfbee3fa9mr4140550f8f.29.1792142231949; 
 Fri, 16 Oct 2026 02:17:11 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:10 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 6/7] mmc: sunxi: B288 mmc0/mmc1 run off PLL_PERIPH0 2x
Date: Fri, 16 Oct 2026 10:16:07 +0100
Message-ID: <20261016091608.121842-7-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

Their mux input 1 is PLL_PERIPH0 2x, and unlike mmc2/mmc3 they do not
halve it.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/mmc/sunxi_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 84f4e4c2198..7329ca3e24e 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -100,6 +100,13 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528))
 			pll_hz /= 2;
 
+		/*
+		 * The B288's mux input 1 is PLL_PERIPH0 2x, and only the
+		 * mmc2/mmc3 controllers halve it.
+		 */
+		if (IS_ENABLED(CONFIG_MACH_SUN8I_B288) && priv->mmc_no < 2)
+			pll_hz *= 2;
+
 		/*
 		 * The A523/T527 uses PERIPH0_400M as the MMC0/1 input clock,
 		 * and PERIPH0_800M for MMC2. There is also the hidden divider
-- 
2.52.0

