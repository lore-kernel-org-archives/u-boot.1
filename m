Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966B606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t2YylETl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BfoYrdxl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6225F816E0;
	Sat,  7 Nov 2026 14:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9XzHq2BKWYhH; Sat,  7 Nov 2026 14:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3FDA80E98
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062021;
	b=rqtE1lIelt6TzGmHWoXlw8jiPTzN/TESizwe1QKnmxE/2zD0MLoAuYf4xCMnxYP2+Yb/
	 cb1dS8vfGJx9ZsKzVhBrKL3uRhN24hNGNM9Qeyq3btNm2PV49nTDQ1QruskOnBj88N5kL
	 jpUpN1jHO1B4d7xmTIMG80/t0USZZZfaNQkg12bTZJyEqmGBsjRtr5vZn0c4M5/KDOSfn
	 M9HjSK5YFAIst7ot3l9EfkUGLsPDelvRd2hyGT2k2z79xT7cSOFIdMytGpKmRhBTIMr4K
	 AcnJtQC/tY0q6ZcOuEkOCsxP2ICKtaKSmd0chTnigGA0KH90fu9EfJpvBoQmRGcNF1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i07zlwjLyVxJsozTSXjg/HU61edAlYkfQoyvwdkQl2c=;
	b=MprN6qD9BKF6LFmJHFIwgRYK2SpVBhvALi5u3nrLvm8o8/L+Kh/8MHorFuDBHSzZfO31
	 XBFKjXFhmt3eV6H03KCg9xcSSLw95EdakEaZO0HyNYkRKHb1PPBsAjHMiBqvPJOxTdb/9
	 cqI9gbqXJfumiFPZnXGr5uYhBRrDixbvCi9XUS+/D24UZg+0EFMIAw/VgN1m7XJwAnCNH
	 JUzxCRKXBNVATG1KTmIXI8p6LvSfieovrGFwc1LKiWWIw74QVckl1sBYnXqE+r73aXcxV
	 o2WhnDGEfdTt/m7RHBG7EcZ45aGX0tCCaaWC23FXBLNsrehGiitT6TdqeiJr1EzxJyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062021;
	bh=i07zlwjLyVxJsozTSXjg/HU61edAlYkfQoyvwdkQl2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t2YylETlw1xMdXN80C4ZUZ/valCTDrpxpGiNql6cWcZ35iMyyz3mtxExWOHJGd40j
	 FhKCQkgdAe8BOf3a93TvhV48b1OupnY1+5bGItXvNx+1XYInp1bWJ3oEwWvs3oWJpM
	 pfEc6CsokNzgVE3zid8TkEJHbgZI5FpzQ/b8NEKBjyiTJolRZlQcapkjruZgZNQ0/k
	 Mfm4NVUDe3RugDi/C6dkK44hRFVb/HR3Do8hs5z967MgyYpBcpUgNoprfBRoZ2F6Tb
	 zlgk5AAjcdzMplpXvf6yv0R4xkBMWTreZmFzra1iIQcNh/SpHdt/sK/u0Z5JcXhaHo
	 wsHyJ96MuaCxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3FDA80E98;
	Sat,  7 Nov 2026 14:33:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46FD1211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 389E840200
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoWyNPNWBW0d for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 40BFA400E5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BfoYrdxl
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40BFA400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:00 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3ab30d04674so1870161fa.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794061498; x=1794666298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i07zlwjLyVxJsozTSXjg/HU61edAlYkfQoyvwdkQl2c=;
 b=BfoYrdxlg4YttsRyfVXI9mQLm4BeBylt7oo2S2zeSas8SKSIfL0V93w4Uai/BdF5Nn
 hco9b/cm9Vg7E4KRpFI0zoL6mViAi0oRf5TzyRRPUkxpxc8ftGQ/9zGDS+DMme1y9n3x
 JGGM9xFuoc6hecNCZFrqIpSFOozVcPb/U2vjPRmz5yRgtfbKlZh+sLWrGVO1SeqPjg6J
 8F7j6qDWu4FQe0q6HtexvLnt7Wr9jy6e5q4ThXo2Y41/LJO94ZJShGCWF0x0i1O8DQqj
 fGfpmRZ0XBHlIY43UckwEB7wa/vGzGhxWOODntwMzXqKhwV19ScJRiByNhK+Uu25Fti4
 c1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061498; x=1794666298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i07zlwjLyVxJsozTSXjg/HU61edAlYkfQoyvwdkQl2c=;
 b=NQwyQy9soFr3yfYF7IRbc32njxuEnpvsA3apTtDz3TZosGNyJY0RpaqH+dVc21D9fB
 oAxECv7sIvqMKnSCeOtQHh4z+4TSIfwt5Mc/DjTUze+KzGzDI/g/GCaigSWqLNP30Ab3
 HzyUBAr568YG1fuRqQOyiMYYvlm/Z/a6dRiFTARE8RLlhhwrG3Q+eyvgOHnRcyex2CUq
 lW4Qs/Me/3Yx40ayTL33k4AGuMZQrxAuBfD3lARH5jtJoNh72wbPcmTietGZEBzUjq3U
 vWDqRce8iXavHusWikg8vzu1MOaBdGYy2WKDRk1YleWenPMIYBpVjjkA0OqZTPSYhgAk
 SNMw==
