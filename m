Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D7606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzsxmvq5;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U0wLYbSe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0212E408F1;
	Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDyttlrsJZo2; Wed, 28 Oct 2026 14:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF28E4086F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198915;
	b=gQ6XjKjOpPynqaOlkhQDVx1dshDiQWKTfqlG4QrKzj5Wksyq1oMHTnhlmi71jIbwkYs0
	 qkC5AT8W2/qKYadiU51k8XDeK92MzufE8DVk3UG4O0fZoaaSEXRofGYJ6aG4yqX4hbdv4
	 ZyJQxaMmfLWzTeaw3SSeXUWKFwhmV4hsJIK8jqq0EA5IKphQL7GdyJW5an4ySRi6R+0U8
	 NH4xLYjvY8wZNVStxEREhMSYcummbtsMkP1zQkW2P78jmqJxyFXf+QkEWldnrIWQ64NCm
	 q8EPd3rAxAEyznfnnBozG0L+RW8B+WLfsiiJjoM1eDc7ojMvQitiHnLTlnApfZcqU2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	b=qWZpKYQm5olZTtWtAgRhmssCWi0h+HWFLOkicFb1uSxtvhUAGc3rF/bUoAuAsadt2ov+
	 vtkEd8TIOqYv96CDXQ9aM0Ji9H+Ihj+x08E6Ter+8S7IleOL0L3e3Byb9q3RCusJ4HiQx
	 URtgRQVIw+Ymsgax3zWv1Eo6DiFS52qpyT0OelWqUHMkMrffWz8h5ZXnTQgezV9gcI4mK
	 0arf+MsEd9/+TaSo3r1v5DlZmhEWB43P72Tpt7icrbQlH4sRZscBaNBJbt4G4Muqvqze3
	 A1m7bcXpezTz0CIs9s5nHby9kV7D4ADxjR89tQ7VS69BlKweluoS7IRZ0FJfbholHjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198915;
	bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzsxmvq5TOwxrawZAK4ESEqe5wzNVf3tIWaRwnNQFlvRBd1LXTIOW6cc2Zsf000DN
	 jAunexsI9Y1ZEQBBIiVy0GusDMQLuk69h1yS1B7pfcJceSSEiHDbDL/vzrOWxCk09T
	 1i6y4rYZXRMvJbBnglLGnfAnFIaPqCDFfJ9rxWW3OAa2Ex3+3iMFvHTH0l6+JI7FYE
	 tbJsNEcP8YS7s+ZwzcuRe1Kdhz3iJp4qvBhoSezRzGXciyuqEYbp4uGaT/gZRjnFa+
	 LilOkvEU54WNwBosqSCo4VHJaYG0UcGNjlZVnvFzeDaiyLBi16w/RKHNliB9imYb6o
	 tSfQ5G7ENaUlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF28E4086F;
	Wed, 28 Oct 2026 14:48:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB32B380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9167C80CF0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umj_uLt61vXE for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 811EB80CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197062;
 b=GYsiAP9zz8S+CcyAL8LaFFc/Tify1NgkfP6Tx1QM1mZJO4kwvgiWTtC2VOK+E28xz9bM
 Qa5yHlRFKczSu2HaYP9zCGQHw67PYUaei+j/moVHqyXCTS5AN4Yn1M5ClO+6L5bJUqAEN
 KMWg9FkgOPALnjiNIQoaMqa8aaSEIF0Yq/GK/13rNSrDXFpFixUUkrL6OoEPGXWQOvibr
 jQvLjAQKomXC9Nj5PkRxNKMHCVbcK4ilf11MIrClLSjhPS+pmqwsIhzIJFWnuNE/+o+cV
 qai7tHeIYPSVKRxXJTZzEfH5kGPmmkSMYN4UeGGQAf7xYH8QQlrjQqI+nESBxb3B4lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197062;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=VjDZfL7A3hyJEG000sh0302w1ZDUJabE5GhsZkImwk+NQxlbwYo9VcPaB1goXTUrCS5n
 8mBgMyPKq0V3D+Vh1diKM1+qmfwRA9j6z6+6tUW9u6xFd8OFG0b6OrZ6W0kiyH9FYyB5r
 advjen2m8mhQdxiPh/jGKXJ3iMVpWKYrQH21RS0mtT7xr09WZ1BNjE9O3I5Pp4ACrrj9I
 1UIkJijfWoMIXa1n0sjNftTmkjMluIk0CUvUG02qfm+VZNd51qvRgE6A+fuinl9LKt6gf
 fbuFH+xAk4b1zMaSiAp8zIvSV+jxV0yvR1yJ5CypuNmtgXW5sXv3IP6ZkPjesuVwopQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U0wLYbSe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=U0wLYbSe
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 811EB80CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:42 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10514466b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197060; x=1793801860;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=U0wLYbSeLhC7pMtBfpsRKld/lZrDSGyeQeeKxzj3WfC9q6cPhpA6oW3fokEAIWc6ys
 BuzEWL3FP5O3Td1PWk5V3INqtEosD+TBS1+KPWqTbkbRP01L9PulBJhIcuHgSbWFzzmB
 TDiF8ymEThK+WhxX1yYKcbou9aUmA1ycUMS60lyRhfe7U59fiCPmMOkEzmNJrs9qbXJB
 kvlvOUBEipe3qtSvIaLS3vkXgthQRaBfLErfYq6QadTAnodnk7kYt4gjkIdNibOuksjA
 Qri/s9dW4xmwFUhtGMWyt9t3ld13OfjNhknxHwdTR9TZjwzkK9/TCXxnGmSTwZdO/EwZ
 ZkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197060; x=1793801860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibjXcSl8e0eFnoe7t7MComfhh/8wURS7SJoiQquFyVc=;
 b=i7b8WqvU6oE5u7kSoYAopOzJDe4Y58ltWuVMKbanXWCfuFy9I3efCBbTcOJDHvhc65
 uointelrbrJJh/burdN0oRF/FMvwPLvguFsN89a1S8q64NziwhBwrmLKePKcMtdQU1x0
 vhpjOmjPkkc/D3gDZPOGt1vWDkWjhFCshmSlglZWaWrPDQm1UIlbYpUwPGBm3Vchg8lz
 aGtwKtDHrA+isjI9GaZaUDp1ygWHkrmVmTwp+uIueV9idKImWtpSiKWuMCjSPWLMGnnY
 2xrfdhosSHaehEYGH5etiFBxDWhetnLifKmLQs25KAWS8zNYWo3fd3eQx7xHaEDyAs0i
 0fFw==
