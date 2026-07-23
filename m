Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06F3C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D9AD608FC;
	Thu, 23 Jul 2026 13:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGdpEOLv41XM; Thu, 23 Jul 2026 13:22:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2F32608F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812973;
	bh=vZJjrrfKTqE6TFhXlt97S69+zZSsGJ1OzQaUBSsZPVg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bq2YR5FdjUL5kRc97EFmDcSN7mdzkz0FAaXW7u38G4CILyHsp1Sf2XOaQGriEj4P4
	 vLlALFvAjDnEtr10Wud4mJZL5/OnFC2MkJgKCrnaQPAl4sdjktqc4JRpuBz7V6J37J
	 H2/6VBps3I/fgvAm1DBCLBv9JJdDZ6mWn+4qOjVmEwcFpQ//tN6X6QBpGEkFmYQ3oW
	 rhI2OsMXetCdREeGySojOf5ALsbQZ/flTYASUN9eDmBQ894vzyOwwMV5W+J6Zs+9n8
	 2c2N2xaHfIvNdVTqSINW2tVI0CEmAktzN+d1KrJKmyqpKxIyvVDzDlLdydSTeWCEqD
	 iaQKPrXu9S5Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F32608F7;
	Thu, 23 Jul 2026 13:22:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F15C82E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E29E480EB9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iihwQATDdOQj for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6EE9080EBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EE9080EBC
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EE9080EBC
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:06 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69f2c67650aso726371a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 02:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784798824; x=1785403624;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vZJjrrfKTqE6TFhXlt97S69+zZSsGJ1OzQaUBSsZPVg=;
 b=EE1KJij9GIepKglCvRo9t6LocmW8qudXEQnH0FOAkz2qpyMRVSYpfGQVrLuBbcOGKo
 qxsWWx06J+y7T9i77463Cq6kuF0YNw7JlhbzdaJEwFhqTPOOOUJr3yLpm+g02aqwKTUw
 ISnKz0Ll6VTCKicyLTGex3rLvW1EJQufhzWN9CAkKycSVFTVKaPPZ1nCGqbNdIcMFGNA
 68nX/eXDz9yZdWfdNntfy0hNrK2kPynT9pMWluCQ3MdC4QBw5aNTTaYG+mz3A+2eeBOw
 iW+CFfU/cOw/rcy1/ffN0q/QcGsbocPosZt+5HUK659Y/Z5mSi+/ot3WT3GvdqBWg+JG
 cnFQ==
X-Gm-Message-State: AOJu0YwR0EAp0IoprFlDkOctzqDMH3mwXYEvBcoC156CjtoNkivvfqoa
 RX+Wyflc6uzDfreu2I0Q3MKQrfKnBGCNa2BILsT9lL7IRMwaDtY0eOzyrfbvu6lZZeE/2ByvHSj
 ZvN0KxbU=
X-Gm-Gg: AR+sD1176gypM32VakqQJBtobDmMMQ/h1rh9GpdByBS5LjhQqwIyqGDOI/lEzYwOn+2
 4ptsMa13sjuOoHJ7vPnfEZ9IESfph3LCpS38gITXgWF4H3fbr5Fi81okVuW0XhZSVGu52uNy231
 7mAy28Gq+XPJMbXOalgIu6GHHlTJtoUaOwiek4i8JaHVRZiDu9PU421uEljWGDRrcku+GVLel2Z
 ZiYNhL+OqR7WcRGS0PxKY+az9OLIvYct8yHAtuN4w9BAAWoCaLpIcFf/xDaCyhfHH6Cf2qTavOL
 27dKjFpN1TD6+3Uk++VDe3Eow23nj6UdItDbDnEUi2LdAl1otCHPtPSwSoGodAPhnZe4Xg9xHgX
 nFYsSmwNurPMIOptzFNWk2qS/D0YbVRq9Eh3HnDizro6SOazjsUn9XSQScVWzlJU7rbj9fvI/4E
 fh0XZGv23dER7fFglTe1TJhToip/p8+RY8X4KYV+REMvai7bvQeg/ss4p1tOasUM+f/D8=
X-Received: by 2002:a17:907:c0b:b0:c16:1a3:9022 with SMTP id
 a640c23a62f3a-c1c509359b9mr124533266b.38.1784798823907; 
 Thu, 23 Jul 2026 02:27:03 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32af244asm206455266b.27.2026.07.23.02.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:27:03 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Subject: [PATCH 0/2] fs/squashfs: fix directory table integer overflow
Date: Thu, 23 Jul 2026 11:26:49 +0200
Message-Id: <20260723-sqfs-oob-fix-v1-0-4fb6d9a49e8a@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFneYWoC/yWMQQqDMBAAvyJ7dkETicWvFA8xWXV7MG3WFkH8u
 1s9zsDMDkKZSaArdsj0Y+G0KNRlAWH2y0TIURlMZVzVGovyGQVTGnDkDUm1d40NNj5Ak3cm1df
 u2d8s3+FFYf0/4DhOaEj8k3AAAAA=
X-Change-ID: 20260723-sqfs-oob-fix-e202a643c3d8
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784798824; x=1785403624;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vZJjrrfKTqE6TFhXlt97S69+zZSsGJ1OzQaUBSsZPVg=;
 b=0QG41V38EADnJd0RXs3PRtWUt2tQ5zMWLMWASsxlZoNOuaHrHKdqD+vIqOQl6oLbov
 Gw8OIVTAmOPJP7MHqJy3a+WdngRp/ogWjdcr3lh0A5Y9i4ZiPASEkmQgAUEgm4XCUZOE
 BqADa0lbgOLN3u0yBux6uqmxavvZoi/RHtCWrlWvo9LFluGoaKEK9xjKvcjJ0Jf3GjmU
 SslPLt9wG3IWWKOejRHY1r+lwC+6Y84PVkaDFvq3TfiY1qRB4vnIBJnQ/jOTPKJajLKL
 csavuycQ60i6FvWPnEwEbqcMWr96lmRHQ6fU+XneMPSompo763/uG1MooP6nXlSGzhgG
 67tg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0QG41V38
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This fixes an integer overflow in the SquashFS directory-table reader
that leads to a heap out-of-bounds write, and adds a regression test.

sqfs_read_directory_table() sizes the directory table with an int
multiply (metablks_count * SQFS_METADATA_BLOCK_SIZE) that wraps for a
crafted image, under-allocating the buffer that the fill loop then
overruns. It is reached by listing or reading the image (sqfsls /
sqfsload). Patch 1 guards the allocation with __builtin_mul_overflow();
patch 2 adds a test that a crafted image is rejected.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
shj (2):
      fs/squashfs: fix integer overflow in directory table allocation
      test: squashfs: add directory table overflow regression test

 fs/squashfs/sqfs.c                                 | 23 +++++--
 .../test_fs/test_squashfs/test_sqfs_overflow.py    | 75 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 4 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260723-sqfs-oob-fix-e202a643c3d8

Best regards,
--  
shj <shahriyar@byteray.co.uk>

