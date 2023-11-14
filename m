Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEB8C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21AC987463;
	Tue, 14 Nov 2023 13:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MRYprjMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3A8871CE; Tue, 14 Nov 2023 13:51:21 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5138702E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so67135521fa.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966277; x=1700571077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+SngRAX0rA2yULTVEkfIRWhVaH4aZVpyhzLZRSQZlvg=;
 b=MRYprjMkUL0dA/npbLoKBg3NR1J6dHYoRJa+ZbZ3fV2GNp9pbRX4/euGGcC2rg2pMt
 ot+Bx09NbUFDsyj6xbjo+OmLBma0QS8yGQ0QInoON9s4PIhExhMxE8yOcZYyRTYUq9r3
 lXdMs3ShDHbDYD9yXmRc8Qz9ZJb0DvLv5qB8vT+YOaR6lSCfbGyvTSwI+NgFxLuDLhm+
 wWWufkN0Gbsn1u9KgmaArPqZAIyKOBpZsJITU1mrEdgqJTA/qpOuKvrWRF9OaOEsIed+
 v77AeLEJWQpsbSexUBZDaPN57/sX75VgoN1hPyE2nDlVl3Sti5Vv7tA1dF7WH8hh+N6p
 VXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966277; x=1700571077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SngRAX0rA2yULTVEkfIRWhVaH4aZVpyhzLZRSQZlvg=;
 b=ZwY0Sf+fcvn6sdNpW0chEDWdy4wx7NZfUm8wW7SeuE16PLrZ3lL5BpfOmoLGpsYrnV
 25sw/opPk5Bo3VMOpX+b+dT0ao3myWcSsl213ZJdSMhHDfYKE6jnaOfUQmXS0+QlPMsk
 /uEPB4HLJ+jyLIgD+MjErN9S/lU0UTgUXlPaHRFcwfXcKpWpQzZMQPcWtBDGwwnImPJO
 2HanTnAkDHCPNEZzHq/cihzSpoq3nOPEfe5aPsj03td45iNBDOigsv/wnADACNq1wJMK
 +VAHoagksP6AXAUWYnKO9Bo35oZ+72hEsnNpYv/UJ2gKCkKETaNa0t/Ewt8XvPuB/TKD
 E4hA==
X-Gm-Message-State: AOJu0Yz+rGWubsCcV+z6RAQK9RoxTBy3re1YFkTuAneFM6F5ezPop0J1
 eE/yxZUtNvmy4JTy38fmSI8V9w==
X-Google-Smtp-Source: AGHT+IGdr0P8+GuQuWwxo+zwhnVWjjn+cJnJ6bYIlkUURNEqO9j33RhjByUqhGjqS9hPD1IIn/FYow==
X-Received: by 2002:a05:651c:1a1f:b0:2c5:2191:3f35 with SMTP id
 by31-20020a05651c1a1f00b002c521913f35mr1965625ljb.2.1699966277438; 
 Tue, 14 Nov 2023 04:51:17 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a7bcbc7000000b004064cd71aa8sm11263451wmi.34.2023.11.14.04.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:51:16 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:51:12 +0000
Subject: [PATCH 2/2] serial: msm-geni: handle devm_clk_get() errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-geni-uart-v1-2-48c8ba9dda36@linaro.org>
References: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
In-Reply-To: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Uh1ey1bT5RyQaWQJWTvuAqZqgpilzcAjZkkJ3g1li2g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgXKfNuS3z/gvlvn6S9vvlNMGNFprxVzauqSsxP1W+a
 tPk/rITHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiv58z/GJ+viCvQOKU6uV5
 Ce+sfk9JT+PJPv0jT1vssotTA8f87cmMDHONPL4WLsvun56zg3daxrHJ1523XvJ+tqz09tbSRYo
 nZYUB
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

devm_clk_get() returns an ERR_PTR on failure, not null. Fix the check to
avoid the board crashing when the clock isn't available.

Additionally, add the missing error handling for this function.

Fixes: 324df15a292e ("serial: qcom: add support for GENI serial driver")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3e2e15b6cefe..0eee776fe8a4 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -189,8 +189,8 @@ static int geni_serial_set_clock_rate(struct udevice *dev, u64 rate)
 	int ret;
 
 	clk = devm_clk_get(dev, NULL);
-	if (!clk)
-		return -EINVAL;
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	ret = clk_set_rate(clk, rate);
 	return ret;
@@ -249,11 +249,16 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	u64 clk_rate;
 	u32 clk_div;
+	int ret;
 
 	priv->baud = baud;
 
 	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
-	geni_serial_set_clock_rate(dev, clk_rate);
+	ret = geni_serial_set_clock_rate(dev, clk_rate);
+	if (ret < 0) {
+		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
+		return ret;
+	}
 	geni_serial_baud(priv->base, clk_div, baud);
 
 	return 0;

-- 
2.42.1

