Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28943C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE4F9607CA;
	Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ipo-cCHGuOrD; Mon, 20 Jul 2026 18:10:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A49E5607A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571029;
	bh=Jw30qgFXI3oaofSqkP8eVs8HXQHAn/HXmmNQFDEJpuE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FPAGMWdLxQbmDbH9YadqRmnrqsh1uTwIYo8YU9ioliAC+s9BMtFzCbcw9yfSk+NS+
	 +FfXmJ4Zuj3kwOJS9kQKwW+/IUbWJDmyn6Zs/S388vIJz6dWV3oy28esoLUnDB7fLJ
	 GNaewflCdR4brze9Hk0nAuUh0kwsheKm4Ni6OvSAuvtralfLR506sQPQLspPoVTuDW
	 plBzvMAfaac7ZUvx3wtd7fSQo+NbSQjqrwlVt6TPzdqmNH1fM/KTrcnSzr6a+aanLK
	 XlHO+hy2G9oE52Sybe2CF0U+R9/N+uXpyvdB7Z+o0Iwm55NEAAmaPNtNMwksaAwrnT
	 2KY3mWIaR9aAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A49E5607A1;
	Mon, 20 Jul 2026 18:10:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78FB21DF7
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A86D80BFA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vA53RYDo4p2R for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 35F1580D2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35F1580D2D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35F1580D2D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A8884A0F; Mon, 20 Jul 2026 18:41:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4EF8484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:31 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso28134295e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565691; x=1785170491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jw30qgFXI3oaofSqkP8eVs8HXQHAn/HXmmNQFDEJpuE=;
 b=X4hx9ZJVWSd5uXssXTC6zoYk+TzsIuBK1kyZlwK575qSGZTWDY25Dy6xxFrRWzGe4o
 +ejogySZni735W2nCemuY3SaDJUU/hM1HQ7s8PD/NIRF+HnFx8Om8+dK4yKX8hProKfA
 /oNKXgD2/RBvO4ya2NAjce1EHFiALRPH9kv46boHAOIobNJdK9/fAuZ8ZTwpDeBKTLbk
 LBuCRlTXvFZ8EFgxgmEGtVw+o7vslPxqS2+lBkPefkRiTRqNM00iECEWMc52XJNhlTIQ
 K7KwsllHNenGCA4XNwnhIpFHtrnmKwR2UVkP0bK3WxZhu7qQc0dRRf2y7MTxBGFQEwhR
 55eA==
X-Gm-Message-State: AOJu0Yw1h39NuKYZcuiKyf9Mze9Nb7IvNKwiub/rg4h6UJFFR/4LdQm9
 IWm69qOpU7l96KPJ5CvDTV5PCNODRuR+lfIF8vrYuFwYi8XtUCU6XaJeDgwQtn1lCas=
X-Gm-Gg: AfdE7cnDoEa2VV3v+LiNVAosI3iDDDwVNz4AlN0ygjMQgA937KZ0Kk/o9UN5q0Y8fb9
 2d7e4WNGH6V+s0pITHUe6uAMZfMImSRviIOeesb9+QQovZK142JW6eGWocUy7Y5XfCVdwDOwNw4
 wWy8d/BjD5F/viAACVkTmX5bRl6gI+azrwOgA7P856IrCgE4qa7//6INIOo6R4Plrc4vxMVjrMG
 K56fw4aZYhJ6XcKlh2sxRJdxX51u/yQ9s6LQ/3eFjmF84rjkJWqanrPQN0uG12RMFSi57PV8NXX
 kId03zrVnw1WaLOdPNC9cxIUMCoWONUx08YAUKL1xPiJcjIla5sf2mtcie1LznER1y1QXZGuWuH
 pe3gMYR3LFBpc6lWFJp5cB1AD4GeOoz+LWxNCAbCbCweUNLHdQm8l1dkVZmtanSpdmts/41YyrI
 dsumeKWw4p3CbpUxSJwsMjiW2qdogJKaH7754L82gK
X-Received: by 2002:a05:600c:46c7:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-4954a323acfmr157062355e9.6.1784565691139; 
 Mon, 20 Jul 2026 09:41:31 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:29 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:44 +0100
