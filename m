Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2FC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191D68442C;
	Thu,  7 Aug 2025 10:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="egaKucDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30AAD83AFD; Thu,  7 Aug 2025 10:08:28 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE5A83C53
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so6262495e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754554105; x=1755158905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQtaBUaQYTU3Urv2X6hdNjnEG4YDAXSyqMVodoJoSWA=;
 b=egaKucDj8EL14toSRK8+VornEys5RROYYG1PN7xG9Znc0M/ovwrfjyl5GmdvrCoJ9k
 Wsdo1bNlB02v9vbrFPTUOvlOC8jNjYa4nRHx6HkD1KMkFuahH0rIIQqgAz10HatwBqEd
 d3o5N1cmAeVjyVrsM5ImMz+ennLELMnWNUnWzH3rLsv7CgOmQVfU4u4ehLuahv2o4Bks
 pZ3A9448BfRgosr21eA+iY5VaGo6OzWLoqm9tjo/lvOTwG8XhYEULGlrgfvpX6uS/zXu
 KHAemOle0DKpwrnkLa/xLxlK4P/L/CxZY1ORaF3icwQZYaPhQ1/N6yRLxP3SX6WftjGD
 ZYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754554105; x=1755158905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQtaBUaQYTU3Urv2X6hdNjnEG4YDAXSyqMVodoJoSWA=;
 b=UcqzMWNf8QqwJ3/5/XiWka3PPZAR4+UP6CZsD1DAWccSDwGZJpdm2+Z0HcjXo2dbmz
 77GSYWdyjAlKUvXr1XfHFLR68iu2dWDFKsk3n83GOj+YkvOxTpT9sgMdor1VgVOJK5SM
 AcFXDEp1cgupe3bg8vHoHUKMUVAONsx0S7Qt0F/Y2oEqWQAM7miHMJwcqrgvH/j0s4wF
 DhmmBA6AICTJCL79hxzFTvY9b3PYWUNW4bC89KY2QWJQdzTuroECk1LhXOaHKsusPvGR
 3PuRh1TtF9J7f5xnCG66vJQ1qcvgH5HYT4hVW07/puTyVKSTyPvaqQ4GGh9JQf93y1ur
 mDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjVctvnSa9BXw2Xyhsf++HVyL4tfLE8GaAhQX3e1Og7B61wetFlUkrnxobiFdOzV5Hv6EogYA=@lists.denx.de
X-Gm-Message-State: AOJu0YzH0jyFsJjR8z9cJSUSWtaaV12+6zZUM/yC6Cwb4P75X7YAdUM3
 uAVX1cKSRp/owqIKo1+OHjsrd93fDlRAi/Jj89XjfsNYFpsgFzuEzhguuO40KaplB5o=
X-Gm-Gg: ASbGncuHYpPMJ09QP9kpX9YURf/bql95jtBDdzbmHhEAiCysDozWnlGuUgip2AdREE4
 vXAK4QRiwsh5HOdA71nr5f/zamJvy+BbK2cCjf8MMThbOoZZXMbF9nxagHRFLc26fFfyoWWlX9+
 x9s5U6XZfi7gzlIrghl5bincNs5XY+OU7szhiiY5XiGCyZn/Jvl+f6pzmsK6kcLhaPbpi+H4XoA
 VXjKrCtn40dSZvpRwKrDukh/C67TEJjlsEUKmTg2ddVd1Iu7/IwfSoujAX20xa3wjg9kS9te9js
 3PfsgRgZunC0nEwHwNQWb6zVorLI/SlMtLXuq4G+G0XDPw41Ps2zLd10FXuSdVr70S2V+MaeRW+
 nk9ehRaIPXEnhgMjiQ/H+kXyFReTVFGiu90OAMxiBY+d4T0aj5aF2ZZM=
X-Google-Smtp-Source: AGHT+IFh8NISBZvoHIUCB2bwa3+R/NHZ6qPEGle89T7e5htezR75yiLMhsCmTwFA97FemiJJIUQ9jQ==
X-Received: by 2002:a05:600c:1ca0:b0:459:d8c2:80b2 with SMTP id
 5b1f17b1804b1-459e7415e9cmr51666555e9.7.1754554105014; 
 Thu, 07 Aug 2025 01:08:25 -0700 (PDT)
Received: from hera.. (ppp089210243039.access.hol.gr. [89.210.243.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eff7918csm13639665e9.25.2025.08.07.01.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 01:08:24 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 2/4] test/py: Read from the correct offset when initializing
 capsules
Date: Thu,  7 Aug 2025 11:08:15 +0300
Message-ID: <20250807080819.1058411-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
References: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The current code writes values to a flash offset defined by a function
argument. However, when reading it back we always read from a static
offset. Adjust the reads to use the correct offset.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_capsule/capsule_common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
index 8c66411929e8..8aaddfc19d6b 100644
--- a/test/py/tests/test_efi_capsule/capsule_common.py
+++ b/test/py/tests/test_efi_capsule/capsule_common.py
@@ -42,7 +42,7 @@ def init_content(ubman, target, filename, expected):
         'sf probe 0:0',
         f'fatload host 0:1 4000000 {CAPSULE_DATA_DIR}/{filename}',
         f'sf write 4000000 {target} 10',
-        'sf read 5000000 100000 10',
+        f'sf read 5000000 {target} 10',
         'md.b 5000000 10'])
     assert expected in ''.join(output)
 
-- 
2.49.0

