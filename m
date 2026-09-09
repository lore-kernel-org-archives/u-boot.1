Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB7C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC65540746;
	Wed,  9 Sep 2026 12:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q4GZiC_y_9c7; Wed,  9 Sep 2026 12:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9EA1407AA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957978;
	b=UhOTtgEsuOxgqyFpCgj1P/+kJIGLRtaGsEizuF0W55j8d2XAvO9uwaNUidz1CA3RgMaI
	 juRyumlPVlR80sCXUSQV8sZa7rKy+VEwJoHiItZcVasQXkq/HD7DSPjFZTAxXd922W7gc
	 +ZzAYP6CtdEcQEfCOHqL8vMBcVVVBW4e+TbU5FgGVknwDRI/p9Da2AtwfuRVWGWwSxRTo
	 0H1/YTBsd36U0meZOSj9d0ktBqSvxVqIdj14DpMPyU5UmLscYObx5cpIjibiBT3H+fzch
	 NKAv2vBTqOiUdWRA/oR1YrXLlUaXHCdLesnjB447TjyM6f3uk6qtKSkTY8bRS9lgqGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	b=WbW1KbahOXHx9wmwY7JJtTD1JoVrkH3B0Z1vsCOtHVQbsEB1T6XDznEh50yP6pP+UXOv
	 NNwvqGwmAK1x0qfFQlJAk6u/d+02g+9N2M46phaUNNgZQ52efZzfISth45UE2epfSpMSH
	 YuHbXgw1KytI19itFkB3iNjRptIPgFzOasevB4ugnhC3q7urINSax1lx5Sb1/rXxFQl4K
	 YnqxnP/YWeGy6Xh+//3UvwexMmPkhblouI/eC0rwqgeAQzxX+V9obi3EJ8sHm+v8iI9Sy
	 Ng8P+36+CUsdl49xdnEGZjkW1bghnClw39d9NpPMZQywYpz/pPtkjdPv9lh2NFHuX2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957977;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0R4nuY4N0FYB4HAiCAZjx70GkGYhJMULUV1YpxTFavUpPEO0p726Z0MfnfKvHRep
	 YTaoq3GDsXPeRixUqb+WyDQg26JTAJcYzEJQtNGPIBzuslqsCf11AZmsDv5wt5yu2C
	 g2Ijig17XMXR+jDleUd2wO78DRFfiv3BOQKBEz3T9EfU9imUFsysbkNrs8u2zETb5f
	 rOIzJGtvVbEJ2C4BnWgDCD+Qltft8z/xPK0vwGTSNmfXgC73p4qFATKyBcaUjcE1ES
	 imZJopdP6S9f78XIgIyYG3JsSIyvKMsITsKUbvzN9h0y4J76mB7hsbrPdAT1+Djj2Z
	 S2oq98wGODwag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9EA1407AA;
	Wed,  9 Sep 2026 12:46:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A823AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94D65400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xK9dXiwxpAer for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 729E940055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943945;
 b=gkY45j0YA3+cGCKTZ2aWps3sHo+p97SswzUt9QlF/AueXDnB0S7MYbKT9f3hnZG8OwYl
 wa3T0LBqkcEpvNQycwo24EdTjs5+oOPQ30trz321PKzayE5biqma9pl2jPKNSdv8/C6SX
 qbyBCEbwLXzqYYyUOYK5t/8oyhjGhzy8hyMqJyH7XniCHSzbY6Jdc7qa+lDE6+DWnEZBp
 gJBFU/CTPrjgIJxfM1NfIVy4oMgR7J2V1N72Y9p9L9NpMo77SvXl0qupJa2sooAdiF4fC
 KGxUdOERyJzsIeeW0s6K6f9sPpX92gQkFnzXFToox1FFEVegZxR/lQI1cu7raLq1FYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=KseatP9tni4+OIhf7OllgK/0JaBZwPtOK4bt7vgjBmDt8+DvKGoVu6vsntqVJMjgn1+8
 28BkJBZlKpTwNRQDBTrBAm5pIYW1hsIf52r3rGAuW4oYBmlMl7CZBRthheuvopE8nR3+K
 zof+s+Ob8gOep2QgJ5X69Vsji9pADrWY6QDNWe4Z0cRdcoUcpV45Evp+049+KbliqIzfa
 l3QBcWT+YYswRJPiSQL+A7/OEf4gIEsdlXLe8naw6gq+v+2S4Rqb0Jle/X0etRGuMK6yx
 4pY4tPCPJrJaK29+20RdiZGF/G08W8LxhQLT6cXdvL06XJe+xbtuMAC9RSpaTufzD5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LczgfJAR; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LczgfJAR
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 729E940055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:25 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74821566b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943943; x=1789548743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=LczgfJARUrguy6eJXgP4TlrapmcQ2DOzb3m1U129T5jxiHKBbYhfNnPTsSVH7T7WYG
 zAiEwGEojjmlqmdp90ex8765OkGlosekEMUsTvSbTLHa313kOTVqNtu1Fp5T/F9gYkis
 xSszGN1aaosNPtknpyrwfFUampKSS6vnwi95suzIbaAWofkhN9UaWeMw8jCrm82/rcPV
 659H76buwWo/IbqOuAG6esKalJaO13uxdZC/U/4m04bI1CUiAYm8O24Z7BeXgZ8K1ORE
 SdfEd+5QldsQFs4xU3oi0c7udZC9QT3YRdYZbWhtFDj+0qDE0zAkxxbaMpS9vnQ8tY2A
 TFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943943; x=1789548743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=X82EVLnDu6BCTS1A+e9sjoe+ssKI7aY3vzMahXE4hpmKJN72/MInwWuFHOlsiaxmyw
 XfYtBV4kLAaOOu/tgS1+uA+aP/X0CCQmOOjCIs9F+/yKHWyKKTFabJyH+cW46SltCGXG
 v0qSRB0jsP37i57vddbLJj9LDSk/AncQhDumLrZ4OQzURgMYqTzgerluvnp3gbX2UBG3
 NOCEQXTwdt19bIyBoOk0UHdF+Oxu9R5qQ/P0OSz+DBPPUbsU44WMnBOsARDxXfb1nW5w
 93ZzSmXlRRwvT5a66Mkx8QrbBiyjzgBzd6jSm2LMGTMKQF57gkoyWgn2YvnlsrCpCwwV
 fP4w==
