Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0320C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C5C8192A;
	Tue, 11 Mar 2025 18:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WMx3H3zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264FA817D8; Tue, 11 Mar 2025 18:55:52 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175B88168B
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30797730cbdso61157081fa.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715749; x=1742320549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxKh7pT6JD9isv+05Psi5nMfdgSVX39T3zsaR3ZYLdw=;
 b=WMx3H3zdizfTVRmE8si6oJN4zoZZSsMNHBYHK8lzW7FtIkP/NIyAh1yi+zTz4+ThJB
 uDHrnaTQOwsDT4I4CdQO8kO41KLDHs7/EwiehUr+O2Uchj6GC3AcMq+TvGU3HsNc8zNc
 j33J/lq0tEYuPPgbhvBGVP3i0+GMepKfxqNPnTbmDExpmqYnkTsdy3WkEoUCchG1lxc8
 4RjdP0zqJzaby2uWZix779eWFSy3q33OT08WbzbEK2CDibnJFJXwn0LV0uAVfx9WvKYX
 LNMLU6PlnFKbOtUvP92ysXoTSiR94iYdASJ70ZE3Q/9pDGknUetK5DM2BnGYracDZyn0
 pQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715749; x=1742320549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxKh7pT6JD9isv+05Psi5nMfdgSVX39T3zsaR3ZYLdw=;
 b=ka2Rro8z4QbEY0AHJnJ3Euxal2geJbIpMwadDU3I5ys1jvpveiAQ/nDwR1ZypvB41Z
 lo+fimkaw+9W6qD+NCC8ZjTVCiJiS2oht6amAJoyhTamhjAMpKlqtdlcjm6/63p6Uh9T
 kKfP2X1zhU5E2upto6UcmKdAXruEncPtNMvzyf8tIlaI0R62D6OIjzCtaTP7LH/eco18
 /agnhRsOWHseJS1VnBXqGxW3s9H2AKT5HBMLo6o4gLpYjwXDKsjklSBdSoW+zSkGZ/tt
 z1cAcUPDNlnTZmMauBztc7/z38f5rSOXB8niNCD1BzHU98Hxks6m9G5erJndm8Iswfnc
 +dGg==
X-Gm-Message-State: AOJu0YxhU+MWmUyb8riT+Axq6c6ix+W8tn7SFKJ7GxvcgAEM6Teyx0KU
 l8t8BmGo8Nbn69SmZJo6McaWiZZ/kYKY4UcDW7DHJuXFUcxjNoiI
X-Gm-Gg: ASbGncsN9Dvm0Reo48ZrDbCmS+S3TcXyeBaEhyb+aiSgtLAnAZmREjZTsAFq/b5oPX0
 1q09q6GVtrb/bd8Lt6ZYpmNJxDadspS+es75QH7/O7oT88vpDEeqaW4tfqXe00NluYNDP0mOBAm
 eNkdRCd8XsBEHDId2VLfwmhxehlN3aIq2EpPmwFQDLSzGBV2c3VrmQt1oL7aqx0cwXwWe/drppE
 x57JbVYN/C5s3rFMzj3/5lnmt0Q5/eH6BGCmzkI3nb8Prt8DDM6gVbKbdq1U0vzzKSGfrct3nMM
 iDh7JSR2Vie/T1Ayq9R4zfJugXVVrCxBd+Ac
X-Google-Smtp-Source: AGHT+IHa58dR8doTuLcY9U7zyoN7deN/gfvtVSJbdFwpFVuyVcGv3gD8B8Sm4iruRA4Y8hDdpIWvcg==
X-Received: by 2002:a2e:7207:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30bf45360a1mr67497961fa.18.1741715749166; 
 Tue, 11 Mar 2025 10:55:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/6] configs: picasso: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:20 +0200
Message-ID: <20250311175522.120018-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/picasso_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index 994951bb81e..a9b7f91b735 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -21,7 +21,7 @@ CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2085
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

