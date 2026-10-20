Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77920606A33A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PvT8/nIz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMVMzP1t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5066E81117;
	Tue, 20 Oct 2026 10:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpRC18OpB_rM; Tue, 20 Oct 2026 10:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF05A810D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491403;
	b=H2R5lwuMHhwSZdjJWj/BgEU4GPqb2YFcdO2KvxloaDCO/+qM70GaNtJPNvc5tnRd38KJ
	 yrakCcF/tSa1FA2NFsA07OcxXzYN1yZS7XTWRCC4lBB/Dma/DN1f87KW1DrzgUS6YRpja
	 FhmN2ZVr3YtpocuaoGG4M4CczGpuzNNPIQniLbCwOAADM8oJRgrlcAhCmC2UyLqn+JNhP
	 IY1FcUK91wZbPyEXOY5HG7Mo3yGIPFexozXbJK9IgzFGsadozdK1fMmrkxLAy8XdsmxG5
	 aLA0QZEq5UgzWaJUN9QeftIUGvCpJv58enEZvvAGuIzRu0QxUtVOwz4wKG7bXbjD5MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lyRDj7jiWDodJwIqx4MFSPqNDjoJQ/pvFE0fOu2BnbI=;
	b=kbDBJg9KCnakOZe8ftfGIlLXlKzk6qS5px9Hwc0K9s3JDep3h7dSW+bb3HL7M61/X3nf
	 xCj1QKZmAEEKm+OWUdHCf32/AM7FJwbAAkMd5FfXdDeA843Xk9FlM4Euz4r8B4g2PZnsb
	 ba/Tb/4G0eArRf+ILXzJvxk8Qq/M4ym0+v4R1KRdKrDFzHCw8SdU3lRHVD3kkKPKTW/QQ
	 29m2KEoCDKdyFjroOGQrX8E9JOwmqwkb1AzWOKIcEResRDsqVjrP7GyL7GfApxesByPPo
	 nupvnZ6Nn1C69Z4DlICjDOQFx26NJON1zI6oZI70ib9yfj80Pj/xvdnGxRKwd8aYHYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491402;
	bh=lyRDj7jiWDodJwIqx4MFSPqNDjoJQ/pvFE0fOu2BnbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PvT8/nIzZt/2paMVW1vYijvjwTq7G4ju4QhHLsqGjzB5Y3UGpRsW3GJxFhoM+VI2H
	 Tf2dWumRv24oiZ4VcktluJ3ESLqaC97dCwjJSNo/VKB5/quJ17qjIK00hJvknV6z+3
	 8rBPx38METRnXjmBoC2fsZ+U5857XpOxz0AFJuLfDXTZdsPwzvpaEFPaDZvtqc2cjJ
	 80Sur72vhDqmnPYGfHFBD9qo/xXGfRzxRnM4cDgIfoN/k0pH493/cobapbfVORVSkb
	 gxfym573F/Ma5vAMB9vETGc0HGzrieBYEeA1TlkrPRE/wDuu/HXYXW6eY/EC7MIgzM
	 muHy69Xk9Pbmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF05A810D1;
	Tue, 20 Oct 2026 10:16:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BA721AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D5E24073F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NIWzaSz2JhMv for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5FF3640735
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491384;
 b=DrsS3iq+bA7XtnXf2/ldkFcR78/QNBjyfQnTljA6YE68rTUyILR18C7vraqrxO43+T4K
 jrLSA+vfU34im6vTfc4yLtgq6A2mvps6gHQYFDB0glR46KCaZQVxa1tmrKrcVpXV6JAIv
 MhMb+1Kugr7inW6V5wHNuIaieqr0Cnx1/L2ba6dBNQIoLEU7sk9XY2l8xJzpjwZJ2FRO8
 2eTnppSKOXLyYUxwyBBLGqTpEC0gHAxta6ml0kbf2WTVVPhmIE+l1Wd06dLKXYmdPlscZ
 QuTr8F9DC636pM9Zb9xhenxW3QJr7FV5aVNneJNgSfY9RHWbLzp7JY2MRmI0Bhnje1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lyRDj7jiWDodJwIqx4MFSPqNDjoJQ/pvFE0fOu2BnbI=;
 b=cMiHOn6JxBQ/67gd4IQnMh+zl+m+GXZgNxpx8BW+al70Tu3SPvdBJfT5mj/PgvVy4pHD
 cVBHgY2FmB7pXjw7XLI/pN3h72nqM2vV7Yq+JStKs7s5yPEWGGB8ZXJhQH9pc3zx/VfT+
 Rx4S37EZjRx8YWsV6jgaig1OB9NcscEPWtSOtnwNjaCCXOBpbpdpw5CqA4ljGpsBEeU35
 ayyfaB1wwuwPjd89SNHYjRoznu+GpwPCngwP4hzLUh/wbgKHxK6vXxgKjwgEnjjqAhUL7
 RxR3wYsTAuh4bMJbYTAI24NQ6TIx+ZAMtEDlZSVpa0F90gxbHMpD5LYezbRsoCWdBYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OMVMzP1t; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OMVMzP1t
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FF3640735
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2521757f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491380; x=1793096180;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lyRDj7jiWDodJwIqx4MFSPqNDjoJQ/pvFE0fOu2BnbI=;
 b=OMVMzP1t5d/MBKm2LV2EmyhXt61V8wj+JWBqo/x8hB7bo/Lnr6yNkBe+zRGGtoPVBZ
 AkrkuRmrsidUt7wwMO9B6Ox9wVS11G9bZK9ISVB270pBegCg/tKsl5J6MXq7G0nx2yGH
 5OubF7rnRIUmtJGzp7rQH202p3BhMTtIfhze0LNXJH3lmUIDITHxyijOVsuRs4FmqobM
 xTuO1KUb61kWXjZoazFBSEi52aT2evGeZY9ZbqTeZonb2CQXCgSgIOPL1LOYRklAIces
 K86xdtiOKGWXsVdy5cBcxuUrCwy7gUCUnuv26ETzYbua+MA5tQ67WRbSW0i/0ehEJXc8
 kJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491380; x=1793096180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lyRDj7jiWDodJwIqx4MFSPqNDjoJQ/pvFE0fOu2BnbI=;
 b=wCMYph6sC6Kr3WlBKAOQhD+J04GBfJ3mKvdo144aQPkBdOEr3a/7hLNwg3Cr6xb0oO
 tVoFa3cSY6B7VAdLa9FWCBqgNPAgIHGej9l5jwIev/Yffy59hO9nT69lfBqc18HlYm6d
 T1ttQQDipsmtUVUkc8zXida7mo7gAr5s2TefnNuzLx0czEMji1CA0FBAS/Os11t6wkiH
 68EnxkzetTJZQlc8B55XHpwQCRfkWFlIe02zRq7IrIrVoQHVJoZ9Cc14q3+Nw2LY872d
 wzS+74gn787+IpfPU2aZp/UFbBoUixnTIPkWse5bvShGlI9W4HgwPiltqGvu/OKWzM4L
 kLAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZmL0Nlg3nz0bPGPhRt/E1Ce/+QkKRfvzYGfS2VuoYOTWp9QET+8x4+ZblHBJvjOAFWzgE32Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXFDTo6mtvaKcf/HFW/UAju9mZbzuqBaQzmlOIyb9OdStq1oDx
 08Qu9I2RiZaMJc6oTddE8pqdNbp7GiGmHzo9yeUCgqGpySSm2yYJPSY3
