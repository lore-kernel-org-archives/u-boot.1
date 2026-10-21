Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A42606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=STiJCGco;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=RDo86QGE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4A2F6069C;
	Wed, 21 Oct 2026 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H9tghjyVg-In; Wed, 21 Oct 2026 13:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7157C6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792589272;
	b=nU9JeneEA9RH8UG983e7ToU/WKZOjFjZf2fahK2Xb1keN0GyaG25ydR1+i6PP76a9BwK
	 d/D0/i8QvxWY25RhRyaHMgZUqAI9TJwBFxLfCnQAMl1LPnssQk8DOfXCS57BDdMFa094Y
	 Yhlr2xCku/B8UXM5yNq0yV/WQ6ChfWiwnSCbbgupnCntwjgk7Y8O80w5psBdAeKXCUp28
	 45lkViI2dQoY3AxgIvCXmr1QOt7nFIkSD2QCMn3GlQkzsMmQgDn56w3MZRtyHmBaj2gjB
	 f6obia8uJlZiJ6OuJvSTWVKHmhoPkn8D0yqVBta68gMXKrcZH3dJpvcjyU7bCCjKR6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792589272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MmI0EUsstvFiBgmKjT5HShNSpe27Raf6BDtT0JqWnO0=;
	b=KlJD8lhHkWw67k6e0apZ0qd+ApIHuwz27wH9M5P5JSJ0AWEBxduATxRRNISo6Pxh/SrT
	 qPcoYx+jnknujd1K/+8dNGBDG1T9TXs03ts+1uUMbRmSAFMxEJsK11/ZSyozieBEW2DS8
	 6uPx20ZPEenMdY8hOrzVyTul+o980JrwyzHaxdtMALx1x8BlL1yHRJIhUaBQSv7G32Hnn
	 kqRsbJ0/c6P6XwOkM/ikWcv7vXRcFzzXjwRUi6IzDI8Wi673nd3/pGalSMYBeh96BbKBC
	 crW2MIJsrLAj+aFwxLlaRt6ZNaCsC6/AYFLcF1d2Hi7eUf9M3oBa8AfZElPrCVymnUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792589272;
	bh=MmI0EUsstvFiBgmKjT5HShNSpe27Raf6BDtT0JqWnO0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=STiJCGco5vwJSiwQkihXPXZ+dOvZfXQxSS+rPumKZgf+OhD5vGWBbnG69wmgtNJDw
	 yrQ+PSrhHHGW1cN61mJf/VnO1cMUu6A4vgkelYCEevelmprhDDIGMwv2rsmAtGB8N6
	 IAuHJ/W8VGJTekXohTwWwrApOsysYTyvn9i8fROZjtTpduu/fu4MD1TMWU2VBkKEJg
	 /kDDEy99qYOECIkH5bh2RGAYNo3aRyc9CJ8c/7RU1C5Rbdk8A8ra+lDQD9LQxGGYoe
	 Rs7vYXbcK8xostpdQciGJbFU2ANR6Skik7YKJN/U/foBqYLxBdRmrpIQhf1eyED8I5
	 cRd6n/TxQbmEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7157C6070C;
	Wed, 21 Oct 2026 13:27:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7CF92A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9F14408C3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBFi4BVn-iGJ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20F5340895
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792589269;
 b=cdc4iqjAaikXwvUTflN+/n0wRgG/KdeqlMpk1DFcSQjup76Qphx2+kAmI8wqvjJ8gm0M
 US3XlYZj81aNA5RszxJC2McoKBurbwp/9dR+dUk+nBfsp0xYoaIAjk6ZJQ4rchsP55laQ
 utMNviDHGFCyPvqghwUhtnBgKYQxPZDs/TCYRtikOFoQI/MCbEbZN3SSL+Anc7+gO04sd
 1c2ukQH2ewrXz/u/+lZV+AZCrq7qHy52Y+98dIr9ZY8u+6viN5j0GiWJO+4AjeqbTtg0T
 PNu2EnnkDK0QXAy5hJOyJJnbyWqnn9+qqxwLCHmnsX8zIbjaYtxAag6socVcr2rMfVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792589269;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=MmI0EUsstvFiBgmKjT5HShNSpe27Raf6BDtT0JqWnO0=;
 b=deIxEE5UKb8ssyHk0JDu6FqPS1+YwegRxE6Or3fxnbj2PyQkxbgM+WwUYV+vx+WPTexv
 Ov2EKkbkJxcpFrJSQ4y17JTfbF2zlzkGY++ybfpvOjsmLBr0oiVcsRHSxvcSYO4JcjgLf
 BWdkHSQsczoa/58spWL7GpV6uIDBB9fzYx5XwZGwbgtVurDC+4EROdAUycg/p2NA5MCK9
 FXojrzpcN6Adurb9bB7RkVVM7QnlAbSopO9DVCk8OYSqLz9+bhrzVG0rLamxXa0sghuvM
 N9lep5EJSIW+/354odfdkNWdyZfyDRdQyiQZzm2rANOM8zSdydZw1cyIi0USZ4lmcsA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=dolcini.it;
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=RDo86QGE; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=RDo86QGE
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20F5340895
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:27:45 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8137E1FA93;
 Wed, 21 Oct 2026 15:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1792589261;
 bh=MmI0EUsstvFiBgmKjT5HShNSpe27Raf6BDtT0JqWnO0=; h=From:To:Subject;
 b=RDo86QGEncIjLjFm1khYeFkXZErpvfk0lBBJufLGZ00/LpSnPx2VI879cTHuS3smJ
 8NNp0TYcxD6ZMuuDi2d5FVzbFKw30CCIWbgHwGnMbdcAtzVlFInPxoaelnR8RjCr7K
 7heN9E/cg6z8TmQR8NmKdw8HRUpqk92DlCBP6ED+Tio4d0qUwNa+lqxQqR8+eDlyRX
 RROWIj18njcnSydBzo+OrZnPu/vOpF4+3S9vdHIEeXOGNbhp51WRbSPMHOJa6mE2AF
 MVhM3PkJahfn6Wlos88y1xiz2FshmHj6cx+rdJJhQy73AEILNIlrj/M1yfLsOazP/7
 4jMPYmBQVhVDQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] imx9: scmi: fix up thermal trip points from the
 temperature grade
