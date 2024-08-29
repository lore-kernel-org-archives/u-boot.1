Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13E3C83F06
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 11:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2867888B5F;
	Thu, 29 Aug 2024 13:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fz83mRTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F9588B94; Thu, 29 Aug 2024 13:24:42 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB0D88B23
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 13:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7cd76b56e59so191537a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724930679; x=1725535479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4L/R8LIhdZyJ0RuIhO6CixIW2PNIxOBQBRLnI5v1Kmg=;
 b=Fz83mRTh49LyIdm307s9GCmt4QCWVpHYrO2QH4q8GtZhIiwFNcp1JUhjaiuK7p8B/Q
 sWq6xwEcDxHG2OIkbNbKDLdxia8ddvUGUw4YZM6TSRXR2JD0w03rpSqXEyDmumBbEasC
 MSBY6j+YT5UZq66IDVpS5cSpfxnKb1gWCUxRA6a2TCcHvOcy55p0+2rmFu0RN5E/m0Oq
 t104OzPRWc+NxVBa3JrWm+6z9B2L/iMOulmLJTl9rP5/uRUkJ7d7XTSKpXLQLEltdjgB
 aCm+tcS99a0JAbdXXm5qVD5kpMh9m6XwrASIQrbl6mXhLromkXBbVNl0THdznGuIb+vF
 uvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724930679; x=1725535479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4L/R8LIhdZyJ0RuIhO6CixIW2PNIxOBQBRLnI5v1Kmg=;
 b=XIX1Ve48TzppPGyPo2q4n/2oujOlnRFqM2l0+d3IdEBEfff7moEoakvBJQ01h/xPhr
 ZFfakzvbt30ryHXvJKCtn060VElGkT6dNvnXMPS2I1EqMuSS3clZjj++8s4T82ZkdWAU
 ZvS2nbOxnT2wjslI8L6nTtKsTA0Y1Ogisr0dCRFfvsm0KKYeccDZkS5kmCEkJ21TmHU6
 q/Qj5asCao36C647CKzhOZuK7gyQjvw01y6llTxjmK6RcPKwZtUprfkoAxSt9Eeg5pcc
 v5p+7b2tKAPcTQeubKkvdQguCbV4tqD4oh5bcM/f0cfUoe8OnCypBJEXEHM9CbpdroDb
 bG6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKCjxS82J2f8DncHZ+MPOW9GOUttmfEP1aA1mPaKtMBvQMBxnA+6mXKX7WTYqt7lcRefPKWw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4j4ExUuEQoL+zbp+sYLbC3WUsTtLUF37TBG9qCy/agd+usFA1
 JJWyQLC5Turf6WktrXS3d0+50BeKaQvUpiWEiLQXmqWmrgh23SP8b2DW+EBY
X-Google-Smtp-Source: AGHT+IEIsOvjxUnB3aVIcqHEnVL77ZLpeoRFKyljp/OFUrE9/ywYAvIC/TWlaG8W4jXBhwCdDyxxKQ==
X-Received: by 2002:a17:90b:4acd:b0:2d3:d691:6d3e with SMTP id
 98e67ed59e1d1-2d85639213dmr2263338a91.30.1724930678667; 
 Thu, 29 Aug 2024 04:24:38 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446c1c5dsm3805899a91.43.2024.08.29.04.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 04:24:38 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Rogerio Guerra Borin <rogerio.borin@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] configs: verdin-imx8m[mp]: set CONFIG_SPL_LOAD_FIT_ADDRESS
Date: Thu, 29 Aug 2024 08:23:57 -0300
Message-Id: <20240829112357.22292-1-hiagofranco@gmail.com>
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

From: Rogerio Guerra Borin <rogerio.borin@toradex.com>

Set the CONFIG_SPL_LOAD_FIT_ADDRESS for both verdin-imx8mm and
verdin-imx8mp configurations to specify the load address for FIT images
loaded by the SPL.

As per lastest instructions from NXP, the generation of a HABv4 CSF
(Command Sequence File) requires the U-Boot FIT image (u-boot.itb) load
address to be set to a fixed value when binman is used. The address is
defined by CONFIG_SPL_LOAD_FIT_ADDRESS.

Here we set CONFIG_SPL_LOAD_FIT_ADDRESS to an address 64MB past the
start of the DDR memory leaving plenty of room for the various DDR-
residing artifacts to be moved to their usual load addresses which are
close to the start of the DDR.

Signed-off-by: Rogerio Guerra Borin <rogerio.borin@toradex.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/verdin-imx8mm_defconfig | 1 +
 configs/verdin-imx8mp_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index ef7f3b1bc10d..a6f92f3d070e 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -29,6 +29,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index fca91f7b1eee..594fea3a1b03 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -38,6 +38,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
-- 
2.39.2

