Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4428C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7261C83AAE;
	Sun, 18 Jan 2026 14:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJX/7Tih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199EB833C6; Sat, 17 Jan 2026 20:09:07 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B4682BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50143fe869fso36559451cf.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676943; x=1769281743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2ljAVLhPcMnrMOdDPrZGdkDyPQjEmCjQcQ2qBqk42c=;
 b=TJX/7TihOvcAEbWWJo770589d3JA4f3TpeCSvN58DyD5e/MQIALctLMj2dOfUPVmv4
 fJSudjueIkLNJlux0/1Dw1uqkjcLdtiyapkLK7SnSlrHl+mEB+gB+Ek/A0u2uVYEYk0H
 6cs0l+5pEdMsEmhF/enw1TUU8mb8lmNdfu1yH1HHz1nS60iCD55Z1ydEB+AMekiLMBnk
 CVNULzP78X/f43Oyf7KgopceYB6FKUPJpVpfnSIL7uxC/ismo13eICWeTc6s92RJYXq/
 8NGf0LdD3haWsUGs7lzri/J+29kekq8nQKfQsUykYn7EQQxLrqTxNOKUI1Zuz9fzsNbZ
 tIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676943; x=1769281743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2ljAVLhPcMnrMOdDPrZGdkDyPQjEmCjQcQ2qBqk42c=;
 b=W4p+2FnPJ3yoC9z7ZVPqZRnBLJlBuY27ztmNMnu9iPhW31IQrZnqMIirNL5bX2abh7
 dzgpHgbb9zgkTZD9BOMqXL18bN7zspDtDRgttLKqAfgJ+DiBIQMFhQcCkzOTWfv7eyhq
 2XZLHESH5pmQt51RZCzrjqbbr5BFGmBV2q6YxJLtRvhrYRBPQrHqjSYRm2mzhgZnUYgw
 JqUHV0F9/LKFL3+NABWGRjAxIoUZObKNmXHyMaU91qHMeCpQ+hUU9JljcFg9ycfdb3YV
 H9UBBhf2WsYgvy0udgOfs3iK2ooJGPF8XXn57QwXUetqCYC5zPF9yQdG9xgQ++sU2+1E
 hnPg==
X-Gm-Message-State: AOJu0YwJJ+3a7SM7Tgt6Mxhk1xMw6qMqkXNrQze4EWBlw/TNO9Txy6RT
 yhHcI7I0il7rrfMQMCqG1Dw1p6y5D8V4+bHvqps/+LQlW+ZDLL0khlPc+z6MOg==
X-Gm-Gg: AY/fxX5ZVezcd5mFWp6RpWUpCvZEMsw1GdBoNf0TKq1F9mVJhJEsoVUuGrCJYXqqOv9
 0HK1b99wVDJp19RDqrCcdEu+6Xd4d2B+faS7c346S7QEyJQPLwVuPnCAJgWa6hrN4pcDz7v3puH
 lEjGUxoehqrd7eK5iX9HXdGzltsKXpiietO1A21PuYolAAcjg+h5tMjOWsUwd/EkrlYziVRhS3H
 VXRK9N/Ec10r6XsENrKRZWjIkBSyxSq5eLC34U5tt2PsAPi6SJR/3ocMtKQ4IjlVeTPKzbbpZSC
 gpai5sAvbc0Iwew9Pct9o5RlL5OpB/K2e8lpKiULzDgeYNsHDIMw/6Q1lN3/IB8zWddD6iD4f6l
 T8/Z0MmCdTwrSlz7GSvGrNIHkMEsy7+ir5kSHcxKu+KWewOJC6odHLMv6b+NyFwkoWH38r2yd6e
 ATTaILFDKzbVhuRmkMPanWo+SW4BvOlQVmmevDWZjsRKSV2zt/1qZnEhRG60hcFPt0JTVG95M=
X-Received: by 2002:ac8:5804:0:b0:4f4:f834:44ed with SMTP id
 d75a77b69052e-502a16f5d54mr98029311cf.64.1768676943350; 
 Sat, 17 Jan 2026 11:09:03 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:09:03 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 10/17] configs: k1: add default option for clock driver in SPL
Date: Sat, 17 Jan 2026 14:01:44 -0500
Message-Id: <20260117190231.977686-11-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add default option for enabling clock driver in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 configs/k1_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/k1_defconfig b/configs/k1_defconfig
index ca9c1d0bd8d..9c4612bcd84 100644
--- a/configs/k1_defconfig
+++ b/configs/k1_defconfig
@@ -44,3 +44,11 @@ CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 # CONFIG_DEBUG_SBI_CONSOLE is not set
 CONFIG_TIMER_EARLY=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_CLK=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_SPL_CLK=y
+CONFIG_SYS_MALLOC_F_LEN=0x5000
-- 
2.25.1

