Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F46C369A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 00:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB85838BD;
	Thu, 10 Apr 2025 02:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ly3FzB3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB61838D7; Thu, 10 Apr 2025 02:31:29 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA74838BA
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 02:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6044db51b5bso146844eaf.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744245084; x=1744849884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7F0ahkcz/5AYBkR3XJ5Q0uHiiB1WOoLdcFlUsVPcTR0=;
 b=ly3FzB3CpfE5dGjqqrHVaSxjfPD4E3FVcxo2Bmu0A8QpMQk6XByj1EC/P4G9Ezj9eP
 jbpTtTu5EBP/mcJcPy3MZc7T9BLCYtAM0rEy+kpQ+Ahqnl9AmIWyiza0wrMJHlkYAmP3
 szyWRlGmJV0jUz3NfnuGLc1aJAX9aJLoBsLWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744245084; x=1744849884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7F0ahkcz/5AYBkR3XJ5Q0uHiiB1WOoLdcFlUsVPcTR0=;
 b=ToblRvc4wA1XRN6cfPjM/tDktpiFMdQdQZkZWADF+iMkQ4sa/jOcjgUfVAHpBFhjk7
 v2mPthoftLQXxoNNkxsgfYuzsbQ1eN19NqKBY1EbLIxauyNpzHAXasMEajiOE8h2SGwn
 iJDWbP4+lT96Mc/OwoWFT40Uh5BjYCjO1Ig706NM8lxQ4Ig/SF+qmCbWoCkRGqzNeOCO
 lxQtzucS4WCBRcLUwU3fFaiqSNTsxS5dX8vHfmwUgpLhcHDznrAKavcaQ0TT34KAON+5
 PdAY6vLslDjPViaMSVyuZWd7N6ozOslY8/3w7oZdZIJklhoCaeUd95fkIlKThel/sCQS
 zLzA==
X-Gm-Message-State: AOJu0YyDWRKtQCmbi23khGea3qtvuYbKiRVWRcX2RFxLep97+BRclRT4
 OvrLDONTUPQWQs9/bLcqrVvRR6cMweiR7b+UrT7p0VCthtp7O5beilJ88SRUKypx2OqyyowVjyS
 8
X-Gm-Gg: ASbGncug/Qz9rnm9UuJk/a3QlbMZTsVmsZm5WRlh1HKsFxvK9JSNWu77Wyb+2Dd14zt
 XhDRVHT9TeDmrLdgX/T+H8eVsdEPx2BsKHIJ+8ne6GDA8S63pMcDWxE+zomiDe5zpvLksT2PqyZ
 AKO73G5N5Yc6VIhsM6ABQPmGf3lKo4Tdp8AGKeXavjBU3ipcoKEun13A7wjmEru3ChvHY6oU0EL
 p58Prr6lHN86e+2NHJHpquskLjw1OIA8sbWzvw2uFbMdtRNZcF6tKy92JYOu0rW5KnHOTfGDGXV
 m1/lh1MzbWqnE2+Ccg9d5wkn1vpDRgSskvgR8aMvXWHoXbbeXZmZdVREE7V90KvDYD//a+W/u2o
 u3pzr
X-Google-Smtp-Source: AGHT+IHZAJjjjqfRa0N0CFIj8c/N1gx8orBFTpBWM8XsH0IbiZbU8eb7us7rkpSHY7unjiX99J1bKA==
X-Received: by 2002:a05:6820:1514:b0:604:1:3736 with SMTP id
 006d021491bc7-60466c65945mr147543eaf.7.1744245084128; 
 Wed, 09 Apr 2025 17:31:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f5a01e8sm366815eaf.31.2025.04.09.17.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 17:31:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH] CI: Disable evb-ast2600
Date: Wed,  9 Apr 2025 18:31:21 -0600
Message-ID: <20250410003121.1818656-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Currently, this platform is failing in CI due to seemingly platform
specific reasons. For now, remove it from CI until the maintainers have
a chance to look in to it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
While it's poor form to apply changes quickly after posting, this has
been reported by 3 separate custodians having CI fail due to this change
being triggered in their tree. I will be applying this shortly to
unblock others.
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 .azure-pipelines.yml | 4 ----
 .gitlab-ci.yml       | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d5cfa59a8a61..7a33d403a77c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -420,10 +420,6 @@ stages:
           TEST_PY_BD: "evb-ast2500"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        evb_ast2600:
-          TEST_PY_BD: "evb-ast2600"
-          TEST_PY_ID: "--id qemu"
-          TEST_PY_TEST_SPEC: "not sleep"
         vexpress_ca9x4:
           TEST_PY_BD: "vexpress_ca9x4"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0f27e67abb99..42ec28a9ad8b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -328,13 +328,6 @@ evb-ast2500 test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-evb-ast2600 test.py:
-  variables:
-    TEST_PY_BD: "evb-ast2600"
-    TEST_PY_TEST_SPEC: "not sleep"
-    TEST_PY_ID: "--id qemu"
-  <<: *buildman_and_testpy_dfn
-
 sandbox_flattree test.py:
   tags:
     - ${DEFAULT_AMD64_TAG}
-- 
2.43.0

