Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051D606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W/84w4F6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cKN6zYcE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8B876089D;
	Thu, 22 Oct 2026 07:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7GTYh35Fwau; Thu, 22 Oct 2026 07:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 879116088D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652954;
	b=jn641HdiqFGEh/6o9/uYUhmNboG8HGQok896W9Lg1Ym8AcH5pUr7yOwudJUvepd42dNn
	 wbvRVwIcDctAAnxE3Rl8ufP89ZG5Xcg0ZZc++Os9GtK8PZAmWK6xaOo2YajbQBikajwin
	 Gqz5fau67gIy3hDxIpiIrqr80bq05lg0b6n8Y4FR+Mxwh5cODqr411j/Dti/4H65Put0O
	 RaSpRn2xFfcAaJaa+jVW3JUqa20XqtaNx7PoPJlHNqp5nm6CP6/LaCS92cIZAybG/fHhv
	 ba2d+iuehr+ol8iX4lB+0sMl+tCeBlcctFiGcT80VZgiCvhUYW9G6FlzijbqZmhqPxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AqTkv3uRV+3QvsMZKpTVAfNfh0zMeAe1qQMopSSGgTY=;
	b=ofdNSe91RTkFKQYzF3w0jSd1U+VGiDB+3p9S/2AzCa6NS/bz1ymQyEhOSKNQrzq3B39V
	 lUwcS1WCv8ABsINgrmFuhEfaQY4Dwcwd6kPzOMihxy6BVRtcmmgJLYdcHypUoRBKFosT9
	 qf6djN3YDAOtiPCIkQVl9YQZQug7MaYzhWzwdydMf5G6DpUe5sdzFalib6sn5FedOSjhu
	 Go8elEg6pmJl+kNu31pOyRnNymUAztSkhvxkFwbZ+ewKRdbioSo1elWQxaRHKopLENBYP
	 lo91OWF8XMrjsaEbldWNkD3UDXVYU0L5GboSdBQ95+IKZDA+Wo1GDj+vIHETqbLoQMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652954;
	bh=AqTkv3uRV+3QvsMZKpTVAfNfh0zMeAe1qQMopSSGgTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/84w4F6Cxm1J+c1JGy/dXb90cG7LrcfmD2wXGmFBHtFdowlELKKPHJmlxeCSbfhW
	 L48ll149ib2gIkxMBR5DoFFHFMKdb44sckPQ0u7B+pDM30/LWRhOgWYFwWIkUcGWuD
	 sYf/k9XIHYNbTGO40lUsK04d4jokXYfzZMrIyMa9pBXs8j2oy5BiUzOXSvpmKzv+AA
	 ueat7pTuOkomKYp0HT/DRigOIg/UhbRpOQKic0gS+cwscRNsB1Ssv4eHL5uBIY/aaL
	 Is0d6TeLrNA5BiX2AgPhvJeG4ByKBI0ETPGzvg2ePU8W2tBQ3naSUIiD0ZQuLJ6sqp
	 Th4Xha/vkcLeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 879116088D;
	Thu, 22 Oct 2026 07:09:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 701811AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629E080C8E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I06JnBDgl8Nn for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BA8580C6A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652947;
 b=nGWCwPL8vG7wThRkiOnz/MnU268+P6ntxu2wNsaHg1Dcc/6iAvgeVVh/N8/UjTBg35bk
 B3XJz89yvKq3PwHKioxUaewtpey5S8BoirV/r0xfgCpemplqZJ0SgXESgnpXgqaazjZT2
 0NJGbVZ3TK4T6ieLMQy5izfXZ+MD83QAQUfTAqZASgI4Bkz4beGlr7up/DIY7fw1KEkQ0
 zTGVO2RvsyHaxqcb3031aiFKol+yY/15jwmOX8efFgC6lJWBbZx3xng4Bnim88nk4CCgP
 urWTo019rkQ2OxX0GFzGIkQ1DfbmX1bxtcb7CjNj/+YJAVB7QwVvQ6al8ZlYdkKO3JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=AqTkv3uRV+3QvsMZKpTVAfNfh0zMeAe1qQMopSSGgTY=;
 b=EpTxpRy/JtglkvjBHTTfuVZdYgPCP2n7sQwPs2WMT5tkbxb8U92fsV8Nh92WWfXw1wvU
 2idxZs4ohCFC8gVxn1qaAAIQN53ZELkrjWHb8pedBbZ9X7gZSHR2JmyqIXLfRQ5e6O7Yg
 /VsMBLxf+GPT4B4mj6G3/DJgnOmKI4onfw/QM4FA4ewbiwyoq4JQIEWsv4X0b/oUxm+aY
 puZCYB10VfkiBC9aUHjfOaUZS48Qnw4s/YDrTSwuDggFfr7n717xQ/vm9k7f4jpkkhbvV
 BgdsaRu6/fh4zClsLEgS4jlhMOefZKg8JkeSfpQdUZKdyIzHY5YmDqLLfWQp2uBhVbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cKN6zYcE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cKN6zYcE
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BA8580C6A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso913166f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652945; x=1793257745;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AqTkv3uRV+3QvsMZKpTVAfNfh0zMeAe1qQMopSSGgTY=;
 b=cKN6zYcEs1ln/o5VeIfuOIxDIATcwsAvlr2TnDxmEKh3UWiZgGiOoRAsy4nDOH1vGb
 UgY+vK9WIakkIyBdJrIU9tbdrG6C4zLqQSvwzpPUBdWJFp+2s77dIFW1woxpjJEVDnDp
 vadSziQj8qezXvESt+siqnI1GHNkwmsG9PkIw6sYDcC0+IiOJ/ovdDjNaKICDIc3l/Z0
 eAU0LnDebJOIVdwOtUHO3uV2AhXv4+iJ93aZhPPJ4UuZ9N8njQAKOIKNtJjuADy31rt7
 /Iz+HjyTAWBaltQCDO9ZvUsFOt8mO3IecAS3hfmkJ1STvnlF+v1/43e8HO0EivvkkxLP
 PFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652945; x=1793257745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AqTkv3uRV+3QvsMZKpTVAfNfh0zMeAe1qQMopSSGgTY=;
 b=SSUbBDj5GB/lnkV8QCYyiEZPbpVrkAn4XHJTfuu4Scq/iiH4LhqEIOgoSQKMiuq8cr
 YG/yB/ajcFx9+qiXDJumzGmpY1AMkA0NqKhoooFqDQhiSm6TU5Mdo7VoF7pSlTakH3LM
 9LJiOxwKiZxF2ZZu6F+TZyJ9ihurdUjeg3Dvyd8bNMWlGi9NgfA+avxIWc1zG61i/fOA
 zdGjDbwIvW6lwMFv+8zRDeVDY8YrPTOj0BQ517NJiDC8ffpOvri58eTFODEjFAEq3siV
 0mtge8oFlBcBacjS+kNu/CsRvtAL+jLf+Ae+fJyhZcocqTmPt8QMGnbDEHLYyGN5++c8
 QEjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzruqo6pLrFCjxck5/8YM/xJ+O+5n+mLYuUFzOXHstTLHgHsP6GSgG+1EkzRtEuB7RxfGm8p04=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJxCMNatJ92FkQP6AC9RIoLranrX2TbAjiyzCrNWEI26pwR/VN0
 BQk04XJ9yKfaFEp73XBv0+mXIHcZVpxu3r3a9gFBT3hpD8DrGaQfXkSqGdlW6UQI3Hg=
