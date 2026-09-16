Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC452C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B281980EE6;
	Wed, 16 Sep 2026 13:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g3qTiaqTOWqv; Wed, 16 Sep 2026 13:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF94380ECC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564152;
	b=XaErQdRk7iKp6NtVmmIQdmM13eCAR3KQpHP9wqPiMgimrtvXZcS92Se0d1TmlL+ECPsg
	 x3ZBWQNMzhEs+vlRGMoJG9rwsOfYcNThITYWMrF1KKTQwQi+TZrEWeE9Yts6rBJq5kJWa
	 OiqPh7aHriPnMe1/J38rwJU25RKBCluVBi1k2Yw7WnIQaRuAY/bGZ8wlxhysWX2RUcVFC
	 nG+gOB6n2RnZpZ2Q9BUoSW4+rqlnFnSiCZIjQuPv1m3L/pZC6CJKQYKrDDN5wMa1GoTpR
	 n2pbv3eKYamtFejRe89mO1kYKKhKdUeyL/9jPfoLwo55XONXJ2RTtgO5ZnGBnLyDlTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	b=b0F2GKTA4HlDeJD9RSaktfTMUDBxnLrKU8juD6tWTd4NGrpg2mjBLr8jP1bWSvhGhDCc
	 +r//RlHW4r5da+S8nK79aLI60ZXG1bI4ykmlXeo2sIE9JLJI+3XxGD9GSXNQasW2MwQBf
	 HugO7bb1Avx6G8s+CIR2e60mGV0Aq+8b9u8A37uJKHC9garKVyXbxhafZZcGHYLGfPhu/
	 9dKvLCesagwaLcxyjW0FnwuUbsXF2qGRtT1NBocIEBeIFKaF6SQ/03zF5TyFsVDw3sUDj
	 Q8WxPNta/P9yJFA/zbddQlGdzhVklZGJjCgWm4wXNJHnCJpUh3lbfGNFfIWLQsMfQAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564152;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iToEswA4wP2eEWgCHLBb/01ysStYhGm2+oIXYdz2k4nGmVUbL48abP5QkX6c0VG7i
	 BL23eSIT+a3N4rHwS9L9+pXsGrOg2SLug+BRgrFZeeU23UCM93aHNW53A/4Imm4Rn9
	 cX68gbaajf5ioD7145ke7TseL3dCcOenH6gyy1C+xRba5M0F718k0GW2GhV7fu9SLu
	 ZEumbjLDB72XkCx4Gj2S94xMSjayv4v6FMlJ4ra4lv4RorWFls2jyQFV5shnOPSeml
	 RxB4vgRqk6NdpTMLokenan4utSbjZ8MweUSbOO5Gp6sYCTTW+NNtfAo4X1vb0WxBRG
	 ELILWrUbO4UMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF94380ECC;
	Wed, 16 Sep 2026 13:09:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B050D388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE0BF607FC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9-5XW0uUC2n for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 91880607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562487;
 b=kpwJDTDUWsrtD3DTtsq4D61QKBMCki6FRWAq4l+aeOtYZO/aWZgsgxRGIpceSpG1x6nN
 00pDkEc1oWoXk1UOduG2UFYCMkwRbFYMwKId9UCTplLVIHaJUCOFUBQRXJgHZ8Y9YrKwc
 Tsr+pnJAzspvBvL+JzcvJINXNJ9Rgk1fWtGSuP+hrr9DYGJ5nNoH4nYRiSaIpkLAGVHHl
 OiXsAV7bH/sGR06B7FETUYAP8/qLLud/5ZlMB+R/+AyPva91mJjk6Lp/K527GAtTDKyX2
 ZJbudbMizd38Ql/ckjGsfm72VJJKHTiYW8izZ2Z5ca4FMStGrmB4gpQnr6WkdXDsQdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562487;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=EV+jQY8m8YF+D9RfyyYOgZTkcBIqnfQMQz1tULD94ZwGnIWPpX6WhQjG6h1YTv17iUai
 AmgloZXFXAfMAe5CeTelbsUI0KnKuUS8eSzvV5b+9ql7PkCCJe5f9aDzjTuaXRkGWLJYB
 rnidbB/SzjvHxaMcdJZ9TFwFzGzCn2yyFddJ0aYtdPkdazlhFERUeaq9o4Bh7OwHsaUv4
 L6qSVIhJ2sjCd64ZeK7uA7PkpklmBteSs7/Jeq0H0CFZ8ffMkiK9+n1Ohup/hVnR/O7MA
 d23ah7I65fL3+v0x7FLOctbrYJZyJc8Iyxdi8Z5m1J9otjZ/mk7cEcX9Fodqbj7xT3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="IKXciS/Q"; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IKXciS/Q
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91880607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:26 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a604843993so126329a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562484; x=1790167284;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=IKXciS/Q6MBC0SwhcnJ2z/IjuwsdictlbnCAOfObM61AM5rBDP8IT7ZTs91ENubqUy
 rHcf0sWiMxYzZoAJqvGWsH71noQ6+Z3zRw0AXeoaxq8Udj8U0I3qR0NV0jp01iQedjOW
 lxof+EBxZcdLlYLdFABfgq0y6x+v6lqrdvHj918+qB0FJDJJsjDXafPB28KMrFHcudmu
 n2K34CXkKZ4Mo8TBov26J1W9s4I0r7v9LacZUY2LxVZDyxXPjOLoFvnTgf8YUss21Dfb
 XS2eBBHpjvlbY0WbrLa5cgvKrlG2OiRnbnP+Mu6Mxc31xzePvGtD8J/Msl4Bwqp9JL+n
 2cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562484; x=1790167284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=YskfWm602Q5xyrUUMLSUxwCi3vGHTeqJtQEZursEH1hcsnKLzrKH6doTB8AhXnAjc8
 B9VfTPocWCDdDWN7R608ZaY1Wwqk4dsC+SmRXvnLVKPppx5H5pwsyIHdjEBxxvtJpLHk
 WFlDVNSliC9AiPvW0WyWm4ocARsKSNAV6hH00txNVXwKq1ePc5W2Hhvrjon/ibikzE9t
 k0Ehxz91cQrvWL4UmC9u8PqsaTEzn988weZIsitp66+UykWDj8HaWqGEVOvjvpr2W8Ue
 L9agIZYUEHiJ6dubnZor0GXBWhiCqyN+gt22HnnXx8HKtGxNszSPvEkFaQmumU5rAxyy
 ZJBA==
