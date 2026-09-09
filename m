Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A5C79FBF
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17F9140718;
	Wed,  9 Sep 2026 12:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3Vopz-wRZHg; Wed,  9 Sep 2026 12:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C94594071B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957953;
	b=W5RlHdPNUAbXj7fJTIL7jZ5WFvbkEBZnk0aJ8miYAYDVgU+Nmo+QwBjawyL6UBaMt9tr
	 kJWp1odERRBVAD5HMFdFwxx5QKRX+9Ri7+JwB6e9QToOk5T9od3ZurX0a+8ze17VkQjcE
	 Te8xkrjzE9f4Pkwn/4+p6zc6UXoBMdY2i2IPPW2fOBK9fXA/XtJbkug3WYeK5SuTNRihS
	 uFzRwwiBY1Anw9JEgRkvlGMGWiHt2A9MDsPDOdqOniXmblH0wDzgKEMvTnq3LEjs8scfD
	 rei8nZ/uPFsfqVPBn3Cz+XAfa7D1G3iF+b8rrO4M2lYu0zFgq5qMV+Jez92ODPoCc6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957953;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
	b=CGLXvAxqTQQqk2LgyrSxh5tvp9/0Xf1PDMMEMKrya+JvQN15/VM+eRQSIMrsKO0J/EK3
	 lKKfyhh97bkQO9rt+iHenifLjggcjW1xFX+vQPaFaxcG/wcc6NYl+RtKFEfJ/vfJyCLCR
	 PqLxpIxnOedOY3PSVdOAhZzEmMq0fgUkBzoSn4/z3XSIxjVbu9qbnTB6imS+goyF4skWz
	 vg0Kc5dRVS9NigKD+LAGh4gISrHGj6IyvfjRNf8p+RoKmsZeaMs35SNltIguplHvYg0pL
	 SCPaCbciDRVgqjM4ZZs21s6/mr8LcorvqC/KxYvi2E/FqwB0TFcmmrbSijKg7sRPEug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zESgZPMT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957952;
	bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fOXdYx7a3E90BKsK+fjMbeiUBmOPtS7AWv0cFRq2fs9JZEWJH0NLH3SDhowY/aQOL
	 KL8ORjSOAmkAGTl7Dc7HdPSeRg4uydC9+xChdVCTOw+6JBY+qUlAsbDdJV6wm0wWaX
	 8OKi2DJzlMs8ndMXe5v/81pDsb0eEIQFsH0o8QulDzPAtqhNxQq4gtBOfBhvLXUw3G
	 PNVug5kXbn4LfZdV5MDqrI/q8U65PT33PI/NPgRqm0xfLc9hggVfNnN4PFYNqLTPci
	 /Vq141e3qiczXZ0z/OsnmMUshy4oUJDS8og4zEG1aY+loGzzU7+/9fnrpj23aH3iGd
	 ZDa5m2LbAPxeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C94594071B;
	Wed,  9 Sep 2026 12:45:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB1002D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCC71406D1
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8LafKbAEp2c for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D05F0406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943875;
 b=iBFur4Mjl3gbiuQmoO6YKdbnq9QZ+llLHWB1yuI3rL7z31sk8CQXiHSHGJrjGzVn/Uxc
 If3mScT+FbLg/OqETv26tJoz+k4WH26vma8joORum+/Ot39ji5DyUCn2pvx7ZQS45lsbE
 iilPTH4KmjLCdfaJQEKUii5ouJ7ps8vQ/gAiqfF5IfD3PWhPmAOygs+x+/geEeREGkZ/c
 itzUod2Rk/LRJALYTJQJ/vy3nwlop9ov5EI7alDwYe5NpxWbHZyCBmZRoE750NomBAx8r
 RyYBREYsJhA4O8NaJZ+yfDI59SZYM2Kx4C7n6SCxJO98SzilnDnfAmaV/A2xZwraUVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943875;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=VsYXImYJzocbwCpXFNDfaRPZ/IvaW66YhRw88lr/ofaoiUgm8ynndUKWYDser2yQe6EA
 4jDeUcqPs/wX3T1sctE6NllfbqUM4gR9RWpCkNfRLkKBrn0lSu5IX6efKFaKsGurzCLaL
 RhWX5Q2fBrN5lbD+qcVQCjtSDzsG8H51fpbBcO2Ew+XkrUtcBSlA3UXmmYJX4iEAgby6g
 FZRzFbmUkcRV2DGWLew1GbNJxOysgwbSX+7+XQ+4e8cmxbSurwZBmtoLEBCNWczoBjfJ8
 RbXWAXxM0V9KYBiLeJrjzvT4+gbNjEXnOi2bqCo6oCHFVFR8XnMVBR8iexSgXRJJavA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zESgZPMT; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zESgZPMT
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D05F0406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:12 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25331b31e8so80180366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943871; x=1789548671;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=zESgZPMTOPwlhVEj/85nAP7v6jneOb8tb4v89NdqoIsZSfh1QjcnbBE1Vl0ng9t5+n
 xsZh/S72S873iSNfRd6RmPTv7Y+lJ0hF2dYtJZTIMFKfX2INtX1VEu+qNO0JkEpk2kxi
 8PCc5xDFrBWdqk1tGBnuYFpyY7pr8Kc+bTYfJZksl8yYoCAM+vhEPb1DfHKSnprp+ZRG
 K0NVhk8g4ptxhrgf9V4eRJLc6Dp/YhblGEVU56UQIErMZ5v4AzUa+x4dFVmg03UQleDV
 P8k5ug780jzSTyFzFCMvU7gHkDD0Uc4E/1sTyqB1Mgpc7yEFx2uzt0a96a7FuvcfMKQf
 yMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943871; x=1789548671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=RkObgGvEhbzjp2IQa+C1i21/zg+LZC0GfNf2ruXVYlElUanMfbgB0GZygor+pM31/a
 z6NvVp/r8+ZByMAHwCsA18OdK8LuzRlw1YAupFtwF01L081lSdwh3tesTqRP5PVJKolw
 73DMOLnq/6AcFbPgisXUOH64OfLV4onQwhb7TnNVnyvqgKMCQQrJMGUswOp4D447xbCq
 TN3zPjcMCZ48p7LvmDMlnEUdMtYiSjS11VBagKGYnn62A9liItz4OizX3fdtFSsEfP1P
 +hXZ6It8nQ+b32s/g6sQ9vRT9+Vvam4TAikmx8SYcKwUjZsQhmUNmwFv09QjDrer9dLi
 ByFA==
