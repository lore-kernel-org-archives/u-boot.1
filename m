Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F34FC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9FC80756;
	Fri,  7 Feb 2025 18:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KoVW+9dQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76077807D7; Fri,  7 Feb 2025 18:22:20 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8771280756
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9CBC840132
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738948935;
 bh=mCW7s8IP4GJFiLJdhtVxnhOyRPZVh0H3ArXcP+Uo2so=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KoVW+9dQbOeAEDM+4DutDXq2rFfH59QY5KEUkMgC2tL8sqyzUncby96ZNMPzPhVQq
 LSNOfpU3MDAJOiMD9bV380CspjKHGzIq4JVL9fgbr81WcTKE/6VSsPqf6oSYPauK9L
 gaqTFMe1SZafSNdWxeUpLYw0SXJubXQzUgcRXIlMqVSjvoAUBWmEpMaLrpFcdshd+X
 s/qKbtGYSyujXffiZdUijl2QX6e34ZC4thaLQ0bEnkmD1chp8aQqed2V73sPrPnXLW
 y0rnDHAFz0efpoJk8ZxATxDmczsD+mSzkC0l0zC0u7fhdg/UG+nWnY/W5iUXUYVSQ8
 CiE2bZnQ3PRKw==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5de575eecbaso177006a12.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948927; x=1739553727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCW7s8IP4GJFiLJdhtVxnhOyRPZVh0H3ArXcP+Uo2so=;
 b=TBjIMyBfp0YBv0BHOVqywB50IWkmtl+p/9htga9eD7X7CzAzhrK0yhQhvwnwfU2BSC
 sNydQ5hP0SEFrddz3WpSBIq4IyGiBgk7j4lDEMXHdD+6fnkFvLtPfI2S3oqc8/uu8xpv
 Ods3zPNEosBOPIB/FMA4/QG9bToQLLe8ZiPRcjUBFY8QybbJoQ7n8b1T52WqTmnGWV5/
 aGy8iD0Aj0s+upYKRHUMo31UxdrLUDkuPYN7yjBbYab1A05j/GOlpoMlw1iGioyeOaN3
 wnKFKrqIdtFVzZCLNd83xMzdIgHXIzymOKb+tNR0ku9GI2fow+jUBoxwP9uUvinFzASk
 r0PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNgslEcgx9INxyYkP24PuhfmzBOpXn3hsnXyKhmggkYKTnouCIuGT66+BJWIGf0GSm7HBrjU8=@lists.denx.de
X-Gm-Message-State: AOJu0YyMunCuIMu2IdANkBbz4l6QYkVl2Ig9SD1s4bEYpEloPUMOv+eR
 KmkcOcLyHXiAcdgfICOiBv8VaV5MkoXYjOT8bh03zn8xi5QrIT4Vrs6BrHUALOfMQ40jAv0psGv
 /fSYvzt9pfx6DS7TFTiOAaLu+nPEJWV7hqPoWpnimvNpkRU2EK7Gbu17oiIRF8MEzQ4k=
X-Gm-Gg: ASbGncvFLHLETaUp7tgcS/Z5BYMffFcWDZc8/CTCtQmWZo6XSNfS/8kWM2v6nN03+3f
 ndxlXrpBZv6u2SgYmcaIg+cRT4F/UW5mHH8gHRBs9WQ33QFXOB5szVagswIKuebErDExC7/9Ayi
 1+O2n6KrTBobsAhjztgOQmD8VxDZCXopGzy94LfJlT6gW20A++dWlHkeu5tgqvL3VDXmsarpILs
 Lvi3d4gkkEVx4LFtzXV8cY5wP3Td6FI4esIGSHk3QLxZ2uS1AU9VGRHRpTyC3yzY1cdjDHrXboG
 xuqf1QZaePN4L3Gn7IkP9Mfyv7Azu+7vRIaQCzevUsHrzv8d7J5QWcr53BGoPXaaSQtmEhKNU33
 U2SjauNk=
X-Received: by 2002:a05:6402:42d6:b0:5d0:efaf:fb73 with SMTP id
 4fb4d7f45d1cf-5de45019876mr5835875a12.15.1738948926980; 
 Fri, 07 Feb 2025 09:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj1ndvI7iuElLAmxb2C6gZ7sQUOxWAQkoup3hVt6hCWTZkjJ9gcgUY60Nv5qKeMAMWcH3FIg==
X-Received: by 2002:a05:6402:42d6:b0:5d0:efaf:fb73 with SMTP id
 4fb4d7f45d1cf-5de45019876mr5835833a12.15.1738948926592; 
 Fri, 07 Feb 2025 09:22:06 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:22:06 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/6] board: starfive: spl: support DeepComputing FML13V01
Date: Fri,  7 Feb 2025 18:21:15 +0100
Message-ID: <20250207172116.117749-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

On the DeepComputing Framework motherboard (FML13V01) choose the matching
FIT configuration.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..e97ea90cf4b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -118,7 +118,10 @@ int board_fit_config_name_match(const char *name)
 
 	product_id = get_product_id_from_eeprom();
 
-	if (!strncmp(product_id, "VF7110", 6)) {
+	if (!strncmp(product_id, "FML13V01", 8) &&
+	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
+		return 0;
+	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
 		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
-- 
2.47.1

