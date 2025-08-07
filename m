Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E218C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BFE843E3;
	Thu,  7 Aug 2025 10:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qekfQoTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A57D8444D; Thu,  7 Aug 2025 10:08:32 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910FD843E3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so6101335e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754554109; x=1755158909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhSjQjTSY3mNXEpvt5cMv9wpWeQjTJ3j6BBlIDQwnYU=;
 b=qekfQoTwiTcYwSUtbev7ofASFY1K23CArykk/tvK84z9U6AN/YxEkoa4VDfbETLgC/
 gaONKSM7APQP14mBJiZrzhOFuwzBtHyR8yoCnCryVeykSqltRzOD8xIK3sen8s4VBzJ2
 VEFML/Llkx27rKVtisN8g4IrDUnfqPHiRVWMdZeb2qAFO7e+pnFuzfQVAHE6ouVqJxGq
 /qdPk7r4fJFDkpz8bsAYkuWXh9vcS94nhO76+x1gxey8Op2xzrKADvuxz5ZzoKigGNDd
 2rhGqw/Iv8PrCHnZalOHjMCLVpepVUvrOfmqivw4O2EH69IzON7WYyC5TJZwPnhokg3/
 DYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754554109; x=1755158909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhSjQjTSY3mNXEpvt5cMv9wpWeQjTJ3j6BBlIDQwnYU=;
 b=QWuX9K52XDrh0Ck0ToVxiAdWNnt+ItD4HvjXLfbGPzD9WwbCNF5oozNWdzU5eIjb1J
 aA2S33vlr5fwDZyJ4piX4cp+LqP9bVsnUlQkuF/Kl/g9R9rHLUvcc3TiVB1k+YjnDJUo
 jHPXPTkbHM7AQc/RGyikBEPmQ3VZHig0s+AaQq7G0aPPxPqoLVxrv5YpyPnkmbJcDQS3
 Lf21hRXMhjDIbCDflMmfXnUaSFmeoXpTqBBBZxsEBj9hfozTueqOwPM0aMCDjAqlMGiD
 /YYYYtEMyj+4yw8uG353BCd/NgbaWPX6Re1XTLFxeEo1275DSF2RIppisiUHBLBad6gp
 BqVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRS6XDq8+AA6RyFVJ3CaFwcrTyvoHgl7403dB3pu7OozYR3eb1wo16j1YGSD/syimcwXssm4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5YHCEyatODVMLtiPQCqlWFyAsAk4e7vHXsUv8P/mRUWKGwvnm
 nz96p5KEfzpCrEONWU1vtRqmB2IOW0dnafLnhry/dMDIQ7ESASQyZ1GDEdrkkgzKuXA=
X-Gm-Gg: ASbGncsQU1Da24OAiMBHw0eVBV1OWX6XfbtdUIWaIaPe+HI0Y4LGKJxsZ2ryNR/nUBa
 PzxM3c3lQwf8A0IsQJrYg38IAF0yF6xAeuCRqK6W5n+wknmR0jDxZL+f8DfNy9UlbuPp9n8JbSS
 4og+7ExyJPV8q8SNj+GlNJ6lP9gwS82fDKH/q1B2MGSaX0oBYyliVxdhcg0eGtaILEImDVPUoGb
 YNmhwdT1PZA+Z+IZoB2Q2zv1NzwZDKPXnOx8ZlTr66ylGzPq0k/uSTXT7qB5cQfrmqnX40yoSli
 rrEILrWEjh8r+Tcqhd6UwBJcMnWXKbMcuHOa4pV0Jdxd61uknuMyjtZJXvAd6a3E+T0V0gekTuQ
 2h6Ojcf1GL9178tFhC/etVmL3G3bRxo6VBSPftukZ/1YHMVfb3jRLMr4XP8pOe9RsOQ==
X-Google-Smtp-Source: AGHT+IFQCzKT0iNfGavHFAaxhGfyVpa6obHtwPKo8Dou3jCjc2vZ3kdGeE2DmkH/e5nts8O8r/oDFQ==
X-Received: by 2002:a05:600c:1994:b0:456:214f:f78d with SMTP id
 5b1f17b1804b1-459e70d8115mr46751235e9.22.1754554108220; 
 Thu, 07 Aug 2025 01:08:28 -0700 (PDT)
Received: from hera.. (ppp089210243039.access.hol.gr. [89.210.243.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eff7918csm13639665e9.25.2025.08.07.01.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 01:08:27 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 4/4] test/py: Fix capsule update tests
Date: Thu,  7 Aug 2025 11:08:17 +0300
Message-ID: <20250807080819.1058411-4-ilias.apalodimas@linaro.org>
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

Capsule updates tests have been skipped since
commit 659f97eb1fc3 ("scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file")

Remove that check since it's not needed anymore and re-enable the tests.

Fixes: 659f97eb1fc3 ("scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_capsule/conftest.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 45c06c42fd2e..ad0cda59ebf4 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -44,8 +44,6 @@ def efi_capsule_data(request, ubman):
                        % (key_dir, data_dir), shell=True)
             check_call('cp %s/capsule_pub_key_good.crt %s/SIGNER.crt'
                        % (key_dir, data_dir), shell=True)
-            check_call('cp %s/capsule_pub_esl_good.esl %s/SIGNER.esl'
-                       % (key_dir, data_dir), shell=True)

             check_call('cp %s/capsule_priv_key_bad.key %s/SIGNER2.key'
                        % (key_dir, data_dir), shell=True)
--
2.49.0

