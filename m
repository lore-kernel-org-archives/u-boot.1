Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB28606A320
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vFAI93ZV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FkR4MDRY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89A5B81155;
	Tue, 20 Oct 2026 10:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4b1DswV6nFY4; Tue, 20 Oct 2026 10:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52FEE81090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491388;
	b=MkZWAtX+PDGc2BT0LarxC23jK7NVsGOX44WjuVEOJev1AuJorwZP7/axGIScAYTtbDON
	 hruOYc99ahAw1sFdS68wG+vmVPF3dS6EOp8N3RgQn8cy8uZECIjTWVS9oG1wa1u6o1NfG
	 1Sc8hzZkPJHgF/+vSX1GgRuZEqnVM090013eNT9HmPZpxsnCDOYpR24xxU5Mm9NwMN3Tv
	 npqml2SdxYyp/ad5tW9xOauq6LavLtULNvVE+qOjLvWB2Ff5Az2XUOw7X48lJVPiIeBsp
	 iF8DnBY/tloU7cSgm68thAcFLjyAn79S89TD8cMNn5J1XMH4ZPF+nF2knYHPldAPMcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lA4y2K8QsP7dF2BCMgHCCbrqSsLvqsZhJf3Ct481FIM=;
	b=dUl8dlmFw31twNBivVKWoqnX9wHPD6O50DBsYWzKalhpukAb/VquoX8D3yGLpur5brca
	 gL1c23/QWxdBywEJkutURWVk7wfQn+GVzRseByd+pv+jcO4Aj0uSrjdUiyimBlA27OX2y
	 KH1zRGQXE1sX6hs5v9idoyg0C0V573osrJI3af9wU9b0xqPp0VsIg3rr4kDT5g4tKCupl
	 vt8LuXKGkb4GTYHb+t450lFNI6Jqa3adjlm854iw8qcRL6iSIX2N36bUAq9QNBMMjzOCi
	 EDAiW7tSR20wTmyJiE5S2LlDBR/z0IukGiVfCoqqUJJL603rYINTHvzqItE8n99AvCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491388;
	bh=lA4y2K8QsP7dF2BCMgHCCbrqSsLvqsZhJf3Ct481FIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFAI93ZVzxZjZcNiVuzWYOMxP9S85Y8N1IzuCxuG4zgjduLQYDzS+pQW2EhH3Xbs0
	 BOeYGTQrEyT7TIZR/bkJzz1KtAqxP+25DGl6zk6dLGnoeUUrsRwPdZtBsPq7+daO5P
	 /+S1OA4PVe3xW9x1kDFRzR57zNDR+AJsI/hOvbFB99fB8KqS8K5XPnEBsoZL2tWNQV
	 ax963+LHOUsxzSFNziEJQIhnWOOklF2LZpM72oQQLvsroII38SNvLzAJGAULxbzibm
	 2BsOJPEf06AUux5+uqOIizUBGOJ64Ez4Ccpbw4+5ESn9ovM4QOyUGbsD+Fjpwnr5eq
	 szYEGNrLSLVuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52FEE81090;
	Tue, 20 Oct 2026 10:16:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F7AE1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D2C34016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rA5LHZZKT_cF for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 629B1400FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491376;
 b=bIsH1pU78iZS1bNJSRw2oUp2J8knQOSyJ/F4xclwOlwzwhYWx+wmfvXZZSOYVMusWRAH
 p2PeJbANxiQSzgd+xdK6eKtGCwUY1bebv9TAaVkHb8X54jrotaKdFoQs8XKp9StgmfH+B
 r+gQm3y34tcMViYbguu0KkY79Zhyz//Uq/NGkviMhBvICzJ9q8QlHGJbeNNFOEWNgpnkL
 8+l5UReNdQxABOOvTOMO8TV0vFkei3E9PVhN0StGvQEDucuOg0zlpYjc3Ayk2hYtXbicq
 mrjIzfv2fqAg17fHLIs1NJaFfo42FeomcqalPOezB7YdjivxalVpjvkQ4bExfTzFE6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lA4y2K8QsP7dF2BCMgHCCbrqSsLvqsZhJf3Ct481FIM=;
 b=WszvxIaAdFP7xdnOL0DwVh6FVjVe1PJQ/1vo7HMNsYWjKy1lWiKQurrUUKsSuaopnTNa
 10zG63sAWeTrR16+/P31zEaYBuqgA+pmBLddE7M4GUIWILJ+03uHNB5i3VczTxhopYTq3
 ggGaB6jGu6ApiH5BWE4MbaYHGt+uSWFdctEpW0VoFz8w1aJw61bS66/T1ECgic8GvnRaB
 2aX31knaScAJnap5JTUmS9S11O86XsASZdD35zOYPjiilnDJcSWzIT/GpR+UPqvZarh8s
 fzQmHG6WDI70gHz3xNCdaE6vulx5TlT9zgj+2L5q0tVe7wAOy837GTP3jfkik3ohA8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FkR4MDRY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FkR4MDRY
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 629B1400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so22913765e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491373; x=1793096173;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lA4y2K8QsP7dF2BCMgHCCbrqSsLvqsZhJf3Ct481FIM=;
 b=FkR4MDRYuhMZof7OhVli5ZLozOEwdszFXfuZ1Wbk2SNAdFzrMY6iQ8LG2zaoGdpgkv
 otecG6eqvWzzExA7LnEiJiy8qXFFPmSg1oEnOYwLq3N6pBvN4VGIdXwjOHAsE9e0XmQL
 ABGzv7oJSprOqf4/SixELcw1WgsNTeKAvrzWaxWph+IcI7IlGYJoGDZ548UKEuRSwXK6
 CBj/pfAL66N03Jnkgjr5zh/BdeAEMlZUeYOKet+XWnBJWgOCNJfUe27FU5xT5TDgmpak
 uQEh7LoFgUpci1mNZHRfTSx6Y7vMq5MgNUlHqKLKFz6QyOB3aVUBrbjXjmIssatk/Aw0
 M7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491373; x=1793096173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lA4y2K8QsP7dF2BCMgHCCbrqSsLvqsZhJf3Ct481FIM=;
 b=nTf77yRThcxeAeRbOl/YTdB8oIFfA60WbKe4tF+ZNcXu5uYaqgPxsn6JFO3tciqhlr
 C5D9B/YKZkgKCOZEkqz+ISOMSeiHVXKxSzxOQuanPO5a//QQglQ0byc0PP2NYqpYvcgX
 IeVXZKqdYIGHYcMISefV/brUoc2qVLeGq+RX6a08oVAECM6hoUsNakrcbPV6Y5DW2GJz
 gyFznPzFj/QM79abkDChb9Nv7K5kkdoBZRy5OosuHWlzaCxmfP5v1oKvPMqbbm5N/Qad
 20hZA815S5SGvfk7GQ1R4gLqRQ6qxWeH5wa7aydFMKwtpwvbMIgnbibNkkuR9wSOBQeu
 ebMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUK8ROKdYgB2RvdlLAK1wbugSWS9oDB6QmgG4EUVJA9oCdXNhtEsIA1fiMwQyOJYYc93WDZCk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIBsaNlrk/3Sc7hLwBlf28A/EZboZwB6NBue90iTac7Z87jSlDe
 71KbJtbL0xCKJVredzqrw+HFpm5QM7bbcSG+8L2fdfjZK2QlPyZZE2Fc
