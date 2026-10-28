Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9556606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VqZ98xA+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EwMfsBep
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEFD980F91;
	Wed, 28 Oct 2026 14:47:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIC1LCMb5NjQ; Wed, 28 Oct 2026 14:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F39B9810CD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198803;
	b=PCxBUFM0riohamClXEIQdn4KTOj3gtyA8bafWyuuhRsT/RUQLWLXClgJeC8ffvaudeaV
	 CQ6pvDOFyBhgSYJiVBVEJVp/GM17ljpxk7d7A5jJLM6JAnOvsCMC/GxGcvO+L5CPAJ/6X
	 7I8RjUJ4E8V0H0V2ZvWUFxgAEhjb/q0OUVdegX2l1AHWBzKzX59UCwDuAOsBeR/KWzfH7
	 lQERa+qvgxVTlRIBkLrgCHu+DTQQObtlU+3qAYQifRkaPodkijLoK8DfxeE95XdcxRIVA
	 FVP6+PlK7cg645OkHWS0r8Z0crPgmZfMZWo2VnYa8WuiuRYcEoKqAkVVLjWh0lSFFfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/KFNr8DKTP66lbcycGlalqZwtlVGRomEuOkj6qwfZXU=;
	b=Z2qlzIpUVQbkq830ORDnbmuPKhVs5ze97nTjqKFGMLVxqS4Z5zfT0e9U3ChzgbtoSI1x
	 wyRh0v+xUeYrgIKTZOABV//8SYAkBRIWKIOyvtDkHvOetyRVmlVcKFYMPS5D4lI+mkMNP
	 yjXtMqhknkKD2FA5S4m2dFa9qxT31jkzLeN6IvdmEnmVYf6JtR3TkisQsieQS7cfsj9Cm
	 ZOMh06SO2XmRayadpGQZVGYN24g4k81ZVgPGwIGbOo+7VsWV+WIAchCWmfAshjN/J18j+
	 mamIg9ZPEeV6E7eiK1gERj5a6EHGCAm9Ro/CQ7FYRXLueUyCJQZNMHe+sqTpllALctA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198803;
	bh=/KFNr8DKTP66lbcycGlalqZwtlVGRomEuOkj6qwfZXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqZ98xA+CFt5hWUqWG/rRCnsTQb/7DCdBN958bpHSHZJd95Esq0NOEqia76cvnjuD
	 GyGT1nkAh45lfts/+6LLTvd4boz4rY7DonzMDOUh78eCGPljyuc/1Ep0A81OKQHsUj
	 c+LEE59gQqWAP3hh2gcB5JR8SLxUtpJatgf4tlBSdQlXTLlL0XM6WewslHv+yFT7WU
	 OgzSanlTfh63A6VrLYuimI8XlA21RmfSOKyEZwztoSFQJbrqSe5q75OW8nxnmsK81H
	 N+5Q+O2R0Rq5Ad5RtOMTIWsvtXwyNRSxqH4GZha9D2T8gufs/I0DJa4ZMSjvJE8Nt8
	 pyNEhnnQuA1AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F39B9810CD;
	Wed, 28 Oct 2026 14:46:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E628C972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D82D9605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9gpKps6pO_C for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3AC56060A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196708;
 b=DZazdGkkke1Q2yO34EwawotxYN6WLukM6LphScBdrxJ0CHj2mb/JrVvxdifL0TM/cXoF
 /bWBFu8Ubeod1J8A/ys4cxa/nCciNL2Ciph98bLgyzEskGZGb+mPw8AZjahEYwoW4Blbg
 IWzbnX2sRTQdIGJsd555Po0W2+yg2nILHJhALzY1tjy4JtrQ7NsmG0dJ4prv7bLKg4i/m
 gSHboUQ7KwQACFGuHvUqrcd6vg0avp2J01DwcbeQ9ILOsml3quLgAWiB8W4zbB20V3vO9
 MyKSDd7fTDoupzHUvAIanzpdg3CUjNaKGEbXMuPOdeD+xu9B5D889vFuqa8TuvtuvvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/KFNr8DKTP66lbcycGlalqZwtlVGRomEuOkj6qwfZXU=;
 b=Hxgb0f/fFATMtC9VkCRWoXfgbMnggoL2ae8xqSyp2y7PQMzRFAZRHNLVlCjsE4MLuUNO
 aMIpDHgRyQwlINIGrX70BqHeYvgn/Y94Lb9iGBOtKIe+6iVIZUfMq5eji1r8wvt4TN1um
 Rzx8zlwDV/hEGzdWH46tkZO99d/pmUUkyubgFWABUPmJ52PX/jlG4az46Bk5exso1co5z
 9NwY8ATeD/GnLixF+2o30UcXM60TO0jvTU5gfGXCMnOR30Q1UJtyQhOROhwoknLZkp/SO
 X9b+bfEUj9mce8XJpnO0yJeyqiCRb5KPBhka8I7y3xv9P1C2CpdVBsLgj2VQFci3vBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EwMfsBep; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EwMfsBep
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3AC56060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:47 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c38ac078440so11781066b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196705; x=1793801505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/KFNr8DKTP66lbcycGlalqZwtlVGRomEuOkj6qwfZXU=;
 b=EwMfsBepZutmg0yJzpmIwRYZl0drPdrQGKyLijeMKiQsBXAp2lFYYJ6sg3HHjCmXhc
 CJ4M6QgLNKnoLG2PI0LQvT7vkTOv0fgIJ1KE47+NruzG/M6j+hUf61/bPUOhy9NeAt9c
 ChBsGnt1zQEa82n2QBDc9u2XXY7WBxilHiq9i0tDVBZsYmu8vA0gH8sAOftYZo7lewKh
 goFGUos/WydwDRCr9gEubdRvtsbMQ7U703V3HbZubyqXd3M7uP9D0js+gVCfxG3SyBL3
 i6GB0wW8kYq2rf2bqt9S7Lpf0ArIyGwbtMqV3gzo3QWKFYtUQPapntKe/HDFXtjhmyfL
 LxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196705; x=1793801505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/KFNr8DKTP66lbcycGlalqZwtlVGRomEuOkj6qwfZXU=;
 b=DtlEZJPi7BSI1InamZwltVrBeiBXqitGZlzcHzd4GgEnMpHa+lf9i5puUMx8p+1TJA
 aAaKYnw8SeWFx5oadXzY6bVQDpt3HFqm23O0RvPdIyWx+S0TgLIHpS7dYSKet8zcgWWr
 7WCaGk/HGn8ucxY+qUqVdtygZEr+mZQ7BEIvQGpQ8mqr63gBm+l8GEPiQ8HyA47jRinw
 9q+eOAuLz5tNkonPhrXe/FRTiDTi15JmoX3fI5FzBlpUPLsRgjU6zafxaTkDqDE/nMeQ
 yAA82zXTcs9VURxP/0mmP5iUaF/FGGNGlI8I+GZEaoFQ/cMx8ORThnGGObBw2lmIBCpM
 5R5g==
