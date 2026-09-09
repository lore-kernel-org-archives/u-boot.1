Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD6C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B949C4076D;
	Wed,  9 Sep 2026 12:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oirLeLAvJsnD; Wed,  9 Sep 2026 12:46:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54E8740758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957965;
	b=eaNSzBcN2Syd0rrUN0klUCbDnhE8inp2VcLxxMH4UCHEkY7/jJ1hEASCsJSIKY64ZbrC
	 fhGSwPCugeDEwAUagSrZdvtK82vYZLl1CrwopDSXqRN7o4C+OQpXqmLLALm+7nzule22E
	 fmmo8PTyisaWcn6bBBfuy7gO1VotfS9Q5YqlMrngIyiI1D12WawR2UWBaUg+pscdlVn8H
	 qvpzuvAH8kTGloeYmidx8YF8HUE3JTV1UrcwYMvwrY96zxyQQeQ2+SbRMEZBTpWt/k3Do
	 UZ3BdQj+s/O3uPikt/M4VCdQaFmya/iVMX6jovMDl7ZSL/TmkXByZ/qG5glxWicXgAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	b=tGORu6jar3/rcaNm2rdKLkhrP8kndYxErfSTP9+5KvV1RJKhcBewK9VH4bi72RWjZ5K7
	 7bnmT3OFFuoq/hsq3+MW7NhT3s7H+24JAu3qnjx8Ie7TxvKLc5ECDcP3jdbDyb8GJiDPs
	 GSCHdPjK3rumgnv27HLAgdjAJtkNoT2GbzNnul1kCXTBfxiiyDl+2cIVPvsfHei/zik7F
	 wogfs9aHTQI39AbCQll+M4c9h+utfQHBaGq3S1HSXJa/oIGmPbN121FaevELd/CVNN4nJ
	 pgPL1BPIJnAZQJjcUTXVO/rgoUnaW1SQ2+qwNK9s3N92rgLD6X9I7ao9ukYMzQQWd7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957965;
	bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yuudhvi44En0nKs9wucfpJ31XFv7nPQupAa5t8xu7gojz79iPjqaxGIGbmyFSI1NR
	 mY0H6HFw+5t26c4rFvCowSdG+A0F+RSAC1nOZJX8/0ly6ZkmzZztp9eSO+Gct6DgLE
	 uXdY+RLlZiXzPppN1KBRcSMTRpx/U1oF7JWpP6xWOAkfOy4JpmUzlrTRLfN/2hicnO
	 Ci1ad7v1e9/M32riaxs6B3hiTpaGHJS6JPmhWRHCtEmOOOTb8y1xwqc9ZxTJdR4Y5e
	 umVuLdnnoLQIRR4yimw5FLQubGvOTuzeCWtoaMG7AL5dYOzwDTsaW7HthyzJeFz5md
	 Xcwey8zKDA9Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54E8740758;
	Wed,  9 Sep 2026 12:46:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E048769
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F5C180D3C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hs7xspZx0g6Z for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 86A0980D58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943881;
 b=iXVxQOdBfqgV6pnI2SmIbmJGKLZd0aGctd57KluXi2s2Z3cFOU//d/amHHmUQfb+0zEF
 7Bx94+J/8gAxs0x/DAhpg7TXdtylSnfcX3W3xuVdqoVT8JI8dq1FM1V0BdhJWYjBNmB/n
 wUTL/CDZRiOtNMWK6bXBXGhGRFDPzKCwN+8hgElnAbMPoFbGYfnVkbjTlx+04/e/nYoCH
 fX+EMG47snmtUU4Uu+Y7WlrriR9ehFMD+FE/FOc3Ekb76vXOzbPd1J7F1D4Lft92Wvos+
 QlAw4eS3v5yilHDve3KDMgOocup6jum/TbFlUC6GKIwqk+N6MrSpO7ozk4fRCxG2UuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943881;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=Yd5l04nZ772I8lB59+jAPrYzxS3vOGkQDmZXqtbkl3TMicH6I9Gxdf0awc10CyEraOyK
 SwQ/tFI/jiGgF2TJmDVKDW8YMIfTcYh+eLPWO5qfrvoUDXUUxQa9WUKlac02n2OvbwoXf
 mw2yNFYmcITplYgLMcLCb6HhM9ofsGHNPcJlIdpZODuxnYuOXhQmQANQgt0UKnCxK0M1B
 jXuskSc4ZS1kan4Kz4kr6wV9dr7C/1lfscB87Ayd+ILRfRqF8z9/+qUHdcEf8Uaq6j3mU
 6RpBWRFk/jSnPkmAxu0YsbQsJr7D2lboHfHv+YO1KY1ZNEyCSfXzoT12M1lV1SwJujg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=k3gSNy+h; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=k3gSNy+h
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86A0980D58
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:21 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25085f2422so66517966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943879; x=1789548679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=k3gSNy+hNkOLzFpa4+7ooGNNW/2sQ2luMmZ3AlIWwsiaD0UhgHh1OV6N4+svyWwa7Y
 T93agC8k9FrvqxZuD9GVQm6BjHg7Ie0l+/cLJD92yVnsufO9xNlhDNVN5Ehfe08Il7Wf
 RfSSuRlXYrgtTHiXCRNq7AMxs001TlB6ngY1f1VggiRoqQdL0WN6Br3DnscvoHswCfyW
 IPZuKje8Rolf1Dd25eAvkZmDZJIQCweUbgBracxS/j21f3dQ9KJilTbNEiOi9EyRTIf1
 kbmfxC7xa3gHgx39q9w5V28MAvdDxXJOC32V164iLmtbbewzCIlGzDFRU+vvxncvstEq
 Eniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943879; x=1789548679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvE3Z5jJo58BdvFrg+hdn5Yq4bPK6YDLXOU1vfcZyTY=;
 b=PF2/q2B65/eE5C3EKRVGPhiAAduZ12y2rKSr44e+IyT1e1yZDJaIFuBbr/giMAGfEW
 nxlrQ6acD5MHULTqRbbGhJ6Jqj5GOUyn1X0wQ/ML7GHdjY6M+KiysTT8HpsuDykyo76f
 4E69KutTFMsJKZrGFP9m1Z/fV0kJoiQxx6yBt+m4uAHlscYAmitbf7SRytt0TRQvW2Ue
 xb4J/2STYmNR+hqdVj05hDtkbgvYSyOStS3zjU7R0CqdB8cPiGSsX42+GaBfuR4odBlQ
 z7GCfvWKAZsz+WHpKCz1Acf/ZzLv7cR0H1ceR/5jsmSkfiw4dinUNKQOPL/a2zsE0EHR
 U5EQ==
