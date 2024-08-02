Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0286DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C9E88A83;
	Fri,  2 Aug 2024 15:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NUjlj17Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64D288A98; Fri,  2 Aug 2024 15:50:32 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3F688606
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 312A5400B1
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722606629;
 bh=jU36AU62XKlNFp8tbs/afinZO8upOvkp6fXhP7esJFE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NUjlj17Z0f+U5foY56qaJYvqIUroVethl9Hpwktwlz/VKOLBac48alLTTZBq6y+ov
 qAdj8GRVxLoUzof1TwOLxOkfFDr1JfPIWoGpgKn6fKdNO0kqKLZzzBNC8vtmuf5DPo
 F5glYkdDpxNx4hFAe1hXmrQkgeFVpNMigC7m8WxhIV74eJGwQXfRTKl4UG3AhJLF+Q
 wBWHwgaOixGLWghSlXe2WLNjYvxsqlwLNU5WjPPGwKAf6RZWSmRWFjZoVAlMKQIFZw
 bWRl/koq39Ga17yaC6qCCd16VmnTmuODmLB3L/sTCpFPYQPPoH4qAasN8xT9xz+4h0
 sgXo6enmQJX/Q==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef1b9a466cso81734091fa.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722606628; x=1723211428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jU36AU62XKlNFp8tbs/afinZO8upOvkp6fXhP7esJFE=;
 b=vczm8MnO9yEFLrYMk9VvBab8i0OX4B8rXn6lkgoV9RK8IX32J9xqpLXLp3ifUB2YLa
 AEF9EV0+2+bOEFk3rOOLEYO19fFZ6327O1+hCwT/8AhL92lTMPryNVpNNOGqeS5sdJzZ
 mRaeLkFPHy40EpHdYqGX45gUF/ddMFGtmQM5wD5iVf7caxFSgsJFowRVReszD9oq5oGI
 zfmXVFjRH9M14/zx8Ja2NjlhctI68ybpzCGfjb2ftEpQyNKEnmucb8LljRlQOxwX9LVi
 AE3kILYU3qIZzHp1JDO/5cjsCKUjPp8o+i7JIlR9gT1x/POWZtHMTTNvvddBeDbKsZ/5
 CJHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFiXksh/XzDK+abyvNR25ZxGvy7uOejZzF3mSp+jNiSPyU+AmviMxhEJM/G3nd2zqC4XtxR1MsmcTqg+YicJ9AhzXBqQ==
X-Gm-Message-State: AOJu0Yx7UMSjaM/5dXqDNUdDzv5mpDtIjQYHx5Jdm4Nyc4n/ObbiR79y
 R6r2CurMlsMh4zSepzxXr7+3dsilog4Sm7LlAcUBFWD39bgoi4KmgIJnc/8nyiTtBYw/sf56sAF
 w36OwZK88j3h7SeQr7EfHQrEe5DwdlvmEDMDTl5Y4RAUovYPFlKc7HkTNM+DdLVAjxCA=
X-Received: by 2002:a05:651c:1024:b0:2f1:561a:4092 with SMTP id
 38308e7fff4ca-2f15ab37f36mr26552171fa.41.1722606627845; 
 Fri, 02 Aug 2024 06:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcSY/oMXhlQIAFVKwtstaYOt9O6Is/PkWdsRUvHexLX6wtnandI+5WMumSHRGNQZGM1oiq5g==
X-Received: by 2002:a05:651c:1024:b0:2f1:561a:4092 with SMTP id
 38308e7fff4ca-2f15ab37f36mr26552011fa.41.1722606627274; 
 Fri, 02 Aug 2024 06:50:27 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83a552984sm1147387a12.58.2024.08.02.06.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:50:26 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Dave Jones <dave.jones@canonical.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Makefile: don't use CFLAGS for environment text file
Date: Fri,  2 Aug 2024 15:50:23 +0200
Message-ID: <20240802135023.107143-1-heinrich.schuchardt@canonical.com>
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

We use KCPPFLAGS to let the user set flags when invoking the C precompiler.
These should also be used when generating the environment text file.

Reported-by: Dave Jones <dave.jones@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f0e6f07178f..4c469b9ce2b 100644
--- a/Makefile
+++ b/Makefile
@@ -1839,7 +1839,7 @@ ENV_FILE := $(if $(ENV_SOURCE_FILE),$(ENV_FILE_CFG),$(wildcard $(ENV_FILE_BOARD)
 quiet_cmd_gen_envp = ENVP    $@
       cmd_gen_envp = \
 	if [ -s "$(ENV_FILE)" ]; then \
-		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -undef \
+		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
 			-I . -I include -I $(srctree)/include \
-- 
2.45.2

