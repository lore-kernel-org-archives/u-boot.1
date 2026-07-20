Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5A8C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BE1940702;
	Mon, 20 Jul 2026 18:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wIklckYhq4O; Mon, 20 Jul 2026 18:10:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6C0C406EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571008;
	bh=Y25x447Guht5ADrFC/WcBLjjXlhddC1R3nrVIl22w6o=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=r+gKbxMAZ8l+5yPXBaYRTv9Ekmdr3Vq0B0q1YQG5Swa0SSA/v0+IV+C9DA5kSrZkc
	 c8CMq/Bqi9aqVXXGr7Jg2SqQdqIas1w8J8RrfZ700MXY0hrfLgIinyaSge1RgJ+FbA
	 r/uFJisaOJOgdlG2zsIXyK6C5iDmk79whnZb4XXaWJ48tRVGXAjKMWKBtP8eRG1OHo
	 KwXUDKR14GEzH75G+Lyvx7j4C+g15LaHZ+T8cTCoRZk04QrccHtGNvN18TiYd9oTn+
	 QR6Bs9Kz2y4RdNFD0klzdAOFBCUgzbftwAfuruNyCiqz4hRgwFt0o0YEZdnzGT3KEL
	 p6K18Mu4EQ9VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6C0C406EB;
	Mon, 20 Jul 2026 18:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24A66132F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B0BA406B3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwg13itdJhbC for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
X-Greylist: delayed 493 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 16:49:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C83AD406A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C83AD406A3
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C83AD406A3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F0E842FC; Mon, 20 Jul 2026 18:41:03 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B330848BA
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:01 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4955484387cso11626125e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565661; x=1785170461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y25x447Guht5ADrFC/WcBLjjXlhddC1R3nrVIl22w6o=;
 b=jpjQ9yMZjlyOje13QRM53gA9W+aXhbvZwoamugjdM6LUMaXCqUzqCNcyD1UHnngMp+
 ihmzY5diJ1bw6pftsDtOPNdgJSgzmpFBistQb3ttqPKJPeTsuqbvnT8yUQRLxqY78MDT
 Ul+OmR4tmbvyqA4xiflkKTUuATmYewrRUlJgave/FwErlMGu+C1RkIazg1QrshjUltge
 laefuDhAPaiOWlJyfIiI7ILZmiuuKjXJnAeUQM1abKdr6Oape+EGN3U6zrNsnFuDuWWv
 XhDHK0wMZFp3UpukHbiswCq04ZmrwonkNuwodTKACnCURqDyFo8nErTNmwlDkJiGVSor
 vITw==
X-Gm-Message-State: AOJu0YxCKiyHXBsO6q1Koog18ViIS/BNax2KeMAFC8tAMEP6EVVimwt7
 TUe6ee0uIZY1CSFvjuS50rKg7VI7VZGgto1s7ZVcVwxcFNv1Fp4p9ymy65XA2veelsI=
X-Gm-Gg: AfdE7cnCCberjJREEawUeW+3BBa9AW4n0AIKLVkfNgVRzbi2uBtdWboCP2Ha4HrrA2w
 jrROOwbzdAdtopeJaYqsCgzUT9VFw3/uDIVtVpxp6sXB4YrgaKm5Pihz37R6OlXdANbDSRaGppG
 NJAuvi+2SLz7gsDC/UFYlP2VETO6zRT3T09rU6tBYhSuQefNtp2r761CrSFR1I3g3A+JxEtwS3F
 i71zg9d39TSvX4pH2DoV88krCy7RAKu6bteuhALdqbX8QOU4swrYesMN7lkynH2MCbnQ64sLmgv
 0y6WGdd8bDTZOaMNLnWB1Ur+w+DyC19frfjAbEiYwkubErjs1ZO4FutDxZEZnswoQz4KzWtrF2L
 vgi3Y89klO9SABi1UQdMukYlXV38F1cGWlDW8kIebjzONStIV01Z049Lx1m7G8/b76GEifTyzV6
 KSFeaag9stNPv8wi0wXbeuUDTe96+27Q==
