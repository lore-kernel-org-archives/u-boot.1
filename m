Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A525C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599F18880C;
	Sat, 13 Jul 2024 15:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WwlstKuD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eFpdjItW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F1188804; Sat, 13 Jul 2024 15:21:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E955488676
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpxy5hc9z9sWq;
 Sat, 13 Jul 2024 15:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMPnRKdHZpNdnpJADEUz1XkzlWIZMZa3Zwwsl+2JT2A=;
 b=WwlstKuDkpTwwUhK1v3G7ORk6GNkgGFqvmAXcs/2RR5cXtaDp0HpBVv0sqkXx9DqLiUTXI
 oDu/epJXHLU93UTor0r+PnsTCuow3MN/q4OfTIHhxOheWAO5OoN+YPYpiA/J7qkH7bqnOx
 RsAccDWvTCsUUxpPJfTXdJSm3QonhBe6wO8HbFCUy8UG+PG4+UfmZ5zP3w6XLhUQ9Ah12k
 fcpfjxfka/9IebbTaRLhVKQPyC/iuqPfPooVqMBi1GwL/a2oAmKwfMSz3xOMzvRRFDxrfs
 hpsI21WOQL2ZHewXIVi6mSM6NHaNrnPA/X5+DvT7X11syKYFhbQ1HlGyMMG1lw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMPnRKdHZpNdnpJADEUz1XkzlWIZMZa3Zwwsl+2JT2A=;
 b=eFpdjItWoW6BWd9v5IPysKFESXtoVnEYC+DQndVIcWJA0MX9pSDOLzR0cEeBON7p1bIfdc
 x4ckYpGIM2BsamJEICEKWxQCS1yUaP3trCk5VJmGcrNKFw4cHLIB9Ok5Z2sB5StuFARG5r
 Er5lk6PQ4a4aSHoX2iro7VrSLEOKD5Pl3x+8d81EWiWOUvgFEpZ/azzs7AZICKoKv+Kd9Z
 762UllIc15s9LpiEqYRBn886rzl5YRPeR1Cth8y4+MxAmz7BgZxYbACvcUpEjLt1GBmtm7
 M6587+cCIx1QqT3rwEoyVLSBdNh6ZqXDe7n+wrKsZAzO2b2q06sHSOJAb/fyWg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/45] arm: dts: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:55 +0200
Message-ID: <20240713132021.57650-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e4fcb8a3419d001a46b
X-MBO-RS-META: dddgxut56qgnznus6e78i5ik8n18q67d
X-Rspamd-Queue-Id: 4WLpxy5hc9z9sWq
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/vf610-pinfunc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/vf610-pinfunc.h b/arch/arm/dts/vf610-pinfunc.h
index b7b7322a2d1..6775e4e3371 100644
--- a/arch/arm/dts/vf610-pinfunc.h
+++ b/arch/arm/dts/vf610-pinfunc.h
@@ -20,7 +20,6 @@
 #define ALT6	0x6
 #define ALT7	0x7
 
-
 #define VF610_PAD_PTA6__GPIO_0			0x000 0x000 ALT0 0x0
 #define VF610_PAD_PTA6__RMII_CLKOUT		0x000 0x000 ALT1 0x0
 #define VF610_PAD_PTA6__RMII_CLKIN		0x000 0x2F0 ALT2 0x0
-- 
2.43.0

