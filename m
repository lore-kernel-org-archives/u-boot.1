Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F94C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898D380840;
	Sun,  9 Feb 2025 16:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="H89rrM/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2C580821; Sun,  9 Feb 2025 16:23:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E710807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7725B3FE72
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739114618;
 bh=ig8BtmEUyEVEQvlbZGhn/FESSQE7uv63BbrIdzspe3o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=H89rrM/EAtiKh2Fj9ZWsrQl8MPjqIKNZ4hrt5ZwO5go1qqE7X/td4c4+luli6q+Gp
 YmZ22Sr9dz9J+hhg+Aof0/N7GOFibwMsmorYd/T23J9AAJWWKaECqDC2NIrsJFNdY+
 Ea5yQez+Izxr7af3vYz5une9MIysqwZdbP795M3kbY3m0LVhgDZSEmoyCdMNWs/C6p
 HxJtCOs2duJeL6Hfisz3zSiYjR92i81h8TmFLawMz1DSoV+OW/TlWZpn+u4TuU9Y2r
 Wy7uWoWbbji4nrfJKzhEKKCkwuF7yaOvs8uYnBdi+1syX1fCz9MBwvfRUXNGUZd7sJ
 dkmS3mDxM1PLw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dcc9653a7so695794f8f.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739114618; x=1739719418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ig8BtmEUyEVEQvlbZGhn/FESSQE7uv63BbrIdzspe3o=;
 b=XlWr8wfoITr687YSOJ7dbG9RRfQAqHEFVf6sNBNJVIgF0uy2aFrShuJSMYdCc2iUUW
 gezpuUe4au23fXZ4/pWvAZeOy04OIYFbOU1FPPVKdi2JI8iIgh3zTGR2zfEpxCfE24r7
 Hqhu2AJwby8iK5sS3NTgqmqw1Ej8btDOuVP/vwSWwdHQnriIP/6sOnnEY8aS8D2k5waa
 hpbZXTQs0eAEG/YVD9mBRIJVIWaeMkvHz9jDe2p4txokdxC3spE5kZipWPPn9Ii4N2M2
 ugO9NvIb6ZVh0dPtNQmva8mjVJer2YktMorOfZowGJADu2FEVC5WWVO+SlfW4jSLRZoU
 oqUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrobPtMKQgEpMWb4ZCCcvfzD1vWqLBUXxS6YF7bVcJ9t0xqk7VgUhBQi1dlppoWvfhZ6E+UkI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpJflsUPyuD8VXkAKPf5s1uUFrjpucx9DqeTgi/fim/KBIQlZu
 Ag557oTxmqoIZxN5iAxUwrLLDQgPplDQWIlFzE3urkMzdK9X8MYBymWvl9O/TrRrbzC0Pw8TiVE
 meBbVtvW6Lp/aVNkYN6bVGUUYVFFpDtINEFsxOWrjxJmD56D/Dy6JVqNSjgEHDTr5E4o=
X-Gm-Gg: ASbGncu7AnuV5UDxkRlbLe+9T/iA2GjHqDc57W6/kyDJ7swjuntqQhjH413k72gPsnN
 rqxU5T1lEzZDio8Dd+2V7o9q4YKfp9t00qW4nxe6+l0D3J43TVHm/Bq5AVgjHjCGp/tX9ZgDlUE
 6Q0gyF208jjPq/4uwfnHP5/ygwBAvSvg06nn8BLZqUZSr82+/aecQd/diXkOlqTpVLbkHtroBGZ
 OGxVJ+sl41w5M8Eeiilyxw2zxbhvRbY1n3/m5CXAAEWP8DAdL5GhzPj67GKhLRUu56IovLFj4Gn
 tZQeWGj3cEziKUnM1KS3HpxvvC51wsZtEmECsnJAhwAUtpxZh+RwsDwSTkIyBxF2oVvqzrdjHwn
 jDC2ObX8=
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38dc9497d11mr4738732f8f.53.1739114617777; 
 Sun, 09 Feb 2025 07:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELiaXfN/BCstxPHtHsBmW7mXzK5u6OdY4RmoshQTCht27gVUKT+W+Pw07SLqCozGjb6cq8Fw==
X-Received: by 2002:a5d:638d:0:b0:386:5b2:a9d9 with SMTP id
 ffacd0b85a97d-38dc9497d11mr4738716f8f.53.1739114617399; 
 Sun, 09 Feb 2025 07:23:37 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd016496esm5912663f8f.19.2025.02.09.07.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:23:36 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, "E . Shattow" <lucent@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] riscv: dts: add OF_LIST handling to binman.dtsi
Date: Sun,  9 Feb 2025 16:23:26 +0100
Message-ID: <20250209152329.187194-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
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

Binman can automatically generate device-tree and configuration entries in
the FIT image based on CONFIG_OF_LIST if the binman node includes the right
sub-nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/dts/binman.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..7edc36ccac0 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -82,8 +82,9 @@
 					};
 				};
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 				@fdt-SEQ {
+					fit,operation = "gen-fdt-nodes";
 					description = "NAME";
 					type = "flat_dt";
 					compression = "none";
@@ -94,7 +95,7 @@
 			configurations {
 				default = "conf-1";
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 				@conf-SEQ {
 #else
 				conf-1 {
@@ -115,7 +116,7 @@
 #endif
 #endif /* CONFIG_OPTEE */
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 					fdt = "fdt-SEQ";
 #endif
 				};
-- 
2.47.1