X-Gm-Message-State: AFuF++mHRddtlfwjXNmX7//Uobsxghh5QX/h+sOxkpBR8Q8BI6HbOnwY
 FuAG+DJWzao1z6rEquSeCOr5UrE7AxoVTofoZtFSOE8E5QUhIn064PnxxI6YN++YlO5vhIVnwFq
 tBmuy
X-Gm-Gg: AYBFou30ZoDklY0zbAYxeH6Ut5+OWSQZUY7mC7h74dAt7Nav5vkU7OXcdtopeNawYs2
 xSYIRZWYsMddxj4RXygGRMaThyUafo8a+00jV31Ydekh7rXXSaMnU4rSYGoBCnuF6obbfTrGiyl
 i5WvdUBb53sXAvTUdQBg572M0gRYog/AjU9OUTkvYt9wfY/PJtDB/e8fDt4VQnHgCwTPfdtWF1k
 Nd7mnOz9rqQLtSyow2RELKqnYWOhKmuNd+rK+NUvtZD0TwYrqRiK6ttds6R3PFkNFBpmHWy2Qqo
 0Ndcx6p2+YZW28ZEX10Z7lN6bW6X2cvzbLrmhJ24v3dh5TNbVEWOvtTIKHGR2L93ZK4lKBfdPoa
 dPXNO1fbXotwt3lzlx/cEvpljKi1r2ZOvX5IYB9odkoFy9uBTAOJW78cB9+POw1GrWTbGKe2Ni2
 5u4WpsCcy+4FuwWvd2lsym9nSuKYJUJCC8YE3cr7rFgQyOEpGRbiqsSzEb8027d9SN7RbhfMvZa
 NAPE6q+5qUV926U+MLA/Zz73WtMMwqE
X-Received: by 2002:a17:907:1c24:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2624cfedbemr999392166b.0.1788943879121; 
 Wed, 09 Sep 2026 01:51:19 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 08/25] usb: gadget: udc: enable async callbacks on bind
Date: Wed,  9 Sep 2026 10:49:58 +0200
Message-ID: <20260909085015.2480097-9-anders.roxell@linaro.org>
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