X-Gm-Gg: AYBFou0lkrsvFGgzmCT9Mqjui+GMHDfyP5Nll2LJHIUyFU50Y/tGIo26f30+xPkozlp
 st5nNhzt2EAmanIwuCO/GpcrUH4H3U06Ey07GvBh5K5y6v3hE2hnDIK226fnmRG1EPF1pI0lGvm
 l8AfbwgdXk/lyY/MBTJpYtMws41la9WHW2nEenVg8LTgXAi+35Qb7oa42uO5vsNGuSy6+fr1VwT
 lRV/sWvLN6cVm2sFVKTLd6LJh+ApAqLtL1cASMQEUyiQLrBVxCk2Ej7007yeZjL6eFR4N28tVyX
 R2X6QO2aBKrOLQZqtaFHrcH3rtKz8KyTp7ePC0E55tLASUt5isMzvj8ZOoOS0H10Mbf6yaSbEXo
 yTrlR0sb1HNwXp5FfDAuJDxfoRyiEmpvmAluHlZZunCugCaS6ozb079dS70pdzW5xs2Olf6w8wG
 to1p+jxF7qlH1IE3jpbPafuogjZNkhr5M62OG5Q8vXhrzbjo/MxcLXkY/8PBLeOWfiAn5qVXRbu
 9WQ
