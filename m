Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D66CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE4D8490D;
	Wed,  6 May 2026 16:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WN9FzMoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137D584915; Wed,  6 May 2026 16:47:35 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE3084903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so4734715f8f.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778078852; x=1778683652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+UDffy0hpw5SJz6RCKITYw7N+TcqiyCpk2SzhPbh+zM=;
 b=WN9FzMoEzrKRjTs+8l7vj7cmsFZU/wmle5GyVnWS1JbuhKLMGx6bo26Ni/Bj1Kn/MG
 cLtfOUVHtJokpNMzsg08aLN3NEaL+kT/pfLXb3Qn2yeHJOVgZvbj4Eu7RhF3CNtsfCXO
 e1pswFYJDzYu3BlEy3gI1eERXzzuMdVGeyxN34ctsSRyguQEKvGAVECfS6DzDzrJCUa9
 /m6dkFfScrXBW+TAZt26aIZJOIfRq1eiwt/vPSZcbCbY5Ueo+y3M9zu7uuyKVdxPSoSu
 ZsWFGOJlJOgx6MFjvTKb+pD7dXkNxo3SEO3CcDNEANmGG0ljgfYl7wugNpg3iTSroN2A
 DW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078852; x=1778683652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UDffy0hpw5SJz6RCKITYw7N+TcqiyCpk2SzhPbh+zM=;
 b=W5vx++bfz7K7Qs0EDSyLV1vLIxbpSu4r51jZEeYXeQZKe1azhP/P2F2eVUeMmutRB8
 gaZWMueov0dz/0Ck4DbhnuN+OlqTyNjT96w30Gc1BjY+FnTTv03w73MEmmcPa14cQcsZ
 8HfZvDdHAjYyobkI9SZvA7BfUoUR/2B+2r+mNDlZyX2MxMa/wbcsxHFxTxbRb1l/AsCO
 XVMi5bkmPt0N804WEviVtCJueUqFCQNm0cbQ6p5nifb81VnVxMatA7kIe1TbttT87tB6
 h5ev3KBip8Ddlo/P3DuIZrlPHL8HZO69hPlqX107IyT5eRJw6ger12tQh7ss6/jCf2/o
 mb3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4/jemGmIvp3RLdcA/+X/0fGWE60p6rmTGNvBY25/iYnrAN+20eXgQeE1uX2MqoKymWbUkIVs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5amvEZVKfuz9L1pJmfWfHEbquDHq1nIQNcABZWsNqyJPB0ysF
 AfNklODTuq3ZgCBzb1aGiBoszS39SnTnMKGzwnAF/F2xhbWZ8TO4rvhLh3agiw==
X-Gm-Gg: AeBDieu+BqZOgUbcTOih2X0kjRV7QCDZqN/x2H/f8mqnxjbimP8HnpgGJHuoBzZ9/tR
 /NUJCXEX5YEZqetooRbpFCLcq36Ct/DAOpk3bSoJ/tAEydG/1mt9htQuf/8ypXDsLeukkPGyTmV
 t/uk/O3qT3ONXo7pe+ueVGHDzPejH0W6FO9ynys5/RFz3E+vudBZpnuYXywx8S+GnSmAZGVxLz3
 Jsjshc50/jQstw0f+zrm3EnWL3JerCRGwBQaIsTOgNoN3S8YeOC3EHfb8A8q+roukIlbUybeNAX
 CBLUJ5M2ljzeYiIw4MPIorcfpOKQaPCBY2RnOKTzsruPX1/LwQihzjqppffLc8BWMhDuTfjS+j9
 wpAzqx/WF/lviZfTJurMRm2+gveTluVRfhq0LddqsCj1NMzFOQ7/I7mMSapOBQatNVi+8ZKsMff
 G+m9VPu1T+5TzhmIK0iU1Blcepq1rcO8y+udZRwj4dYvdoEB8uMJ2dztBmz/A1tcRTiQj6YKc3f
 g==
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id
 ffacd0b85a97d-4515df65daamr6226919f8f.43.1778078852151; 
 Wed, 06 May 2026 07:47:32 -0700 (PDT)
Received: from workstation.lan.schwierd.dedyn.io
 ([2001:9e8:9c:7110:7346:e23d:5001:3678])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02c5asm13000314f8f.19.2026.05.06.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:47:31 -0700 (PDT)
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PULL] u-boot-mips fixes for v2026.07
Date: Wed,  6 May 2026 16:47:30 +0200
Message-ID: <20260506144730.168827-1-daniel.schwierzeck@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

please pull one bugfix for MIPS, thanks.

The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:

  Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mips.git/ tags/mips-fixes-for-v2026.07

for you to fetch changes up to de79075f0f6b8795d1f9e30ff36435583b1a119a:

  mips: mtmips: align MT7621 image blobs to 8-byte boundary (2026-05-06 16:20:27 +0200)

----------------------------------------------------------------
- mips: mtmips: align MT7621 image blobs to 8-byte boundary

----------------------------------------------------------------
Shiji Yang (1):
      mips: mtmips: align MT7621 image blobs to 8-byte boundary

 arch/mips/dts/mt7621-u-boot.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
