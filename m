Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E208CA6007
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A91F80DBC;
	Wed,  7 Oct 2026 16:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4diRw2ZkqnZz; Wed,  7 Oct 2026 16:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 85E5F80C46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389239;
	b=mf3FJ3Hz/5IHAwmZPXTgPeE6RnehIqHwCDYaGoimeUKsdgRVnVY+REVEIr5IOxtLFoTJ
	 EguANeFUUpg5IUL6zupPy4mv7MzstWJBFVvdaguWHivUsBEJ9OWyNlBLJUeAeOuU161df
	 7kwK6kqTRueAtcnt442KB9uTTb5mju7Hd/UomOZbLKb9SDSXZxCX7zvKv0QlQFdFoE2mg
	 FQeNQt2cVEZVG5XcsR6jNcwQumxdcIYj+OHHLKYJH6dY2GqlyRRy0snNUEG6wWaQAcGE/
	 SbPjWdHeDQ/UsYWN7vGsfQnA3QTPDkVycN73Xl7D/sIkdbTKXmuAQ7oMxfPAXBm3wMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XxOojrBKyFol/swZwQc+R3C5PI74yzLnxV/wtIhi6QE=;
	b=FMviQGUroeWGkPtaYZ/hoSnXZlR9H4Tt9aELr9uUIqVEDI/W+eBla2uyykUxrewpUK37
	 ieGht7Y90cJwLxrPzwtgO46+RwRozeY/5Z0WgZqwrf8O4KrdH/U2HuGrIQU97UoO7rYqu
	 axBA2PKfxHQi3RWBWW7kNhaRYZibYuaHYWM8LnPHQp4Ll4t77DyuV1Jdigei73KMqlxpe
	 OAmWDQLnZThvFRiyIgI87DfaWxspUwCTJRsHMgbqnZQ0ZF/hrM2uzJskiTregxBHHz6Zn
	 6xbYRzvb6wumKiqWednC0R80dTpQyzGOgdKhpJcFuSt2fgxO7ne5GBTRnyW2nkzARjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389239;
	bh=XxOojrBKyFol/swZwQc+R3C5PI74yzLnxV/wtIhi6QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFyQyBZ0EcO8+kKWJhCRUis/vq7o4wGwkYq7VyEEGL01sbC3sNQqNGgAx96INUTUq
	 zzL8+XrbvY5loCX94zkhg1tArgkLRbYJYfmmI5Fyrav3MO1/2gXZ/yOPvcYcgtP8lY
	 KTBpr3YMSbkNmL1cunsLSB6ULKM2j+aUDjOd78UYsgvJwzDNIiHXB/i881lvr3iMPl
	 1FQPeCBccWbhOtiY/GAwUdiE9xh1KgoBdHG4SZIuYiH/5HOp+nWt4/8NhX7D4xRBF/
	 CfgJQkdTZZulxPk03L0sA5KCnTZlYq2yWLxjjgpyO9pFX8yEWxpinE2l5H2XY56qth
	 B1FV4rkN3Umyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85E5F80C46;
	Wed,  7 Oct 2026 16:07:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6017932F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45395606A6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EO-qatKf--ZE for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3DF1E60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384353;
 b=C3EVRuY34PYkwouKacHTK4NbVTacJdFTai63wgeS+V1efVHuEVLTNq0N8fDwTdnmMqbk
 fo/plhjg6r0GABEeUNHamvfO2YBC6QhNYA+vEBsrQlry8GLSlQ0/A+83K6bm1Of5Cgvcb
 li9Wp43jjUBngnElBzTm0ji8yeXxh8UdFafqiv3KQNPZ9ui5CytoQuIB3JewkmVv0u1w2
 iRucesNpu/nxvgL++WhHAwURN+S37pvTGTJgzx5EfTksPKF97oAJ716xDLZ2/0sa7FLv/
 BYJUUscMhGevGu2mkHzro8l8OqD7drWMfrMaOXX4Zl/lhESZQwNNOmgD/JYoOL7Vq4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384353;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=XxOojrBKyFol/swZwQc+R3C5PI74yzLnxV/wtIhi6QE=;
 b=hwT7deMVuhz60PYtnoFovIGZ2n9Ov2EyPt56vULRBOcojoH5WBG5ZRVRH45rVd2XGSlX
 75Qr37cCiRYkqf+folyh8sAPxx1n9mOhl5wRqcguhLnKJMQc7ac1VPD5kVzDAmraTcQK2
 hwMHWhVvDYCsS8/MtKO4So/uBydRslwN/XmjIFOuoB5op3g7SdeQmt9XVvxiD7wqi0cK7
 0xIFebQBZ56B2lK70bTXoekleE3rC1vp7vk8aP69y01x4ehoVS0rVpJq9+OUGNS3aPWYZ
 3JaeoOEXzCpDgY5j+vQlKUgN7I/R/LQ1aFni8t0JhdP7EIBF3JqM1cAt3f7AWS9QNxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E9bImZDE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=E9bImZDE
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DF1E60670
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so17661015e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384350; x=1791989150;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XxOojrBKyFol/swZwQc+R3C5PI74yzLnxV/wtIhi6QE=;
 b=E9bImZDEgCokDF4Z/oLtUNpfJNjzREivsULTzn6h38o7tNq/QMo2kpVvrmRuBvW75g
 7NX/wRtcCNvLdxmi9E/X00jdrMQI0QNMEKUCJzqIrm0ypmi9dkSpwV3Yn7G2w6XJeOJU
 sOhZzxpsbivB7LAyqW23lwNn0OM6vyf+0UpZZyRaemTwWdDahP4xiiyVdGvrFcRyc1IN
 OMawi+PHXVJTX5ITZF1ekUCD+HYzK2rH8pDBbbF/lBqhbQfcEFDYDH66a+vpgHlNqVMP
 e0AVzvZKf9JoEnU50glGb7ttS8J12Ue4C+shODh7Lpq4gzOHWsNgpuX9epEKUC/72utE
 6FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384350; x=1791989150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XxOojrBKyFol/swZwQc+R3C5PI74yzLnxV/wtIhi6QE=;
 b=P1XMGF5d7KRm5wCgQmuUaE2wLR1Pe0JEWLBFXAB1YWk9LiT3Lob6MHW2up8vSARmmn
 ZF2Qzznt12YyQdes1mnzTc8Cs0SrliLcc65IxuvJEHD9jEu6boHuPZX+ZkuM6oNast9U
 IzmVmUtZdCrBp4akm0vRMrQ7vvRRtuyAzRCLWDioz2arUkYTucetawgcy3UZw3su1ZOy
 I08aAU4EvLsKlQa3IopizZxcfXrnwvdsOET2Ii1wxBAvLaOJmbanbhwLEc3Yd/Q9AHQ9
 5bdYoNFWPHEfkn0PIEFv/0HP9shiteMQOtx8QDRWnFgnxgGVHbz1CpKawbEW2gXOjG1t
 L3Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuIqKbq4pOkvciiDl8QsW47ThqMZ1yMPx7FC6sbGr6z+4v9Hq1i9cJVpc6IpAwzFVzb8ew5Ew=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXyXaEY0UFbXPaCAxrNW2jHy58drTiVANrJO4syQ+RA9Fib/Y7
 m2NjTBUfCugXPqMc0eHheWbfQf54aJn+pl2fa8aAqYCX9s1ZeQHB5DW5
