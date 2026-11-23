Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD9606A32C
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zpDXBVGA;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLJOcNoE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 274FA80C77;
	Mon, 23 Nov 2026 19:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_F06QuqXm9f; Mon, 23 Nov 2026 19:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66BB780C68
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795463645;
	b=WTiHOrhxyLs7Wj8M6tZuQhbPVA6gTfuUv8OegiNa0w+lfyCjboHKbGdPP30ARnp2MnzQ
	 CkD1atfObHMRT6HKt67dBS1SZBP6wscYk2PvdAkFkeW7grsDQ3HisOZr6AXpssHWWkS1D
	 XlM7ZO+qSlk+iBTfMUMxPoHHq/lTyKLOe79/NvTV069diIQztZoP0PCnCD8DF8JJOSFj9
	 UZ0YIg3A/ob4sJnLCoU5CIaeHqBTPCZdJ8qY1XHjUUD+D9yu72y/6FE0riX0qfolOVIom
	 tdmx3FA8jTrrxKifS9eTrFrZb4yOHHHFtpIeTvA0QQLKZI28n6vJbkWFyNZMVVSgtMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795463645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wNcD+oqmsLrp6SeVRhnLef6BLXg9tvk0R6Z3gNUs5Hs=;
	b=nFRvS8gjGI4Bqdt7d2SrMOMUl6JbXdlZcHKwacFNaLO/bYpJnL6feG7YyMVHEmvLaJg0
	 nmI8g+lru2UTgAnVb9lhGyMaRP8QJHIHb8zswmvZh+j0LXTYPebxACzrSmzvVAZ/BQSH+
	 P9fI/bGxfpE1LvQqUOF9H57l+hJOmLy8qF+qffO8R/jny3tQqg/ZBrb2neASJOuDh0lsr
	 a1Nd6dPhE3jIUY7iqtsL717odJM2kkI6jvc8dGxKYQ+7DDMCDGYy7j9Ajs2JtS4VIhUta
	 BeSlHs0CAAGcCGSZGhQyHKmc1NwDdapCKdjBIzr8+t3kv+tLKxIppGRbSl99mIkpijA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795463645;
	bh=wNcD+oqmsLrp6SeVRhnLef6BLXg9tvk0R6Z3gNUs5Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zpDXBVGAab4U0XpMRUN/AAUHZg6/Nk8kH4ZaJ0DlUuOjVT/WrqDTGaVFcvvHUiVjf
	 a7g37FBnKnOCMLkRLW27k4EavkL1hI4w6geimVx5xkyt08NIm31Vc4BUdLRAykxy5n
	 qE9n6MeOQmkaUlcKbLey88PverMS/PawAC+e3wuGk8Q8dgHpYua0f8LzB6t/k12E+J
	 S7hA3wJJyndltfJm/fHl/+owbAt/ultUCAu/oSGyDX0EYmdUxR7BLgf/YMr+ESTS/f
	 uYZI0LXJdPM5oJuo/gDILO1Z1YrVXRxGiFMrpedow+yOcCdm1iAFyCfwdxnGtN1We5
	 e3njzx/sruDLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66BB780C68;
	Mon, 23 Nov 2026 19:54:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC230260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB08D60678
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLrRs3QkEpb6 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0445605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bLJOcNoE
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0445605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:00 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71acdd32a53so1529217eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795463639; x=1796068439;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNcD+oqmsLrp6SeVRhnLef6BLXg9tvk0R6Z3gNUs5Hs=;
 b=bLJOcNoEj4P0H8xTbl7RqNOqVFJh2U/44mlJu9Msz2cQjcJMfVL753VYey5rr9qM9P
 yswYDdukyBqsADfgs45y6yo3byqLMudWcwaSJyl1bbRYYGFgzOL3tfQxCkd0QfKWCW6J
 pdO+VlVrOTwVzEyVPZCTQhp+jqMbfAH83w9p+TaxYEZQUouZ+TgauFmGFyOfNaqW6SPV
 C10YVcDtf6VRRaU9TSnIv6bLxI+01LFsBKOni8DjAURL7v324Yq3i6Vh8W61MOC7U7zR
 Ht7lUPTpMjQb/vtIPyE+l6qwmawmUGawlK/Zuv7x/mWzNXZ38CBpKOXD527uX7P298WS
 3xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795463639; x=1796068439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wNcD+oqmsLrp6SeVRhnLef6BLXg9tvk0R6Z3gNUs5Hs=;
 b=wG5WW7TVFh/NThmXCNvLspVrMOVCNem3XDMe/6GojYAPWOI5++1yxnTrLb4eAHawMu
 pkAKuxT4NW3qJq+DGppTVW24p8BLQo9u94iDqqVIoeEujBqalbpY7X1wOvBSnfizo1qL
 QsF1jDZua0HCT+r4pg7pkAOzLaHftwHmD56DOkfrDkpAxwoSomw/7o6EEAvMe/fAUX0B
 Nnxm5/922tKWhAW3X5QGidG79tnneH8bKD3bR7O4I5eYONYlopoMsQaW+tIt3WpdwzgD
 9TwygiVdyBAlCa7WWPca8+bZwM9HX2Wl2JPK/pSy15NRCVpXi5KcErJGnWsxMt9BGiV9
 iigA==
X-Forwarded-Encrypted: i=1;
 AL+hErEdNMELivjZODXVdcE3L2cxCDOP0IZirTVQDGYLsQ3Zg3QeN1GeUOa2c+8JxXYIySfAHYmktmQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+yZ+B/YHRUI1oGowAm/pXuoshNApiFLmFqia3sUeovs7J1ZLSc
 QwUBO/QmF+NilZ+nI/4JSTmdaLWeTC4HxcYcPKRZx3UF+USvMHrucG0j
