Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E132CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C817D84825;
	Thu, 28 May 2026 19:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dv9dVzqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBDD846A5; Thu, 28 May 2026 19:11:11 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3958846F4
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e62b6163c8so1772179a34.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988268; x=1780593068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JywXSQ6i/nQr08DhdEgIj4NSVtAa5oFtVWWh1USf05Y=;
 b=Dv9dVzqP+Or2ZvJXj22gWU5DEwYsat4xPHL3bdBjRlctG7/uAt5nZ4puirZDDzl0Ot
 F6GJ2Zdhs0TGFrF/SXgvZ95zoFHN/rGTiohnYtKYgXXrgP046CN8W0t6KwrYw7ei72eI
 Jnj2Nvjc8NIN36/nNaeyr9dWldEOD4TkwTBOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988268; x=1780593068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JywXSQ6i/nQr08DhdEgIj4NSVtAa5oFtVWWh1USf05Y=;
 b=m0vPqmAJb1E7X1Bl4V4E2QGHue3bXfCCFcK7daIeKS1R+IKQw1OXPC83aEeEha01GP
 F5yz7XXQKoeqqqywWEO8tUmTMOD8FYZJCxDoLx9TbJBO9sGR2jRF261nDWOcsoon0Yi2
 +ZJG8yGyhg/dhQFks9bvR9LDycDvEf3y4+yAutoWpOi6JhLwgANsdPJmCxGwQTJUXvs4
 Qt9gLer2DzAmmlhp3CxiVsmZbpNug2vgNnmcoi9X2KN7zxM6puHmOs4DU2/sY6+KZn3R
 NSboAm4TGXpHiPS8/c/5OiAsMABAJWceW6JfiJG6KoGPg0alEtcbpBR2Pp1CD7O1kBJe
 p38Q==
X-Gm-Message-State: AOJu0YyT/GWpe9E7KLHbpJo+R4VwCcPWS/imtCOQJXDF77TgKybLQMzb
 OUzyP88DxEFb62sF6SjeakOslvdLGj/NCMilOE3aYEBNCjf2/KUWX5cMO1PBMosuoYs8OyCv1zq
 wWvsiq3CBOhY=
X-Gm-Gg: Acq92OEpAKt+IFgi4T3Ipw9rS536d3Av9TQL56RwjgZE1zXzW3PlkjNpeUdYIf9Lu+i
 aHNiUdYxYzcWSU40eNUBZnEIotGrQCQ9kRaM+aWDbsy/Dj4MbIzfJjQ6xIjYJ1OJAzgxwaMl+wK
 leMH9vOGpJJ25X8aIfL4XwyIIHcIq2LSCDBck0NKJlH9IhScI11HaLSdc6ozxme9yqqSUSDVSEF
 DttKnBGWS/rrPW80H9QZ6hMm5a7ks79a4jIPu4YyH14V+oTrgZHgdJo5FMS3PE/LAlZNeB9ATwx
 h+9PKQnScG+c5CHVlbAOf6D/hCN858NOS7j2ejXdiX5faexQF0mmuF329SUWfjeXruxZ81bi8al
 Xu/CmXg3thTotHUzR1V+O394QPTUbSBPdLVyAVWP5XLcSvCQsvh6vqiBYZSv5NAm7LlN1SOUsLr
 GBpbqGFIoiumf3Q6sAUPtkcdVa4d0N
X-Received: by 2002:a05:6830:82bd:b0:7e5:f941:61c1 with SMTP id
 46e09a7af769-7e5fef85544mr17918547a34.22.1779988267626; 
 Thu, 28 May 2026 10:11:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 06/22] rockchip: dts: Specify the phase in the image
Date: Thu, 28 May 2026 11:10:13 -0600
Message-ID: <20260528171043.910264-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index ca2003fe5c0..f4c6a14fefd 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -64,6 +64,7 @@
 				compression = FIT_UBOOT_COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = FIT_UBOOT_COMP;
 				};
@@ -82,6 +83,7 @@
 				arch = FIT_ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -101,6 +103,7 @@
 				arch = FIT_ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -123,6 +126,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.43.0