X-Gm-Gg: AYBFou09dRnzV0USgPiJTHHDF+vaU87/S1yB1gPyjpK1xwbE+UQ4nOj+6CK80/t9F+l
 SP34Abhf6i93h8Zfu/Bcks4L2nk74Zi8jchGQ9sU4Kb0NzMUz7o+KhcN2tg2PbwAJ+HSu1g5qme
 4syl/qIRNlV33UpbdxjVQVAizaBFhaYW6AWiTgmvRAJUvOeVlfJn4orjEA57+rb5qpoq9aC+C06
 k8pAt8csCuHRNF2r8fALnIzoTpCiWHOaLTf5BcAwl+fudbWSOrgUebFA+enz65uoHoKlS1ErvKS
 YTbAfcAGp+1CXn6GSvHqlCedi3/y7Ub6l6768r4XwMDR1q4/kqf9JkqI43psyhI1PMqW4r/YOtJ
 CS4xVuHpuBZmV/5k8pbb7NaBjye1BJw4isMBURExh7t955GC0vsb5Q+U+3jQ0UUhpD/EqsnYsJx
 H2BacOa8bN4ln/oZErkm4uJdCMoWN0r+uiq0UrVT7OKtkG90b1e3uC3d8SB1z24EGeYdjHI/qBi
 Xcu
X-Received: by 2002:a05:600c:8b51:b0:4a1:7690:d878 with SMTP id
 5b1f17b1804b1-4a18041ee5bmr39372855e9.17.1791384350111; 
 Wed, 07 Oct 2026 07:45:50 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:49 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 2/6] usb: ehci-vf: remove the code path for a build without
 DM_USB
Date: Wed,  7 Oct 2026 16:45:40 +0200
Message-ID: <680b1cda98a5663582a176972d135c8a2885acb7.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
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

