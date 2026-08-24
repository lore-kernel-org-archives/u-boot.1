Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A0DC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16ADE60737;
	Mon, 24 Aug 2026 16:45:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fIlC2MtbfnX; Mon, 24 Aug 2026 16:45:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589940;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TLI6yIIEn5YBOMRU8NLqos5uzFrmU98zB4/PTMwQ/uZX9vfHUnyvRoAkBE14yufpQ
	 MSsQboJ/AyBD9yI8QAZ6cgPeH6niD0/r0q+8R0J1M9Ilhh3VATZzX6XUKxh/8eC056
	 HKY1Hl6do5FMUgx3WTiqTXQb7pr1XtP+b2MX5fjL/m3QDmzr89rS5g5C70W45T4BuA
	 b7A0pEt0PoDkgXO6i4O+iSRZTdOvGlt19cers8MHiM0IH3L78sIfbjEB6Q1vY4mo/M
	 uKtPKfOEz+mvc/j3e8aBcUVESrPs2Gi1JAPFUuu3Qe3kOGovQ8eZEt+OyXgAxYYzJk
	 sRcvZ+V6WohFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F42E6078F;
	Mon, 24 Aug 2026 16:45:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE4929B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 200B340542
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6PonIzZbZKO7 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EXss+cX5
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AA6D40540
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:18 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15fc4707f5so29409366b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586137; x=1788190937;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=EXss+cX5yCL9fuNaIyzECuNnucLquPPfcSADGd2W+kSWrhIrEi1ylySGGadcotSRkO
 L+Yny6A1iVEZrhCiKMdDxtd0Q0upYe8Kgh27wwCTFsauwCUNBx3aN4gWZfzM4fnHcCuK
 oucVmgXmtoHT5Pf7ATm21Z0SXk/kvLB4Krs1d/GuyY1syimMZvIuQ28gNIpL0QjpDdgu
 xHD/jgf7PIeN7foI+woX02WLnDwSSWwutnc3ldN+OX8Gr516GIv7BxGLKcHHn/dWn01R
 UGbn/dCooBv4qm4sbMAsMxH0126T2cUcgiIyihZvxuWxe1vweLMnyVjtiDUzDmAVyhfA
 a2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586137; x=1788190937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=Imcu5S5RS2dND9Ric6dX9fJXXq+NIlkKku5jbw/zuZwwactTHjtegkdz3EXbTbLtYv
 OHOyR3l+Q9lQgqKj8qK4McXmgkJ4lVocaS7cfyHvEVZu1oa+IEpZYXzjWv2PWtrQ7T9Z
 L1F2DkGfDqpyZfA3/ifJ+m31vG8pFgXFjrdeZ/3Q0RmlxK0D3Ge0318CbS9OURsleDGT
 97RTCPhIt7x4cj2CzcG9ABbHQcGDIE1tlosyEasKSZi1aKD/TCle7/tbk3047m3mMQB3
 nY9TRBFFBFiqLxNYJELSuMacmrWK/nfA87w1W2p3vcIuycYbZ3kWo5cRM08JG5gO8pbP
 Tvcw==
X-Gm-Message-State: AFuF++mnGaqh5Eg+IFeuBzwsiWYzoNe45CLlR18e14yLMzk3Imyb9mi5
 sAKvlsVp7F4Leg9OLAg+PbRwrExMSPCuZEPvDXZKS1JMsMNDPdWrmhpzxzbBPScZ8AgwDChjKIs
 qZDkq
X-Gm-Gg: AR+sD11XXZ+TBgMxPeOfSKz5MxaXKP5Bd1IPiW75XylbF64TwDH4lo2xmY5PSpMEbTV
 5NsFWDlKac9t98pPEDZlbe5HDForBVtQH9dgzMVrbR42j2SCiWDK2L2wZCkI4JiZCIYR9frDxK2
 Lkil+/TCJk54CpicQxxSI+nCkOICq1VHjHm1uQ8c3Y2dPEYQx36u1PjCZdwqNMcGNeZ9SgsH9la
 t28tWRPTr1SL4UYO4+gNEQnvPJq7h82ylPEbV+8Zv5vfQnX5p3msuINTYDOWRYcFow0XlBNEyWJ
 7AabYkL3w5BM5gg9pj1h+Gh5ExqGHYzQN+b+9giypzaOo5LMXmuxX6trYFKcd7b8raqKrRDhvGU
 O7hbjomfzFzX+4j+Ht7LUatmcRAkG93+EhNq13G5RvcgfWbguR6txlaM5qQkaK0SjPFEK/UimLf
 8Wcgy24mpbPiFqxH0pZ7QE7obQ+GOBRt3cyvbua8bK0lb0I4mVhP9I4tLWXWmQ6oyKpuG14zORk
 pGKJm8PvquHTjybuwG1Gg==
X-Received: by 2002:a17:906:f59a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c246a62f67amr1500105766b.3.1787586137091; 
 Mon, 24 Aug 2026 08:42:17 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:16 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v7 08/24] usb: gadget: udc: enable async callbacks on bind
Date: Mon, 24 Aug 2026 17:41:17 +0200
Message-ID: <20260824154133.217744-9-anders.roxell@linaro.org>
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

The dwc3 driver was synced from Linux v6.16. The new ep0 code only calls
the gadget driver setup() when dwc->async_callbacks is set. In Linux the
udc core sets this flag after udc_start. U-Boot never did.

Without the flag every delegated control request, like GET_DESCRIPTOR,
returns -EINVAL and ep0 stalls. The device never enumerates, so fastboot,
DFU and UMS do not work on any dwc3 board.

Enable async callbacks after udc_start, and disable them on unbind, the
same way Linux does it.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index a01a7e6dc21f..79f249cbb114 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -949,6 +949,8 @@ static inline void usb_gadget_udc_set_speed(struct usb_udc *udc,
 		gadget->ops->udc_set_speed(gadget, s);
 }
 
+static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc);
+
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -968,6 +970,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 		driver->unbind(udc->gadget);
 		goto err1;
 	}
+	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
 	usb_gadget_connect(udc->gadget);
 
@@ -1164,6 +1167,7 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 			udc->driver->function);
 
 	udc->allow_connect = false;
+	usb_gadget_disable_async_callbacks(udc);
 	usb_gadget_disconnect(udc->gadget);
 	udc->driver->disconnect(udc->gadget);
 	udc->driver->unbind(udc->gadget);
-- 
2.53.0