X-Gm-Message-State: AFuF++kLDbXw64uXVn17+ElpOb4Rfn4u6NXdL8Upe51HvnkcfrpLISZ3
 I1wt1YogDVEJr3y2cMhgfVH8n3LruuC/q0nEplUlAxXYmE3upATLZ6Kklho/BFOLOwONAeOqSoZ
 ccNnw
X-Gm-Gg: AYBFou21T5s0sANXGAhhnJbj37m1sYaTHMrZ8p705K/1k2bP7nkPq1I5o3ISCAkJHyG
 fo6Dk6AZQhZHC5Qmq7Ro411Qs8S0KFN/dL9QuC5ZXDbVMP8IiP9J+ErXoz7C1AxkHEwupQEoMrM
 cb9JgtpP1ieDoot4GrRxyBUFXV0wvF5cn57gpv/BIrYK0qekoIOTyOSLqL2aD5k8bxwyq3URRaf
 4y3yl1uX1juToobpVzuxjzx4zXfxiwLYDabHNHtm/CgltF6Tpsm+MPwWtmcNFj4wBmuekm0Gr0h
 yE1BYihKMTHFVctiyJvq/NtNQtyD9Xote9wqxFgWO2NfjNjAAUk8UFcsLEvSj3hMOhNUbZqCvVh
 7hM6aiEJhe6StNPNXT6R6C4dd3gJAZ1W3EE9H/KDYCDSFQ14ysxkRxorG0R1WsTnW2VSKDzmpg3
 AhDDk4Lf/ID9SU7Q/wKtAVuLDzOc//ly2c6xIw6DJPYevVjHjI+jXAWXLxKEw422pXZlFPYtZWG
 h0jerWMr8TJS6ercgzzkjcwbkeo+CX8TLJ8a4V1Egxb8fFkX34l0/rQ
X-Received: by 2002:a05:6402:1ec9:b0:6aa:447:17d0 with SMTP id
 4fb4d7f45d1cf-6aa223b1007mr2079294a12.1.1789562484258; 
 Wed, 16 Sep 2026 05:41:24 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 20/26] usb: gadget: at91_udc: set endpoint capabilities
Date: Wed, 16 Sep 2026 14:38:20 +0200
Message-ID: <20260916123826.517181-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

