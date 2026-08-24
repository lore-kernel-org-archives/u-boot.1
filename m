Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C15C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F22FB606E0;
	Mon, 24 Aug 2026 16:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-2MT3fC0VT5; Mon, 24 Aug 2026 16:45:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589952;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ceHytijVpv3aezOHhduToe6Sq4XoxiZaQlfCI3EtiMYZW0D2MD30PlYWgN+kCruhY
	 nn7JCPR6lXmUdgYk91BbuD2NSuO96CQmO5WPgGPJTYOPh1BEkupTBziKBSvFa6xBAV
	 5vE2FTRWIRKzwGLk2QiIvY8U9sdTwikHjjXFnD1yzK2uSWqe39RRGhYd3F0yYLp28N
	 8AMngK9sKGY6Bpt2mO4CrDtDk8sxjKshWo7q0DX+O9K4sGVRFVUNQG/LrDmeLUOX7+
	 eNrvZanp2jJQ1G2AtGagnese+AAQl0HWhQUnrY1iRHu39+5h63oN3eq++2N1NiufB3
	 Ad68qAUlERXQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08FC8606F6;
	Mon, 24 Aug 2026 16:45:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 68AEB29B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FB3740068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fAX2elirGfrr for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=RdgMvV7U
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2665040029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:12 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so652609a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586191; x=1788190991;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=RdgMvV7UOJ6tu09KCHBcC6DNtG7ZdS6XdoFjmGR0+NUshj8HiVo7HQj8vo3X2+P7mj
 Gx0ByzZ2j/1MhJ1wf4pQoTr/aUvFQGSDXuq6qOHnS2euy6IULQzJP4e9ufR1OzBm478N
 sz7D6riYyYJg7UNgOVe67WV9YDkX93xrXiOcWqz372Ai4bPUQ1Ng1GVLxkOFhMNvM4Ak
 IQ9/R17lkgBo9OkL7JWyO+yKhUNSVAZYcHpD+fwS7o/TamMrNBCAN9XHO5piFbwTgdaY
 f7krMZYISEARw/QffV0pkOu/VWfBbz64DVNHUwSYLvLO6E1rRsc7dCHs0/vukMPGH3QW
 fluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586191; x=1788190991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=btjqsq/WTgSZ0Km5YsZFok1tx6QobVih4LFOFSlvVrogt6t/+h1V5VvhvDLyW9DVRg
 8WfAnry/BBuIdEflNaN8PeSSTTLdLhdU5LdEpc8ZX/pUlo7+fLjNy7iXLEWX8M0Utw9c
 ImDQjo2Jz+TvwGSPOIVrMwJgkgwCVek4kEf4d/oIdbRqxh9ixCvsJ6GekDuoSUYDonQZ
 +pHX/uM8xfD6inFZR6LMm18mvD5btM2Uk52OIsV193EkwyWd4xoJkHhoiWxI0o9cmloP
 58uZIxauJJn6pFiXe6L5YaZIYt+pbRBQ4VUex0DN4917n4zZvosognW6GvlApJjc7/cf
 iSKQ==
X-Gm-Message-State: AFuF++mDvot8mnAAfCKIsncTnOYknsSnqoW7IOC/xWGi238J5IsHuGoM
 XCzHAWd2ohmeUuzw03VhBjStpMTd8rPB41cWtptDJY+v8PM7VELuOARe3uPPVMJggdS0rLWcTmn
 hsEhm
X-Gm-Gg: AR+sD12sUXEWqZU6GmCkR1vAyBm65YSWyaZVYR/+b7DHmv2KZyO3NKXbg5jO0VjIZte
 4ViDKvFiY8WWJodnU61T0p9RxR71NIDTIwPV9hPslWo5jBG2V40eJDUXuzsreSLqbmmAHd+HUFH
 s3ksCjWEJqI+z1dyWIhwVeJbZP5sAbAQeGrXc0rvE5V48QVmjf7yA5VFWWzL6eyPQz3HhNXtKSK
 12VMwevMM8LToF3r3SjLxFBambpZTaEW0h/hKGabelX/LtUbqJj+ZI5KrMWeNgvLKH3rdLwoIH5
 UHs66pHjvGH0izPN3CKAl8N8A79SoT42YzFxUJ7zTHTPwN/wzzwRfk9rXuU+pkLoIvCZAdZgAQQ
 FwxzYlharLyx5UQFIOXSpCa3cEyggzLdTX2X3pAoI6MVJGgX21LiRKlVg60UXI4CZFkxnaImmS0
 LYZO6MkOmvi/rlA4ylw+T8rZIYe4E1KTB1T/AZFwYemYdK8KuQ6T6oqrWDlYEItoxPrpE2nQQRc
 kddsBKzyJd7AkDYW1XpCw==
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr15744738a12.2.1787586190732; 
 Mon, 24 Aug 2026 08:43:10 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 16/24] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Mon, 24 Aug 2026 17:41:25 +0200
Message-ID: <20260824154133.217744-17-anders.roxell@linaro.org>
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

usb_gadget_ep_match_desc() reads the caps field and compares the wanted
packet size against maxpacket_limit. atmel_usba_udc sets neither, it only
sets maxpacket, so no endpoint matches after the dwc3 resync re-imports
epautoconf.c. Same problem dwc2 had in commit c5c4cc4c6b98 ("usb: gadget:
dwc2: Set endpoint capabilities via .caps field").

Set the capabilities like the kernel driver does, and use
usb_ep_set_maxpacket_limit() for the fifo size, like commit 6f9c431a2062
("usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit() for fifo sizes").

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/atmel_usba_udc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 52900ad654cf..bcbfe5272d5f 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1188,7 +1188,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
 		ep->ep.ops = &usba_ep_ops;
 		ep->ep.name = pdata->ep[i].name;
-		ep->ep.maxpacket = pdata->ep[i].fifo_size;
+		usb_ep_set_maxpacket_limit(&ep->ep, pdata->ep[i].fifo_size);
 		ep->fifo_size = ep->ep.maxpacket;
 		ep->udc = udc;
 		INIT_LIST_HEAD(&ep->queue);
@@ -1196,6 +1196,16 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 		ep->index = pdata->ep[i].index;
 		ep->can_dma = pdata->ep[i].can_dma;
 		ep->can_isoc = pdata->ep[i].can_isoc;
+
+		if (i == 0) {
+			ep->ep.caps.type_control = 1;
+		} else {
+			ep->ep.caps.type_iso = ep->can_isoc;
+			ep->ep.caps.type_bulk = 1;
+			ep->ep.caps.type_int = 1;
+		}
+		ep->ep.caps.dir_in = 1;
+		ep->ep.caps.dir_out = 1;
 		if (i)
 			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 	};
-- 
2.53.0

