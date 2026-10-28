Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D964606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uy384qQg;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YtongRUy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 389A5405E6;
	Wed, 28 Oct 2026 14:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NREQuYNFnWUs; Wed, 28 Oct 2026 14:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 801AD40743
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198794;
	b=cImwF4WsgFIjR8jV+TTm7bUVqUymd+f74fqd3T8IFw6EIhbjPcq4beAFbaceUI9zn7B6
	 Pt2ZHI15HDP9B3yke67RDFpu8SyvrQDPwh/X5JvAzexHJu57DZ7Dqc5l7bTG6hY+7CMsS
	 m+iUobQaPquAIRDV7KZhGOte+M7GPNYe7i9mBvhWfQtU0mAlyFoRkNyiUqgzggXTNLnmh
	 HL13Lyt0c6xXylgGNDnoMOYr77Uc/pr6W8ddwKhvmCY+lY2YwQ2COBJxH6q5Z/+XK1ySR
	 bvLsE1mHMEHRHLRz9UPrAbruwz2NIFI395X9CLYUOO+a8+/Fxx0TLXXk+IdxhVUa/FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
	b=jhYwX4rS7W5gDCo/grCkUx8UgHbZM8akpu8Z07k0z5KKtma5OCOiFgugmWlj1zrwZ3ia
	 EX3qqq57yOYOe/jprDTDLR5uFHUnBdNNQKlqRpoSSmlLMmELgCORk9d7pk/SGMk4FzlbH
	 Kri/7kRbIGlKCvJZH9VP+Fi5HhhU8HfewPa8uKSkJa6dpxuJiW41brJo9P/+eiNGoMQ+x
	 epjqHb+lx+e5tbKvgsV2LaMMFrjfKFLmbCmaSTmOaAtaovy4ahwTd1vvNCF4pusu3sPmy
	 SSfdAfoKqdP/AIivsaVMmXg4Nhy8bwvGhcuOlpDJfxX8eM/8A3uTlZDPfoxLhec600w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YtongRUy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198794;
	bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uy384qQgszorRTmiJwsAbd3XZYQ9IhDj87Bh8BoK9/7ZmBTw4/MbRo67r9L/D/27Z
	 xGxW8NeTW3CrFf6TKoL5byvpu7Rcxhql8svAyVLPZEZvzgJ8cM1J3TvcK6nVNP2BFo
	 kYBS6vrAes7YQHLespPU4T0mCq7GfqSYcCaQ0G3wE8VSdWwP6RE18XdKohX5+DnIO2
	 op1Vm9l2aYS8U8A4FYB+mJRtAXV8vdTdnZSobjLu9xhm8JZPuAqLLhknh1/gICMPFu
	 jemRsaw7/9Kc8eqrR9Keg6mUTqDoU5PuunGzmen1/8HJZqOEPNmDLpdiIWCKwtUEaT
	 luWSWRfORQGng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 801AD40743;
	Wed, 28 Oct 2026 14:46:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B3C5356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81D04404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVM_y6LwEZ9F for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 453DC40562
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196704;
 b=eQjlOWnFzEn5fZGZQSD/GhHUO0p+fWYX8+2hJBhZwFTyEK2gFXWyNqXphIqF1uTiT58v
 31Z4x82Jp900Ao33a8TMUDn9c+QSoMBwODn1mZdBTiDyB9fji0qiieX12s7pbMSx2SI6l
 Ri6QWOZg7YOcttfEyGSIykcoLv9QNdHEnrSrYiPW21cuc3iHqK2x0oNcwSK6vn1XGIvr3
 XkI7VRmThkdRzhUrdAxoCiHtdBcGKd1PcPaceSIqfiXvdr8WARxQGyWKeNNELRUxMOcvC
 lEGxnfKTX6Elyp6EHxfAp2GMeNkZtaWo8+q8EIZaXQOuntSQHs5+q0lQtGNeII50X2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196704;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
 b=c2+8/x7L3UfRTurZnAwW8zhh0KXYkQKm9jhBWbgkB3q97nxIsduM4O7RhX375C3cLczL
 qglk0SK0TaAzkFiMlNuE/G1RlWimYvRQ32DwqbgEumhYy2EKzzM1jYNsW3e9mHNKVoE1i
 4Y7iralRTOpJF9Tdjhh9iRr1M9b4GsAj8sjiucyY0cW0ZE6sH1u7yciBwyqZXTUf94OhB
 Ar5EGMY4GMaXWnifqsiUwdwI/ubpTd0w4a8Em9aLR1vqCiu4f74jen4CX5l68XrtsaN7V
 qhuZNzo95v2WyE7Yj8A53zlqWwmCHQpak2nuyHiPQeLe8XjK/47B1yWDNybdgEx9mnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YtongRUy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YtongRUy
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 453DC40562
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:43 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16150666b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196702; x=1793801502;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
 b=YtongRUyRTka/jN4RyFtx9xPtlcXQbNPWW7aYtPHge0/TzA9zEatuSmGBW/lBv7i1i
 Bm/8tilbxqz4/YH80CNtCJ0RuZcXbAisTYGgckpEwElUPMv8pwTAqXP/u37lvVeDIPPw
 63tA8SfGWOzo/ZBnGStwowe4ylzXLdoznkHGrQmesv8mw6tLA+8MhBEIneHrPZtCzX7n
 UITYGQzGBzo81V74DdTTOVOLYmV7p0FUOpDsbvlD7Yh5SE0+VjfGPXrdLOISUYn0OaYq
 YPmfrzeBYj73S0J+33U5ZK4MmF4YvgJXE6r2zMHajwP1GQfLp8ujSD8OT4Vi51CWausk
 v1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196702; x=1793801502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94u2O8R33+hTEnslRsTieLzpOaCQn1VloGZwwVbF7Lg=;
 b=JOVpArpV3ipUWDWApwXfPObj7vUgJskh6YfbNwTUWGcX7ZVGkyq51nCXv7RjhCo0K+
 akZIeOhAobcb6aeb8EQLw4BIJOpmbeIEgoWOiborM9sRoth/OCKcMAk5uowXmpI1mh0E
 X8tKpgQ/M99k1ELmX0uA09xvOtsTEDkrl3zKVSm19Hq561x00k7VzV8+lv49uGWbdZSp
 FrwvFK+duWtQAGSRvgmGar9pQr3aRaYSz0vNN8E+8OSzIBPmqmNrx/RjuNdQBoqHXLtG
 F12jE8ig3eVRjlHjsVmMxpoJmxi/ogXGkQvOEHOii+xYZg1dU9MTSmoeRmwHce6J7JvL
 Dm+Q==
