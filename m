Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD065C27C43
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3ADD885A4;
	Wed, 29 May 2024 00:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjYos8Z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDCC884DB; Tue, 28 May 2024 19:05:26 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5C48844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ff6fe215c6so887452b3a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915922; x=1717520722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEAkXnUOl142oBO+AOfsmgnAictfH8kzAqOl7TUVPGQ=;
 b=kjYos8Z9uah98rtkJBylcGMplwvqFjaBx1t90d3+z63CE5gchZaFrIpmyT0Y7ex/9X
 4h2V9RSaol0cnUo47/88RXNDUmLy9lgg8gWpajmMBGp8lRfEe6FGoykad6Xkyuamvn+q
 YCHUICwLOXvp0KnhdBqjy0VG0O/I08zye/B+xbT/El1EWhpcGueNliyncFWqQ66jDJ3L
 gco6ktBgR9xbwv5GXLNOn5clDbXO8UcIf8+74S0L1fkn7qvc5nVb96F7f94qp1MkwW0v
 blC/y3Vzq5rmgBP89MZvtfyt13VYXIwvT32jzpHqGivazhrOxEua/76yVTnsuSN8UmCP
 K3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915922; x=1717520722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEAkXnUOl142oBO+AOfsmgnAictfH8kzAqOl7TUVPGQ=;
 b=UzFO2OGNZTw4pjajJieq4bg7pAUJlIlNsVQtFl9PvtiIwr68NdNTu6nM5F/semmWwK
 Tp71KU97lT3xpv+p+0GWqonU0WGwUJLgqP7qgZPZJ4sh5QhwHF9ZV5ERb1I0x5oi+5pZ
 jyz7plpHOFs+nZDbvesQ30f6aVkj3GNtl/xMLOZjFM3FJLqZSNirZcySj4l9cUq307Gv
 cw0CK9D++yQPrkloIVcc4Nf4Pf8fSPeKZ3/7We4Bc2p9C50nA8syOAd2V171L8yJGFH1
 BpqbCg8KYCUaawSQSZ2oXHc0HEqz90O2wGB9MN2Tu4QBmH4ZDIZ8weAt6cy3oQC8oT7N
 2FEg==
X-Gm-Message-State: AOJu0Yzav1EHQqYpWWD7ZXqGRtpo5uhUh8nY7Xv4D7836ZrpKbSZ+wuU
 rDTt+J2w2MC3cVxw/jnWqxh7GJDGWato8j2mq6xRFO9p9TIeoqx+kbgP5HmiLtBYMg==
X-Google-Smtp-Source: AGHT+IFkhzlUTTsZfxBLknAESZqauJBI39BPHru3xyge/i19katqncKrTtDY0rFBA2H/rk4SR0KLDA==
X-Received: by 2002:a17:902:d490:b0:1f4:a057:f90b with SMTP id
 d9443c01a7336-1f4a05801b3mr65468595ad.16.1716915921867; 
 Tue, 28 May 2024 10:05:21 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:21 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/10] arm64: dts: rockchip: fix usb2phy nodename for rk3588
Date: Wed, 29 May 2024 01:03:59 +0800
Message-Id: <20240528170406.353616-4-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

