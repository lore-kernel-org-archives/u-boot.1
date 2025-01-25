Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F694C0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 19:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A9F80F0B;
	Sat, 25 Jan 2025 20:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Wf8URrjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FED80EC0; Sat, 25 Jan 2025 20:59:31 +0100 (CET)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01B880EF4
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737835166; x=1738094366;
 bh=51iehHOcX1WQcQTDRkJxafWBFbjxPzfUvDL8Y8OTTUA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Wf8URrjHSVtl5yIRne3c51hPF2GR67odrUK4pXA/s/2LPPr16uhNQj0OMDXnyN4K1
 KVBlORJVBrPWOtMEZDUJIZjjRVIxX16+Z2UKMF8KIto838IJ0uimjlg8BWknkcX/eb
 n4TVWYNtBHbbGoK3ZOqFITV28XBF1gPhttnA16f7BQQ5r6GhfizpBgTdhiyNOTk0eg
 3EdeFxeowyFoOVgLHcuspurzVd7A7A0Lk5LAfxpZKOu3NOTRcf+K8A7eETYdKQbemt
 DZUwXrJ6F3xKI9CwvG/qBPzc2dXyhbS1yKFG+8a5Hm9IBlINQIK/7vQnmOFoY2x2NN
 WOfMuKuxyJUMA==
Date: Sat, 25 Jan 2025 19:59:20 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 2/3] sysreset: qcom-pshold: remove ARCH_IPQ40XX dependency
Message-ID: <20250125-msm8916-sysreset-v1-2-62073932ff0e@samcday.com>
In-Reply-To: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
References: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 3f85b92555a8b0de4c75d597da396eb9db3fb9cd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Depending on ARCH_IPQ40XX is too restrictive, as this architecture is
explicitly armv7. This driver is also used on msm8916 devices, which
have cortex-a53 armv8 cores.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/sysreset/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 121194e4418f48012c28fa3a4d7da174d3359f54..475540ffac766a302d994372ac9=
65d4d94dd4708 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -242,7 +242,6 @@ config SYSRESET_RAA215300
=20
 config SYSRESET_QCOM_PSHOLD
 =09bool "Support sysreset for Qualcomm SoCs via PSHOLD"
-=09depends on ARCH_IPQ40XX
 =09help
 =09  Add support for the system reboot on Qualcomm SoCs via PSHOLD.
=20

--=20
2.47.1


