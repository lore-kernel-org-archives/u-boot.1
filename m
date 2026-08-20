Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1CAC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4CB940483;
	Thu, 20 Aug 2026 07:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJ3PhEekstR1; Thu, 20 Aug 2026 07:15:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210120;
	bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyDJmFM+cnpDxCzTpf725wtX28ca12t/r3HyClNQF8HR6MjQld3tjBNKjwBA40hUS
	 g6EW9ps4v8KuJZ0aINKuMnEfd69CL89ap9mFHakap0DCwzqiEB1Af7W3IFn1KFWSjy
	 SYxRjbgsmq+IzqLrb7I9FgLN5B4euoP3P5HrFIuA0osM71HbO9yYA1l6F3SwlHe9eO
	 oFskAjpEPZpF8AmBRLgfUF2pbOTPXqea1M/JTbbA6rZ1U4/P1x99fDTS44fFiaLEET
	 7h2BO3x0puzOBmfaLZTuz6T/vflQ1UBu9fVIQhdf9CPGwDNen+m7+K6DK92oBYBYhG
	 dwbyQTvy+Eqcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F33404C9;
	Thu, 20 Aug 2026 07:15:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AD762FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2121D80C10
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWTvl-ne598s for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pxNFpBi2
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D68A80BD4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:15 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so17025895e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210114; x=1787814914;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
 b=pxNFpBi2OZUsqCI9b6yJJwlrL91vuptf0/yZQlPkD0g0BLns0GoUgf+AKi/NQTJKTB
 Rhkz1XK2Ozr3SHfRYMcqzrAVF2e403dd2/MdYEGCEQ0tx9Oi0NwljsN6+0Y7iQV9vEac
 UuCf317Yss+lsCLdSE7IP2IsNJ6wncjvMfEdXOdvX/5vpuSPP8gjI04aKlYe3vrrWrSX
 X73tRxS89NQs075H//sYxrYFL1PrYy5AIyU5TxjwKDBWw4qIzg/JxiQ2JqvOyIqsUYbG
 o15u0qghATLW52V841DXRtiXTX7Tdw1juz/VctsjmOZ6mGG6E0kvHOnnVCHfblUoYDhN
 /nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210114; x=1787814914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OPvMZAkACVgS7/iPHWInokFAQI4ZjmofjDKUa5S/b/0=;
 b=sjCZQ72P+HA0CeG17wqopSX0jBErDuF8HUCupnYvjf8Dasn7OCCWQLLRGyGN1QWItJ
 /bMZKLbhARn5+pvteF3GG0J6nmBchsHfH5ecT+QdwLtqGo8fmkp7V98HAVlZNbbHtNcg
 4u3ruG4oDo2L7VSZvcSpYsDuf4HzZ8MY7Jqk61lG7b5kT2s3qBwbPvCG9Y9kKjgq6Ptm
 nL+gxBaJzD+/6xiswLuj9W+YeT5hsTtb03z/w/jJG5HL6UL0is+0ijsr64+vA/OAXRCv
 XYQs3DJkvdU+2xvyVEDzjW3KBjY8cjmzu6iD+/079APDg02gMf7n+i16aJIgeBquGA67
 BW0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqGfpJpvCh3b/9pqt/IYhLgQIPP8Ep4CCWse1WPhTQx74EG5T4lZU6ZqiDBX1BngQd/2MNz8g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwVsHR8qOn4iGeZo0eF+dRaG5FIkCq2b+zP3cA/a7k5Bb/fpbjB
 F3X0EJ65m2Ie1TjhNbBDTy211aqHk52LYxwn0hRavZMG1Sg66zM5zFbq
X-Gm-Gg: AR+sD11/91fml9kHvvsXoABzbfteBohZbKjQbEN5sSmw2D0LAYWVRHna3kog3ROKaTB
 524Ay06ndIBQ+extW6ytr+/nPYjXf/af7c3wscA23KEXqNMLn7hiB0M95uj9kx0ce8U21QAM8TO
 98Pyxvu1ElSOknFVqQOjbWCij1IF13U4qlKPvZxOL63TArVONS4cVEIMO6NfmF7MZ9KOc7w0Zxc
 wSgrqlB9iEhv1E2WQg3UCcM5huNT7/pBrteiGJ8L4gg5i0pGY4pBYt6vjhFXpSzw7uYpvFvaiJk
 OkvI8v5hHL3M9e+uhGjxCsmdPGs3fv9Ik33y/mT0e7y2NzekA9Eudvjcdrz9R40aykVXfwSBTMv
 jzWmZ0pJKoVb24BEgRYtY813t6h1i+B67bXXDkDUXShqdQlu+tKW+mn8nMS5CH6pAi/aFMIpAHX
 d5yl4eX/ImmWxXEazGSICfg4XYxa37+6QxtcI9VF1qlIDhDD5vgqQ6TAUIywBtun4baw31zp4hZ
 H+nbA==
X-Received: by 2002:a05:600c:468d:b0:499:4892:d022 with SMTP id
 5b1f17b1804b1-499aa17d5a2mr170231205e9.8.1787210113667; 
 Thu, 20 Aug 2026 00:15:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm158151475e9.11.2026.08.20.00.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:13 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 1/4] usb: ehci-vf: remove the code path for a build without
 DM_USB
Date: Thu, 20 Aug 2026 09:15:08 +0200
Message-ID: <20260820071511.1036506-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071511.1036506-1-mehmet.fide@gmail.com>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
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

