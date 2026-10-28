Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gRyOA167;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yEa8XxNB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A5458125B;
	Wed, 28 Oct 2026 14:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBIM75QkiEwv; Wed, 28 Oct 2026 14:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BADB81266
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198890;
	b=haifLa5Mb4KWOD8PkvzVnC0gCXnSQS9H2EQHvB+8m8qmIYUtbOIv9KzD+1gOhJUDY7kM
	 JW4ERMarWykW0zeulDdsPXoA4VDfT4rt6Fkyyuqx5jOTf/M4+IDLZNKMQcQo4k/JX6bGV
	 FiFG3aMAoGR1cKycGxP3vHifpdD2J4ZyvqSFr3O8OMCXPfOEAYX2CekKDiqDZNg9iS8GX
	 u35L3b8BDRlDxDp+m5oSv9kGHge1MRUhXwVesBzdr+t0Uq3QzL9d7uKPtD6vTmJYWHWqt
	 Rbj3qoo8cNRri4LbhM1I+EPJC66HrqVdMHgdPnQJg4MyXmCqW8WZd66PECykshp2L3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t6PUjGljGtE3tk1tXtIoQBLXryeg81nM8Gig9j5Xhyc=;
	b=Ac+BxfGHxzT9fXOzcw4MxRl00+9NkscIntzl7jIj6DM7jPbCrYC04tbBFQT0dl++0D5I
	 Kax7l2B2VG/V8aHCgU/tHXnWJ+XdJsJofLHcEyEnrTKzl3AZDoNTjrO1odnWOq2j60+n8
	 TLzakoDoz/rUO6yng9gg7jp7Pm6M3Pvuw4iKKnzojdH6dWSPwnloMdhPpd+090ieA2TPF
	 6Q5AGdKusbxkKZMElVw4J1OTW/M641vQqxZFDOZ9xPqxld6CblDGQzLJOaNDUGBx2Ve0b
	 gOdyqLFv6VF4lBWQ6JzF7N4gTkrQGiovwBrSrkeKXto2iau9Wm0cG0X7mkzth0Yp7NA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198890;
	bh=t6PUjGljGtE3tk1tXtIoQBLXryeg81nM8Gig9j5Xhyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gRyOA167tiU4xHNeKE53DcnmG3OCj85y/ZPnNBoH3Tqp1wjtIiTspryuUXcuqYuE1
	 f3WlxffUhA22tf//1qB6SEgww5AbmcKOaNf+K+w/h3K3mdq3gOLEfRP+BnlXPHZM6u
	 H8Bl5QWR69rNWJ9UV9GuNAU/8fPoUVs6GTL1mekaaIDCGLK3Yt1SKEkwRgQE5c/Pww
	 Ku373u67cltTWiHCSqRSqCyO+NYWWCNhyqUGJYc0nwUc79dn2SGzngspbRLh75baiK
	 TIH/6D5CNQNARZ5roHsX/UMuE9FXIjbv74IbsJK2lFOzqGTvVx6rUK1zN5NtV5FLAm
	 y16k99Z0gyy0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BADB81266;
	Wed, 28 Oct 2026 14:48:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1D93235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFAF540557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2ZXOp1M0UxJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8062340550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196974;
 b=a/aXvGCB/helwB0aiWYf/LAhwaaAC/F0bW0K9FRVB6GliDhJTycROuGWC5xF6iZvOvD2
 /jnLaO1tMuoz5NYLimDymLBGAH6dcw0p4Cid1C9MCTtH2zpkQAi7eTvvjYvGW+d+aVBd0
 Sey3Pt0Vqr3sixk2PDK+DM0QUoP8IMYPMQ+ZUsv4tR7kXo9d150TuKDEpZeSta8p2U2Vy
 1aCN6NbxCv0ltEKRbUmMiMrqQ4T9ngnR4GW9TE0plFHwD/jzX62tU2amDw2HGzIegyOLM
 47fcK0Zg1CJYOPJcPMpSMy9+kjQLJBVrOMetsONCS7Tyg5PrxfrbQxWNw00adXnhrhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196974;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=t6PUjGljGtE3tk1tXtIoQBLXryeg81nM8Gig9j5Xhyc=;
 b=ZcPZGcgh6PTm7qGVsxTrghgBZZw7nLwd76inwh9l3WpnbCYxUp7i9wDYZCWZrLmGVfOm
 FEKdB6g1XOifaYxhvGHYwirRZyvfJhJIXPWA45abPCx9myLaY7JyjoKhH+9isHcXB3d0T
 FDrkgoZrrb+zK6V3f7DS5oeO+5i9nF93naz/WQpIh48un9TAehfNdSn8UEA35NIfcKCyz
 46yJga5DyW4hs8MLKXSWdLJF+CnfyX85gi9zMQ746mA7FRLZ3BMQq0b1GfI4LxKvBsbfz
 Sakhqo3UxiHEVNpBIUj9n8dfS4yF1jB57m55opzNtJm7JGQH/LSMa6epP216e3CmRVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yEa8XxNB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=yEa8XxNB
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8062340550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:14 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11420666b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196972; x=1793801772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t6PUjGljGtE3tk1tXtIoQBLXryeg81nM8Gig9j5Xhyc=;
 b=yEa8XxNBvVmwzM2uDy9nqUD7hyq7eoN6JXEg4rZsZPDT5W6l6QiFSPHzXXVHEu88hA
 Lg5KWqjK2LhITEIWXe6GAO8jcF78kO4iS1nVznUFkQFYHSV6GrCNyLOZMGAJ2YOCvNBS
 bE57IxFaMzZTc4Sg9ecIDCEFBZq9mA5fGBVm13sZeQ4zEVAV3vcb6fcPvyMRHDAFSSOO
 2FKxvWB5ZS93CBJ111jnx69+iuGWV0XQZsaEL7Wz940shrpqwsAtrSnSbEzTl3KLkHCb
 JBOVzGEYwOMr1fdzCsonlNdA8zMqsplyEhcbaxzdSrdFARW+gyiWRb4ZmmN5kCW2u19V
 Bksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196972; x=1793801772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6PUjGljGtE3tk1tXtIoQBLXryeg81nM8Gig9j5Xhyc=;
 b=a1tp1Ag0e3lIN6TU9sv6zce5ROfKkSxtEIhJ8yReQZ6TPE3KRRc8GkWfr/dlA3Ww5L
 RGuhx+suv7IOVUE0FVuhnJETjm45Q81g7gHHSCTNwXWiuoKe4hpl1oEj/hJrh6pnsuhQ
 1pavewcLyWgFe/hQg+c//nhh0fIrRLB06r1XLA9mulwNZApngTV5t6LJvX0ZiCxLCd4D
 OcL7friUNUgHS5GmWaetR9VxKu8aVm7e+tiMWG8QRC+wpWmvSEGqs4vjcXHXSgr2afTV
 S1d8+WKdB/54lo23epmFv2tT1b+5A5EIpz+ya9XRh4C971B4/BKAmh4+XQOfRSaJ/MEZ
 wXrw==
