Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425C606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IzHFtTMZ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o7O2LSrw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59DB960F15;
	Sat, 21 Nov 2026 13:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXzSWtprQcrD; Sat, 21 Nov 2026 13:15:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A451560E9D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266903;
	b=ogh2wX1uCGkO1m6RwVEqC7bY1Z3xOYLL9ZgoNj7fMoLA4l+l4OWCckT4ntxoocu1q2Zb
	 EwfxAXydlZyp+K+UcAbG7rVwWkl6nnj7uSnf+L07uyczTS9r1U2oHK82uULecMJeYb5fN
	 vwrxvK736vlWnCGI/GbAMmd5TTfkX5nE30xQPwBQMG/XRpC4nBdGg0lfzGZjLcKgZys0m
	 y8xGEKlGSGF3TO+Z0O8HO/MZGi7UT6oSu+6OW8bG2f04okl11nXWrA7RHWUeFjdVq3re3
	 4pnmL5gNYFDoaPPCXsqmc7UKLHtG/zSKrNXUQcmsu2hNnL/G7qOc6DK7FFf4jRP4WOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	b=HmrUm3CO6esL/awCh4dZvAcawCXXtmYr3XAEOoXIOlDifCuubdPKgnVHpsGNMCZzJeQs
	 5MO8EQ9wU6+zM8unNzTKV7A4K71dTJ+u4U7INwSZ1mCdvPijzFa9rFWmypTDl8aZS7acQ
	 QIWCxizjFm57qSm33OPNMWzJ7htN7nCYsktAAAlIqxZgoKApjw9/pDhPS+oAHTHybL2tA
	 0HZJzOCL7H0M/a17AZ7mYNy5BOD/Zyn1fQNwfM42smQ46y+gBZh2xPupjGx73Vs15ef/p
	 MYRZhXQgozI32AtZxuyLyfulZ+oLyOUVcC53wqOEC13RSeXQxhjZDuiSaXPv/SGq/ww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266903;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzHFtTMZ3BMzlZTa4m2PAxQ4DD3qENGSTK/UY435S2q228is241BXYewKt9Yo0qfE
	 RQ0DFIo1OCAnKc1hY5mWSg7EBT5dQOtiGFC79DcQoxy3Pb6rQY288X004yDsjenG+1
	 L61oVBdJYppRh1sx2l2jffOlDSMOvFvogABYVBwO5YkcT60w9VO7NJhjmzacgdrCCA
	 +Dbb6Ywjq1bUqhlChmpjt7+n5ktGCFIarXCJFECz2ePXm8D+NahZsqrmDhv+1oTnhK
	 5B7CsZyLjbz3d0trt/2u97zJQr/QZ/aioioKzxvkSdZ/zNo0VV1vF8ApOcFUwyF6J2
	 iUCzD0mbCIcjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A451560E9D;
	Sat, 21 Nov 2026 13:15:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96034260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8841B81415
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XyKVJRr895T6 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E03B81416
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=o7O2LSrw
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E03B81416
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:42 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c5062bcb857so24861666b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262141; x=1795866941;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=o7O2LSrwMolZ4lCvtnGn7DZVO2cQRRX7DXoMJoStucUMyJ6iwMwFpfNENLdXhxufZe
 8+PvZlm8ifho0idU0kJogpDv4chHlkn4Ecs5k9HQ2kds5UixZhWWwch8f6I5oN9z7dn+
 7cZ3O+nZwjDx1UUa3CO1Qb9plhNAHKnfBPFKJHv1SxDkuTSfx0cYKkpQHPeBHoRvorLr
 v1U7WXpJCyWSMJwwAUbLdkZcYA4bVgvAsF2Cc4b2r1yLxSsdCuYmWbC0cIkPWFSwABFi
 +wqSD8cdf/4rmOFWhFAiNETLiYay3Dh3xF9+nQEwgMQz2wBkjX3dbWn8RKT8vpEcyOb8
 wrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262141; x=1795866941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=GqIMfDdZZpAmOSEMQZ3fndSPLop07LL+VJIce/kztBZwkgkrKk1Sv4KT355LsVEVAe
 pXqwo0/qpdvJ97SWrfL0kyK2Qwx/wWRGofcyE3qH2SVEnDS750ycdYxleA2nVWrcPM50
 uxSKvmdAb0yqDPgl0l4dc6mtrd9RjG9nzuc8N8wNw0Fr5pL9yHpWpiIk1PtoKaEIr5+w
 0eQSIKIBP9j+LoPK2y9EO88Pgadkq8PQKiUlKZp/GaxjvFRS657IkMSIYayHyI6kpcGG
 tLlxlQFE61KTIt5fxyQs5TakKnJFF+axtt22oEB8snA5GDRoiD7ok+mme8ZPLBAl40Xo
 jOEw==
