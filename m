Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F82C369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 06:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2D181F66;
	Wed,  7 May 2025 08:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="Niap6ivW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE8481F66; Wed,  7 May 2025 08:07:51 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3690F8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 08:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746598068; x=1746857268;
 bh=VhCsUkOO1TZbwrUsOfcBryjp7jc2p725231o6tvw8n8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=Niap6ivW1rgmE6+ALI52Ztkk9lh9KSq3oLmF595id4TvPr48WIWD7t7McSY2vaSRT
 uemNVOWKgrLI907aX++cXDgwCRcTfybi2r+ub8GA07+2vJo+aPD5aOgHzyCb08s3XB
 RbvgkabSGOF06SB9Vhyyh2+ZHLRpbk8y8xJGinq1DHesGAFdm1nspwDwnfOg2/TbCl
 tXdVMVJBIcC26MfT3+SUV3SvdOONQqFxVqmDErqiPLzZb22iB2HbeTsHdX9dcWhnDA
 SbeTU//k486bXON+wP7//I9fBNwp4PexFoEpRsfXX8KlBP8rk2p4kPl7ky0xP0D/cr
 LrVbMmyQMFD4g==
Date: Wed, 07 May 2025 06:07:42 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] arm: add required assembler directive (binutils >=2.44)
Message-ID: <20250507060739.326096-1-johannes@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 6a5d5a51dd643946e4060641f8a49c6647d48024
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Since GNU binutils version 2.44, assembly functions must include
the assembler directive .type name, %function. If not a call to
these functions fails with the error message 'Unknown destination
type (ARM/Thumb)' and the error message 'dangerous relocation:
unsupported relocation' at linking.

Johannes Krottmayer (1):
  arm: cpu: armv7m: add required .type name, %function directive

 arch/arm/cpu/armv7m/start.S | 1 +
 1 file changed, 1 insertion(+)

--=20
2.39.5


