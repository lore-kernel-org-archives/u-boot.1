Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC4606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jcfj67tl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fw9qBkTn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EBFE8122F;
	Thu, 22 Oct 2026 07:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oLkzByywgbV; Thu, 22 Oct 2026 07:09:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5036D81219
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652971;
	b=rqENzihrutXI8k0G9apNgXYZyq+S165ubNrppi23SqWGpUdlksHS74DElK148vV+/790
	 YXS0Qz1wYQv2KuR9YVel0H2b6iR/eIcO4Q9U4biKzvKe/YZL71rePS+5GCuVN9TNI9S1h
	 YXr9ey+Aw/3+UA1+j6USVTB8Zx+xclnaPVYayOb/Zyc2K5h/XYw/4D9P1Bznlf9q5vo3X
	 twIfHmOFSBqAJDFvsZGHBcIhxwtPDXMTjGOOVbzxMHOw0RVFVAFbckXUiDcSDKvaB4dx6
	 L9w2DtuLCKP/17Flmdf4ZdMPj6khYMs9D3OBJ4yaX/Iy6qeq0OjMXZIqi5vVfwezneQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fuV+oXY19BkcD87eO4OvG40OmxxtmRuczQgfK9gCAc4=;
	b=QcyZ2TNi68kDnaBaBq5Sj1v65Yg4po3bowtOuV/y9DLePoEGOF633AO081bLLOATP0L+
	 3teuFjSl7zZYPTiC4G00YpEmZvAMVjPakpGqKT/CSuWZhHxzuUlaqbRDWUn6RHAeb8wJ0
	 jH2zW7pJZi2y80ZGcwmdGR3xqLG6PiIudCA0HhoiPIybPHZ/vRS+jCUY5dT1sitDI359A
	 OL0tOXENG6a+ZSrUpZYnr2XIKJjo65MTu8NhUh/SP6ws6W1b5vyzXrIh9o834S7CTrkN2
	 6HpOEx9VSzUzUnqNoC+jst0+gJytwJEt3OQWrJDiXQnB0gAQ/WSPpj7T734PC4pgWGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652971;
	bh=fuV+oXY19BkcD87eO4OvG40OmxxtmRuczQgfK9gCAc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jcfj67tl1XIc2/L3tR/gR7exOJl62GnSHPQLIMd10+FQwuNnI4gXyeLJlLCyPlCje
	 FvVJIVUab76rizhcjjDv+ulb2SZ0NgSU4HMojc4xu1Gm+0+yra9mDZDI6F3ZoBfnnI
	 foVCTlc9pudl05YVCA/hPPw9ZdBbHtJ4TufYYAPDJgFpr7NoKa2GyVcSemkVGQ5xr5
	 +3xaa9/tumawUHQO2jQXb0k6bLxYfyvgLbDCScbHQRQ/4k53QcRDK0XTdVcG31Ci5e
	 8zmQB203VeqVIbNiaH9p/Y5w49aKnnKtrUquxiXikwewtN7lFQTbS944jvQCW6ZgIi
	 TVdNuuOhg/22g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5036D81219;
	Thu, 22 Oct 2026 07:09:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13E413A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03A6A4017B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qk9UUC4MujzU for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00EF640042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652955;
 b=evwvyo5S3pPhKi/Fx6cg5038GVf1XHKqlIQsiSYnbEhhYrRM0kzHzQ1QWtk9nlQVjMyr
 dVgefXdSgXzel6ejUH+33C0CXFkvB87yREzIOQDfTfeLGhE/JoWeXiLZ3SNbo85uEH3Ie
 K7D3VBIKewGUA2fD2ibQXG3sPHpVE+Vgy8rx9csencl/Ify5zJzeEh3uxr0zsSOHHhzR0
 XTe8vVWMR2LDBJ4YCDq0UmxFW22th+3jNcaQRO505cdH1KFra2PLZofqEjuzxhtPYixaW
 g1/XwsBrBoKI70G0Z1hFs2nd6K2NMdIzYxWVDgWr3LT+vzokbhm480NAkJ/xsQVhIxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fuV+oXY19BkcD87eO4OvG40OmxxtmRuczQgfK9gCAc4=;
 b=bb2exdOROxueC9tL7xxujxLy/iLQarnckUizFHy5N/levPk2VPu7t+8BHR+8sbZiZOcf
 /oHKKJ2A59Dmb3huepK1XvNm8/NwNv+zbVBqiHNwzfwu/XDqfolVbTZvV+7yJPLhOOxwe
 O9Y5z3GFrX+YDOknBQLldc3z+tGPG+NlufRXZtOxZQxcOcWIi37yrcUflGMogIsc6OTC9
 2vcinNpbT8rDy3sX8IWp6Tkjtb+K7v5yKvwnZOrmFY7LSxBFI8SC2hFzt5QZ+OgmDfCRn
 +1s+eXS3S5pca/Yd948C81C4UkII2ReA1hhjkqi4j6tMARU1xqc5rMoTf5UyVe0k+dw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fw9qBkTn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Fw9qBkTn
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00EF640042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so473598f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652952; x=1793257752;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fuV+oXY19BkcD87eO4OvG40OmxxtmRuczQgfK9gCAc4=;
 b=Fw9qBkTnNVh2lGc9bqxoWbvyVJ/j03CtKzqLRiS8sI4wxbhe8UDwX4vsfwt4kvsrSw
 TYbJ6Lz1wvQ0JtCcxGE7D1YdRnzcGUHlFgsDpdB666GrKbA08C1/s8IsP2h2OThO2sT9
 NMydwn1awdIVbnF8G314KEFyPIdm6vUJ6X/lqtUwal3lpjxZyV6F1UOh6VoRDdCIlgwq
 CGZF1orC69bO27yCCaiyMl7+9yvCfMuRhZnRihv7XuVWakT18LM22N26HvB/8RnHbpOB
 ybNsO+9x1Rnb82SPBhLjC0PzD3cTTcjzduvGf7Q0JbvJrrStNFiqPdEYKZV3K2kWo59Q
 wZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652952; x=1793257752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fuV+oXY19BkcD87eO4OvG40OmxxtmRuczQgfK9gCAc4=;
 b=rMP92Sn+zOS2pVLbjQzb/uP3GEBHX90c64SeIy4uRdt/MxeyJkepurQ4c+/YJp9Kmc
 K3emDsAYy5J5tqm83s20oQPXRR+38qHu4hjY8lmp7SFdNVt7zSOrZ1rUa/q3sAPo9kZ7
 GuvO1tBEUpfdK+7Tf+8mRmR3Gee+hC9ZDFZYUTqzZQBJztGfBWkjippqElGf+hCkFAk5
 I24YE0LnSHfuwA2F4yE6ibNOtucre5KKHaPS2VcHjZ3Siaq8a/KyCFauqQIclwGMtEyx
 4JFFELGPDDlGjHU40KoemlEw/oL7uOk+JINiK4k8AE8FeDC7Qgs7mbH6Eqbg+3a6dGIE
 szqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbF5D0wvO3b0fzdoO/pzxFH3v955SyAjcmIf36l/8cRytUDdnyJ8y/h6fAkXq8BknQyTnw1z0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIkmJOQW68vjVVEfsjSO9ZHJprXG67a0NcENt2RPGYQcjyT32gh
 bLcqlLq4c9Q4+3ua3qpV/BH2Ek/VZ8OHG39HanVvrPx8UKoSjsTVkPMd
