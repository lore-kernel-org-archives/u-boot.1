Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7236BC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 22:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB4882C4C;
	Tue, 17 Jun 2025 00:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I4pDfkPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D115982B18; Tue, 17 Jun 2025 00:09:43 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BDB982B18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 00:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-042.46.114.pool.telefonica.de
 [46.114.105.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 973053F942; 
 Mon, 16 Jun 2025 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750111778;
 bh=7gttBqZ4NxRGfpTwdHMrhTxFZLWFHCQaKvlcpdo7kks=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=I4pDfkPIm1E3wBGczkQ19VH2ePYImsMXd8sHsLUwjylPWaDIN5Nb6HwHk7cZjmLeM
 XfDnL0U7rSwRxvpucROk67YyYGsxNGt7uRKBfLslnSshPWcEj0rokgeiAiMLRnlfGc
 IC+zQpJ0My7EgsV/KOKMScFyzdWWN6sJ/zIRkhtKXsDIVhwIwTRzz7unhQOfnY8pp6
 oRGt1/acRFyg1d3mk5oYnj5GXUay/GvtDzzHm2Ujn29qYcWxKl7McbRBTamjnEDZsG
 QqiOFX6+aHxMOElng/VBzxehBQnE7QRVn2cmL5wyxa8v2ARHeis6SBG7VFoOQDXUJl
 L16Ci5ze2HLNQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] test: disable TCG test on sandbox
Date: Tue, 17 Jun 2025 00:09:16 +0200
Message-ID: <20250616220917.34189-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
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

The TPM emulation on the sandbox is incomplete.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_efi_selftest.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
index 12cbe5caa9b..58dac72fd40 100644
--- a/test/py/tests/test_efi_selftest.py
+++ b/test/py/tests/test_efi_selftest.py
@@ -179,6 +179,7 @@ def test_efi_selftest_text_input_ex(ubman):
 
 @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
 @pytest.mark.buildconfigspec('efi_tcg2_protocol')
+@pytest.mark.notbuildconfigspec('sandbox')
 def test_efi_selftest_tcg2(ubman):
     """Test the EFI_TCG2 PROTOCOL
 
-- 
2.48.1

