Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AE606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lgaV6iCe;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L6kGHJXN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CDE1818CD;
	Wed, 28 Oct 2026 14:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8bTQXyNR2U1; Wed, 28 Oct 2026 14:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F33E6807F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198922;
	b=gp1BcAZiy6au/Me8NJDJOxwJxiKk52VxHsupOeg7OuDMnaIe3aY8e3Q8aG3rIh/8koMW
	 3LUDxcZqSOvEsoL5+jnNR7wLkmQ4ptC4AYmMLTkdaQzMxv3qjChq99Gu14X7KI/4wwcAS
	 086qgDODuxodRUe1fmUtT0HXdJw3aHelJEoin5fOUHFL1VkdpfkXhjH7KN/TsOAqpnvbd
	 2Oov0EDV79Wx9AiHpEhN51WTDJHNkmD8rSnsI6DPlEFusgITnyi4XdPkK4vaLoqsyFzRg
	 dl+0esHsjnrBa//gIHkNUQGTopZwJtCuof6I7XB+/baTCDw4rgGI5mjmDSVqll6zzfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198922;
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
	b=lO3NmQX7/AACj6YsomautRNlggFAmCHCZU4m4lVB3RZH5XpKjjWp1xcoo5oYdHS1fH2J
	 CqgLAUy8yF0hRpzLqWxuyDoYkRpZRL2myo62ho/PXiMln7R0oPZvtctptxZaaCDVo1uKN
	 xbcewto/SappdoHifcVs4W9bU+WjLPcvxH5N0K6h0qnvJqWSU9yS9GEMvSUFmO8el2G/B
	 liIb1NKlDwBFYlhMflaEs9W2Y1EG3NV81QUp59etvDIhR8CCuoB565htGjQDNku6dKKlk
	 aBAu/P7lS6jY81+/fy7smduCAvzjCSAbhWZYgzludt/ZkbOWwEhgRfiXJz/9F7iMAdQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198922;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lgaV6iCe2VOQt4mZXiPpk13omBE5js6Jj/4CvShMxuJGyFdOzg368XXIYGLZbIVM3
	 DdncVcu4KK6VucCAaaU02NUMPBNrUwEQ/sbi2LUi9sK4ZZebu9kwADYYtz9IKvH7Rs
	 vxSBKavbU+XBYX8RH6He9w6IdCIx2UOqVasnpBnGnnMZPhbvW0HZC9x++vohKl2iJG
	 bW68SwGv1anOc/bc4YAC/rqJGDYCt9nNUDgloth46q3YkbKM5zHseVwaUg0OvNCCN+
	 2Q9vZh+dGEpm2ekQiHVsom4+zcxf8mfEv0xsZdyXLxQ9FNJ/afzFZ8p0rdZHvcMkxl
	 bFV78c2X/qdtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F33E6807F7;
	Wed, 28 Oct 2026 14:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D60C235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33ACD40557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERSXvj04ZVFU for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04FCA40550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197067;
 b=DMwvFOSitAdiQRWHwWQ5TUfu4SddXeO/bp60BvwzFuQ1cryMrIOhrkfUTLMO5+GLEbZR
 Nr1NpTl0c5qbdxD0/Mb9trW6ReIYCkaYVr4UNdrJCi6y/H/Dg4JLR0e3yOKztv0G92ji3
 JwKbwEf/Z8EZwFVsW5HTUI5iqayUvi4HBYlUSWIXDg2X1BKHtzeTb9AAXeKQdOJodpjpT
 18nrB4oW1yhXx3Hz93zjSWEsco43UtQ865kUXN6G7Z9TN3yvs0u4A1O6VFkY4F6g2xiQE
 LGM06PUB4MmQ1IssKw59TNF7Ut2EzI7SLH1znlF8pZI6+V5egbLdGa733XqBLj8DYzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197067;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=HH65R4G7qx03Y6Obk317OEc2CGYHk5S8DYCeE4En8Fz+h0iMdoCxFHtQvCSOWMiBtox2
 EzH+zUCqfpWSvwOV/m4e+torlwMdLJUVwOUrbjwPSsSjXPOfPlwvdkR+QeYSReh9aNaNx
 TkwdXY/aqi4dT/tfbThHjAesE41MZI0MLmvtLnyG507MOcCDIHXrXQGzuN/DgtGM8Bul7
 vP6Dx81awchO3rl5cKdIjkvTFxOnfex+SZChUVOyiFU08msxlmbGdYIrbmds4BZFEMNlj
 WqmmqKtmKC+dVI3JzshgxaV0w6It4/365Htf9gR8JKp3/4r2XPjkfXYPNHbBhGXZPzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=L6kGHJXN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=L6kGHJXN
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04FCA40550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c408e21e8acso12736766b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197065; x=1793801865;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=L6kGHJXNm9ryHIoh5/B+NcS3Yk2Mj6U07ZyWy14pf1blPMqBmwBJ7ZmQIQyELeOEwh
 0cOQF7Z8K7fUJuJgpTjfZTOs/ZNQkyRsz2vLaAf+sWyi8fXs+TOOEcOAEXtFEGkqGVhA
 0IAD+aOX1YcWA/efId2c/c8EZy4XqOoSliqOfxTL5iQEQAZnvld0Pe23ELi5Cz1yIYOz
 RvURX4lAPktXZdxlkA+BwQANDpp3VkSqtm3TTwYM0jiNs6yLGUKoLcHqDDDakDZmWnna
 Fvb4tB3EkvrgnjVS4ggOpVNjghkYxvQPcmIiYhwizkGeMeAinOphH9bvgb2PtGCeTS19
 giQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197065; x=1793801865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=OvnKF0qzb14H/GaZuumSvACtBHKKFuZDP3QGWfoYpabiAYNipsCYQ6VKKCgJ72PsdD
 eFI9JA0PI3Wr25He6Der1Hz7CXnhvnV7sr9hJJGjCYdYRmEUTIEUYJFJKfC7A5g8xbVf
 R7jMZy18Cj0EYI3lgEe/mQVaJhcZIJU3E8GH7WHEmIr/S0zW6Wr7MUJhFiejiugwpUqj
 dwvw+1hH6O/+ccB7AjWQKvjyx5nAenTH5PktRK+sJZa5817l41UVWfvLEeqV+rWJMwvE
 qetAKEOjWB6Se4ptDPV7pbVa509gDAug2/Cnk9KHWoDaSCqV2nCXYxO1MfjQ9ILoZvUF
 ADAg==
