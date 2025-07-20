Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D45C83F22
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 17:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9D28300B;
	Sun, 20 Jul 2025 19:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="ULI3MlgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AC283689; Sun, 20 Jul 2025 19:00:59 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F78D82F8E
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 19:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1753030854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WdUa+B/ULRh22RKCcO8ugH5y342g0oj9AgacaJO2Tl8=;
 b=ULI3MlgOu14y/yyWz9isLXa0ezPZGIxK1wha0Y3RVUg9AxfyvHHUhWBCMfzqpPIJluwSaJ
 QA/kAf6tt+q3Fonjc+TXYrOq1DMiiSseLQvKCb6+5JEtT9N8DIPJFLJ2diLOJuw1WAPlzx
 30vrCtfTu7/f0k2wJptg9cNQkJOucP4=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/3] mmc: add more exynos compatibles and fix cd-gpio
 handling in s5p_sdhci
Date: Sun, 20 Jul 2025 19:00:25 +0200
Message-Id: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkgfWgC/x3LQQqAIBBA0avErBtQK6KuEi3UppqFFg5FIN09a
 fn4/AxCiUlgrDIkuln4iAW6rsDvNm6EvBSDUaZTvW5RbJArbhiCx5UfElSe3DI0Q+N6D+U7E/2
 hbNP8vh8EhRqZYwAAAA==
X-Change-ID: 20250714-samsung-mmc-fixes-0cebd9393b7c
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 u-boot@lists.denx.de, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=henrik@grimler.se;
 h=from:subject:message-id; bh=JiWPo9+BIdFuroXEzzo2/b9VjuZtlZWg6vrG0VNIRfI=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBofSC485+tKu87vd+SQbGZjbMgFmC7zbG31leMt
 D9emBhF+7WJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaH0guAAKCRCwB25JC3Fh
 a7lEB/9C2i6gQGHPLqkIu2CdVFf7EGDg26Xm8JnVYJMAOsnXuz8ntoF0fsJn+k52dmAfgaIJksW
 Be32B1aQ/kXCpDr9s5Gc4T44k75AH1iEkfVIUTszzPTO7Oo69dbHfeVPIXbBFqz/sVFHCi0RCIg
 BcaTrb6x4x/Ca51xStFAXa+9NBH3a1SMuz9F+rQnoxT+kUBmF4f0gIx8IEy3W/EZh0RNLC1ufNi
 QwKLMiWMTA4c96y5wRpj5gSQiu3g+3MBBGDgbTJMsY4VzZn14G5MTjacJg6yAPO7bJfCPnhRK8M
 HlAxBDMtw1bSkkF6PE112D2HHN+jupGu3PQkgbERyubNOtBE
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

Hi,

This series does some preparatory work to s5p_sdhci and exynos_dw_mmc
drivers to make it possible to move some exynos devices over to
OF_UPSTREAM. I am planning to send additional patches for other
subsystems as well, with the end goal of moving over
exynos4412-odroid-u2 and exynos5422-odroid-xu4 to use OF_UPSTREAM.

Patch 1, "mmc: s5p_sdhci: remove duplicated card detect code", was
originally authored by Simon Shields:
https://github.com/fourkbomb/u-boot/commit/2eac9dea7903, but I have
not been able to get in contact with them and have therefore changed
to set me as author instead.

Best regards,
Henrik Grimler

To: Peng Fan <peng.fan@nxp.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
To: David Virag <virag.david003@gmail.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>
To: Tom Rini <trini@konsulko.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: replicant@osuosl.org
Cc: u-boot@lists.denx.de

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (2):
      mmc: s5p_sdhci: remove duplicated card detect code
      mmc: s5p_sdhci: add samsung,exynos4210-sdhci compatible

Jaehoon Chung (1):
      mmc: exynos_dw_mmc: add exynos5420 compatibles

 drivers/mmc/exynos_dw_mmc.c |  6 ++++++
 drivers/mmc/s5p_sdhci.c     | 11 +----------
 2 files changed, 7 insertions(+), 10 deletions(-)
---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250714-samsung-mmc-fixes-0cebd9393b7c

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>