X-Received: by 2002:a05:600c:34d2:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a1d7614d3amr211087445e9.27.1792491378221; 
 Tue, 20 Oct 2026 03:16:18 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:17 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 9/9] usb: ehci-vf: enable the vbus supply of the port
Date: Tue, 20 Oct 2026 12:16:08 +0200
Message-ID: <20261020101608.2818265-10-mehmet.fide@gmail.com>
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

The driver never enables the vbus-supply of its port, so on boards that
switch VBUS through a regulator, such as the Colibri VF50 and VF61
carriers, the port stays unpowered and no device is found.

Do what ehci-mx6 does: look the regulator up in probe, enable it in
host mode, disable it in device mode, and turn it off on remove. A
missing vbus-supply or a build without DM_REGULATOR is fine; any other
lookup error fails the probe instead of leaving the port dead.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v7:
    - the Reviewed-by of Marek and Simon on v6 is dropped: the VBUS code is
      unchanged, but the remove hook now comes from patch 7 and this patch
      adds its VBUS line to it
    
    Changes in v6:
    - dev_err() and dev_dbg() for the two messages; the reset hook reaches
      the device through the private data
    
    Changes in v5:
    - none
    
    Changes in v4:
    - enable VBUS in the reset hook only, as ehci-mx6 does: enabling it in
      the shared init as well counted two enables per probe, so "usb stop"
      never switched it off
    - the dm core patch it needed is dropped, next claims the regulator
      GPIO at probe time
    - reworded the commit message

 drivers/usb/host/ehci-vf.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e67eae834b0..ca2023cf7f5 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -20,7 +20,9 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
+#include <power/regulator.h>
 #include <linux/usb/otg.h>
+#include <dm/device_compat.h>
 
 #include "ehci.h"
 
@@ -42,6 +44,8 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *vbus_supply;
+	struct udevice *dev;
 	u32 portnr;
 };
 
@@ -221,9 +225,9 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static int vf_init_after_reset(struct ehci_ctrl *dev)
+static int vf_init_after_reset(struct ehci_ctrl *ctrl)
 {
-	struct ehci_vf_priv_data *priv = dev->priv;
+	struct ehci_vf_priv_data *priv = ctrl->priv;
 	enum usb_init_type type = priv->init_type;
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
@@ -232,6 +236,13 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	if (ret)
 		return ret;
 
+	ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+					      type != USB_INIT_DEVICE);
+	if (ret && ret != -ENOSYS) {
+		dev_err(priv->dev, "cannot enable the VBUS supply: %d\n", ret);
+		return ret;
+	}
+
 	if (type == USB_INIT_DEVICE)
 		return 0;
 
@@ -257,6 +268,16 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	priv->dev = dev;
+	ret = device_get_supply_regulator(dev, "vbus-supply",
+					  &priv->vbus_supply);
+	if (ret == -ENOENT || ret == -ENOSYS) {
+		dev_dbg(dev, "no VBUS supply\n");
+	} else if (ret) {
+		dev_err(dev, "cannot get the VBUS supply: %d\n", ret);
+		return ret;
+	}
+
 	if (priv->dr_mode == USB_DR_MODE_OTG) {
 		ret = gpio_request_by_name(dev, "fsl,cdet-gpio", 0,
 					   &priv->cdet_gpio, GPIOD_IS_IN);
@@ -313,6 +334,8 @@ static int ehci_usb_remove(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
 
+	regulator_set_enable_if_allowed(priv->vbus_supply, false);
+
 	if (dm_gpio_is_valid(&priv->cdet_gpio))
 		dm_gpio_free(dev, &priv->cdet_gpio);
 
-- 
2.55.0