Subject: [PATCH 17/36] cmd/clk: add CCF_FULL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-17-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=f0DleBncCH8tOhy9khGk7osgZEXQ0K0Ac/nuoNn6TgE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+DQCNHcGeEr29iTGKh6rWHDjdF90y+vPHg6
 KtwIu8ivr6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tlwrD/98wUKcRangQ7knAxRycP7KoZ6NNXX2iVxzYqwQ2/G5r5gmCy+ENHFkw/UTBMbMSoLFQB+
 pem8KPEd5mLg1kG8KFMuhghSVypIEdVt772DZ9dmgdZzqpjXjo/ae123RHH1lQPU8Madu83HZ73
 znJu2laxFnJjhfO6bNaqVXHGoWXbPn76sv7Zg64I0YKhhyFTDiSIjTQkod4IP1WiBVZeChn0FZn
 lnWjchz1H/6RtLZ76APxW2DvviFav7RjGQbjlvlAbkOQABkX4jf0oLBBUhYfHaGA4aVspir6Njk
 V/iedFVNTv/aoSMD8ifD3+rCABXgwPJydXJD0hY6u5X8cXyE6/WqtJhLP0ZczNiEOtPyfS8eYg+
 2/wGeZw81zlGYSXd6r5TSUajqJHNc/hsEEU50lz7ZDrFp1ddP54JOBHtGuTL1CpXUsDsrC2m236
 Qy0S8GcDPFAQ5V1TEI83sJ3V2dsWs1PlJj/Jki8eZHdZqJmhZGr3lsahH+L5hYINMrbgQCgx1QV
 qu3DwDuDKgmSwckXecRZtjkOAJGcd08H2kaF1DeiOzuqr6ovCoC8NQVMznhvwqU6ng3grdJ/RDw
 pGYRFtcfL+XcIMN+rLmr2MgHdhLXuoR2fDIOEGpM/0IafC6lSaDbMYoHZ+dzTXCtPKS03vf6pSP
 n4kdeprakWS+QSw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565691; x=1785170491; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw30qgFXI3oaofSqkP8eVs8HXQHAn/HXmmNQFDEJpuE=;
 b=Hx4sClcBTuZFn2MuMjsmuNHqBSpxQQLPK9ERzn/HpuD73CH/9h83qVYKpgXw4NwJ4e
 +aE3aW14rDab7WchCg59CqJ1n7pYeQSbcREKKDtNJaqY07XUppKmbaAsgMNY7bmylHDA
 yzHZ8w7PC+QEld5n60E5thb/1Ur46ffmzMzj9sjVw3MXY+DIzVC6fgQivgLzNIRCBfRR
 S8T15S9ToN5D7hhfVrQJvdriqJ6ugzqlCTrXwVPia/D+Rnv9Humamvf3BKTBOkKkN+xW
 k3NzQqN1cQvreuU+ZLCSRLG8hXIcLi8uz19wH6fIApNHrio4qn9wsi3JNB+NpW7991be
 dtoQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Hx4sClcB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hx4sClcB"; 
 dkim-atps=neutral
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
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This functionality can be expanded later, for now just support calling
clk_summary_show() to dump CCF state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 cmd/clk.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/clk.c b/cmd/clk.c
index 1210a84ca2aa..1f1888b8fd94 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -9,8 +9,9 @@
 #include <dm/root.h>
 #include <dm/device-internal.h>
 #include <linux/clk-provider.h>
 
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
 static void show_clks(struct udevice *dev, int depth, int last_flag)
 {
 	int i, is_last;
 	struct udevice *child;
@@ -119,8 +120,26 @@ static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	printf("set_rate returns %u\n", freq);
 	return 0;
 }
+#else
+
+void clk_summary_show(void);
+
+static int do_clk_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	clk_summary_show();
+	return 0;
+}
+
+static int do_clk_setfreq(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return 0;
+}
+
+#endif
 
 static struct cmd_tbl cmd_clk_sub[] = {
 	U_BOOT_CMD_MKENT(dump, 1, 1, do_clk_dump, "", ""),
 	U_BOOT_CMD_MKENT(setfreq, 3, 1, do_clk_setfreq, "", ""),

-- 
2.55.0

