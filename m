Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D78C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30884440;
	Thu,  7 Aug 2025 10:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RFbKgdJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFB78440E; Thu,  7 Aug 2025 10:08:30 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CC68440A
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso4018285e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754554107; x=1755158907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WABALEPv4gaEl26WXMvsoTwnlwEpSzyjN9OPL3WMXZY=;
 b=RFbKgdJ/rQy5/UfGZLTyCt1izMM3FAYE2GbbID1AGYlMapWGzV/LVC0aIpLbYPoMcP
 K1Hal+wYxyo6+5FY2jpfG0YB6pdyCrsIBq593J/6CIP5d/+6w8eiQ3UWz5pmKiAbtqw8
 NIyTpwVEaZVeEz3KliM5PcHz3f+yTvIAoDEIJT5x/9tgjzoj0Y+tXnM+Zo7KNIUwnPVw
 j/jOZOuNZkUIiONdwge2ZiS0py1YzPdvXkzCZLQ0EltK2r9nS0gXod7cF/Y9q89F8T1x
 p/clHr1V/9vP7bRVQru2te/YA/mKA9jZsEMS1t2Aka3lrT1qDddFQV7BbMtssBdmwNoT
 zk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754554107; x=1755158907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WABALEPv4gaEl26WXMvsoTwnlwEpSzyjN9OPL3WMXZY=;
 b=QajxNI9NDkev/rV1q5xon5XKIHvfpFDbdTPyuEjRsgOYFmxmXdzpulOjwLFwzjTrHb
 6JjC3qYZ43Bqc985x/4kdOJ15aYuOAvGDNwzK5kAhdEC0ZhRQjATk0nT4mXzlXeL0BfW
 OlYQkK3QWrn263YAW3PwwERItSyC62MR17Sg82H0BXyo2i2g9VQlNPFN7rHXjr6BqOfP
 83PYP3t8dmrKz37kP9kqf7+womzEi650S7aPDfmY5dp+MQ8/C1NsHBOgS6ac6SHkGktX
 8oiDvniOgJo0TkNnK13vPSTRDOuhCyYZEgO+mu+CTuxVjEPKu24QKwYCG5QwBTMACZeJ
 5Tmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw08ChQ8udDUkKe6MgwjV/AOS6gLXRAt8I1kHCRHVJH0dtz9SGMmWXYz2u2dPIWN/HmEnYWtA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxth6GH4GcPP92ILmsHptUPmnSPx8Ys+bQN09SnGzYchqg0ujgt
 /5JTqegPuLqfiVOHGurTNKxEYiXwBac3mUyk9XZqHrIu6ku8gNf/LGEpkVqqSBl1Rc0=
X-Gm-Gg: ASbGncv63AdP0BqKGh9FtetXuSnUlPPrJdM/3H3iiO0d9AKEYtGbU13xZSCBr6P3Z1V
 fVNR8wNQ/CGG2R/MUkLlD6wZbQu8V6iRUb97wizKloHoBy7cLp9VsH8ckF7m0lBKqtF4CD2heKW
 Qyr98yVD6Jpxss98CB/EKXY8556QxUgVXrU8i4RxVuOR9uLi8mv1qpUpmgnTPSLM6b2NMEhTfFB
 OlHWJsx+Z7SJqTpJLsIW5xOiokjXnyTDp24ZOnKLioBl1LZ/XleToan5p1Hvok29iyeKaLjTIWD
 Gs7LVVic91tqikrCN3wR7VwEhN0k0Bgb4mmlTmW4cRhnDxKsg15pwNYvw2nD5CICqbxBchCedGF
 38DV3aKfv70ClL+tzgVAMdLXGzQ5L4yla0wGQ1p4jT1iOgZRJ/rWgpDc=
X-Google-Smtp-Source: AGHT+IE+L3F+iEABERJuEHT5d40/tfqSpSA3EpyAaUIlXaGO1x5BVnRLNKhsAaHPNF6kK1dFMvpqAw==
X-Received: by 2002:a05:600c:4e87:b0:459:e06b:afb4 with SMTP id
 5b1f17b1804b1-459e7080202mr54653755e9.4.1754554106641; 
 Thu, 07 Aug 2025 01:08:26 -0700 (PDT)
Received: from hera.. (ppp089210243039.access.hol.gr. [89.210.243.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eff7918csm13639665e9.25.2025.08.07.01.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 01:08:26 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 3/4] test/py: Fix race conditions on EFI capsule tests
Date: Thu,  7 Aug 2025 11:08:16 +0300
Message-ID: <20250807080819.1058411-3-ilias.apalodimas@linaro.org>
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

efi_capsule_data() is called in each of the EFI tests to create and
setup the files we need. However, it also recreates the spi.bin file
that holds the SPI flash contents we rely on for the test validation.

This leads to weird errors since reading from the flash returns 0,
instead of the expected value if the file has been recreated.

Always restart our sandbox instance if the files are recreated.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_capsule/conftest.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index 961d2e0b3c19..45c06c42fd2e 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -103,6 +103,7 @@ def efi_capsule_data(request, ubman):
         pytest.skip('Setup failed: %s' % exception.cmd)
         return
     else:
+        ubman.restart_uboot()
         yield image_path
     finally:
         call('rm -rf %s' % mnt_point, shell=True)
-- 
2.49.0

