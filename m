Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161C2CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC8F180D07;
	Wed, 14 Oct 2026 08:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1kMZN_8-X_x; Wed, 14 Oct 2026 08:39:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2D0780A92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967140;
	b=l8Ko1zsnThYLIvRGqHswVakp/4PF4VFwEECqhQzI6vTn6dRKFzg/kfIoYTNAe7/5xGJ7
	 xW+XhcWM8q6VXk7XYNM8SaUZe8R1RNlQLgIZCgcJbRxv1E9gle9xuQ+1j+W15wlHvep28
	 MHRdRHij7S/2ShobB87QhIAlm9HIY5bcfLH2BsA/imr8FQG7XOup6t7z2VzedQQmUr3i9
	 i8F6fuAyxOkV+6Hqn1beBIB65MuQ6v4l2Ah2193bzRGnylxQjtZar3j6OH9NQWWflREmG
	 4MJOOqY7QxucgaQZN9hgvKUrkwyntmn1mm6Snzarg1k+4yBotgfqNPk2h9euF8LOCOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jBe4Y1mUBrNRm/ZJdb4g1wT/3BuMzVA8Bw39Ebk+HVc=;
	b=QQ8P9JBiLuz13OqlYBElJ+ISGELtVtK9W7Xuyga9QeA5b8MifZx+ylX8+ujo1cCcJOIv
	 YMT8cUjfCgKovfqMKouvxmerdK8GiDjUSnDoFQRfl9pu43MaEnyaKbKn36pexsPRkyzMd
	 M/Kalkv9DTCRNvgq28EuoffpVAqX7H14w842wLykOOiie0NbVNjXKZ38+l/WDxnbA5KZ/
	 98oubIPa3LnclJLGlH89a9FWthMxs1xpcxl0HBYVJ6B9xvkeG4RfzH0+72/OYCuC5cOT8
	 YH6JkUZEVVZZMfxLY0k2yiu5zFo7ktHXOH0QrCPuqZ5L7ZjcjrcClSm7V+g50GOfITg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967140;
	bh=jBe4Y1mUBrNRm/ZJdb4g1wT/3BuMzVA8Bw39Ebk+HVc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7qjUTuWmKKNqnjVswGGcsf++hPQscJXebmjV7ac5f/5+KKAmuuces7hHHDfw8yco
	 PFZrXRSpmXjYyvPTnGwnwW7eiJruMJa7H49a8liKQp/YBJF0/XPiMBELQ5kAVY9smH
	 0Ag03AUx+wnDUVo5icBZ09/3Dwz8esXTnXikIP0Nati5qf/XVZkkuZ13S7vyqJOB6P
	 NGw9JPfolI9jluMbfvw7PjJMzuyl+taq3hmwSFh38ewc+1j9h7jZPq56SVm/N6sOJA
	 bAYbNDnfDMeCLPDjtLCkCrjBGPlu+EpDaN5nON+OotFqzy++e1q5mxL+A31m204yOa
	 493VQyfs5BW6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2D0780A92;
	Wed, 14 Oct 2026 08:38:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD26F235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2613400B0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqnH5lMfzGF0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:38:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BB68240079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967137;
 b=Kh/waczRJ/LLF2XNRHIj4zUrA4ftq19cOThlaXtm+6tnS6VarmwZqBdut+pKn6dNkmy6
 0um23NY7SslC0FSlfSuWyKVT69aaozRNasgq8B/c9pNQDAswa0kDhIKvyCUN8jDrdjyGh
 v9ZBEGeNrDtiUr633WJ+eFLD7hZR/yVoEZwQ4VtlpLutuWXAMamjnGlD2SjqmGqErD2yj
 k+/NdTThfnqi0vUCGaY2Vgzkiuea4bU7JX9v0RJgN9nsMfvBnh7Iic3KSHV1QcVcS/3JO
 G1VXaZnuxdDe06m3sYH0HpoFClgMNg1mD8X0tXLL0DXAhMf1J9DjgBypM+VT/KyIjpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967137;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=jBe4Y1mUBrNRm/ZJdb4g1wT/3BuMzVA8Bw39Ebk+HVc=;
 b=PXkORRX8p58bGj3S+/CH7PrxRcShQjkpOkKHexY6aKP36vQk5H6lfqpTmC3qE4YM5yWv
 SF6OjZkhU29cdYR5HlfmePtVPS49bKjrXVHqliY+XB2BH15+5gCCS1FLduJyBuCqOA428
 l2Yy++sSb9l9ltU4CB6dQw3g/eWT5Hgao60Av1Oo6x0FcL5woHByuoz6EQITblGerDvCZ
 Mj2pe9IpTUmR4YLN/Vh2L8v8iiUIbB4xwJ+JjjauyyXxoWibGTbFGZLXcnLpp5Y097BTG
 W+Rev+kvNmTSkvUYcDmmb6pBEMrQ9BTgBmnQHJh6Dcuvp+1VqUd5FCA+KfmDivJtdqQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB68240079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:55 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuVf-000000005ZT-3LaY;
 Wed, 14 Oct 2026 08:38:51 +0000
Date: Wed, 14 Oct 2026 09:38:49 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 01/11] test: cmd_ut: keep the suite list alphabetical
Message-ID: <c2916f5e54965c333e3906081d4128c77ad5d111.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

The imagemap suite was appended after setexpr in both the declaration
and the registration list, which are otherwise alphabetical.

Move it next to image_fdt.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 test/cmd_ut.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index fab55d5be8c..966cf44c511 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -64,6 +64,7 @@ SUITE_DECL(fit_verity);
 SUITE_DECL(font);
 SUITE_DECL(hush);
 SUITE_DECL(image_fdt);
+SUITE_DECL(imagemap);
 SUITE_DECL(lib);
 SUITE_DECL(loadm);
 SUITE_DECL(log);
@@ -74,7 +75,6 @@ SUITE_DECL(optee);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
 SUITE_DECL(setexpr);
-SUITE_DECL(imagemap);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
@@ -95,6 +95,7 @@ static struct suite suites[] = {
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
 	SUITE(image_fdt, "image fdt parsing"),
+	SUITE(imagemap, "imagemap on-demand storage loading"),
 	SUITE(lib, "library functions"),
 	SUITE(loadm, "loadm command parameters and loading memory blob"),
 	SUITE(log, "logging functions"),
@@ -105,7 +106,6 @@ static struct suite suites[] = {
 	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
 	SUITE(seama, "seama command parameters loading and decoding"),
 	SUITE(setexpr, "setexpr command"),
-	SUITE(imagemap, "imagemap on-demand storage loading"),
 	SUITE(upl, "Universal payload support"),
 };
 
-- 
2.56.0
