Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DEC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 23:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5004C8129F;
	Tue, 22 Apr 2025 01:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paulsajna.com header.i=@paulsajna.com header.b="tOopt2rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADF0812BC; Tue, 22 Apr 2025 01:20:15 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B618A8082A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 01:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@paulsajna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paulsajna.com;
 s=protonmail; t=1745277611; x=1745536811;
 bh=0MTSMlo0T74j9IsNUaaNoSC4vzRMmJh+iYjf/+R4xPU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=tOopt2rlGhSQTJtPjA4OWZMpto6N7/2ou5/kvbO9VW8iBGicojofZd2DiZdiLfaee
 jqbuvrQbinytjwpLeT0uDjE1ZNLnnZmp7xsRSaARM7qfj90rGi5kNzc5ot6nBKQmlH
 5nhOhF7RHziAEfzSoXqKmhgFGgp7ic9PkkDaOo51beyb38krW6GwzvWkh3ux+w+t/4
 5hfrdb8S34qYmtTLN+iU8i0lPtXgPWtbbt7884dYnBgZYo7vhHSHznWXBU3KIhr5V1
 ZjyOv/UfqGUDW6Eo65ape3Z/B1LR9muMa+tQjJeCBDp7OAl+T7u9m3EgjHF+HdkJ4N
 OmEr5g9yeVvmw==
Date: Mon, 21 Apr 2025 23:20:05 +0000
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
From: Paul Sajna <hello@paulsajna.com>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>,
 Paul Sajna <hello@paulsajna.com>
Subject: [PATCH v2 0/2] watchdog: qcom: introduce qcom-wdt driver
Message-ID: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
Feedback-ID: 29073965:user:proton
X-Pm-Message-ID: c7976b196475080974e4f69c6ce0f78346607c98
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

This patch introduces a simple watchdog driver for Qualcomm devices.

Some devices, including one I have been spending a lot of time with,
the LG G7 ThinQ (codename judyln, arch sdm845) will reset within 30
seconds if the watchdog is not serviced.

I have tested this patch from Casey Connolly that is over a year old and ha=
s
not yet been upstreamed, and it is very useful to me. I can hardly use
u-boot on this device without it. I have received Casey's permission to
work on upstreaming this patch.

This is my first contribution to U-Boot, and I am unfamiliar with
mailing list workflows, so please be patient :)

Signed-off-by: Paul Sajna <hello@paulsajna.com>
---
Changes in v2:
- Add watchdog start
- Add watchdog reset
- Remove stop from the probe function
- Use dev_err instead of printf
- Update Casey's name
- Add myself as an author
-=20
- Link to v1: https://lore.kernel.org/r/20250413-b4-qcom-wdt-v1-1-db42cb93d=
ff8@paulsajna.com

---
Casey Connolly (1):
      watchdog: qcom: introduce qcom-wdt driver

Paul Sajna (1):
      watchdog: qcom: improve driver with more functionality

 configs/qcom_defconfig      |   2 +
 drivers/watchdog/Kconfig    |   7 +++
 drivers/watchdog/Makefile   |   1 +
 drivers/watchdog/qcom-wdt.c | 118 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 128 insertions(+)
---
base-commit: 0eebdd17888005751cd77cf3794c5292d36f481a
change-id: 20250413-b4-qcom-wdt-e7b913fc375e

Best regards,
--=20
Paul Sajna <hello@paulsajna.com>


