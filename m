Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE315C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 676DB80F29;
	Mon, 24 Aug 2026 16:47:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZvhACU1Em98K; Mon, 24 Aug 2026 16:47:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589932;
	bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e47VN18Je0Y7KBS9hmBXm8Vco0jWdQFTaBK44CfGj9TYPCTRfQaJU2HXi5/cHYaO0
	 6Cot1iuhwNlU9XolNhJAmKt2mIfP0wo4x54xdc9HVWTpj64TN6W0Bzr6PvqhaUizZD
	 l1t8KQohrBFsJhaQJAd93nsrlr8UIa0TTouh4ZjrsppeWmWsPEwQuyFI+ygo+K71tb
	 ReDxrjl4YVOaoOKeZOE1rfW0IxuDzJP677ABC1h43GJUJ2F8TyUhlvsaRkRTqlMKXA
	 Tf/6awH8VN75s1u+/XMMQHrYoO1aqVTrjOsiGDCR6FjnZ2gZg/FcOrHl3ZbrZDT1UA
	 rkO3DoUchaklw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D68C80F3C;
	Mon, 24 Aug 2026 16:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C706279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79C4B40068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-91xcDQe9HZ for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:42:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NtwXLePT
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 793B040029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:42:09 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso31643166b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586128; x=1788190928;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=NtwXLePTUjSygpM07JhlIaQCQLnHBpiIbNKpHfhXuA2ti72JCVKsFBuyW2oQrtw2tH
 CtsjImYmLbFhh8JhqhFStcaI++TgY3EGC0+PRKLT8xveL/H7ZGB8F8INsUNIGoV2F567
 qc90BO7sXt5UcJkBpt13CXmChgc7XHgZnZv/G3IXoGslz/ZTMbnBWU94hVENg3AKcQSx
 b7PQB/xM0ilEuomXJv52lhcYd5ATraF808KCCkBIbI2ZK3Yh97aohvESlQq56no1WUJ7
 PjZquS4wn9Gw137/bPI4bqPf71E7yP5NA3ATwlxVM7krbzilVlRSNrCDEqz0WJoaSFY+
 B3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586128; x=1788190928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=rIk3S8VTpL62wJxNOoZppoGx1I8IU+XbZ95Z59Uzt81CA82Iiy2uD/F4kQiGnqWASq
 oqpDU2VYOZ3jrgK7HQnSJV/N0QLMXRdLWBRZUpjsKjelhiKX+zz5JaKiSzlCpzdJdFSh
 V8Xt/DzQj1qZ5OmQrhYSG3/Q9HCZ+S9dV9fjNHH8HLsUtL3ea+Z2/U7mkDoD3BeMCbCq
 xp1NUMrKa0K7+yzhP3kaMOoUYjlDwdxwnt2msreoraPGZ6koAcifVX16piz2Uosx1Wgk
 cdOO0SJs6OJCwpmEvwH5FEhLv7vAOjQnJMKflNh1po5oXV0AJ5S7jfWBS23T4ArjAeCn
 y47A==
X-Gm-Message-State: AFuF++llw+BWZRCiR2Vdu1FzW2CVD7iI5R++DgSRB+r3qG6VQSVBmTNc
 6h7BUXsOuFu8IbOBzWmkfu0AZ48bf4v01UqUZ1vKPylmxs43e/SqY1kX/CK9kt37TGlJtA86Zxi
 9Z7f4
