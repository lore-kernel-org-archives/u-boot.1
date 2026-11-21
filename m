Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A574606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t4AmkHS9;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C/YwBTbf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 729B36074A;
	Sat, 21 Nov 2026 13:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEGkrKkJ3SaZ; Sat, 21 Nov 2026 13:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1FD360668
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266867;
	b=IixeWHQzMuc8bY1nT24U3jI4iJl2clj+jbhOv90VYr7SlxTqFOxBv+Fjg+XBk8mmB6Ke
	 pnIvFQ7AUbrVkIXRnm1BBUSbreEg5GU2O24TOctnDtxpQ+g5ixwffrTjWQ77w2lkainSz
	 SzdPcVQdQEFkwpbm/4oDqx1FcURitqn6y8XgGiCTSdj2mdoXbtWNo+wJEzjoMGOUqOpAI
	 vM5xtBE/vmugE1Zq2abBOBxEaskNlGzxp4bF5+uRrfMSAGPWPv7/ZjmjFvYaQXynNWooZ
	 JKcH4dX8gxCKztQZtmevxykuGk1LPZnzMGvv4Hb2liyJuEiQvDn7ulcGb7UaFy3iY1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
	b=AgdPcF/oghDQzloMi6Gq1rYcsIQlkDDF1iGcyxlZGywijSB/IR4XT0duL6Drnj/V9iaM
	 XiDsOJwAokOwadsq2+HvqPhOKFMIFFfllsJRcBLjHqI0comYoAQOunRRyd9eP25sBEGyw
	 tFxIzQWoc2gTU76kZGhWbFpB+Q+4Zlhhgl04uQg0BhHKp9QzMaarsqP/pAvrf7rCh7eZ8
	 aRFtuxhJ0NQmpo3aw+ohoVmVbZOH/m6uzK+fZJhacljie2gpz4Z6SZ8qpjsQanx0pE76q
	 LQbmyNjgpyUwZoc8loPIXBkafHFaIiL+TAJ5oyDZX5dHlSILOA1SGUs756OypaZPpxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="C/YwBTbf";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266867;
	bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4AmkHS9iUezLU3lTz3Q0Zqg/H3MA4LWVs6qA+ZjgX8h0wtJZcJ8VWqN7NaaNGBPz
	 gfjKMOltVqNdWsCeONVcmbRCBCKx2nxgX42yK1BxAwwfu+K192/u3cfMM29ex3D3KV
	 QEjeF/n/0UZPKLzp7eqm3zMI+1t0thgtaX3GexDghWYHWKEGsNYqKKH2wolzHlHJyF
	 QdXOH73IZEW2pAMO1TWKa27cVBqIq4HpSk7U/rTICS0QyAqvec8zSwS4BlqMrZ8bOs
	 PHxu5YQvgxRxf+/+QmD7l97kw8eyLoMVJqHSXRfb+H//T+H2ziUfjZdIvJh52vTVK3
	 lQpaVd3CVWdeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1FD360668;
	Sat, 21 Nov 2026 13:14:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9462260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E72F26061D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMdMw4l-8CvO for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F85060623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=C/YwBTbf
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F85060623
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:59 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c50686daf9cso43125666b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262038; x=1795866838;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
 b=C/YwBTbfsCo+URkdT5lzaG1tDzDwSDKZKqg1nFJ/GFAECunfQv9XmEcrfRTYYhuq14
 S8UzVX/REQJwE5NhcxbmjTIC3FnC1ai/md0kPetsChncnaXlD9oaG2TqXvYp5yPHll9q
 Pjon+pcqXc7kI6idFmobUp1ULxGrB1ytWTRemO7cmIa1Q6+UPsHbEy2+ywP2daZh26bb
 9z6lKCyTlOSXSTqshAicncmh0O5nlPh0zIeP5lVU5eN02GNT6h1NGREC1GlNydjNe2j6
 3B38UeR/a/cZhpinVC15ZwMRQW9nObKjIaMSp7HFUju9cQNbRTRyn/HmT1fJpjB+Nsu8
 QeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262038; x=1795866838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aaB9azxIljSGsyXBTTiFCJvVcq6IUfI8nTSqcEqFs6k=;
 b=OgNQ2lctXnnkHxaag9lnO2bXh0xAN9aQZMvtom0Lkj3yY0fMaHer12I8zCX8fzgwe/
 hPlnmb8E3sD1tbcezxUJdHNbzwnvdfiYhCUzGE789Ag//t6z+hB3dK7SpAYdBykh+AHO
 xSI7FGkVOmY4a+c9n1MWyrWtIKcRItJp9mInHQpJqetDMI94vRXJ+kmYhiRTt2uPMM4K
 1+s9lvIF0qSD5JyJ1yAlaV/EIti7xOWgamIkE3PAyXN/SRn2LbgAWTOu8g0LIsbNFLiK
 ++0uYZS8yiZiARHP9mghyuZ7yJ1wgciQD0FQ33w59VOa7C7pPkqot6eoku90anb/beTU
 0Zxw==
