Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556EFC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B95380E65;
	Fri, 31 Jul 2026 16:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYDkMws7b27s; Fri, 31 Jul 2026 16:35:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6131480E71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515748;
	bh=PYcuT7YL0wv+kGGkq7v17xyJDkRTD7HuimpLTiBiEkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7N051FbG6qb3FnHXdD94EG/ml82OSAtHPM16zt5J2DA2SgSCXOlNxEPY4gwLs5w0
	 3x6y8TYGciWuVDQL7F1D3EbSCfv+8oMK35b4zGuoSWT5fJpLQX3IdlZQ86r19I/tcq
	 rKvOBYrmJwiTovwANugfxIC8nc1CM7CO67IUuRrvjDe4GUw1JQ58n2dWiILTleOtJi
	 0ZkeWRipwQLy8WrPYoYF/eCuVI2OMC/My0RhdvWOe8NxUU1rGGUKIh5264gSsZwc8Y
	 1csvgt1SmR6khcIY8+gYMmFJxVI4BPKaS6hoFLRDRlqes345GNiDc/6vQq2xb0rgM5
	 rr86B0iExwPUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6131480E71;
	Fri, 31 Jul 2026 16:35:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE70127C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4C20406A7
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfk0BcHsMwTD for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:33:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::933; helo=mail-ua1-x933.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F19994061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F19994061C
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F19994061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:54 +0000 (UTC)
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-97723f98735so661161241.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515633; x=1786120433;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PYcuT7YL0wv+kGGkq7v17xyJDkRTD7HuimpLTiBiEkQ=;
 b=X6xfFBUJHKYHu39ZqhrBFdm5k/J4FU7v5G8wmiaaDAonC/98MlJTxOAR/nEk8brdMV
 IetvWxSypLW5mKrC2xiAC/Ya76WIKCir7R4UTdf0xv/iNHBPVonz6FxfOlvhRRxHyEvW
 yO+98RXIUaTuELtfQVupgvcBmyO2KTqZZe38Ff9hd9cZEPSf7mL4+PVHi2iCymDrVlmh
 pOweaPPwFyDlga9LRXxsK5b02BGeeoq3DTJ0YPcq0ky98KkgMBJkyIIxVOI+EE14gp++
 Eca73lp3OExqfzmxeqf888f4dQ03bFymkPCOJ0Sffs+bE4bvt+zCOOZ8ebL2obADgyQJ
 Se1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTQaLy79akICFJXdYyzOmcx3Z63uj0SboHr1pDlqAt4R2Fi1XY7PGJNqMPkoFXGRWoOZfGBeU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyOohhxx+hrt4iZhoioTumec5vqkXBfEDSBE3owU8lZjM4K0dex
 JzT4ceYkmYiYJ6F2PXIgbdVpPE9O9/YiWQ4KrnoVUrjZP0rUru//sGtL/zij66OY4uI=
X-Gm-Gg: AR+sD11fNo2y294htZ9Ir9FFnxOW90E3X6TCw5rriBtfJ2VqKwoRG+s1msJNgRkR1O8
 VW9sElMLIaz78L23/enLZclIweMVpWtcz7HD9GB+cQaac9UnKEilXDz18Dkym8Or0Ng31Ho4ujC
 KGZ8RVGFeZ58T0m9n86vNhbsbpWF1kCdeDdjYpC/u85+nFW5tALCfvYZzk6tHNeu5AvKiEWhT6v
 RuTfrCgrEBjY0UbtN/wpfNi3Wb8leEWg8VJmuTl3m295rmqCvbtYFIugH9Bax5Ot25+slHmmxpT
 F0qKuJ99dxEZTzqlYaz1jWkWShJj4trzXgD1Ro3Lw4yK34CCXG5Gvc9/addQHggh3LTOrnH8EdG
 j2YfnCQAkVpUp++yX2eS1/mnXSIpY8LOwRVePIzyJnU48EL4vQdEIOD+KQtTdqapjZ+RCjYDrog
 12CW1deCFSiXpxFROYOYiEec+iivoSU53bGBiI2zNhCOAYCsKeJOQoP2M30qP155mMyEKJ53DiY
 KxIUHLI4sXwBUoKlxq1ue8UfYR/z3LcyQpmzzKRCV1BW49tdCJPOvgCrbYDgIyWnvwnTaM=
X-Received: by 2002:a05:6102:fa5:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-75b23d68935mr783614137.9.1785515633590; 
 Fri, 31 Jul 2026 09:33:53 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:33:53 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:31 -0400
Subject: [PATCH 02/17] spi: cadence_qspi: enable clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=679;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=KPeq7o26XSGnUt6oraOWBvr5j6Bxo8ikhHczgBmV4O8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJam7xR9Tu3407wjYdkd5tHR1XH7tRGHVq8Akqn8o3u+Yuei+JuT6kv7j80DIphORBDHVrx3CTI
 AP7am+0dvPgY=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515633; x=1786120433;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PYcuT7YL0wv+kGGkq7v17xyJDkRTD7HuimpLTiBiEkQ=;
 b=VI3TW3c5EQnkUEs73wj9KzfVzq3zojp2dxZI/ALOjB+ZG82S4yzvo+d52BSP+kNfFl
 WUaAwnDTv9as1dtkSBdyv6Gy8b6ERIT/jtxkKDEMRXa+2GSjRxLlI89y1hxvneqF8DYc
 lYkvybFwaRfBYLHG2JJIDlRNk8sPXRDWxXd4SLk8wdu9CA5bCj9XlPD5j7FLNsxIi6OV
 iugchEdWmrPLIhSVOqdgamp0C3rKoKmy7MgDW/c6etM9RGdbLwrgA4Q23EIDzMSXwkTe
 0Khhx9tSNpMGryAYpF/spdZXneDd8AsbuBRCnNaCk4Id0H3vjgzXxkiu8T93aoY6u1/g
 63Dw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VI3TW3c5
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

On certain devices (such as Renesas RZ/N1) it is necessary to
enable the clock before accessing the QSPI controller registers.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/spi/cadence_qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 984d4a39ded..c383caec6dd 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -253,6 +253,7 @@ static int cadence_spi_probe(struct udevice *bus)
 			priv->ref_clk_hz = clk_get_rate(&clk);
 			if (IS_ERR_VALUE(priv->ref_clk_hz))
 				return priv->ref_clk_hz;
+			clk_enable(&clk);
 		}
 	}
 

-- 
2.55.0

