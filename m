Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4EBC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 19:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C6780EB5;
	Sat, 25 Jan 2025 20:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="o5rMx+Tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F64B80EC0; Sat, 25 Jan 2025 20:59:19 +0100 (CET)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8199480C7E
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737835154; x=1738094354;
 bh=c/KBaA65JQTyCG3ma+JvTmROsr5lSCTyGCRTSyjXWzQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=o5rMx+TfccO75nIRHCZjgoKJe2d1pLz5EpgrnySynNis5DUjVeGqL31lmq7QI0gZF
 kl8sSZpjXcZM+kllH9hWPJ/jPbaw6VGb3VfyttEqa+XFRKPsY4B3RJpYCw3OGM9xaz
 t292woPUfNz97PnkX9PDNZLyfgyYjrBk2HUYR9Lr8Pvbk2tTHawUHPi6mJnj4ipmjS
 OOS+k1hDNR53VBDsXO7rnSzaskCybP0LPz7rasKPfud2dV94Klv+tugCgCvZW45Fdi
 JlU1AhgAaqodV7ZDUu5dRhD131d6jxrbSt4gAv0VwWZwWeQTS6YuyPB5NbQ7Yh2PNk
 QYFX3Xo7fPDMQ==
Date: Sat, 25 Jan 2025 19:59:11 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 0/3] qcom: MSM8916 sysreset support
Message-ID: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 86f726746597d1c30e45d4dd3f009a68d26f6a1a
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

Most MSM8916 devices shipped without PSCI support in their TZ firmware.
Instead, they use PSHOLD. These patches enable both PSCI and PSHOLD
sysreset drivers in qcom_defconfig.

Caleb had already submitted ([1]) a patch to do the switch to PSCI
sysreset driver as part of the UEFI capsule update series, but it seems
that the sysreset patch didn't make it upstream.

It's worth noting that sysreset still won't work if booting with a control =
DT
from upstream, as the msm8916.dtsi there includes a /psci node.

As far as I'm aware, only the db410c ever received a firmware update with
any PSCI support, so I intend to send a patch to kernel to remove the
default /psci node for msm8916 devices, assuming I get the green light ([2]=
).

I've tested in a local tree that includes a u-boot specific tweak to remove
the /psci node, and confirmed that qcom_defconfig can reset both an
msm8916 device and an sdm845 one.

[1]: https://lore.kernel.org/all/20240527-b4-qcom-capsule-updates-v2-6-4758=
3d7ad428@linaro.org/
[2]: https://github.com/msm8916-mainline/linux/issues/388

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (3):
      mach-snapdragon: use PSCI sysreset driver
      sysreset: qcom-pshold: remove ARCH_IPQ40XX dependency
      qcom_defconfig: enable SYSRESET_QCOM_PSHOLD

 arch/arm/mach-snapdragon/board.c | 5 -----
 configs/qcom_defconfig           | 3 +++
 drivers/sysreset/Kconfig         | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)
---
base-commit: 8162f35a108441b8d7a44ac9266c1a64dbf79fd5
change-id: 20250121-msm8916-sysreset-580d9a65a759

Best regards,
--=20
Sam Day <me@samcday.com>


