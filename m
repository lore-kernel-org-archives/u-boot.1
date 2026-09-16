Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6FDC982C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3BCC6086D;
	Wed, 16 Sep 2026 13:09:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txC15pjYTgcX; Wed, 16 Sep 2026 13:09:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 063716086A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564151;
	b=s98tGUfnjU2MsqgvPbltT0hcQ7bUrKiP+3HOuMhqf5b2zouWwwe2NrEjrL4LLoXRa5pu
	 +CraIlvDpHlbtbg23J77SVMe3rkp686Z/wJi5qVPMvWKrdio6tXVfjcpnmSyQEGJ922ti
	 YeZQw6tke4Enf0hqtp6WWFq6R2Eca0R8cpb1snVkmJg2xJcgDXELgOABjpVdq4Wc38UwY
	 klFsht7mMjHF6jkG95Y65D+cWVryZkNiqIFaWkioApBysHWhvb/bkPSv5TWjGDMDyB2e6
	 M5vSpnkHgMH/cCg8WwXmXPw0vsdyvUZK8BjwULK31PXKbSIOB7/iR4kQd3lREo6ZpsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	b=s1M070UM9JY8RawbRYOEAsCEUXtsbbTGQMRTlL5/5eyhZlJVsHXCYHbpFrqcTEFzhkt9
	 QqqEpKJr/iFEi/O8+itLoyg+KMF8D4NYEpQuDnXr5/m+1VPmxjMnwOpx2Tn+NHJyx9FfD
	 vmzDP2hC0GEaHD1zgK38VNygcylwlF7F8PBzVBwzji+mN5I2bdLky2gVXDNxiGWNC6ZMd
	 lrP0AwYsJFOa+EEC+2lq1CSrPCQRXFDcD/8CYfQRkfnQMLtOxHc03GzInIHVeeZ2RRPDT
	 PT1rbpR8XnX3unK84WO+eEaaVvCSMQ6Uj2Gdw0JzbZsH1fX6vnCewSUpcrm1AXrLUsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KXwvZSH5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564151;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BWJxat+708iZRjh+XApCGKA6YvoPADXxcr7qe1F06LKd1CbAb34zDSxVMUvHKVGDt
	 4X+heGDi5+xCh4BA/9V3jVaaYgRNFZmS1nHwl+Uy9LBT8s6Pw98tIAVmk3fDMx+y75
	 vejuCV2XlV2xEdMuodDqOvHZWeni6mbApe7DeKVEEr21+TJ0rKCYD+/tkFHzi63YiB
	 Ipj7c3sIUA3VzZDEp9yDiEyY79VNj1KXOWDo2VFoqt74coCglk+8BBTKBAROL2ESr4
	 Kb5k616MCywfBLty3OmvGwRMYqFErtpEoFfO8UNNEgbMnw7ueYdxv2EVR79obtW54a
	 V2/jY1AhbIRwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 063716086A;
	Wed, 16 Sep 2026 13:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E9F62E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E901B607FC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-31jwFNOAUd for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 24E1A60812
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562438;
 b=lE7g15kyE0YmxiH4wO2ksoLJ2u75uyABMGUeJ+YOUY9wOsDewrL2ZhFXkWXtCNepFvNV
 nS3uimgGinF1GPMT9ybuOQxcTBwBopdsqU+BjQWYU29YR7xLIHZmvA9DC4jVgw4cyTsxG
 DjYmrWKap1v7mAfmQz+EtNtEQK/8XWBzNEEB1xGTMl0OllX8USNRTroF0oFvh/6VrVj2a
 eTZ7bNo/5rax01hRY0HDE9TRbzJU5H68hCQ96wROZYFbJ5MOCfc8RbNp8UPawxKckaYGb
 xboasb9V/rBf2TN/O4LUDv/Jzf3dzV5Bl+R4Cbw7eMXsvKEkhPXxQrIjpH3SF6xnTrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562438;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=AcrDRq/P9DNAZg6UcKrHww//X6WfjHGL5IuSRkx3pxXChXSsiJKtkB+GHwUAal8D/Cf0
 gkji8MISPhPb8hLwVksjD9AnPZotQWa6kJFSbO95IG3i7sc418lFUA2rXTCFbRXJbTGAV
 39J4XMPSRUgmdnGeDEli7o6CuPqgRVi4nXyrJX3zDy35HQ5ZLHv9QAJslea1wlh/MK0o1
 9tnV/BhFi6XxY/MBKfs/Bm5LTTe1Sc0k+WWMtNIDXxXfWRObAYJaxhq3GhBFBJJjBaZY1
 vYoZdo816ZHBporh/r/RP3o1QCPWACxBb+QXx5dZeznbn6sAQKiH5hekCCmwZWzj/Hg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KXwvZSH5; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KXwvZSH5
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24E1A60812
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:38 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25085f2426so10672166b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562436; x=1790167236;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=KXwvZSH5u73oJXqdY6qUyn9ViLRykB23cuF1czjhH/SPFB5c7ii7nEYGR+DqjjvhDJ
 9p8QB703VupdsGmzVSoa9fPGj9TemW+gJb+8h3v2Ps/eaSvIYMa2mqfG5wuOZZS0LVb8
 ICtt+AnX64xG37csulUsbNYmKbwyn4XY6Z4W+pP5R+BXiayNOnFrK/z4mIx8Bsa1aJrY
 ku5BZo7CuwbgjQd/st6hoOvMvuZauupi63bg58qpGgqmPfBxlV+doHvWx6dU3iX8it6R
 Qv/hr1k9OVlhGDSilNDIvwKi5bpv9ZenEaq+PMfyJrJpNiqkbwOd0qfZueh1Vf13i5FF
 QbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562436; x=1790167236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=v9I29UC0gkqsX6CwD1cbppRAJH3IxqNWBrYSCWMCYx+sphwVIrZ22+ZTBZODXRx+pA
 GYsstopBFv5jEQHkEcqxc7kBYwbMBWQo/81l8JS33L0zupYPz8i/qjdRKK+esc3aUOOX
 X1lysTtG7s/CaV5jJgIybMgMpqgcVeHO9W0rERHi+GOjOuHm6YJTQoGIen/MvjxAp5cp
 T4O77Gjh7EJD31zHxVwlV/gSyUpZT7SOvT8dfu+0AHUb9ub1leNxxoiJYomDmnSS1tv0
 kIeFm6Z8ftMAm5VAy7PKuCZ+jgJdYDMsWn16TX3uWfrvOnL2ThkINjr9UmEr0EFsAv6Z
 YKew==