X-Gm-Message-State: AFq9FYIYzz33Cn8G+XHJ90GV7FnrLIC8WIQUXfaX0nWbvcONzGovTFGG
 KeTK3dsSn2zLcK8zVRDK+nATraEN3h15un0ybV4RR/eFWgZnwKjmE/SOEaTwoI0Or1JJVHqzcp9
 oCVOa
X-Gm-Gg: AYBFou1rNvDAe/WGVgwOXKQ+9caAvlZvO0DxYWi6Zvuv9ruxqIqEsH9EIN46mOj1x6/
 HH5QGXAU6zbsAmZ2NHWlAp8BNtsxM52lYwQul3mlxtlJj94BUp7t0FPgUhABZ7czJ4ogmB6irUt
 9PufHMJ+cbC7EStT6z+/3gLGnAYwpTLqR8PEbZ6SRI02jdyL5XFkhXY7Cy6eFYmV19oBP/XEr7y
 Q5I4M7rE65mbyLYS9HXSkF+5H+qwAG6bykSYSkE07csfuv3HXQ/VmsDpdIAboB5lcYudtu1JDfP
 hvncnZJ7VtKHzUjKJWxeRGVBwLKn5X2oqKvSQlH76kgu9l7h6dZrltwS6FCbMh++HoUyLqfpyWN
 fK87dyRyKTO2Z82Jh14shiA17i/sM+cNCAh42Fn4mCY2d9tYLdjUd8YIRAoXxm9gc+p69iq3bq5
 GygJgUl0STJ7LHGYpc5Ot/a2Glbi1G1b0Gkba6DyUpTRa1yfmVav1fx/ZDv8oQzGBB+p6W9gCa+
 ronbMgTHahPolIWRYaJrcwEIB0mGUfPwknkAgQAFWmGHXApiIvH0Tb4oeBi/6NZ53EqrCmFEbV8
 5H3X/5KikJMaWIwmA2VhFzj/wmVyXfo5JidRvZhqlaHqJfylVq1G+hhqMcZu2qwCV3MgTsvwYWM
 OCkwhMJ7Vow==
