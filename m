Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5A606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mm4ofwdZ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bAE8OrDN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B09A81681;
	Wed, 28 Oct 2026 14:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elGuJg5QYzQf; Wed, 28 Oct 2026 14:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA6C68124D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198881;
	b=UodL4s2AWfH4fylOlrQmWGBcfc00S0wcFx91eul4/mMTNNBhb8nkofAy+ZgoioY19zcC
	 gcpvobCs7oLy7GLWOGCtoP7qmD5/tpQ/nB31c6Vd4kYVBmsY11It9jPvb3FxxSskKwuui
	 Er9CG/de+iro3O6xUbr40bQpslMsfkr7zOXeWdpsnsMLk0Ob/US/tsFx8ntrDK/lCTL8V
	 VJN7U4AlSp1QkkcT3/6LoZ7JEC43g/MwMK6vC6SeAjyRJ/GVDObndghjaW1dD3YqyumwO
	 uehfaXCEVEVMB/9/GxBoDLFn+XLkPTpPuhGMF5I9aKl06vEx/5MTziESpDgGBDKdyCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198881;
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
	b=h77NI45/IDaoR5q3iNkX2uGeC+Zk/R6tPil+Vt/CbI/J41hr8IaCulWoFBvkTGbSncHt
	 04c5hcZkUwLk8IrnGbYYFBNF8HO5YgMrc4weceBwP/rI+8V8dTwIF01Ytcbog1qzfyZgI
	 EfnJlhgbV6KyLij5HmajAEG9mnDtyezrFf1iR3Y11a4JpwQZH+z5hwg2b5vE6sbsIFXsd
	 mq+7uLmQZGFsmBKjuxmh4omSiTNoFWbG0nmnB8j0HeeKcATiUTc86EWBzU9ecz0rdlYlY
	 KZmbjeroyfgjCvlPasTKfG615hPW4vEDXNKq01MVJyQUTIouncxkG+dFbI4fgfoRZ3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198881;
	bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mm4ofwdZfTA4/U/yxLQVeamyDTiTL56Cnw8WUefleNpnmkQswt+pWPDbRrZ+kZaMy
	 uSxWtmZa3FLyc5Jmgf/gpyXLCj4pVL6uvYSDw5JJ3NA8NnHyBbz2DLPQyYGuprdDXU
	 zxpAs1pYs559RJEwjRy4MQqJtQJ25cU1BGQM9zbvy7cQwMgK5PuJCBEka2IsKpSGGv
	 YVqxGSsb7agzuCMs3WchnMWjYmqYRzxeqNQ3HbbKuewi8pSYbh0rUqlI8tQPZhLhwp
	 G0Q2P8kXtTNAcS+hTY6g+r2l/PRjrg3eOLqz6gmdszVSQoHhK16yBxQCrzAzermnyA
	 xvqwE6JS+73oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA6C68124D;
	Wed, 28 Oct 2026 14:48:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7FAB972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9F204008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ju8XDO9fJzJj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC8E24009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196967;
 b=XWNV+DK6gqdBBuyVsM7RqZ/tsg+pkUTaaCawoZQsYoxFdMeOXmCmov8VjTW8MEZXNkqn
 ItbI0in4J1HElGe2UUlsQlrDAtqSyKHlfmpNhObeu4oZfi4Ki8mHkmnYEsrbBJun3MmBs
 pHC9UeOgqbIUi2WUtuoDi0e2XqLFdnFqWo8dhsqLYLdO9dxCoLPoy96lgEF3vQXgDt84I
 W/RzNZBMvUIKQZ2XDXx1HvxROV5fQ85JZTpFiwVA+l1iqieTyJRXyn//mJ5rhUmMFRzFW
 JG/QEJbFYvu/QxUZXggHULeRYwYIxA47z9f1ub4b+JWuE/5e7A+KF+rIrAa9GOKBnBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196967;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=T7xQYW0+XenoIcfLnOTzIQ9OsTb885bL8k+o3nx1QdTg7JpupNnXjRyQf9yffiWpYHgB
 4Gl9sRqNS/6oEFho2RysyeqmFvRIDl1+V91m3TkP6ODv06XXcTw7EeY4YC2sMbAVz9q7j
 32LSl0dwyHrByWSjYESNipPskqjDWWPbliOwKS2WZtd7PNLwpvSMYIUqWXCb3peu2ygAS
 AWZUnRgroZiCWn5/OywAd7CGsuWQBMsR08YtWFHpkDl6VtSKFPnf+f1XSXuMSuyQfh2qI
 L8YhBG/O7Ko6ubojqTeNxNPKJhSc6nLT/BcNpjnnCEoBiqsLG7RkNAh3GpQqGdhzH0A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bAE8OrDN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bAE8OrDN
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC8E24009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:06 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so13433666b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196964; x=1793801764;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=bAE8OrDNfj6c7TddPBv7YhgqgNDHCEM30o/1Adig8UIkMVc6wObNcLODvVJixbTR7L
 qRz1UK1M96BomT9zkXFPvp2TsMQ8OeaPCNtqQQ6AnZnp53ZiOhf7wdDYdlFMR+4xMXOV
 9iXcw/05JBURKyz/4vK7xw46EmhocSlLxF0rqYRJp4jV7oq6Y/jD8Aq98XfBdQGMlcWL
 J6CEzIQVBHE/48pzieUzXQqHUiciWnSBhAqjRyARYJawJIb3XvV9dF6SwD4HdGEGPjAo
 TUgPVB7ObrJNTgbzepgSMzcx3sgalAByzbH9OMXvSz6vq3/a0x1TBVjza2HViJzpkU/X
 7B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196964; x=1793801764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=UrrA3KGYqg1jH1owMASsl7RDAqa3WwIPkcCS45sVbR5jvnGagdswZcZU6iinU20kZW
 hM9ukKqqDACZU0LNexERiLFDZvuW5Z008UkGnkCu5au0nrLXr28q0Wq3NMB6eIXBYojG
 b+hgzNYfLlYF+wek1eXbidQLIRyx9xgsZM1VotS3OaTCX4IW8paChSu0pMk2+YS4MUv1
 dXNRDMxfb1gFeHIK6G8FgelZ7boP9iDRrtoObFvdBUFrf8Q5vDIPniXTiRlZ/FJxPrro
 zRFzUQuj8wbCNPMQMRK5YyO30f6W+J0U1ujAQaCFQUhImEfpSoPceVHkfmG5XXeobR6f
 BnsQ==
