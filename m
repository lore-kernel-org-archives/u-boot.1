Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135D51091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728138400F;
	Fri, 20 Mar 2026 00:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lN2hgERD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E1883FDE; Thu, 19 Mar 2026 21:57:01 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0752A80517
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso852048f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953818; x=1774558618; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
 b=lN2hgERDYVimqsIv8XyvMjztL9f/iJraxO7/l97ZlQh17wuZGpRtXdxPhJVGrlvW/i
 A92/X5KnnrwxGssmnu5joOVj3i7DumAOO9BO3cO8C/4zoB5c6FxSTIZ/E25ol8JX3uSM
 6MaWkpNTIdpyooW0jiWjHF8gdIDnO3+wCgqjRRZpB60pYeWHfEVnvE40/b/9zPDc8rUT
 Xq33T1cekbXnoN4UNDy1hFE/UqjktC/SrfSQbOOdVUC2ui7hLtcgw0inhnDU7NGTeusi
 7nVFpEbSMcg/hbf3BMWb6ufIQtM17qBXGQN3yGWLJBC4ErEvgFmw2+4TYo91KXQMMiNZ
 pkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953818; x=1774558618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ySESJfourxrh2m62qey3M/YF6AEV8fxCE1YjUIBwGs=;
 b=IU3G2tn0v/fm3wD44DzyIjUVrxv7HehoKDXG5SofNowmEh4MivDx7zc1Gz6WMG6Y/R
 mh0JubYLoWV3JlVtWkYIeeofsHNedOvmPuHOV0lgzKheYnGMpQ+5r+vmqsGeLznte09O
 lKJHAkoqNJsvB4NWZyVtC25tJcnefmOGSb7YNaZvfvaSULjooFNMDTp5I9EjNhlCa9uq
 M2h5742JBPikVUXeYYOfmoQUDp6I4y6gKZUS3F2pr3IqwhQ0PSXNIpGN+ktT2Ap3lLdy
 QHNF/1tG2ksZ33Wrp8x+rZK+TBtpqMH7stPb7rQ0Wjk24CRHwSwWaSe0KEz/RsD8Bv/5
 kfDw==
X-Gm-Message-State: AOJu0YwDyM7o6JR6e7/p3/3atFPb3AKor/nWALC+mswwC6LwNLinPNGq
 b9r80I5Hqiy9cWmiyGZXQItRzcvd91PCf35yoyOdd6qy43eJ8HgvA0K/+6kEDhqppnw=
X-Gm-Gg: ATEYQzxPEWhE1Vh+9byWrqpwYldtTQDvPfMt6PVBpZ9jAIYouOzKHg99uSeDFBDaBtu
 xaIqkxhJlyDl7Mw6h7CKuu8ctQVr18MUZvnpd0psY5Eadau+u9LjLt0fKfUQgg7xHM4nFOG5eaI
 Kxsb0wN6viHrZjDKDi280C2a7KrOd1FKVVHmLtd/ZXKurcXruomr6Mn8CKKlcwWoQoXDBHUKsaV
 WZW97vIjBWuzUQSY0HuOfUnqwDvw+iTIlvAigLu9FxIMeSpHFw6pc1P8pphr42DqgSy1Q6Jk6kY
 Ly5l5+gE6PoV0m32anu1YQybHab/c+Mau9cv5+uyfsk3zsBoQ7dBhDMvmjAmwOwwQVNF25Dz4w5
 SI5VzXuzagJV/9Wy+HYz2vXBzmALg/h+DF4zTTojiRpbtUIRV6ox3RZHafOzeXaqgOZmQd/6wqG
 xFcX7dJy1bkoaT/1NyZf5cgvaAdeQ9TBU3hVaYzUSdKXrERz6NtxsiDPaEzyLybfeI/Hg=
X-Received: by 2002:a05:6000:4203:b0:439:d750:42e3 with SMTP id
 ffacd0b85a97d-43b6427576fmr1301743f8f.25.1773953817871; 
 Thu, 19 Mar 2026 13:56:57 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:56:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:23 +0100
Subject: [PATCH RFC 01/40] vsprintf: add %pOF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-1-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=rEJNtXZP5+H5gwqn8qXTXflA9ZA9fkONh6/nGZHH35Y=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybyf+o9MPLX7qcBkkZqeKOVH5zuNuUVy7mxfkCHLq
 aksqLK/o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzknB4jw/pH62KlVzw72OBy
 ppHzpZKQaNukswwLpt48M6vh7cfX+T6MDHPYNuwR1ZOyjLJ5dp656cTlRyziG/ffnVTI8J+9yGK
 fvwwA
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

This prints a full ofnode path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/vsprintf.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c7340a047b2e..49dc9c38c652 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -25,8 +25,13 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
 
+/* For %pOF */
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+#include <dm/ofnode.h>
+#endif
+
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
 
 static int skip_atoi(const char **s)
@@ -437,8 +442,32 @@ static char *uuid_string(char *buf, char *end, u8 *addr, int field_width,
 	return string(buf, end, uuid, field_width, precision, flags);
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+static char *ofnode_string(char *buf, char *end, ofnode *dp, int field_width,
+				int precision, int flags)
+{
+#define NP_PATH_MAX 64
+	char str[NP_PATH_MAX] = { 0 };
+	const char *err = "...";
+
+	/* If dp == NULL output the string '<NULL>' */
+	if (!dp || !ofnode_valid(*dp))
+		return string(buf, end, NULL, field_width, precision, flags);
+
+	/* Get the path and indicate if it got cut off */
+	if (ofnode_get_path(*dp, str, NP_PATH_MAX)) {
+		str[NP_PATH_MAX - 1] = '\0';
+		char *p = str + min((NP_PATH_MAX - 2) - strlen(err), strlen(str));
+		memcpy(p, err, strlen(err) + 1);
+	}
+
+	return string(buf, end, str, field_width, precision, flags);
+#undef NP_PATH_MAX
+}
+#endif
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
  * specifiers.
@@ -472,8 +501,16 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT) && !defined(API_BUILD)
 	case 'D':
 		return device_path_string(buf, end, ptr, field_width,
 					  precision, flags);
+#endif
+/* Device paths only exist in the EFI context. */
+#if CONFIG_IS_ENABLED(OF_CONTROL) && !defined(API_BUILD)
+	case 'O':
+		if (fmt[1] == 'F')
+			return ofnode_string(buf, end, ptr, field_width,
+					  precision, flags);
+		break;
 #endif
 	case 'a':
 		flags |= SPECIAL | ZEROPAD;
 

-- 
2.51.0

