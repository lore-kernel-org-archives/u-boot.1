Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD22C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE9B81E1C;
	Mon, 31 Mar 2025 14:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iFVKVcjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C498129B; Mon, 31 Mar 2025 14:23:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B8E81F7B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso230744f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423833; x=1744028633; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n4ZX1kYeWbkWD3oGSfpMiI13LVZvhkUoF6CId8hdoas=;
 b=iFVKVcjVpZQ5jrsGqfqg6WS/rIDuuV4mrlimHiGBrxy5rhUmp+99fSx4ogJ6SVSXbt
 JVz9HnSrplIlgjFpyxSHM4eRYnLPoNLv22jNz6YJ04UKl35nL6IgkY15cRz8leC/vEZL
 nqdc4sR+/l7oNK7GHpMuAZJ+kTatj/wLkGc0h9xpsfSNSOqUFnlgRfgg1Ou/E9GGF2xl
 U7Q55G2fa4+MVs3D09QCA3qOX1zyA5zvO1t6B/YWPGjf7Fk31eVVo8gkwnCqU4wZBp2J
 zNNI+MCWnr1j4S2TQgWPHdahNnsxe8BAMr6Kx93ZT4WiyfaZOqh2Eq5a2MusdBtN4TOo
 8D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423833; x=1744028633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4ZX1kYeWbkWD3oGSfpMiI13LVZvhkUoF6CId8hdoas=;
 b=FJ+koi/iOrq5DPSmxh9iwc00HvMdxKZF9BJWoaB/smA1ZBYrdpxmb/PQ6mpT0YspD/
 Gi4MK4J+r+qcUVx9FL0YloYK4J/sPQ8Y1UbwCumuCdf6gmvWsFh0yNRm0XmvySE7nhwA
 Sh0RO1MKOmKaZieK7Ka/NA758U4XaMaLDLd0oWjJLW9HSkIAoZiybg1sHKnVyjAG7gf2
 gLhT5uoh9n3RkfDmq6Jz53v7jPNq/QUaqL5hcBQletTcsxiXpxfMuY0eT4yYqScRgpFX
 CWZ3WtqwD0592ujs7g0U08FVAj2fvot6umpd0AIuIhFTKIBVTHT/iZaPZ211iutZG3xA
 nFHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi+D/ZpByHDF7b7CtYyZumiV5mPv0OgxUKc1oVD87a4qs1Jdu9gs6MECrt/eKQpOsDGGxUuqs=@lists.denx.de
X-Gm-Message-State: AOJu0YxzyY7qRQPCsiTsuD5cuNcNpn7pt1p1DBUuznOy27j1nqpy0M9V
 xoVb2NfIrz8AS0um2mGJdow8sZ/eZ1qfFCtLqNf1/q3teTdcVnaR/FFPJ8/SQLs=
X-Gm-Gg: ASbGnctPWFiM0KYSRDAH55eSKxP2k9aFlgTCKIQtBnvfmjZeAc9nMxX1DhhpRHO6Rf4
 XPMQf1TfRPaiD0IMfL+NiF8+etuabreas7V2Dro9CS9w3Xef/wYGi6y9ik3QwjiHkuK8ACyc9Wp
 5iVxwB2i6+VVT7vPqk7Se2kSPbgPJEwE5I/VVVme8YLPYCoLbdMIonxudoopu55yNywvLTe36oI
 8cudWgbpQRwgN0kl+FP12+Lulz3AZ1w7gmylFc1W+lBzLswFs4nMlPPEBCPv/b0QrcsMDAti0Eh
 a/VgAN5ePoekQqAVQUTgtWSYP0QtFwTzLFvATRXpA0g1+cNuzZEWvYy827sGXDxK4n6qmaLA9nA
 Cz443IkdU7jjr
X-Google-Smtp-Source: AGHT+IEj/itsGGd1ks8O7OLW4qbPzMV0LktDNNwJJ93YWy7cT1dRRrP9sx7vQ2++ldWdsEzK5GgCQw==
X-Received: by 2002:a05:6000:4284:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c0bf23245mr10798173f8f.2.1743423833487; 
 Mon, 31 Mar 2025 05:23:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:23 +0200
Subject: [PATCH v4 6/6] button: make button_get_by_label() case insensitive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-6-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=2RKQbKocfiqQwaU+bvLnopzJWPshiwiyW6dFzJC7TEE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olNiOkrgLYnte1f54S66ItVyRqkOu9uxlUXR
 3S0mTMO6XGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTQAKCRAFgzErGV9k
 tkX0EACLNQwTJKTL/ON7jZYO90MTAl30+eHcShBOAB/lGPtapc6pyHRgxJs+pWqDZq2mbkPxrbo
 iw5YFnfkb+nB1DgJZv1AkEsbWy3ly1Z4rYGU9u7jJAZgfmLh/ztQIoxoB+OZK+qHbrrJxTD1Xzq
 zdt1mokAOtoVDgC+PHFWTF9KzGEkc8TsRgb0Bw/9bi7VrJbNWhouuy51G1jXft6rWlOxzyUrxL/
 B7q8hDfxel+lAtS1QEPSsBe7BT3Mr9PNozjOGv+kH628uIqTLkeBAKgCVdSkp45oHb0s0FhSVkR
 rDt6zLya7fDNTOEBWGUoaDeMy4zc3xmXs2jJbGKQpfyGNA6FolTR2RUuNmsx2ibxGtN0MCkYM86
 2tLkToB7hewXWmfOMCI0fs3AZEhFomE8DBwFFNPB7pLhHmsUEKsyfeKKWWTW+TrTPAsjQAHDffz
 xybX1WJObrlreNKhOKTFDUHnwwIAxYpmepaMpOOSSR293jZqaN3k6tF9EhEJvxhtp2VDuqWvSkv
 EYtOSorisgZpS0pLHuw1fU0JY/LE5p7Rvp6CsyVk312iO9156YwGJKheOy4kPp34k+ZJFSZ+ihR
 wGyYhyqGjmp1adEfO71iltNoDz6VWexmK/pQHl6ObkNwJ4RHAl8ZskDni9hwk3Mu8sWf74y1BLf
 6qKzt2iPoZnvQ1A==
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

This function is already doing a fuzzy match, since there are no
guarantees that a given label is unique.

Ignoring case makes it much easier to catch "Volume down" or "Volume
Down" in board-agnostic code.

Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/button/button-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
index 729983d58701867f7ea18e9b5f87e7404bca3dce..025917887e80f2fe9cbd3777e04035d20fa34713 100644
--- a/drivers/button/button-uclass.c
+++ b/drivers/button/button-uclass.c
@@ -20,9 +20,9 @@ int button_get_by_label(const char *label, struct udevice **devp)
 	uclass_id_foreach_dev(UCLASS_BUTTON, dev, uc) {
 		struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 		/* Ignore the top-level button node */
-		if (uc_plat->label && !strcmp(label, uc_plat->label))
+		if (uc_plat->label && !strcasecmp(label, uc_plat->label))
 			return uclass_get_device_tail(dev, 0, devp);
 	}
 
 	return -ENODEV;

-- 
2.49.0

