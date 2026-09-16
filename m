Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F4C982C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E442240735;
	Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abIqiMhvlS03; Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0E6AA40714
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564121;
	b=afVeBgD2g0Ki0niWS+zHc9ilTh2x1NNLwsMhVGjvKQmqwaO8p4Jb/pIuBezGjsC+9Wj2
	 s4XBYRDr62tFtMKrHrfu83OIG/6P+UYCjdnTJpc2QkHhd2u/aY657zJfkEv3IQ9UdBuLy
	 2M4YSc5Szbg0KvSWQgNB9yjpB0vDMeW5LcfhiVqtYMdzpwIpNdGTvtJ1N7h89In/A8FuW
	 W75kb59JpxF2hMKN4TKzYmRlUfr8o9SYF1UGQ9o3C6e1QTsZuIbyMZ1z9YwrRCO9rVrUQ
	 kGXSlqgvw8lhh9mPPkQM6Fo3odR5xD+CZZuoskIKCPiLQmYJS1yKtGehOUAy8GDXaZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SlB3E8GBrnpGT/lb/QUaGrmCERyqIY+3LQ/fbPKofHc=;
	b=EYCksQjBudpLSkT9iwwSgwNzXdkq2xvP08N0XenNJipNMD3ePLuohCza4UuHuzJeIAbn
	 jknatcsBZu+jsiJlzH+cZqTlossmDUKO9NxjDtdJVcLwW8Eb4SMI8cJR9odySDaxBSVMT
	 /mVEc/Py11w7TlDi8F217JiODodL8e5AwvjbBlmrXvyQWpJr2TgECFyGz1NXQ4YNdMM0i
	 WdfAeTqwVoVCJPUomx7f6ju7X8oRyfj86Yv7P392bLxHtjBufpFH8ugG3Q6UVTpY93nrh
	 zVfKydRidIE6lAxj3mZxOZ4qa4iKdxwj9yyddmPMN8XGPfwurNqz2q0OqNamCHiLLKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564121;
	bh=SlB3E8GBrnpGT/lb/QUaGrmCERyqIY+3LQ/fbPKofHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsqOq52zEeMLgotl6zlxXU6wHwA+hZbwExPmKHXqQ7bZwMk5P2Kg8lfoaefybUlfN
	 VopX1CGnEMU91R33vw9FwxFTQiiYiFZpL7vojf0UBPZG7Ekyp9qWr8ZbR8yx8uDEP4
	 R/izZ4mfx+5YWrdBqYg9Y4lJhQSpocQDliZzSjTAj6P+8DGTlcZElMzABElm0xVjST
	 zhoomynmbJVv603PbIDLJXBccuYbMtHnsg198V0/gxTFiE1k0PS8UH3xpwjpl71O+v
	 nHXkeAsrl/4nfR6McoKSDwOY25kNjUpjDtrIYl1t2AmzASacv3zQACrim9GBeYQBLu
	 QDhFtSePaFmkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E6AA40714;
	Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C54B7352
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2E30607E9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFZo0bFZlKG6 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CB54F607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562363;
 b=mAWJUGTvfdCEGWeUd7BmphwAQ/niJ2a3pz7Cj9fBJN2UyOeecCsCZPhFMbFZ1Uc+IxK6
 YTZNXl9Hsz1KsyBV7c32aFNyV5fHAnoJZeGaY4oDW12sArpmG1eMb5MbBA81e7Zo+qAC7
 pQUhhQYdqHYphiB0308YwmeGXmcpGm3CDiB38syZ/fvBrUAzleIBmabAYa7KBZWdQPsiA
 LZ88nN+3gP2skLF2wF6PlgRw2UnVoL2RLVU0rKxfftlZn65CWfXHznzw4AbtOHVliyc5i
 jjjzRqQcJieTYEkBbM7edeOqJCaiHwuRfEthhgJph2z1f6ObWtekL7Yn3+wXjMM0N8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562363;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SlB3E8GBrnpGT/lb/QUaGrmCERyqIY+3LQ/fbPKofHc=;
 b=pxNXkH96ZzJHi0VqeTGCykS9jq7fOx1S7KhDGhNEc1o/4AwVK9M7HbZ0BbpdE7h8nX5t
 G4lABG1uqI5oFaoV0EOQ57oYgbd0IGdbD1vHIagIyQ+1Q/kOQeeZHUnHhyfkOtToXKyzd
 1X9oxWGlk2iXAkNR+u0GDNbaQJiDS9uqnkvTqELqxItrV58dPl2I2Iy0doPhctMuAzjxP
 fSzFAZgsk7yohGeiV31MvzZmFTvQCjQC80wWAK2YX7+veJ1n/2Tc1+PATw2gmluUSoBc0
 N4+DmgvZVu1DK0OZ9HEGeDg59izrRAqZKXyMyhgT54FhJhRc+oPo76Z/vpl0CiFArLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=f2hkYraI; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=f2hkYraI
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB54F607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:20 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2507a618e1so15770166b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562358; x=1790167158;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SlB3E8GBrnpGT/lb/QUaGrmCERyqIY+3LQ/fbPKofHc=;
 b=f2hkYraI/WIDp9abykguThEoC4jhDrn4GK23wQ8wYEh3K19guPmETPEV4NUMxMlal8
 ep88prEoz17NpNPuQzowy4lJpdK0xr4hRfeFA5pzCAiPo4ukFkohiU43cc5T9LWbgubZ
 OEIjhj90DEB3IsF7xAarXLCElf2j3TISVgIzKXG+n70ViC7Emy451Y83gaLM1Gu72M5T
 8XlhvCXBm6bZisUOpjmvb+oHLA9W/JBhSkx6w6hyUvuHbO7SFytBZKi7u7IOjATKwQnE
 496GuVy4O6tbcvWI0W79eMSL88zfYMJxYDOl7lXh2PZORwol61sMNDCGJttdfHCzMwH5
 KFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562358; x=1790167158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SlB3E8GBrnpGT/lb/QUaGrmCERyqIY+3LQ/fbPKofHc=;
 b=o2J8QQaywsk0Ex0MkwShdQpmP6QrqQdWJ/YH6U7vadmEVYRY2MVwIqOEsq6jLCfa3J
 uH8lKWhm93nHj66+rmVIhR1jbS3dnc/iH4+3F93pzWJrl6MNJuub7Y1WLHyWI7aCD9LF
 CnJ+n2o5Zvi8DKYU5Lc+U1alaZRdY4tfZEmXVouRxHrQLOmx+j0GfUXiMmrQ5QNgXaH1
 WwnuW2cY6E4wMutIuCmQ0swzYdm395aKOy8FW6nmdNmhgMW7aPxc83z6XekFEJ9cEuUK
 AHHJ7tZwabh+lXl7u1aV2mFAv7zFwuC9yTLM36ML8JszQvuZ+JybgLSaS0jsH/DasYQW
 F7xQ==