X-Gm-Gg: AZFdTZc2LB5ozynkfdN4Jkd72pJpKnc/sx8yElXSUfAp3zzSrCW0hfdDicMeWW2DSpE
 T6kd3Oy/loM/+94hlTgAaGbw9QrnvZ1LNcMgz8k4tOut7lVPzL+pyxL1H/uw17k7p9FhSVJFbA5
 Vx+EJaeK8VBBKWkiKwS59WMlZTS6JdgbHaUI5JifzIsaUpdR+vgWPKaS4QX0NNQvibu6KvpevI4
 2irJrsiQPmCYBYC/0PO0rxAvUZDvaPYd9+rO6Tb26zueXKWCGFILhFycGPkA7tVdg+rsa8F+YX2
 PETuwGfVFWk5Btyd9KWnJIgapJQorrcF/bQiegsIEfuAp9zNfQnDemm7U3KPakd82URqvDca8nG
 UlXH/p0+mFKnXpSH3HQyLvNCsxxt2jxP8EegRU4bT4Ln83Ajd6IlxPAkcvFOq1LBx12qhBmFYS1
 jAp5J1v4NiUsXQN51fRSB3BsL0rKlNw+k2sq+mo3eAwFdfF0vJyFe9DhSDUjrRLSG21BKvDjh7g
 oJ3lUeTAF4SFwsuq1nlIDM69Bm9cmNxNjiQz2+eM9j5hb4J6n34oIUSWaXNm+yDLEN10g+cTS0M
 ER2+TS3J5kJbakQHbO7qBLzlw2oRHryuUnW81QPQhDTkQoQN0PCWQrcl6jTOcacGDBf9O9Xv8JR
 a1+O68ZiNXAQapdW0vni/VqSk/wsfwAUNQFYO/ljBtRblY2tX/K6RcFzdqjiJHlxpeOzuPLpVit
 HaNEJd3z3bo1lYFHsOXGHDFjhP5T8q9ASn8HNmdRfZo/47NelR9Wlj
X-Received: by 2002:a05:6808:f13:b0:567:f784:f939 with SMTP id
 5614622812f47-57a0bb54177mr11196668b6e.51.1795463639463; 
 Mon, 23 Nov 2026 11:53:59 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm10307575b6e.3.2026.11.23.11.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:53:58 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 12:53:54 -0700
Subject: [PATCH 2/2] net: ftgmac100: allow conventional PHYs with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-ftgmac100-v1-v1-2-6b34bebaa2de@gmail.com>
References: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
In-Reply-To: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Macpaul Lin <macpaul@andestech.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Selecting lwIP disables the FTGMAC100 Ethernet driver even on boards
using an MDIO PHY. Its packet buffers and Ethernet operations are
available with either stack. Remove the legacy-stack dependency.

Keep the NC-SI interface identifier available even when the protocol
driver is disabled. Select the mode in platform data: a use-ncsi node
need not specify phy-mode, and overriding only the private mode at probe
leaves the network stack unaware that it must configure NC-SI. Reject
such interfaces early if NC-SI support is disabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/Kconfig     |  1 -
 drivers/net/ftgmac100.c | 13 +++++++++----
 include/phy_interface.h |  4 ----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 72b77064638..b23f34ef0bf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -509,7 +509,6 @@ config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
 	select SYSCON
-	depends on NET_LEGACY
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
 	  Ethernet controller that can be found on Aspeed SoCs (which
diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 782aad4b0fe..542a9d63f2a 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -814,7 +814,15 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
 
 	pdata->iobase = dev_read_addr(dev);
 
-	pdata->phy_interface = dev_read_phy_mode(dev);
+	if (dev_read_bool(dev, "use-ncsi"))
+		pdata->phy_interface = PHY_INTERFACE_MODE_NCSI;
+	else
+		pdata->phy_interface = dev_read_phy_mode(dev);
+	if (!IS_ENABLED(CONFIG_PHY_NCSI) &&
+	    pdata->phy_interface == PHY_INTERFACE_MODE_NCSI) {
+		dev_err(dev, "NC-SI support is disabled\n");
+		return -EOPNOTSUPP;
+	}
 	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
 
@@ -856,9 +864,6 @@ static int ftgmac100_probe(struct udevice *dev)
 	priv->max_speed = pdata->max_speed;
 	priv->phy_addr = 0;
 
-	if (dev_read_bool(dev, "use-ncsi"))
-		priv->phy_mode = PHY_INTERFACE_MODE_NCSI;
-
 #ifdef CONFIG_PHY_ADDR
 	priv->phy_addr = CONFIG_PHY_ADDR;
 #endif
diff --git a/include/phy_interface.h b/include/phy_interface.h
index b74f4ccd84a..8e7f907725b 100644
--- a/include/phy_interface.h
+++ b/include/phy_interface.h
@@ -55,9 +55,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_CAUI2,
 	PHY_INTERFACE_MODE_CAUI4,
 #endif
-#if defined(CONFIG_PHY_NCSI)
 	PHY_INTERFACE_MODE_NCSI,
-#endif
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -101,9 +99,7 @@ static const char * const phy_interface_strings[] = {
 	[PHY_INTERFACE_MODE_CAUI2]		= "caui2",
 	[PHY_INTERFACE_MODE_CAUI4]		= "caui4",
 #endif
-#if defined(CONFIG_PHY_NCSI)
 	[PHY_INTERFACE_MODE_NCSI]		= "NC-SI",
-#endif
 };
 
 /* Backplane modes:

-- 
2.53.0