X-Gm-Message-State: AFuF++lERUrdutDkeJMwNjFXO9R2vfTiV4Hb7DUqQaSHfIeac2tqRfEr
 gR1F0pCTqxfwBI/tTNRj6uVdAz3eXjLMGmpQCNS1TcD/rj18y4QlSkzYOhMH7mUJaUXxaanTRmg
 HqR2r
X-Gm-Gg: AYBFou1aG8gJMDrlg8ETQNtyCWS3OqGnmLFhfyKSbBv2HOSFLYLQIEHiCvlMDx7M1FH
 gIw8QymEo0g7fpv36X5yXzO06hnI78rB/YgKMbNwVn0Pw/TILi8FPMAIj5uld2+NFzVzixzAHuI
 tKKriom/pSavyRe5md3PsKZ40EU74ylk4UTgOQxdwL/+qyeLcNetyJxAiUxepx+aijrxf7okTu0
 VpQoEixfcFFQ62GCdzWM02MhqunjGrlt7cRBXuNQLXx1yr1eSMV4PDpHLyRrWY3nt3NrG77andB
 zVfabjBnY+JuxKECChuoTyuX7Hts9j+KfKwN/93KI2Y8s3R+JvqpqdcQ+4WO3DHkLihCyYx+yqK
 WFWjBPTQBG+jS/KTyChLnzAEqsUvu/RIkbUm/N+x3ngdGLRfOskIIf3r5Bap43M05TdafjJsdYv
 tMRlLQUfFD3/EACn3QlNba+X9saA9Ws/ualm+2AB9uRq3LlI/sLXNEoQlyIYYCsVJaxZnYBjl1O
 TbMAtn5zgEUTo1VdUtzgjYng316Qf8WspbxX99ac8OpcKH9tDYP8XSKow==
X-Received: by 2002:a17:906:f584:b0:c25:ca8a:8e25 with SMTP id
 a640c23a62f3a-c29e520e8d1mr175390966b.1.1789562436122; 
 Wed, 16 Sep 2026 05:40:36 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:35 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 19/26] usb: gadget: at91_udc: register with udc-core
Date: Wed, 16 Sep 2026 14:38:19 +0200
Message-ID: <20260916123826.517181-20-anders.roxell@linaro.org>
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

udc-core provides usb_gadget_register_driver() now, and it only knows
controllers that called usb_add_gadget_udc(). at91_udc never does, so no
gadget works there.

at91_udc_ops already has udc_start and udc_stop, so only the registration
is missing.

taurus and smartweb call at91_udc_probe() from board code and there is no
udevice to use as the parent, so pass NULL. udc-core only stores the
pointer.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 5b0c55d59c8d..ee2af2d699ff 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1494,6 +1494,16 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 	/* Clear all pending interrupts - UDP may be used by bootloader. */
 	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
 
+	/*
+	 * The boards call this from board code, there is no udevice to hang
+	 * the gadget on, so pass NULL as the parent.
+	 */
+	retval = usb_add_gadget_udc(NULL, &udc->gadget);
+	if (retval) {
+		pr_err("failed to register udc: %d\n", retval);
+		return retval;
+	}
+
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 }
-- 
2.53.0