X-Gm-Message-State: AFq9FYKaZ4fp1kOZYxbk+AVF3eBV7sxBFk3eAFJ76KY13+cfo2/rE9WP
 bVrlka6MTiDDZU3EWOqqRBgXzxPmCAJT7Mvg1zIVT+7FkhlzBJ/eANmZrf/bUUtfqAacFJ+9UoQ
 jBl+T
X-Gm-Gg: AYBFou3mnQZXoA/xhDU2/0mOaySnowgpIqSHv1vmPHGz76WaMgxIr1j1KItJkx320l8
 uRafc113EdzSqEitx0aLxXh2eQmMlAg9tNQ+5kdfjkCckSsj1A2iZvujA57J3ijehjdHxCGfJNh
 vvhthwVWZEd93b2sXiMq43L6UQcCDz/0rk5O88IwmsX4LCz4a2Nh9e3VT2+Drot+GFyHP0JeRsY
 qwIsLK2JKale+nW3RuDP/bTsf0aJQnv1nYMitGWLrr3ofnD5TYkcYzbOk4gZYt4VY/TT8Ee353g
 hUdK1lD/ob60p95s7m0P2YtQ85+ro4teuzXLFmaZM8j29I9ZJxmphfFuNdotxfM3IG7Wj4ZIlWU
 C9AOZ5LJZPxbXcDPeu01k7V2oJ3KTfpwmoSu7VagcRTp/G8Yd9UmME7k95cNcMaCrvZeCo2Lnss
 JTIbN/+uiLfpJOxRD7QHstGtEd3M3TXjylzrV2Ck+gH13qwVcnnktOjObeHUVXfZbP/gdZIDwc7
 Ca1WZJONOPVMY97rDhJCn2yAmnCUBVloD7xKf/pn17KWRginYowkktU0SBHylkcyke4ef5iCph+
 1yrgPUgnlpYu9jpCzPqpeSWVttUGisl3O0jfyy0eDyn4f0tRA9qyg/ASNIKv2xZ+2g6S9VNALbS
 DeNfb0NdgKw==
X-Received: by 2002:a17:906:5a73:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c49bda28beemr270987266b.0.1793197060204; 
 Wed, 28 Oct 2026 07:17:40 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:39 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 21/30] usb: gadget: atmel_usba_udc: set endpoint
 capabilities
Date: Wed, 28 Oct 2026 15:15:45 +0100
Message-ID: <20261028141554.3073545-22-anders.roxell@linaro.org>
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

