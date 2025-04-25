Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151CDC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712628212A;
	Fri, 25 Apr 2025 16:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CDnPT717";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1008F81F4D; Fri, 25 Apr 2025 08:49:53 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5567C8059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 08:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E360C4396E;
 Fri, 25 Apr 2025 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745563789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXpADx/A9RXx6Co+slCutZhtk/ceBzW/qFKcrSeN3ww=;
 b=CDnPT717egF8vLD/kV2H3pgxQS/liSHGT3YDsvLb/WlnpbMLOyvhnXBGEddKZs+TI1LE9Z
 TFsCS7Qr/yyc6bAdsAaBXoJ2C2xIcljaJb/O6SSvl7kN5IqM+63WumulN49Ku8qnHEq9Id
 GvqkTzDf16CKgn97whbfJu3xMJX5ZJnYk2HOd1JyS32aypDnq/DodPeUHz5F/zUe8Xy+hp
 FxBEXQ2UWMH2Ell8hlZ/0CPZRsLehZqdIk2Qh1gIsmGdCKYfl/barXe43TU+pdV7cB4rnT
 j5jEmrXlRL1R1UTzfc/T+D+HuATfKWidDTSsNU0q3FY1zsdrc51ybuYgHu02Rw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] power-domain: Enable uclass refcounting
Date: Fri, 25 Apr 2025 08:49:31 +0200
Message-Id: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHswC2gC/x2M0QpAQBAAf0X7bOuck/Ir8nDcYkvnukUk/+54n
 KmZG4Qik0CT3RDpYOHVJyjyDIbZ+omQXWLQSlfKaIOfsR4dS1jshbKHsMYNbakq53pTj7qHFId
 II5//uO2e5wUXlnvwaAAAAA==
X-Change-ID: 20250424-ge-ian-display-support-a305ddb47f2b
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegteeuudfhhfehhfetjedtgfeftddtuedvffetffejveevheeludetjeelffduvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehnqdhfrhgrnhgtihhssehtihdrtghomhdprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfvghst
 hgvvhgrmhesuggvnhigrdguvgdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepshgrmhhuvghlrdhhohhllhgrnhgusehsihhfihhvvgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
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

On one side we have a power domain uclass which is mostly clueless about
the topology of the power domains it manages.

On the other side we have SoCs which are getting more and more complex,
ie. with several layers of power domains. Sometimes (eg. on TI K3
platforms) all power domains are defined by a single device tree node
and the "subdomains" are referenced using an identification
cell (#power-domain-cells = <1 or more>). Sometimes however (eg. on NXP
i.MX8 SoCs), the description uses many device tree nodes.

When a power domain is referenced several times, it is likely that the
power_domain_on() function will be called several times in a row, which
in some cases may lead to glitches or even breakages. This situation is
problematic on i.MX8MP and only with proper reference counting we can
safely support the video pipeline.

There was a first attempt to bring refcount support to the power domain
uclass, but it miserably failed because of the details mentioned
above:
https://lore.kernel.org/u-boot/20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com/

So here is a new version of it, which takes into consideration:
- the fact that a single power domain udev can target several power
domain IDs (referred as "subdomains")
- the fact that some platforms might count on a uneven count of on/off
calls to work, and "fixing" this may break the platforms.

So refcounting is an opt-in parameter, it is a matter of filling the
platform (public part of a per-uclass structure) subdomains number with
the number of subdomains this device nodes features (one per
power_domain->id) in the probe function of the power domain driver.

This series shows how it can be done by enabling refcounting on i.MX8MP.

Samuel, Neha, Wadim, Heiko, could you please confirm it works on your
side?

For once, CI is green :-)
https://github.com/u-boot/u-boot/pull/753

---
Miquel Raynal (2):
      power-domain: Add support for refcounting (again)
      imx: power-domain: Enable refcounting on imx8mp

 arch/sandbox/include/asm/power-domain.h          |  2 +
 drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
 drivers/power/domain/imx8m-power-domain.c        |  4 ++
 drivers/power/domain/imx8mp-hsiomix.c            |  4 ++
 drivers/power/domain/imx8mp-mediamix.c           |  4 ++
 drivers/power/domain/power-domain-uclass.c       | 90 ++++++++++++++++++++++--
 drivers/power/domain/sandbox-power-domain-test.c | 15 ++++
 drivers/power/domain/sandbox-power-domain.c      |  4 ++
 include/power-domain.h                           | 69 +++++++++++++++---
 test/dm/power-domain.c                           | 11 ++-
 10 files changed, 189 insertions(+), 15 deletions(-)
---
base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
change-id: 20250424-ge-ian-display-support-a305ddb47f2b

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