X-Gm-Gg: AYBFou1mIdqmFtRhJ36Qcqx+8/5BcAxdDekpeMva5cK+2tiZFYtYVJYsJ7OC4SfZrhS
 kuI0GKyTpr3yGp39vOvp2A183nJqvkNlfRgOQM07/5iTnJqnff6rRJJnFXHrj0LGwNdgkeouvIK
 DPUYjs5GjwQnkUt5nWIVuQdISeuiUyGIQZDpvzgmh81BnZaLkagD9nbEFJ2hWUtpp/HIRJqzmGy
 LC/kV93rW+vZBjNrhwdgYRJwAZl2LQIw/IiU4aGjDR/mFDH9XRnF4jzDfTaKGST4rXpWNQqHu14
 dVhSFSVOWGmjAyJkPNoHyfNj/lOQOnmegpnHlrAjOmLcbjQcEzYKzJma1SMtFT5e8NsYFoJuo2r
 ax8UDvPnNHDMigixn3UULv8DLodpN2eAnAIMYQb4X8auAhM4Z4t8nyf/UoMta/gugsO18iMrPmE
 T+EVrEeY2w38kxjAa4lgae8VfekedeAVBFhKpJqi80BxWsJ+0XP9A4o3Uhf9P904KHPGy0/7jFW
 gxwuqyWKc3VEiAUZI2tgAln5mb1vBd9MMV9cO1oxQP1ZHlqu5mkr3Yls7N6LQ==
X-Received: by 2002:a05:6000:24c8:b0:48a:fd58:a7dc with SMTP id
 ffacd0b85a97d-48e264c992bmr9219398f8f.12.1792652944997; 
 Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 03/10] usb: ehci-vf: remove the code path for a build
 without DM_USB
Date: Thu, 22 Oct 2026 09:08:53 +0200
Message-ID: <20261022070900.616265-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

USB_EHCI_HCD selects USB_HOST, and USB_HOST selects DM_USB, so the
!CONFIG_IS_ENABLED(DM_USB) branch of this driver can never be selected.
It also cannot compile: ehci_hcd_init() calls ehci_vf_common_init() with
one argument while the function takes two, so the branch has been dead
since the controller was added as a second parameter.

Remove it, together with the board_usb_phy_mode() hook that no board
implements and nothing else calls.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - Reviewed-by from Marek and Simon
    
    Changes in v6:
    - the commit message names USB_HOST as the option that selects DM_USB
    
    Changes in v5:
    - none
    
    Changes in v4:
    - none, rebased on next

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
2.55.0

