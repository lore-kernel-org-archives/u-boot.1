Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B53C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95038788D;
	Thu, 21 Dec 2023 17:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EVaGgPxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBE88788E; Thu, 21 Dec 2023 17:09:58 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591E5877E5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so12070435e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703174996; x=1703779796;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uMnsDjNL76yqsTdKFEajTM8QWF6fC3zEC/BAiV7Qh2g=;
 b=EVaGgPxSb5BWD9WFv5sN7UBjlmtZ0KpbG8wttmLysIIMFoyMYvwlURlXOsbg+/ESEp
 LVxue6V5eaKEi0dxteAj+Wn7Xe/mAviwfvlzris3oX0nlR48lC3UyZ/vnSrA5OZzgyS2
 o3XPZZvheweYd56MpN0NJPascHCAkTD6ogCPdkl9N1QzLWpABAYfYk4+be9dfct1FH26
 RyupwYSoDwWL72PmnEOTuNeThIad7UyRKP3Wtmt6ec3cSGkbYpYzfUId/pWTGXtASlRR
 vfQHUtrXGoAJexZGJPYRwfCgeUOigApk4BTvcYvFVHFyWxbRaxC6YWb7FiRcc+MS/z6+
 Pvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703174996; x=1703779796;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMnsDjNL76yqsTdKFEajTM8QWF6fC3zEC/BAiV7Qh2g=;
 b=mA7t3vi9UB661vc5Iais8ypOm10PmiKZZueOTWUFenVsfB6Wp30u02qm57UkUljJvC
 GhRnEWuvRPDg//Sv4/792Gk9Rrxa1GGzU2omy4GuXsST19OFFyQGFGbWWtcnYuap2oYF
 bUhSDo/WmzyCRAnq98PfP6Np1RcOrbWZ+X7CAxrxPXc+0dcqUXH2vQybSvzHznxQvpdJ
 yo/PBe+QvGtfOkOL6qY0K6HPGERjUKWxyaXdtCPWLNjMKZvy7WaqfHMykTUl7vfzzSSd
 rERY6Xdepm7muaueB0VtWZvM8GI1bAdLvH4nYn3bRYerAkXc3wc1cZPKY1rtFKQvDptp
 gz2w==
X-Gm-Message-State: AOJu0Yyjz9gT3D+9v4t4bzshRMkctlyAHax14cZVSBy6I1+YdOPOa6JM
 EmnspeQhxDl5Xf8WgZmiBzJand2AkpmUie42QtM=
X-Google-Smtp-Source: AGHT+IHe3H/W9C3+6ExqAcBbNo6BnkaKEFh9EO7vn64Y/AsM+LPRgCChifOp5hR0aolmUl1SB5Mszg==
X-Received: by 2002:a05:600c:5106:b0:40c:6b69:1885 with SMTP id
 o6-20020a05600c510600b0040c6b691885mr917750wms.213.1703174995679; 
 Thu, 21 Dec 2023 08:09:55 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 bi18-20020a05600c3d9200b0040d378623b1sm3807862wmb.22.2023.12.21.08.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 08:09:55 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 21 Dec 2023 17:09:49 +0100
Subject: [PATCH v2] MAINTAINERS: Fix ANDROID AB unknown file entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-maintainers-fix-ab-v2-1-9182a7829646@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAExjhGUC/32NSw7CMBBDr1LNmkHNoFJgxT1QF/lM6Eg0RUkVU
 VW5O6EHYOHFs2V7g8RROMGt2SByliRzqECHBuyow5NRXGWglk6KqMVJS1iqOCb08kFtkLTXvWW
 +9sZBLb4j12QffQyVR0nLHNf9I6uf+3cuK1TonDp729GlY3c3en2JiXy08wRDKeULNERIkrcAA
 AA=
To: Tom Rini <trini@konsulko.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Commit 19a91f2464a8 ("Create a new boot/ directory") moved the
android_ab.c code under boot/android_ab but did not update
the MAINTAINERS entry.

Update it so that the maintainer will get cc'ed again.

Fixes: 19a91f2464a8 ("Create a new boot/ directory")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
- Add 'Fixes' tag in commit message
- Picked up Sam's Reviewed-by.
- Link to v1: https://lore.kernel.org/r/20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4dc0..f6de883a7d8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -60,8 +60,8 @@ ANDROID AB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
+F:	boot/android_ab.c
 F:	cmd/ab_select.c
-F:	common/android_ab.c
 F:	doc/android/ab.rst
 F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py

---
base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
change-id: 20231220-maintainers-fix-ab-2afa7cee97bd

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

