Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55312606A32C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=he6PFz6V;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qdnJH0ls
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CF6481393;
	Sat,  7 Nov 2026 12:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id drKxH658JAbK; Sat,  7 Nov 2026 12:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E59C81384
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055798;
	b=tI7Aa5FsduX3HGgRDNtFB1LrOry1zuPUrAkR94mEeZjjVkcvAI6o1D8Z3HS70+mQmx4s
	 LVGqSU6SXJKc/oku6roTrwl7XM9U9y2Ns3ZJ29/LGTPVg0Z/CPIUlPNMJW/Vq1yj3qmRx
	 tftk4bT/BYp3nm1aPwc/olFu8kL7U+HBQteJP99y0ddSshEENJ5MObY1RMhrSK+h8DRsA
	 mWobgxk69BibzlpNWuGiyUdOsIj01304WKM8q1eBSroHiMFG2B8WgG1nQ65gStnbDyRsL
	 HSMI4xHBOcVACUFvOe0upafep750+GinnteBIw760WZmTKMgW0FIF1mF15hFjlNFfgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
	b=FVK7YLWck7wECeAjR3Vmxs3vbAvxKogbckAoDEXSoDdN4Dnqg4izueYmKmIZKCRSANoD
	 YMPSy4g+HAaAHpyB33rXASMYM6b7U1EjAPYyvc4+8dnRuZrv2yBZhB6Q75VRSAzSARQrQ
	 wnckYKA3Ci2jUMLU5czT3AxP+h0LnC9AeMgqb+9mbHXqtm8bJ4/yPNL8GLP5Ubda2Ba86
	 /HPQJ1BdOYkwd98xzAgDYFuaX4i3+r+hOUdDkVCLCi5kMx/bhugB0NOo0JfF7JDXok6CG
	 8SmINykfyOgq7umNqkn5DXJbI8E/JqXe0cT+m2dkm5gv7Lacilri5zH10gh76V+VFHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055798;
	bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=he6PFz6V++hbOU2tgA7bBzxEFcQkjUrXOx+tUuJ8DrEhamymQr2rW4N5xa/QWjKXZ
	 5lwMg2PH9Ee79dO9ZY+lXp4CwsMi2blMOpEmmQdxOIHnhV3y1JD8lZh1Ii4pxTnLV9
	 +7B+YndXoRNqtl6rSUPlMOwo+Fz07YqOi5ALGOALsPVYyXysI4JMRrVDFoB9U8q720
	 dKpsMRi2MXa27YN1rNimvKTJUkOBldFftq6PZCZeziAqwoLY4/1a+lnx21RiQvL7kN
	 E+iFulSMVO/Nn/h/aev0aiYQns0sFf7jsN8CDMAfSKZ7NS7Ygey43RdJ1TLPLNIxxp
	 5mPNMguaKCV2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E59C81384;
	Sat,  7 Nov 2026 12:49:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FD9E31F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4634D407AA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h32XI94HM6t4 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C65940762
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=qdnJH0ls
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C65940762
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:36 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so12081766b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036155; x=1794640955;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=qdnJH0lsBImMoxDILpzfxllOZwdL8iKXiV9kF9889w+lGsOPGiM7M58fJP3pGReaV4
 Nt5cGRGzFE6kt3ouhJZNqm0kXl/AaV0J18AzH+fYsySb3UEGpd2hVd2LnuSPD/GHQmkx
 e0MfM/OzXYiUtvMw2WPlj6rTHo/xFvhXVcuuIIN1sg+cOPrV2GqfpvFv/7X5p3GNhhJ7
 ABzEq86sgrZeB9WHtgPCHN+I+DLrZkXoqVj4ghI4VTx38k+WBSrzFO/5gg29lpnQbpVz
 kdYv9cR6+pGdz47fH0ommDwrwFRMyYEnfCRyyEbAhIiW+3Zv8eh/yK+gbQbNqXO2N9wo
 Sqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036155; x=1794640955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=cqn3XjUa7p4dM/QM8O/+z50HIVKKvdaw7VElewRXgTJ9ErrBl8hvqVNY5JXlTwFuWA
 Db6Vci2NokR60D1KMdvjK3DJVJjS0S0vMuVL+m2OZPGr3NPUV5t1OhoKnDuA2z+3sH3Z
 hTFoR7ZdC+aH7MP2tmrRIA9M0aPhKZ3wmZVMUFCfo4xu1Ugy/KFLKu4qvBqJNatWUnxl
 dcCplJB22tlj6+gq3ZW2Nw74ixdizDljrRrHGyMOjrXMsHM7CQQE0GoM+T4bw9j53a+y
 78cnxhzzpdK+MrMNBPhD5Obq232C9L50dLUT03NCYkijfNg0HVyH3vCy9VuxKnTb256w
 e+Lg==
