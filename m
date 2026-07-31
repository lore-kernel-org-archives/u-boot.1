Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA86C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D994D41180;
	Fri, 31 Jul 2026 16:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id As2Zq7pPr1MC; Fri, 31 Jul 2026 16:36:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F79641182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515770;
	bh=BkY/fnnkBS64GvOSOaT237eb9RSZ2xlShlAs3RrmhXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cpp4V7mEH1cC17MgEYZDcy3y6mrwklzSwbkaITdSlI5iKKrCT8wzWpeE4ggywCu/j
	 SF+oCfp8MdHIxkvPE8UkOXwNfKneFCoQMqJnvjq/ojlMPP80vGU9GmXsxhIoS0onzE
	 BF9cZcU8t/n3J902Sb5BOcyYp0FK1fx1TE2Kd9f3LRj7XzG4OyStNXa68E5ehAZ+NH
	 pbj+c4m5Wkkb1P9/M09I+9wBEaUqKxKBwU8x2xfxYzVw+1HuhVihmjWgw0VHaehoZI
	 VyHN051qbo8mrX/ufjjx443zNrqcdEChUlhlioMxcesM379pQkt+pQUDulce4ZoXzm
	 s/QNN5mPi5wtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F79641182;
	Fri, 31 Jul 2026 16:36:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83E2536E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76AD9406A7
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHHOS2lRvZCs for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B47504061C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B47504061C
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B47504061C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:27 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5c2c0e261aeso378827e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515666; x=1786120466;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BkY/fnnkBS64GvOSOaT237eb9RSZ2xlShlAs3RrmhXY=;
 b=PTMwXeYXDva/bnRS66wBR9M94rNDKubY/wqRhbkW/Dk9R3WEjxjTs+Cnyyn23BIhqD
 e14qJ+aO/lM8ADFeiF6Stwiq+Zn6i+Wvxw4+Z90pS5VTEcZsdXh3mZw9wQzKpExdsop1
 9IHzQ6QbBr07uQBFd2mBNXSQeqhDb5hMLVGTABj1VHtH9RpOr2X7ahW3DbFJo1GniDEQ
 zvb44RLoO/ParyTQeNKytuBxzVTCgUFxCjENgh5A70mNG6q2ure2TSTNotGvtyep3YHH
 AB5i63Xzx0CjYgsYPqW7+u9te2fimwlqz46LMN6A013LKbgBfRkxLzcAPXRmDUW6p64f
 nxUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpchhZeWN81grfNtjbbXanjT3/69vC0A9USu51zOZK6MEZQayvUDkdfkumEwWzlB7HsjL+mNr4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyxwIkQbNTB+ja32SVFEKAM+F1V3uV51T55uXq3Z8d+nXUw3ftJ
 dSvOEJegMXamje6N3jGAnA3QyD1jIarB7RQK+Bzk8u4ZltAJ/sRJRdscySKNxHPK2EM=
X-Gm-Gg: AR+sD11yJl3SdXPFne/B4VB4Ftsz4mjZ3NzDkPl8LHqxX2jWOe4te7LuRrRqn2eErNz
 ZU4IiMUWCIcOxK09CG9oqnFCRcZK0zbf7YHSA+S/0W7/2kGIeJsUIHl+JxCvYi++MOUAcT/rWbk
 wTUtgFBIuyviV8dwLhuqHjynYfQtbvlzad+GluCGeYqlMsLRdCr9xs6JDEonfMiB4aNlWjneoAX
 DayTesvtZqXyt9DLy4On22DnmGBkcwvC1OSOB9eI80obbSAeEhXaso0qRA4L0WAM+hWfZXzaejv
 egUYksxxwj3ssPi5jSk7XSPpEvPB1/ieJ7kfxn5M929Ibbgyr/B3IIMHU4tmZk7uJ3hfbjnHm2H
 BKDPiDRDUwXf8xUwnOqqS33iyiVpnPONkqMxlw6FIyJdocnsZFj8v9/+i3ASQzal/xQwntOARhG
 K2/i4zHR2VqWYY6OLTKdkSwtKmRvaF6o14ILt8UVEId/3jKlS2c86nMODGN6KLR9cXiwEM9Dr3a
 A0DTwfdDquP3RdJohBBPpG/AsrMpOYJwyGQ/a2MPu9QLB5zEC7iT1FUQEGZ
X-Received: by 2002:a05:6122:7cb:b0:5bf:a179:b2be with SMTP id
 71dfb90a1353d-5c3876d7d07mr278183e0c.7.1785515666254; 
 Fri, 31 Jul 2026 09:34:26 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:25 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:44 -0400
Subject: [PATCH 15/17] ARM: dts: r9a06g032: add QSPI controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-15-af2ce80db9d8@linaro.org>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=1060;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=8nrBh7d/rqtVjVeqSt5+2Ti4Ppf+BzXElHKWc1xTa7M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAsQbaT7gTyskqWSiTcmjq6yKSEsUjxisrdxkztP1JCbqTbjgzJOcI5AlYuY6R2QjcTnj6OIQz7
 cx+/Yo/zUtgI=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515666; x=1786120466;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BkY/fnnkBS64GvOSOaT237eb9RSZ2xlShlAs3RrmhXY=;
 b=zQV+eqD3U/R+zjk6ujzLor0ALdrgqz1h4l+GI4o+xeeQ1tNZxyb1+hTeMPsZMs0x6k
 n8Lj5/YVGCk4K77dJqGR1dFDIkT9Ab1LR2Cb5SFRcS+1ayuKzvMBItlpEuCntN/N1cc8
 NNmbDJTkxloumFvMeyY96DDg0NgSKJAev1iePVAoO2diU9cojzs+xvEGYvfElrU61OFi
 2w8Od7Jm6Gay/v2dvgO857hm+uKFjFfYeCxyPZCdzZIrx1QcDtayTwvynC0pkyMjcw3P
 I16ygWvVm8y7KE1kHsCPJvhQoltg7OfxSh0Fj7yCgJrN+UT+i5ekAEpBSEPOtQi75+r5
 Ywgw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=zQV+eqD3
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

The RZ/N1 has a Quad-SPI controller based on Cadence IP core.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
This change needs to go to upstream DTS.
---
 arch/arm/dts/r9a06g032.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/r9a06g032.dtsi b/arch/arm/dts/r9a06g032.dtsi
index f4f760aff28..b9073abc7f7 100644
--- a/arch/arm/dts/r9a06g032.dtsi
+++ b/arch/arm/dts/r9a06g032.dtsi
@@ -66,6 +66,19 @@
 		#size-cells = <1>;
 		ranges;
 
+		qspi0: spi@40005000 {
+			compatible = "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x40005000 0x1000>,
+			      <0x10000000 0x10000000>;
+			reg-names = "qspi", "qspi-mapping";
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_HCLK_QSPI0>, <&sysctrl R9A06G032_CLK_QSPI0>;
+			clock-names = "flexway", "pclk";
+			status = "disabled";
+		};
+
 		rtc0: rtc@40006000 {
 			compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
 			reg = <0x40006000 0x1000>;

-- 
2.55.0

