Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yqf8WbN+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I+xWP23O
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DB6E40899;
	Wed, 28 Oct 2026 14:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVJ_I7svZ0mJ; Wed, 28 Oct 2026 14:48:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A305F408CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198935;
	b=OqhRXmFFl7MUqLX6zaj3L+n1iAnuG6yudljKO5ezmaU6U/jYV4A+TTI3L4xEwx4qB+m0
	 XmQkHZ2vtAW4xDDLmIROGhDJbWgZoO+kNpXC1IWPqiZ4MmpVv7KyNjicL72O1g6I2BP2y
	 E6nTCQeofCuVEBfD9FNrOu3l+BfM1ajd0e7ilRlRuhj0IuL6QtSoTHKAhl1QeLWjtbaUP
	 Wgvo29d6KsUQqb18Hm9z6PyibSUZqRV6mbXJhbCPp2+msfHWfEf5uZA7DfdOfJ1wNsywU
	 47OJhG/YoqqxjXGopnViuXLdwye/ATucfryrb8BpfZOEEkAu7uCl8tcxBpUTC9Rjc0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	b=niowNeU4C3IZwOj5zCVsRtMwHm+5KkW3FEN8qvLUdvyPOcsSU1zDIi5rR41gALNxtqKj
	 o4aBj+kU/Xzj8aU5fOomLtIsnoHHO5gteRu5g5pYwq+dpMDBp/2lLqtPLQ2bM/pOYDFZt
	 8TiT96+ctzEv6JlnpHaN8nZj8G1X4Ok/TQrMzx55dIq5cyKB+XQofgiOFZVXZ4sdk4NIP
	 44deBGxpyIvOBnSZewOegZssyEgNTkGTfnvfYtO8oEsOBTvgop5ofBFZbYQ2tsGrkaQZv
	 zXEDw1//SULjZJ4dyy6p1ISFZbTjF9FKGxNhRLRTRGskeDHbRp+mw/jwMYAZa4gbtmQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198935;
	bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yqf8WbN+V2HtobVARHWtBptSV5po6i4C5Q3GGtdPNur1RjIigsDqb7/qhGaaZ0Hj3
	 eQGubvE0iXJVgTmvQRbnkHJ1YZUo240LHdTg9zvMGz3oz4AtK/4EDgWSVk7MpCYKmA
	 zACUPCsYaeRAUVRY7IK2v5ebDd/8dCYgzFwsVPeIEUwK3pfGUPj0nD1t0/WOBTfp5e
	 6fZuRiQmwISautYITKg9fp7EKMs4ZKCahYI9Pk59imDzNtQDahhmISTQ4IU9vLd3bR
	 SlW/GKtat7EzNRIFw1nJsjVURreA4G+TE6QU1upe/FwfNcZGbYdUp7uqz8FEqaITCv
	 CNBH8n5xHtjIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A305F408CC;
	Wed, 28 Oct 2026 14:48:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5CCE972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B79E84009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k1uhY3S0Q05m for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B27314008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197112;
 b=SUehupSljcBXlwH1L8y3rR6ei713QDqyWp07btxqgRtlsLF3Kg8GF/eRT3Dmv/0k8ozj
 wdwPloJwR1ERylPQtLVqY5r4dCR+5t5kvRWgtT2EQw8VcDC+RXbA4kCDDiIjakGtRa82s
 d08+f1O8u7U8UKusfyvgszhY8P4b/KKKss4FKeTnuKef6brBF3Hl2EjHo/GWSmKU5+Gmo
 MDpFx+58UFV/IX9+T9yTzI3kO54t0z84oXpnjDveB/ekK4s4AzjA5Yx+HPld9U8+4iTJj
 YgH/RBmnZ+TxIt1vvIJaCGpl2/DouVAMHIPdzrh6kCPLKQ/6O8MF3kHmSH8bJOi+cIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197112;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=hYg+dFu1ZqHgSSezIL9U2bbTPAdwC3FZ4r0nQ7qY7BqzVxixWV/8CXuwQlVEJaGZILow
 R1A5n/tjBqqzPChXPce10VfqADy1I67/kHGk4U792gUgJD/R87SVTUHDgrddP4FyxzoPN
 T6uWvPClwz/5Ew7wR+V/LagjdqGdNQK9o2XZ3kMmUi5ucd8BINoWSGmsZF/BhlFQpX0I7
 p3AjGEbvGlM/gQZAq6A/lIeMnir8j6JSlVZZAxj2D6dUvIDt1ZI+vtAtD9WBBnNq2uWXy
 wt8zWLXUI9CSOL/a0tNL0wEYfcv6IEji9/jrRCyHlUPnwoTCuz9B86Rc2m9Dl3aLdZA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=I+xWP23O; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=I+xWP23O
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B27314008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:18:29 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6acbaec0d70so184638a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197107; x=1793801907;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=I+xWP23OsnJ1ERIgj//B3wsDNtglIMIt9hILUvRJsv9wUv+07jEVkIXQXYmCuZHmM3
 Pdw2TZrShMGuY7/ErTzfuzA65IbURy/9pYBo+ALISXrTXT1o6tdvtc1LfZNRYSAEh0y+
 klp4oXwUKjWkw9Db+sgHGxZ49V/R7QGaHf3ZA7U6YkjOD68Nv7gBLKmNvwN89Dwf1WkS
 rN1ppvaxCUgE7+jM+q7EfBCTaJDMICrEiQPZHRbmoLNEa8UDyUYv/mif+nX/31Gyngx5
 b08GRM5gCvOVWyG28CR2pdGf1aue8oly1F01h/MBd54GiKgLipTA7KINhGh4k1lNsMtM
 28PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197107; x=1793801907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2fG+2YF3dG0VQRcJzXYrmseRICyePMR1BhvbD5VTzBA=;
 b=yWrHfRLCcmafdW8x4LD0KKIBGT36rg+QboS2wvz2bqP/djykZiqKuySuWlpBLGbKcv
 d/hmUVPiO+4rboxBEfr9eDgPfXoz9xHM1aV51jMNrotdXhSNB34rEauh31hbi3C5VCUR
 RzxrOggUKPFkqfy9RMwV3tdmBFMqOc9xZC+F4Na3Xv5NBxtwbSvvnjrVuAux//w04M+n
 iNGDaETnMWNDwlk+8y1pP4X2XDvCLVXnrIh/1i7UcSqFJSBfTwBTVlIxGff17yHMDbqe
 6B3okSfzV2n4ZJwaRh55pA9294RD6eSD7xiW12abeTzwGVHVQvqRDYgX8vrTWK9O5936
 Um9w==
