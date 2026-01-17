Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15365D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8F283A83;
	Sun, 18 Jan 2026 14:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHtKhtgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC5F833C6; Sat, 17 Jan 2026 20:07:49 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889B682BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8c6a0702b86so300392085a.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676866; x=1769281666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUKOtBG1A2wvMOd878tp+8nxEhqUveqfaPmHvJEtr8A=;
 b=JHtKhtgWm4tb4PFtC+6iCMo8WO6G89IoO3CVKQaW/1BTARH5LNUK8tyky7sZODolrl
 xbusiSEb18kw5roSs7krJC6DSCLheSCdwnMT5+krIpYHoEp1fdTi1YAIwXvRwnRwxZ7x
 5TW/0yyiB702ldjiViGjX/uKXKzY2A/SAmL24NMoJPRqY/JPx621CYzDY99Ya+kIlw8Y
 iPKo5y5LLTs/zAMTdxb2EkwReUyyl2Qs6qFRkr/K68H7SOCIxIcaOqhTRWttqup+gaSc
 bTJelbSrCPgT24g7xCJB3SnEGSJcQG6s8ldfxMs4DWeHhaZ/TrOxC5GCEkgpZzfcngFl
 bqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676866; x=1769281666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUKOtBG1A2wvMOd878tp+8nxEhqUveqfaPmHvJEtr8A=;
 b=U7F+Bz1ULtUnBDWdJe1CEaDkHG2DUnlSxX8BUVfnYa1S4CjfNnL3BpwgA6jhlvH2CR
 aS1aUFRz9Tt/BnUt//8R8DQOkIPxkIwGO8GQ0xnXxDWxGTV9c0E8CTNKmciHhOTPz28E
 2hRUxLYcIlr5Y4VTh7lET6OU1GHB1kENrclyg1RwI9L7kRzweu4D/WZaLZOxymM2dBhQ
 UXfco8o8AapZofpwpTA7dGx//Lflu4mYvcxPtee9Ko4gYZn+7Fjit94OB4DySrPp7Fmj
 ozqdGsUT3oDRFoeOb7XckRK8uBuB3k9GBhmIEGiIiTtTCf/7GuiuysNv/KiIGsJTJd0F
 711w==
X-Gm-Message-State: AOJu0YyNUoleOlGQhwUVcOBln/HDlCpbr7B8uf31fEGbNfaT7SBNsEoF
 vGWRCg322I9a5dBdr8jvXfxGJvV98O5wzD/5AekB6Tnvw6iepFU2wQYKhzKchQ==
X-Gm-Gg: AY/fxX4qggnH16Ic8JEbRKN41L8lALWPQ5WDuJLgA2nVCHUM6xmoYU5fqPU/rtmc20r
 TlDUx3vAMlrZ/T3xrSmjGZCA1X8tL1JlcY/t46dxJ2SMzfJpC7DCaFnKJ4oYMXjWa02owNZY8kV
 mqNC/jEluYZyqdePTxroGW0zL4Tv/SdmOui5PeXIrUSeXe//bBamnYAyQliBc0sgvSvGcnfxASk
 4O5StLQFEeZEs7bPpRsDg5jg8eulWAQg1lT4EWu5ykIP9NAukheeWcnya06HocFBVBiJrwfVs3b
 ehJBFhDB6h7ILK02NTls+68/q3aWCIR6svo1bNWUVM/9rD7io0wt0Lu4bD4n4V2olU5XvPTW7ti
 +A4LPgaNhl8sNp+FmFeSDPlibTLRWwhTqoeFQQzsGVhqSGjD0vW0nXavRWKAWbmD6YT5hoaiUUa
 j1ewqbW79TPPH1otdEeNPomurvyzD+qG/yEXupWlXzNmiFKjQ0YKFV4MbEPltBpCXx7P8R+dw=
X-Received: by 2002:ac8:5d94:0:b0:4ed:6803:6189 with SMTP id
 d75a77b69052e-502a1758037mr106106131cf.53.1768676866053; 
 Sat, 17 Jan 2026 11:07:46 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:07:45 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 08/17] dts: k1: enable clocks in SPL
Date: Sat, 17 Jan 2026 14:01:42 -0500
Message-Id: <20260117190231.977686-9-raymondmaoca@gmail.com>
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

Enable clock nodes for K1 SoC in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1-spl.dts | 51 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index 6018ea1e452..1f6db740747 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -11,16 +11,63 @@
 / {
 	model = "spacemit k1 spl";
 
+	aliases {
+		console = &uart0;
+		serial0 = &uart0;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 		bootph-all;
 	};
 };
 
+&vctcxo_1m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&osc_32k {
+	status = "okay";
+	bootph-pre-ram;
+};
+
 &soc {
 	bootph-all;
-	serial@d4017000 {
+	system-controller@d4050000 {
 		status = "okay";
-		bootph-all;
+		bootph-pre-ram;
+	};
+	clock-controller@d4090000 {
+		status = "okay";
+		bootph-pre-ram;
+	};
+	system-controller@d4282800 {
+		status = "okay";
+		bootph-pre-ram;
 	};
+	system-controller@d4015000 {
+		clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+			 <&vctcxo_24m>, <&syscon_mpmu CLK_PLL1_31P5>,
+			 <&pll CLK_PLL1_D4>;
+		clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+			      "vctcxo_24m", "pll1_d78_31p5", "pll1_d4";
+		status = "okay";
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	status = "okay";
+	bootph-pre-ram;
 };
-- 
2.25.1