X-Received: by 2002:a05:600c:1554:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4954a3dc7bcmr184999985e9.16.1784565660734; 
 Mon, 20 Jul 2026 09:41:00 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:34 +0100
Subject: [PATCH 07/36] dm: ofnode: fix parse_phandle_with_args API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-7-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VkqFoCA+I49phw4ZN9BG/jLRlqnUHdmYjTVV5RWV5c0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AmUZ+xt+bfbv5CNqttCYh3sbJcI+HehBYo
 v2Xw9jvYqmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 trg4D/9rZG2bvRA1/1gdHsB6lSgv2RMGnFZd7U/oc37uNL0dZWPVEZ5fu/XHzsNOF8gHeDqhRcl
 kDE/Zx6tStNoBnilbUHplEkWTcCtbGRrtBThTkgkyY2Q6+6pqAklGiRVlZEsNeQAmb4jIvcBp7x
 RZitkeh6Lm/qmO/SAhKUlHHHnaysrbIARGJv3TZSUNaL2zr/hFbkAeeFxerRCx/cSmRlAcg20HX
 FD2BeLpDv5pdJWhUdSOHeglRA6iUF9oEkLz8IVbM3xkzE/y0NJcj4Ii2u71xxVT/9auINkWO1d9
 DN8+LLeFct4j5P22Wo0MizCoSjFgwjtmtdB7G3nAorLhuJxTbEVxLen0X8HuYdgCRvTHbtFoZPD
 jvkPjMutNgkdT4gfLexWUWrabHT1d7f0SDpVT1HddTFGT/x4mauCAuRxk3S/AQZXfx5TGLz+yb3
 QVqz4KEoj2DEtD1qN3MIK01xGMVhCKHXo2xYu0iDzcMTGcorUScTsOtcOnebQxHot/wcqK3OUYr
 Xwxl6wgQakbxDNf+w/hB+0Bi9TxEuuMpaRzpzuqH1/0M7L+dA7Dp2KB1UYmMl68r/iTZP2rR3xI
 dY6O1yFMzQU98FbOI4O8kTzd3/TUyAGFrH4QgCV5DSLquCskJLQDkXsWh+GSIccPKBFtQRZx2dw
 YV2ZIwChQ8d9IlQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565661; x=1785170461; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y25x447Guht5ADrFC/WcBLjjXlhddC1R3nrVIl22w6o=;
 b=kR5+LgWRPMcSnyiJqowkq9dgfsR5Hf49Ucw3HRNXE8bn9H29YDe8M+aYHNjK3LZTxZ
 cZJWyc3ikcr/oi1CgUFu2035NpjG368QbNSu893O5XPlh1FcEwkE4KYGPRuMBy9uGSJg
 Pjw0xyXphF80x9BPRb56nnqC46k9OLa/H4jVhHdmqagxXEdyG9REw463J3UE6knHrS18
 eyLIqORQvG0Czk4K9Pr+neweie/HjKYIjd08u+EKJAKWWOT5GVjdwDbqIm9HMbsqaKii
 4r0sxO4ZcT3EwcnJIuxQfxTDFaFNQD8GOaROwUWQJ+CUoY2eGzZcG1bSntyiWIvLG4Wc
 TpQw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kR5+LgWR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kR5+LgWR"; 
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

When not using livetree, fdtdec_parse_phandle_with_args() is used both
to parse as well as to count the number of arguments. This means it
returns a positive integer in some cased (based on the index) which is
NOT valid for ofnode_parse_phandle_with_args().

Fix this by ignoring positive return value since it still indicates that
the phandle was parsed correctly.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/core/ofnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 1388b4810317..b82d48232ec3 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1069,9 +1069,9 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 		ret = fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
 						     ofnode_to_offset(node),
 						     list_name, cells_name,
 						     cell_count, index, &args);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
 	}
 
@@ -1102,9 +1102,9 @@ int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_na
 		ret = fdtdec_parse_phandle_with_args(tree.fdt,
 						     ofnode_to_offset(node),
 						     list_name, cells_name,
 						     cell_count, index, &args);
-		if (ret)
+		if (ret < 0)
 			return ret;
 		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
 	}
 

-- 
2.55.0

