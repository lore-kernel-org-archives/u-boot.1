Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E646FCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0FB84CA7;
	Fri,  8 May 2026 14:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pTrTG2us";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sqX0qr+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D533684CB3; Fri,  8 May 2026 14:23:10 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 120A384CA7
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpDX5l2Lz9t0N;
 Fri,  8 May 2026 14:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LR+i7jeCYbmeSe6jii7oAcBlsssqShM78qvUxek1syc=;
 b=pTrTG2usXzATsX5vNqGnHIE/6aRKYxIFkJQtMWICOsM8fTSRHK6ZPtWyxM/NFkdwuPJHFP
 LQVONFQ9QC6+LLzL+A10xuwQlTSvY09q4KbEnwzbdA2K8C22FyurymdXGAKylBXTfyi9OE
 UGujHtZhRMcCCsTCRL/UIX7gbIj8HL/HsUxROGtzk4m6z1qosAD3gH1rpknzq0nGGsRKp+
 srHPLGN4p3x2I1q8xWDopvB3AmIaujLWlxS7o0mIfHfK7N3gJhhE264auDKAt+zOZvJUPV
 nwOaPM6EWhnVkhHpSCEHntqR4Mq/87Xu8PXaoHCdu/YgSq6AtmjaDqp9gd6Bpw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LR+i7jeCYbmeSe6jii7oAcBlsssqShM78qvUxek1syc=;
 b=sqX0qr+dIkP2xhGBa8cJsRv/PFlc3xiN2aj7BRKd6HCDi28TpTWbfsFGRgze3pJPEtrJ9W
 K/o6bWLbuKb+GjqbcLpaweAQC7quwcLC25/xrIrnihcLZnkqwRVjJa3cLEcKMZfuy5PHDN
 X9BbFL0nd728qb3I4K5Hfmx8Mr/x2gSBtMmjlv9ibfSfeLvTZZH88Jw8+TEQu9M0IHro3f
 KW0LG2hJZ1mBEvXkAfmmxSRcirvDHegHjmk0W6j85Mm3wwMe+XH/BJfHJaQO9AlAtsqmhi
 FSb3HbynoEowvUAs8FIfwGn5UV+3RVHzVebt59s88qLnmPqJlZDjOCIJz32o2g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
Subject: [PATCH 07/14] power: domain: meson-ee-pwrc: Staticize and constify
 driver ops
Date: Fri,  8 May 2026 14:22:07 +0200
Message-ID: <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nej3k1cy5cydeiwxdnchpqgm93sqd9z6
X-MBO-RS-ID: 2501b6b934bd680ad0d
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/power/domain/meson-ee-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 4d9f3bba644..6361f3a6c59 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -386,7 +386,7 @@ static int meson_ee_pwrc_of_xlate(struct power_domain *power_domain,
 	return 0;
 }
 
-struct power_domain_ops meson_ee_pwrc_ops = {
+static const struct power_domain_ops meson_ee_pwrc_ops = {
 	.off = meson_ee_pwrc_off,
 	.on = meson_ee_pwrc_on,
 	.of_xlate = meson_ee_pwrc_of_xlate,
-- 
2.53.0