X-Gm-Message-State: APuU4Z9bsyYKO2yX/pCvSX1KoTsOJpqN5sNwiftJq2m/Ivm1h35w3AFt
 dAZY5oQI9BE395TjfN0yZJGlZIsy+j5GcBssThaVE0DTxwHi5O6JQi+BdUpsLLRK8kcB9u0X
X-Gm-Gg: AYBFou0Ew7Rn1ugg/IkfdiOuDuwKXKduhteZ+64ZgubTByB/2BXOb6vMfd3KFvOq3bj
 jY+BI8rf1FmnqOQq2sSPdggPr1btS5xB0zcGWEeUuRXJkGm+y/Uq0BaCDyqs4O/KBDUi01LMEHj
 rdUdawo/HkrtncGieYyquKid6CtrX89a1zUh9dScHO4lFg5BwVfB3sCcX9eGzeL5m+TGyZfV3nZ
 f/g2+IvlxAAiC4uaKpZr1Blcte6fM6k2r6faPf4k48YNc1ROvSHET4qRqLzSA3ewEmz9iBQfLKC
 +18r0oLyNxbAT2MTMFcF2AGvv2cku2+dx7IcqJHkM1TRdL5wIIzzJfQlts63dkbyu/BV4GFHW0y
 LU9xMTMhawCSgQ92h4nguYXUn1hFMXO6dGvn0yXmRzMQGg3xcXyIUkP/2LMJDDNp+fmz7unPyU6
 dIhrXktIqqxaNR7xx0QZ+5mM632iqyJimN3EI9PheAsCrur7pOfrEV4dpD5/eVCUD4qeqY6dLdZ
 dph8Jh54mc0ujBGk/5XC3+eUwPe7SyEJXOoql1dBhHHd0QoaS+TBlSAEvbs5Yg/ZkuJWuPIOyvN
 l2fotRSG6L8tsLljnapq7XMRwF3btisNuVmzeo8=
X-Received: by 2002:a05:651c:c004:20b0:3ab:1d67:caf with SMTP id
 38308e7fff4ca-3acf36d91dcmr9350391fa.0.1794061498213; 
 Sat, 07 Nov 2026 06:24:58 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acf60c9cf4sm7125971fa.36.2026.11.07.06.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:24:57 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v1 2/3] net: mtk_eth: an8855: enable link error recovery
Date: Sat,  7 Nov 2026 17:24:39 +0300
Message-ID: <20261107142441.2104669-3-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107142441.2104669-1-csharper2005@gmail.com>
References: <20261107142441.2104669-1-csharper2005@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:33:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sync the Link Error Recovery configuration with the upstream Linux
driver.

Currently, the U-Boot driver explicitly clears the
AN8855_RG_LINK_ERRO_EN bit (bit 23) in the AN8855_RX_CTRL_26 register
during SGMII initialization. Setting this bit instead of clearing it
matches the Linux driver behavior, allowing the MAC/PCS to gracefully
recover from momentary link errors on marginal hardware rather than
dropping packets or the entire link.

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 drivers/net/mtk_eth/an8855.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index eb037ec1382..513f4534701 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -599,7 +599,7 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 	an8855_reg_write(priv, AN8855_PLL_CTRL_0, val);
 
 	an8855_reg_read(priv, AN8855_RX_CTRL_26, &val);
-	val &= ~BIT(23);
+	val |= BIT(23);
 	val |= BIT(26);
 	an8855_reg_write(priv, AN8855_RX_CTRL_26, val);
 
-- 
2.53.0