X-Gm-Message-State: APuU4Z+7ZOeEI0FQeUOKRuyn+7x9g8jU2kkdpF60RDjI5hpom/EssTwf
 /TKzWie3gOhv/5P33IAtFmSkeMKIKxbmmB4LcI9yfHT4emQsHhrjxd1cMY7gDWhSU0eknzaAkzF
 CMoqc
X-Gm-Gg: AZFdTZf0sZqi72nvvbnwRkUeKs/BGV6eG8WxKGeiJiZYp9CjPieDgtGBIVtS113L1Q2
 qZktZMnkS86Fp6UHXVz15DsD1QH1Thy1+LrEQrACX8ACEyXdYZJBbWPsVURf2U0YdZVm8L5S3PH
 8s//YyARIC/E+U5kLJVSF0ci0W/ONesST/QZQ8oTdaNRjr0RKxVU2nGUNotFXDDxQK0dLehAXfP
 8zkSHkJOgnb2lsP9RbdF2poYqLl0yGVcXx/9io62+lXm7Czavn3pGva68twBKmp7uwA1Qq/GsWO
 4sci9m7vyJMZgRvYYJeH6fgwMAzcR64f7GnGc7PkdHzbyCp6rwTxhLTHoN6Ea5ibuFtTORchQOp
 lHxFAF26KRhO+PaTU9PJLzDnkeH/RQtbSCdLcoFmOiZnExRib0IZCAf3V8b6DquKgCgXY/8NHd2
 7B3CRnOzPAVPszsEWWY8Y96Qg4FXQwRt3mLFCT/q2H9KTJ0UjoBQf5lcpNC5tg5d5hv0teFPfF8
 Dl3fXXludEpO90RXwvqUeR+5uM4JqTpk4B6WJuqyaR7XQ/c1v1NGNZ2zzFox6mO2TesWF1opxkS
 pG6d3l3VoC8BxCi6g2RFzzRYsI7gW3D5LvbNEaffeVHVaneGJvXhzZbMNeIuSMk/5ZGKGLYp0Fm
 20j21uzyaz3CKAb8jtMdbgyRDI4JA9Po=
X-Received: by 2002:a17:906:2b5b:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c513a284994mr484528566b.0.1795262037678; 
 Sat, 21 Nov 2026 03:53:57 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:57 -0800 (PST)
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
Subject: [PATCH v12 08/31] usb: host: xhci: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:12 +0100
Message-ID: <20261121115335.548142-9-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced drivers/usb/dwc3/core.c has a global dwc3_core_soft_reset().
xhci-dwc3.c has its own function with the same name, so a build with
both CONFIG_USB_DWC3 and CONFIG_USB_XHCI_DWC3 fails to link.

Make the xhci-dwc3.c version static and rename it to
_dwc3_core_soft_reset(). Drop its prototype from
include/linux/usb/dwc3.h too, since it would now point to the core.c
function, which takes a different struct dwc3.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/host/xhci-dwc3.c | 4 ++--
 include/linux/usb/dwc3.h     | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 5b352866a5b7..ce740b8f51a1 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -51,7 +51,7 @@ static void dwc3_phy_reset(struct dwc3 *dwc3_reg)
 	clrbits_le32(&dwc3_reg->g_usb2phycfg, DWC3_GUSB2PHYCFG_PHYSOFTRST);
 }
 
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
+static void _dwc3_core_soft_reset(struct dwc3 *dwc3_reg)
 {
 	/* Before Resetting PHY, put Core in Reset */
 	setbits_le32(&dwc3_reg->g_ctl, DWC3_GCTL_CORESOFTRESET);
@@ -79,7 +79,7 @@ int dwc3_core_init(struct dwc3 *dwc3_reg)
 		return -1;
 	}
 
-	dwc3_core_soft_reset(dwc3_reg);
+	_dwc3_core_soft_reset(dwc3_reg);
 
 	dwc3_hwparams1 = readl(&dwc3_reg->g_hwparams1);
 
diff --git a/include/linux/usb/dwc3.h b/include/linux/usb/dwc3.h
index 9ceee0a1c9f6..e916275b9817 100644
--- a/include/linux/usb/dwc3.h
+++ b/include/linux/usb/dwc3.h
@@ -216,7 +216,6 @@ struct dwc3 {					/* offset: 0xC100 */
 
 #ifdef CONFIG_USB_XHCI_DWC3
 void dwc3_set_mode(struct dwc3 *dwc3_reg, u32 mode);
-void dwc3_core_soft_reset(struct dwc3 *dwc3_reg);
 int dwc3_core_init(struct dwc3 *dwc3_reg);
 void dwc3_set_fladj(struct dwc3 *dwc3_reg, u32 val);
 #endif
-- 
2.53.0

