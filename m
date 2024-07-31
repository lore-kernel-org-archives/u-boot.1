Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C5CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C5988373;
	Wed, 31 Jul 2024 10:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MVldm+66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBB2883A4; Wed, 31 Jul 2024 10:13:19 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF008800C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3CE583F6AF
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722413597;
 bh=XtZyNTAan+JYTwFhdrcW0XgcaovGYDjzNghgDDjHMTQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MVldm+66RHVIHrlxIOxmDETSrkWxmyABvivVQwA77C7XiAMbGZq8RlWAvMUG/MkR+
 IbDxIEmu90KOb86qFKwGMFrKjsMH3a1GUnwPENvJSi0rnhJv2c84kz9bSCblRtLh3b
 u6afqWzlwjpa0uQIjeiGBVeFJfaesYbxL39oVJFogcj2bPYxFlqU5J1H6IwyHx0SMR
 b3VCQC6z2jpoHJj8YG7HY5xfqJTdBi9dZja0580W6PmLCyYnRvstV7YSZoe565j9Qh
 gsoll0x+EaykVXELJB/Gru0PYHde2rrTGReGKOhaesskUGyFc+VhfzNZpeilLc3Uji
 jDWyC3p1XspOQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4281ca9f4dbso26738375e9.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 01:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722413597; x=1723018397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtZyNTAan+JYTwFhdrcW0XgcaovGYDjzNghgDDjHMTQ=;
 b=KRxwvyLTVae1K/J+E78cefkCjQvDfjEDf2ygxjL97HrGCsAlA92sfw/dWDijMTZekK
 TuqxIC5Wq82Tlte7GxLdG7SU1St48mFkuEyCRMVNCWguauheTiE17Q2EVYkWpC0fCHmb
 KYhompe8upratYxDh3lSYyFx7M7rpn9m59Uh1X9/URRNT7/sdaJ5sVUwmWJ+0VZGs9jO
 E30KJeuFIFsyv/OvbCe1fTteBClh7h5kKrzma0nMHFe8m1SZXN4CHNbtJaPcIvR44AIk
 VPH7diUdlf90ibn6UB22m0Hb7d8F3FTWmFD/PK1JH9FwYlFFtrhiCvRe0ck+1WBhy4B1
 idYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgsGNBcdw02YLEfe2Wb1W6tiBZH4gE5dK3YJ4DTAcvnIP10hp4A6Gg8WhuES7V/nbUnX+Ckue+lxzC9Mu7528RcN+dPg==
X-Gm-Message-State: AOJu0Yxln3uKbKKkh4+sdWb/xR78z77nG94C2sRzZ8jsZfSkIFW3cdUT
 LfuH+ye9D4svx0qh6dBAHOLm7PvP49c3m8c6clLqWa/LDu5ByEaPwZAEeJt08jyps0oVG7Tepyw
 5qtvE4NxDEmYQ/NCl24z3tVqpeTrYc6MSMlrnVMza0j2W0OYx+j9GpXtpMmID5Iqqs2E=
X-Received: by 2002:a05:600c:198b:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42811d83cc0mr88283325e9.4.1722413596929; 
 Wed, 31 Jul 2024 01:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF445YJ0MEXfMVN78o4g0gO3afE1M3Vo/wG2wSyAdD7ujFoL9dJy9MTL/+HOj8RWubAxaWCAQ==
X-Received: by 2002:a05:600c:198b:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42811d83cc0mr88283175e9.4.1722413596535; 
 Wed, 31 Jul 2024 01:13:16 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8add59sm11924915e9.18.2024.07.31.01.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:13:16 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: use list_count_nodes() in
 efi_protocols_per_handle()
Date: Wed, 31 Jul 2024 10:13:04 +0200
Message-ID: <20240731081304.81848-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Simplify the code by using the list_count_nodes() function.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_boottime.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index eedc5f39549..4f52284b4c6 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2509,16 +2509,12 @@ static efi_status_t EFIAPI efi_protocols_per_handle(
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
 	*protocol_buffer = NULL;
-	*protocol_buffer_count = 0;
 
 	efiobj = efi_search_obj(handle);
 	if (!efiobj)
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
-	/* Count protocols */
-	list_for_each(protocol_handle, &efiobj->protocols) {
-		++*protocol_buffer_count;
-	}
+	*protocol_buffer_count = list_count_nodes(&efiobj->protocols);
 
 	/* Copy GUIDs */
 	if (*protocol_buffer_count) {
-- 
2.45.2

