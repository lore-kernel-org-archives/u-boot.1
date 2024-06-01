Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FC6C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 14:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE74880E5;
	Sat,  1 Jun 2024 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQojZy1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C41880F9; Sat,  1 Jun 2024 16:55:32 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0A5880DE
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 16:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eae92e7b5aso133701639f.1
 for <u-boot@lists.denx.de>; Sat, 01 Jun 2024 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717253728; x=1717858528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hoHGS4Q+tMM4GiejpFaPHcYXs2a6ydCAPLeV6C85EpU=;
 b=mQojZy1NLQJ0EBKe9Ynze0V0romzSQ7pIG6yfCALxVBmIJB6hTb9Fof3AsKgf+5pDn
 80JhVyO7p9vJwm1kVhI3dS6Yzw4rPVboZ52xUmn+RGY9P757JUO2yzC2QhrOLjLO6FlB
 2d12KCAWLAKibl2aPfVTEaG6jlN0wOwVXwmBQhwt50d60LzCjznrMGZequHt0ILBTRz6
 Ev8OdeMie/MeCthUQ7Nc0gxINl9RTlTbsQfa8f9pC3GtXJQHqiBnzuHKE+KxNm9FtTcf
 /IbOrsBpJFocDnD13zWJB6I+SzFa+eL4aQGjqhyQ6N7z24R2Y67RH0lWvy5NeZKmr1Ib
 Hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717253729; x=1717858529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoHGS4Q+tMM4GiejpFaPHcYXs2a6ydCAPLeV6C85EpU=;
 b=r5fkXKSSHH/lkS9hiIwFuMKEYF8vBu2CB40MBA8IyGhjG8LBmOaTdW1DYmbZYwxLen
 H2Th+MlDDoB40HrdTMAnLpcODxfV0KRJ6lg7XL30YsA4f+daqHMs9r8YaOqoi7c15tQj
 cNmXZchyDkNlgwyHxoIkVCeNShP+rGzcm8gOe9kMQEwqGSUketzZ3QpwCXRNTaXVuKg+
 dAHU7tnObLhvw9g2B9qlmU6Y3q4/g+DD2TEHHHT2zG7BsjSBjZ0A2yvAdYNl62oepZDp
 bVKtvuDNbgxNeZBX6txXtGY00bg5zdnCtxOpT0Q/NMcdmN9SA6H4Nf7iMU9TzR2oTL1K
 b15A==
X-Gm-Message-State: AOJu0Yygi9byi3dwDZm991eikUHaV3ItHMTODhod/eU1gB6L2mKBxsX9
 1WqcmneTvcheSjseu4mMV+72oRsnH8AWmYOtk7YEWpU4yQDSZkzahLj+m9c+
X-Google-Smtp-Source: AGHT+IHaTryNCxZjjGxtHwVZWEBgsqNkXlRbaCL427MBPoXCw/C4fj9uy62kJnaxr6aeX9qbuVFXQA==
X-Received: by 2002:a05:6602:150f:b0:7ea:fcf7:ce9d with SMTP id
 ca18e2360f4ac-7eaffe685b9mr567210839f.2.1717253728670; 
 Sat, 01 Jun 2024 07:55:28 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b4881d5bdesm1050386173.46.2024.06.01.07.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jun 2024 07:55:28 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/2] renesas: beacon-rzg2m:  Add Marek to MAINTAINER file
Date: Sat,  1 Jun 2024 09:55:19 -0500
Message-ID: <20240601145521.200132-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Since any changes to the RZ/G2 family go through Marek's tree,
update the MAINTAINER file to automatically show his name
when running get_maintainer.pl.  Without this, he is not
copied.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/board/beacon/beacon-rzg2m/MAINTAINERS b/board/beacon/beacon-rzg2m/MAINTAINERS
index f8042bb2c4..a4a920a017 100644
--- a/board/beacon/beacon-rzg2m/MAINTAINERS
+++ b/board/beacon/beacon-rzg2m/MAINTAINERS
@@ -1,5 +1,6 @@
 BEACON_RZG2M BOARD
 M:	Adam Ford <aford173@gmail.com>
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 S:	Maintained
 F:	board/beacon/beacon-rzg2m/
 F:	include/configs/beacon-rzg2m.h
-- 
2.43.0