X-Gm-Message-State: APuU4Z8HdhjAvzFf/ks4SG2lpj/gJXwmNAMAezQcJiVTPKWpCTepH5yp
 IFHiiaL2hNbyrh/fUBkGD9MR8ViSf//UKVznszYSaGcvjd5KPkDDoQ68wCwTeRfooOG+cGPbRcy
 Vg/wT
X-Gm-Gg: AYBFou2tv9qgH4gd7WOH0dGHJyaeLWoKsiju8QryewiFUPcgGS93VDVRim7w4iN6X0W
 VwvnjF3Vk7riyk69jghuY/+RN7Wkw1ZmWBbpk5n8Rmj1VZMMQNLqa+IwGLrkPxdQYEq/ZiFVM6F
 VAVE4CF7KeKkve8/KzPelOZaH6NOGd9WDnjJI+c3b2AVxLy2RihMLvWi/YFDQzuvoj/sSX7Nz1R
 luPgpkXbHkC23EB0I6UyHtVFx8uQ4aI5GT3gkOlBjzrq7+EkTnjusjxp2PYI9bel4AnSWwk0wwH
 qrZw427AWHGukE/Wc75CedXwu7zXiaCXu2Q0hi2iBY/3DR+0rsAouB7hCEEaezwznvk5YQIKY1f
 Mv5bOaH+wgM72iXfY/jHFwg84v4DAlNl42OdhGLo13cXZR8O6c+3EPhMoPvXXYsLdgWb38iUB3a
 FuA0+4bYeIvmhx1ocsWSpjBYVg3ZuYZcyq8SkWcoW8tLBYNGsvmmpQRetNFGYFv43U3vOWqe7dz
 xecwn7CV/RNH5CKdVLTegY0QidtWIS6wfODj5hI9jZ9VlBWT3G5FbDukpoKGN0pduZdAPV8HUsm
 A/VXApNI5jcFQViwkePyZhOkeR/57LnLaS/oHYMtWmUzQExRuWIhUzhU1Iaxx3cLqz7WWyTGL1w
 zhgP6HJDCUg==
X-Received: by 2002:a17:906:a255:b0:c4d:1768:48eb with SMTP id
 a640c23a62f3a-c4d34c5a0bfmr423975766b.2.1794036154904; 
 Fri, 06 Nov 2026 23:22:34 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:34 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v11 04/30] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Sat,  7 Nov 2026 08:21:58 +0100
Message-ID: <20261107072224.3492260-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 14b2c7eb2e63..5c83f17dfc4a 100644
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
+	int     (*init)(struct usb_phy *phy);
+	void    (*shutdown)(struct usb_phy *phy);
+
+	/* enable/disable VBUS */
+	int     (*set_vbus)(struct usb_phy *phy, int on);
+
+	/* effective for B devices, ignored for A-peripheral */
+	int     (*set_power)(struct usb_phy *phy,
+			     unsigned int mA);
+};
+
+static inline int
+usb_phy_init(struct usb_phy *phy)
+{
+	if (phy && phy->init)
+		return phy->init(phy);
+
+	return 0;
+}
+
+static inline void
+usb_phy_shutdown(struct usb_phy *phy)
+{
+	if (phy && phy->shutdown)
+		phy->shutdown(phy);
+}
+
+static inline int
+usb_phy_set_power(struct usb_phy *phy, unsigned int mA)
+{
+	if (!phy)
+		return 0;
+
+	/* TODO usb_phy_set_charger_current(phy, mA); */
+
+	if (phy->set_power)
+		return phy->set_power(phy, mA);
+
+	return 0;
+}
+
+static inline int
+usb_phy_set_suspend(struct usb_phy *phy, int suspend)
+{
+	return 0;
+}
 #endif /* __LINUX_USB_PHY_H */
-- 
2.53.0