Date: Wed, 21 Oct 2026 15:27:32 +0200
Message-ID: <20261021132733.170201-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Adjust the thermal trip points (a55-thermal and ana-thermal) according
to the temperature grade of the SoC (automotive, industrial, ...).

A zone missing from the devicetree is skipped, not every SCMI based
i.MX9 devicetree defines them.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/mach-imx/imx9/scmi/fdt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/scmi/fdt.c b/arch/arm/mach-imx/imx9/scmi/fdt.c
index a1d9afbf69ad..be4927fdf173 100644
--- a/arch/arm/mach-imx/imx9/scmi/fdt.c
+++ b/arch/arm/mach-imx/imx9/scmi/fdt.c
@@ -620,6 +620,18 @@ static void ft_disable_periph(void *blob, u32 fuse_bank, u32 fuse_word,
 	}
 }
 
+static void ft_fixup_thermal(void *blob)
+{
+	static const char * const zones[] = { "a55-thermal", "ana-thermal" };
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(zones); i++) {
+		ret = fixup_thermal_trips(blob, zones[i]);
+		if (ret && ret != -FDT_ERR_NOTFOUND)
+			printf("Failed to update %s trip(s)\n", zones[i]);
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	/* Common peripheral disable fuse process */
@@ -628,6 +640,8 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	ft_disable_periph(blob, 2, 3, f19_grp, ARRAY_SIZE(f19_grp), false);
 	ft_disable_periph(blob, 2, 4, f20_grp, ARRAY_SIZE(f20_grp), false);
 
+	ft_fixup_thermal(blob);
+
 	return 0;
 }
 
-- 
2.47.3

