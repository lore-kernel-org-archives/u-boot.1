Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E051C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 15:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E4D838E3;
	Tue,  5 Aug 2025 17:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="es28/GlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB72838BB; Tue,  5 Aug 2025 17:45:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9095B83890
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso20625285e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754408752; x=1755013552; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rTDtydKcFfxkI3Uby9QQTHXJD+LfMkwpBnwxc9BxGC8=;
 b=es28/GlRKn92CcpZTUIxMw3A+dA9jPEuWRL+CploybVEXrWaUxSa9yIkEwKWVEfT0x
 ijhGdPbV7jXuAhlry+ZEjsGfDauzjeF7Y/LpsnVlpVDsFkyxsfG9StLTAmkXFS6vDRe1
 4tntxKyXfOlB18O/AD92LPQxHobKj3MRr3o275yJp/nngkNtCNwzffBN+AbKEyrhZXW0
 6MOjqRzgobV1znfyFH8DgFZ3z5W61uIAaLac7Q9BeaFzXuyI18uXpqyxxFRVkcbTJEjD
 H7M84pZlkRaCid5QnQHAECTry2Mh6QOWMfuLQAa42xIcfI7PV3ma/lKiIYaEjxVE06Q7
 bckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408752; x=1755013552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTDtydKcFfxkI3Uby9QQTHXJD+LfMkwpBnwxc9BxGC8=;
 b=HYlHkEPrj74Mfl64G4Pwf/6o67E7WhiTAYWfOro4lfoXjpgseF5mkLdjzMi+jpulta
 aScwVyfEyjrvWtgSB47fmODjCa9V8SE4+3o4/aw6XOYo5/rKUSYV/+BH9JspLEiHaEtL
 w06CZ0WbhnCsYD1xe1en6/HkJCgZb7w+ZecZPuiRCG/36jTt5u1iKuPr8AX4UiWzATU1
 Dyuy12iuogK8ifGfMX6o1s/lA0aeU0ebMm4ehtuw54/mqyUYk+LWdTXJbS8qkrw8QQ55
 EmNTVGIY7mogJCoKDJdXFJCi+YccYVWb0XYFF9skPP1weZbsomTHc5XoeMMmN4khBG6B
 zgdg==
X-Gm-Message-State: AOJu0Yy1u9dT7yIW281RtyKbv1mgUx/jyRcJbhZABUSuCVJlw5USZptW
 Z+4n5rVRlWJdmCkSulYftJMNhA8A0mLrIklQ2adh2gS6uNtIjUT8UIjac04pc/PDsQs=
X-Gm-Gg: ASbGncu2p1xhdLOXrdHQgwC7eWfy8RBdh7hXvJ3XJadzrKXZC8LskY2wrby8KciQxxi
 cVR4kgaVGGhUO4jRhbIL+eMEXzyo8XPF51tr2NoYq+AxkVwHRu5F7lNXQxndqKTgezmSfP3f2hc
 26XcKZ29tbVOnUgqaIVNjxioNq7C+UqBNIBFkvP1uiTPJCDqmxrL/c6Pm5nZ7De2gxyX6nABQGP
 9j7e63ta0brdW4MtT01WkXDa69JJpT90IRtXkrQYPXPbUHglyi2ksL1oEL8yBoQyPlDXBzAVJEN
 6d+0LwXoketLFciJ/nuGavsbCuSrjrSseNLpUROd4uX72HU8EWC2Rw0XCI98gNREVUNM+G8vAGh
 u0rjF112cbhVPlbNOlycOSoJw2+rD9jfYoMfQ+Tv41XlCwIVAFjA=
X-Google-Smtp-Source: AGHT+IGEz2LhLM7nGhpTY30X1zxqL0zjghKDKE1F3bWStGfMILyuNymaIRTcIAmJXOlYMqh8HVmR3A==
X-Received: by 2002:a05:600c:1f16:b0:456:1e5a:885e with SMTP id
 5b1f17b1804b1-458b69cbde5mr120960575e9.3.1754408751994; 
 Tue, 05 Aug 2025 08:45:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm9007255e9.9.2025.08.05.08.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:45:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 16:45:49 +0100
Subject: [PATCH 3/3] net: octeontx: Free allocated memory on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_octeontx-v1-3-637095d82265@linaro.org>
References: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
In-Reply-To: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In octeontx_smi_probe if an error is detected then memory that was
allocated is not freed. Small refactor of the code to use a common
return and free memory. Also return -ENOMEM for an allocation failure.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/octeontx/smi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeontx/smi.c b/drivers/net/octeontx/smi.c
index 233c26f7319..217bcac2ce2 100644
--- a/drivers/net/octeontx/smi.c
+++ b/drivers/net/octeontx/smi.c
@@ -338,7 +338,8 @@ int octeontx_smi_probe(struct udevice *dev)
 		if (!bus || !priv) {
 			printf("Failed to allocate OcteonTX MDIO bus # %u\n",
 			       dev_seq(dev));
-			return -1;
+			ret = -ENOMEM;
+			goto error_ret;
 		}
 
 		bus->read = octeontx_phy_read;
@@ -355,9 +356,16 @@ int octeontx_smi_probe(struct udevice *dev)
 
 		ret = mdio_register(bus);
 		if (ret)
-			return ret;
+			goto error_ret;
 	}
 	return 0;
+
+error_ret:
+	if (bus)
+		free(bus);
+	if (priv)
+		free(priv);
+	return ret;
 }
 
 static const struct udevice_id octeontx_smi_ids[] = {

-- 
2.39.5