X-Gm-Message-State: AFq9FYIQPsk8p8yKmu1RRB2HvGrGw/AVwVu/n3skbaZ5+vOq20DH/hiL
 J+ySBnKVJEblw3EhARTw7W+D7lUSRiJ6admc9/m+3PQuoF3TYcQ6uEGIg5XV/oht9YUCayohlns
 hDc70
X-Gm-Gg: AYBFou3l3IvTn9/vepV+rbuXnrhyVKX1A1Gho/pv9Ncm+N47lMrcvdiC1JcdRRYIHzY
 9pA0Qh9aB2XLqsQSXSjNVTWfQKaQ2KTlrNA+3X+ioDseQSkYND+sGwZBD9BKjAEUrYtb+MSIerM
 q+Zs7B416JHMx0ITuF0DSfY8m9ur7l7dZD8CJ/GNYtPMzrZEKg3LtFSvvTigNJi5OeR8PZ4Mnfv
 5k8r0rrexv2NaYk64heG297t41IT3wv/4zyU8L1ZqlRUM8bws4icuPygXqwGASAhWrD1B4tqwaE
 AIlcbCzFfRRZIAsSc/zQuXk4edlA7yATVS0Zmi3Ee9YNcodmLQP04A8EYmTWgmYYSm7asrtGU6G
 f5ru3pFp8hKp/kIkw0jErXxs3q02Dyt0A0dovGK0g/aVH62nXFBhEeTCzbHWQC00MJLP5+X9d8r
 ycfg8h4zzF89hCGq7AA44vE/ts0WhZPqEnMXUjJzaJW86mALqgWorOkV4/mWZgpvQkBgko9/8o9
 EdwFFwI383LRuobWsbn08oUxSsUlYeL+LYN08gCfXaL5AqlsDL0yKVmtrmIc9PvZDtUPpR6VjdO
 lEL43LA9REIXgeB2ApV2mUoX4Xot15mIptX/9pLfuOnlwPMacXmj4X2jIvETD8mewJqk6u6MuMZ
 IectdiPeU9/gCoQY7igdQcoSzZHBLf4o=
X-Received: by 2002:a17:906:c006:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c49bdf3daf6mr226957966b.4.1793196701795; 
 Wed, 28 Oct 2026 07:11:41 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 23/63] usb: dwc3: import from kernel v4.19
Date: Wed, 28 Oct 2026 15:08:49 +0100
Message-ID: <20261028140930.3025368-24-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.18 to v4.19.

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

