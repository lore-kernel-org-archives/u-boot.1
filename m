Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E34C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 18:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2D687E52;
	Sat, 10 Feb 2024 19:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="eIyaEQ+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DEFC800D9; Sat, 10 Feb 2024 19:18:15 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5544587E52
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 19:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707589092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TY53IXtuWBTcqeztkKUQduWCo94M1KoP5ObaVMOAjQk=;
 b=eIyaEQ+3RQoDyoapJ46PNwcXJ3FNnbGdQvYXR86MozenlEP2nWlOmULzXYaBMtGhu16YXU
 p+VfvMVsRD7BGjOx6uTFEOPlhS7XEcBsqt4hzzQIGeHZWLQT7Nw0xEpNUZVsTDK7xg0ObS
 2nkZuuogFhWiKT8R5aqkVSFEcFBr/mJ+UfY6im/Biuw6lFnNM5sGDZqMfvna0CJ75Vh3d6
 Zb+4vCqMeyAgwlfKYLvfGAm8MsP0wStaLI+srU1hbsaLsTryxpo99NuUJE9D28nUucpcE5
 8gKakIVYRz+wh9X1kHcMvsxxfSj7wuAazBAH5j4182ROlsFiJTy+lEJnofKN7w==
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, massimo.pegorer+oss@gmail.com
Subject: [PATCH] doc: rockchip: Clarify the rkspi image format further
Date: Sat, 10 Feb 2024 19:18:10 +0100
Message-Id: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

As discussed on the U-Boot mailing list, [1][2] only some Rockchip SoCs
suffer from a bug in their BROMs that requires a specific format for their
SPI images, which was the reason for the rkspi format to be introduced.

Improve the description of the rkspi format a bit to mention this, for
future reference and to make understanding it easier.

[1] https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se/
[2] https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com/

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 doc/README.rockchip | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/README.rockchip b/doc/README.rockchip
index 84caff8a24d3..e0c5c395ec6a 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -649,7 +649,12 @@ sector is used. The header is the same as with rksd and the maximum size is
 also 32KB (before spreading). The image should be written to the start of
 SPI flash.
 
-See above for instructions on how to write a SPI image.
+Only the BROMs of some Rockchip SoCs, such as the RK3399, suffer from a bug
+that mandates the above-described data spreading, thus requiring the rkspi
+format to be used for their SPI images. Rockchip SoCs that don't suffer
+from this bug use the rksd format for their SPI images.
+
+See the section above for instructions on how to write an SPI image.
 
 rkmux.py
 --------