X-Gm-Message-State: AFq9FYJ+XgJ+sqt6MVSZa5Y8kphCHSt1MoH3ZfSfoX8kuCMmsuEky8uD
 3b6l1+lpyaevSyr+Nc1Ctb6RGXNHRUXoMW628tSDkpBHk+NDomPGEpqBXKcCSUnjgsRQ0a9S1ge
 LjakD
X-Gm-Gg: AYBFou1QvNRkVOSVQcPUP5v7BoDxMNEp829/lbP1loU0kU9sHYpX9w99cFZpzGS71Ek
 0Fd/I/HHnSLBK+SSs0iv7ieBaSdoloVnpUiYBpWFCUBBUkq3mPisaLSSxP+LHyA0vzjrBB4MpE+
 ClZG3Av18Gz0+Kc5lOVzBL+jl6/W5/26J8VMzcBX4fmmXanQgTMcovnc0S/GiXz95loX4/4XMrj
 ax+AJPg2Erw+Q5ftVxCW0aWWXfpOduxZ1ZgBdWyYZh9F0j6lX6atQlLH1ASSjP7q66QR8jIfsl8
 xivzeaADsE6rtIRnxjIYqWC3XwU+W3Iu/DjOl/gz9p8ZI08LV38h5+E/CXT/Ujg2tqKpeVZkHh9
 j2W2voVIa80y5aO9SK4xAe+pSlpvgOpc+XJSGEOyN6gtWcE64cBBmzCWPt0/EN1brPVwp8VucTO
 kya70HfQM+zowS930ri2i2B/bWazr9PbqC3AkEhemY1nZ1AJpwmMJKdvDXkQme/Tg9dLWyemnpA
 KuLJDjb+ufp76XGSo3cr01/vtk/1gKhCbrnMcV4gVpPCSth8ZTC+zhg8Mx4CUCcRi8kVmnn1uAW
 +4e1MSaOpY/XqsG5lCR9/fRNjLmSK89Af6wicrCyy/59O08KVxvcZRcbtEhxVz9o9dgYkLZQ5sU
 n7hEr96y5rA==
