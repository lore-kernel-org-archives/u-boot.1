Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9224C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2227C81218;
	Mon, 24 Aug 2026 16:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0CfxwRDDexy; Mon, 24 Aug 2026 16:47:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589954;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HyxOYU9MmUTKs4oeyUlLcbj3ChE1A04DbGPMpoB6+hLwNYwf+aKuu18jNIf/siddC
	 48yZcM7RkAhYv72fZxwIDcAWZq+cLJXrn/BmBsQNcjeXSo31IJHkwSqVmPiUsqmM+a
	 nhG/AqLi3ZhUEK03djtVXfcvd/P/r2CQC2DSG60dBlZi+qOyXyAY/skJOy4xRoYzzT
	 80oST8ZU2llZE0ld0s3xJY4oZIQsdcHY0P4y72DPFLMR2SCTxm3AKv9VFDmWDmcOa+
	 m+Nx4dASTY45RIYfhroXyC0SWz64EE6Pf2B0wxmy9awqVrULbnPrs06orWttry69Ui
	 p42QU4wIXyUVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42C0180F03;
	Mon, 24 Aug 2026 16:45:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0A429B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72308605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fjj4OdEq69aX for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Jri7fL/L
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21CA560627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:16 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c2193c18362so46599766b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586194; x=1788190994;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=Jri7fL/L9EuauuCcHUsGYmt/2ESZew3kzARRCWfYsYkKnu8cSSkE3G3+m8tBjPmfch
 7kt7k4/nVU9NGtpiTPxjPjL7JUBBdTbGYbVF139duEZH1IxWx58a3tHbplHtrQpIbci5
 Vxtrm1u/w1LwtdyNGXRqxiuiB0vW8dMai2wJNMar+zHDwCqCRdRujzkrTmz/8fs9PqRS
 Du49goh1X0WtgddtU8dLzgBliIFYTlC6XycBelL3uNzkKpQjDnqlSOlPa3oq0/qL7q3e
 zDVDUxeFVTLSnafEpkpEMyzcMCk/r5HhFwNPD8Co2giy358yTlsLPK5Q348MCqEGlpkQ
 0JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586194; x=1788190994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=AvPDdkESlKGt9urmyPnlVT1Nvq99susb/WH9JPE9I7VopH3yXboj8o5sOF/xWS4RwN
 GZI3CePYFPFfZaiyNcSX+6KaszA0Drx5HG7NaHBzl+5+u44kJN59r/YyHdfnKDt5kodg
 YTzP5usFaC6VTBYS5Yjm6BMMiRdLu11O9gPvzW24KIaIbHud6oU6Uu1uUTY8Dj1WcI1D
 UTHNaaP26GdM7a9ZXajwRr71QV9sy3vAFlulsoLHjN+xJKVcWwqBnfKNt0b85o54s/3P
 hMMYt/4GsdFZTSRnBAToQ1cRa3RKm6hzfnY9RjSdjfMuWqmqjUA0EOou2Jw0l86MLo7/
 FFQg==
X-Gm-Message-State: AFuF++le20pQUbXMhXkBMNS+hEQtbr1A2BgVHA4CIVjkvHz//Xuszv6V
 BJTjKCD9CgyJO0KC6QrY0CrScTQXCSudqKbyEJQJx3S/lr6ZYz5ao9P8sN5+tWQsao9V4PGPq1G
 kBvkD
X-Gm-Gg: AR+sD1248jqxRizAT5ENDU1fxIxr7aioJvc4Gp+f5PVDj06Qtm+/3pTxP4XOxU+kPx+
 huGKdNG3GmG1NtyLcO7RoZdYqxYTIvhz7qihfRgvBvWwkBn04bgRwSRDDhhRihRfn84gI8mJiZ+
 vqvCcyiF6jo/rAQO9ejoPm5nXvg8sx46Bih05SCvqQ/Ol5xz4RsAYWCx2/nSn+alf+GYNxJzbu7
 KiTCRRNUDxHHzUEHTKHfiqQ39tNzp7ObjEwe+njrk1/4YViBW7D8D46C6hg8PWrZXS+mmZ34gYp
 NmJgqRmSU04MfH4c5pojCXS6qLdyhoMluYtbAoHZz+cIlnzB/urhB7fDWo91U4Te4W/bFPDJzCB
 hw70m1GslJC0tDz/eR1WUxsq9AKcIyZ/TMKoVVlxqvExRvLefo0hWFEynWBWWkgowUvjCnKNVOh
 UsUceonAldP6OgVvREbwop4U2jRjlBrYpozCsjvLk/7JMSYYMueMKmG85K/eBtHVp9qsw+tKY90
 E7/cnXBS9gC39/k4gBIrQ==
X-Received: by 2002:a17:906:478f:b0:c1f:4754:d87b with SMTP id
 a640c23a62f3a-c246a2efde0mr1611854766b.1.1787586194490; 
 Mon, 24 Aug 2026 08:43:14 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 18/24] usb: gadget: at91_udc: set endpoint capabilities
Date: Mon, 24 Aug 2026 17:41:27 +0200
Message-ID: <20260824154133.217744-19-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. at91_udc never fills caps in, so usb_ep_autoconfig() finds no
endpoint after the resync. Same problem dwc2 had, fixed in commit
c5c4cc4c6b98 ("usb: gadget: dwc2: Set endpoint capabilities via .caps
field").

Move the endpoint names into a table together with their capabilities,
the way the kernel driver does it, and copy the caps into the endpoint.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index ee2af2d699ff..a8ca22c906c6 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -51,15 +51,23 @@
 #define	DRIVER_VERSION	"3 May 2006"
 
 static const char driver_name [] = "at91_udc";
-static const char * const ep_names[] = {
-	"ep0",
-	"ep1",
-	"ep2",
-	"ep3-int",
-	"ep4",
-	"ep5",
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+	{ "ep0", { .type_control = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep1", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep2", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep3-int", { .type_int = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep4", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep5", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
 };
-#define ep0name		ep_names[0]
+
+#define ep0name		ep_info[0].name
 
 #define at91_udp_read(udc, reg) \
 	__raw_readl((udc)->udp_baseaddr + (reg))
@@ -1469,7 +1477,8 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		ep = &udc->ep[i];
-		ep->ep.name = ep_names[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &at91_ep_ops;
 		ep->udc = udc;
 		ep->int_mask = (1 << i);
-- 
2.53.0

