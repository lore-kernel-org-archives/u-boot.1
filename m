Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64BAC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6391A88B35;
	Mon, 26 Aug 2024 18:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hFDOiTGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4676F88B1B; Mon, 26 Aug 2024 18:50:08 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BC388B03
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5dcd8403656so2018253eaf.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724691005; x=1725295805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0tDf7fp/K6uFKbdamYR8nK9NAh/3Vgv7NpOV1jnz54=;
 b=hFDOiTGch1Y+SlI8Hyxdso9YfXVZ43Cc4XGdySEwtvWljt8DaC9xia7WECPU7VTpHy
 QQqdDnSqHk/Fv12qud1RnTdYpVAgWVDg5rGyuaJONPild+xmEeteWOZGRFA63E6ne8ep
 cESRmOVqJO8TGD52lxfgrGs1MO48IiyptlJM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724691005; x=1725295805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0tDf7fp/K6uFKbdamYR8nK9NAh/3Vgv7NpOV1jnz54=;
 b=RED39xCiK+AxAbb/ubMjsETNilqS1ev3dY6YAsRBlniAkeFQVwxSRE1FaoutQ+2QBp
 LDnRQOIIkWs9fXBwBn6euzIcw9y4Cts1U48S0MQ4rP5bN82p9wO2EeHxK3tnJlJxxPcY
 qopHtuOZusmgVZQqK1mk4FOy895N63cuPzbDIsXchTmMOBekY0PhQkEF00/sChMv2gcY
 L/cf38ySyegEXfiXj2a+qbkt/VPOqb5UKJ5rwqzPwtdxvaHvV7bVd2MMbzNiC8vKFjqZ
 Ozs74+qKRXD4mGrXC4TKZ5thcMOSbR7s9VaxO9I8UuQlpkA/wckJ/K4pgDD0LLf71OGr
 Pv1g==
X-Gm-Message-State: AOJu0YyxeLpMh9pfqJH7C16ga9MRSq30+hj7Y6Lmu7uth4/wMrfH213v
 sxHJIOeVCiTAEPhTRgb+aRV7t7STFkkCC2ltDYxwO/jANMIjy4K1YqfuNhLrC+7KjnTzkXc/mnw
 9
X-Google-Smtp-Source: AGHT+IGn5Zk4eridj3Dq8vzZOTvDqVeOOcD4K3TteCoBgjT9SvXxBnCN36pukIx1LDLIN5tBoydp5Q==
X-Received: by 2002:a05:6820:206:b0:5d6:ae6:a852 with SMTP id
 006d021491bc7-5dcc62754c8mr11282783eaf.6.1724691004625; 
 Mon, 26 Aug 2024 09:50:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d242sm48576136d6.16.2024.08.26.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:50:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 1/6] doc/arch/m68k.rst: Update toolchain comment
Date: Mon, 26 Aug 2024 10:49:52 -0600
Message-Id: <20240826164957.2789525-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826164957.2789525-1-trini@konsulko.com>
References: <20240826164957.2789525-1-trini@konsulko.com>
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

The old wiki page has not exited for quite some time, update to note
what we build with in CI at least.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
---
 doc/arch/m68k.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/arch/m68k.rst b/doc/arch/m68k.rst
index 8474ece62c7a..de7eb3849551 100644
--- a/doc/arch/m68k.rst
+++ b/doc/arch/m68k.rst
@@ -82,9 +82,9 @@ A bash script similar to the one below may be used:
 Adopted toolchains
 ------------------
 
-Please check:
-https://www.denx.de/wiki/U-Boot/ColdFireNotes
-
+Currently the `kernel.org cross-development toolchains
+<https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/>`_ are
+used in the project CI builds.
 
 ColdFire specific configuration options/settings
 ------------------------------------------------
-- 
2.34.1

