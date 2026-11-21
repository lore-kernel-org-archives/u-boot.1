Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0C606A337
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rw3P5Iwh;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tmWAAxm4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E463060ED4;
	Sat, 21 Nov 2026 13:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mkfVqLWy1F1V; Sat, 21 Nov 2026 13:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 237426079F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266881;
	b=Uam9gJeeINR6HYU0jAsH2r4mBt/7npu2bkQGZqd4mfM/6+enE0uLUty41J8mkGmUHhGg
	 u8feh3yP7vB0pWz5bIAdro6qy8BHs5ZYqpx9kO1c5NGXPdZE+rqrnbv+MgCxecEtr7qLK
	 78DzqAkDyovPMD/OtISlh4L/ILTb57X/Gt3Mzh0L6MeiAAUQad8BIiNC5ylNJM+XsIWiq
	 /y8saItXv8UPn5Ocbo9duZzk0jmSViwZz1+liw/Xd27AxrfBQfP17Nnqi9JmPjRl9XvjN
	 t3HEs5jT8YFlM6AZaWRHXC5ajPOxyX9iEnI/xrAy/Qu6O05ucOYfbV64aNCzRU8fLyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mV/HAN0pj7nbCIkSCc84l1FyEJ+iIVSntjtw5egmeXE=;
	b=qDriIhz6xcvPDf0EyI3OO5MZVZ4dVVf7cGUwP8P5COuqLbzA0kI/X3BrP+Xp5Dhcw41Q
	 PkjCIdc9Mo0jTLSbRcFAIvJDwqG9WuSg3Ow2d/DrYIQVOMgpO5GvSQLDelemHFE5uvpM3
	 vFQ3Ce9sx30B91h1ng0Ze8jj0Wk10MtSf6FHu6lrbhiV+0Diq4u1xwZZi06Y/5dJ9uEF3
	 EzGUPsa3PR502IeHK9IkHV3bHSIuR+W8rAoJqplxKRC7c8KlAOE8TIBE190U/I0Cd1kSY
	 rJFezq2pH6+0UEN+YGIqkkiXM3wBt/fiyra8k+n+O5G74JL7dMm39BGbbPZ4nvo1TlQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266881;
	bh=mV/HAN0pj7nbCIkSCc84l1FyEJ+iIVSntjtw5egmeXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rw3P5IwhudX2r1tyXPhEvGpdxSxIekvpj4gPHk8RWYPI863qRuaOUxWTarA6pnt5R
	 JvNj0akin+e6tdGWcEbGXg021m8ffX8rLw06j32Zsw7jHzpfHxNUIiewIhe9uFFC8q
	 lmRV8R+9F6Nafn8GiMCMTWXvC0Wd3EuJNHdjybl8jFugyexai91+XoW5a/Wy1j2Q56
	 iIgCCPlBU0EeTEtlBtcJ3V8tt6edXjapdG4gANLtHnd+GnQ8VifRWdv6QlzJe3vyE3
	 z7Cka5rjy8KxkvQrQSQIO11PxRGG25x4f3P/8ashohaVCMfjZvUe3kled48go4MVxt
	 dwQ16lQJ1QXzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 237426079F;
	Sat, 21 Nov 2026 13:14:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 481A7A58
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E509405D7
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3i4RxYnEvAZg for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F28D40596
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tmWAAxm4
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F28D40596
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:48 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c504707acfeso32950666b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262087; x=1795866887;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mV/HAN0pj7nbCIkSCc84l1FyEJ+iIVSntjtw5egmeXE=;
 b=tmWAAxm4GlGSzNK2FQ27REsLC0cKdELudRYRlfWy9+GIOShWaL5cIlNitX3iP48/zh
 1TEkxPuumywM3WeZcVWsBr18krNZmEUmckvoRDhWO+pufTrmqXe9BuF9kLeAx2QCJW+g
 5Hy3Pt3qAFe/rJQVTaoQxFQ+/7JNz4kEF+yjtquPjiO4qJynqN+d0KRpRKlHovVzNrwi
 /FSaihXAugn6Jsm/M2xOL1EPlcP6IvJilQoxedmwjRzlx01AFWWG6TruHNJBpyB9mtIC
 zazmMWGM7MhVMvp8k+lOh+BcTvfUnhiUlJqDwZWH5oYE2oCXkrPF2D/GPVMqRLAi92+X
 R9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262087; x=1795866887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mV/HAN0pj7nbCIkSCc84l1FyEJ+iIVSntjtw5egmeXE=;
 b=26k23J2DEnoDO7/tbUBOmXJV3UYHh4+rwWCn/mMcm0PWDDckDabvcKN/oreACesWiV
 yPQtEPxhhBszgNieiM5xWOLideUwsTGqdAXFdzzTP2gNmXc3dHmjsometR3b9HG0XH7d
 OCIvEQyO2+xhGFoMxt2GTw17bEhPCzIF0WY0T0ELmXGm25hp+8PbyXywQvkjfkSzFCYm
 AHHtMeS/hG6/mCzvqfg4zBp6UodKiCeF5PXiD3m8V/IwzmfDyfFO0TJDEkxYNd4j3XlP
 1iNbdOlwfCoAd5dU0eh8SKSrHzylQAGsYWfZrZ8uO3p8VcQryaQl8j/3PtbbLQNbVEqC
 ZDlQ==
