Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EFC5DF8A
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 09:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F00280D0F;
	Wed, 19 Aug 2026 09:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYTO57PBtFff; Wed, 19 Aug 2026 09:37:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787132234;
	bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3q+08lLMnIZTUU/DXYYEe8F1yd8X4aFamo9HwVVm1MMhI2A98p1ICMLGkSrK4Tn1
	 gJBigybZI5L7zCxNcuIinK2bXoLQ7XednV5CyshMIjS45aZffkkw06KXkvByeW/UWK
	 xIrdHYkagIN/8bi670z+Wc1aNekxJdowWgfsxncVD4WKiGA1Nf2MvM0F0h/5es2VgG
	 G+L6Hl9yqooVsxq33TmzRQKtbZ5X5qgXL+XYIV6btA8fyXhw+oJJ57b55I716G80KJ
	 lLpZlPH8p0Awk4EXwh0Jd+NrLxS+4N5ioQ+BSsvE9nylwaAKBSu6A6j0Jsm6wdgH85
	 ve+DGalA/ndpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDE0C80C86;
	Wed, 19 Aug 2026 09:37:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 332CD3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24AA440582
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yIEAIvf_T26 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 09:37:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=a6XOsZJT
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 152C34056C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:37:09 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso8058135e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787132228; x=1787737028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
 b=a6XOsZJT6rGp9eH06+LysYFMWra/sm94yxLO/ZRa0rY9iqsR3nVTvM8TjYC+uIb3Xf
 Ajf9Qg//ZGnNQKhPAYmEEy/eWJtzemIaBQ8b3cM9waVxCPhe8m9gIjCRE9l1ufbdw97c
 y98eWhRFsjVBeKN2fhoVjeDcEEy26zzlElYTObJg6Xz9q1QGZQ1QY+OXyOOgXxYN9XsL
 l+xr+FFJlnqOCzb0VQTfzivsE/dLFVMs7VzYQi7yNoaGj8yezN1QmBPjurO8LqfwaMM/
 iC7uHQQzys4iXuTpN95RtjY0TzpMWeXqqPK9Fy4xdUk94ZffaeXlb0+SY0DvHQVO6Ku1
 UPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132228; x=1787737028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
 b=Bv2acdNhQ5WPHtJZxfhiNNB/QFwg7cf4GKOX8jxucwv3WTSXNXNeQzqSRZCXUNrD/A
 kkfYkJhsKwfCLXe01uygBK1iIMTjRlmIrCClBEkADd89t+AYXW/2OzcXSJ+2RzC19vSx
 bNTVoD3WEQY2fIWu3zR9dudjwhAaQBIeaQFuiiiclk5k7ZhamuJ9IBKtzfjrlcZH5D6F
 I/m1m9WFM2/ydzV3ko5Qj+/f6N+g0WnSg3QVk1Wf1bjjYAEFw7JkG5RAAILyNRQTK54z
 goW/9pju1NjZRj0Hy0J8iiDqGoWjIEk0keqrFZ7Buzp3r+h2mSRULZNWsQJ4nhenEHb/
 CUPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSTCHlsX5P3qHZuuVAwJUZSENoI6JTRUJeJxH8xzi3pFlqmbQiYhDOXxBntSwiRnd86SVTBTU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwFQGOH2vTSjNq22zS1QjzmTQiMIc/hv2rVaDqE2gC2kcSiWa8k
 ur9HPkiRbGPYHgavOoBNfoQ1KFqPxzUyMrEKJLEV9VR0m9tRFYki7HrQ
