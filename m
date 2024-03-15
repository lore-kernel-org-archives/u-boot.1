Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD84C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D441F87FEF;
	Fri, 15 Mar 2024 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFq5DrQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B788801F; Fri, 15 Mar 2024 16:10:48 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ED688023
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33e6aca1ca9so1676774f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515440; x=1711120240; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HxlOsugX2/wIO/P7KsmKCSR/CeuUXJcHxpYPD4HuMPo=;
 b=uFq5DrQgzkugw9zhtf17coZj9ibue6w9AVFLCs71+pWiuQiI+q6PoZ4me0Xz515nhw
 W1kPfBh+/GAMTt7JNtZGl7TAJVN2PfT/4fEmnUsiCZCrmKwvvrUo8ais5xY7yAsHNcKZ
 KnSiL7qTkYAu6UpYHnlWfRy93uc8rpyZwARhTLLbNvgmX6xosVuO3LsBbZkDnQOzBkm0
 mqJBcBcqstWug70YT7oBLM5G6wpGhpU5Rx0K/9D2RHBPSFxXYZ0cLd/bhH/RvY0+9QEL
 s4cn87CkU0cNxBaXBSL9JY+V7XRi0zLM7X9/9zDsPD6LVd4leOqlNfzRzoWi+MtF4QRx
 Mf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515440; x=1711120240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxlOsugX2/wIO/P7KsmKCSR/CeuUXJcHxpYPD4HuMPo=;
 b=s/fwxFbsAznuTtIampZuc133juqMITZyumsNxPTVj5Fyar1TUzKEwQrY281K2CEAxf
 N3/aTKDvnWerVxuXp+9aje9NtHvH97q3y4RZ1RaEimALQixkyo8SpM7QQxpitMxRz7hx
 Xwa/QAB4hc3f/59Llj2kToLzfYcEA9cVP4xZqxIczo7MUp1HwuN8FymgURwjFTj3MrqU
 7GjKnpuLaFz++PFvoZmR/HLl1/Lh1qtOu7pVQTTkfblyOMF8T7c0JQTLg2M9BlVsB5mb
 GcLh1WH1ckFAtRJsbXdTITovSPE1QUM3chwXcf4i8YBclTX6k3G9CDPToQTG2oi9NFpF
 c5KQ==
X-Gm-Message-State: AOJu0Yxetg4OtAnYY6CjXWf83IUajuSQF2j/FjbhlhwSMpp4B7AT49FY
 /t0dBTidU0ceC+inRC/GjVpQAU9E/L31EkUu4+rYPRk5+toxhn8JFVoOE7z1pSdS7iCucgMxk6z
 z
X-Google-Smtp-Source: AGHT+IHJ1E9Vq7gXDek2ZchdUiD7pkg67BDdVeAuiuYwxteftVHpsICEtRYO+AyonSYJymMRqG37kA==
X-Received: by 2002:adf:fa0e:0:b0:33e:cbec:b2bd with SMTP id
 m14-20020adffa0e000000b0033ecbecb2bdmr2800266wrr.9.1710515439870; 
 Fri, 15 Mar 2024 08:10:39 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:20 +0000
Subject: [PATCH v2 11/14] mach-snapdragon: fixup power-domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-11-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eATLOOhI4TMycRloeb2rEN+Hpuc/Br8JMYSeGYyQmIY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY835HU45L8PffhOkP3iOru60G+6ovFBU/etT8xIa
 F0rIOPbUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACYSKs7wP9rv7fWquhem22bd
 TJpW/+tMZp1C9enM2wu1ONJ+RlUETWf4Hzxnl0J6lMTmyws2T709ffrt6DU/CpXkZ8/RX2Kyc0V
 dxX8A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

We don't support the RPM(h)PD power domains in U-Boot, and we don't need
to - the necessary resources are on, and we aren't going to enter any
low power modes.

We could try using a no-op device, but this requires adding a compatible
for every platform, and just pollutes the driver model. So instead let's
just remove every "power-domains" property that references the RPM(h)pd
power controller. This takes <1ms as we're using OF_LIVE.

Of note, this only applies to drivers which are loading post-relocation.
Drivers loaded pre-reloc that reference the rpm(h)pd still need
DM_FLAG_DEFAULT_PD_CTRL_OFF in their flags.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 6810c8617cc0..49f1fc1948f3 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -21,8 +21,9 @@
 #include <dm/of_access.h>
 #include <dm/of.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
+#include <stdlib.h>
 
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
@@ -108,8 +109,39 @@ static void fixup_usb_nodes(void)
 			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
 	}
 }
 
+/* Remove all references to the rpmhpd device */
+static void fixup_power_domains(void)
+{
+	struct device_node *pd = NULL, *np = NULL;
+	struct property *prop;
+	const __be32 *val;
+
+	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
+	for_each_of_allnodes(pd) {
+		if (pd->name && !strcmp("power-controller", pd->name))
+			break;
+	}
+
+	/* Sanity check that this is indeed a power domain controller */
+	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
+		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
+		return;
+	}
+
+	/* Remove all references to the power domain controller */
+	for_each_of_allnodes(np) {
+		if (!(prop = of_find_property(np, "power-domains", NULL)))
+			continue;
+
+		val = prop->value;
+		if (val[0] == cpu_to_fdt32(pd->phandle))
+			of_remove_property(np, prop);
+	}
+}
+
 void qcom_of_fixup_nodes(void)
 {
 	fixup_usb_nodes();
+	fixup_power_domains();
 }

-- 
2.44.0