X-Gm-Message-State: APuU4Z+uMRgSxkalxrr4xOXtSqDflV4mZsrB93wdbGArGVt3QJaXPwme
 maNE5byZs3xiCqSaQAXg06xKCEmc+woW72axW8ooE9ABUMmFK7O1shwHgpCptXc2Bx1nqzJTzDa
 AtItW
X-Gm-Gg: AZFdTZe07phbfLQWxnJcL/xh64f6bGhMEfxW+gWERHIPVwWiK8d0xW9sbO1XPGJErIH
 UhyPhT9/szP00UE6xPA+Kbm+kIPgMYsLfxC4iDDIMrBGfqXhZOZQdC9sG9he73wwKVHcGqup36Y
 YhyNIEPKJ5KpG6zCSP3Qkmyefrr7lEoh2N+YyO+11yJzoo4suvEMSdlw+Id7OruDhbRYIbOlzD1
 +Vuc4BYYNwyPWsLB80iDx89r628tB+jdGl6+ZYILApuUCzzYs9kvq2AIlzeYpyMLlpcjQVOkCGO
 C0LSaYBvlpB0+zTqUhiOonsM9V84YoGQAm9NgM/JLmFtHB5eCS2FhggqmTNE5hg0cAXdo9PsOqe
 MQCiCAETkoZVTY17AlUuy5gVnqGHY0XqjTDNC0W75rg9iNwG9xy894j6A+15srXFRuLNIhkyQY+
 UxoHEUWC5aqznCrksCUkitbrammW04HGSbY6/C1DUi7O3VdgGf5CbOAhjnmTlfcAhe4qzIwQzUf
 GqTwUv4pw0wKnrw1O0fzRYUS+FM9dbUTdplXdCert06j4jhii5SA0WC3O4e6qJYwaJcSmXd+BLc
 cW4mAdx3NdHMtaljGLWW9C+lPI+IZ3Qei0vYFYgVbAAhrvIrwGZYiXhZCtrwua4SkwVtNupYysf
 0GvVicbIsM3TFf8dysrgmOfeVK//VaGo=
X-Received: by 2002:a17:906:2b5b:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c513a284994mr484629566b.0.1795262087057; 
 Sat, 21 Nov 2026 03:54:47 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:46 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 15/31] usb: dwc3: gadget: flush and invalidate cache
 around transfers
Date: Sat, 21 Nov 2026 12:53:19 +0100
Message-ID: <20261121115335.548142-16-anders.roxell@linaro.org>
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

Same problem as ep0, but for the normal endpoints. In U-Boot the trb
pool and the request buffers are plain cached memory, so the controller
and the CPU do not see the same data. The resync dropped the cache
maintenance U-Boot had here.

Without it the controller reads a stale trb and no data moves. DFU still
works because it goes over ep0, but ums does not. The device enumerates
and usb-storage binds, but no disk shows up and the host gives up after
20 seconds.

Flush the whole trb ring when the endpoint is enabled, since
StartTransfer makes the controller read the first trb right away. Flush
the data buffer and the trb once the trb is set up, and invalidate the
trb before reading it back. dma_unmap_single() already invalidates the
request buffer on completion.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 13f34c41f95d..9bba1c16a088 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -947,6 +947,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		trb_link->bph = upper_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->ctrl |= DWC3_TRBCTL_LINK_TRB;
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
+
+		dwc3_flush_cache((uintptr_t)dep->trb_pool,
+				 sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 	}
 
 	/*
@@ -1385,6 +1388,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_flush_cache((uintptr_t)dma, trb_length);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_enq(dep);
 }
 
@@ -3155,6 +3161,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 {
 	unsigned int		count;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_deq(dep);
 
 	req->num_trbs--;
-- 
2.53.0

