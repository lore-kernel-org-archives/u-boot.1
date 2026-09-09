Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F3C79FBF
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9979C607DA;
	Wed,  9 Sep 2026 12:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EvAIgUV0DS6F; Wed,  9 Sep 2026 12:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D50A8607B9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957989;
	b=RYLVpqnOSWqGuzTINHAVw0iin3J2/Fc0yuaDOrL1IjVYRNC4U7gu6uiCTSCTUgp+4R9o
	 zx8HO/f9oMdphnE3sjzzIJrQjHH5AN8pQOi/QdizpuOM67RS/VXIq1ncBdYYNFzL+hRh/
	 IC2ZxpkwwlgZkgqRhnsfUIlYTUnqPcw7iMkm+XZL9m0fKbF651x0l1osFWDnYbe25Y5Gp
	 wGLd9cYOd/LQfr+hlIoZexDDt9qysM+1G9Lnmb3HGq10yvoF0aOz9hrf2Y9L2KgapEq/5
	 CTSZOYBkEKmBHvc0S+z6TQOiUabDuISxoff/2ApKPqs2Yqm97ijXub3Mfo5FeBnxJeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957989;
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
	b=Fx6coDjYPHaovAuIlA6IrTaX/1XWfHa9uEqEGlG8ysS9W0LTQM2Nu08MglNeA40OudBO
	 HhITIg77Jh5auUpGrLCM/dJl6+1wFVwyZJppXlfngX6URm6Gegv1QknIsDD136Vc2XlNq
	 ngAnLz7UEkDsr7aQ8Z95Vj00706a8VZDCtyUCf3fThQuxmMVCHhC2uJzThT0r/nDsgWFY
	 N8xgVRg7m9gBZKtSuPpP8PrSowba324hvbhkrL4BEGdUGXqSeiXxBeMo2hICcn0HkkZXR
	 ttGBGw3FnORZj8SLkCuloeRKy72z0Tp18XHO6M736TfkOUpYa55Lq2NAzdPkbf0ufiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957989;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zr3I4PO1YgXpiCbqJvo26E7VQiXjbfmtDn2t3ImxCwp5Xbq4jPZKMtTpjTXY+twIL
	 RuvqAG6zerneTqp9Pt9OsTST+X/kx7d14nQxskhVlPhVN9PyZsjX3NEVv6TXzoDEiK
	 WpfHC2CnjuA/2FEnVLx5xZngCeqUlypiCxRLkKCPZmiIBXB8zrHnncMqa7JSmNENFM
	 +p+alwHIUk72tp0Cw3znTK6CpJNU2ic2zUePYIAzPmHP66FdUvSR3YLHig5H+b3USO
	 ZULpV50HizkZ8igbZL0zF8TX53xOHp99ytW989I/7aWzUUL7TI4Z/tFZZVaFRvI2za
	 WjAxgyx0yCL4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D50A8607B9;
	Wed,  9 Sep 2026 12:46:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BF83769
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61FF880D3C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dg8Ai40yAA-A for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96CE780D44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943951;
 b=guxh2X3j+AYmxlAnJrZRXvPbHQPdmsUqVO6GqA+QO1F4WAAN78efTK1yImMLj8zCuD2e
 iv/WeBao251EJHnza9fnliZIlzhMzdsQt1E2ESAvyroHK24NGyGNnn2GdvCIL4EAlkbFO
 30e8UIO1/3ZzTtp/rt1jC05bvl+7ilCI1ztYOxaa4gdIPXa5/324xeHC2xQBiSp1wz6CZ
 dwEt1ArEKYBPy+dwEkcY95jEA+bwwfJGBgdAFnW1tbl7aBs+t/oucBjGahk5NCKV8KrYD
 6aAANpeYy5jHzNMxAM80hdzHSsboJd1Op5YgwAlatvQmXONFUY6VNM7/Kp5tJ7ff6hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=a8KEXU4EWOOSAFYzv/L5pV5uE5BRpmivy4RewcKhWf6uMPz7g1DAj6t36cmQ36wnSbuh
 RXDR4oXZ4veQ1coJX9y/aTZ4xcsj/gLVE5Np99nH1zOLcq1CXZRLy0j30+KvxyCYZfhFL
 o3Qj5sz51U9QZACAejd7v+ySt+1mihh6f6sFV5o2eu20Petiea4aI3ru2XnqDgNHo5e5F
 2nK7RgGRwc0XJlkrQ1U88/Z7SAtJYo13MNR72gXwcXX4IKvXmTJrIGc9s10WPquZjoMmm
 xpYaQxwNxyxRCnTb4tGw/GUZH8CJ91MDBB1FA0vgnFEye7ic/n8QKVs2UneW5fxEznQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tw8wDxS+; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tw8wDxS+
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96CE780D44
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:30 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25085f2422so66534966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943948; x=1789548748;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=tw8wDxS+2H0Ugg+x0HLaIVVLFdSqGeNvs0j8mIzJFoz3hTpbsz/jVtNQ/lkYZQLHyU
 6ts/GwyeAguDlVcvlZWSA5UoW+jqQsn49LHeN8DYsb0RBN4dI0q9el0Qq2k0nNzZnQuU
 +y2WYwP0fRCSGTvoWJtv/+IGfcCRZSfMnNfHWtiVs6KMxM0fSo7eV/FRVMpvDtfuXncd
 OD0VdbmaBbeqXtDyHkqAz4ITIJx9ioptM+FuMDWqf7Nycr7D1za8OLps/sW9BJ8OyvUB
 ENDjt+H5Mp63YbZw9K+Db/1f2tP9io6NYYlJW3dbAwjcDSc4fMChcHVyBExIgBQBH7jG
 xMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943948; x=1789548748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=b9IAxlpEG7RatO0muhJ0aGFmxjoKH6rkuSqSBGPhHOcHm6WZD4wsr6+jZ7bataS6Mz
 nsLME9crV4CEkG0C5Fc/EaG1+NjlEydjVSBVW/kq+TgvNaZOBXN6bqyeeJnAYQKxv1F2
 LN1knDo8PKOFkeiieytewGhZdAchOFEwIjVrRQTFnGKYF0oGEQc1lLGuDmQxuKshkIQW
 s1a7xhwBiqcTJO1QXZCrnnI/KlWsyjAdwMClzrtHxW8OPrxzSHIxR0hvahQfoQlArMZT
 v/2ShS35VE+zSISPhXkuP95yOTqgdvHWDA5eUQC8CqIsU4yxVPsGol0rUp4IaGBcA1Mp
 L1yQ==