X-Gm-Message-State: AFuF++mhQNjujdicTVOlYQnex9qb1buFn3v64l+dDkZHrghDn5+ZIAuJ
 xJbo0vb9Puszy23uplFxluU56tzUP9GiqI453xqjPvKP1P+bnzuhXQWS5lSN/y2Oc8zmqlUxPmS
 wbGpr
X-Gm-Gg: AYBFou1BIobn+e/OkczfgHiKAztdZuUiGTkqyYtuiBPkny7kXgUPrihkV2K/rm8jSDr
 Y8g7Z/uYAXyHSOCUkPqNmhKd1s8npYdsEkfZ9AxAVLrN4Ca5h/JsSk7Ts4KmlSwyH0qFKMjqHnP
 qJnbwb6qGH45sr0C6GpyTxTquGEC6d6m4QFBo/PoviEcNsSqxFn97NbFp1/bdF1mpA2kcGHxEsU
 SoXMH15w0CitvlqfnK48IO9+bk9ddFUHiKd6GETTU6Dnycy7Uxk08zzFGd8kZTKZazvpl6INLI9
 QyuJGzoAGEbWW/4GV/HEOcvqMxDhzNCBOuWOP/ifrjj9oPV7dbSjCMO3IUyifgbi8+b2JH6s01J
 CIEWfU9oVRdotLFAxKyXskkuGCGy6CZc3Q31n0MVMJqChJNs20s9ouStG8aabLZt2zaHUsV4VYW
 TL3dnZq8AOfcyg1Cs01KY7tCres1KZaFjFKrfYTzelxEkq7chTHVFoNy8DOTgmri83WztIOXD19
 JTj2Y0soeMLDi9lttIabq/IoqYzLufiyrljJo0ZgniA4yxEroP3kDBP
X-Received: by 2002:a17:907:a089:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c29e54132c0mr165334966b.3.1789562355035; 
 Wed, 16 Sep 2026 05:39:15 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:14 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 03/26] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Wed, 16 Sep 2026 14:38:03 +0200
Message-ID: <20260916123826.517181-4-anders.roxell@linaro.org>
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

The resynced DWC3 core includes linux/usb/phy.h and uses struct usb_phy,
usb_phy_init(), usb_phy_shutdown(), usb_phy_set_power() and
usb_phy_set_suspend(). U-Boot has none of them.

Add a cut down version of include/linux/usb/phy.h from Linux v6.16. Only
the parts the DWC3 core needs are here.

usb_phy_set_suspend() is a stub that returns 0. U-Boot never suspends
the controller, so there is nothing to do.

Linux calls usb_phy_set_charger_current() from usb_phy_set_power().
U-Boot has no charger framework, so the call is left as a comment. It
marks where the call goes if someone adds one later.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 include/linux/usb/phy.h | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 14b2c7eb2e63..99262ded31b8 100644
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
@@ -37,4 +44,54 @@ static inline enum usb_phy_interface usb_get_phy_mode(ofnode node)
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
+
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