List of commits: git log --oneline v4.18..v4.19
Commits imported:
4e3121abcf53 usb/dwc3/gadget: fix kernel-doc parameter warning
4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSize from descriptor
b138e23d3dff usb: dwc3: core: Enable AutoRetry feature in the controller
a77004681148 usb: dwc3: Set default mode for dwc_usb31
d9612c2f0449 usb: dwc3: Enable undefined length INCR burst type
d635db5508b0 usb: dwc3: add global soc bus configuration reg0
9a7faac36502 usb: dwc3: change stream event enable bit back to 13
db9fc500e85a usb: dwc3: gadget: remove redundant variable maxpacket

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h   |  17 ++++++
 drivers/usb/dwc3/gadget.c |   3 +-
 drivers/usb/dwc3/gadget.h |   2 +-
 4 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 103807587dc6..88c80fcc39f5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -78,6 +78,14 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 			mode = USB_DR_MODE_HOST;
 		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
 			mode = USB_DR_MODE_PERIPHERAL;
+
+		/*
+		 * dwc_usb31 does not support OTG mode. If the controller
+		 * supports DRD but the dr_mode is not specified or set to OTG,
+		 * then set the mode to peripheral.
+		 */
+		if (mode == USB_DR_MODE_OTG && dwc3_is_usb31(dwc))
+			mode = USB_DR_MODE_PERIPHERAL;
 	}
 
 	if (mode != dwc->dr_mode) {
@@ -778,6 +786,98 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
+/* set global incr burst type configuration registers */
+static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	/* incrx_mode : for INCR burst type. */
+	bool incrx_mode;
+	/* incrx_size : for size of INCRX burst. */
+	u32 incrx_size;
+	u32 *vals;
+	u32 cfg;
+	int ntype;
+	int ret;
+	int i;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	ntype = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", NULL, 0);
+	if (ntype <= 0)
+		return;
+
+	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+	if (!vals) {
+		dev_err(dev, "Error to get memory\n");
+		return;
+	}
+
+	/* Get INCR burst type, and parse it */
+	ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+	if (ret) {
+		dev_err(dev, "Error to get property\n");
+		return;
+	}
+
+	incrx_size = *vals;
+
+	if (ntype > 1) {
+		/* INCRX (undefined length) burst mode */
+		incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		for (i = 1; i < ntype; i++) {
+			if (vals[i] > incrx_size)
+				incrx_size = vals[i];
+		}
+	} else {
+		/* INCRX burst mode */
+		incrx_mode = INCRX_BURST_MODE;
+	}
+
+	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+	if (incrx_mode)
+		cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+	switch (incrx_size) {
+	case 256:
+		cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+		break;
+	case 128:
+		cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+		break;
+	case 64:
+		cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+		break;
+	case 32:
+		cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+		break;
+	case 16:
+		cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+		break;
+	case 8:
+		cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+		break;
+	case 4:
+		cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+		break;
+	case 1:
+		break;
+	default:
+		dev_err(dev, "Invalid property\n");
+		break;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -840,6 +940,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	dwc3_set_incr_burst_type(dwc);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
@@ -883,6 +985,22 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/*
+		 * Enable Auto retry Feature to make the controller operating in
+		 * Host mode on seeing transaction errors(CRC errors or internal
+		 * overrun scenerios) on IN transfers to reply to the device
+		 * with a non-terminating retry ACK (i.e, an ACK transcation
+		 * packet with Retry=1 & Nump != 0)
+		 */
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0ef3b91..5bfb62533e0f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -163,6 +163,17 @@
 
 /* Bit fields */
 
+/* Global SoC Bus Configuration INCRx Register 0 */
+#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
+#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
+#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
+#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
+#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
+#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
+#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
+#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
+#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
@@ -227,6 +238,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
+/* Global User Control Register */
+#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
@@ -1157,6 +1171,9 @@ struct dwc3 {
 	u16			imod_interval;
 };
 
+#define INCRX_BURST_MODE 0
+#define INCRX_UNDEF_LENGTH_BURST_MODE 1
+
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 69bf137aab37..2b53194081ba 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -473,7 +473,6 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 
 /**
  * dwc3_gadget_start_config - configure ep resources
- * @dwc: pointer to our controller context structure
  * @dep: endpoint that is being enabled
  *
  * Issue a %DWC3_DEPCMD_DEPSTARTCFG command to @dep. After the command's
@@ -1121,7 +1120,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else if (req->request.zero && req->request.length &&
-		   (IS_ALIGNED(req->request.length,dep->endpoint.maxpacket))) {
+		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index db610c56f1d6..2aacd1afd9ff 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -25,7 +25,7 @@ struct dwc3;
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	BIT(9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
-#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(12)
+#define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
-- 
2.53.0

