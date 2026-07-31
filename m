Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19CAC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E143810C2;
	Fri, 31 Jul 2026 16:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBt_FSNdMlex; Fri, 31 Jul 2026 16:36:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C280A80FFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515767;
	bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ro+zceyjS+Q+XNOIFWjl/HUCetvpNyb4Wl/VLmdB8++bPh+JtgyUBZgvT1dB4FRjg
	 97iY3Zyl6KsdmVnbbhIfF0yL0USstQsgyDpveljwuO2v/cRahOpbYBJ51GNyb/fyg9
	 LIcYD5AcHacUset4Qv8h5loVjmZDsDZpZwR/qajVpUQR4KYXkTso5BqFlAk9kerrvn
	 5Nzj+iewjZCGir1XxqSKNa510GfZecegS//WIoehEDjlaqB+gWB65TQtJenC1j42l+
	 6duciHbZYr6qP7aOu3XF8158EPoiX0m4buja+dyoyz3FTHpdfiJirLiwkLWr9FBKU1
	 nCsnFxSGrwCNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C280A80FFD;
	Fri, 31 Jul 2026 16:36:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9D5D69
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC3F160658
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0NVzeXuxW65 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2c; helo=mail-vs1-xe2c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 902CB60657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 902CB60657
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 902CB60657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:22 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-74d55dac06eso640168137.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515661; x=1786120461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
 b=dnry0bMC+JmJTcNZ4sGbojA7DvfBnDVzzWK52971hcg7jAy2EpAuPpBfYFYSkB/UHg
 aMmoRGSBTiapd2qVmWnau/Z1P7+rsnvdoj44I2KYnm0ccOb2wK/ceBhL/Y6rlW++Rf6s
 og2TlZDSb/MOWuV0sySExQXz6i80eM0E26t+hoC6xfi1zBE0wENLkTgGEeLEd5YS/cST
 Gai1N+f09zun70DjNYFgzhuB67oqUdOwBxkfF1+ShuGTgzwXQniFy47e4OATbn3rbEEY
 XTLtL8evfHEslfVI/fjBWhgKLGXEaEw13kzJ2KNnFaDyzTAAfyytrDZWonjNpSYND2Rs
 YQVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmN+RPpi1w+U5geZxnhq94zuqYxLvdN/2jF5HePxK32L/Iiy6HkNBBGecXm7fW9ew57Phv1G4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzDHunbMjxIlWQPyr5larpbSjk/vbeKqOcpW7I8YrWr9kdYKy2I
 GVIEjNGZVzjK+C5GRqVRp/jI87ojVaXFsdB22PWpTuiet1Xp8mviiCSqJEkHDy2pxww=
X-Gm-Gg: AR+sD10yYMeuUCaRtgvitPO7/FhJ2L3Mg8U0Z1kYCkVZFBzzZZOeiMkv+FoaNvqkH0k
 jgb8vAkT+jvXD8P+IkZxn40xVBI9QQfFAS8SXhECFfBpD5WmHj7XOa3hSqo+LvmYgdtCnEg1lcC
 A4dWKoANNOmmXXvXc90K9KGJ90aRTZyC1PfnTnpaZ0K+jcuBzmH0+I0tVhOv2psmaXvf1K86MnB
 hHU04/vFoV4e9mblAuJnwQ21khkX71o9w+t404fuUO5Q7uS5bNoY5oEXVIRdCfSN/ohq4F+4QMq
 L6efW82Dx/t9NtCuhBA1oj0OpchrsWcvmpHKkdQKXSl8nXyo1b6Ft6Nl5mBHzuGNwfIcHPp4c+B
 27q8lELeUmMBbNDBo6zpS5Hjh+wgILJLbopvnAqyFJARCVNbinR6dZUMDVS9ZHfkCVXt5cWoPZe
 GQQ+t/MYn1z3ncPMaMEQCSOnYZ+5VsuCRds/H6sQggXEFEGw9TeYWxV4QKNpQrZdxq8E0c1fSmw
 51LBIN3/a5bK2nLUnUWEW6EGexx3qAEfB2O1NHXtN9JrLzdiVgSV6HyqI1L
X-Received: by 2002:a05:6102:1496:b0:74a:9ac9:792c with SMTP id
 ada2fe7eead31-75b243758c1mr842831137.12.1785515661231; 
 Fri, 31 Jul 2026 09:34:21 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:20 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:42 -0400
Subject: [PATCH 13/17] ARM: renesas: RZ/N1 QSPI controller features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-13-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=742;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=nucqgOLzzgd5nw7OemCu68jJaNPebxWyN/FlvwHa1C8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAMcAGJE9J8OBxYAOuMuVZPABCbsUEXBHPucUMzojS2+RvzBChVMCNOkjVCAfd0X3JxNpx9FdtV
 EVl2wj7yFHgE=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515661; x=1786120461;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pzeHkXVHU5/KJm79XEWPHbETNwBCY0lmIZt98ASzlPg=;
 b=utxXjWobhQlpbNinrDBijDQfNmkQtDbHkBbe0vceGrFEKeG1RdyxvGm+JH6BG/nRW+
 rEmNxNu9B1n4cxIuD9pLv5KCWrm7pXO1CIeE9v13iYMQwyzAF4WiS+8no3e/pZE7H0Qk
 JHqHCL6gKbGmGYxJi16nqLWKpOvoSWOswIbwM28Lk2cUy9R3n4tq+qLP0++qGRAwBRQn
 YeJfxe4iTiqrJA2kcYfEVOuyfw91Wcnh+Sm/lsZBzHJBmz7x5iSCjZ5ucmDpJ6WVEhK9
 UKv575bW9h80tkSgruxdmgzySIx1wgy8rRSGS49bJicK6k9kQa7vFkGHbjdE2yKJum+h
 xCmA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=utxXjWob
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Renesas RZ/N1 has a QSPI controller which offers memory-mapped
"Direct Access" mode, so enable SPI_DIRMAP for this platform.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 arch/arm/mach-renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index f86acc31039..4d16d541443 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -70,9 +70,13 @@ config RZN1
 	select DM
 	select DM_ETH
 	select DM_SERIAL
+	select DM_SPI
 	select PINCTRL
 	select PINCONF
 	select REGMAP
+	select SPI
+	select SPI_MEM
+	select SPI_DIRMAP
 	select SYSRESET
 	select SYSRESET_SYSCON
 	imply CMD_DM

-- 
2.55.0

