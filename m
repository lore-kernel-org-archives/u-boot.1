Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D76606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=maoOO6yC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52732408AB;
	Wed, 21 Oct 2026 14:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7TbNlT6cO2B; Wed, 21 Oct 2026 14:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E3334087B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591760;
	b=KD8lNwJ7PM7few4UvFCiPWpkLJ92GXgz736oZED0FJHqdFcQaOEtJVzxXxtbC8EZoJhB
	 wrnPtDD/mVA/cw7+Q+BfWOHIkCeSaZbQmDx6cs3GuT/xi5RSQEZK4SOZco4AtUUp+Z3D7
	 jyJc+8DrIHU404k98VTGi/6ul5PycSrJSAw9uOquK+gQO2k00HrQKKjEPotPReN/Kp3Vo
	 Hvx/NTJLgURCCbvKpCT6BfdC/fQ3SE9ZwbAgQ0hq5JRnemlCCvcAujkSXuhhMw6QJeH9S
	 zqfigx0CeTpKp2+N+z9hUn2rbBcJ57S2+8y1Ne35WGpeQPERHhwh4wjMqEDS9FAD14A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nd9YTKxOIEr+z9XBghqxmBqquME0vlDaAg01B1gCa68=;
	b=TwBKf1h4AeIXw3E6Ch65tEw0pnCw5/BqbEGr8SNNYLsxC8h8ZGRxY0VXJc2GsjPBD/Gw
	 BA4VXtloZmUhqjwRvWZpjeCyBjd79MXAnGqmJ76o9wvPY/rEZ9aQztDWzUV1Whe908yxc
	 nhSV4rqITconERpBcoqERbkQZhRUx4Iw2ebHoJFASdBe/Zy3Zrs3dv3FIDk8wwlFZ5xHG
	 61dbf1xX/qlTeyLnbFG5urm1P2I1W/SxTcVD/Kxlr8533R9ffdV7GT+N3cYZBoCmuNcAt
	 dZmPcd8b71Dx+ZYTGpTLKhd9Q7IqqSA2FTFcEFosA17prhG0sY/hFoYP7LsDVu93z2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591760;
	bh=nd9YTKxOIEr+z9XBghqxmBqquME0vlDaAg01B1gCa68=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=maoOO6yCIq5zuj5Uvy7OlFkYfPBlrDXi6BKUlFteGNcFYH1waEs40g4JA4V2C/sej
	 6GnjP1lj/LRpytUhon5AZjAp5pVVf6mZNTmGGu8hiNR1yWnm6NWeLNGQjMwB+pIT3O
	 uhgG7ZfLAfR7lTSNn1ucUrVPicoTPWla+y3R5QmDqz9e76mUP7qveD5UyeAdG2mcV4
	 1EjuqDwb34lYY8J9Crkfx251r63LCiWwOFgYaYuv07eS1XUYSclQmrsPDlRBYuzfPl
	 uWoJkfaaahpq3q6cHUWmfbtoDYWEWs0ZPx6qGADIydPmgvGWJHJexJOUr8gePU+I9x
	 JlS3fBwhFXNSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E3334087B;
	Wed, 21 Oct 2026 14:09:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90F39765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EA564087B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qu0HgG0OL7fu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA5E140593
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591756;
 b=rS08w8Ia2A63z9Buk/e1PBy+82sJ+untVvvjxMsJunNVWW4hQvzAWzGO8qMkpW1z30jl
 U9m2OM91NPfjSH6iA/VSrxWAHd2Jl/SAtf9E88OSnMkqwIPMTC0jcnKt86Jfdec/pQVaj
 ckD/TA2jusM/VoPY6DmE6Vui3t9TXI+TqALcdBrJmnnWu4WaXQkZGmFSZHyUGMFJUv6P9
 E/zagKFKmuafYPY7dxxP0DZVkaewEvWTQL1+supHzbi5+u2bIb4Gy2XP7nWyEGRAbQyCO
 3J/cYLB9QrUn4SiMjFhEpfepz1BszXhr/OH6g3qdPD1hednp3FE6fpIUu6qewdqxjkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591756;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=nd9YTKxOIEr+z9XBghqxmBqquME0vlDaAg01B1gCa68=;
 b=MY6XxAcN5E1zkEpVTO1SSk9zo7Yj17+mKtaoLPcGdLLEPmF28sgCC1kmWOuJy5kYZaP/
 iQ/qKMCEgavH4WA3l3c77wXi3MFL2fqd/Kjqmu8FgJSpy1AQwH3vrlKDIl7gXIb4VZo3Y
 0d+1YWzDLQD0tAemqtXRviRkV8y1b+243KQXR23Rsx32iSRGNHrrM8/1rH+jYQgqGFV/W
 EhuybuZDLaxj0AslLUsTbMacMCTc5RC5w1dhwTIHVvAHdvYB3xahoHGnLgdu96sdyKx9F
 /BUrvA3XRd6aEVOjMkpQzcvOmyb5JmM1LFh7QVjIKHBxu8/XeY4Sej9unLskgrs6TVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA5E140593
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:15 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWx3-0000000022W-3Q2G;
 Wed, 21 Oct 2026 14:09:11 +0000
Date: Wed, 21 Oct 2026 15:09:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 01/11] test: cmd_ut: keep the suite list alphabetical
Message-ID: <e4f2983b7f1c87de4214bacb5e058dc555819867.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The imagemap suite was appended after setexpr in both the declaration
and the registration list, which are otherwise alphabetical.

Move it next to image_fdt.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: No changes since v1.

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