X-Gm-Message-State: AFq9FYLkLNy5yM15dGh9bdPJaTdG4ExToEGjBQ3EhHSkbgIyfRfObr3I
 tJaxRfoK2xFVJNvWsvipPAPQ8W/qVBu2DRRdlNW6Tl4jjYCrfB2Ytz/7ThZmH/VO+xdY0mbySsv
 awf7z
X-Gm-Gg: AYBFou311cvfLV2B/PAP9stGAkSh9E660XzfEz5wFM/edWvzjgOd9ApSAEgKkcdDhbE
 M2vHpRBDrll61HbU5zsuDg3JQj+7ouHgKubiTHO5+yy1oFxL5RaAFOKtTYLR2prGGHMz71uU09o
 ILNY9lnXyOmcdMT9Uv+S//CfdxYh5vA12ywgopX8ywOaDY2IdK39wWr2qg78iDx65T0C10oV6JB
 ipKo8KP/XHDVz1RLbQTCYg/g5H0Wts17D/z0ScicEteb8OMBwAV4IclTv96gUUZS5+b0Pi1gyV+
 7O5Pu02Ps0u11cM0jWElDW0v9V5fju69e+X1c2bgJxs8xjNufvfAliACEPFKsxm/Yg6kmLrcn5S
 HPG/8HznGMB2IQoI/0hpi+sTUs4NWnr+/XkaxjJcRcOqoEGQsCYr1pREbg/NJ8XrV+mFLk1TYl8
 APMK53MITdupPLwxhqxUx23b5jvP4rF/mtrgd2JhcpnM4zUQt2J53/QO71GQH3kSiq3LV59PoQa
 w6q+ctSGTRLoqrPMyCXrYvsikv8XJy+sFRAUPr7Z7yIMkGiJabq+8K95wrZFuBs86CSZVmADoxV
 IcC38ke/E1jXu9t7nWfivySYK8v4AyvLBDgvD6M586DAqFCoTjJAXAwCiOdOCmS/54JJP/uGq4e
 XXGPMWEO65g==
X-Received: by 2002:a05:6402:a0da:10b0:6b4:2f4:fc49 with SMTP id
 4fb4d7f45d1cf-6b49cabce72mr2162734a12.0.1793197107558; 
 Wed, 28 Oct 2026 07:18:27 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b497ff5fddsm1466213a12.2.2026.10.28.07.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:18:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 30/30] usb: dwc3: enable SUSPHY again after xhci is
 registered
Date: Wed, 28 Oct 2026 15:15:54 +0100
Message-ID: <20261028141554.3073545-31-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced core clears SUSPHY when it switches a DRD controller to
host mode. Linux sets it again in dwc3_xhci_plat_start(), but U-Boot
has no such hook and the bit stays off. The old code never cleared it.

Enable SUSPHY in the generic and layerscape host probe after
xhci_register(). That is a bit later than Linux. It is still before
any device is enumerated.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c    | 8 ++++++--
 drivers/usb/dwc3/dwc3-layerscape.c | 8 +++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2406f8446179..cd4170bcb817 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -278,10 +278,14 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
 
 	rc = xhci_register(dev, hccr, hcor);
-	if (rc)
+	if (rc) {
 		regulator_set_enable_if_allowed(priv->vbus_supply, false);
+		return rc;
+	}
 
-	return rc;
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_generic_host_remove(struct udevice *dev)
diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dwc3-layerscape.c
index 108b44c67eb0..afa31c48be6c 100644
--- a/drivers/usb/dwc3/dwc3-layerscape.c
+++ b/drivers/usb/dwc3/dwc3-layerscape.c
@@ -153,7 +153,13 @@ static int dwc3_layerscape_host_probe(struct udevice *dev)
 	hccr = priv->gen_priv.base;
 	hcor = priv->gen_priv.base + HC_LENGTH(xhci_readl(&hccr->cr_capbase));
 
-	return xhci_register(dev, hccr, hcor);
+	rc = xhci_register(dev, hccr, hcor);
+	if (rc)
+		return rc;
+
+	dwc3_enable_susphy(&priv->gen_priv.dwc3, true);
+
+	return 0;
 }
 
 static int dwc3_layerscape_host_remove(struct udevice *dev)
-- 
2.53.0

