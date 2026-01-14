Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D02D37E3A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 313DB83642;
	Wed, 14 Jan 2026 15:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQovGAk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 990A08063E; Wed, 14 Jan 2026 15:13:19 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB05830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so5372685e9.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399997; x=1769004797; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JkFKobl5bV/tU2dq+g8VDII2ztp9IKxmIMu8jsjs7GY=;
 b=WQovGAk5ujjPp54SlkUhJur3k8+HukY6zNuuPcHHI8HVupa8JGeqLPLo5WF0dFNaeH
 gk/RYjMG269Y2bgtgaEbLkn011xY/TDOjipQT0EWG+s2uoOFZVBqeyzX4+bSwltyxe1/
 uJPjoqEkkFQl2bliSkjZGLychgiltPDb553/OIOFRuhiG9xghKjYkDFlHHd7M2DUrLo9
 pu0jdz1fPksPzsZ2VRICj6ftDsJg6e0uM+xtnt7irNXIviVwK/hJTMd6+Be9JVLDWC7d
 KuXSwkxW1MDwLqZbhB5IXj1smCXE2LlPIhvOuZ/qL5Gn+L99ibUCc9qXyI7O8gjl3Yf8
 MokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399997; x=1769004797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JkFKobl5bV/tU2dq+g8VDII2ztp9IKxmIMu8jsjs7GY=;
 b=Uf+onxhKlMCQ/83hQBFU321X1A1tkpkWf+pN2RPUUwvfxCRxdb3jtgJ75PsVCB+BrI
 knHD/4YVsPD/8Q6b+daV9ri+LXmKZuTPwi0jFkHyJ1/J1sxRkPqtT4kYo3yOdHnjSYsb
 H5s/jZif1eVDMUz1KW3Rkbwl5wMLRFIxiq/qq3wsRU0AUJ7I5ZX6YFulpoCsPYqQ95SE
 oXw4CBRihu1bFZ+dmzzzcQziemtT2BjP6OtMDV+sV9sSlLIM1ra8Dp2IfD/hR9lDU3bK
 6QIeqRa0gfYHvyNgZKiTDafhS6GzorscrvVZ+hkiI3ofYdb/pW80zPEhmUcGKlmAyvwC
 snrQ==
X-Gm-Message-State: AOJu0Yzltimc9zvNQBdVer24dgMId6ZQrvKsqt9cRpyIptIN5VF7uboe
 cjA+eFJ6JGv6OFp7wMDJ+XKvV65sn62U3miGzwtq5/fnnpoSqW9grOHgnhqTavLQcIE=
X-Gm-Gg: AY/fxX4d0tGbmN8Op/OJ8Hjs1v3dhezUiheAZEKSbudrH+2++JdJ2NfaXnSRMSUk4yJ
 I5D9wDBbc0G0B/qCW7xLn4/2jpfaBOofaCA6Hwgja4VB2jKsvwi/FGR7x81KHd3rytj8TP7RMcr
 /zfWfUqxGot5cnOUb/VixBDHQJVDMVkDhbKfpN751btEpRXEWdIiUlTcq09G1NEA3CTqqupFYQW
 URQqbZIQvKw2MC7cgI7onREM4l9qu0XiKh/UME/UMqOLxtrM+F9Gxao343ygKtozQhdFzBz3akX
 JIvfJH8xVO0ONP+ZRR6evDrgG5wGLTjTG+4A7BCvrF0aU3Q5RyBBzYWE/RX0k7l8eVOpYmUdOW8
 801LwNFlb+Q97ks/Os4zteQXIrHdjABB2SyeqmzId+ulqXAo/LckBHIeEUHgIm3sxiTXqLA31KX
 kRPdkAZd2Qhq5TlVJAYj+Gz1vO7qgiZVELCcPFNHjb5nihy9kj0PdK/qNCaUgP9VO0
X-Received: by 2002:a05:600c:1da8:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47ee338a6f0mr35206455e9.30.1768399997118; 
 Wed, 14 Jan 2026 06:13:17 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee5910fc2sm29279755e9.13.2026.01.14.06.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:13:16 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 14 Jan 2026 15:13:13 +0100
Subject: [PATCH 3/3] usb: dwc3-generic: respect role-switch-default-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
In-Reply-To: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=RoSNZKik5Ee3lmtP68cnzUMoO0QXKNv22Yl/t8aBMuI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsz0JRUhi2Q/FD+ekjZf4eUkhaYJLYnLPywQvvHnjsDxx
 1+69mp96ihlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATCbzN8D8rOn1uj9lNn+Ui
 dUf3zueSuvBr3hnXfYsT22qWG/HdPPWE4Z/xWt+lxg//zlO/9lYz7stK0ZIvQXckPHX6bpo8uJJ
 Vk+UEAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Respect the default mode configured in DT if it is set and dr_mode is
OTG. This allows the board to prefer host mode even on a DRD capable
controller.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7044696ced0c..1aa9fc933282 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -528,8 +528,13 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
+	/* check default role for DRD controllers */
+	if ((dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_UNKNOWN) &&
+	    ofnode_read_bool(node, "usb-role-switch"))
+		dr_mode = usb_get_role_switch_default_mode(node);
+
 	/* usb mode must fallback to peripheral if not known */
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = USB_DR_MODE_OTG;
 

-- 
2.51.0

