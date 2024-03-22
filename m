Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D373AC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F08E88231;
	Fri, 22 Mar 2024 12:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107826;
	bh=3GUiFC07m0qwr35rR07HyNFx8NNeFTHvBCC9w/+RMXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwTt4cskF0ck9InalTf0H2pDGEjCsX62VpFI651kISBSaa3YO3nkqstQWkdAY0Qq6
	 4RDiwpqZsFpetsMPu3EpInWvPHOy29knM9bbj0Fo3GaGmhgut+HshrSgTZH1ur3IXM
	 eWcfNrp9w54YgKM55CaQ6bAQbxPQmYrFc3nUJf5MFiNSX2B87a8r4mx+Ds9iB4JxSe
	 yOAapzxdQTtcjAAEUfXbbb72PM+g/vNcHuQ/5ZH9KzZLhG3uyl8pAkfHyTDxi9+BiC
	 AxhjEUwtTD/UEVcDy4x3Rdn4tFHZGKSiFzmMsumtMUOdQ56OpN4FMxK4BGbb8t05mT
	 gUJ7BoN3pW4DQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C05D388223;
 Fri, 22 Mar 2024 12:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107820;
 bh=3GUiFC07m0qwr35rR07HyNFx8NNeFTHvBCC9w/+RMXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZRxQbdkT6hkBFNYR0No8zBLdj3hPlBag16LFgu/B04LyG2xjV/XvV4N+CnsHMTgPg
 9TSnIX2dBTKKZBXk3OBFTHot0QYPLO03B1uC5q+xxbha3zjOWLwTN0W1w9E2T1uQGs
 0XwzjmN2zFK5io5DFBkdVw6B9tToikQSMjlNQlQVm6zuEeH3MLrNqLf8MZ1g/SZwst
 jx5xVD8F14l+dHf9z3pTD68la6P3u6jHWG/eNLkMeCuBFTcLM0EIM/wfMHflM9fiq1
 3E+de6FcQua3fZTSBA1UiRmBh7/EWmR27WVLoBw/es4Zhex7Y+J+OujvW7k4Fx4ldc
 Z2fDhB1k1oPTg==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/12] arm: env: Add support for booting different HW
 revisions of XEA boards
Date: Fri, 22 Mar 2024 12:43:15 +0100
Message-Id: <20240322114315.2720727-13-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

In the scenario of recovery, the FitImage is used to boot the system.
This patch provides support for deciding which dtb configuration shall
be used.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---

 board/liebherr/xea/xea.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/liebherr/xea/xea.env b/board/liebherr/xea/xea.env
index ac6ac898ec..9dec4016a0 100644
--- a/board/liebherr/xea/xea.env
+++ b/board/liebherr/xea/xea.env
@@ -112,7 +112,7 @@ sf_swu=
 	sf read ${loadaddr} ${sf_kernel_offset} ${sf_swu_size} ;
 	setenv bootargs root=/dev/ram0 rw ;
 	run addargs ;
-	bootm ${loadaddr} ;
+	bootm ${loadaddr}#conf-imx28-${arch}-${board_som_rev}.dtb ;
 	fi
 net_mmc=
 	if run netload mmcargs addargs ; then
-- 
2.39.2

