Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C6BC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E58787969;
	Wed, 17 Jan 2024 16:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O2mCaDVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2788876D3; Wed, 17 Jan 2024 16:34:00 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15D787969
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CF1D3F272
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705505637;
 bh=nYgGDgxXqDe2ulxLmlYhvt+b/uQRUcczhWuRcA0Nx3s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=O2mCaDVz49J4iU7w7G7liWHsqbbi2GMCIKLuidkqbV37uoH6/tx3IZH5NdJKcgTF9
 atzGEtIBPAsODOWdQ9GWWFxeIeQOL4yKQTrqcJ34p5BBeTadbmr4Xbx46Z4+VTru4l
 4JLrYKdoPeAm3w+aqakdKsVN4iruUIw9S7xU6lZJzBwBKfbbLj2VVx+8BPurefchDx
 OJpfP9pGC2qs59pKKqiC1FwTxLZscNHub5lM3zQtF8jlMGoA6Gzp/9iKl/Sle9fRNN
 fjfk1adhXZZSyjy2DIqCqpaYY7PKgZEuh0vglu4eTwt0Ruw5ZwLKS2xd8+KXslyzkd
 jWHdDPLgY/0RQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3374e909bf0so7845367f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505637; x=1706110437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYgGDgxXqDe2ulxLmlYhvt+b/uQRUcczhWuRcA0Nx3s=;
 b=NEUgO59DsZBa0Tb70jYcMlerfgWtzEEFvvANZEeGPvG3LT+cfpJmPA/XgVq3j2Kfss
 97ejfc+ZBo+aGbwTFzPNqWjizjClX9ZTxsfuBwdk0C328i/hQEDmOm1tJF/ssAREEsiJ
 FspVXANjQ1qCvof9jY0Z7i2wx//kACjI9o/Ua0hgVoWuyg3g50oiYMmyYVZRBI4s6tVd
 rrBAaaL7x69NVyf777YJVAWdS4RTSCvS66g8jCbkL8jvlTZUBDiJ3Pu8AKRsTkkN04AO
 DR9wX3j/FMHhVv/eMK3MaPYslKKcpGWIiAHQJp+ki6NApOTZbt7/6Gvgj2Al/kTui8eH
 Fz9w==
X-Gm-Message-State: AOJu0YwWEbWyDJvLkvxrRXJxFV/O3yIdw6NupU/PA41fL5Rya4PI9DD/
 enqdigVRqJVIs4QvAfM3U6dr8Dkv1ecFxVzMAXlwqtjcs0ZYpJeFda8WAN0oG991AGgQjBFJ2V8
 ovyi3rFYCVz6H2sWX4NjmL4DUvH+4e6VPkZsz2g==
X-Received: by 2002:adf:f010:0:b0:336:8ca7:73ed with SMTP id
 j16-20020adff010000000b003368ca773edmr4789039wro.109.1705505637055; 
 Wed, 17 Jan 2024 07:33:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqTBcYXC8YxIyV6SPRZTz+ymbRgpBQPZh8Y2WgXVq3AY/l+EAJw61khtslLKvoLuP2ygKxFQ==
X-Received: by 2002:adf:f010:0:b0:336:8ca7:73ed with SMTP id
 j16-20020adff010000000b003368ca773edmr4789026wro.109.1705505636681; 
 Wed, 17 Jan 2024 07:33:56 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4f07000000b00337876596d1sm1897499wru.111.2024.01.17.07.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:33:56 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] smbios: type2: contained object handles
Date: Wed, 17 Jan 2024 16:33:44 +0100
Message-ID: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
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

The type 2 structure must include information about the contained objects.
It is fine to set the number of contained object handles to 0.

Add the missing field.

Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	email address updated
---
 include/smbios.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/smbios.h b/include/smbios.h
index b507b9d9d72..98bb9e52cdf 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -139,6 +139,7 @@ struct __packed smbios_type2 {
 	u8 chassis_location;
 	u16 chassis_handle;
 	u8 board_type;
+	u8 number_contained_objects;
 	char eos[SMBIOS_STRUCT_EOS_BYTES];
 };
 
-- 
2.43.0

