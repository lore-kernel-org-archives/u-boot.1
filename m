Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26920C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA5E883A8;
	Mon, 27 May 2024 23:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GbF6APBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD6A87EAC; Mon, 27 May 2024 19:02:53 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8BF87D1A
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f480624d0fso23625ad.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829369; x=1717434169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEAkXnUOl142oBO+AOfsmgnAictfH8kzAqOl7TUVPGQ=;
 b=GbF6APBpyA8h7LmHCBB35lJ3lC07/aPCyx5Nhy0ImZWXLCOABNmw8MfiKS6IqGSx3f
 Xu/osBxCuY8Em2TfQwM9g6qq1qubL/lgyKY/GFKHLSAsmkoJ5hRFCvYBfr/L45bQTC5H
 mx/gl8MA8nYqQggZN0fSZ1MGTlFAfVFjDQ3Ex+jPqhMoaP/oVNfpyVQ134utrXmXO1vi
 dtsvJphuWCFUTx+hO2mlVLzqPwqOGyIDDfTP+HCDIjk35xzIjq00uVIkD+wpx3FQ7++S
 3v3tIZWr1xXm/6iO/Tj9u33MpZEBdHo4UtsEa1iVHLvp6wwfkplwDTu9LgdvfZjlzthH
 tu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829369; x=1717434169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEAkXnUOl142oBO+AOfsmgnAictfH8kzAqOl7TUVPGQ=;
 b=hLuLZVy2tL08PoYW6kWqyTCuMlJNYgldZXfhf00r4w/aYsnKb/a9do0yLdcDaUy/GS
 zua/c97zsXRagiEhRHZP3z5+lWYkgilaV+XvKOM6mnuZs7QqU47LVdJTH+gMERqY6JVq
 bYnZvb/l8vSrOcHjVvTXgt6wD24L2/4yudOHpLkY7IVIjmEaOxLo57ZS08SJUo4KlsMm
 20GD6hwOCH7HXYfW63oNL4yfUD5GhUZsm5dsR+YiGYX5qxh+SyG4Apl+wSDzoZlivx9X
 2AlkvrpPewYaB3Q4SWxPjqrCT+I22G+n9TQGHOIMmz28IgC7jVBY2rUp3W4/L4Lwnb/o
 wu6g==
X-Gm-Message-State: AOJu0YwkFxWkhLGLVmCddHyRvxBKbob13TSVSlaIeQxN0fVkrlyCIFt4
 EoRY9p8p1QIk0tVdWQOaEnfrE3Dz/KWF2ObOr6xplhepcN6dh65uLh7ma+MackM=
X-Google-Smtp-Source: AGHT+IGLhQgvy2qnTRMZBWb71+/bCv0aPTV7dcgqcgpHJI74nDFEJeSTxoFBikWjnbFB+zGXlePOyA==
X-Received: by 2002:a17:902:e54e:b0:1f4:ac10:3ee3 with SMTP id
 d9443c01a7336-1f4ac10802amr21276885ad.20.1716829368679; 
 Mon, 27 May 2024 10:02:48 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:02:48 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/7] arm64: dts: rockchip: fix usb2phy nodename for rk3588
Date: Tue, 28 May 2024 01:02:10 +0800
Message-Id: <20240527170214.283988-4-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

usb2-phy should be named usb2phy according to the DT binding,
so let's fix it up accordingly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240408225109.128953-5-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 4e07a95f7402de092cd71b2cb96c69f85c98f251 ]

(cherry picked from commit 5a3e4638492497ae81b9bd4a8627f4727e312ccc)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index ac5bd630f15..87df0902273 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -599,7 +599,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy2: usb2-phy@8000 {
+		u2phy2: usb2phy@8000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0x8000 0x10>;
 			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -624,7 +624,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy3: usb2-phy@c000 {
+		u2phy3: usb2phy@c000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0xc000 0x10>;
 			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.34.1

