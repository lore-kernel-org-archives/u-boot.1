Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65AFCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75123847FD;
	Wed, 20 May 2026 00:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="XbzdO2wY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EDD84873; Wed, 20 May 2026 00:49:01 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075398056B
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36931e4f5e8so3530461a91.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230937; x=1779835737;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r1JAFCIHt7MDnbg8N3jhQVa6uYcIohu0l8vHY9CFkj8=;
 b=XbzdO2wYFJux5ZMs9LbWZeaB1dWtGVEGQSGPmb/gu/pjPxO3/A12GTktgkIMvzcWGa
 4kFm83fuehKJ4GCrQMSxqVrwgHBCVxTYJVpWWheMU7PTVVBTGjzUTQw0ekI2ImVlR1jQ
 X98pA+iz6+3ikldFD/GNQqfBR87uVFl4Ss5jSov49604iTIjKl9DEXauRCUvLbuSkVQ/
 5lFSBAIqnAArQdDjsnerS0iomrEE+kLahkYZlD4Yv5Obsi/PBjaFhcrGBzj5GHxU6uZm
 R9bBqy1JXLyRwTZtIldGve6H0NzaW7b1tAZsnyBoENRTEZ6/bfbrbvges5Kk09s1NKlR
 AJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230937; x=1779835737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r1JAFCIHt7MDnbg8N3jhQVa6uYcIohu0l8vHY9CFkj8=;
 b=gkxMoV8lV8MtmOACI30mkxOD5K2xV6r7XVro5ChNMT5BkFdz65+5tRlqJTAk+lk3KJ
 By8Ui7uwCbbmduuHXVLcs4EMVG/KAQqxG5xGjCqvlRwL/hpCW/W0/enBUgX7F+y3CqtM
 Aw15PbCtY1acbwNrDrpbLPVr72+vEAWOzlO00HPz1sIM7Fq00kBjLc4USK5CbE3ZMLsF
 WbHk/fWLg6YTghdTod7de/q45r1hUicSDpcV/MOpVJRJ8I+oL3J1wAblen54N+r4Eyll
 bnezUNbvniFEO5CAfF2kpuU1nZ9/mbck66ZkH8RuFqnaXQW6yeTW+aYoJuc4kg9HEpwf
 105w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yT0+Ispryjp+yItOTpGhVdbC2Of71CNAF2Jo+0mJrmbJofd3z3XO1y5Q4Ni9BviJR76+aPIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ3nm/6KLQgOpGQwjSIcXBU5XLMx6EeFxE5gZay8L+Zj6W1fk4
 LS6Xr9n9ne5JTbhfHhkOYrudMhBToZoTTACS0B3RRENh+AKDYXwp1QlvevlZZ9kv6TM=
X-Gm-Gg: Acq92OGZnQwNqWNoAqleiCBnkg27hzK2Zq+FvAny8WimGMyXUy3HB6aPSJ0ABS+DHR3
 ENsL0ptCYKEPgI2FdO1zFlp1YVSX8mgnGyTZVGs6A81DC2x0FHhQR4WrHL2/b1U+jqtkrSJ96pz
 Mw15TC9q6aIgKcp0xisv2eM4ttW4VP9EG3BlOqYy94enK0r05XFaGpKcFZU6wcrj8U1qZ+kRWxK
 r/YkpZOdh+1AeepoZg4z7FNfVesWniT5Bmb1gIK/QfvpH/vW8W0BA8wrY5sPrww+wN0D0bAsPfa
 T7YObtDfRrboUZJovolvvx6GfN2WG9xEuoQgexSkBBC4mdhSp7EXsVQASq2d6Z4CX1z3XQfjMu0
 ujRPx/uQXolCi4TJBffv7fD1TYl2UE9mQNgU8q4qZLMPl3I50tcennWqnJ7KV+vEz9OT4i+rCsc
 Lr88d5ipNkt+cxgtodi15oR0DA9GUBKmPibs/y63wqGWo=
X-Received: by 2002:a17:90b:2fc4:b0:367:bf59:6f99 with SMTP id
 98e67ed59e1d1-36951cb8825mr21716942a91.26.1779230937522; 
 Tue, 19 May 2026 15:48:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:48:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:49 -0400
Subject: [PATCH v2 5/9] riscv: binman: Always set default configuration in
 FIT image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-5-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

When CONFIG_MULTI_DTB_FIT is enabled, the FIT image contains multiple
device tree configurations for different boards. The default
configuration must be explicitly set to ensure the FIT framework
traverses all available configurations instead of falling back to
CONFIG_DEFAULT_DEVICE_TREE.

Without this default property, fit_find_config_node() will use
CONFIG_DEFAULT_DEVICE_TREE as the configuration name to match.
This prevents the SPL from correctly selecting the appropriate
DTB based on runtime board detection (e.g., from EEPROM).

Remove the conditional guard so that "default = conf-1" is always
present in the FIT image, regardless of CONFIG_MULTI_DTB_FIT.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- No change.
---
 arch/riscv/dts/binman.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index b518560bb94..84c261c6849 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -93,9 +93,7 @@
 
 			configurations {
 
-#ifndef CONFIG_MULTI_DTB_FIT
 				default = "conf-1";
-#endif
 
 #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@conf-SEQ {

-- 
2.43.0

