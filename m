Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA16CC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E74982BA1;
	Wed, 30 Jul 2025 14:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Vt7Jnf6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DD882BCD; Wed, 30 Jul 2025 14:54:37 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F2D81D6A
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 22FA63F57D
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753880075;
 bh=e2vOJZhzufmVHYwi8570f1yooJ7WyPl/kfPXy7sSh2c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Vt7Jnf6hWMv4IlJU1LvxBa7JymPjoml88JSaDKdySQC2bpj2XuKnvcLAqPFYyDf8G
 yQKoT2wWmJRp8pYQLChNII6L1w0woKDD6Q7pS14slQw9xVVXVePpunn4qAq1iA2Nbd
 9NoP2h24FAXkIC+Gvb50N9F4JQnVuA1jZIsKWbHx0NnSeHcBnrWHX1XzfrmERlgR6d
 dlvUwKkXedpNPICpN8LR05TlB4ozb8m6hTNRmF0F+yJN5/7rhlsoGDzLguF2nOn1Xk
 ZCAG1ZYDciCjQrnqNAblueDJimPcdsWujUi9OiBQ2BXmzu9OsDHperCMYE39coR9DM
 vcKMW8rfELGTA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b793f76a46so1445673f8f.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 05:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753880072; x=1754484872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2vOJZhzufmVHYwi8570f1yooJ7WyPl/kfPXy7sSh2c=;
 b=lofkWYnnlPRAwwLXz/jfCednlFeMcc5FpcZSADe4/V2qfuYs3Tp7iQ+jlL9E5sDJNV
 NgvxxGK9/e8hB0xZiigmX5VlMbax3xFHQ6flABbGYe34uY2aOKxWz+GkaD82m3ZGv4Hx
 oJYEIx0AZy8cYwg2m7Y3f6mGQ5p6CsweTlTlIi4N4qdhD+ie1RIs0zze0J7DjUCJEa9/
 te20Wp8e7IB4ToGFIwSodmClxxAxtolDa7lSzHpj+M19U2O3YQu+r2B2yTCy9kOkrHTp
 1PqAMybTTCzZbRrAoEzRnBHmTKjaXWdKr7GV4oeiID4AWsUpPZN3+WxTj0Reja1xRaTv
 TY2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTHtqdmfmWzp8GbeaUnT5rPsYIqWFTSm5G+ardVqnGgxQ7duC+cWoqOj3X9xVrJkdw/dSLIYI=@lists.denx.de
X-Gm-Message-State: AOJu0YzdIJRXAgWtzmSftgicxOJNEUFSXckFDWu/qpIrVFvNG+BP5BYP
 9FdW02TEUmXa6fPi/GwWp/93/mylee+LhNCqpkjiJHf0g9AzTA+gP0yXR+eGQX+BtpThw19tIIO
 wTO9makWAYhh5vOL2o86sAB/lp499iSRYrAEG7wdWH/pRpVr2tt0lDwWLM8lH5PV9Eg//MVM=
X-Gm-Gg: ASbGncuGhCBESws+O478f6eqdMK6OoqKvjqEuqNFz+0pYOU5x361uNg0kPj2mnpX9KZ
 TKNrtrUqcMF6R3MIV2HbC062sDMzH5qs0C0IW/CqAS4kue7gIZfXLcSbLOlyU4861daT/BeLCW5
 cB47sfOL6hMyfaJjUx/ZLwEvAJkkMOxcIh0+Kgr13YtDNiGE3EWkCvI+aEOrSped9wFJspgdDsG
 e6dNoGNDSDZAkGLc/TvCtBuZGSWxIWECQ0ix/vXRLr3U5RIgGuJ+meDBwEbq6guV39QZ1MJyrt7
 eDZ18iM68MzekkuVaCt6kONJUXJxqC6ngeh1iL9bIup5qyk4EuKt5E9Ll2G969rTrNeH8tavEni
 NtNIyaHuIko+WD+QtVSIQprwdkJyR3Q==
X-Received: by 2002:a5d:588a:0:b0:3b7:664a:8416 with SMTP id
 ffacd0b85a97d-3b794ff5d0cmr2707937f8f.23.1753880072501; 
 Wed, 30 Jul 2025 05:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo0XP5C5c5OfUCi+aXiOupfBX2253m3FGSOgkPn5k+vLm5UNinQKbrch8LADKGvMkg9JK/LA==
X-Received: by 2002:a5d:588a:0:b0:3b7:664a:8416 with SMTP id
 ffacd0b85a97d-3b794ff5d0cmr2707919f8f.23.1753880072171; 
 Wed, 30 Jul 2025 05:54:32 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b798867061sm933936f8f.15.2025.07.30.05.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 05:54:31 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Kconfig: typo restict
Date: Wed, 30 Jul 2025 14:54:27 +0200
Message-ID: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

%s/restict/restrict/

SPL and TPL have separate options (plural).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index c883f115459..22636da6444 100644
--- a/Kconfig
+++ b/Kconfig
@@ -552,7 +552,7 @@ config BOARD_SIZE_LIMIT
 	  Maximum size of the U-Boot image. When defined, the build system
 	  checks that the actual size does not exceed it.  This does not
 	  include SPL nor TPL, on platforms that use that functionality, they
-	  have a separate option to restict size.
+	  have separate options to restrict size.
 
 config SYS_CUSTOM_LDSCRIPT
 	bool "Use a custom location for the U-Boot linker script"
-- 
2.50.0

