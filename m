Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A59C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E5B540EB7;
	Fri, 21 Aug 2026 13:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0YKC_JHnZThV; Fri, 21 Aug 2026 13:16:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318160;
	bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ldr3OLe2xf6ZNrlz5+d5EWcm81fOw99fKQtC24yrU7TPvq+4egLaMtkuBlDipzuCJ
	 PBEMI8zW3Pk+PlPaaAGjbMO9pN+irHZekXOSFwPRpEUPRYSmg/zB7codLC42e995DM
	 sBPrOI8ULIAR1cP/2y62porpQQ1ZPD1DH3Kkt2X3dsw/Z1sZ4lnSa8RRCPvwxEEdLn
	 e0OJVFoXi5afXQM+4Mw2R2M8WJdWLIpaMfc/90nYZFzcvA2D4r+ndyoT8jCGWWGeJY
	 j/ErHkNnHck6aZypyO5fL9aKzxcvJfippR0anUhNxyuVjMOU1zJODwHkY6wYza7BSR
	 itN4PAvNDP4jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3AAA40E1C;
	Fri, 21 Aug 2026 13:15:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1811B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2CA5810A3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvFyoqQQEGRv for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=QcNwCbGa
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C114810A1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:45 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso6922766b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302364; x=1787907164;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=QcNwCbGaqwf2Sde0t6abdt1KQxAUFE4xtAOID+FJzgoxsel3AkyvEnAUFS+CREYWAV
 sA3x3xhKyhFtHi1eoDVSt5SZDTnTp2fZcVm9QrIBnEWwEY2kT11G31uaS8seEWk/isb2
 2TCyk7gg2EZzUkm/lbbq6q6/8E6/WCCIMFMBybDD26lufqM/u4Vh7ydEhKR2DdTi4JAD
 0bgSqzuGz/Z18wIPY9OH47IIDpzo2IjbKpOVQ54FNaOU9x4Z89TBeLLMQosQsPU9YN7j
 hrG7iXEFMyJfRn3Ne4lrCM4Yec778nNJp0jJ19scQg2emY+MLou7Z2ieEjEKRI8UoNad
 2SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302364; x=1787907164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uuxr0c86ovzf/ZM+5leNXnR6OcA4HwH1GNRMh//aGp4=;
 b=FzyuHdDinedvUOnehPgO+WLWFeedJQ+ybKwu/osBeptYTg7fnokv0/U2aP2aXjl1mK
 yexNP8xgLZsSxpk+TqUVwshtwSmPXh1dIb+YbD+EgPa2D1Q1PcLBf67QwffVJP2iU/Vw
 t/vhiJIGjy9iw+hq/lZC9yzwd4LVwVRp26UFMqz1Ee2EWi7ug72hJoP9cvke2Ac/wkw2
 Ws99EJ8A42yA9/P6b/iZy8BP44Kw+8jm74DJgLOE0o1doZbuTY1tWro5S6UQaovuUSAU
 PhdAmISbALpDewHMR1W38WOpVeib9EYEerhbnANrjBpZaMXALOW8YZ8e3XuxXY+bACXg
 0lRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RppwQiBy/j78s3nhltFKgvULzehsxcwhwARzhuZPpsgN8IpklxJt0GBvEzuWZVfFobFxVELrzg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mIdm1PgTaJmzXP4kHwwiWDOsaerdoZYXf0YrRZwnBeWX6gLwLp
 V8NjUT91cYsPnNhgDvfslx+zPYfTYLXJ2nwu6vRhuYfARo2AEZyOXkTD5sb1wNiNFbk=
X-Gm-Gg: AR+sD12x/yvhi0jBq/B1RC4sxQHxQ7OD56Ro+QhcH4tCU9yqrzwVaAERt5SIAohA/i+
 GEe2Zt5eXXNeimo1eGuHkb6tcG3tgzJYjNBjzfdtvtI1heqE6cdUouerblLfG5ObC9KPJ25uhSQ
 GBVsvCzAIavcQrVpnz8ThYsug1qpNnPJJrvLVGVIVLbK7LaZMvJaklL9HpGFWecxsqU1YGQ5OoP
 Ahax4U8UnvhRj5ntwSMHTD1U4kvDrwJ2ClB8VCJ01YtLk85fH5wwA6O+jb6/eW0S5YSMonFUnXg
 KZkeM/yrBTRvVAYhWp8KrOkgb5w/uI7fjAP3V4FYbULFmSHM9wBM557s6VECwSXEft7Kz94Gzdu
 hFuMsUlOTBEjwTypeuA0CJ7MHHA47Jiy9Aj5VtfjKXq8RRQwyptFuCE14zVw+fAz9ThcXET0GOH
 WxrJvcmTl9Cqqxa8hIJjlVjrvr+vWBB0js4/wdlIQ+Bok0NertO8JBaiXc4Awz2DyR9VdLf9V5A
 OWwYfzttcB4dRa5BQZxkQY5
X-Received: by 2002:a17:906:4790:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c2469f9902fmr269510066b.0.1787302363571; 
 Fri, 21 Aug 2026 01:52:43 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b09599sm353957166b.21.2026.08.21.01.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:43 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 80/87] usb: gadget: at91_udc: register with udc-core
Date: Fri, 21 Aug 2026 10:47:56 +0200
Message-ID: <20260821084829.2070426-81-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

