Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0831C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C3781F54;
	Thu, 24 Apr 2025 14:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WKav2Adi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07523817C4; Thu, 24 Apr 2025 14:13:46 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7C809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB5A840327
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496813;
 bh=/1XzuE3AHi9RgtMhV/3LbVGKgIIatqJo0UPiIRuzCMk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WKav2Adi2h3J0h0gq8WVtLuFj/FJSvgH7JNWAV6/+XohRL4f3xyaZAPfqlHralIPL
 8bO3I4i28kRF1kT3+hjR/B4biNB1DxmwXf/z5Tegey8DHCNcaJPbYOBjuVFK67OTpU
 0YqZcAYRhoxJweYRtLKeLk0zr+JIHroEgiOgBef3ayktJPEredGmEWiN1c4IapV5cP
 yGrx4uR0yBM4HWy6wwO92obNqbWZBs+NsNu2Dggr6WISOlD+UDaTyXIlEJ6m49OT5+
 nUHaKKyBO/ZCM0h35H3SqAX+gNx59aN1iqCvA9NvbQbI70QHM9EmebSUGvC52f7yCa
 qb0tP/lMISf2w==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso324259f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496805; x=1746101605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1XzuE3AHi9RgtMhV/3LbVGKgIIatqJo0UPiIRuzCMk=;
 b=dZrYA556UsI2BCuYEIYPlS4hwbGNgo/MEsf0PKfJDiwg+cngGQlutbMZCGvinUtDg/
 wL0g0VO/KOc1dvVZU5I5mivtTVXVPQl4wjrJO23l5z8BcPKs+IsPDkDfIprEVwi8SV4U
 8aNikng6Z9nZ+APaKihWXM33dznhymF5nIxRrQfCXHs7YaBkxf0cdYwngKve0WSC7Dv4
 FItPdkhcuhF5U/h5DECGCc4LQ+VYig3Ca9/R7fXePTVAN5E0vUk7VayRHCjYLCY6Dfmu
 cVy14hfzlH1XqgMxCpAQ7joLLfiSfIf2naG4yMkcRjaJ+vOd3U5KvD2LVbrAAMd7BQHP
 6rvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLhkQoVgcXOfQCT4Ub07vvAgGoJa+Bo8e4Oql1NLQTs67Zk4fDbHRoZ2aL/q5b6UGcPZ3apWU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxye67CX7JSTN0hHJEJxaIk3fVeuKIrhUjncQgc3re4w6hr5gKL
 xCEkxYbXrCOnUZOG781Jj05GbhkdrYlSjC2H5jO6Lq9MJaozp2558jMD+tqnVZ4vz1YCCe4pKZ0
 QsT6sRDOFS7Uh3FVLLpVTO9/QcQYHAormygvRHd2pyip8DjA7SDLniKrcSHIFff3jM/4=
X-Gm-Gg: ASbGncsNSJWLxfEbMkFWpdC5sDXp5ZgVqi0fFxbdGzXp4eie4xdm9Dh44kQYGh6qCY3
 mLMszjBALRQ/JbzqR5MWlAXU2aRnQBZ1Z3Yg74b7ssG1mBZvOdurjr5iHsMSlsYUGwNDVQx4OOw
 2SWsxFgx0GnaTlSyciKHbrd8HYHuEA7OGXNBEOTBnWzigzCFkc2RLKZjd9aZeF8QJddQJta7VeJ
 1FLyhjiRwdcdCHe1zwuvVpwTGNSK5aIJyK/toJd/Z5yh/NAQXk+rgn6/I3FMhbp80LLKa+tNI2U
 mWujmS7HqdO3M7fCJxHzdcgXGxWhOpOnS1aPQCgpYPh4WtgPZATKsIYJiWRRuyarbMg8it79bv2
 ywO3hGvKg0j4+gQ==
X-Received: by 2002:a05:6000:18a5:b0:391:29f:4f87 with SMTP id
 ffacd0b85a97d-3a06cfc5ecfmr1982132f8f.49.1745496805576; 
 Thu, 24 Apr 2025 05:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNDDvv1U3k118sb/635WhLz8s51Ri7LjPT/oyTtsY72No7ko1iIPJ+WJEaUd4lB1zavtnnDA==
X-Received: by 2002:a05:6000:18a5:b0:391:29f:4f87 with SMTP id
 ffacd0b85a97d-3a06cfc5ecfmr1982100f8f.49.1745496805148; 
 Thu, 24 Apr 2025 05:13:25 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 3/8] board: starfive: DeepComputing FML13V01 fdt selection
Date: Thu, 24 Apr 2025 14:13:10 +0200
Message-ID: <20250424121315.144549-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

We support all JH7110 boards with starfive_visionfive2_defconfig.
The relevant device-tree is selected at runtime based on EEPROM data.

Support setting $fdtfile to the file name of the DeepComputing Framework
motherboard (FML13V01) device-tree.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	rebased upon Mars CM removal patch
v2:
	no change
---
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index b8cd509bc89..5fe888d4072 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,6 +17,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_FML13V01 \
+	"starfive/jh7110-deepcomputing-fml13v01.dtb"
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
@@ -63,7 +65,9 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "FML13V01", 8)) {
+		fdtfile = FDTFILE_FML13V01;
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
-- 
2.48.1

