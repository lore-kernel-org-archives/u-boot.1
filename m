Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F1606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GkFFueBB;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SofBrqDh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0E3260A4D;
	Sat,  7 Nov 2026 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYqGMu_v2V7t; Sat,  7 Nov 2026 12:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2F71608D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055837;
	b=Kaici7PJqmQgzCQPbY6MGp7crcxSu1WS5Q6HWpl40Sa0bIStzaRa3Pud0KgMIYCZnJGc
	 Di22mqrRbldrXhqJvmpvyHq56kBLefVY5itkGe+y2acq3sjaTVD8986NF6zAluLwKy3tV
	 LfKGc8M3rvE53s4IHazKg/Y7DJTr/8rZs7+woV/l7o/Vy4NzbLXOlCZnoBbN69xt1FT8i
	 fNwHPL8MCeJLxfpftWkJX64ICZSgQCWaghZJOE9wPZxi15NbNUfwswx6s1VzX7bX9XkyD
	 wEJ4jV/jhLpEzxzoh9CnohLXA4B5gfJCL/Dhv1wKZQQ5f1On7VPDAO0mi2Hv6YgFZPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
	b=YbHm6IECp7F+dk+fX1XcmRjLUZZyn22KtUKmXlmgLVz3g7aHkLKkAEBQ2A4aXecqS0+J
	 ImxqaqA5bEqnXNRxNsxq6+a+i5tTpF4UoBW832OKrbH7REWV5B+4St1pGMRp/vOQPVnU1
	 g29w3bO4FASWF4MbL3Qlt1gnD78tMTwCjHWGA0aW87w8xeLrLPGR6w4u6IEBxDOhZIsCi
	 3rihcSCSooSGxGXxEQFQpnK9PkXGAXAPKftkyu4EJwcJsGmwfn+bo/AkzvPCdfT0Ct5S2
	 HBfjX8dRsx/70YvBwI9IRoESeH7t49ow1KuaikNVruKUeI1t6HFpk7k14m8TOGybfHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055837;
	bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GkFFueBB9wIc+H9xEFqI6BVI5XZ+ol+kA/a0L33YFHThbzSWR7T0d5kSo0CyiNuyq
	 f/I/R04FR3I1UdNpexp48HmsGA15LAWFDUIemRadGdx8lkX0kpZjbJVp4k3gU0M4JJ
	 Th2RVNEZ1nbvbrwk3uGreoNC1xZb3CzSqVXQy/iV6DOpkpa7TrV9lBJ5c7/zfzfuYg
	 poyKrwo/ABtffXKs7IzDXvBbnXmQKNfLVeVFQI7cpYZXAopbJ59UhmWOvxYe/GWYgS
	 n4KolOnkHKGLjqcdX/BCV8YBQa4MLIZpB8obDTE7OyWzFcCVgYL5qnuGjzXoDV4fQ1
	 mJKasDE92oJJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F71608D2;
	Sat,  7 Nov 2026 12:50:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4755031F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DA5D400B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lmEDrrMk5iZc for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E3A374005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SofBrqDh
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3A374005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:09 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6aa77d4d968so241700a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036247; x=1794641047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=SofBrqDhg2MD0wwPBMSJ0zbFpZ/qBaWUaED0n+3Z6T6op4KKnBeCDqjkSaREK4Gd3s
 CPmEvmXB6MoBgTZWm7yOJDw6tPWrQbxyhMFTG/OXDvUPm+0BIDoUmu+GMnbwD+J0v+5A
 iDf/kkjCo9+9hHaoGYxGckuREd48fUTstdDMyk4OBr+xLcmEXbQL2NqBkXpTufgnrMoj
 yVBwqp/IlbczCG1oh9DlqQgCVKZVnx9fVETA/MmDkI8+QIRzGB7BU/5W2Rk14RhljCXE
 QBtQxVKJPycQyFYgXHfTu6nBDCSJtQ2k0Q4lpbbSDkxsz64WtYg/ivUYf2zgbRcsIrwC
 Y4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036247; x=1794641047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=YiNKpEBKajmcjnDOw571ZtbQq1TCdMlIQnDWqYWez7wFp6MTv0MkqtVm3Db2kSCaDk
 6l8JqzwSYkkSoVSf6b37aKWidQS7zku8+Mhwy+yC31Eb+zF4FVxa2syODYfFZ3pH9IeH
 94mJBXILukzqUoq4tINQp3py+jbpUyEFSupRSEM2wRv69A6iDVV6/BdVRZI7ImIl5aAD
 y0Fd/I64+DmUXMZ4naiG3qT2vBDid0cpktbVA5rvJRUglpKZqw1LvsSL0beSf/4CNKYz
 CMemwswNFMYl1sSe0BUBH11ki5mfKlOc0C2m5pmO/v54yQ6x3K0M/iNlMAjA9M/jQV4j
 hnvQ==
X-Gm-Message-State: APuU4Z9e4+DHljEWAx/7TcA17kgQqMiN9SkONTJIE3XJaoYBxYDit1ZT
 VaoP6Z/o4Hjv25KEWNe8w5MLOYtsMLp4+9LewJd8yr6cp9lbIUnKJ83yV6FWbvza+prUUCk/7wR
 AALxv
X-Gm-Gg: AYBFou2oDF/CeWHgiPTlNkYAGp10Qgcc8WVgRuhTTsXS92o1OzR6srE+gtM22iWY4xb
 4NGvRsyLWENJwd7VJilOwe6JD1gkghJgjkVAEIiPsDoxmOo/pTKoZA1EHdFzkMmvmpKTnAko+7F
 OJjD0LCRiEPsuAcBuzuxY/mzpf/ohM5Fwd7iGpP6dsvTE8uY6xHlZ0viKaFlAHOGbYnXikGxD+J
 deSBvrSm7mtHkaYkD4LEi/XoXyCd+z7p0bBjl93T2Fkyf+KFOMWLyDae01bl3mWxydAiYt+sfRL
 WdxwMaLJGpMVJ/Y/3sJQtLRkRMuESK1OAxbjnqlShwOdortBnMzp58ktRilGG97Dm3Vu1rwM/pg
 YPQCv23IpV+MzyZN8hi/f8bSkKRmZwAA6EYQEC6rmsYPemxfYMJrtUGy/jwlmbDipY+rWF9Zkwm
 cfaqtzlZgTPVENTBPH4ZH72bHPsaJqAmJ2CJ4RF+fKA3wcgqCk8xTeNZQdVUqFy/I9+Z6ZS5P0F
 7HvPMXHot00ZdaAryhjepmPKf3ZT8rGfrhq9aORgNOf2SKN7cJSNI1rgynA5kXyxf11ZWJYfICA
 GsPu7Z8HXD1EhLF/wTiaebgmIL4TvGR8lUSv+slAV8sGtPSM0kg9D5CcXm6TcmbUVlHTkR4GH3N
 ePUUfc9yixA==
X-Received: by 2002:a17:907:1258:b0:c4d:1501:ac3a with SMTP id
 a640c23a62f3a-c4d352df5a2mr398209666b.2.1794036247485; 
 Fri, 06 Nov 2026 23:24:07 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:07 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 24/30] usb: gadget: at91_udc: set endpoint capabilities
Date: Sat,  7 Nov 2026 08:22:18 +0100
Message-ID: <20261107072224.3492260-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. at91_udc never fills caps in, so usb_ep_autoconfig() finds no
endpoint after the resync. Same problem dwc2 had, fixed in
commit c5c4cc4c6b98 ("usb: gadget: dwc2: Set endpoint capabilities via
.caps field").

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

