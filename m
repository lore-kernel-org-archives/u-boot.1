Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D0C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C983C80815;
	Mon, 20 Jan 2025 22:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bhjy5zdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CA3807D9; Mon, 20 Jan 2025 22:54:10 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977C7807E5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ce85e37887so50244785ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410046; x=1738014846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EDtNef9SbXt4CfoHyWV9IDtji8nsuwJD5xm00M44kk=;
 b=bhjy5zdkPrPhXUo92UZVWL429wdnV0XI1lt0TOrnQ7tWEZSb2tI6z72z0t6KpDK4+v
 Ec+F6nlrr9IayjXwdZzfCmbZfTHgOsVosmbSI97bioNLRA3wz6/tyHjFF4jwwO5pI3sj
 dt15NYlTwAr4vEF9+Hq5RzBIqA8vbot9gcAhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410046; x=1738014846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EDtNef9SbXt4CfoHyWV9IDtji8nsuwJD5xm00M44kk=;
 b=uGNFTJXMBRboijRil3sfZ7nYNTL2GWN6i1PgMqF3PFhpKy9Gf0js8QzDk2oQhF+Mfm
 LtGgBrs4cYXCByvdYWpQ82nMn+S2LewkJI3gz8T9x8z+Ws+ru8SU6PmF9Iobc+06KxDB
 B7ApPmqQ5LpIC/k/whj4XR3cdfSacd/RBWdDwvFx9RqgJ38KlyWQIegE5+6n2Gdu2izT
 tX7caO9WNS+8cupV5NZVqMtuFUQAOJDFHYhpmVsrEO4L38CGXGtMIHzr2vDQi63thxri
 3kIS9NYrdLbFOD1STIaZwfHAWV2F2dkNerb6Xahfw3Uj/CRsjIuAneFHwFBRQ74GV5x1
 wOZg==
X-Gm-Message-State: AOJu0YzU8jn/NaOnvCKoMlp2VL0WyB9BevxLpzn/8uPuyV0C+8mY9/2x
 cyVPbBecBpeXi30QhxIxRHx390N2ylcxPT05BJb7c6ZlarXc64jDr1pnL1jR1kbSdspSxAMsXmE
 =
X-Gm-Gg: ASbGncuV1TIxaErrm8hlSluvU14Lp5n57X2ym7VJWzonp5HeFioGQuu0zGm8HH2ee7j
 1zRwM6oP+osuvl/UVToq209npvq2WgoW7ULC0wchBtH8VdMjR6/F9GJKqeu32JmFv9nKLwjQDe8
 X+/BXU78iIRzL+GOozjlPKsd9u8HpkbbiCxAMXkx8QOyMkhMiRu2SLelq9r8ba/B29yIT2T/yXd
 aqOO5Ufysc50t2It4Hd25OaK1vUD8BuHyhesVuk+4VhVQUFicL/dlLPymOPB9/t5LOmmLXCxfi6
 fxcgdv7z8xDPZazM6+ugTrjOxCtrGM4=
X-Google-Smtp-Source: AGHT+IFOnkAhdt+UqckwQBGRxnCKQlO7fvRcMXMqjJtwqC6E3zXq2BFlqHSnoc+ldejfa7XkDnrHDw==
X-Received: by 2002:a92:c26b:0:b0:3a7:d792:d6c4 with SMTP id
 e9e14a558f8ab-3cf744beabemr143077785ab.21.1737410046441; 
 Mon, 20 Jan 2025 13:54:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/28] test: Move fdt-overlay-test rule into test/
Date: Mon, 20 Jan 2025 14:53:10 -0700
Message-ID: <20250120215340.617194-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'fdt-overlay' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5d1b3d0f217..655359d254a 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
 libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
 
diff --git a/test/Makefile b/test/Makefile
index 5ef8c379cb2..99d4797d968 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,6 +21,7 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-$(CONFIG_UT_ENV) += env/
+obj-$(CONFIG_UT_FDT_OVERLAY) += fdt_overlay/
 obj-y += log/
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
-- 
2.43.0

