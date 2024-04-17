Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F48CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 08:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7388844D;
	Wed, 17 Apr 2024 10:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GiqKViCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF9388458; Wed, 17 Apr 2024 10:06:33 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059428844B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF7EC412FC
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713341185;
 bh=cd958tgIRm0hWvp991+12q9U/1IF4ylmF0+i0hmk4Co=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=GiqKViCUasUeEbaIn6Ue0ksNnCzmOIYYQctOtQoZRUyblA8wSK1wTsWRawsng5fAt
 OD0SuV938/Ea15H8B9+kKtoSZ4plmVoeEjC5H97Az7x6OdBN0QR0CZH12/7OR24lJA
 wGuwK2z9rIp6x6hF09WoGfEVmKWnulov2WbGIc061cdTNbpDq3iUsr9zFsWKaNJK22
 vDvcs/mb8BiZFKXc1Fr8Cv71x/W+HzztvTqJhVcdFhYYlmgUX5mhu/JcHLz/zr8qEh
 CQLSq2Zw0oHHorBr/FAvqW2914YnI1HP5C4BBkinAf3MrD6JNXiJavd5mKbNQsV0bL
 ZL4/mpXSQrFIQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4183b895ef1so11900455e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713341184; x=1713945984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cd958tgIRm0hWvp991+12q9U/1IF4ylmF0+i0hmk4Co=;
 b=Q00D7epn+IjpzOTbUGnViq1EodZS14/qkylnRHEjc+/fXSwWynI0ZNizgoy1/FzenO
 CT6x6/Y0D+nBgtSY/4RWrXnsqzebB90RG5wI3FbOYNmXCuUQ54rVsqgesDcK0sdNVHUE
 yNS25rc9t/ZFuWg3FjV8thk89JKC75y5RjMKiRM6FqOnXgBGls6AeMVgOPn55JNXFP8r
 tlgRIZwd1ZHk5uH35rSfuDkdmqHAmrVNNEcX5Ndy8Jp4u9oM9HzUIjD4GSRSr4owkYg9
 ajA/1JemChfMk27M8j2UVuQ+QvFbhHjTyHoqHKTQvVwC0VXjn5/KFrbu1LFTp2HD3F0X
 AKvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOSAIo4IT37rFiWmXdCH4bTGUi+2ajALCCpfH/y+yzsUd92xhwIOm3Rb8OrVIoACFT2fwjEXR0k4rLTUFad6xcd11V4g==
X-Gm-Message-State: AOJu0YwETek1XvspV1F2qALZ80vjUqfsjPtp2SmcygmKgzT8s3G+UfDc
 iKd86UY+Vz99ydG/6pz1U2o72tQBlVBTrr1NYVhSN6j/kJFshXwEgHeCtrE0NUT+fvL6Ra5bvpE
 zX+WsMZRRb44HLF1DsoW0zJ7LzMsg6B/Gshj9cYZcMWE9ikkbhdO/uMpbL2ZmGSgZK9o=
X-Received: by 2002:a05:600c:3486:b0:418:c570:1b39 with SMTP id
 a6-20020a05600c348600b00418c5701b39mr374871wmq.5.1713341184434; 
 Wed, 17 Apr 2024 01:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOf1bWsF3r8Je7J61fp5gQmvjEvp+E8nfzgNyebbW7V9DKyNiKGazYaHU1VoJwKajimbT7g==
X-Received: by 2002:a05:600c:3486:b0:418:c570:1b39 with SMTP id
 a6-20020a05600c348600b00418c5701b39mr374846wmq.5.1713341183989; 
 Wed, 17 Apr 2024 01:06:23 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b004182a36b185sm1759098wmq.2.2024.04.17.01.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 01:06:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] doc: update list of aliases for the env command
Date: Wed, 17 Apr 2024 10:06:13 +0200
Message-ID: <20240417080613.24718-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417080613.24718-1-heinrich.schuchardt@canonical.com>
References: <20240417080613.24718-1-heinrich.schuchardt@canonical.com>
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

* add link to askenv man-page
* add printenv

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/env.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index 60a294328e8..040076bcc03 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -40,9 +40,10 @@ the UEFI variables.
 
 The next commands are kept as alias and for compatibility:
 
-+ *askenv* = *env ask*
++ :doc:`askenv <askenv>` = *env ask*
 + *editenv* = *env edit*
 + *grepenv* = *env grep*
++ :doc:`printenv <printenv>` = *env print*
 + *run* = *env run*
 + *setenv* = *env set*
 
-- 
2.43.0

