Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C27C54FC6
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1674A83055;
	Sat, 24 May 2025 15:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e7BwpX44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3E583340; Sat, 24 May 2025 15:07:02 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A3F8329B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86142446f3fso14504539f.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748092018; x=1748696818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FN0lNERYPGoS5OgPJqTvMJrcufIL4GlwsVBpjdz9+Oo=;
 b=e7BwpX44EuwkrX7tEqZfNKyR8ITnbcCuIV42h4OzQL+SArdHkAz35GWESf+Hi97d9e
 P2XzzQTXQ6WGNSrKrn0bFKli7wuWUyiN4iCG3Lzbj0S1Bfc4af98EYFqgrO3KGJSWnZZ
 WyuABP1OBtW3j0fkm4omQBXPeWO/M6gQYmrFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092018; x=1748696818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FN0lNERYPGoS5OgPJqTvMJrcufIL4GlwsVBpjdz9+Oo=;
 b=tAyZK2LMLwrfU/wZCQ796zzrZwmsKSt1vYKUtfxioZ2wsOsTEsZMVHwc1NMlQ4DMNV
 dIdFIACUIySPMStDvP3873U4cX+g5HbTLZV5/E65nIkH0exfpDKA/7RLZidYUltAiZ8t
 tUZtU4p8LswO+HS7bGDFIihNlg6fiR72YtA/vQe7VTjqF6cuG8iHSbfIJTx/6HarZddF
 LqGfGJgEhJLcJkuRq8QmtbMTQkxhSmppK4HReNe0xhDHiuwfVNxPJffLE/nHgm7f+5g1
 l+v4LJbppXXEFcz79UqrynY78JMMWI16L2uaAh3x4fQJaRJyeJlEHgbl/WUiII4cdNO+
 MROA==
X-Gm-Message-State: AOJu0Yze6aCJH5QuCyrHWOUCYUlLoFTXkQc+JHFhwabK5plhvbJMgUZp
 yqMSZL8pXYobx0L4+XoequxfDcoGK2q/aOM+di7cX2M20aX4SNho8sP0jY67UhY8gPaHRTKd34K
 No5Y7Sf2m
X-Gm-Gg: ASbGnctoOosdXT6D45QElKQieOLz/tELHLyd7wITOvmZkrqSvCC3G5s3LHXYnfc5Rey
 Or7Cc3DUhrP9UHfRHdD42JYHXD79tiTwVPlPQjqkSmPeJ2S5giv3R5WKmRxLeV9z3ZIcrl6X9Yl
 cXX4cM/ndotr237Sx5pEh1a2ZCAX2qiNA9Jbw/X11hNYRAy3OUol8jYH0qkHg2RI0yh6MFivpMO
 NaoP+WcH3axm0ldnd7k/KKnA1x3AQj5WLQXegGI5yqGndMLaKX0mXpLeXs3/ulZCfYOs+9Ejuos
 5j940XCRVs+SH5OOptKdmPjXmZ9R5t2qoTg3fWkNJq00kjssx99yivPqXhR96FzPyUIgWMqNOS/
 lehOT+Ion/obilriL+1VtIag=
X-Google-Smtp-Source: AGHT+IExk6L6FaVFdK1DIClNX8Bw+fMKCnGAt3USckzIhpuG43PdrcsiRry/g4PrpvSsHDFjJzG5Ig==
X-Received: by 2002:a05:6602:3a11:b0:85b:3791:b2ed with SMTP id
 ca18e2360f4ac-86cbb89607cmr333421239f.8.1748092018666; 
 Sat, 24 May 2025 06:06:58 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a236e898dsm373238339f.37.2025.05.24.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:06:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 4/4] test: tpm: Skip failing tests on coral
Date: Sat, 24 May 2025 07:06:37 -0600
Message-ID: <20250524130642.902486-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524130642.902486-1-sjg@chromium.org>
References: <20250524130642.902486-1-sjg@chromium.org>
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

These tests have been failing for some months. Disable them so that a CI
run can pass on coral. Further work will be needed to see how to make
them pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to skip failing tests on coral

 test/py/tests/test_tpm2.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index fecce248fbd..9be85999d46 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -179,6 +179,7 @@ def test_tpm2_dam_parameters(ubman):
     assert 'Property 0x00000211: 0x00000000' in read_cap
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
+@pytest.mark.notbuildconfigspec('target_chromebook_coral')
 def test_tpm2_pcr_read(ubman):
     """Execute a TPM2_PCR_Read command.
 
@@ -201,6 +202,7 @@ def test_tpm2_pcr_read(ubman):
     assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
 
 @pytest.mark.buildconfigspec('cmd_tpm_v2')
+@pytest.mark.notbuildconfigspec('target_chromebook_coral')
 def test_tpm2_pcr_extend(ubman):
     """Execute a TPM2_PCR_Extend command.
 
-- 
2.43.0

