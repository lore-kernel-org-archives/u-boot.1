Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC54C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3427287D50;
	Wed,  1 Nov 2023 17:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kjw8Uh62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CF787D36; Wed,  1 Nov 2023 17:28:42 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8332B876DD
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6754b4091b6so8796d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856114; x=1699460914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3DwzfQlzAtaLynsJJDZXaiatyQktJ9KuKiTkUErC6xM=;
 b=Kjw8Uh62dlPAyyaOkUjSNE/rmUT8f66NaM5keZK6KsJwzJ2x20NJ7rUCej9NkLqhtr
 VOpEGuA+Dp6yGxuJudKEgmtZbmQUCuHeRdEPEfNnr/wciQtRpqpsdG9tmHYhi2S7VBIa
 VMANMcrvbBdpqZae4uPRYYos+z7BDwxingzo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856114; x=1699460914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DwzfQlzAtaLynsJJDZXaiatyQktJ9KuKiTkUErC6xM=;
 b=QNLPSNpRmxpCn2wLhrR44BTkb0hJ0YAO/mJP00dwVPBcimHLoYs1zPul3xsZpj0/Uz
 NWxm9Jgi3u9KRM553+BSpyvpJ7VBgO6wIgwWzC/5BWdEhy4LH/X+ZKdL33xce+31+LaT
 Mwwn8DcaYoUZsdeMMDsZs5ek419nFOJmt3UiAXSbMdktLrJs0pg92rYTpos3w2o0MZ8p
 EaTXbNDukWdY4DGQ4nL2Vh9W0FjRNkEfjkBNaCEUBb5k2zxNPREDytsc72Ld4qrNtpZK
 t1Zq0qNPi102R+xZmYslhEFj1rATYoyAJJpb3opAr6zNiop/92N11jJ56N0mj4bWl5T4
 RX4Q==
X-Gm-Message-State: AOJu0Yzh3YBy0fU5Z3PRzu1FcSHB/Q0ktmN29mweJnCB+Z7jqYOfDpjU
 eW+IQWT84DZCE6oF6kmIre4C1MDbwfSGaKZm/g2LpQ==
X-Google-Smtp-Source: AGHT+IFS7/XHz8h8glmJJGsADDBF5OeaXVxdDlXFZwjiKfgD/7KtvnfAJepBZCXBb4+1APG7+KNR5w==
X-Received: by 2002:ad4:5ca9:0:b0:66d:2813:fd18 with SMTP id
 q9-20020ad45ca9000000b0066d2813fd18mr23309288qvh.52.1698856114144; 
 Wed, 01 Nov 2023 09:28:34 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 09/20] qe: Add <asm/ppc.h> on PowerPC
Date: Wed,  1 Nov 2023 12:28:13 -0400
Message-Id: <20231101162824.3755579-9-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

This driver needs <asm/ppc.h> when building on PowerPC, add it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/qe/qe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 736dd8558b60..9631337b8d9d 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -23,6 +23,9 @@
 #include <asm/armv8/mmu.h>
 #include <asm/arch/cpu.h>
 #endif
+#ifdef CONFIG_PPC
+#include <asm/ppc.h>
+#endif
 
 #define MPC85xx_DEVDISR_QE_DISABLE	0x1
 
-- 
2.34.1

