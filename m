Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5F21091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFCF83F9B;
	Fri, 20 Mar 2026 00:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OIho5zj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A53783FC0; Thu, 19 Mar 2026 21:57:13 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF9980517
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso1060643f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953830; x=1774558630; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+IfOdxKnO5d2gX0DJUSfHZyr0om0CN4y9Pd0XspF9Lg=;
 b=OIho5zj5RzZ19PH1dYQveudK2Rh+B9BslDsgVlyutpS6m8vhgOLg1z7zyI6c6OmrGo
 OkrrnYs+Ieww1pbAfMh9N8HB3a+uVmUrnsEss0bX+giRTNufmhQXOc7h9XE+7EaPfCfd
 VN6CPoRTJyMQfBD3HVZuLqLrNnjYRH8zLEnbOqWaf7GDPtPtzfptsSzNkx3HMtoPk/y5
 5RkQJ6ZySLhtfxQf9h+sXy9+hTVGEYdfTpWmJlxiK+e5Qbpam3e1+vPPradKypGa7y5E
 FR2u1vFCi8qYJxXpANP0E9hinu8kw/vPyNqkMnVC8BeNOa6za5Q4jgD0WAOAX0Af64jC
 kNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953830; x=1774558630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+IfOdxKnO5d2gX0DJUSfHZyr0om0CN4y9Pd0XspF9Lg=;
 b=is7TnhmaMclFn6n88irMBehXwE891f2kwmWG9sOFF/cjdX+cjzIdpyabFUyu+Rz3zM
 S+KDGCJalkrm8wmk4BIl4WoHU0kdh6dPr0I3O3+K2YEKHXsVzbgAF8yUkrO+q1xqSmdJ
 Xse8smNbJxjL5NHF2dfQz9s90wUIr/rRjHOevR/1+KM9Xo1irk08EjxdifM8tH0NkKsG
 o1bUkF95D2JQcQAJadBS5aUc8XQmBQBYGWwjkwDHJZpQNzhbXxzgoixLH5feVPlVAx/5
 rNjKdP2LRCHF0hqYBElw6JQS3gBpM2NO2Xryfbn6gpecnceQtNtf4mDopZKO145nPjKy
 W8JA==
X-Gm-Message-State: AOJu0YxMCBuNgEOOZhGdZsyRUh0718hN5NQhRaMNwKCdIS8izSjoAs8Y
 TrOPXjws28rD9RxZlJc+CkabQQ411cDDNQUzZvE5h5z8Od6dBDZ2CxoI2c3ZzBgR7dE=
X-Gm-Gg: ATEYQzwVtfgs0Ox5k4IZMN6aSW01d1LZazo2XWgiU96PGV9rPMcYTin3BArpAWSg8/B
 zVeowbMtjy9M/kgQ9QlUXZzDQId2PV/ZrHToViNecgHMx0CotC2S5Oi2UXhet52nclXx64F+eYD
 MxbRNppu71fxHqXxpkqnOmPrCb9EMPMztxeo4CgJBFPVLlBKx9QmaIajWnVOHdDT1uyxLNGRMzd
 EYgGcvY+HJn/tAdYXj5vx5j19Rkp9UtZ2G0N9wiqcVVkWrMnYstFUfLcvfmZGVn6vxEf1bdVEYE
 lNxQ3QLzPHKdGklWK2wHSyHbH8ZQoKJY7LGeI46LzpENFVii+UnsfmAcNz7BMyh/7zSo9kapZi6
 RLhAyjgmJMcBLuhoFjg5XGLRupczH2afXKBPci7UGdyht8vbaSYgqlVJIEhC1KXS9xH8aoEkAiz
 zlgGuyuu490Z5IFZpd91mnOh2IiRkArMtju7Mzj3qrXx7Y30tRBi5kk7yuz+Iy1AnGddhSL1zzj
 UyeIg==
X-Received: by 2002:a05:6000:612:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-43b6427d39dmr1330209f8f.34.1773953830110; 
 Thu, 19 Mar 2026 13:57:10 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:09 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:26 +0100
Subject: [PATCH RFC 04/40] qcom: rpmh: don't error for SLEEP requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-4-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=EMYajq/tChEE6riKBZOgKjJcWcO1seCjnTJUt8+7XRc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9ybxWnsm6/Y/eMPq3n0radJUvOop9kQzHhH+HnnTp5
 qbrn9rSUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYi5MLwP72ITZt57pM3y/9a
 3Vq1c/7t7NM2Xzb+8vflVvc2Xq3yfBPD/1qzDXLxlm6PFHiMxH4/4ywILdwUOOO/+O9Db3+zXjl
 Q8RcA
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

Just stub them out since the caller might also send active votes. Since
we don't suspend there's no risk of missing votes here, we never enter
the sleep state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 8 ++++----
 drivers/soc/qcom/rpmh.c     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index dce61f262292..51af5a2a686b 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -260,10 +260,10 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	 * U-Boot: since we're single threaded and running synchronously we can
 	 * just always used the first active TCS.
 	 */
 	if (msg->state != RPMH_ACTIVE_ONLY_STATE) {
-		log_err("WARN: only ACTIVE_ONLY state supported\n");
-		return ERR_PTR(-EINVAL);
+		log_debug("WARN: only ACTIVE_ONLY state supported\n");
+		return NULL;
 	}
 
 	return &drv->tcs[ACTIVE_TCS];
 }
@@ -389,10 +389,10 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	int tcs_id, i = 0;
 	u32 val;
 
 	tcs = get_tcs_for_msg(drv, msg);
-	if (IS_ERR(tcs))
-		return PTR_ERR(tcs);
+	if (IS_ERR_OR_NULL(tcs))
+		return PTR_ERR_OR_ZERO(tcs);
 
 	/* U-Boot is single-threaded, always use the first TCS as we'll never conflict */
 	tcs_id = tcs->offset;
 	if (!read_tcs_reg(drv, drv->regs[RSC_DRV_STATUS], tcs_id)) {
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8c222324c66d..b55e23c4417d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -59,10 +59,10 @@ static int __rpmh_write(const struct udevice *dev, enum rpmh_state state,
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 
 	if (state != RPMH_ACTIVE_ONLY_STATE) {
-		log_err("only ACTIVE_ONLY state supported\n");
-		return -EINVAL;
+		log_debug("WARN: Only ACTIVE_ONLY state supported\n");
+		return 0;
 	}
 
 	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 }

-- 
2.51.0