X-Received: by 2002:a17:907:da10:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c49bda96afamr288413666b.0.1793196705164; 
 Wed, 28 Oct 2026 07:11:45 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:44 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 27/63] usb: dwc3: import from kernel v5.2
Date: Wed, 28 Oct 2026 15:08:53 +0100
Message-ID: <20261028140930.3025368-28-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.1 to v5.2.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.1..v5.2
Commits imported:
2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
b873e2d0ea1e usb: dwc3: Do core validation early on probe
c729969b2b69 usb: dwc3: gadget: Set lpm_capable
41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
75ecb9dd56a7 usb: dwc3: Free resource immediately after use

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 18 +++++++++++-------
 drivers/usb/dwc3/core.h   |  3 +--
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c |  5 ++---
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f90261..4aff1d8dbc4f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -828,6 +828,7 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	ret = device_property_read_u32_array(dev,
 			"snps,incr-burst-type-adjustment", vals, ntype);
 	if (ret) {
+		kfree(vals);
 		dev_err(dev, "Error to get property\n");
 		return;
 	}
@@ -846,6 +847,8 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 		incrx_mode = INCRX_BURST_MODE;
 	}
 
+	kfree(vals);
+
 	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
 	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
 	if (incrx_mode)
@@ -893,12 +896,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	u32			reg;
 	int			ret;
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err0;
-	}
-
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
 	 * out which kernel version a bug was found.
@@ -1218,7 +1215,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_max_burst_prd;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;
@@ -1426,6 +1423,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		return -ENODEV;
+	}
+
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1600,6 +1602,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -1632,6 +1635,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
 			spin_unlock_irqrestore(&dwc->lock, flags);
+			synchronize_irq(dwc->irq_gadget);
 		}
 
 		dwc3_otg_exit(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1528d395b156..f19cbeb01087 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -406,8 +406,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
-#define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
+#define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
 #define DWC3_DCTL_L1_HIBER_EN		BIT(18)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 6759a7efd8d5..068259fdfb0c 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -250,6 +250,9 @@ static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
 		size_t size)
 {
 	switch (t & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "Get Device Status(Length = %d)", l);
+		break;
 	case USB_RECIP_INTERFACE:
 		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
 				i, l);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e293400cc6e9..d67655384eb2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2863,7 +2863,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
-			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
+			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
 
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	} else {
@@ -3301,6 +3301,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
+	dwc->gadget.lpm_capable		= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3384,8 +3385,6 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
-	synchronize_irq(dwc->irq_gadget);
-
 	return 0;
 }
 
-- 
2.53.0