X-Gm-Message-State: APuU4Z+lpM4oFv+PkswzCg97nycI5N596V1YpGiuN9EiGKppv7+idsHg
 bK72bOBEtHPT0PCFBtMHgvXSlim6JN9DcogbflAdyXAwlHt8qRqicVe3tX6iZkYpKvQbq8SvT9n
 k6qQu
X-Gm-Gg: AZFdTZdQah/m1yOeAjb48L6C+XaEHU4isNJ0XR2/syA2RAS9EiGMkAGLxp2hFz8STdM
 sZWxgZOR4K+PTsJs+Yo+g8VJWW1ZaMXcjwpmEZb66xD2gskaoW20KEi2I0bBIxUjoRQZAdSeo09
 gDHoF3XUoTJrAaiD+Nw/s315cQ/dKwGuUZjk1Xt/JDYkOWspmX0Rfxggv4+5LRkTSOio9gPu+Rj
 jVBzk9U1+WjMkTqvkPR2JSb4/OFx0vr/AoXX35F4lFqkVkeiZqskIg0fP4o1z8yyepXw00jCifV
 clbRkdaRvCDI2mKeC1NwzmGNZTQOUN0QzBXs3BChAGnfoMAjus2C3I+0PEYYRWChpFlZwtF/Kll
 fxwVkR+vjF4o0nXIyp4pXlcS3c6EvqEOFlZmtO5Y4p1h3xWtpSm+bLuHysLIF7pEGNM0C6gIc47
 /Gda3XoI33OyodUbmCjPQeCVsgRo8r6NIy3MbOmRYDUXvEmCUhCS8H2VwMzbgZIlCGV7PS6UO4z
 BsiH6cTn2u3s7DJWcYIT+XVlewCky1Ma0JicYRwi+QFuLhDAM+fkvr5YNJtLmikT/dX2J/YuwI/
 UBblqb1j3G11cyR9YzgGdQ5hEZitzOtehnvBrbfIA2c2kzHkJHlcCNhyQyof1+m51bcMy2Npb0x
 3TScp2Oa+GygSU/UnP+HX85CiyXeYOpc=
X-Received: by 2002:a17:906:811:b0:c51:356c:2657 with SMTP id
 a640c23a62f3a-c513a567c14mr526356966b.3.1795262141125; 
 Sat, 21 Nov 2026 03:55:41 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:40 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 27/31] usb: musb-new: set endpoint capabilities
Date: Sat, 21 Nov 2026 12:53:31 +0100
Message-ID: <20261121115335.548142-28-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

musb-new sets maxpacket directly and leaves caps empty, so
usb_gadget_ep_match_desc() rejects every endpoint once epautoconf.c comes
from the kernel.

The shared fifo endpoints need both directions, the others only the one
they are wired for. The kernel driver already gets this right.

Take the caps and the usb_ep_set_maxpacket_limit() calls from the kernel
driver.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 7daff5850f19..cb55f9ab458e 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -1841,17 +1841,32 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	ep->end_point.name = ep->name;
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
-		ep->end_point.maxpacket = 64;
+		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = 1;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
 		if (is_in)
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_tx);
 		else
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_rx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = 1;
+		ep->end_point.caps.type_bulk = 1;
+		ep->end_point.caps.type_int = 1;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = 1;
+		ep->end_point.caps.dir_out = 1;
+	} else if (is_in) {
+		ep->end_point.caps.dir_in = 1;
+	} else {
+		ep->end_point.caps.dir_out = 1;
+	}
 }
 
 /*
-- 
2.53.0

