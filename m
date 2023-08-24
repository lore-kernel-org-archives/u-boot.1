Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55A4C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B80868D7;
	Thu, 24 Aug 2023 21:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="osbN1Arv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4AFF83F7B; Thu, 24 Aug 2023 21:07:53 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E303868D7
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-592972da9a6so1362557b3.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692904069; x=1693508869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DsHZJUYhixBFUW9IVU8Utf2oe57oSpdzKBh4XXPMXwY=;
 b=osbN1Arv4Y7VUpwEVu94NPmLIu1/J4KOF+rnC6QhKBrajSGuBMKCpCATPK/sEHUXDE
 KBAw6u7VHLNTCkX0pbkvogPY/6/MZHw4xxcpiVrzDd7zZ1ZaL+tcj56DZA3pZKEjR5sl
 1wx8LqeMp3OG/ve+wrI85V+e9N7AeyuQTTVG9L8fBJgh6oHRMkT2C8TgZQ6sLgOiV3SV
 Y/j3fmUHK0jDVeO7pEJou63p64H9EHDwN5OcT9DbXt88o7V5uwMXA4Cv8FGnxAUYjdsh
 /ZaQ9ofMqNfshnMzkpq4GGFdQ9zVwB3iEe7LqrUSK+gAjQks52W7zeC3awJrW5oDQQ/u
 YK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692904069; x=1693508869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsHZJUYhixBFUW9IVU8Utf2oe57oSpdzKBh4XXPMXwY=;
 b=A6o/YMGgy5BcuOGsbC9ISIpsJJ0BPMR40jfoFNdpdRP7aOhZOttd0MFaA4XSSKLTb9
 oKoSYV348uFzvD6Smp0YZJC+YBs311EQVa+Z2CrmqX1VTB4SFjmqvv8RMoiZ7C//r2ma
 LaWNdm1Kj44Vbofg3UUGPBQyEaXJurtr6oWUWC9m/fe9gS03bwNtaG9vM1KCeYjjcLR+
 VoxkpqhCRnrgFeLBBLhHYXnquZJOvQA/zaXGwFVHbrR/CdAc6/Vw3QkvclN64q5qWl+q
 ZtRi4wHQBxFCdevMNGk0yPlq1IEmLSOB95RXaTPGT86aBpoy+9e6lT2FrnrQoutlIE6/
 jqjw==
X-Gm-Message-State: AOJu0YwmWfaUoj87v3/AHyZe+rD/4+SewOTt71b/dc+csvv5hpT54vrx
 Jbvv+Hh/Bu2WiCFR2fbpN47jfLMWdUs=
X-Google-Smtp-Source: AGHT+IFpKn3z66ok7pwG3t7X2nCCPlKy+QZDthVW8K7ZOETubQq9sXQTHs+v3K3aAV8/OXbdVOWK0w==
X-Received: by 2002:a0d:f804:0:b0:577:3eaa:8d97 with SMTP id
 i4-20020a0df804000000b005773eaa8d97mr17855440ywf.17.1692904069420; 
 Thu, 24 Aug 2023 12:07:49 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 i129-20020a819187000000b0058c4e33b2d6sm49869ywg.90.2023.08.24.12.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:07:49 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Pogo v4: Enable LTO
Date: Thu, 24 Aug 2023 12:07:12 -0700
Message-Id: <20230824190713.30866-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable building Pogo V4 u-boot image with LTO, which results in about 30K
reduction in size.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/pogo_v4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index 3e3e811543..ad36da712b 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
 CONFIG_SYS_PROMPT="Pogo_V4> "
 CONFIG_IDENT_STRING="\nPogoplug V4"
 CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_LTO=y
 CONFIG_PCI=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
-- 
2.39.2

