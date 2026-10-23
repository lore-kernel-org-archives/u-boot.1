Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A3606A33C
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zub1BQ0v;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ArT8GW/D
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 752EA813EC;
	Fri, 23 Oct 2026 11:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJaiRk67TTOa; Fri, 23 Oct 2026 11:16:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5A81813F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754191;
	b=M/nFuYeHcvhFX+nBu+VY/xbeOE7qwdr8FHYQh8Bq+8I4OggChkFLzZYA1Cs5Bhqmrkmr
	 MopH+93do5R2hgbKDUfD85PYBdAYT6KVPO8JxW/q7Vs1fWqL0lr7UYzAHaUfPQvPUQ5rX
	 lvquB8CL5B9OmUMxSOVupSdpowJAzry5bq/l7Z2U6tWq8PMN7JaMlDUxGhXT6jcaZDWOe
	 oaaFAp344cPqIgrnz2xvjJpYmVn4ZlGrqYkFCmGiikY29siWqUBqC7QN75m+dVVtdkG4D
	 NDFGYq1rm5vNa99cSOeCIfHpZFCXPCNidtLiuZXnasjGN7umpTXWhIIxUS9+26qVAxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eDE7IpXVJI9W5lYur9binU/BC0grUzDF6UnzIRFuzck=;
	b=KYWkdBDys2vvzVAeLFYPr5QoW+ONiXW0CZY7yqVbp+OayztfpvdiO1lOGjYSu8YZtGmk
	 FKguoVYveRfl0Xe4+NUXgNA5lySfouPXws64TOCXrfL5q9gZ86nI1KPzY+yPl/ae0wmIU
	 6Sdx/5EUPb5rKPcIso+aKdaz3Y1g6+x5Z6xkSl/gKUIr1Rm1okCSaI6EJrHffuAmaIf0S
	 Y7XuPuhVGde3YlB1MKZ1UUJRtT+Klhc2RgofMix7dCg+kfwILu6/fUGun2mpxqGUThmyP
	 pv6jUABw/YXkpZmQbbETy9I72dJv/IPkwN8mIt8xqPqozobSu9Y4AHnw6zh1ilLAlVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ArT8GW/D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754190;
	bh=eDE7IpXVJI9W5lYur9binU/BC0grUzDF6UnzIRFuzck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zub1BQ0vtglPPGzwHtOMRfQySBwLruAj32e5lsT77ko5WgiiJpTTaEunTKd+QiW23
	 604vkzD1wMImk1JRh8+T3YmbfBuq3SA+W4JPvPsYQub6fh8o8OCyWgmwiXunq1yl67
	 yVuppbylNdhQN2TruriSgct4NAEL+22wIj/K4h8ORcLcpHk5xQGreWqtwRykEk0OGb
	 wruf7jSD9aKhLt4Z1EQSKJ+8XcAr+6RkEeue0RdcTaO+IZgT6h6OhiAYpf7jT0sI3V
	 cevxRZkXAQf1ho0keIeCcUmyixI5dWiLWt+iczYmNP080kZEobFADjThMWFaLlUgWO
	 al+d4N4ORgKAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5A81813F2;
	Fri, 23 Oct 2026 11:16:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A2DFC235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 920128122C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ukxSQNouDpRd for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 307B8811FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754174;
 b=b4kWwygnKB1mmVGmV9FMUp5UgecTh/Xx2Cfzs1UWyltti5LytU9tE79rvg10ybX5vlf4
 tSNJhcCh/MUgoNStKseTXQWommjKdbwx8dM2LbAszSiPdD73UdfcKHGinxUb1/dLEKfCf
 AemZIvbQ1AcGH7XtovnCL52Sv8bf1a/G0jTsPJYrhvck8EVTD7ih1juwZMH1QQ9HBOJjx
 CsqKTEeDj3aQtNhipLAAcOjrnaggjT1lfDFl3zF0P6JrXva5P3shGoUgJohKodzzrJQ5J
 yu80PFKxA743ZssVbucviO9NxC5nmuh7Udi2KcpmOgrx9o7QqaNNgtuD2OoupE3fmqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754174;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=eDE7IpXVJI9W5lYur9binU/BC0grUzDF6UnzIRFuzck=;
 b=a9xeorH8UiMcwICQirACkC9NQf/TDiw+jUFqUx9WhD7iBt+uajVbp3blw0syiqqkwdrK
 71MkN/+fzY7KXpmivQJifcqZkg4eVsVUXqrVfZj+UxKkjBqRBDUp8RFR1nxQhvWLgTVrY
 Egd/aXFe3Xjkul5E0rQbz531MX9HKrNPdAF5ZkqGzCpXhMhgfprklL5vjlo8+of9PWPJB
 Lci8h1a+wTofRMFmp+HgbEQ1SqCDbSV0y3J0ikdmzxo6TZVj+taIMqTD/6X8/y6VopHJw
 jBlyzfIdVkxd/Zv1bbf/re/C8jFSxZNE/PePvEhPuH9G3EfzNytUaFYdu7ODBT5OEtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="ArT8GW/D"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ArT8GW/D
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 307B8811FB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:13 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so675405f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754172; x=1793358972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDE7IpXVJI9W5lYur9binU/BC0grUzDF6UnzIRFuzck=;
 b=ArT8GW/DEr28vIlWcaHh3gI1rHYlMjhQrJErgepl5hsD6VZ4PZk25kZ0Ux1DKt9ANW
 zbFWpENhlRwS1IQlT/Hd6JNR5KcIknKmk+kR/ZSyz9UYmqNzgZ2vobLMPBVH+xY+13aG
 Li1CvT5vmbo7dWxOBDQUfvVxtQg1zyio4Rgv/NvugxKgwp1F7pggqgKMWEotXbQ5jFuB
 kWSPLWVZ5lp30hXpSBgIqsoJON1//iQ1OztNTpy/DJAgt8dpdujvHPDin6oQdKcc0PjE
 CN6TLa642XL2ctPvixvJSWIR9LYsui63GfieO+rBB1BKDKtxp4nZBMa59kqPKbM68j9Y
 5uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754172; x=1793358972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eDE7IpXVJI9W5lYur9binU/BC0grUzDF6UnzIRFuzck=;
 b=ZzOeTODkcZ1nZ52L9vEDmFr+NZuI5OI4MLTheON5kDxfJLj5oSlmF1cONcDwzokCdx
 dvjiSGJZzVr98Ze8NLdcSqhOD7AJvKCHIwwu4hFM23GAukfbde6CaPfgPLi8bdf9y+xm
 hK49e1f1w4G6tcqzeCfU/12G5bTgWEK8mlyPWUp4A1lDf79pSvBHMGibuPWVOtEHE30+
 N4HeeUHC23C7qADnkLw0xOy3atw14+9S/gU9idmaTaABV+alAN6KecTBVsblHlt4mU8F
 pfRKaaS5kuAP0yOML5GWgzVT1iQBoZ4CU4Y9Gk267k8YRjW72001d7H5Ykt+xOlwJ5jR
 EoGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRolNPphCkTYekCoySTz9rGwylrNRvrj8cCssKuJ+F6DYfD5GUP3zWqXlobLCnLMrORCs4fxk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI2MWHQEB7dNSeIbraIqJK2YgMUaGCBVRJY/v1ef+43zL06HA3I
 Zis6AjM/HgOTFIydEmbeBJiV6DBFAjo4U3ME4e6jKM5qxH5t3J/+S/6E
