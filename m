Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4D606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YIyRYZya;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eImpr/Sq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8051B8119D;
	Tue, 20 Oct 2026 10:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wegBd1x2tuv1; Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C529381187
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491394;
	b=Rrum0MkM73yyR5cYNuK5rXh5vaTimzxEPhFYgXP0SW3pTRbFshjkSKo8svr+2SE/KQcU
	 8G+nryGsW0nCi+3fhSssMYUUEjP13pbQFaFefTnqJSzHjeWY5GDSEoOF4cYhiBmQKeWXf
	 6SYuwH/TSxp+AXgmXbEi8peVr2ZFAfZZpuN9h0wn9tXASNFboa8ufjjCyaBt/yLVI4C5r
	 nASunIsQ/DT1HlREChotJ4LVhRWPAovwOU+LB3KTBL61Rj26JSWG00Y4rVCqa6Rj28ei2
	 eXk04msPisLivkegdGQMoMXP/jYZ8CVizB2kyJBACqIwLakmXtLt35HQBxIYNOaJ4eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TAk0wiADUY+M9oaCU5xpmrzG7Z8LhQFoLndxix59FD4=;
	b=kOurWTWpjCGNvz0UGXEZfkVqQ7VIRPoDHh0PSE5RXssyvnBdGQZTIXMMq+zVsCZfrag1
	 HA1Y43/pICvNGuzpeHD+fWr2hcR07sNnVciRNJRsOhfjjyXbveRGY+1uCZD3DOu+Rj/3T
	 uL3C+IgT2LMXgcKJoux46DYRSgx49Vgkvhy/uiiKGwIKHnrBDMOy7nV/Semt+ixYFoRO+
	 UMPlaZUJAt0L4yG7EApdc3XATHU1fqSoNlafUbYErL0gs9A+bVkOnsjrJMzp0fmlu26CE
	 92G8UY+s3Imnq4IwnSY8Hc1R1LRMulXsaDqA8zEMkrkbzVajfWCm3GcOlCaZCOSek4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491394;
	bh=TAk0wiADUY+M9oaCU5xpmrzG7Z8LhQFoLndxix59FD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YIyRYZya0CnCnSoluMds0jL4PBFEHlFlBIg9dxL164Nuf/4sPF65EGajwQo7+l9CQ
	 o9uMP6jqyecvzwJ0plSxJT4GJlp17G8o3UlI8UZz7ri9jTyXQTd/WQo8QFrYraad7N
	 wUID2UWV+Y6O+y0nvOHvw13uhNnf9d4TmMWGigeK7VPwbFIwg+ZbDuaOfPOW/9+MCL
	 HT0cst4jPlRKh1Szq+t8DquMzmvPOy7Bqh6+h4ZSqyE/zIhAhW7IIyxbbR0PRuGx8b
	 M81ejHN8SbNB21f0/nadeZOAxaYlFVrQcdxItJS3d3GaRqMnwZAPR7YKHioGwOxpWx
	 f0D8Azww0Yreg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C529381187;
	Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F8723A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01BEF40328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7p-r8TQZPVD for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 100D9400FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491378;
 b=jVLJ8nv58BhHKIx3cGGsKBMKKQxp7AgzJyY+ZSzcG2W2i8HgUQZ9imgU9NP9zMzUbAXo
 KL56L4g72CkFexix0ZRXu2HvEUfvigda8qF+jD/xqg+y5OCYF8jcf/fkSKXKBIXFkVfRO
 70viJx/McAp1uewRBSXYe1B/vorbzf3esudiEWX6BGXgiItpu6gOqzAbqIHWy/Ohu77bz
 aJWkNgXr+0TnQ1c/6/c+Vd3eTBVQIZ5r+FwtX0rZWjnyNmFx9UosAEaV3ntJr9HtZzRyi
 v8+IXyTqFD9OI39bQRFzruYBHwqWwxCunkuu4Emya1eOB2ilFv9wDf9pPQzfkMztoVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491378;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=TAk0wiADUY+M9oaCU5xpmrzG7Z8LhQFoLndxix59FD4=;
 b=ajz3lWw6Gjc7/endApaOrw0jIjNYRe6VcEzVWdmiQ19bJHGT0fJeweu+WI8/8Ebpm1jD
 2AU/456qPsIm/AOTBQH/27Vk9wUPqVJnPqKnvn/mVWq+ct1HMrgS551sU4gc+8i5gTljw
 nY8BmFHNj73e3mBp465V8uhLTqq+E04NOWk15KydS93yMns8b3LxsxDXlEJj+7mch+iWj
 AAjyJPFdCFbvmCc1H4gn+Js7thAo8as3dQpQmCd/wYkoUdNcWFu/mj7mR8TEnJIxtoz0S
 SjiWqKxDyVHSG2SLRt9ywJBBYR4v33blm1VW8kzrxFwHe8pMnqqnNnrSAZio2IrImcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="eImpr/Sq"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eImpr/Sq
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 100D9400FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1f68a9855so2542535e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491375; x=1793096175;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TAk0wiADUY+M9oaCU5xpmrzG7Z8LhQFoLndxix59FD4=;
 b=eImpr/SqfGKXXSUQPhFHbXuevz98nHwez4t+EvbvP2G/dJhNtDFHrtDResSQfeB+zg
 lWEAuZHrPn+NpYWAFtf8qASZG+LYq41tIysfqrdopG0tKmP57+ik8OIL1yHd2ZUJnwre
 eduVd7xRRNIF8o1GP43aM6h6W2Ozfg/3zt9wwZR50CZrLGPY6EMweKSH+lq7spTYCn5Y
 fdjNx7dvpCFxY8SsPSrTKVqIdzAfX4h4m2nyDsSjxjxueLEDfZNWJPbrX2hhEyFgWZXz
 6JTaeYFpxEEeb4qIDKqaHH9W4ecScSlS5SPe+ZWh6cDr+vvRJ0AZx4MzDPePytMAe4rJ
 UPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491375; x=1793096175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TAk0wiADUY+M9oaCU5xpmrzG7Z8LhQFoLndxix59FD4=;
 b=qMlr4gthvoqoDhnePw6kEKrIvIoL+txV7wQ/Wfq6RuCE5F/R4LyrE+kD4Ouud2S0wm
 kJW4YYK3g2qGMGeVK5PurCXgJnANHMBXIjTC7K5m92z1EVXOYCG5nbC4BEYJe+QEPX2a
 HOl0OgthvRk2Z7vRAc4c5PzBsBpCLV5xA1BqiqRsh7UunB/Y5R4Rwn5CFL3RvYsnoBHe
 X/6yOL+OhXfG4jkbUyPCqf8fn9Ml+5fUJdUFC22IqEKvnS9sP8CotZpgKIn7Y4EDVdMd
 HUL2AYTd9PWdkBvCn4G5xkZERrUKMr6hK9LoF4IR8CUgt1Pzra+Vagstsw01lhguffgx
 LSEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9dqxFoVjGHQmGwOWj5BO3C2i6xIWw/vN4cdwQi+Fyd9zmfbH2zNSIViwjwjTuTCv5M1Pw5yc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2+o1WdBqzi/xddkT0JO4v9lg+zM1MKMuZSWu39o7OlkmogrEV
 oA16v2MQeF0mHEzT7S8JcHA6qY1Q9ryssiKTJ8SFWC1n+WbQPucVupRO
