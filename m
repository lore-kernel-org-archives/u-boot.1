Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F283CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A9C81D5D;
	Fri, 22 Aug 2025 20:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="TMOzPQt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D10381D5D; Fri, 22 Aug 2025 20:56:30 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C74C8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1755888987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ATwLxaGKjX6dsNAj+HpBD+oX+V7pa+VdTwkn3HAysA=;
 b=TMOzPQt8zITryu3RHt18dcTuLtDHoHvHlVBW4xF/9wF367wkyrH0AgCM7QkYn3YsNZtiPB
 qi5hjJl2qZIOUMWDEpZ5T8Q/R0lummcHGMe+VEqE51/cYCzdCis9668RuVbqedkS6pbx1e
 35QOdI2MgvL/b+LZ7poIDA3+ChNPtfs=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/3] ARM: exynos: fix origen description and align and add
 \n to pinmux msgs
Date: Fri, 22 Aug 2025 20:54:37 +0200
Message-Id: <20250822-exynos-origen-and-pinmux-debug-msg-v1-0-e6384177b42b@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO28qGgC/x3NQQrCMBBG4auUWTuQBBT1KuIiJn/jLDopGSqR0
 rsbXH6b93YyNIHRfdqp4SMmVQf8aaL0jlrAkocpuHB21xAY/avVuDYpUI6aeRVdts4Zr63wYoX
 9JUW4ePMpzTRCa8Ms/T95PI/jB8QdN3x0AAAA
X-Change-ID: 20250822-exynos-origen-and-pinmux-debug-msg-16cae0a91ccf
To: Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=henrik@grimler.se;
 h=from:subject:message-id; bh=HCbQCI/mr2QNRZr3RMSzLnKrepMF7QChdQLZO+4D/TA=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBoqL1Hv30MV6NBwiizU6hMnlJDtHvDRF7BqMk0w
 d6Hz7WR1omJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaKi9RwAKCRCwB25JC3Fh
 axM7CACw07sHa7PJSdy68SR3EahZy1v/YeNSFC7+ZYM6TybqbgwkIdflIOWASQVgDuxaTwqf1Cm
 +TWnalj+pok5W6n1QF25UVDqB+oCMW9CbSV6qSFbvsjnQCn8FVvIywJxYYwFs0Dd3Jo1OgnCaKo
 J0T9AzhaDpNgVp2/NfvgLJRWLOPIzre6RtEXvG5jqz/qhen7aPj7lWav7qp1/7HB+Gs7oDtuoK+
 xmhrgBlvcSYhq0oOjipMXYm2YIEf/n8QsAmewYAy98F/g/ezttuGukUogpksbmOyu8lViwVd63/
 InM3oxLL0h6Xyx0bYP0mS0ZWkaFXhXyuLqz5Ld6D3SfjPz7c
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

Three patches to fix minor issues I happened to notice.

Best regards,
Henrik Grimler

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (3):
      ARM: exynos: use correct exynos4210-origen SoC in Kconfig
      ARM: exynos: pinmux: fix parentheses alignments
      ARM: exynos: pinmux: add newlines to debug messages

 arch/arm/mach-exynos/Kconfig  |  2 +-
 arch/arm/mach-exynos/pinmux.c | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)
---
base-commit: 94e690c44a03959c39f0f5a44a9b89c851af3b60
change-id: 20250822-exynos-origen-and-pinmux-debug-msg-16cae0a91ccf

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>