X-Gm-Gg: AYBFou0wnS3maNoO3p09MuFrWy2qz1ZhQizeO6R2/NC7cSRkhK4bG1O4tDVvfg6bMUr
 1pqrweKNThKadP3nwDa5ZuGUH3Az9yOjSd9biyNmFbP3i6Dc61QNFwOn9YAvKaY5CBUrRpYVgHW
 X30yK+7clDvE++21CfQq6zn4q7iGLWoxfe2kXCDSzgzsfziu95UpLIU55R8cJMK3wEbQv16o6/9
 th+RDMMBK3/99ynfC0fyPWlBquyW2rIHG08YFb6pDvzGd7xHPNAupOZ7/1I8pB8RsK1lCCdd97o
 z+qeuRuhBUnnLyQ1Eksg3obt28bMRCiG+h92aNX4+RiIrN1qaW0oKSD40Pe8ltsv7iIcnJp0Uoa
 vn09IAr9FZu85ysm7Ds21WcI7fBoCSSEa04jSvcuk2w9Vp/nTFvLETCgasnYmEIjcljg68UNsVQ
 h5a1XOgTXa1tQRsQcNYx4X0cFtTceieeC1nCSSLw2iqp3i/p215sm+7+G+/quNGxI+jFI9wO1hL
 m7ZmzEeD2doTh9BHt33pDLuHef0FHksazPWQZ21UOyAe/CcF2p3C/QFUtRguA==
X-Received: by 2002:a05:6000:136a:b0:48d:fd5b:504d with SMTP id
 ffacd0b85a97d-48e264b1ff5mr5938959f8f.31.1792652951705; 
 Thu, 22 Oct 2026 00:09:11 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:11 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 10/10] usb: ehci-vf: enable the vbus supply of the port
Date: Thu, 22 Oct 2026 09:09:00 +0200
Message-ID: <20261022070900.616265-11-mehmet.fide@gmail.com>
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
index 81f76ddb1ba..f5c6eae6779 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -17,9 +17,11 @@
 #include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
+#include <dm/device_compat.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
+#include <power/regulator.h>
 #include <usb/ehci-ci.h>
 
 #include "ehci.h"
@@ -42,6 +44,8 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *vbus_supply;
+	struct udevice *dev;
 	u32 portnr;
 };
 
@@ -230,6 +234,13 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
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
 
@@ -255,6 +266,16 @@ static int ehci_usb_probe(struct udevice *dev)
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
@@ -311,6 +332,8 @@ static int ehci_usb_remove(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
 
+	regulator_set_enable_if_allowed(priv->vbus_supply, false);
+
 	if (dm_gpio_is_valid(&priv->cdet_gpio))
 		dm_gpio_free(dev, &priv->cdet_gpio);
 
-- 
2.55.0

