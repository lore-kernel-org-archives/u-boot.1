Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91193C44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3681A84A67;
	Tue,  7 Jul 2026 17:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1uqlIn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C9884ACA; Tue,  7 Jul 2026 17:32:41 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485C084A4A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-497deab2d66so566024b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438356; x=1784043156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdbEC9LFjF+1xHiUmY+dV70gFM4KLE0JJkoECtmO2A4=;
 b=P1uqlIn8eOmRRGdLiyZmBCTOU0OrsvG50iBD4JItDj87ZvmL/62JrbI4szIBrqp2bM
 Tw3kXLfv3po9/FeszEski3noaKZOKgswIVcXkFbL4Y5YWSNTo78D/Pi5oBnQ0jYbMh79
 75uefxBVOa4H1Xv4tCUCZQGZZ9f42OcwYsUZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438356; x=1784043156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZdbEC9LFjF+1xHiUmY+dV70gFM4KLE0JJkoECtmO2A4=;
 b=BAWbbT3kYYEOm/bRnAejIgPnLL1wB7ud/N+Zczc5M2V7MJmuw7aWIDTyRnJ5YWFGSX
 IWyuwSH2y8Jrnli1OekVdPyXsk9Eg2EAhaX+06DaH1rVtAeBr5X6ahzKys+5tuHcEWsx
 nb9yOTEMTp7hjWGA0jtWZZe+T0GBqj3t5Z2shCeE9YDpBHJUunLrGsBpf9sE36Sr5vH+
 IdYLnJryJofusS733cdYZ1sGcRzuTKcTv8ukw7CqVQp6bRGun5eb6wUFltmMWud/a7/a
 +3/ddGXFaIyQNnpHuOFPRAWs3F0IkAPrZJvkMw7KVaTcO96I1VblCbQGRA2juvgQGxJp
 XIxQ==
X-Gm-Message-State: AOJu0YxqEnVPuFtoX430BWaebeUFAxXFj2EfPeglsbxtE4SF2Ht4bpoz
 TTla2DaxRtWpw1DPXVxa2xW6TLAHPMXvBAZ2g/E8r3ytpInfkD46rcQ3ilpxfW2hCfWcKEYKcLH
 eM/pYHA==
X-Gm-Gg: AfdE7cl8gFCasgblCn9Eq/SORFChK5x2EHRnSyTzA2yBm5fcjPMInl8872zpxOog9Sc
 L6S+b/MVWcYUa/IWHL0Rgrx5NPBhhYjIu3QSBmu2Yr4/hhU6MOa5n+F75Oz21aZAsWjvV5IMYJb
 P3PEyJj5oPnFRmaDpt8cHj3ToOr1xdHy/spTnCInPdW6nQ6CaMnWmj/eNA2npSHsFJ/IRJ98OoG
 syOkQBxrXsu4zkJULdo2sO3a2F8WFqhsFRjmBAXv/R/iSPlGN4ahXApk5vBELRLHJA1Vdj4mfR4
 s97YLseR3oWCj9fnSGwYm+OSnpVoW1rs1MwQY6sFEPible6nsjdRE3jwA/G2bfTR6ut7JezyytX
 070hdj6gcdHCmrFIVXZvLbYGnyIh8cULMwpCiYzGxLWPzq3PDWekiI2gsnTZnYClXggabHNtXOp
 UQDqHEGAQ=
X-Received: by 2002:a05:6808:6884:b0:49e:d43f:1b94 with SMTP id
 5614622812f47-4a0740bde81mr1480121b6e.0.1783438355968; 
 Tue, 07 Jul 2026 08:32:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/15] tools: rkcommon: Add RV1103B support
Date: Tue,  7 Jul 2026 09:31:02 -0600
Message-ID: <20260707153135.2048115-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

From: Xuhui Lin <xuhui.lin@rock-chips.com>

Allow rkcommon to generate an image for the RV1103B.

Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index b39777fc060..6f25a1cda31 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -153,6 +153,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rv1103b", "110E", 0x40000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 };
-- 
2.43.0