X-Gm-Message-State: AFq9FYK/SLNmdm3QCxKccJlxfd9GXN2QY9vuB6rA7XWEERhnU7EwBn+z
 nWZBjCYUgyRVhWCADi+LDaJyFE/AWJHTAsjc/ToPVOSIT6oUmcj2pSRgNKFIEb/fVQqBik6tMv0
 mzoxh
X-Gm-Gg: AYBFou3DLsoR6UDUoaMkTL2XjUcNv0a6Z+5xQ1eKqHmhIHOXXwvQoIaKM9fkpy/Da4Z
 Ezj9ci0ZS+ypkNqKAPkFhdKRHK0Zm7aLKUQ7kJSfG9qNNSgCUrm0na16vkITbjOV1mfCmicwV3L
 1fJA0MgCyCBadyiQ1nTQxR6gahGXyCODtX1K5XdLWE9H7dILC8uYTV5kpZfaf84wqb27q9jItVd
 mnUzFju5QoZtBRhpSnnwAg5dqa9WvMBAW98ANyalPFjnOY0s6ALp6U0oKcxGEsb6dXtgn0oypnE
 6Umhhd2sTbWI7ugEiZVctIL+P8a6h/zVoKZgzS6nE7lzNACa0NAIEphniTBvqJdXkPnyUztD9X/
 49OX8Tc23fTG7msvL1YGiESOLdN3qF6ez9PUmm5egRIbCzAsTtV+/wfjpuScaSCwiukEQQR6VAI
 PpJg+cAYLh+l8B7TLBlKMw1nJDK4jqvexjZmfvnIycKhSGM7iRUTIVT34y0d/oCw/gqvcQOqT/u
 aBHtHdZbLX63rn/fNhDvoKTm4cTWf9Z8wan3XsVFJg2ix48LeEeRBbdJrxUCxBdIr9ogCHNhI7D
 vkkPA9pkGibN2tb57D7HpJBiXvTw4o5RxxwdmSc/0ltyf/vLPyCQZ2PFkhM8Y4CWkL7tJ8Ldjyr
 +jHJ3+llbiA==
X-Received: by 2002:a17:906:b30c:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c49bde860a4mr228122366b.3.1793197064814; 
 Wed, 28 Oct 2026 07:17:44 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:44 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 25/30] usb: musb-new: set endpoint capabilities
Date: Wed, 28 Oct 2026 15:15:49 +0100
Message-ID: <20261028141554.3073545-26-anders.roxell@linaro.org>
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

