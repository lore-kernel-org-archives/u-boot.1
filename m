Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076DACD4842
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C0C83D9C;
	Wed, 12 Nov 2025 21:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fdiQYHr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE22883D77; Wed, 12 Nov 2025 21:03:29 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939ED83D4A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656eb0b1294so44163eaf.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977806; x=1763582606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/dMe8/C0p3BiNhRUdmsUyoiYatcXX0KGhAvgUHr7vI=;
 b=fdiQYHr+UYcMP2j1BxaVWYkl2DvWTte1XQq6GONZ8BpTeoxAYN1+18GyGp3r1q0Py+
 OfdV0WrJ4WfDiSpTgmv4C4GPeWI3/s5qRM0LAv6nRBEF/sOJzYbcxXkS21na1Srh4xdh
 EWv/6M2PHbfRQYeKSTJGCWQvA+qFkS2CrYhc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977806; x=1763582606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/dMe8/C0p3BiNhRUdmsUyoiYatcXX0KGhAvgUHr7vI=;
 b=AhJT/UV3aAXLXZ8n49Elq5DomUCoblo6ME5q8GCybqMDjwBRL78jsPN0XewUhwE3P6
 pi/vQn1j6FJyy47X1x8gR10hg/U5LNjNEFP1BSW0JChV/QbtXNqY32MVrUfZzPQbnzGT
 akACgPeRh/u73ZupLbmoZAE7zE+h0NWOKrjvef1qVZrYFmz+eS9Te87pqNkPtFtGo+tn
 Dg6Z1E6n7xgsn5BkQ+/C9RWIXMWRKeIzzbGpdosBnF25+c0su25nbbjx5jQi4fM0Dp+a
 dvQXJDOYfWi7gwD8G4fnwp84+IsL4KkDPy/oTvGJOF9JulvN0ojOoxUE0gVxlS6MMQYT
 DxRQ==
X-Gm-Message-State: AOJu0YzLAnAyDo+3+7YJacyqogZtE46otdhmatFf/zQky2BZbnW/s3YN
 qFtdSVlrFEznUg/mYhIMtn43+GD8/YbncbBlsbgsm8vuHtR0qcT7fuZ6gYJQohSszA1doqu1xqh
 yPWOiNAqaRQ==
X-Gm-Gg: ASbGnctXE9V5tu+sPWwVV9ZYy6dbEqxFqQuBzkQn0IPEMnRwELzfJHSEFHd5u2QL5yY
 thr5uMfAMOnxUSRmRa1QG4QoiSgzkZyErJVKLB+zPFX1U4PaUDLSOnsQ36LqreV100lsLD12rKG
 YQ6auc1JOLFXOlRe3fQOoxxPqa8I3R/ZHfz05Hya7I6VmzMJwW2gBDKPFPKpS8r99kX5oa75iEI
 sxfkS/SjIMQaC67lQ3nJ3+0irmlskWDL/osTxAPWXOIIBqXx/rGoC4hU4wGapQwli9gwNoQvD4J
 jAIi/dAYqEDpOP238Xm+N1+0VajNJz7YUlFk2eWCNqNMdEgJ0DsQ9sbQ6HjFFbgxwR5Mg+MtseD
 IDyH2/3lY5ofyXW6fpwJFLibR7Faryv5V6QEDWLmyLjFP1H62XZcMJte5SjqYShCxOtd6TKUeVf
 qm7x1y8QCXxqerTFbS3YdEENFmztzArjBv8jxZSxJiS7MmaCvPZvEc
X-Google-Smtp-Source: AGHT+IFV8ZBfVVb8Zl3VPrayku8Sy/0077fKxUdlzFJIM9sY2Y0bsvz7j2h9lIQ9V2FaRlkeBq9ZrQ==
X-Received: by 2002:a05:6808:190d:b0:450:5ca:5170 with SMTP id
 5614622812f47-4507460c425mr1837869b6e.33.1762977806098; 
 Wed, 12 Nov 2025 12:03:26 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 4/7] video: anx9804: Only build when needed
Date: Wed, 12 Nov 2025 14:00:05 -0600
Message-ID: <20251112200315.1111980-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112200315.1111980-1-trini@konsulko.com>
References: <20251112200315.1111980-1-trini@konsulko.com>
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

The logic for how to handle this video driver is slightly odd. Only in
the case of when CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804 is
enabled do we need to have this file built, and otherwise we have a
dummy function in use. Correct the logic by only building this file when
needed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 4189b81ba6b3..984768ea156d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -56,7 +56,7 @@ obj-$(CONFIG_VIDEO_DW_MIPI_DSI) += dw_mipi_dsi.o
 obj-$(CONFIG_VIDEO_EFI) += efi.o
 obj-y += imx/
 obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
-obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
+obj-$(CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
-- 
2.43.0

