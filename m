Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D3606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tvI9u24B;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dDup2vN8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D0D56071E;
	Sat, 21 Nov 2026 13:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYjEdV4GushV; Sat, 21 Nov 2026 13:14:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82C93606E6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266862;
	b=h80omzNytIBkbblAEtXf4zRFLd/gQTSfxbB3v6WR1UeF7oQMnJBYfJo7QnLklLAaA/f0
	 zSs7XVu9jx0gugFYWdkno1NrzgeuafzKSY7ARapUT2q8A1nN9MgfkyM6T4TpMzu3OonLp
	 CSQi2f6itT8IS/ui9wiNnzIWCnhF2L3ph37Mv2MhZIaDHE6xy32HaDwWqjAP2XiVKsnuj
	 joWDi2bO0mO3dXMpOG0dqW3qahO8BgPxZdh9BDFHsw3gwixEeBtBbsBFRmAsquKQC05Kn
	 DMUBzFwPR9Za9xnDQglsizwQk/cLnPNYXOEqchmJL/YL5NezAJ6GUGIcfHo212QQnqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266862;
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
	b=pqITfGSBEyAPyn5L+sfLju9PlhzrPrRTpuRKgxjQPlAXb2Ilz10D5pCjMBtDXu9Dj2Wl
	 bZaDOswHIvnrY/OmhY99fwLzBuzKTADbe3hYUpYD6TIGP43ZJK/LIXocu1I1fsSSgdcvh
	 czt0uqffymx+o88L2Rc/sVSP0ysEwsTKvTBHkfp+3DQatUiMsapThpp4SzTg2dNlzmrRJ
	 CerP9O7ghEnNAHch0WzW09vzNcwfQXqc9yHZTLVS53LYiGufIM86II7VA2/MjG0+/Wgl3
	 OMPxj8bbcrdB8KLWLZWmy1v3G0FTxrySNqDHN39SdmrOLIkSVpFEusZy7jLIqwJtaNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266862;
	bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvI9u24B32MglDTjlqGsNYJ+N9zqHBUEZA6m3T4L1AvGPPk5LW+shEZ85RkY7JApz
	 OE2zN/3XA6AdhxKwalhTRZW+uUl2UwSjBqAZ+4REuEXbI6aCJv90K6bOymvZ6YsoGC
	 6clfToMAVGSF2G4Tj8iHaXxwsJEYN7Rf7T2c0LNkzB/b4ZPW1PhZnOmA2TKcWRHZil
	 7kPLC/6A6t1Uw+deUb5CF3pbrralAkR2vn7m6VWrkoPHFTQeJXm1Cs1OTSo5ybbjhO
	 OY30QFOyF36wxbjYy2pL0UPCip6lq+XlpG6lt7aMe7cTReHhCIXtJnQWRGZk4QxsfK
	 4/Q+qHTkEEjfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82C93606E6;
	Sat, 21 Nov 2026 13:14:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 217F5260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12BF24068E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EWJallHXUaAS for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A9DF409F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dDup2vN8
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A9DF409F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:56 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b88aab58fdso155285a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262035; x=1795866835;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=dDup2vN86h4tlDDKZJtq74PeQ6Q4dLLWbzbNI2+f2hVkP2tbKebeh3v9pQEqazybWc
 TLHC37uAgq2v8N6VDUIoSMkDZXfXG2iDlk06iUZVrl7Q7faASUJX4Qmvom+d1N/Viq1h
 z83BXWXG8m4WuTRR07FaTG4QonI+yvOaR68Gj+rk3AqauMeEO4mcan8q0FRCLoZR7//e
 bjLhfG/rqYhvgz1JXULAB54N4TwG/HUP86BqEUUnzkDOm5/a+tlPt8ouGR1leKiqClZv
 leYBJHmhaUdfuE1BM+Fq9wDLMFqmlbFR2ZU0GgUKsI0W6E9NQ/jd70BCASXWKswgep5Y
 J91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262035; x=1795866835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4H3sFLDtt42FpABG0XFyikFzBVXr6GOrnxI1tbYYuQ=;
 b=kTaQ823EwERZpGAsTlaaJMRJGF4ntqjzSmMeNHjpW4r+G4NTYk+ArKfcCm6nzcFvL7
 +c/36TCCLd/gFARgOYVRLBraI4hyYUkDw3wvi69nccfNA54CQ1zmrmBRpTEMGJULPAPB
 lon6AvP4emtxpdzv4lAZBOeDk8s+bD+6nMN/E6AjouCOlod9d5qeYsoXs8KaxhSfIKNE
 r5OZ91N2UJzW8BEz8ufmI6GYQOi2Tuobo6dXJkDSQEfCg9I762btXQnjQEaUgs4+wV4z
 dI36oIxMpVMC8HI4g/eSLaE80rBel8EsS6uEFT4vJ6Hk6n/vDjpEQnJQ81jgtmk21ocp
 i81g==
X-Gm-Message-State: APuU4Z9GCUtfNWhlKWJNAu+fS80sdycU2AaSdcoUgNCQx+VujcItXlBx
 4TK1vt24z+nwWV3gUN3WAUr47Yf0TUUXzUZkiPx3/cJwC+lZo9T5/WgvAOvnEg1L7wzF4im9yFR
 rB9Ro
X-Gm-Gg: AZFdTZcD/g8TwbnS5uk16f0/J+QFgkwJu14VPWkqvLIovCddl4BsqCsP5mk03QDF+8q
 0Hx8C9D63UPy8XSqug8LMnJsJWmWTAFpIHal7M0W5pDZkhxKNuyKzFv7GI+S9Dxn9Afp1w5jZOB
 iXQEfi/jURSUPyBsNLGCdPf8g9y93i0XWTZ8s3LXnYVUuhZHTwFYUuM6kqGrWnl37096LddeweA
 GfmaeZHJgMsvou7qTmmLDGgIcJDIJpEEh6ep/6Q/o1GlcEkgubbnTHtZEPep8tF/aNSxymLSO31
 oB09fHGDg6871FKShxUeO5qsgm8s5q/1cdq+2SeQsGI4xlxfHAExnpBCocAZZoBwJaHl3WhSBvc
 N31m4181/DS+la2xkPiazsJtjntj+DBILwPWk2xGTM5sNsxB3yLXnR1A5h6GwHZmMcAEjpkjEfE
 4xZ3yTQu8c8d51q871wQy/ry32WhTJ3Kkit905szqbHw/7ToCS1NSyg7I+LZ94N4qtZzhqxUGTC
 S8F+enFmqjnygFzZZLqWQqBr3a6JUiLoTqk3HxZSJcztQM/aQlguIMOggrVKV4JFzDwiJo9rNHS
 YveFuY+OQNvLvLfLnR8ezJaa3Od4QKRxiTsabx9Lp2yOXmqiKpYMSXEpm8UZm9wb02VjPHdjXWZ
 hzUaA+neBVg==
X-Received: by 2002:a05:6402:a545:10b0:6b4:2960:d381 with SMTP id
 4fb4d7f45d1cf-6ba37c76e50mr4012501a12.1.1795262034673; 
 Sat, 21 Nov 2026 03:53:54 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:53 -0800 (PST)
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
Subject: [PATCH v12 05/31] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Sat, 21 Nov 2026 12:53:09 +0100
Message-ID: <20261121115335.548142-6-anders.roxell@linaro.org>
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

