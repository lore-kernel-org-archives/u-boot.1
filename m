Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D078EC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 02:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B5280214;
	Thu, 23 Jan 2025 03:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h5tF3YJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEDE780243; Thu, 23 Jan 2025 03:21:53 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DD480137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 03:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F5463F1D3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737598910;
 bh=vd0Vg0C5hrdgsp7mT+0nrQpf63hjy892FAuBvWqeycA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=h5tF3YJSeSk8io9e11/FGJVV7E/ZVb7ZDR069ecCPZbgyxLMfdVuP9or80O6iPvyu
 CnHVcmMgYrfsa6JcuLqWWU1hWp70MDgbGd522vv4bESkCWYdm0xlbMAOXuRtcSGBS/
 d9z4lA8XB7qH3PoXDU8Eng11qMm7hC4afNv6Pg2USDiNOZZKcwbG6Q3jn31Uqv751Z
 w4E0KcKbMWh+LNQMVbCbj56f7c7K0BlaDrWkyZ9YLhmU/hzyF5a2nm5LpPa8fne8PU
 zufxgu17PzpE5Dd2TzJ3HFx/FwKsEy5QVu1a1AJwG+6FvES61VFL0rF9HsHcbIv7rz
 6erZAwz/XJ+2A==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38bee9ae3b7so204775f8f.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737598910; x=1738203710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vd0Vg0C5hrdgsp7mT+0nrQpf63hjy892FAuBvWqeycA=;
 b=wbrDYrHQgrdo1ExZaFITOXXv+zcP51X1eQP5KDqnotTEhVlKCfyxcIPqUU3jfrP/RR
 ds+lpV5ie9IZiFe26Uxb0HcJVxyu6nB5HcUks+0gMHdvo2b/uO1UzbLEx2tn35lAiBOY
 bdQIixj/sNS6Kye5G2mdY01vQiigqxSDavvjboHELpmRfPbu8ZbgtdT44udM2kw52ecK
 tF/R7hhdaeSbUPKIlmveVBzg32qMyCwaiHzlLOzsOXo3Eak544gkIV/l7fXgW2KOmBWU
 RwEhd1zZEJulOXbfll23WYClL7YIF/7jajy3z2SxzbBHP4bbGVutPsXzTPOfAC6WxxYE
 r+9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv0DHn5bpI79+o2fuQmp8ssr/3RAPjAGyEZvebErzvxHNtK31IH3KJQoiQUXUmBnm0RzbPtf8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/zlrVN5wwWRiq26EtQtM0mz4ngOs2zg/8MD++OfnDKSIygHsJ
 3/5JD4AZtljY1sEsy2vbvvTQI8OGuYjWrj8rVRjjwIQCmE6Km84WsEf8zP2toAFIS6dPl+c2rJb
 kUHvsl3Vxs6Jz3NgLhSCB04dzF4ePhYHIXvLYD762QODbkeCmznIoj2FDTPnAeKzvqhk=
X-Gm-Gg: ASbGnctQXROnjMNmy2Svi9+jpk1uxhlESvv3VCue2RXSjO5I7QRKHTVrxuRm+QGltR/
 LaX5zx/b1GBMNOQhx5r7eV3byg3hTEhAvBe04kbXC8ksFA9RBnciRn9iA+u3l2e5TcE2IZWV2f2
 2hTKBsEtssQIjemm1wuH+E3dob050sA9jeCOgOxoA2tV2MKSbIyA8DVoEuoOo18GSgiqixuc3Kj
 ACHVTzqRHLj2HdwkCCBhuol7POYy+14dPpjtgET3pgAK61EDe+tc5TKkpqlvu3yb3GdB99FWpHH
 sHNbmx7vKpkB7DjJc5ipcme/ec4=
X-Received: by 2002:a5d:64a1:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38bf57d3813mr26763092f8f.51.1737598910014; 
 Wed, 22 Jan 2025 18:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm12KnAfCBoPIXxUiwfn5RoXDW5bJjPYPMRQ6M3fcg6SqAGTzFdTnFvVa3ycApEMxE2/XQqA==
X-Received: by 2002:a5d:64a1:0:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38bf57d3813mr26763079f8f.51.1737598909665; 
 Wed, 22 Jan 2025 18:21:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4a90:399:6f76:8248:d5ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327dd34sm17567450f8f.83.2025.01.22.18.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 18:21:47 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Tom Rini <trini@konsulko.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: AVAILABLE_HARTS is not compatible with XIP
Date: Thu, 23 Jan 2025 03:21:40 +0100
Message-ID: <20250123022140.69418-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

If CONFIG_AVAILABLE_HARTS=y, variable available_harts_lock is created in
the data section which will not be writable while executing from flash.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index faf70cb5d4c..f4e76db3df4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -459,6 +459,7 @@ config SPL_XIP
 
 config AVAILABLE_HARTS
 	bool "Send IPI by available harts"
+	depends on !XIP
 	default y
 	help
 	  By default, IPI sending mechanism will depend on available_harts.
-- 
2.47.1