X-Gm-Gg: AYBFou3tkWP/Mw/VsVf4D87F4WfsZa6zz7objImAgZEjD0u9KUhAyPEngNMPdeaIY46
 i5oDGv7v+2wA2lIDzplD6Zjvm+rf0E9UYot27vtm5b9sp8rzG9TQzDfvRpUPBXTyno7IWrGsvYr
 mDTLkdghkkbI7VFD4Ce6xMmAl3CBzs/pBSKnTR7AN+S09EXYcpQYLezVGe86jl8dIlB+gganNtV
 Z6Kdyf2sJUgHh5ib3xntlzprVTTVzm/00tK1BaNINK02bg/WtnwMWM0z5OTVcmeO92G/dmWVSkQ
 udWdbnbfa9q6/NI139q2FGs6TGQr/e+deyjGpoEQ40+z2Q2KfiSh8ZMqzcatxye7NGFRVQ9fnE7
 A+sbi7RgTXZBJShXK7Rfu423I4LGB+tI8fd2FtTz91sMcvPr6nv6LpN3KqfyqUFxMZQHrSgzZiO
 pqfs1WCeJAIb8ALvT0sYY6SFIfqFBZYhtQj7abt2Ou1YYuLCRvAD8hOreXrAgaNxFrDKi5rId7a
 v9T
