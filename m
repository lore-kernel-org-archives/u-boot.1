Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBFC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB3646088E;
	Tue, 28 Jul 2026 12:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brcRoNcxYV9h; Tue, 28 Jul 2026 12:59:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C66916089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243593;
	bh=AQjj3s4eJWx32+swxeEncfRdIqPD/TLOAg8npvRVFKE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y87sEshN02t362EbAAHwVStrvSy8uEKx56lRRYllh7sp5vVV+I6HP5HQcsmh/MnVT
	 1dWiULVuyaqP5j5XF8RhsBB2L4F4vyl6LXbhC+v+XeuNz36zXj5q6tOLZHJyNdZTll
	 bOTSw5jZmc7c2SSGiEEgxeeUgNtvun5Ki7IGvjwe+5c/kEyIsRH+86Tn2fSt1eNtsM
	 ooo33vFSLGlwEcIt0xsRFkV4vYwwMPgeh+IQB41w02t2TVusEWgSXcw3j7bBllaCTP
	 L5Eog8DE6BYDpLCk/4Xe8qyyVAueaiC2xmuYqvW1tmWdWlS7AcgFzlgpr3cH2SXuI0
	 n99XKzEP9aKlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C66916089F;
	Tue, 28 Jul 2026 12:59:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EE8263
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BB7F40245
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2ie0t4GYzJE for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:55:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F3F6F40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3F6F40042
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3F6F40042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:50 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so5728083a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221749; x=1785826549;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AQjj3s4eJWx32+swxeEncfRdIqPD/TLOAg8npvRVFKE=;
 b=p1b6lwwqNV5bgGX7kxF5euWDD/jg97zOSoe6S5RZmoby1DfY7mYFCalAFIkK6eX2Pp
 +RwedeTFRULn3q5ybGQL4rMh5RTkf9ad+Tvr/QcIoOZbfo5wR4K5WAXCvK9wFWkjKj9T
 90eM89ziHKePmwKtAYouq11c07WY7HKYyBpyl2g5deZ/dRHwIOD67tucZRYU0VuIvo0R
 BgZEyqi9QHWT9Y36MoU5hyAv3XvyrgrKpHYyJnhMixxaIPb8gayZqQ6T7th2D0fSAjG4
 22Fpmb2u2lrDH0u2g8epgNB8x5UAngraERW59rR9/s+UjBxPqtKO1Pu0tI3QaiY5wXPN
 i4cQ==
X-Gm-Message-State: AOJu0YwGCVBccCazHMQI85aPJnwgR+unaZeiJW03B65CsMZUcprq6LPX
 gn/hlMkRGxdydZsbUA/DeXVnFvrYFZv429wTs68hAxDFEz+wYc7rWhP5X2+Bc7DOLRA=
X-Gm-Gg: AR+sD13kU0Do0Tk73tiSLNuxzcU8Bi2mm4OQTg/OoIQ205C4SmfI0dp//3GB3ilxuT7
 K0wHw1a5TN3WtaX14Lmkc/InawD+MJlEz/aCNIvaE7TzOm3HHtNSwR3Z9a2ZG/O2P6f6FOZPmYA
 tZ7uU2buBhQtXiInDb5nyJtPGq8X6iBWWIzdUJ//yGPUHFi7SvNWTh5tMYO8wpG4PGII7yF628x
 0Cfb4yZ4uYcfcD79l3O5FceMlAj9WYWsP+xsyuI+Mei5fiVcX51T/502HwmkOTSY4HnslZWmPZY
 7inv9x5+G8HTU9QWKDr6CWxBPunlkRcrc4DYWOjkW1y3jvF5/ORTN6UZETJ4MiPSM4F5FvG78Zc
 qVqLvMIH/++ls0x5wZdx1xhqrltBZsl7e3yTj8Os+BdsuC48y7jaX9NYCQ9QrURA41VeLok3Qh3
 D6Q3/VBmI0wKqJh1xxXetjLyufzS6NvxcO9A5MtCyvH3mCyo5h7AmGIc+JHoO2K1sEFyw=
X-Received: by 2002:a05:6402:21ca:b0:699:12e8:1c54 with SMTP id
 4fb4d7f45d1cf-6a0349e9e9cmr368339a12.5.1785221748861; 
 Mon, 27 Jul 2026 23:55:48 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5746e08sm3493586a12.23.2026.07.27.23.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:55:48 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/2] fs/squashfs: fix directory table integer overflow
Date: Tue, 28 Jul 2026 08:55:38 +0200
Message-Id: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpSaGoC/3WNwQ6CMBBEf4Xs2SXQEgRP/ofh0JZFqgnVbiE2h
 H+34Nnjm8y8WYHJW2K4ZCt4WixbNyUQpwzMqKY7oe0TgyhEXZyFRH4PjM5pHOwHKcWqrqSRfQN
 p8vKU4kN3637Ms36QCbtjb4yWg/Px+FvKvfdHvZRYYDXoum9V1VKjrjoG8irmxuXzE7pt277Lo
 hMfvgAAAA==
X-Change-ID: 20260723-sqfs-oob-fix-e202a643c3d8
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221749; x=1785826549;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AQjj3s4eJWx32+swxeEncfRdIqPD/TLOAg8npvRVFKE=;
 b=azeYbCy1gkK1BNz9TIcmBnJ1T8afZLfLHc7md6whLDyh5bg52x06IuT+CesCsoaeW5
 VIc7onuFYMOyftGRfwcJJ5GOxGxXklgIpQ9BzUm6JacqDGvKZHIdID1aLgDkSq81mH1b
 yF4WiApr5z7btA1gcP8icoJuXmhhKg2atC7QLN+q7XZ9bbsVeWmeFsVWxUAcrTUHOXjQ
 iJ/vrKb/IL3XI7FcpwJG6umj3no3SEJS9Jg2tIhe83irJR9KjE+tZyYPyx16RRwMLUnr
 IClrdA9VV5xla3n7PmxllkEGFgza7LxadiJUVUxdvayvB+K0P2ktkV/r8cFD5HBxxDxI
 e61g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=azeYbCy1
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

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Use my real name in the From and Signed-off-by

---
Shahriyar Jalayeri (2):
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
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