X-Gm-Gg: AR+sD129S3gMsYX4x06qphqa1CR4QBq28jCZ7aYg+WzXPyUtdhLyw1vr0K0+LVP3ds4
 9SjW8COP0qT0CRkOOD2qkEO+Aby1j1aG2KT2Dr5vUB+O++e9LmONn9SunFG/XDxja8xu2E74dSz
 FPYbEwVA+BohzD218GNLkqLTc9ybwMOhRRXUtPEQnFzoC+3aCcIFLX+BDP/lhsQEInQFvwdgnqC
 Dw9DIEuJ1sIAsNvvCxMhajnc7JQ+y0c2ooIlxXQ1LTVLAj4fjwAxFhemKYpYYS7Jarblqzha84i
 eUfLqPersZ6WDfD4qzLOR+i4M8qw7rMs+ZQ3bvZF5ExOooK28F1dMNS3iebjdr7SVubNlOh8vqt
 jSEreDgNzCKA3g7Vi2badpxcxurr4/2J5NFkfOk/zyZZUiePzGi16YCpmYLd89NyXsnBvaL8jWA
 h2HEUSwBhooBNKgBHtXAB7/V/kRymo/ZIX20XsP0pB23vpebKNq7TZoTM1y8/+Nps90jU=
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-499aa1c7bafmr60032415e9.15.1787132227463; 
 Wed, 19 Aug 2026 02:37:07 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aca21c63sm37939945e9.0.2026.08.19.02.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:37:06 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/3] usb: ehci-vf: remove the code path for a build without
 DM_USB
Date: Wed, 19 Aug 2026 11:37:03 +0200
Message-ID: <20260819093705.4143509-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819093705.4143509-1-mehmet.fide@gmail.com>
References: <20260819093705.4143509-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

USB_EHCI_HCD selects DM_USB, so the !CONFIG_IS_ENABLED(DM_USB) branch of
this driver can never be selected. It also cannot compile: ehci_hcd_init()
calls ehci_vf_common_init() with one argument while the function takes
two, so the branch has been dead since the controller was added as a
second parameter.

Remove it, together with the board_usb_phy_mode() hook that no board
implements and nothing else calls.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 49 --------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 32fe05920d0..5d27318de62 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -128,11 +128,6 @@ static void usb_oc_config(int index)
 	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
 }
 
-int __weak board_usb_phy_mode(int port)
-{
-	return 0;
-}
-
 int __weak board_ehci_hcd_init(int port)
 {
 	return 0;
@@ -155,49 +150,6 @@ int ehci_vf_common_init(struct usb_ehci *ehci, int index)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB)
-int ehci_hcd_init(int index, enum usb_init_type init,
-		struct ehci_hccr **hccr, struct ehci_hcor **hcor)
-{
-	struct usb_ehci *ehci;
-	enum usb_init_type type;
-	int ret;
-
-	if (index >= ARRAY_SIZE(nc_reg_bases))
-		return -EINVAL;
-
-	ehci = (struct usb_ehci *)nc_reg_bases[index];
-
-	ret = ehci_vf_common_init(index);
-	if (ret)
-		return ret;
-
-	*hccr = (struct ehci_hccr *)((uint32_t)&ehci->caplength);
-	*hcor = (struct ehci_hcor *)((uint32_t)*hccr +
-			HC_LENGTH(ehci_readl(&(*hccr)->cr_capbase)));
-
-	type = board_usb_phy_mode(index);
-	if (type != init)
-		return -ENODEV;
-
-	if (init == USB_INIT_DEVICE) {
-		setbits_le32(&ehci->usbmode, CM_DEVICE);
-		writel((PORT_PTS_UTMI | PORT_PTS_PTW), &ehci->portsc);
-		setbits_le32(&ehci->portsc, USB_EN);
-	} else if (init == USB_INIT_HOST) {
-		setbits_le32(&ehci->usbmode, CM_HOST);
-		writel((PORT_PTS_UTMI | PORT_PTS_PTW), &ehci->portsc);
-		setbits_le32(&ehci->portsc, USB_EN);
-	}
-
-	return 0;
-}
-
-int ehci_hcd_stop(int index)
-{
-	return 0;
-}
-#else
 /* Possible port types (dual role mode) */
 enum dr_mode {
 	DR_MODE_NONE = 0,
@@ -372,4 +324,3 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.priv_auto	= sizeof(struct ehci_vf_priv_data),
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
-#endif
-- 
2.54.0