X-Received: by 2002:a05:600c:8b6b:b0:4a1:e7ce:10a4 with SMTP id
 5b1f17b1804b1-4a1e7ce1832mr116929175e9.29.1792491375493; 
 Tue, 20 Oct 2026 03:16:15 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:15 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
Date: Tue, 20 Oct 2026 12:16:05 +0200
Message-ID: <20261020101608.2818265-7-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver parses the dr_mode property itself, through the flat tree,
into an enum of its own that mirrors enum usb_dr_mode. Use
usb_get_dr_mode() and USB_DR_MODE_* instead, as ehci-mx6 does. A
missing property still means host and a value the driver does not
know still fails the probe with -EINVAL.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v7:
    - Marek's review: this patch only replaces the private enum and the
      strcmp() chain; the ID detect gpio moves to the next patch
    - a missing dr_mode property means host and an unknown value fails with
      -EINVAL again, as before the series; v6 made an unknown value host
    
    Changes in v6:
    - new patch, from the review of the register base patch in v5: the
      private enum duplicated USB_DR_MODE_*

 drivers/usb/host/ehci-vf.c | 40 ++++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..1d7b3bdc285 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,8 +21,8 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
-#include <linux/libfdt.h>
 #include <fdtdec.h>
+#include <linux/usb/otg.h>
 
 #include "ehci.h"
 
@@ -150,29 +150,19 @@ int ehci_vf_common_init(struct usb_ehci *ehci, int index)
 	return 0;
 }
 
-/* Possible port types (dual role mode) */
-enum dr_mode {
-	DR_MODE_NONE = 0,
-	DR_MODE_HOST,		/* supports host operation */
-	DR_MODE_DEVICE,		/* supports device operation */
-	DR_MODE_OTG,		/* supports both */
-};
-
 struct ehci_vf_priv_data {
 	struct ehci_ctrl ctrl;
 	struct usb_ehci *ehci;
 	struct gpio_desc cdet_gpio;
 	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
+	enum usb_dr_mode dr_mode;
 	u32 portnr;
 };
 
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
-	const char *mode;
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -192,16 +182,16 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
-	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-	if (mode) {
-		if (0 == strcmp(mode, "host")) {
-			priv->dr_mode = DR_MODE_HOST;
+	if (ofnode_read_string(dev_ofnode(dev), "dr_mode")) {
+		priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+		switch (priv->dr_mode) {
+		case USB_DR_MODE_HOST:
 			priv->init_type = USB_INIT_HOST;
-		} else if (0 == strcmp(mode, "peripheral")) {
-			priv->dr_mode = DR_MODE_DEVICE;
+			break;
+		case USB_DR_MODE_PERIPHERAL:
 			priv->init_type = USB_INIT_DEVICE;
-		} else if (0 == strcmp(mode, "otg")) {
-			priv->dr_mode = DR_MODE_OTG;
+			break;
+		case USB_DR_MODE_OTG:
 			/*
 			 * We set init_type to device by default when OTG
 			 * mode is requested. If a valid gpio is provided
@@ -209,17 +199,17 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 			 * of the gpio pin.
 			 */
 			priv->init_type = USB_INIT_DEVICE;
-		} else {
-			debug("%s: Cannot decode dr_mode '%s'\n",
-			      __func__, mode);
+			break;
+		default:
+			debug("%s: Cannot decode dr_mode\n", __func__);
 			return -EINVAL;
 		}
 	} else {
-		priv->dr_mode = DR_MODE_HOST;
+		priv->dr_mode = USB_DR_MODE_HOST;
 		priv->init_type = USB_INIT_HOST;
 	}
 
-	if (priv->dr_mode == DR_MODE_OTG) {
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
 		gpio_request_by_name_nodev(offset_to_ofnode(node),
 					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
 					   GPIOD_IS_IN);
-- 
2.55.0

