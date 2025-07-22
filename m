Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B581CC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BAC48338B;
	Tue, 22 Jul 2025 11:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="sxFiGqIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1E683346; Tue, 22 Jul 2025 11:56:00 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF368338B
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60bf5a08729so10107475a12.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178158; x=1753782958;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kc4UBqs6mloHfQA782897rpvGt1rGMNv9OswzWdG1LY=;
 b=sxFiGqIHYQM0F3PtdaMTtwCfK9TrsLzjmOqn7NXJlfZXpyp2q4iwOhEYhfescgR4dT
 2x/ppXAaW10mvX79ybga5w/5PNzU+f6wExRfn98RCHqLF88z51dxmM+joUeY0deWhqRN
 NgEx4lRMlMNyq8dwsXi2DgALIIC9O6Unln5ecpgfpf1no9qWL+7k1jJYOeF906pk24GP
 6vW3NQY/nZoYzGaUhCoxsaALQbsn5Gl39DFpBPpbsabbE6fwsVpxcbSdLT/M/eMs5Jn6
 la0fWp5ehHavEpJlYfDfYqQjrLsvPzwdD1m8rRpArJHFvixwj93cwqaxfdwD3KSTlqah
 MrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178158; x=1753782958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kc4UBqs6mloHfQA782897rpvGt1rGMNv9OswzWdG1LY=;
 b=EzydXr2KBWCNwdj0s6ZJSomADL89GD1SCyjUmwa55fWI9jFC47p29m8+LxMPqZIWew
 GJX234UULIxfeUZUieTAQjnwTUON6Wk+kkf0jMAyJNCbH3tHCL8Cqxt+EAUTUpnpz1Zg
 BGD3C//N1W53dQxRBWSCajsNMvYDjt0AEermvcPk4YtwVSOj7S/0bTRXmLW6OQT2amYz
 N2y60IBEpnpzsxuT38Rk9mjDMSzojGY8wZ3wcIkxykfEbd93e6H7Qn2RSDat8AN8eCKC
 W4NuX9OQpCSSYOQV5kglX7qF3vikvGZz4VCEeoLk5G3d1DZlpAqVuVgP7XPSucMebOmD
 e8Tg==
X-Gm-Message-State: AOJu0YxOHKMD/H4zDgdObYvvg1q4Fdw24bhShr7SGS9gwWhVaxDmXjCq
 1HiaLizcIZIUxBe3oBJerW8PxmC3JN3Pft/yRkC8aS8Nf+6JN98/RAiHbbAUxam/zNo=
X-Gm-Gg: ASbGncubdKS0cD3ga+JShJvfWb0zsM1FJLUeItTzT51/gIi/xN07uXt3m3lxXPfGjD3
 wbgbu+f/RCEbIW95BIiKjNSPaemO1QomCe5ofikgw11QjM9ksFXfWxEBvjKgCs/VgMkkT7FY6nV
 9UEOcX1JnH4S7rYRucOEBe4S9nuLv28Gmdj/CheGKN+KHvE+gYxZKHWhucVkzSBHYm9XtBN+GAk
 OrTDfTYoszFbVNYrC+3KDwybNFbo+DZa7Ik1IOYzUwAJUCvrKQfC2tHIHH0l5Y4xhZ1IruomsSN
 PMR9XRgrTTf/UksW31SZnJbbU8maTW1kvm9OUSdWp5LTWQ9nSD+fBN6gjSrRfKNOhBME192wE5R
 1u1rKQGDt97xuh/Mq01CM4YULL7TkYMjM1A==
X-Google-Smtp-Source: AGHT+IFuBEHMhcqHRaXK4ELUPvzmN3EO/5KUjb8PgnicKTjP8jobLPdkdzXtV5supY04t+eDYviF4A==
X-Received: by 2002:a17:906:f049:b0:ae0:cc3d:7929 with SMTP id
 a640c23a62f3a-ae9cdd861c1mr2229647566b.1.1753178157702; 
 Tue, 22 Jul 2025 02:55:57 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:55:57 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 22 Jul 2025 11:55:33 +0200
Subject: [PATCH v4 1/5] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-1-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently the check in usb_onboard_hub_bind is relying on specific
compatible string for the Michrochip USB5744. Replace this with
more generic approach that will allow to add new types of devices
to the of_match table. Because the driver only needs to bind one
"half" of the hub, the peer-hub node is used to find out if it
was already done. In case peer-hub was bound, -ENODEV is returned.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index d17c85dd6225..7606362a4ee6 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/uclass-internal.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
@@ -179,8 +180,8 @@ err:
 static int usb_onboard_hub_bind(struct udevice *dev)
 {
 	struct ofnode_phandle_args phandle;
-	const void *fdt = gd->fdt_blob;
-	int ret, off;
+	struct udevice *peerdev;
+	int ret;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
 	if (ret == -ENOENT) {
@@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 		return ret;
 	}
 
-	off = ofnode_to_offset(phandle.node);
-	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
-	if (!ret)
+	ret = uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, &peerdev);
+	if (ret) {
+		dev_dbg(dev, "binding before peer-hub %s\n",
+			ofnode_get_name(phandle.node));
 		return 0;
+	}
+
+	dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
 
 	return -ENODEV;
 }

-- 
2.43.0