X-Gm-Message-State: AFq9FYJqL7cj18v2ZuUDNOs/ZKyubsdnJz4sf0JjnP7V6cQV/SNuk/WR
 CK4qtANUSEbMhT5NM31ySmPUuFWgZ3ycocjs1hkMseq5ygKv1XON3lhkIyFyVxRvl2RtUrWEq2K
 9zNia
X-Gm-Gg: AYBFou3rXs/5EGkwtJf/ocaB0iP0iL6xFFksZGVd41Myojg/PE4oC8ytKFxpt6vPsvO
 cUtM40MbDxUv9q126eQdDAoJcV7wQmfedIZrEjNuDAL5xbvF4ytLaI1qatbbLx6w9C7ZLjZmPXD
 sU5Nz9Fnz3taqa//QdyFf46gUshegK+lcR7URTenavsOjnDK/F+lzxBfqQ4jkQpUkTbXVWsMiSb
 8bXv6T0N0hGssbWJx6M88VFq8pyoJs5BucOEhZvBDyXOBveZlGJk87e251hAaSH42SptWeILOca
 Zp7lQTmlR0TvCpOgzAZSEN1N5gHCQEVQqtlL0xbQV1YzrPbH1zzpcB0JSRwY85tReuLMcgeMywq
 75iwKRSg7E/Vc1iAOloVTVF0r0x0sOjqMSDGWFYAIwiiPI6sAJLkaJRzx1K4dtFMtL/okApJM29
 N4d4qodh0NLagdH7j2Z+r10lZcAGWx38+0k3ibtr/nqqXLPdFRWoi65cpLXwwP3LVA+S+wHcVpY
 wSG7/2dBM7wcvZKfExTakE2DRJwAcnQI44Y9C39yM6O04N1HuD6KEQ93cXTq+dwTjnAjoPxhlNF
 mgqGxkvO+ZKhliM1JnAUnWfEycv/7Xr4WSCg20YGY2lvlcBxYUqqSXh5VmsprCRyKZheJKuI8hM
 alqJyNK6XSXyPEWuOFCe/+268PHyGOkE=
X-Received: by 2002:a17:906:9986:b0:c46:b5a7:5b29 with SMTP id
 a640c23a62f3a-c49bde9c83amr232637066b.2.1793196964407; 
 Wed, 28 Oct 2026 07:16:04 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:03 -0700 (PDT)
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
Subject: [PATCH v10 04/30] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Wed, 28 Oct 2026 15:15:28 +0100
Message-ID: <20261028141554.3073545-5-anders.roxell@linaro.org>
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

