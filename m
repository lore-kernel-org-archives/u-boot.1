Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98214C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 16:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E464887603;
	Wed, 22 Nov 2023 17:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aNrLKAVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2E5868AE; Wed, 22 Nov 2023 17:21:51 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24462875F7
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 17:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3mypeZQcKBpoGILCNT9AIIAF8.6IGO-5IINFCMNM.78HR.78@flex--moritzf.bounces.google.com
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-daa2684f67eso884433276.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700670108; x=1701274908; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sCQFVqoOYe0pnYi6rzRGC+yHUcbkkOhNiLSji6nTp7Y=;
 b=aNrLKAVrxO/6cHlva6YLihf+vQZPKRz8NJXmdMDQq6F+mtGGkcAJ1WhoAYe68DLTaS
 CneIvXcS9NAhMIQV/YUuPBGyOjgW0ckQPMPBId1tw0+gPr5RbJu7Roz8HasMOmvI8PJ6
 C6fEQJ+ovsSqvIBKC7I/jlvWmMQGP7esIq0u2wo9OAguenLtea+pKnpQEorM4Ec1KpRs
 iGP6mYIEnms1L6YV2nSL6J4fhtlOV/3qzA951XugXporx15pUiilfWPTCchmvLtAubXC
 GWl2xUiEx98m1Ljh8xVRr2z7Xp5BqSd3kxsI+i8GuL+9T9Tnn/Y61qhO5XKLFJs1wq0B
 HrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700670108; x=1701274908;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCQFVqoOYe0pnYi6rzRGC+yHUcbkkOhNiLSji6nTp7Y=;
 b=YrSObCd0/CIsITsTcpBnw+NUH5SXaq9WVuM0hnxE2V6jnt4yHMZys50Gl2dJNTtGfk
 MQb7PGfenWe6Eg1HO3rxAkXH15or6Jzk9RuP7tB3rcZi/QktDHyJXzdI3rPbhKi1SHZa
 OHccAYeoRbWk7endaNcyxwIJ62mCws71WBJCvntLIKE+F7Ns0q7ayHoJAJFAbZaV3HTV
 YGomsSo9432Nr+8sw4Rh80d34RO58qyNqMM5xcbnaaRR2IJHz44jpfVgONhjY+0HvS+E
 c/i4F34K+R/iAAggvT0cFOvQgvqPRpMDJKE8zz+1zB2TNpLAYRtL/SNtCkQCkqfFDshG
 UZNg==
X-Gm-Message-State: AOJu0YwE+HHquRcXMGYjhW3fY8lJrUdzI9w9Fq5LsvF9IgF0I0wMsVzX
 i7KJNcZkCeIjs7dFKxVXTvHf+2Gq3gCPi70ZffOmG7//rWZPHshx8QT6BsRrsL0FyQc/mtELeJm
 FHv87kTkQm0mScZ9/7JgJfnFtX0aniDAcfWWBImAildp+RNu5tqBvT2NdXEpQEw==
X-Google-Smtp-Source: AGHT+IEAP45Ax8N+4wfK4vTgNCPRi39euUP2BhkVhFsMshGMrgbFQFNhGKH5OxDmDRAjqLiWvQBR5Bgnn7tN
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:8a11:0:b0:daf:3e84:d016
 with SMTP id
 g17-20020a258a11000000b00daf3e84d016mr101805ybl.2.1700670107823; Wed, 22 Nov
 2023 08:21:47 -0800 (PST)
Date: Wed, 22 Nov 2023 16:21:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122162115.508690-1-moritzf@google.com>
Subject: [PATCH] MAINTAINERS: Fix ARCH_APPLE file paths
From: Moritz Fischer <moritzf@google.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, kettenis@openbsd.org, 
 Moritz Fischer <moritzf@google.com>
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

Fixes a filepath in MAINTAINERS file that wasn't updated when
renaming the files to match the new SoC name.

Fixes: a4bd5e4120d6 ('arm: apple: Change SoC name from "m1" into "apple"')
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4d..833f7beb9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -117,7 +117,7 @@ F:	drivers/mmc/snps_dw_mmc.c
 APPLE M1 SOC SUPPORT
 M:	Mark Kettenis <kettenis@openbsd.org>
 S:	Maintained
-F:	arch/arm/include/asm/arch-m1/
+F:	arch/arm/include/asm/arch-apple/
 F:	arch/arm/mach-apple/
 F:	configs/apple_m1_defconfig
 F:	drivers/iommu/apple_dart.c
-- 
2.43.0.rc1.413.gea7ed67945-goog

