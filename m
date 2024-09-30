Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C025CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5B888DD1;
	Mon, 30 Sep 2024 03:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FoxxQCF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9E888DBA; Mon, 30 Sep 2024 03:50:12 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9EE88DC1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a340f9dd8aso22157415ab.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661008; x=1728265808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaUkLAb/tzjoG/kpNA2a1s2g3n3b4WrRqzfRqyUWjLk=;
 b=FoxxQCF64CbmhiYwZUIWaWlqilJ2l0QY+qaOWn7h8WKm0DwGE7my59ntvyWIvEshDr
 gMA2T2CF8U6IbzHXr4JP9tmT+asbqouhFaR0YTBLO/EzphbsSpkI0cqNy8B59I9CKuZ0
 hm6HSe1aWnsCpysRXLxSMItBmuKqbHyKu+I0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661008; x=1728265808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaUkLAb/tzjoG/kpNA2a1s2g3n3b4WrRqzfRqyUWjLk=;
 b=OGXg7i+F70sMvpLbkO8SbU5vpKniJRlJc2X0/1XB17xbCCFlW+hUuyhPygIinPOm6N
 HzfirIv/ERs4WVxwaq+DKd1S80FE5Zgr6YUNU41TizbfaknhFR+d+/I6T99u4VAvWVzO
 1FcUakJ3RfZosMQTgIjoOdlUHNcD/fFV0umDMjxFqaVTpzlLz4S8Nv41qzFkGqbM9wW9
 1odohjAZxJrRE0TEV1uvS2SHLmEeDZPLf6MlPA8loP/uawOLLq48uMzmKvhnG82IqF9e
 CPwrTUuGNtYtvsz0Lg5DdGGZlLwo/XV/xbmG3la79PyvfuioOLb975pQSMiwLPq22Fmg
 u3OA==
X-Gm-Message-State: AOJu0YzjHUDny8KrrIkLTUCDCIb/WBNbInEdBNO9C/dgBrPClHqrLkPu
 /zNuN3kE4+TN8jRu0MZrN3VQhR0vn6M4idLyWjX7B2XvRGkSIoTmGsibUuc13QGxV+l+82TAwUs
 bCw==
X-Google-Smtp-Source: AGHT+IGkGbSfFm5gpN1c0IfhhB/G3pCsVkoq6NCIPr6Bhbat0tbpC+LMXrImPcwZ14mue13IWzcYow==
X-Received: by 2002:a92:ca08:0:b0:3a0:c23f:9647 with SMTP id
 e9e14a558f8ab-3a34514afc2mr87069585ab.1.1727661008205; 
 Sun, 29 Sep 2024 18:50:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v3 03/33] tegra: Drop dependency on SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:26 -0600
Message-Id: <20240930014956.1434060-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

SPL_BUILD is not a Kconfig symbol so perhaps the intent here is to
use SPL instead. But that changes the output size.

So drop the dependency on !SPL_BUILD since it does nothing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Correct the subject to match what the patch changed to do

 arch/arm/mach-tegra/tegra124/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra124/Kconfig b/arch/arm/mach-tegra/tegra124/Kconfig
index fb016aa46c9..84c8f86bad0 100644
--- a/arch/arm/mach-tegra/tegra124/Kconfig
+++ b/arch/arm/mach-tegra/tegra124/Kconfig
@@ -21,8 +21,8 @@ config TARGET_CEI_TK1_SOM
 	bool "Colorado Engineering Inc Tegra124 TK1-som board"
 	select ARCH_SUPPORT_PSCI
 	select BOARD_LATE_INIT
-	select CPU_V7_HAS_NONSEC if !SPL_BUILD
-	select CPU_V7_HAS_VIRT if !SPL_BUILD
+	select CPU_V7_HAS_NONSEC
+	select CPU_V7_HAS_VIRT
 	help
 	  The Colorado Engineering Tegra TK1-SOM is a very compact
 	  (51mmx58mm) board that is functionally almost the same as
-- 
2.34.1

