Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66701606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rwpXMYjb;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u1SVxUrG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EEE560EC1;
	Sat, 21 Nov 2026 13:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hymz8NPnw7Ul; Sat, 21 Nov 2026 13:15:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB2FD60EA0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266900;
	b=lrSapxOfwJlMnlWVgVgEkoDVRB655nzVuM4qF1kUYb1+B/Pl1yEnXtJ3AtDCk6dgAemx
	 xU6bywj5BBu7yyIj/DKFfgTJskL3/MSertpWreD/MMnhdpCBabtiBZ+fsNZr72KQE+7yo
	 H5B+e0OyMtO/DcQ5k27RUVzpVlxlbk7Qr+MCnsrSr+8GYeS0EjFLDiOaWCp4HDr9lVfHw
	 vCGPLNmK4abDLl4+d9hh82xPdHkCffPG7KKiBWAq8aqpl8DyE+jo6dVHmYwh+DR99lzCR
	 U5DuCvJ00fKWULqeZ1ksM/3vILsaUzTn0ACbd0hWNuEBUv0D9WgrbizQH7yj40JORfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266900;
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
	b=euYi2TYX8n7m23WrMNyUzpb/TRoFsSG8XkX7jZXeQOArRvJH74TG/NSXz+o3k/NgKopC
	 T2K4HEICfidl6M3+1HCzy81esB9dlbs/4WbmxrD8vheoso9YK8rxqbF1kulGMihbhcOH1
	 uOwe8tBwWHdulEt10NYdJuH4ayXezgERvigr/o/CXNKsIlSK34uPg/5QCX4LdbrbDaaa8
	 r7KnyHROwBDj93xAczs+yKmiXx7c3hvEifRLQ9lumZqQsVi8ZQ90FdfKOQqP1wjcbqX7j
	 pSlpFx7ogq7xsbsW0PHcNa3lTZTIrisXZfE6PVZv1lguo/RuXpDz+G4NIfWtYj6syuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266900;
	bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rwpXMYjbxJQcbc3ljVl7MitChSMzKEv/VLOqy757iE50r6HD2xtaTtyc2S9dGMxoz
	 vUsEm4b+fBqzxdp65y+n2mGtNs8/bbcKVKvMwb1MBpcqDg8Uf97b7otadQDY83e35r
	 0Cvx1o+SvaVVJyNuQGjQ79jHYeexK5PO5Ekhh0YhyX0KmXEvxG43eRYf+coN5FrjVk
	 lsAQB4/BlpZL0vz7vbd3MjggjMwRs2N++ZC2jgESUnlNsN51NldO2AoepmMXHMkOgQ
	 4Bf9nu5AKmshQ++meyMKKre9tDDXOJ/PK850ZOM+9iNA7qFkKJanEu34pM5v5Hpb4z
	 K6RzrY9kBSAbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB2FD60EA0;
	Sat, 21 Nov 2026 13:14:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F480971
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35E8A400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KuuQVGkAOwgN for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2AD2B40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=u1SVxUrG
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AD2B40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:40 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c408e21e8acso40214566b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262139; x=1795866939;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=u1SVxUrGmss+24fKmtlpmZfjODkKrLT3plD6Kwpx0JbxJavt9ROge2SAZ4LhEFFyBY
 Smh87BfmekHbHhucrdSTAAk12m4NzB/Ivq26BdBZe7jOh/u20VwpwyoVlsyKQgwQsZJh
 0FLk15ddtqPnbmxxNGi4JcC8VhgO5qLlqc8/TiKKrN+Iu/vuwnN6lqPhHOwDAEEdh3Fk
 IQTO6rLkAM4EaPoNgnbXEVJOWO52+6/9hdsO1kjUxGJES7z4XtkjG/ZA9eEQe65uJPfJ
 2Iq4XJdAhTO7Klw9uYY+t8ybCVmN9x3t0SDO3TyjnVixV/Wjcorm76bMPul9NFJDJACN
 HUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262139; x=1795866939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=V+2ivhsV30gnOAmGlkr5M8LgTLcV0E17BxIO7dWTFxD9R2R+o03GtGuK/YJpdRLc47
 jvIxTtPyAtpu6QfcG2+s1UTjfkvzEuIFPFXLZ8rx6H9psgnlcsZ8DWobMM3y7ROWGju8
 ImcUEuwCle+MSfMjy6++sbqwh2J8bRO2SS4iLFSAajbIl+nuVQ1Z5wppSgtxedAl5E5m
 JF/Lu3d5vWOOM804mOwfgWFkGOYonLi/OSxbJyeKDMia3ybe9LZ8Q3gMPwOCBCSlrBJ1
 lvWeBT9D3OvcLZZOcU6OlnVgvZ0XMo8UyiYVHEjJS+CX6UoibmJfec2k7amthrMd4axl
 gF9A==
X-Gm-Message-State: APuU4Z88O6+EWWcMTbawxi+bX/CTO1Nwua/r8PDMC3mJOoQ24DKqm7MW
 dgJEHIldPoAygCBqZvwz8jiz4XvJuBrWRkLcuHUeonsfiU90RNm94JZ4AXAhtKPj+fEYe+8GSuW
 lcCrg
X-Gm-Gg: AZFdTZcWOhMsKY8MHdRwSnYZA97Vr23SQbR76rTHZlV/7SKF9IqngrCo9Oqzs+CH+7M
 VwFwA0cYDNs2aBKfwK5J7khjccgEaRzjaJpP0K0ZLu8sYoxbexXV3YLlykOj78IS4SCsEB8MIlM
 UM+/ABMNTQuL8w9enugU3BumYyg0S6xokJzuu+X8J1RcG8zV5DOaEJkJXzG7EtEDQ49BOf/fC2G
 3BTvwgYhVgwyYEZoSX+L2KCRT3RaMY7VzDHQ0SqERw7M5JPUwOxNvrAARS3PYc6S+w1os48jEnX
 SbcSeump1VcUh/mGoRAhFzv8q5hGsi+zLj7DNY4OPfT4+v4NMO79mfIbThhit0zu66r6fWlvR9h
 74ROhytMfxnC9vKoyAZd9eMZz7ncwgGn1k+8uPMLZrJhnA0AgTA/IIX+QYrho34kYzXdRZDzPCD
 df0ozo+2jHVW/5THn6taGzf9rdro85Z34qEl0hGV9AYsft53uP6lfh0Wso/xv4Gglt1aneDMy3U
 8x69lUzC/J75DuSF38eKxc4n/z9r35d/jyNoA9Q3sXPMX3KghnFFxAsauOV1pWUlHMXTFu2XVNt
 igukxg9hy+AIgq26K8516qtt/pS5clo8zyRuxL8E+48nwG6yVe2YKS9Nco+PfWFQOgSH8mKgxiU
 XQM1ZcBqUPw==
X-Received: by 2002:a17:906:6042:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c513a5f04b2mr528114066b.3.1795262138903; 
 Sat, 21 Nov 2026 03:55:38 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:38 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 25/31] usb: gadget: at91_udc: set endpoint capabilities
Date: Sat, 21 Nov 2026 12:53:29 +0100
Message-ID: <20261121115335.548142-26-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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

