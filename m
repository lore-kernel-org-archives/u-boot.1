Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F0C61DE1
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749A983D3D;
	Sat, 21 Feb 2026 11:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="etk6pVCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CB783D0F; Sat, 21 Feb 2026 11:00:50 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F0883936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65bebcbffe8so5401620a12.1
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668048; x=1772272848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj8/10gXbI01zUd5gmvIEoTHks1ja5XYZiq2y+nr9rQ=;
 b=etk6pVCRQ9vfWcuxXBcRdeaPce2OkcmKmnR+als1jg4qHAuOz2ImPP17SmZVIoBrvo
 TLzmDMGWYhWbYIJWxrXrxLdarJ3p4Iyk+T7fbLVEWkKvb8BUk0nJ9dM1/4uXVyPdVbgE
 6w9vxgsRqR+835DInVYE31bf6ug/36W6AYjc9N+vLThgG1KQoq2PXKLZiuyEZwdbaYSG
 CXbz6vQgnc6IQDWwYAUMwC0GSOTdTzQ6AdbJUXU84ohe6W7banAPbnxqNQP2iODVN7mQ
 +Pjue8tLQGuMo1aT0Le3tD3E/3/uhP2NaDCVVmv0tc0wUvUtBO/+pTSnYCW53Y5QAG6c
 C/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668048; x=1772272848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oj8/10gXbI01zUd5gmvIEoTHks1ja5XYZiq2y+nr9rQ=;
 b=u/ptsvTw5z6BF41kZmAtmqw8cwUAc0RZkzqy7iW+BLEWBr+hrIGsn7PnENqzIMr1iO
 Y1WOR3SEzXFjXDmexg3JQjE8VUGLq1S3LM3n0zoLv3gIghL9CvBFuOF39Btq3P70Zf7Q
 e2dLiZyx09ub2szf0R28vIGLTatE3Zu6WOjyfLSa6rbULRMWZJsC99em6lMfKnCO0z0u
 JxJ/ebhqGPgAKhatHNYSY33abtF2Y38w52OKx7fgwx25Tl9+rq8HxUziJpF6DOVZ/36S
 xBrblSzSjmkzlkC5LgrrQ4byhUsORSlCZKfSQA5pgXwRsJ/M9rgcTjDoJQS8sDoQZOac
 XRhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGmorAbRTlsifFOdup6MHuO2KEbKukll/z9X4RkYFU2xaF8o7Y8J5/ChxdVWPjC+0IKJk02zk=@lists.denx.de
X-Gm-Message-State: AOJu0YyrzPJiVtJLoCItEo1/ajZNvjnoobfQuM0hkW6Rxgjci5ymhtAH
 kDAL/4Mw6ueUq7i6oEWFXber7ymZoPsON9UlFRkE19cLF7Wd6MZPeaLZ
X-Gm-Gg: AZuq6aK05GUGLoC5fBSLCCqSRLmdbxcfl/cp97LgRNRfu/+keEJKPwnDrJvQiZlZHGO
 SYlCNM+vwiHKicz5g0vPNVcWMCDANPAIZtd/ZgppwDoDaYO5ExKrrVoEBAnDm4qSci/NgCTCR20
 7x48TrP9ksU7/RSxzWdxOMlzyUx44dYofXfe7veBDmKHTvQws6cZmptvtpx1C0WgxRgue5vu5E+
 MIH4MfgfDqqiZDBq5BzLlZXdbhMi+DWjfHOXDQ3qCNDeNuJjCzcgVrOoMvcdEGetym8Wr1r5pzI
 4Kyw0Uz4TViQkXz47XnADw7VKWtwd6pehy0NXM8cgoGsa3H7bJbYBR2LSX19cchiT4rFgG6/Xuu
 MrQ61bRRzoTxUy2XIPm13u9yZE0sO1w1PXRviC7NZyd0xfNsDEVm+wd5gEcVp35UGext2fD0PhM
 gqyK7gQty4wZ4KFRnZyOjJMA75b3vQoPyscZ8dwhFWYeoAKd/eAV+y3G6K4v6/F9dc
X-Received: by 2002:a05:6402:f25:b0:65a:3cd4:8c9b with SMTP id
 4fb4d7f45d1cf-65ea4ed1a45mr1421798a12.11.1771668047806; 
 Sat, 21 Feb 2026 02:00:47 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:47 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/6] fw_env: cleanup flash_write_buf()
Date: Sat, 21 Feb 2026 11:00:05 +0100
Message-ID: <20260221100011.29049-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

I found flash_write_buf() somehow more difficult to follow than needed.
Some code turned out to be inconsistent and some not really needed.

There is a set of 6 patches that should be small enough to make them easy
to review. I was wondering if I should squash patches 5 and 6 but ended up
with sending two smaller diffs.

Those changes shouldn't really change any behaviour (except for smaller mem
alloc). Let me know if there are any issues with this!

Rafał Miłecki (6):
  fw_env: use "erasesize" variable in writing loop
  fw_env: allocate buffer of proper size in flash_write_buf()
  fw_env: add ROUND_UP() helper
  fw_env: unify calculation of "blockstart" in flash_write_buf()
  fw_env: move "erasesize" calculation up in a code
  fw_env: drop unneeded variables from flash_write_buf()

 tools/env/fw_env.c | 47 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

-- 
2.51.0