X-Gm-Message-State: AFuF++nRcc0dh/EdYbVhQRNNlp58a1DFdZiAIwiEJub3ZHjtTyite0QG
 omcEPcE27FHFl3FcU9SEJyEgJ4AVw5MMCZudP/mwHxQ0qum+Yed6Bc16gtb9NUyyOQuk7xtxgR0
 nNIiH
X-Gm-Gg: AYBFou2ci8ZWbFH5Uke1wuc/T+Yikw9aLu3BJiAQwo7S5GLtdWdh0kdao0otm9tp8TN
 A4Es3/5nhtzWKK5/joJqkvGi4xMkKQ0y+HQ5vAj4ZZO7CKturOAFSR/L7vdXvc120ht9Z18MMIf
 LCsA+Q27d/EdbXnfxFZ0ROJUwkdcr2YDNJ61thaG23KP4Dm+UgQIEjnO6tQlrpaGdZpt4/XENDf
 SfKmXtasekufdI5uoc6/EdAtrMNwRtHwQlBaRcT8jX7qFXrmHmXg0qUmy9VHc1TMX9LPXjPOvG3
 RX9DnhfJBx6uQUxRg27Z/RMOJxQWBO3PLIUBYNp1Q2Z20n/16umwz5BaUNVKcWpNzADGRW68rRo
 /6pChHmWl6inckETctkryfdqCPRQXzYq7RtPE1S4qx76/9rmgua6AOEMtlFmoCYG3KYmdd4rg2/
 CFL9PMW4iCDGGiMlgROD9xSCb3jwU4SJcX0gwyqPAkJ6xHoOzlSuZ+MpWCVGDMYzNESknJWIIjS
 /FZ4jQgW3wUS9dIQZQCnD6dybl2q/+S
X-Received: by 2002:a17:906:4784:b0:c25:3ccf:bd9c with SMTP id
 a640c23a62f3a-c2625012ec1mr1041756266b.2.1788943948457; 
 Wed, 09 Sep 2026 01:52:28 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 18/25] usb: gadget: at91_udc: register with udc-core
Date: Wed,  9 Sep 2026 10:50:08 +0200
Message-ID: <20260909085015.2480097-19-anders.roxell@linaro.org>
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

