Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE7E65D14
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 01:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C745B896FF;
	Fri, 22 Nov 2024 02:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732240759;
	bh=MDAawSq3wm8ZXZkIjw1P8jug6tnB5n+ChHgN2DYCk9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OyuTt8CX2PNb44qbRW4LPb5Nyc/F/t0v4HI/xwKDwthvYE7AjM5Q++gVN3NLBADuJ
	 2BMhWYsXh0JyrIejLN0zekVoPl+ilPgeAN7NQKAJCtjBKL2J+DaHt93bpwbgJUtjCG
	 zSgvKnyYV9OpW+mCFH9vIq+5WAJqCVUvuBeyb/nQZFceMlJIxyoQXO59j2VSWBmKyK
	 WS3iDpougUt9yzuavwM5wxECs6lzgQdencIV/ErFUhInEA4+QPSniaMRdQwBjAPQqb
	 a9SgpVoNS6sM96v3XzGtuWT8Y5mG+mtDw29X6hv7g5Df4kjWT5nKAltUPxPvgjx4po
	 P9eNjv+jv3vww==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B3F6B8921A;
 Fri, 22 Nov 2024 02:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732240757;
 bh=MDAawSq3wm8ZXZkIjw1P8jug6tnB5n+ChHgN2DYCk9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=z/cr5FOXBNGztBWZzNO7cLScH9OJRism3vl5xE+khxuIlNTz1lr957kRHAUtRjqEj
 nLIKGRcJu8yJhbvPeT0aILcc1IWaaCXBRohCXEN9fBLH8IGep0+3rEqzyprVqmO0Vg
 2+DiuVFyyLCk0XZgY5v58C5QIo4QudIUrWv4BxJF4ufB0ZfcRzf0iusjMlANQsZNxo
 oj8rB+Sj9yjlzaCvxeiEDY/n2Moux2tLmZtOJlwnKA9pVo4lhxZsil3+gierlnIM/t
 TA19e0VTYGict9YbxdmpHjfIguNmTaVYn6jFh8hQ9Q8RJddyWO6fuDLswQsg/RiGC+
 gMT/KOZr5tYRg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] Revert "arm64: dts: imx8mn: Include 32kHz oscillator
 clock in SPL DTs"
Date: Fri, 22 Nov 2024 02:58:15 +0100
Message-ID: <20241122015858.557561-4-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122015858.557561-1-marex@denx.de>
References: <20241122015858.557561-1-marex@denx.de>
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

The 32 kHz oscillator was included in DT as a temporary workaround
for the v2025.01 release. With a more appropriate fix in place for
v2025.04, the workaround can be reverted.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Malysa <greg.malysa@timesys.com>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.04
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 38e1934aee8..b0cb96f0829 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -72,11 +72,6 @@
 	bootph-all;
 };
 
-&osc_32k {
-	bootph-pre-ram;
-	bootph-all;
-};
-
 #ifdef CONFIG_FSL_CAAM
 &sec_jr0 {
 	bootph-pre-ram;
-- 
2.45.2

