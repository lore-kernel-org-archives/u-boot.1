Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93168C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0105E80836;
	Sun,  9 Feb 2025 22:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mJNmNMtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237B0803B5; Sun,  9 Feb 2025 22:15:38 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19AF80840
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so12142395ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135734; x=1739740534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmJKgIxcfQAIYD0EMA3/KIQPOQVJXOYiu32z40Bvx4g=;
 b=mJNmNMtluV3Hxqz/hGWdAel888iSP4aOzSV0ZkBggBJhP9fUNGbuL3UE7CIgRDffCP
 BsmOK+5g9vbgtORsPcI5xbDxd3y31Az8ybd++R2EVMiXT1VCtMf17EUzD7C+VWy40KxX
 rkGzDwrhwJaqx6tfXAtWUcSJmZ8UsM4oK7VeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135734; x=1739740534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmJKgIxcfQAIYD0EMA3/KIQPOQVJXOYiu32z40Bvx4g=;
 b=O6vPT+KUazsN8hPTmM2WbEH585xvWpcVrw/FwgHcG28FyJQ4qhFbPHTKjOWkpJuWGK
 01FmVoYqH090f6pCFijWoXeJGmjGx8OZ4AqaEg/SykfOQDJBd8tWGbFyKGeX+mIEAlZ3
 rVZubD+ZbdYr32lO5smxd1OumrVGRA5JOJ0M9k3EQq3tI+BLG6riHOsOzDloKzHoDfxi
 PJ/XoYzs9wY1neaZsr0pRaSSZvBN7p17CMCX/goTBY7bqWIL6SWL4N503AtoN7O/1nZn
 /YLHeqOltdJI1yVB+FLfYOBrCOYKVauLpEVWtLqI2eD1Mi3oxqMFTKR35z+uK7KKTxEY
 ZZ5g==
X-Gm-Message-State: AOJu0YxHowaExXP/xkS4xo+ZFusmlL8E2HhTQ/zJJYv7QZp2WhoPtSQC
 y6fX6EiwEBDnjgsQnBVRew7G7x2FAHYXdotqgmDMJJKH0aXI0UrinbT5coJyei3tvH/Pk9UCwIA
 =
X-Gm-Gg: ASbGncvjvLkzvkZdmcYmKNRW4Bta38rr52meR8IojioxJTTR8FEQoecoEjIMfXwPmNP
 6RWRzxwt9yiJ79K+Arrnwdw9nHv1L9Zd3/Kf2aSva6oAv9OYy9sZpK7cEsSSYjEQT8op91lHxbh
 XkSRk6N1bXmTB57qltnQOZL/qDQdLAFmitllg/wegVCprB3EbbQZtmeKeu/34zyUJ+fQVPnV1zs
 eaVG8W4q2O+uNyVriAyyQnJx15n0pw9HoGXRoon4pcV2vSzO6NUY1M7OsRxHuV/ehaX9U9F0Q4J
 /doFHEDu71vgauNEz/ShIIPWxrxAHi84279YmNsi0thaVlOaki3f
X-Google-Smtp-Source: AGHT+IGzB7ttF0RP/V41w5xcklS4ujz8w1ztoc1vLZsnWI2jESGmSlL7BJRA4jns/+tNFUegzzGeJw==
X-Received: by 2002:a05:6e02:1cad:b0:3d0:fe8:6076 with SMTP id
 e9e14a558f8ab-3d13df1be70mr108042195ab.21.1739135733807; 
 Sun, 09 Feb 2025 13:15:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/35] spl: Allow VBE to handle xPL size
Date: Sun,  9 Feb 2025 14:14:27 -0700
Message-ID: <20250209211502.2299245-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

When VBE is in use, the size of each phase is obtained by reading it
from a FIT. Avoid using binman symbols unless necessary, i.e. in TPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6b75910e243..e7157df1ff9 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -200,6 +200,8 @@ ulong spl_get_image_size(void)
 #ifdef CONFIG_VPL
 	if (xpl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, size);
+
+	return 0;	/* VBE handles this */
 #endif
 	return xpl_next_phase() == PHASE_SPL ?
 		binman_sym(ulong, u_boot_spl_any, size) :
-- 
2.43.0

