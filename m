Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C151C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2CF835C1;
	Tue,  5 Aug 2025 11:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kh2pOlxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B508781D5D; Tue,  5 Aug 2025 11:20:10 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8644F801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso3334234b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385607; x=1754990407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAlrCd7b8rkJ/0qvdXQwWm8Vu6kBrSFBOFykHb3ghu0=;
 b=Kh2pOlxMS0YhOESn6+FLS0nk2RjLb6U/8+y4ulut+UZV3M9XpG7IqRBtys6Sms1f3N
 BYoUlI+V2OIqMT5g7nLQdtXFdtJPTL2QOd4pQPgP52iF3XDuIBOk5YYQMdeUNVeE+ymw
 Lx4wOjlBsvUluA4FzEAU7kQ6wXU45RNhMJfM8THIMzb5KYAJRw90CkrXDNn0KEX8b7Sf
 +sa0AoXRxdBpacLS+H+4De2o3lhniVLZcerMSUyAEGywp0TUiu996yRY5zCUctLjqb+H
 koveCxK8YYMSmKBW2YDVyO8PDcs2QMWIZTwr89/OWLMPHUlUA/e5iI4gU8a8CU+HSN2j
 9LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385607; x=1754990407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAlrCd7b8rkJ/0qvdXQwWm8Vu6kBrSFBOFykHb3ghu0=;
 b=HRoJDy2mFaCOWm5ibvSyF360AaJ5gb7RZiYzC6R+xTlsxGLL40bDEfrsGr0rNDmi0u
 xKLztkUk7E0PwdOUTuORgih92ato8VNJmT57ZOpcWuuRnx5r00Q7di0xdsvg/0cLTyzt
 TmDwAqJx5i94dFFQEGAhtxNUU+xJ+uDc0SpkTZsTvOeXP4quh7KIwNZ7bF3lAaZFd3Wr
 Nxg0n1A+eqaMYm7iuoD/CCWZ/DEpiimKSUy3NQ5S50RiAYR4lryeEqB28TLtkvbUpWXd
 WTbalY5wx/29KGsa/Sn2ZuUBB+OG2kJ1RukxLH7E/CMZfp/xqRMq+aLvs6tGtpDglVZA
 CKlQ==
X-Gm-Message-State: AOJu0Yzs5Qe9Th78Eo6x+bvlr7O1wq/eQi9SfZl5mf7Q+2QqgHt8Rfke
 Mnbvjm6sV+euzEfQuXwXtMiNhqJ1aFK/7YbscfQY9au6dz/3gj3788DlRIjMJD4Y
X-Gm-Gg: ASbGncvLNUn4C8lVQEB3YQ5cbdrIX+rqvTl/PntUmozEXo51kPZygfwFkubO0qrU0ao
 iZ2L1VHhIRk4vghVauEWcN5/yddfdus9M2RBFe9dd1+yNStOzzl1U/pbfVdqkUal/Hqe7DYulC4
 ps6x2UT+W4QG/ohV0rFp79cKGclWoeuTjtIH2AeyJf+7dZmSl5CAfG0VQ9P0r/abjJ84jcDKDOt
 Issx8VcFS0btfx9PjtTat6voRVE9MUktMypLn2FGxHJjaxHAMw/Ls5e81oMlfXbrtLrdEZtN8sB
 TsMUBBequmegwxnzXm/K/dSTROKzkONreXshM7U+d9X29COkWBlIrAdWdlPCVNSGbrQp1/D01jU
 gEhBKysPrwj3D5BNq/+ijhM6WsfTnhpcy/A==
X-Google-Smtp-Source: AGHT+IHvFwwjdE6HK6y8zQlNwT3Si/vnIjAXStRk4/cBAG99Yry/LtMysvnFwSfcFcHmH1w5/h2yog==
X-Received: by 2002:a05:6a20:3d8b:b0:240:1ca4:297d with SMTP id
 adf61e73a8af0-2401ca42c34mr5530541637.13.1754385607017; 
 Tue, 05 Aug 2025 02:20:07 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:20:05 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/9] net: designware: Fix get_timer value overflow
Date: Tue,  5 Aug 2025 17:18:47 +0800
Message-Id: <20250805091850.2051096-7-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

get_timer returns a ulong value representing system time in ms.
On a 64-bit system, this ulong value is 64 bits long. However,
the driver stores it in a 32-bit unsigned integer, which overflows
after 49 days up time, causing the driver to get an incorrect time.

Replace the unsigned int variable with a ulong type to properly store
the value returned by get_timer.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index fce3ef910cb..49b1f6f2c92 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -532,7 +532,7 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
 {
 	struct eth_mac_regs *mac_p = priv->mac_regs_p;
 	struct eth_dma_regs *dma_p = priv->dma_regs_p;
-	unsigned int start;
+	ulong start;
 	int ret;
 
 	writel(readl(&dma_p->busmode) | DMAMAC_SRST, &dma_p->busmode);
-- 
2.34.1

