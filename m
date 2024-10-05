Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5628CFB423
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 17:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70099889BD;
	Sat,  5 Oct 2024 19:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MCKJu/24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 062C0889C3; Sat,  5 Oct 2024 19:03:05 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE078897F
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 19:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so4224257a12.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728147782; x=1728752582;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cyFloGHRgea2WGeAx3KhLkFnPMpq0xrYxK42Q0gH23I=;
 b=MCKJu/24nbE3aaeWegQTLrvdLEKdpn74y9toY66GMXiDfhUES53Wq2nw/tLi6pG1+u
 w4I694qyN5ZfxpJQc+Dukna3CQ35yNKcdL5XStTpDXN92a/Kfr1zr2Uo3Q9vyViqcOWT
 911hn+fD7AitNjl1KXDt3b3SYX61CyYG3S5zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728147782; x=1728752582;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cyFloGHRgea2WGeAx3KhLkFnPMpq0xrYxK42Q0gH23I=;
 b=D0UUo3Pt568R2Ulaz+92Wv74lQZdY2mxu45G1KNKmYA+SWM6Z7tga6qp/HFNRWpThu
 gAHYmt+jf+abSBpwNHnsB9eedw8r2N0apeGQlYHk9/cYVsXsgAbGw/TfJY1o8MpYE3se
 47zuHULnNK0KMz4DSruVTWsrWy+20MBlYuKXoJh1ZZP59y2yOsPo/bsuQ3NPNOV73KHV
 9ZE6JQVNnzHXNkHkdNUQLOZ7ScxA7syg6q0sDy1QeivDlJQLqbVdJNKrpCHrYD6vbaR3
 VcjD0cUmjwWNJWQk+lhWVZFzea80HYS1RxHHV09vaXW/JO7wKZn3Zz/Xa/97x6Of/fXL
 hzEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoddnnTMJCQEvXR33yVH28ttcCV+XQd6bvH3Gh/CrM+JnTHs8GQGTmm5oTKpB3QSCgWKgPEcY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/i8p4tCSuvw6x2KdTe+Uav2P3VxVAu0A94Eyk4peXeTF2+4Rq
 YoDPw5hVQAImvS8GekToOC3Y7YVUXtv1qMCBomvRCrEPLT2jHL2nELs1S8EhlY3ijeIy8Y2+V8V
 fhYWkNwoGfHdV6cYGurFE2U2GMi+nki10DpJ1xA==
X-Google-Smtp-Source: AGHT+IEKVRxw0h+HCgHvMK6HEcDMgAOWTVS/dEPfVQ4wMrAqa5lz0zJ3FNMT2HDwQYTjofsLV3o65T0FeaS2Ak/Ssp8=
X-Received: by 2002:a05:6402:3210:b0:5c7:927:6a5e with SMTP id
 4fb4d7f45d1cf-5c8d2e36dfamr5092667a12.21.1728147781881; Sat, 05 Oct 2024
 10:03:01 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 5 Oct 2024 19:02:51 +0200
Message-ID: <CAOf5uwkVkZAz9d1oxW1EL+qYjWjm4mzfwxhLQ6nYhxQ2Yd4uCw@mail.gmail.com>
Subject: [PULL] Pull request for u-boot-nand-20241005
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom

The following changes since commit af69289d61876d8e62449ee2da2dc6683bcb8198:

  Update directories for new name of TF-A directories (2024-10-04
09:00:47 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-20241005

for you to fetch changes up to abd7258222188be745b6f3f698dd983d6ffc5755:

These are a number of assorted upstream Linux fixes to the
BRCMNAND driver.

This patch set lowers the hamming distance between the Linux
and U-Boot drivers a bit as well, while we deviate quite
a bit it is still possible to bring fixes over thanks to
exercises like this.

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/22535

----------------------------------------------------------------
Linus Walleij (1):
      mtd: rawnand: brcmnand: Add read data bus interface

William Zhang (6):
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix mtd oobsize
      mtd: rawnand: brcmnand: Support write protection setting from dts
      mtd: rawnand: brcmnand: Add support for getting ecc setting from strap

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 209 ++++++++++++++++++++++++-------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h |   2 +
 2 files changed, 166 insertions(+), 45 deletions(-)

-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
