Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF39C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6F18056A;
	Thu, 24 Apr 2025 14:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kDcYet+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B548082A; Thu, 24 Apr 2025 14:14:25 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D3B80F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B183841A01
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496860;
 bh=82Mh9yp0cSN1h7ca2bidCTMX0L0WwedYebqvWTUIeY4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kDcYet+4R1CnpJQ5a0A8jA+H7h5i6nBk/Rwv1laQqIXJkSlsikSJqG0yx+Q5I52bw
 36O3lmccE2npGGPgYzoEvxpPfCyC/BKWXLtKeKDx/iF1BVzGWIHvcZrmdC53s6DC44
 RIJH6P2aN36q18ejM77T8qNSAXGgjsKOHdPhCIT6smkcp8ABsvsJAuX6GO2XKSAzC3
 xn+ZPyChWJnvOeC9r2ohn5aprkDckL4br58+h+AIqSB3ZEwu4RUElIBfZWrJGuSArc
 22DK+fpUhS42dzwQybAbLCOkP64f4xUGm9insukbuFDH3/UsbVmDHYUGyBeRqyTmDK
 sf6h5abyig7Sg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so354444f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496812; x=1746101612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82Mh9yp0cSN1h7ca2bidCTMX0L0WwedYebqvWTUIeY4=;
 b=Tj/D6mmlROrQwM8MI7ZNuS6N2d8uZZdNMM5RTn3hf2HcthsBh4oQRplh/F4gFuF5cT
 /Sm17JkqRO3kwiXUpIkPArc9DquPUVH4RedwtTmuzsZ/aGoeRZ0pcDoG+lzyu6kVPtUw
 7wQHgX9V8aLhGDKColhIw/cVgxhn+J4FNdCG789XjO9ufhaNaCowguiD+lCqMXOLkE4C
 1dRy1faxIM8jNsn6GrsUJrsGDucCTs4Aq5UO3/KsNS0g/na2UQaRt+bbowwbys6mdp+u
 Eo9obIjYWjV4FlWHBIWG0qclfJBIUsFyult103tUb9fDzDtFQAliLPyRt8A6wVltqRH3
 fEdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbeIPBv886uAGixuuKuKuja2mn/MLzkmFDkBwlPcJI3PDgbrZDT6PBoKLrfJHnyBbdX21Sn8E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3nFv1aGhVmtr0ARdX6fecpAaxwKcwxvd6m53zUgOlCZ1sV96+
 PumL8VRiJSNJh70F84U444Xyf8GnuqbA1xgr0XsnzbFYtFLTJTsvL2YZ8H1udog+sKl60Jc0ox3
 FAR6YI4nKGBXSP1y7RkTJcSu0vRNQvNCP1lxoEn1nnmnVaKCxMJUET8qyQskrrzdGoDM=
X-Gm-Gg: ASbGncvDQMP10yS1GdW55zOKWIpMCLjhTnNGX1mllpOOduefzmn0KiTpybBAzXRqRBq
 F9QjiM/By22bBrXY3Fvk05GLCcn2wPOZGRxY2Nm99U15vKYTN/XYNRSy4m11JXcCQE6jnLTjWQ7
 7RezUHmp3hjJs4oa+tGJBzMSz/SuMmmmTHhrf1rrNDHEho6XiAGc8fZMKWtA9ZuWHHwV9stX3B7
 xmDJ22ZEG8/X6MVfrmA/aDnQ/BR0HpgtyCpOVV6KQrbxKnRahiLeXEeMzFlq3S54DmK67r9f550
 9g10qQBKcj7SpgE9xp7eM7KMIeZib3zD38OJ2Fu5CifmPIpCZ2UAuudDwURNxe0PGsRlnk3IwqZ
 gZSfia52fMhSIgg==
X-Received: by 2002:a05:6000:18a3:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a06cfb079emr1971840f8f.49.1745496812154; 
 Thu, 24 Apr 2025 05:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkVjtD9XVzCCHtqAMV4oFttEC7esoKScdFW/0K5OZukT4dGIuwxRcnjFbiSnfmmCMbwliXGg==
X-Received: by 2002:a05:6000:18a3:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a06cfb079emr1971807f8f.49.1745496811781; 
 Thu, 24 Apr 2025 05:13:31 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:31 -0700 (PDT)
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
Subject: [PATCH v4 8/8] doc: jh7110: describe debug UART
Date: Thu, 24 Apr 2025 14:13:15 +0200
Message-ID: <20250424121315.144549-9-heinrich.schuchardt@canonical.com>
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

Provide the settings for using the debug UART in SPL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	no change
v2:
	new patch
---
 doc/board/starfive/jh7110_common.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index fb8d87a1551..4a8058ee5da 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -87,3 +87,17 @@ u-boot.itb via the Y-modem protocol.
 Due to restrictions of the boot ROM not all X-modem implementations are
 compatible. The package tio (https://github.com/tio/tio) has been found to be
 usable.
+
+Debug UART
+----------
+
+By default the SBI interface is used for the debug UART. But this only works
+in main U-Boot. To enable the debug UART in SPL, too, use the following
+settings::
+
+    CONFIG_DEBUG_UART=y
+    CONFIG_DEBUG_UART_NS16550=y
+    CONFIG_DEBUG_UART_BASE=0x10000000
+    CONFIG_SPL_DEBUG_UART_BASE=0x10000000
+    CONFIG_DEBUG_UART_CLOCK=24000000
+    CONFIG_DEBUG_UART_SHIFT=2
-- 
2.48.1