X-Gm-Gg: AR+sD13bDtm1ZiQ1ouAd7R032eQ2SFzAHgnqV+uuLIjDMtDT7SaW8WzQ5g/IYMZwU03
 HuLybFr1LV+8qRvfB00xEQj8nFOQ2uY/uLouYUe3eDEhcL2feD0oh97t7LtrfkJZGq/sUAn9eIo
 wt6npJ+Ikgea6kvDgmgzurm8M07ub9MKoD5anSBwgPlbQIPsgSRi9G0vPNA3g069EUT7oLdbEQy
 nwC5IC79gze4WwlQqJHc7gBvUEBukXctvNsAyVOEk35QmNsxXBkaOGOWc8eVoPoRBE1rEseC1/x
 c0VQS2RypQ977UEdKP0OAHM19Pngf8RRggxNHBDRXlpxmRq2EBRQYYfuj34cmV+Ixp+E3gU0Uwb
 abFX6ZusdLhIuV7vxyR/4BCoDHZNFAR1ZTeqkjlut2pzrpdbNc6KxfYonqofg8UaCymJLD/P+yd
 XxgTUt6SH/SpIRCk0zntG8ByXUwe2GbFmU99N+Rvk08g9GVHHfXHgYsjRFIMK4JP7rxn3ZT2jkm
 Ds+2xgJ+WT1wJl7/NK3oQ==
X-Received: by 2002:a17:907:6d20:b0:c15:9f0c:8d31 with SMTP id
 a640c23a62f3a-c246a5f67f3mr1670622366b.2.1787586127889; 
 Mon, 24 Aug 2026 08:42:07 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1278567866b.38.2026.08.24.08.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 02/24] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Mon, 24 Aug 2026 17:41:11 +0200
Message-ID: <20260824154133.217744-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

The resynced DWC3 core includes linux/usb/phy.h and uses struct usb_phy,
usb_phy_init(), usb_phy_shutdown(), usb_phy_set_power() and
usb_phy_set_suspend(). u-boot has none of them.

Add a cut down version of include/linux/usb/phy.h from Linux v6.16. Only
the parts the DWC3 core needs are here.

usb_phy_set_suspend() is a stub that returns 0. u-boot never suspends
the controller, so there is nothing to do.

Linux calls usb_phy_set_charger_current() from usb_phy_set_power().
u-boot has no charger framework, so the call is left as a comment. It
marks where the call goes if someone adds one later.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/linux/usb/phy.h | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 14b2c7eb2e63..afda7870e21e 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -21,6 +21,13 @@ enum usb_phy_interface {
 	USBPHY_INTERFACE_MODE_HSIC,
 };
 
+/* associate a type with PHY */
+enum usb_phy_type {
+	USB_PHY_TYPE_UNDEFINED,
+	USB_PHY_TYPE_USB2,
+	USB_PHY_TYPE_USB3,
+};
+
 #if CONFIG_IS_ENABLED(DM_USB)
 /**
  * usb_get_phy_mode - Get phy mode for given device_node
@@ -37,4 +44,53 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
 }
 #endif
 
+struct usb_phy {
+	struct device		*dev;
+
+	/* initialize/shutdown the phy */
+	int     (*init)(struct usb_phy *x);
+	void    (*shutdown)(struct usb_phy *x);
+
+	/* enable/disable VBUS */
+	int     (*set_vbus)(struct usb_phy *x, int on);
+
+	/* effective for B devices, ignored for A-peripheral */
+	int     (*set_power)(struct usb_phy *x,
+			     unsigned int mA);
+};
+
+static inline int
+usb_phy_init(struct usb_phy *x)
+{
+	if (x && x->init)
+		return x->init(x);
+
+	return 0;
+}
+
+static inline void
+usb_phy_shutdown(struct usb_phy *x)
+{
+	if (x && x->shutdown)
+		x->shutdown(x);
+}
+
+static inline int
+usb_phy_set_power(struct usb_phy *x, unsigned int mA)
+{
+	if (!x)
+		return 0;
+
+	/* TODO usb_phy_set_charger_current(x, mA); */
+
+	if (x->set_power)
+		return x->set_power(x, mA);
+	return 0;
+}
+
+static inline int
+usb_phy_set_suspend(struct usb_phy *x, int suspend)
+{
+	return 0;
+}
 #endif /* __LINUX_USB_PHY_H */
-- 
2.53.0

