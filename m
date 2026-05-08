Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0188CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DF884C50;
	Fri,  8 May 2026 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBDbLTZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A246E84C3F; Fri,  8 May 2026 10:52:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F94084BD1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ad135063so15242855e9.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778230338; x=1778835138; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/crk9psfXmN+yUa8uiyNhhZLO9LwvBzyEMxi52SmQwM=;
 b=UBDbLTZwxIP7MyqYJbXXWVRKtRMW9mGHwjOjRf0lMgbqRUt5cfcISevVI2WhxUGidF
 UrRixRVbo3TYM0pAzT5wrdoAQsajLUG+rOTMeFrsx244OlWf6vEWSVyl6Pu2YLl4zuoU
 PRWgiBk0EY9mbxvMHtF8iLmILBEaFBUIT0yS4JDT9r90wGROn0aRWX4VkUKeKROPWA87
 /v0qLcENRi1p4Ea5eSm/8G4AyCKDWQtSGVcyomuvs7OA4j0JeiVm5u3/XXDjmqXJXvEe
 JjxbB+b9nGUN4eGwd15oXy9KUvtTcLtoPNWWrqGJ5W2Iku9EbSXojMEy5n2KXPqw/0tc
 yPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778230338; x=1778835138;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/crk9psfXmN+yUa8uiyNhhZLO9LwvBzyEMxi52SmQwM=;
 b=TBUAZ3ud9lxwHsoe5EKpZ6S5/JqxGxMNYIxOyld1HE8Tu8hz0my9exJshDrhGLS0wj
 fWam6f/nfGYQZ5XPbyyc5Z5Bw3vmYc4vKt3rd5Yf6k7K/PGkNRg2zDxGyF5wZuoHqLfV
 yfKLHwKZyc3pWjgqxld4s3iXWLPNrC2draVyy3Hb9QEYnJiHMDoomHTXgHSt/Fl9/KoG
 j4eqkPThW2cZ015Cer/IlOCo7JwSGCLDPPiIvrplHuURuiZveiZXCqBdYU7Dyav9wtx+
 ZjR9X3eU4CUrH4NvjmB/tnk2OolHmF3lMz5VZNjIsvrktoWu9sU2P71NIfm0/mlAhV0S
 J4Tw==
X-Gm-Message-State: AOJu0YzmHE1Hc90Os+dFGbVVK3ym2s7UtAHKme6+F9bLRTSMzKzanmze
 In8lvwFG02/cwhLGAuTkJYY6Zkw7rRBejRysZOLGWUGXJ7Xgccy3tn9d
X-Gm-Gg: AeBDies6wvvcPHOUeCvpaORGurONYMibUgqzbA2wgjWG+AWR2El5S2Cs8ql12Z22yqy
 JWmnba0ZF/z81cbabp6UTeEJwvSugJ211jMtvQaNT4z8xDv2AXwM/+d+Vj9mpeuvqmeUzfEMh5z
 85d8PSeiNo3XHFa+76cWvFzOM7wmNgRc0YRw2UiThS4RBwM6cQKlvJbweea6ad/fGYZlWGREx/p
 zF2MYUGK/ERlLy1SZx+opWVVsLz9xp2o2uYD2BqtKdU1Eq6CNOGvXVh/qe3ig4HSjhMIgOsjqL2
 edK+yX3u+30qyk6NE1dNgh4P8qp5usgbFzseO/1oRoobtTGdVoI4/rlRxFAC/uOwJF62EAfKkbn
 /JbRywFQKH02ELuRb/X46Vvjk5pFyK+cpmBS/xqmRn3JbysG5b+jajNJmQec7MKmAg8+4Y2ltJC
 KSc3lOO5V5W04MsIhz0W+TvP61qC14z1JiNoqDr6AD9I1yYBSO4KTSAGcnNYgUiw6PEBGeLDzqa
 a8kTWWIeVm8JAU5E4ND+ATGQ9o=
X-Received: by 2002:a05:600c:a111:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-48e51f46e24mr147569985e9.25.1778230337663; 
 Fri, 08 May 2026 01:52:17 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a5b65sm2676777f8f.8.2026.05.08.01.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 01:52:17 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH 0/4] board: toradex: k3: Sync rm-cfg with TIFS v12.00.00
 firmware
Date: Fri, 08 May 2026 10:52:08 +0200
Message-Id: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADik/WkC/x3MTQqAIBBA4avErBtQMYmuEi1ER5tFP2hJIN09a
 fkt3quQKTFlmLoKiQpnPvYG2XfgVrtHQvbNoIQyYhAjFon36e1FmDZ0IWKQwrrgyGivoWVnosD
 Pv5yX9/0ALK1V3WIAAAA=
To: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
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

This series updates the Resource Management configuration for Toradex
K3-based boards and makes sure the TIFS-specific RM configuration is
used where applicable.

For Verdin AM62P, the tifs-rm-cfg.yaml file is refreshed with
k3-resource-partition V12.00.00 so that it stays in sync with the
existing rm-cfg.yaml update for the v11.02.09 and v12.00.00 TIFS
firmware resource reservation.

For Verdin AM62, the missing tifs-rm-cfg.yaml file is added. The file
matches the TI AM62x configuration, and rm-cfg.yaml was verified to
remain unchanged when regenerated with the same tool version.

For Aquila AM69, both rm-cfg.yaml and tifs-rm-cfg.yaml are updated to
match the resource allocation changes already present in the TI J784S4
configuration files.

Finally, the Verdin AM62 and Verdin AM62P binman descriptions are
updated to use tifs-rm-cfg.yaml for the TIFS RM fragment when building
tiboot3 images, following the same pattern used by the corresponding TI
AM62x/AM62Px platforms.

The generated/updated files were compared against the matching TI board
configuration files where applicable.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
Ernest Van Hoecke (4):
      board: toradex: verdin-am62p: update tifs-rm-cfg
      board: toradex: verdin-am62: add missing tifs-rm-cfg.yaml
      board: toradex: aquila-am69: update rm-cfg.yaml and tifs-rm-cfg.yaml
      arm: dts: k3: k3-am62*5-verdin-binman: Enable tifs-rm-cfg in binman

 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi  |    4 +
 arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi |    4 +
 board/toradex/aquila-am69/rm-cfg.yaml              |   40 +-
 board/toradex/aquila-am69/tifs-rm-cfg.yaml         |   26 +-
 board/toradex/verdin-am62/tifs-rm-cfg.yaml         |  867 ++++++++++++
 board/toradex/verdin-am62p/tifs-rm-cfg.yaml        | 1476 ++++++++++----------
 6 files changed, 1670 insertions(+), 747 deletions(-)
---
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260508-v1-update-rm-cfg-f10acfce64d4

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

