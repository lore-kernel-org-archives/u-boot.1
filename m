Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C09CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B211783893;
	Fri,  3 Oct 2025 21:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JYtOFjiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02ACF838AE; Fri,  3 Oct 2025 21:20:06 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF37783893
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-91524f5e6a8so224209439f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519202; x=1760124002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnZZ3dffgOidngzJZRrHGORRZf5auGxqLDSJH7a6oG8=;
 b=JYtOFjiZD6tg6aA5xccpyKBYwC92nKKu0p2UA5rdTmAJ8HCb6TW3Te3nHsSqTO6yHV
 2anLDnf3TaM4Razn2L1xwgrXQECu3IYn2EaqHtKxksRODjjvDN4gbk8IiRY0IblXz+ll
 Rjq7q77OkZtLYuNNN8OhKUM8uomcSRl+70Uxdc4Eb8bVqeog8ex1CVUMXHapmTABITmD
 eQT5kAg3H2EU20wUuz9gPAABK0E6WWUYTCujd054c7aBaBy2ordHg/XcZFHL6sLG/A6+
 MwJg3pXAVee3GaMl/7mzNoFuTh0gCG2imV3X0+nugu/TkPHpEzbdlmnO/hcL5A0Vja3+
 eiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519202; x=1760124002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnZZ3dffgOidngzJZRrHGORRZf5auGxqLDSJH7a6oG8=;
 b=XJTo3G/jvnYLGv3T3TTs7Ud1F2+fZaMmStAcLkEp/Tf8m9tuZRcjo6oGMFA0dlyNWj
 mRzmEcWGOx6JDW1BDPwEH1e/Ldgg0h6zcGGCH0VN0BJG2s9AHr2aNbaWrge7MvQPpOIE
 2Kanvx/DXevL5kk6N9Cy5wUR22t7B4yRCIrrqKCNbIfiT6Ea0HheG2FcUXtBVkUQxVKe
 sLp5dHZ8isFpGOci0O3IJsAb0ZfakPjaPsNTI8/rSAoA3rpL1OF4yjBZoN5TcAMURgrg
 RKhf6xaMGvdGOCmeBN0uwdIxLKIU7KcYhvSSeZRIZX+C+0wyIpHFiAaJpUKHJHz1xQjr
 kkMw==
X-Gm-Message-State: AOJu0Yxo/kbv3dD6H0byp4k0+ca1AQpVHbm/TFXNln0l/7TI4U0tJsmx
 2t9hFF498OD4mzz/SnRa5EAKoF9Own4kWb7Kn+0n5tVs28krwjFbcKK6vvG//YsAqlAn1tSnXgK
 vDTLw
X-Gm-Gg: ASbGnct9oQyUe/QVwLaf+cyGxrHX8z3CrUWZa+dfGtkdqGhEfu1YJ0ktWgwWaghrGWF
 baJtpMqHTTm0QwEYc1TFcUUvhQ5SRv40Q0LBuX3L0I9BFQQpXQHQndo26PQB8Jtk9p9hnZO6Jrt
 eZhpI92R/Bkouluww9TWmZER40qoqc4N9a8B/RcLKklDD2j6Fhfsvlo77K3plQxqLD70bz+Jd4n
 /SluPk/JAZG7taPPuBaimlsdTtg6VwGxPwbcyyKiRbDu5Wau+XkgVJV3ujYF4/NHkAMBp+f3cWq
 Kh2nNhy6x9jTjg89P7qGUZ5fJ6GGV6qR8AVIjqa8q9OQI1Kbx1JR7bd31PW5NbuGzzXsoIS7PWo
 Uc1Tk32VHH7CSnsh7BFvpccZkpscFD5enNyqxEFH+4m2iBiSejQ1K1dY9h2gfTvBDPShrDtR/cg
 OM5wPXDUCl
X-Google-Smtp-Source: AGHT+IFQoU9JGxd0c8JqsopjPwItGmiNTOW2NSZ1Jyc+QFeTTTkPHwZyljMVypxcLAPI0vaNtfJptQ==
X-Received: by 2002:a05:6602:1653:b0:913:34eb:5562 with SMTP id
 ca18e2360f4ac-93b96534104mr529133439f.0.1759519202127; 
 Fri, 03 Oct 2025 12:20:02 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a8912bfd9sm213794139f.25.2025.10.03.12.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:20:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH u-boot-test-hooks 4/4] travis-ci: Introduce env for Firmware
 Handoff testing
Date: Fri,  3 Oct 2025 12:19:13 -0700
Message-Id: <20251003191918.767698-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003191918.767698-1-raymond.mao@linaro.org>
References: <20251003191918.767698-1-raymond.mao@linaro.org>
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

Introduce board env for Firmware Handoff testing and enable it on
qemu_arm64_fw_handoff_tfa_optee.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .../u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py         | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py

diff --git a/py/travis-ci/u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py b/py/travis-ci/u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py
new file mode 100644
index 0000000..8f1d5c8
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py
@@ -0,0 +1,3 @@
+import os
+
+env__firmware_handoff_enabled = True
-- 
2.25.1

