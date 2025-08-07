Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4084C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4790E8457E;
	Thu,  7 Aug 2025 16:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EEqn2M7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC3B8458C; Thu,  7 Aug 2025 16:41:24 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7F18457D
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so522542f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754577681; x=1755182481; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a1CKmRU2bBq+tmZJOdiDw3WLmjqPy4c4Crn8YWSzKmE=;
 b=EEqn2M7MJl9RIbQr0WlfpRCAUJgJPqft71vW34AS3K5YZEO8/3c++24tbv+9k2lckb
 ukbwn3yT2JlsEfHr9s3tl4PQY9nVRegvXr9vWRZf9dQYFGRlZ+xBYZb/dU9k1nr5yN5P
 /n5eF8NZo1opC70vp23ZXBFKHaVGvQRhfYUhBeEeq22MFVs3XH2BsQfEAEYdnp6yN8hY
 hWt70qFkYGw6UN/czSN5Pqbrq8g8IIb114TXs+MJNbqNmp6KC3OwYQKODvvs6fk9EneR
 3M4viFajvLxImAZCPQL7tp9990gI0tmPtt+cQMYF5/TfOqdLu0gg51RMVZim4lWXFtPF
 8R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754577681; x=1755182481;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1CKmRU2bBq+tmZJOdiDw3WLmjqPy4c4Crn8YWSzKmE=;
 b=WFZP8L4yfRzCULr4BsGKU8y0y+WyF3GjNv48lgzK0FlFygp0z3x4bOuP3mH8aMmiRG
 LiTMUWr9XNJPn+O0Mn107komLVsvGloC3GjUWZ2GeB597NJat22dQsulb4Qrlntyyw07
 LvBAb1ixt05qSzhJN7v5N6DogTlzxYx759NS1lE+11q1RW8OIJbMF9VcnJCtwh+3Jqwx
 Dxi+zbZN1PRo1146x30yh7Xh0dUsdf9d8fbBLxUQXz7QPkOIbZPjNWvtrnMs3THtqm7X
 GouoFszARO30P950ofbOC+KxeIlCXyRGdmdrMDrmhfY7+WT3lZjtgcQzXcDrFgKADjoB
 rzag==
X-Gm-Message-State: AOJu0YzYyPazJRUq5Bjb4np9mp0lScoDTC5iXd9sD0C0HKWEfPcM0Hff
 6ooRRr8xOLurGkTDVIkZv89PB8/WlSPwClATvc/wv/kxJrjbd7yt98lG0egtfItfEN/aQvzoo5V
 j20fw
X-Gm-Gg: ASbGnctf9dIXgalAS74hRY961J+0ch9nXFv/DsfyY4R2FRMya6MNlOSA0UkBs0yLJcD
 PPu+xkrxL+F0RV7AQva2fdcfL9hdWZBJUXwTMw1CM7A/tpmI7gq5H+8A+iN2Q092jFWExUNMqpt
 kuGnsoW+Q1ikHcnx1zDPm2e3NMOCIs/ZGXtRWhruy6uWqDX/RaRbrFipR03ue48Iy/huIANa6KA
 Olc0QfR6mP9UBqrMJC2t6zJy74itjSeiTuoA4MAx5uHt36CA5xLHEdEeSX2V8QYNC8xZFoha/4A
 Xd4Tch0Fc/I8h16DaIdwhinJj/XLAKZboRxFYS8biHmJvwT+/z8XzN8GNQP7EbibULZLuMofXj9
 CZ5p1PNNm0jhs7UvUaLbmDxRo09KotoRdul6+CgP1htRk8ZMrkMw=
X-Google-Smtp-Source: AGHT+IGsKDInK2ccFTfoie5D51Tv1FZhwIpS44Lbkia1zv9a84WOfQ1nKLmpMMVxKbwU55YDpTBVJQ==
X-Received: by 2002:a05:6000:2584:b0:3b7:9477:f4ad with SMTP id
 ffacd0b85a97d-3b8f41ab697mr6198076f8f.36.1754577681369; 
 Thu, 07 Aug 2025 07:41:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3c4d02sm26313399f8f.33.2025.08.07.07.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:41:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 15:41:18 +0100
Subject: [PATCH v2] pinctrl: rzg2l: Variable may not have been assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_renesas-v2-1-5453d989573e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAA27lGgC/3WNQQrCMBBFryKzNpJEq8GV95AiSTptB2pSZkpRS
 u9u2r3L9z+Pt4AgEwrcDwswziSUUwF7PEDsfepQUVMYrLaVdvqmRkpx4uHFmFC8qHBxzjhstQl
 nKFbwgiqwT7HfvLeXCXk7RsaWPnvqWRfuSabM3708m239H5mNMkpXlY94tdE08TFQ8pxPmTuo1
 3X9Ado0hePIAAAA
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Tom Rini <trini@konsulko.com>
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

In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
rzg2l_selector_decode fails then the variable pin may not have been
assigned to. Remove the use of pin from the error message. Also update
the error message to show the invalid selector used instead of port
which will be the error code returned.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Replace port in the error message with the selector used that is wrong
- Link to v1: https://lore.kernel.org/r/20250807-pinctrl_renesas-v1-1-055ace62c1dc@linaro.org
---
 drivers/pinctrl/renesas/rzg2l-pfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index 3c751e9473a..4a75e0b2372 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -353,7 +353,7 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		/* The pin selector refers to a multiplexed pin */
 		int port = rzg2l_selector_decode(data, pin_selector, &pin);
 		if (port < 0) {
-			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+			dev_err(dev, "Invalid pin selector %u\n", pin_selector);
 			return port;
 		}
 
@@ -550,7 +550,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
 
 	port = rzg2l_selector_decode(data, selector, &pin);
 	if (port < 0) {
-		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+		dev_err(dev, "Invalid pin selector %u\n", selector);
 		return port;
 	}
 

---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pinctrl_renesas-b48818ef01b3

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