X-Received: by 2002:a17:906:5154:20b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c49ce7c8bb6mr46290866b.2.1793196972328; 
 Wed, 28 Oct 2026 07:16:12 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:11 -0700 (PDT)
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
Subject: [PATCH v10 08/30] usb: dwc3: core: bring back the U-Boot entry points
Date: Wed, 28 Oct 2026 15:15:32 +0100
Message-ID: <20261028141554.3073545-9-anders.roxell@linaro.org>
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

The Linux core.c has no U-Boot entry points like dwc3_uboot_init() and
dwc3_init(). Copy them back unchanged from the core.c we had before
"usb: dwc3: restore to original v3.19-rc1 kernel import", with the
struct members and prototypes they use.

A diff against that old core.c shows no change for them. What they need
for the resynced core comes in the next commit.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 420 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  11 ++
 2 files changed, 431 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index dee68745b94a..8db1dd2c29a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -45,6 +45,8 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
+static LIST_HEAD(dwc3_list);
+
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
@@ -1315,6 +1317,14 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_core_stop(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg & ~(DWC3_DCTL_RUN_STOP));
+}
+
 static void dwc3_core_exit_mode(struct dwc3 *dwc)
 {
 	switch (dwc->dr_mode) {
@@ -1336,6 +1346,8 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
+#define DWC3_ALIGN_MASK		(16 - 1)
+
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
 {
@@ -1392,3 +1404,411 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 
 	return 0;
 }
+
+#if CONFIG_IS_ENABLED(PHY) && CONFIG_IS_ENABLED(DM_USB)
+int dwc3_setup_phy(struct udevice *dev, struct phy_bulk *phys)
+{
+	int ret;
+
+	ret = generic_phy_get_bulk(dev, phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_init_bulk(phys);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_power_on_bulk(phys);
+	if (ret)
+		generic_phy_exit_bulk(phys);
+
+	return ret;
+}
+
+int dwc3_shutdown_phy(struct udevice *dev, struct phy_bulk *phys)
+{
+	int ret;
+
+	ret = generic_phy_power_off_bulk(phys);
+	ret |= generic_phy_exit_bulk(phys);
+	return ret;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(DM_USB)
+void dwc3_of_parse(struct dwc3 *dwc)
+{
+	const u8 *tmp;
+	struct udevice *dev = dwc->dev;
+	u8 lpm_nyet_threshold;
+	u8 tx_de_emphasis;
+	u8 hird_threshold;
+	u32 val;
+	int i;
+
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
+
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
+
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
+
+	dwc->hsphy_mode = usb_get_phy_mode(dev_ofnode(dev));
+
+	dwc->has_lpm_erratum = dev_read_bool(dev,
+				"snps,has-lpm-erratum");
+	tmp = dev_read_u8_array_ptr(dev, "snps,lpm-nyet-threshold", 1);
+	if (tmp)
+		lpm_nyet_threshold = *tmp;
+
+	dwc->is_utmi_l1_suspend = dev_read_bool(dev,
+				"snps,is-utmi-l1-suspend");
+	tmp = dev_read_u8_array_ptr(dev, "snps,hird-threshold", 1);
+	if (tmp)
+		hird_threshold = *tmp;
+
+	dwc->disable_scramble_quirk = dev_read_bool(dev,
+				"snps,disable_scramble_quirk");
+	dwc->u2exit_lfps_quirk = dev_read_bool(dev,
+				"snps,u2exit_lfps_quirk");
+	dwc->u2ss_inp3_quirk = dev_read_bool(dev,
+				"snps,u2ss_inp3_quirk");
+	dwc->req_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,req_p1p2p3_quirk");
+	dwc->del_p1p2p3_quirk = dev_read_bool(dev,
+				"snps,del_p1p2p3_quirk");
+	dwc->del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,del_phy_power_chg_quirk");
+	dwc->lfps_filter_quirk = dev_read_bool(dev,
+				"snps,lfps_filter_quirk");
+	dwc->rx_detect_poll_quirk = dev_read_bool(dev,
+				"snps,rx_detect_poll_quirk");
+	dwc->dis_u3_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u3_susphy_quirk");
+	dwc->dis_u2_susphy_quirk = dev_read_bool(dev,
+				"snps,dis_u2_susphy_quirk");
+	dwc->dis_del_phy_power_chg_quirk = dev_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
+	dwc->dis_tx_ipgap_linecheck_quirk = dev_read_bool(dev,
+				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->dis_enblslpm_quirk = dev_read_bool(dev,
+				"snps,dis_enblslpm_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = dev_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->tx_de_emphasis_quirk = dev_read_bool(dev,
+				"snps,tx_de_emphasis_quirk");
+	tmp = dev_read_u8_array_ptr(dev, "snps,tx_de_emphasis", 1);
+	if (tmp)
+		tx_de_emphasis = *tmp;
+
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dev_read_u32(dev, "snps,quirk-frame-length-adjustment", &dwc->fladj);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	dwc->incrx_mode = INCRX_BURST_MODE;
+	dwc->incrx_size = 0;
+	for (i = 0; i < 8; i++) {
+		if (dev_read_u32_index(dev, "snps,incr-burst-type-adjustment",
+				       i, &val))
+			break;
+
+		dwc->incrx_mode = INCRX_UNDEF_LENGTH_BURST_MODE;
+		dwc->incrx_size = max(dwc->incrx_size, val);
+	}
+}
+
+int dwc3_init(struct dwc3 *dwc)
+{
+	int ret;
+	u32 reg;
+
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
+
+	ret = dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto core_fail;
+	}
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto event_fail;
+	}
+
+	if (dwc->revision >= DWC3_REVISION_250A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (dwc->revision >= DWC3_REVISION_290A)
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
+	if (dwc->dr_mode == USB_DR_MODE_HOST ||
+	    dwc->dr_mode == USB_DR_MODE_OTG) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto mode_fail;
+
+	return 0;
+
+mode_fail:
+	dwc3_event_buffers_cleanup(dwc);
+
+event_fail:
+	dwc3_core_exit(dwc);
+
+core_fail:
+	dwc3_free_event_buffers(dwc);
+
+	return ret;
+}
+
+void dwc3_remove(struct dwc3 *dwc)
+{
+	dwc3_core_exit_mode(dwc);
+	dwc3_event_buffers_cleanup(dwc);
+	dwc3_free_event_buffers(dwc);
+	dwc3_core_stop(dwc);
+	dwc3_core_exit(dwc);
+	kfree(dwc->mem);
+}
+#endif
+
+/**
+ * dwc3_uboot_init - dwc3 core uboot initialization code
+ * @dwc3_dev: struct dwc3_device containing initialization data
+ *
+ * Entry point for dwc3 driver (equivalent to dwc3_probe in linux
+ * kernel driver). Pointer to dwc3_device should be passed containing
+ * base address and other initialization data. Returns '0' on success and
+ * a negative value on failure.
+ *
+ * Generally called from board_usb_init() implemented in board file.
+ */
+int dwc3_uboot_init(struct dwc3_device *dwc3_dev)
+{
+	struct dwc3		*dwc;
+	struct device		*dev = NULL;
+	u8			lpm_nyet_threshold;
+	u8			tx_de_emphasis;
+	u8			hird_threshold;
+
+	int			ret;
+
+	void			*mem;
+
+	mem = devm_kzalloc((struct udevice *)dev,
+			   sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem = mem;
+
+	dwc->regs = (void *)(uintptr_t)(dwc3_dev->base +
+					DWC3_GLOBALS_REGS_START);
+
+	/* default to highest possible threshold */
+	lpm_nyet_threshold = 0xff;
+
+	/* default to -3.5dB de-emphasis */
+	tx_de_emphasis = 1;
+
+	/*
+	 * default to assert utmi_sleep_n and use maximum allowed HIRD
+	 * threshold value of 0b1100
+	 */
+	hird_threshold = 12;
+
+	dwc->maximum_speed = dwc3_dev->maximum_speed;
+	dwc->has_lpm_erratum = dwc3_dev->has_lpm_erratum;
+	if (dwc3_dev->lpm_nyet_threshold)
+		lpm_nyet_threshold = dwc3_dev->lpm_nyet_threshold;
+	dwc->is_utmi_l1_suspend = dwc3_dev->is_utmi_l1_suspend;
+	if (dwc3_dev->hird_threshold)
+		hird_threshold = dwc3_dev->hird_threshold;
+
+	dwc->needs_fifo_resize = dwc3_dev->tx_fifo_resize;
+	dwc->dr_mode = dwc3_dev->dr_mode;
+
+	dwc->disable_scramble_quirk = dwc3_dev->disable_scramble_quirk;
+	dwc->u2exit_lfps_quirk = dwc3_dev->u2exit_lfps_quirk;
+	dwc->u2ss_inp3_quirk = dwc3_dev->u2ss_inp3_quirk;
+	dwc->req_p1p2p3_quirk = dwc3_dev->req_p1p2p3_quirk;
+	dwc->del_p1p2p3_quirk = dwc3_dev->del_p1p2p3_quirk;
+	dwc->del_phy_power_chg_quirk = dwc3_dev->del_phy_power_chg_quirk;
+	dwc->lfps_filter_quirk = dwc3_dev->lfps_filter_quirk;
+	dwc->rx_detect_poll_quirk = dwc3_dev->rx_detect_poll_quirk;
+	dwc->dis_u3_susphy_quirk = dwc3_dev->dis_u3_susphy_quirk;
+	dwc->dis_u2_susphy_quirk = dwc3_dev->dis_u2_susphy_quirk;
+	dwc->dis_del_phy_power_chg_quirk = dwc3_dev->dis_del_phy_power_chg_quirk;
+	dwc->dis_tx_ipgap_linecheck_quirk = dwc3_dev->dis_tx_ipgap_linecheck_quirk;
+	dwc->dis_enblslpm_quirk = dwc3_dev->dis_enblslpm_quirk;
+	dwc->dis_u2_freeclk_exists_quirk = dwc3_dev->dis_u2_freeclk_exists_quirk;
+
+	dwc->tx_de_emphasis_quirk = dwc3_dev->tx_de_emphasis_quirk;
+	if (dwc3_dev->tx_de_emphasis)
+		tx_de_emphasis = dwc3_dev->tx_de_emphasis;
+
+	/* default to superspeed if no maximum_speed passed */
+	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
+	dwc->tx_de_emphasis = tx_de_emphasis;
+
+	dwc->hird_threshold = hird_threshold
+		| (dwc->is_utmi_l1_suspend << 4);
+
+	dwc->hsphy_mode = dwc3_dev->hsphy_mode;
+
+	dwc->index = dwc3_dev->index;
+
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
+	if (ret) {
+		dev_err(dwc->dev, "failed to allocate event buffers\n");
+		return -ENOMEM;
+	}
+
+	if (!IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+		dwc->dr_mode = USB_DR_MODE_HOST;
+	else if (!IS_ENABLED(CONFIG_USB_HOST))
+		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
+
+	ret = dwc3_core_init(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to initialize core\n");
+		goto err0;
+	}
+
+	ret = dwc3_event_buffers_setup(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to setup event buffers\n");
+		goto err1;
+	}
+
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
+		goto err2;
+
+	list_add_tail(&dwc->list, &dwc3_list);
+
+	return 0;
+
+err2:
+	dwc3_event_buffers_cleanup(dwc);
+
+err1:
+	dwc3_core_exit(dwc);
+
+err0:
+	dwc3_free_event_buffers(dwc);
+
+	return ret;
+}
+
+/**
+ * dwc3_uboot_exit - dwc3 core uboot cleanup code
+ * @index: index of this controller
+ *
+ * Performs cleanup of memory allocated in dwc3_uboot_init and other misc
+ * cleanups (equivalent to dwc3_remove in linux). index of _this_ controller
+ * should be passed and should match with the index passed in
+ * dwc3_device during init.
+ *
+ * Generally called from board file.
+ */
+void dwc3_uboot_exit(int index)
+{
+	struct dwc3 *dwc;
+
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->index != index)
+			continue;
+
+		dwc3_core_exit_mode(dwc);
+		dwc3_event_buffers_cleanup(dwc);
+		dwc3_free_event_buffers(dwc);
+		dwc3_core_exit(dwc);
+		list_del(&dwc->list);
+		kfree(dwc->mem);
+		break;
+	}
+}
+
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+__weak int dwc3_uboot_interrupt_status(struct udevice *dev)
+{
+	return 1;
+}
+
+/**
+ * dm_usb_gadget_handle_interrupts - handle dwc3 core interrupt
+ * @dev: device of this controller
+ *
+ * Invokes dwc3 gadget interrupts.
+ *
+ * Generally called from board file.
+ */
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	struct dwc3 *dwc = NULL;
+
+	if (!dwc3_uboot_interrupt_status(dev))
+		return 0;
+
+	list_for_each_entry(dwc, &dwc3_list, list) {
+		if (dwc->dev != dev)
+			continue;
+
+		dwc3_gadget_uboot_handle_interrupt(dwc);
+		break;
+	}
+
+	return 0;
+}
+#endif
+
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 036a1440c8e8..4c4d7bae2e5f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -418,6 +418,7 @@
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
 #define DWC3_GUCTL_REFCLKPER_SEL		22
+#define DWC3_GUCTL_HSTINAUTORETRY		BIT(14)
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
@@ -1232,6 +1233,8 @@ struct dwc3 {
 	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
+	u8			incrx_mode;
+	u32			incrx_size;
 	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
@@ -1313,6 +1316,8 @@ struct dwc3 {
 
 	u8			num_eps;
 
+	void			*mem;
+
 	struct dwc3_hwparams	hwparams;
 	struct debugfs_regset32	*regset;
 
@@ -1398,6 +1403,9 @@ struct dwc3 {
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
 	u32			wakeup_pending_funcs;
+
+	int			index;
+	struct list_head	list;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1564,6 +1572,9 @@ struct dwc3_gadget_ep_cmd_params {
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
+void dwc3_of_parse(struct dwc3 *dwc);
+int dwc3_init(struct dwc3 *dwc);
+void dwc3_remove(struct dwc3 *dwc);
 
 #define DWC3_IP_IS(_ip)							\
 	(dwc->ip == _ip##_IP)
-- 
2.53.0