X-Gm-Message-State: AFuF++nZ2/sDr6Hc1dPC2rWjVt7G78WAn1VPKk9V5LBG7pT+OLzqP5+T
 YM4ypYDe5Z7glX9bixuV1qXxxy+YK+tAI7pA+GxJwDcX4s20wjXV7yDD/xzMDqrVplRs28NuBCI
 zSJVA
X-Gm-Gg: AYBFou1JPzdvFh9NDdChzI95geckMy4+KZntxkul7bQUFieldpGp/RJNibhvPzghHxa
 ClXSjPxFIV3RGQ5Kf3APod1kbP/5O76nuvjISvo8zgqW0bFIx0HqKu8CjqwXJhezQpYu6Ild8av
 v6OTDFfwrBa7udznVLLrGTmV6rGMLtWLFwA1AMLLY985OykS63hUH4fNPFO0YkdxQTUAeAbNezd
 ZYP39gfYidbSie3I/MkAWW7GcgvYLnx6hLtnmoxX/wZGzPWcI9vkY2u4qrFbsML3rV112REcaSJ
 ZbXtJjGM4RrPe8VsqRTXenTq+2O40jcYeacVO7XZrjoV6UhvSoZJBeN84m9YzA55o4cXG/pQxbI
 I6WWYWIIFG3ScbeNFyA20+6Z+cLJ+yf4wC/G358Xr1QxV6Wq9KtvT/h8NWRcYnkRF2ZwY8+u/bM
 yxuEmhOPQkPb380sQ71LFkWfgxEphtSBTtJ8bglAHM7u6z2Z0p/H6yxjmX1vYhbcqjHkdxMcvNG
 3g74VIQEVMjK6cylEztJnp7t2zH9QLHow==
X-Received: by 2002:a17:907:c645:20b0:c29:192:e9bc with SMTP id
 a640c23a62f3a-c290192f40dmr374130866b.3.1788943943491; 
 Wed, 09 Sep 2026 01:52:23 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:23 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v8 13/25] usb: gadget: ci_udc: set endpoint capabilities
Date: Wed,  9 Sep 2026 10:50:03 +0200
Message-ID: <20260909085015.2480097-14-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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
name. ci_udc never fills caps in, so usb_ep_autoconfig() finds no endpoint
after the resync.

ci_udc keeps its endpoints in a static table, so set caps and
maxpacket_limit there instead of calling usb_ep_set_maxpacket_limit().

The names say what each endpoint is: ep1in-bulk, ep2out-bulk and
ep3in-int are fixed type and direction. Entry 4 is the template for
ep4 and up, those are free, so let them take any type and direction.

Tested on an i.MX93 board with ums.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 87194601f67a..69616b16b052 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -121,28 +121,57 @@ __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 static const struct usb_ep ci_ep_init[5] = {
 	[0] = {	/* EP 0 */
 		.maxpacket	= 64,
+		.maxpacket_limit = 64,
 		.name		= "ep0",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_control	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 	[1] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep1in-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[2] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep2out-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_out	= 1,
+		},
 	},
 	[3] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep3in-int",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_int	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[4] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep-",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_iso	= 1,
+			.type_bulk	= 1,
+			.type_int	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 };
 
-- 
2.53.0

