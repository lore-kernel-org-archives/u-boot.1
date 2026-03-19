Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568331091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AB38405A;
	Fri, 20 Mar 2026 00:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AYcHotYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0912683FC5; Thu, 19 Mar 2026 21:57:06 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE2E83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso872211f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953822; x=1774558622; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CQ+gm0zG3GJxN3n1mzflNTKMTeIaXJtAS2Va848P6kE=;
 b=AYcHotYNEodRO1jEdpDpAjWNGRrh0oBmcFEFgMwHBEBVVVUQJ+VJgsC+LRDGOw6NkU
 5ydGFxtgk+7vFIEtfNW/HsfNPx4bBOhaufs4UunK0znEZxWbZzrnx+Q0oE0qm0Xdtwp9
 jcT7w1MwVzuw9WisKNqD+ZxAPSHhESMDQkkuPAYXc2/YAsl32CM8RieYq2KNeDseOsB6
 OtmvA3OkDot1yPJ76wcf14MVwv3uigQOvTF6OmxqisgAGmoksvsQKyDLxHzmURN7whwk
 TfLx8Vkq/Gl+jN91uspRC/OyLiAD9yj7wPPKH4iYr6NWMP3eb0um5vfCeYL9+Xz50Ykn
 6mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953822; x=1774558622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CQ+gm0zG3GJxN3n1mzflNTKMTeIaXJtAS2Va848P6kE=;
 b=c2+Z77n5M1iWxMahDQDBMqRGciaZeem7AVDnZWXAku76iEh+iehsx7xp0LZdailcbP
 BrpiaY7KARjO15lAQr2F/P2rsetA4FH4KWwygmjtzG6FaNpwi0gZn+DKhcOdiN2Ib4bl
 caFB0Em/T/8qCjma/L0Nv7ehdLjGs4kgCjF4ibFTajGKcX2VT5vU2TO2mShb9sS/zcU7
 cyxg3XmzQVsE3shd+ph1s610MYsF5rNOClERb91z84UAB1nTL3yOxBa3YqZIubnhVVpt
 taZwDaxnWOd7TeKEaVRCbOml8Vsnv2M1hLNwU96r0EZ0jt1IRFnZPxZenVx3OZ0UwPgR
 GB9Q==
X-Gm-Message-State: AOJu0Yz08kZswzgPe8jDfmm+gHDU7eGzG0o1KokLlJsXnQA4AIvpI89e
 6DIcGKpdJWJ6g5poulaqURdjEkxJF6eWfpDIpJfQ+Tw0VA/ngUKhKc1nQfUxl5ZKCwU=
X-Gm-Gg: ATEYQzzwNnfMwiIQEhbEYtq+Y17HlEepSgOuI9X+qfwQHBXIK9NiypIs98a97jktt5h
 c3WGwzK504FNsyB/pZsEDfBNNGkfmdtUf6b0tvzBi8prXGoIc693k28wvseXGYIodwekvnI1Fmp
 2R2m5ZuDYfjViQcnlb6OEtkZip9dVqG2Uc490ggQXAeSTnXN/1dGG0iGv1cJr9O7C6fxCt1+/9o
 aKRaQWfrqu3i9JhtFiwQs5EHZETFaOecVx4q6Vn84CqQRXj6oPbKOjfJ1BRPPufKvpBgMZbsvi7
 ncz5xlU37Z100glFB/X/mReKuT/drBlzBYjBT0JCHdYoDB//KEVf/sM2y+F57pzWxCzp6WAs8+b
 tChO61rN8CW8vQB1dQCtWecCxi9tngCqzg2d+XL5RuwKE/Qogd49sPLaxQsU++XlyEnxRJVg1/H
 f3bAwU5MDGyIiLsOiGZ5EixR8voaRcO8HxsjKNCnoWvaHmOZIjwf3O4DePmJDeVSSA15o=
X-Received: by 2002:a05:6000:24c7:b0:439:c799:dbfa with SMTP id
 ffacd0b85a97d-43b6423fb14mr1251715f8f.9.1773953821872; 
 Thu, 19 Mar 2026 13:57:01 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:01 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:24 +0100
Subject: [PATCH RFC 02/40] common: add an option to skip DM pre-relocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-2-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=BTSZ88kTLdi5mw8IXVoDVatMv6+okA8GUUaE3nA3lEw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybwBE+oufnqmZext/b77+xpekfdysrzTr4Qt8Ofae
 +PE7fScjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR99MY/vBeUv/Iv2ORsy2j
 rzjHXHcZ3z6jg1+LTH78mzy9kF/yZBLD/6LM9oU7l3PdD755erX6csmn559+t3/f+kaXQfuwH0u
 m7k4A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

For some platforms like Qualcomm, it isn't necessary to perform a full
DM init and scan prior to relocation, it's also particularly slow since
it runs with dcache disabled and prior to building the livetree.

The only device which needs to be probed pre-reloc is the serial
port (otherwise U-Boot will panic), however this can be found through
/chosen/stdout-path.

Therefore we can avoid scanning the entire FDT and binding devices,
instead just binding the serial port and clock driver on-demand.

This decreases the total time from power on to reaching the interactive
U-Boot shell be about 50% (from ~2.8s to 1.8s).

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Kconfig          | 12 ++++++++++++
 common/board_f.c | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60f..2f7677f47f16 100644
--- a/Kconfig
+++ b/Kconfig
@@ -473,8 +473,20 @@ config SKIP_RELOCATE
 	help
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config SKIP_EARLY_DM
+	bool "Skips initialising device model pre-relocation"
+	help
+	  Enable this option to skip scanning and probing devices prior to
+	  U-Boot relocation (during board_f). Unless console support is disabled
+	  a serial port is still required, however this can be found through
+	  /chosen/stdout-path in FDT. If the serial port relies on other devices
+	  like clocks these will also be bound and probed on demand.
+
+	  This can speed up time to interactive console by about 50%, particularly
+	  when combined with OF_LIVE.
+
 endif # EXPERT
 
 config PHYS_64BIT
 	bool "64bit physical address support"
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899bf..2713438cc18f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -813,9 +813,18 @@ static int initf_dm(void)
 	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
 		return 0;
 
 	bootstage_start(BOOTSTAGE_ID_ACCUM_DM_F, "dm_f");
-	ret = dm_init_and_scan(true);
+
+	/*
+	 * If SKIP_EARLY_DM is set then we just create an empty device
+	 * model, the serial port will still be bound later through
+	 * serial_find_console_or_panic() via /chosen/stdout-path
+	 */
+	if (!CONFIG_IS_ENABLED(SKIP_EARLY_DM))
+		ret = dm_init_and_scan(true);
+	else
+		ret = dm_init(false);
 	if (ret)
 		return ret;
 
 	ret = dm_autoprobe();

-- 
2.51.0