X-Gm-Gg: AYBFou22xMgtgLEzr0752Hi1GJLFz+PeRWrNcl/FQ1ZfAZxPPpaPjGLm9zhNYiWq6sP
 ifLLY1SJd5HUJgXfcmFRPB7bnRBj2MiGjM4BhM+HwXasjh/0zvyivYWTj4K1X5xuOqn9opuRcv3
 dgmpc6Fwvj3eWFHTvQYc669GO4+sZqWR4uBqnsQIwMIOD1l/WvINE9gMEmGPcDs72pfCNWgw5SV
 aAcVMoXhfVS2/7k1Ge3Z1W4gFMBQyY0xbFHlqotxPR3bF3N/z2pk4N2c7tuMgK6w7BiwTYV49ER
 2kmAnTrRsDVW6inAZKUBroAcLscbVjCz5OlqtAcDx4t8IhuduLZF1VHarLi/LLkLSTeUNc57dZR
 KYQj54JmJtVIBmLXE8VgQk6F6I3nZEEfslNilGJwySWNEbnjCiHa96G+nxXZNPVLYi7ru3XyQ7+
 jl07HoFYkPaxaeXMb2P+JFGtJreUaygy5o6QExdmaHex5Z4tjbMj2ruWHioIlhUiE89DgVlCryV
 5Fso9katB6oIqVUhLB+OZCjNYkTBnpkQVxUxoASK+kZucUsrKP+W0KLPXV2VA==
X-Received: by 2002:a05:6000:98d:b0:48c:7ee3:e07d with SMTP id
 ffacd0b85a97d-48e385bfc42mr2895727f8f.52.1792754171690; 
 Fri, 23 Oct 2026 04:16:11 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:11 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 9/9] usb: ehci-vf: enable the vbus supply of the port
Date: Fri, 23 Oct 2026 13:15:59 +0200
Message-ID: <20261023111559.4081795-10-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - dev goes before vbus_supply in the private data (Marek)
    - Reviewed-by from Marek
    
    Changes in v8:
    - the two includes go in sorted, and the reset hook keeps its argument
      name dev (Marek)
    
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

 drivers/usb/host/ehci-vf.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 364ac5b831d..f7809a98c88 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -17,10 +17,12 @@
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
+#include <dm/device_compat.h>
 #include <dt-bindings/clock/vf610-clock.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <power/regulator.h>
 #include <usb/ehci-ci.h>
 
 #include "ehci.h"
@@ -43,6 +45,8 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *dev;
+	struct udevice *vbus_supply;
 	u32 portnr;
 };
 
@@ -242,6 +246,13 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
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
 
@@ -267,6 +278,16 @@ static int ehci_usb_probe(struct udevice *dev)
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
@@ -323,6 +344,8 @@ static int ehci_usb_remove(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
 
+	regulator_set_enable_if_allowed(priv->vbus_supply, false);
+
 	if (dm_gpio_is_valid(&priv->cdet_gpio))
 		dm_gpio_free(dev, &priv->cdet_gpio);
 
-- 
2.55.0

