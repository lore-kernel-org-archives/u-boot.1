Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF52EC5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6159540D82;
	Fri, 21 Aug 2026 13:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoeybQpf8cb4; Fri, 21 Aug 2026 13:15:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318115;
	bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TfaDDILnr/x1NYGRDBv4tSixL/G5q9V9EU0YhoK0bPqH40uYOCiba0CICekrVyUXA
	 C0K2RCC60Oc7RnhqJmDUIIE/ZdIvOaCoLvyavJ+uUjxTckg/WlaHyLNZh8t3r4/65F
	 qRr0aIoO95sKpuhxdfKx1nvfyBpfUT1lzy9dgghgbIB8k7VSHi03co9TpB8g40Wmhz
	 JkjoMRlN5XptEtV/mc8vy/qRsnOW+JHOF0Wpg839FOo93zZ3l781UxJAarGaShNBAH
	 7H1uc3+lWAGtpkqdNUYi7fIwCCPq4MVDgA5IYFC51P/AcXoRS4bxscWZ6scf2veKu4
	 lxeTXJ+ucwj2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BE4540D7D;
	Fri, 21 Aug 2026 13:15:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EED3EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84E4C407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJ27fbgkN6F9 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=X3/7XLGp
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D8FC40841
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:24 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so145555a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302342; x=1787907142;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=X3/7XLGpJzw92+6bgExevZTMVx/6Xge4yhSo9K4qoYoxjcWH2x30q45q0LnbJcFCdp
 xikfIZ7/l5DF4mOyBhDnw0pFYiV1hGJD4eFq/BGGXiz82KOgPRFHbvRlx/paNU6MSHsR
 4DW4gmPKLTF7/ZUHf9FPHXMZ/C61YmgUyKjfk4BA9ZWaPMUgdfgehbkLDzWYS+OOCTCp
 nNXgH5Z9zH3lXuyXbDVOgzXC0j2aTz/GEus2aEPk7zrxgKtxEkZwcpbAXt2BUJmZwcmB
 Wqahk3haO7fMVT/wx2QvhdPQWBY5n+04/3PR3n79Reli1yHjuAx36+yzyfsN593+aoml
 x6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302342; x=1787907142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oY/U63xg7cvS8opOBV0PPbU2cGbeU1DYdySFVn/4dSo=;
 b=WLPKd+HbVTGR1URj4qqivIYXJhJ6TRSuZrrj4Dm4/ZqJhm6BXoS57ziE1Xuu6Df6Yr
 rogJPYbNfD0a3jQiC1PB7qf8PtNPsw2DRb7RxhAO6i/OJWbWwWpzsx6LrVqsIxZconfI
 z3VgrU6Vk2e4cRpGIHGMi4GD0JPYQUkqGe/ChZ29Hayk9JkJCuPFU0qbu70H9q+mkpCv
 BbHR4RGnDN3+F9RG27NR/5A7aP1WYCCzjyjdoZU1c4k6f8Xo/9JvBew6hYAjE5DJFGzp
 BlCR+1/tVL2E5npanfu3IghRrOLn/+RWLF8DI1ejNc434MrZ8/TBtYg+FRtew2pC/TTF
 mLMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXEBTr3XI5bw5ZVWTzfC6SQu+wosFqQUDGKneCMBe6SZj/mBxl/zb5X7NeiK3RRHxE7CA/siY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kkiDfGY7oQMmF+/atFqdjycBr+Zs/WcIr1lZsPfLyyjONOXASG
 NGAXRPLksz7jmq1gT2AP5EB9gHXOM25xUHECwFmac5mqLGBSEzu5qAtKuTfixBrba80=
X-Gm-Gg: AR+sD13MuDDqS28mIriyiI+WWXWR7/iJalh2KywEfInnWIBvaVkxKtV0hFBqmPiDpoY
 X0iVthWII+fafmW5eSpeUQqq1PTHV+fXqQ75M/9aROUbx7yLOnyJFZvRNb9GDOOOKPilqgGXVFc
 +kFwQk1o41wf/ObpQ1KbQogLfoLikeBqXvXMMxy0iVJ4hbuUaxnctOqnlhkcIxkWmS+G9rLIQxA
 ra8th+LLuvtgC6kB+p0gDNySLx42LPBtKYy9D9uABuw+HsXYXJ/uXOKOMK10+kgp1Hee7paDcFK
 IIBS+kaMK1UvrYRSjthUDv5FvEgxaC3IpyAsHTx/yw6LeH0hy/mR/IINw0PVcF0A+DtvBZ3EGIG
 2rK6z2ZfdQsNAwgHD+MMyj9VB/J+bF0Q49fKxlLY3jBk6ffEIC/DTis4iEoEO2dYvGYwhFPXD8K
 TvKeh3l6Faj2zNg0Wg9wjo1OpH3qsDzP6X9qv2Yt0nlML76YJJtWJseY0lC2I9z+97x6/WEqKhF
 tkw3nC4BESZH+KJ4C3E+PBe
X-Received: by 2002:a05:6402:249c:b0:6a2:9c3:6926 with SMTP id
 4fb4d7f45d1cf-6a42f1bcc81mr2545839a12.1.1787302342465; 
 Fri, 21 Aug 2026 01:52:22 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff17df84sm6839096a12.31.2026.08.21.01.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 65/87] usb: phy: add the usb_phy helpers needed by the
 resynced DWC3 code
Date: Fri, 21 Aug 2026 10:47:41 +0200
Message-ID: <20260821084829.2070426-66-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

