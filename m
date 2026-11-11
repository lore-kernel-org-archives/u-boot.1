Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84A606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OH1Nxiz/;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Bie7A/DW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99FCB60DA0;
	Wed, 11 Nov 2026 14:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D19hqKWuvWTB; Wed, 11 Nov 2026 14:21:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E11D460D61
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406905;
	b=lPj35mPYSvmASH/n3FAYTmRuhwOTkUJkrZg007wVsy1+879ZDbZK2HVLI5wos3eqxXPH
	 4GE5NCWmIwjlEw/WXEnQKjPvInimjwXN7tYt6VegoIoQ4xqFPX4XgHJdIGKqg+MvXhYN0
	 7F/PxWvgs9wManOydOcAkT265h12MjTBC1TyFXgbp3ekm8U3rSzJGVMqPWxSAHAdv7mN7
	 tIP4jiG2afJIvn2j1JxSgB4FagQH5VhFky4CtyVeyd/MqufZLuwzo6Wz5jkjN6wPtrDRY
	 K+RB5viMpYtRIqNM6EJVxU49asiUFgkCVv3w9farsFWaRA30/QZlQxUOysnol+R20YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IdWP4TQVDswQo5Yo1jMX5MljA1LO5on8B6+bzW0MyUU=;
	b=ZCCjFqy97PN9Z/W44MdazYj+ElBw876AeHOWIcgin1CqgA7IWANSy0X02TGeBAb83BzW
	 kH29azCZ8JPWM/3kwyvffisj05IOwRGYSFndSzXU+hM3gJPS3xCmX+libdGtcg3MqqOqc
	 c+yN0zjJfIyLA8aBqpNwTZV1VcJEw2fW/tLS90LHIjUZk5u4GfRKiVxpadNS1KyraWUJt
	 wW7HRoPnBw0f8W5qpJDJbBgnt+YVqxn0E88FprL3shRNI14b4fsWL+1uzz2NOE9qGLTJc
	 zrFZNsmwZ1FpepVHaVeEIQ+oS8h6htqdZhr2sM/Q3org2UUaDo/TtPKGVVKpE42eReg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406905;
	bh=IdWP4TQVDswQo5Yo1jMX5MljA1LO5on8B6+bzW0MyUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OH1Nxiz/8H1f6ggIcE8nt+sfGMfDcf79gPkEtzcI1S7EEjAFdI/TbDhIY56mLdixp
	 Yqnd7Guz61oOW+6OLDrcAeD/M8LcZYvP2o+kvvwGw5OzQXmzPTbDdLPOqxr2NXa9Ji
	 fgXyh23Y250xlRfIbwxJu5pQKojaroFA6pACj17+ZYuw8y3OSjBEY/nnoWSqhVH9iC
	 SVaw+rHJ+sor5WaE+1UAcH1QCzO746ddC3FB/9/9gcChvSh0CFimIXBuuIyeA/tWIm
	 xWAKeKota7JB2xeAOg5s6UW/WIdK3H/Xj3G0bzC9xY8H2v94330yxtB3gMHSdxQuLR
	 hNxm/8zAThQaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E11D460D61;
	Wed, 11 Nov 2026 14:21:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2598B31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22FA240801
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qe3s6RQwdtBV for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B275040873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=Bie7A/DW
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B275040873
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 372FB23124;
 Wed, 11 Nov 2026 15:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406874;
 bh=IdWP4TQVDswQo5Yo1jMX5MljA1LO5on8B6+bzW0MyUU=; h=From:To:Subject;
 b=Bie7A/DWF0ciO7PL6jQKhHdJMNLlkwC+tvgf5FJn/cJY34lTPd2yjYd3gk4ckH9HH
 AYzmM9t+qyfMgQ+gfb+WvHhng5aT0Q5t1K+5QuWCoLLEP/AzaWsiXMrUCIT2f1h/KL
 DwxEGQ5g7y2RlJIrGK9R+aYy9E36YafSJQuKbvmKhQ6HqwJ6TpAqXzuQwCfciJoilG
 /WZrsyNv2fDknnjcFNZ1HkQYxdhqB96mhRCakFYT75EyojINP094YginK7lrCvswBm
 67f0dgoZcQyfx7aLeqaToLmJZHhrv5TyqRXsMW4R0ZlkLBRJ6KOilSZPfVsbvBqet+
 frApDPNTFpx8g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 07/15] board: toradex: colibri-imx8x: report detected SoC
 variant in board_name
Date: Wed, 11 Nov 2026 15:20:55 +0100
Message-ID: <20261111142104.109139-8-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

board_late_init() hardcoded "board_name" to "Colibri iMX8QXP" even
though select_dt_from_module_version() (called right after) already
detects DX modules via is_imx8dx() and sets "soc" accordingly.
board_name now matches the detected variant.

Fixes: de666551b304 ("colibri-imx8x: construct fdtfile dynamically")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/colibri-imx8x/colibri-imx8x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 0a86420700dd..f8cbdc33f28e 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -141,7 +141,7 @@ int board_late_init(void)
 {
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 /* TODO move to common */
-	env_set("board_name", "Colibri iMX8QXP");
+	env_set("board_name", is_imx8dx() ? "Colibri iMX8DX" : "Colibri iMX8QXP");
 	env_set("board_rev", "v1.0");
 #endif
 
-- 
2.47.3

