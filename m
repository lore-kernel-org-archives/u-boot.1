Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B906EC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 21:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BE187EAD;
	Wed, 13 Mar 2024 22:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffZe8R2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F2B87EA8; Wed, 13 Mar 2024 22:14:07 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2D587EB7
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 22:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5683247fd0fso373352a12.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710364444; x=1710969244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jPP5cGHut8LW80XWY8BxuI4mFrwReLd8vC6Vr0Jk5Ak=;
 b=ffZe8R2vG73BpT64peXcflI4oc0O2GxWU8brJp6eoJYqK6a5rW1ZuBT9JDVrvlVei0
 JHnmjyjOrVY8JU742cq4W6j7Ozm6lXrABIErYmiYaQCYhPUM8X8QavG5HsBfU9+xxwvL
 k0q519o3Ti2R9GrEixrfastEFELlzjb7TBE6H+YrMXojFGlgSZnPI2Exd6uO7LJt8e6J
 kxh7MwZaQM/ipm+H75gja9+FzBlkro8hR2GbXDMfBP3f5HoyqmMVmDc5OsoV8yO1WjHz
 zjYW0dD2aaij8S0cI358BVAZJ56FP0ZJMfjCXUH5qxQEBSzAaSWVFJc2qaYsFTY5nC5p
 yX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364444; x=1710969244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPP5cGHut8LW80XWY8BxuI4mFrwReLd8vC6Vr0Jk5Ak=;
 b=EcFlSWgkXgXS1U2QaK2Rl6q7l6phkevPAZ3z0l7F+DPfOjFHXd4bEHqtForNaZBct2
 eELIb4bV0DlGQ+B77Labh8+mQfQr3/pPIfH+BFwYMsL5us42wa7QHdHyLpMvf8vEH4pO
 hEcr3sTm+TIryLOnCNYWNXu04ywkdbALN/rcFx7i/YqOntqOBdBT0bPJRdCO2Itgfgqk
 eWixT0vddGVlbxlc2B3q75klGeMKn/rkm8OXe5vyqIhEF2YEm8o7+JsGqwjGPC6wlyU2
 bRhidqVj6EtYMb194e1ZUgOCP+PuRxF4STpNOdVG5XCasr30NB5pOhm6JKHPgFMd1Rrm
 BqqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnocKnxgmGB2jgEOPVqjWMwi3hjEKxpDCLhtyi/A87+CiXvKVMd6TrpGLBANqSomzJyhv46m32MXrO2W+SwVKQvnPaWQ==
X-Gm-Message-State: AOJu0YzQbKrvkprfW27zko2yxb2Q1TMzVugrVb4des3VmYOnlSaGnGpI
 6c7f9Z2HbG7/S1f4UPF//a6ZqIan+8Bit6+bq7Hwr4amDpPDQwrS
X-Google-Smtp-Source: AGHT+IEXNjQUe0buc1z/0I59+fVf1POQwsQDgB5bcI2HO/uru1QJ1ouQm4pnEWRqn9zXNCV22d6i5w==
X-Received: by 2002:a17:906:a14f:b0:a46:5ee1:b9c with SMTP id
 bu15-20020a170906a14f00b00a465ee10b9cmr1798992ejb.63.1710364443575; 
 Wed, 13 Mar 2024 14:14:03 -0700 (PDT)
Received: from workstation.lan.schwierd.dedyn.io ([87.122.78.171])
 by smtp.gmail.com with ESMTPSA id
 jl20-20020a17090775d400b00a46497c74a0sm21984ejc.93.2024.03.13.14.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 14:14:02 -0700 (PDT)
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PULL] u-boot-mips fixes for v2024.04
Date: Wed, 13 Mar 2024 22:14:01 +0100
Message-ID: <20240313211401.253572-1-daniel.schwierzeck@gmail.com>
X-Mailer: git-send-email 2.41.0
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

please pull two bugfixes for MIPS, thanks.

CI: https://source.denx.de/u-boot/custodians/u-boot-mips/-/pipelines/19933

The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc2d:

  Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mips.git/ tags/mips-fixes-for-v2024.04

for you to fetch changes up to 6806a133cde6f99777925953ee046bf2f050d4ef:

  mips: fix change_k0_cca() (2024-03-13 21:15:40 +0100)

----------------------------------------------------------------
- mips: implement __udivdi3 to fix building of SquashFS
- mips: fix bug in cache init on MIPS32r2 or later

----------------------------------------------------------------
Daniel Schwierzeck (1):
      mips: fix change_k0_cca()

Linus Walleij (1):
      mips: implement __udivdi3

 arch/mips/lib/Makefile     |  2 +-
 arch/mips/lib/cache_init.S |  4 ++--
 arch/mips/lib/udivdi3.c    | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/lib/udivdi3.c
