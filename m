Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB229FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A59F884372;
	Mon, 27 Apr 2026 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wSdhPjQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94776839D9; Mon, 27 Apr 2026 11:03:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B5A8419E
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso83106735e9.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280614; x=1777885414;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c04I1Fg1PyTrVYWFdT0PFo7EWBMxSI5HknzkCFeliek=;
 b=wSdhPjQEVj3dR+sYlJQGU4VXpdiRvzeGvqLAa06ovyl93F6/d2Qg1vdPtSWEzbZLrm
 PAWxM+wVUz6PMWk6WvyOd8+REMnXjqQHByz8v1sXdgqc207z2r4YPMJNZnoiYJdhgkxr
 gDNopX+s4GSPyVA5x3S5G/xKGXHrEtvcUDPbZCvkRhFBBV/2hS0qbomld9JIq+lvt5SE
 CNjPX3JVXMw9pCcvY55Rv9cKFj2Qbj8zziL+O7DdVqiJzYtYYtEy7Tkhv+wHOUhaCmbQ
 blvsT6CSfc19XNxJb+MvfmM10F72551BPbyAo34ccszKHg+y1Zg7A9I7sXLSVSS38Vul
 qN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280614; x=1777885414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c04I1Fg1PyTrVYWFdT0PFo7EWBMxSI5HknzkCFeliek=;
 b=PgP4yNDEy+E64nTEIDCNxN7F2ajoqtGsLHWgr9Wi8yKSlXKvnflcaCBo48FCczw2XE
 hBu71O5a7KuD9sEWRUnobQsmCJ7xHLFunfvDl0UvLszo1y4f4B7YvtDmCkvDB2fzRR6z
 kSPDKoEtorTrWKFYKV9Bh35UHTLPi1i6jxfFd5RB6nqBFUBgZUPG0IA/GbOvhT3oLvh1
 WLlOM3wBmCgl5V0fqoJ1+o300yQiw1SMZUwAlHB9sO0ALJURwVQJr+IWrMkXr7F/E6o5
 Zyk6mS/qVwNVTydzPPCg28V1A8MEzy4zNH69BgBfRJPOQSgs/uu3dHrudB16MZK0rTW8
 XNCA==
X-Gm-Message-State: AOJu0YxMrfKqUnb9e/G96jUKOcRcSRxv39RT2P7uDxNdie26t+0JROlH
 umsWWtSH5hbCIJDzkNIgiRMZSYUPAX4l/8C6iFrYKmbNbrYBdLwgFAdDAVs0EfG0Nuo=
X-Gm-Gg: AeBDietQBDkO4kWQK+MSJB9CHIMFIIpb9QYj7t/0CPZB9Y5mhRX/fB2VQt00IqyRkSl
 IBPGzwXoKxgbK3BITRNOlsavEqR3Ewv/Cslp4F3JLCJfG7sfKyFQ+5puJgcrFjnfMzFwMqQCXZ6
 JJTQBZLsl4CPRHR6JQ5+kETtg7XyqYRW1TM7EMklZMkTK3u5o4zScVnf+ZysHEk4wF6Di7G0kQe
 vmAEicat6yiLRgmkyEH0RMo1WB90gvVa/ZP+2PJdPIwGTA+/L0XLB0NLv6AuXnK/XOtjkurxOQq
 b2Xe/gLKLWhmTNeCi2efZGeVCpid7jF2qaypOF+thyPpQ5dbHidsCud3FbwsFkDx15icwMGf1H7
 mkCFkVE2rfjkhkgfDBNr71n9mL106Nf3CAkoFzuHCJe8W+6HxUQDcEbntyLRH7qFYHXVRLsDPdv
 Ij1wXWhbyyEkTdsbMtn7J5iVxqHoN7agc=
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-488fb6e8eb5mr578464975e9.0.1777280613578; 
 Mon, 27 Apr 2026 02:03:33 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm783372645e9.5.2026.04.27.02.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:33 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:30 +0200
Subject: [PATCH v7 14/14] dm: core: Remove dependency on CLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-14-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QZ0NsvYTmr9oME3Ajq1bYtC27QyLWWm+Lxbnh29yP7M=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3an4Z7jdN/txf7y7IqiT1Tio3+D1X+R/uS0Je4f2Tk
 mL2SjR1lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwER+vWf4KzXlZHpFoMBeuaQr
 0zm7/qknT5pa+OO+6oL0yRPzFk7fpMvIsN719ptwLW3HueK7rqh2Cdq+4ryoI3e54Hpv7H7P+n3
 /+AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

CLK is an optional dependency of simple-pm-bus. Remove the dependency.

Fixes: 447bd8f1e5cf ("simple-pm-bus: Make clocks optional")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index cbefb522e5804fe8f1b674f5db03396b22c45f3a..ae0c346677230900c0bda4d24791c67f6342042f 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -337,7 +337,7 @@ config SIMPLE_BUS_CORRECT_RANGE
 
 config SIMPLE_PM_BUS
 	bool "Support simple-pm-bus driver"
-	depends on DM && OF_CONTROL && CLK && POWER_DOMAIN
+	depends on DM && OF_CONTROL && POWER_DOMAIN
 	help
 	  Supports the 'simple-pm-bus' driver, which is used for busses that
 	  have power domains and/or clocks which need to be enabled before use.

-- 
2.53.0

