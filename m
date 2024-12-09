Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8CCE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D058972B;
	Mon,  9 Dec 2024 19:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hK+vxmbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA2D89780; Mon,  9 Dec 2024 19:20:19 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1994989752
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so8348685ab.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768415; x=1734373215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgAsOfRBaQ+cSQKHcchLTixmvl65HMw2ydL2lm3XbVo=;
 b=hK+vxmbSpKeLcTz58QK2nDVBIDJyJcG3go+dNGf0B9YJpzqS7PbkzKfw61qVcnHdvL
 8b5mFOkaz1+1Ceb7DH2++CrfeuHb1N1iQ72rI4TlemcUeZWoe1IcivCjUqQp7nph1Q2H
 gBg3mbdIgVz4SRU5vlp8sNSyjwMjqQ+7M3pe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768415; x=1734373215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgAsOfRBaQ+cSQKHcchLTixmvl65HMw2ydL2lm3XbVo=;
 b=CK2oXFzet+67BWl7bI5a3HjEJeXwZ+lLmgdM45Kn2LoOTQGsXHOaoB5ihQJm/QMImo
 Klv9t2/83Te6O+PIKimGdjyF7J/YHVAxVoyajiP0kwJP2tDeTXAwridwBI9LQIMp9hDG
 aGdvlV47HUugcvm1wTAHBEBkFf5WKsxLuH5/0YEOaIbv4L2e1CFHLCDFQo83EXV55rWI
 /oaBLBiqkwmJOdLIJSHWemAqMGyxqW5qpLG85efTyIRMwl90zxQ3wiAc9Lf9DMZuQzXq
 FRZ4C79WPPwCugp9DqJGpSxro5FBvuXwEm7QGi2hCuK6rrzvq2e1ma0dym/9KRIbPN6z
 TbsQ==
X-Gm-Message-State: AOJu0YzPhj1pi5o4DeFd8BtrIRUmrNkp31n+162r0C7ggeCVT5+m9HC/
 iTkhUvSuoskgQ34KabIpZVYmatCFn3Az9arEzdo4q3YUKVkIw2aXNkWdh8LU++dkAo29VIJusQk
 =
X-Gm-Gg: ASbGncsaplop4xW0WJpwS07O0DAB2VqB6/8kJEDXXMe2aBwhOjoVuerSLvG4cFQccn1
 81/srxAFu3sQDXpQqWn+563wzUf1KMhsH/wuihwJibN5veS4fHXgcF9mLDegAT29E6gHrjNDSQw
 QFDv5dpIXpbrpbhbtkbY4s5vwUT1TVmj8qtmtsd6KFld40LDIZMrXbkiVamUJ9eu9e5NBQLqPgG
 YS4LjaRQobyCSgVlkFcemtsBf3rYrat7CyRML5fLwDY/Ez9zy7D3eaOFlpY8MqCPI+5jl3me1AI
 0GrnRPfSVNI=
X-Google-Smtp-Source: AGHT+IFtDSoqXjieqSFqY7I/3nyV3mAh1CY6xsFn+n4EwlrwwPixnOUgUkWJcqv/Hfd5HmIhBkK5Ng==
X-Received: by 2002:a05:6e02:138c:b0:3a7:dec1:de55 with SMTP id
 e9e14a558f8ab-3a9dbb27764mr11941075ab.22.1733768415108; 
 Mon, 09 Dec 2024 10:20:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 3/5] rpi: Drop fdt_high and initrd_high
Date: Mon,  9 Dec 2024 11:19:59 -0700
Message-Id: <20241209182002.671953-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
References: <20241209182002.671953-1-sjg@chromium.org>
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

These are not needed now since there is a bootm_size setting to keep
things within the lower part of memory.

Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add new patch to drop fdt_high and initrd_high

 board/raspberrypi/rpi/rpi.env | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index a58ef38b1aa..b79730a3e26 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -68,13 +68,6 @@ dfu_alt_info+=zImage fat 0 1
  */
 bootm_size=0x20000000
 
-#ifdef CONFIG_ARM64
-fdt_high=ffffffffffffffff
-initrd_high=ffffffffffffffff
-#else
-fdt_high=ffffffff
-initrd_high=ffffffff
-#endif
 kernel_addr_r=0x00080000
 scriptaddr=0x02400000
 pxefile_addr_r=0x02500000
-- 
2.34.1

