Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572FC83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 151AC83560;
	Fri, 18 Jul 2025 03:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OwkbIdqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF1D8354B; Fri, 18 Jul 2025 03:15:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9859835AA
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2fef7f6d776so520381fac.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801332; x=1753406132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dNwEPPn2E2SfBWQKBPlnljzMOFynea9X5PRNTM5k7qU=;
 b=OwkbIdqqVSWMd0XZ+ET4N/FCTSFGSiNjh3n2lzcfjqZ2FzGo+Qq7zWsmrnyOcDAQkM
 362QUnCzGxkPvts4svebuuClS+n0hgrt54CHcouLlEf5OGzm3EAOUiYgSt2chcTTMYtt
 Ai8BJoz3K+yeu3e8xHAYZBFx8rEFws51//MB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801332; x=1753406132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNwEPPn2E2SfBWQKBPlnljzMOFynea9X5PRNTM5k7qU=;
 b=UioKmatIdNDR1sIkvwoCDvVd+sX6tNgMuPeqVkAJkma11dmdH+9vZxHD66UQzbM3oa
 CJErnM1b1jUwMAtemajsRf3mnhgOtnQwY/+Crrpm+Ig29fbLQhaSipkK36XrDP1LNy2x
 rBdrMdqXN64QLzNG5wP2vdGZiOcgqB/dt9Q+E1STRrO08mcq3eI5pdD5HZhwadvlWewJ
 POam9jmr9lvhoEXgVb8qdlIM5O2dgknUY7Fv37K/zA1G65ZXaMmrUM2TSePyndTWNE5b
 azBDPGg7P7TQC04UFxgINgvmt9mzFDYqCQkeQOxFiVo4jUewPPR1KlO1TW/yQBMgmYHE
 6yRw==
X-Gm-Message-State: AOJu0YxDbP1DTHcuebf8q21t71hGtI3RwW7sfev48kfWFvsTtjGscleC
 a9JCHaa8SL9gAPERR4xz/bVpxudfIMB+YbKKU18HUaJtPZRI7yjIVXqFc4tMCwbUTua5pcE7c56
 hCn+uofw=
X-Gm-Gg: ASbGnctrECCqq34PiL6qWtWfIzRYKG/9GnrUZ9kjnzAle6Wo+i9Qx5vKqyzOMMupZ7q
 gfyyX0dagShoJaihEYnE+K+VplFblUFGFs4cf+nURgNkvrculXNCTmyH+TOlLQkVFnqaj3Hw2cC
 97H45b2xzaHgv9lw/eQwLajOQc3+bgKV6PHK88eNa9iZO08SwQp776KEZR9gjxHCPBa6bz8Bucb
 B2QNshV+01kD1Faxb9Zdt3DcgGSVt1Hxvm+dCl+Kek50XK7s0Jlkt0XMpk8x8uS2idQqPoBEsKt
 UvXcLCl3LEi7iph2O+led7ZkcvFx09zBILQ5LpiP5n7AdD/k8iKsygGp+Y85T7A0ZpzzzSWSf89
 nKi18Fh//iAPMf3wWgB/cXCo3aIgELeYNMNcAU2ErsXXTVaLcqHIonaSsfgUwbjGxSOsBVw==
X-Google-Smtp-Source: AGHT+IHVKdbfNMJC94ZnD9JjKMo8jJ7slXMs+cbeX35t5QUfAbZtGyb9UEtzgH0HAgNJTlmIto4LVQ==
X-Received: by 2002:a05:6870:2052:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-300e8d1ddb9mr763554fac.10.1752801332549; 
 Thu, 17 Jul 2025 18:15:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3010220aea0sm204065fac.20.2025.07.17.18.15.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] nvme: Tighten requirements on NVME_APPLE driver
Date: Thu, 17 Jul 2025 19:15:30 -0600
Message-ID: <20250718011530.1333880-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver requires Apple rtkit headers in order to build.  Express
that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/nvme/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
index d138867666bd..b69fc4ed53d2 100644
--- a/drivers/nvme/Kconfig
+++ b/drivers/nvme/Kconfig
@@ -11,6 +11,7 @@ config NVME
 
 config NVME_APPLE
 	bool "Apple NVMe controller support"
+	depends on ARCH_APPLE
 	select NVME
 	help
 	  This option enables support for the NVMe storage
-- 
2.43.0

