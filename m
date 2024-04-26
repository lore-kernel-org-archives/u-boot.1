Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E78C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 10:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3708907E;
	Fri, 26 Apr 2024 12:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bRnSSBT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302BB88F40; Fri, 26 Apr 2024 12:09:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DE68907E
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 12:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4BC03F36F
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714126188;
 bh=rRxnv4N9526O/V/8uGgvhsQz3ORIlLxS+QSas4nBt8Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bRnSSBT/JtL++TXGC64dqMRtkmwXaeEM/EvUESo4E+3TyosE4VAQyixiFtRjDxqso
 zhQ38k6Xs0gLknbHUB1l+J2OGGW5cbHIMpEDtX+KGPKt8947qafXVg0uRayMqRNdkP
 5QeFqtrM6ab8tvCYyrpYBG+usNmfI00a2etLd7PnzaGb/m+9Z+/mPATIsnsvHFssDu
 pP2Bm/uuBvumCdQu3FBSIWU/IC167gEFDe0Scs5zLe63FfwXa9NlfQlP3j6jhiTNbF
 AWyd55ZovSymCNphXay4KmUfQmd1N9iZEIFSdjv0yvMtjJLXMaZE7FlWANZHxADdVg
 qudxEGJv/v6MA==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d87d146022so15521281fa.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714126187; x=1714730987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rRxnv4N9526O/V/8uGgvhsQz3ORIlLxS+QSas4nBt8Q=;
 b=wwhDdn/vSY1+PdSKGrbLTAGkboE1D0Mu5Okoa7wOofb9fIoIMAHUjXiQPDHh1+JDRe
 97BsEtx2R9d4QiAjLx+VPjFU4trnCVHGLc5v6zgfl/u0AchH6IOXxLKsJnB8Y7AH2y5l
 jbeSCwpWUHGcK/JW7p2YMrU9MogMxvixqPg4DGPbR99fF7k29kv1dIc7eBuD53XsVhiT
 S1EUfA+v/BOKFs42hUnvBII8PEVvz7TBubRQ9fo/RCeJQO8JqV6HjyF3P+lsEM5cmjks
 jOU7pP5LV5VWb4AnbJirEx78oRfYQbwpTAf7EriO0qtRaPNmaJ3EguItFXdw+a00BS3O
 dhZg==
X-Gm-Message-State: AOJu0YxZ0P2KOYjEW9tUlAu3cNZxQP+F6NBhRAJh5LTGB9d1gx2gOoqC
 /SxPVWBVDGxmatxljzkMa6JXcPFZoF9TUtbMqsIrVImngNjSrGF4BFCV+4+h/z7A6ch58WT6joL
 nWdjml5dUpqkUUrLhBKkDIVrkupELl614GGylbZj/MmnqulLNfUolFdI3KxDkbAVsn3Q=
X-Received: by 2002:a2e:a28f:0:b0:2df:6e6d:2c22 with SMTP id
 k15-20020a2ea28f000000b002df6e6d2c22mr740182lja.47.1714126187101; 
 Fri, 26 Apr 2024 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl4esSBB24/SzCUBJyIfNTJVFA7UiRIXMth6uvZorf7AHUthFZLBl8ioPP0EAvVanvS/L7sg==
X-Received: by 2002:a2e:a28f:0:b0:2df:6e6d:2c22 with SMTP id
 k15-20020a2ea28f000000b002df6e6d2c22mr740167lja.47.1714126186699; 
 Fri, 26 Apr 2024 03:09:46 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adfe00f000000b0034b03d0b94csm13344920wrh.74.2024.04.26.03.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 03:09:46 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_loader: fix description efi_dp_shorten
Date: Fri, 26 Apr 2024 12:09:38 +0200
Message-ID: <20240426100938.89303-1-heinrich.schuchardt@canonical.com>
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

Use Sphinx style for return value.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_device_path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 46aa59b9e40..aec224d8466 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -102,7 +102,7 @@ int efi_dp_match(const struct efi_device_path *a,
  * See UEFI spec, section 3.1.2 for "short-form device path".
  *
  * @dp:		original device-path
- * @Return:	shortened device-path or NULL
+ * Return:	shortened device-path or NULL
  */
 struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
 {
-- 
2.43.0