X-Gm-Message-State: AFuF++mlSqPiNVL2Dglt6b2VucrSeiLn0Op5oTYQ8piwmSX9w1z3/CR3
 pSGjHVPmc2QW8jaIw+3NK+DNHW/Lol5EMkXZ7Y5bTqo0lp5AooROf2rMmRHloWahaXtsTb85jr5
 5pnEl
X-Gm-Gg: AYBFou1GhvK5Pfj4YjtW8zMdTA6azh3IGcjauUhFAi2qDgRpoT4TWaeBINFjtCz4QPh
 P6FQpA5m4krHri3hy70XKMAKl6AYGlnX62Uv3sbfSuzRy1farRJk9x4uc5ox05/sdgBomR2wT7h
 4O5n3qFjjXvl0EnwYbAODSRWcfUaRGCKvU1bIOdJTj2rcE8fw53oaUprC6jYt5ei5yA/paNkFfF
 xZA0eCY70m+DuoCnHvYQ4zIKYKTo/GY9xGZxdMDbNJ+uxfdO2Ggd+z7JPAtmJbyZPWx3PKcgKOy
 2M06BlL1JwxkE6zw9VHMCJl4DF61WN86+XR0TtqlDQnHKLF7Q5FZgT1TgKKZvqgjGrVRD9wUy3a
 jxiBw0O3maoV2Kd3YxTl9i0wzUqFZAOT/BP3RUKBKzF7DkI8vkFQRE4hCTlvNOQumr5BpOY68y9
 t1OEEyN4L0krs7k0JxYQdcL4LGWDn7pK8fUqojArSLEqTraAEtNcSwSn1DnUBWbctIPfv6IjfUq
 tb4rmvGYA0bFS8nhfiZPbxCJlEzvvYAtg==
X-Received: by 2002:a17:906:4784:b0:c25:3ccf:bd9c with SMTP id
 a640c23a62f3a-c2625012ec1mr1041516166b.2.1788943870492; 
 Wed, 09 Sep 2026 01:51:10 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:10 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 02/25] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Wed,  9 Sep 2026 10:49:52 +0200
Message-ID: <20260909085015.2480097-3-anders.roxell@linaro.org>
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