X-Gm-Gg: AYBFou3wRSB6m7VkNcLRQYiAQGTfiU7NyQ7PJTyPBRL7zehmuL3/EkGML9Ltp5DjggM
 YV495LcHMEZ0pXoGR/nvH2P+aSHEsxVErE2K7uuzMJUa7gIFvIzyu4414XiN7fn7HiGJKxz5MkH
 vavOJk6kiDn4fotC0QvmcL7Z4z/Fvn6sIiDGbccml9OmO230zCpqkH81z5oxm2DTe6hcuW+rtJw
 F0NJH8Ji5bd3b3Jf1tDCDrT17gCD546XZ1t6uOaRDRsV5XHf6htRvtRjJmp60VBIdB49Ye3wLo0
 /8LYTxC3wkWLXVBXx3HLSENcagjcCXVSNPKlHp0kAWoNu8JXq4GfcNbJ2mMGYw4Dpu0fjZ0ny0f
 i/Sf8xjoV2ovpH/ctiDg419LZrNnVXtgW6RNJIztumNFWNRqcZiJNgKa1b0h8nzF0WTVhrSc7Ex
 Hc3AtS0xMTQ1u9U+J9p/KRxRPeTAp9haYHHuoqOF7nYDi0AXp1Iyoo8ppZyeVsCYACNkbmXfRlL
 123
X-Received: by 2002:a05:600c:4e11:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a1d75f252fmr207822665e9.10.1792491372861; 
 Tue, 20 Oct 2026 03:16:12 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:12 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 3/9] usb: ehci-vf: remove the code path for a build without
 DM_USB
Date: Tue, 20 Oct 2026 12:16:02 +0200
Message-ID: <20261020101608.2818265-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

