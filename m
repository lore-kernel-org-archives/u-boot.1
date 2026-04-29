Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3465FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690D2848C5;
	Wed, 29 Apr 2026 23:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XDtn6+6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E0D84837; Wed, 29 Apr 2026 15:59:13 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB55784855
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so9835387f8f.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471150; x=1778075950;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vDks7obpZyJiKiMiHdoRgyzLZdypXIIMbIZYpp1RNJo=;
 b=XDtn6+6dnqRaB4Jl5miI7PEQbECok+GzXY6G8uXqF9M6B1e58K5RONOcVEgM1FM6dR
 Dmo96vFsFNDfDMU83JOuTtlxDX8kDjD2a7gk7gdJBdTZ4gRDH/6Pdva9D4S5IKicmokX
 AiKUukdJIaWWWJl8thcpmUCXMtTzOxjbo9+ylWkbSfy8VChld8IGljhjzk9dXSRkMwOn
 iR3YkBTHbFr4KLyrLVIjz6u7DMryKspAlsyUxL/7+UgkokFoJ6138OAkvY3KhOQuGfA/
 No9GdI7u+T6II62DsQgqWL/tvnuSHZ9efglai9AiarNB79OrltnvHPK16dZPkG3XeIGR
 O59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471150; x=1778075950;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vDks7obpZyJiKiMiHdoRgyzLZdypXIIMbIZYpp1RNJo=;
 b=kRbea35g3JV4bJRMEnNiJaC1gCvYNoHX0WxR1ScnUR+rBgOZ6fe6htQ7JbqlJCORBy
 3R5sqdjQ2ec/MTgTiYO3YnRdvyT3zq7cgpAHOe+8o40z5gJZCVfw92YqGtkUqgdOnzWe
 M+Vbf/GyWnsFlyagvWfY6ceaXMOuHy1QUKJLKG6YjvNxrSQhA3gYoMck2BFhC/EAbJGW
 /q2sQzOd/8VzTP+p+yrN6GYhFwXl1zL4QBHlno09kvvWP089obh6FRLIJc1/AtKh35vA
 ZtG/dnLMevHOfztfabPAa2mSPfQp0+HfajxzXdwSUrpGvPK3pDbH6e6cBdYtvNK9ij6F
 7vKA==
X-Gm-Message-State: AOJu0YxqlbC6+NJnCSpldAcp+T4Qt+fsI7qmrmgmVi0+ADJJ58pP3GXV
 teyQY86n6LlztMLNrMU8aOw8+fdxBrjsAdBbS2Gj9mFW6j9lWQPka+8Ns9JfzQDyHuw=
X-Gm-Gg: AeBDievF7qvrOZ5h+KMpTd1PqNgCKNuhP8+HncWHvqhH10I2AK1W64Cn9hrQy3xq+uk
 yqme7ndyVL87voNR36oWMYdUBmof3WOHOlcO0rhGFcj81pKsQL4pUncpRrWZJEgkwJzBdVfsh4z
 Fp9H5cPv+yO94CV0zzMO2VjpQ/UUcgxONVwIYx00rNQ+l5k5TGs5VsTOWJg/+4DWNMIfvpHMEZL
 R3meCmUm5U6BChdzqo4lHhBPCUfXk2xa5BTaOG61ti6bRGtROyuKkvd5L0OxYoZqvVP4INQLa3u
 C4pSn8dtYLEB83/RTpXEd5qtPmXyFSe7nnrz3NtM4IjZ3Kq1bgbmkQvcEEdwuSuIRB4RKLQt98I
 a6GetaKlfnAQbu7H1VTqBY/oO2BnyE288gvfpw/dHQAZrXlmABpCU2FAJIl7Xd480E9jlximq+O
 ARecZ9J7iQUjCTgrPUL9ir19CHT4ETuYhwqTcz5c6MqYikeg9wFq5VW1/OkjEupsjXR32f8ej04
 bOvAU4Grk8sshPgYnh+Th8LEbsVOvUT2/eospbCSi6iY2oO7iNjlkNLfCGZUXKzSdOvUxsulrRX
 haHhkrFZPfb0xC2yl3g=
X-Received: by 2002:a05:6000:438a:b0:43c:f52b:8003 with SMTP id
 ffacd0b85a97d-44649ba199dmr14175480f8f.36.1777471150075; 
 Wed, 29 Apr 2026 06:59:10 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:54 +0200
Subject: [PATCH v4 1/9] MAINTAINERS: remove trailing colons from section titles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-1-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

For consistency, remove trailing colons for the three following
sections: ACPI, ALIST, and INTERCONNECT.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dcc7243124..ce4e9d58037 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,7 +50,7 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
-ACPI:
+ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/emulation/configs/acpi.config
@@ -58,7 +58,7 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
-ALIST:
+ALIST
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	include/alist.h
@@ -1279,7 +1279,7 @@ S:	Maintained
 F:	drivers/timer/goldfish_timer.c
 F:	include/goldfish_timer.h
 
-INTERCONNECT:
+INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git

-- 
2.52.0

