Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36206C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D42B40A24;
	Thu, 10 Sep 2026 06:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uK_slag7gJf8; Thu, 10 Sep 2026 06:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40EC540A26
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021583;
	b=dsr067oVHUTk8B53WuTrkfglRmUcMdfhFX3uJ3qIQ45Hfw8HTM4OiCtxMX8dzNN1X+rM
	 IVGgqjkZ9qGeiUFhWaEgSQkgloiHySC/Rk0ap0hA0mPjcnLBNZAQ/N/cl8/dDokwV+aSK
	 FxrU9/Fzg+8z7KHSF7ryfSwmMX25tVIbjBg9oPp6C/1FvdWElDD2SSmxZ7F8XkxTw+RCF
	 1rIDk8f3dqM2g5sVUbVUyPHaRicrPKaSawWHYlTo5dzY/5NoS/t+36eSShDWsJpTY2mge
	 F6pibmO7+ZoT9eGZxU768qphKfYiV69A30dDXj5RwND8x7WbfiV06e07NpnvjU1hjUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wIMg4XpMK4pdUeYihPvp+A4LPU9+6039HFpcbh0i2s4=;
	b=MldqXwy+ICkstEbCkxo8wLBgdjiacPIFl27jwiUobgAFIsFqKeKfx13/etDYRqkDx9eC
	 B4LEoPg8Se5c2lyYZgYkD0pQzav1c+yyD6ajs8YBJtwgf4q+bvfZ3Q1vCrGcRA5ZPuBh5
	 PyVGvsNkf72qh1lIKin5DHNDZw9HSmdigRq1t6uqYeg+ulkxJoRfL0OTaGzW9umsDhAy5
	 UT2qUrG/uYfmc8NU2z5fqMttpuLROkyjlA/UU7ljdYOCNzl0TNeAOI36ERPFR8j1iVjYh
	 2G5xiRWfjxF5bSLqQ8KzmmxD6VPvzTLqb+nLRzuptTgVrw0bs4BKloBKFix4U+zVkLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021583;
	bh=wIMg4XpMK4pdUeYihPvp+A4LPU9+6039HFpcbh0i2s4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IVlYRevRz+gwNpyscryhPcBaoQ3fUoykOo1zJt7Ew7gsuBifeUB60a7PlTzirbaiL
	 juDcL3InXqzuAh0c0B888cYGxnPboUoi5HflpcwrlnOKQkqs07hzspdoUBqi7JcAMd
	 mv7WN7KAokfkL1/LAZ1h5YtbiAimpKvtQ2aLNPB3wHAKXyCLoWxAl2KHaj//CUdbuX
	 OWNkkiaO3PtYJ0O3vCQ6KKqjFHGgtv/PCFqIzajDPA/7e61XJPUlSQAzJN2GBwK029
	 45ziLqadgNV/qZPtMwGaolQb+nS5vkymhl3p7XaV1xhd0th22KAC+Bo7h6ff+N0D2y
	 PleE0YXKcxNwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40EC540A26;
	Thu, 10 Sep 2026 06:26:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28E7243F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E7C680F0B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXwsnCmkw1Nq for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1A4880EEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021577;
 b=Q9hVLSg18luue3gipHZJcFhuE+JIO/IzQOC5J/brszsU2htCJ945PGn7/xs3AGOjm1tA
 9+aE3/dQFaGlWGr6Wd4vF+4a4UfmWotAZxn1dTpVMWua7y7l2s9ZCgDwu1hk6bRDzQi7G
 BKhLvGvD45ARa/K79cysA4T+gUbzp3Ueyd+RDgpULs6Efy7k3bhTlYleOUOAgxt7yfhkl
 kVhKDyq4C9RQz5iuqYxAHHGJtCu6V5LkaHKhGOriXDvZlLWXaS8MA3kKIKwTTi0KMnhq9
 Pm5pJCp6hrHw/ejyMs/Pn6doEqgUlbFHmiYzGrO+SNiFBBgYYOd06mhiGd7MdH37K9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021577;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=wIMg4XpMK4pdUeYihPvp+A4LPU9+6039HFpcbh0i2s4=;
 b=NDa+uex7UvwYZuBJIXHain10szWlRMu03RyyV27b/PoyoxhG7cHXaVFDq+S53shXF7LU
 i5GCQWxTFZGomxkUyPTMZiDJU5gLvpjPNMI84x3KSR2+fjpUcOzgIfcOj1IQFhye2ou72
 C+tUbPowsfVmT26m0YaLYjQKOOPZVUwzJUN3jrqpQZSCXzZTD7gpq0SofO1H8lHr7q6q7
 YgWywFe1TWwmUN8cOG1XmSzVVzBmdvZfS6xP5wqNMTtVXTEjrmmhy3SHPAwL2LtFMGbgC
 sxm0TS7HxcM89j6ugtND7LOR/br5JLoaPkc5eKcUnuaPdd529AtkfGz6mi/2gqcZGiQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="PQE/NXDC"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PQE/NXDC
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1A4880EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4956869750eso59525505e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021574; x=1789626374;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wIMg4XpMK4pdUeYihPvp+A4LPU9+6039HFpcbh0i2s4=;
 b=PQE/NXDCrYmMCeVa/C+RwCz1a6aehyhIZBjXmsCGZldke1j1bUjA/F7hlnLY71J12A
 6y8Apx6RMpmtdb6YEwcuhxryaZP0Yr1LZo3gLjaDhgqHmHG4bZ0066FSyjTGF4xt91KD
 egDjuqCEVaffT1wGdQvVLzQ2QS7M5UmUJWAsF01sg913YOgh4R0urzGT1vLU6RzUMg9r
 +g21XaeGSMP3HRjszRZiWUXz+GgpLpEloQU/Yb4EXz2QKp1QNmle+Pmr6/KfUdDPHBMt
 3XBDGWqUo9RkUDFlKLIGOo9O00Ve/Iz0A8bixqacIJj4IociEg85Hp7gTP6utQr8TvKx
 XbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021574; x=1789626374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wIMg4XpMK4pdUeYihPvp+A4LPU9+6039HFpcbh0i2s4=;
 b=kKUha2NgdYSMiaMzS8ew7qsg0fPRDflm6UO5hyvP3471aLeYmrjFM04TC3k2k2NUQl
 bnoqzEqsqEIsZKAE9I7HjCtAPL4AfgfiAWdq6rJa4KZkVyBq/R3UQKdBjdnHygoJebTa
 dqJM+2x3ff3IctKp+zEelx0WDZ+4MEWSkm1Y59hw6ITLbB/RA+hWw4b5C69LCERhDR0q
 9jmm0k0hmwExGUVLvizE01uF1BzbNWkrYQCIoVS2qX1P8+4mVOUv8wI5IdkfRO091OO1
 i9fdkCgxiRXmGUMGV3u3MSVSsQerc61PTVAXtfNFymytHBaou4mP3WHFOUW+CQao66hh
 hRxw==
X-Forwarded-Encrypted: i=1;
 AKwUvByB+huO8L4NkmtmbNz+Sdy/Zt8McHSCFOZbWjPQq+muhHkYurJyilfSPu5fIHBbdJuaffg6mwE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuVznjzknAiQBQ5Ig4vXVObajI12bgKUBz3Jt8ka49pLHfou1W
 0nbXEDwBbi+iJL9fJ1/ovVgB+Gov2ycFDJpSrt1uzO8YNa7vlgdEpfvp4xe9Rzyx+zQ=
X-Gm-Gg: AYBFou36tmwhLeIGoTnjF15gD51Qe13WkPxsN3pin7Go72QtYJ7mQDmyBOCSqt3/6TN
 xi37zbd4UPd2TPSeBBTB80WoSMDtthKqke1yX1e20ZKbpiq1gA9aaXCNLrFu4+Yut3jlgn09grp
 EW/OobleUk8ixRrRSIgjlEl8USiP7LB648hVrDaZdyyCcMFSvD+ZNGuV3MShQ/mpvgqKLCr0BJz
 nFxpnUkxjlqB2+9dwOQgB2PvPCcbfIuEthIZud17hdEDvfSoOuc8PtxgJhwrOxpGlOtgBtXcuTD
 /vjfNo2F8WU+sIJ3JUppLtzIbNJmEnef2gvGHeSfED8b6S9eOYFd9m87PaJSK2Tkex8YZlTIdpo
 ai53htgpYvMPBS62czpLAc7csnTdPfh7TuMZ2UI2DtKonDSqYKHA+VBn1gxql+hKCZHyINlZmyP
 oNdAhrVjiYND66SqwDBez9z9XV6qEVjxjejW2bGsBwDBzdkua6H1/j3phcjeKUquWJcPT7mJUmf
 0iQb3OG5YkSFpZ9Mxl0uVfNYvX4PxZwp5L0k87JgyfZTCJrj2GuRV6E4DnU3Qynfp94ElELJcqQ
 OWcNjJf4yIslA+A=
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-49cf8244878mr469720775e9.11.1789021574060; 
 Wed, 09 Sep 2026 23:26:14 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:13 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:52 +0200
Subject: [PATCH v7 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-3-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Genio 510 and Genio 700 use an external DDR loader before SPL, then load
the remaining firmware from a FIT. Keep packaging optional because this
platform firmware is built outside U-Boot.

Separate the container, loader/SPL payload and firmware FIT descriptions
so their layouts can be reused independently. Generate the loadables list
to include every OP-TEE segment.

Request AArch64 BootROM entry for the DDR loader. Disable SPL binman
symbols since U-Boot proper lives in the separate FIT, not alongside SPL.

The follow-up MTK_BROM_DOWNLOAD_AGENT option needs the same loader/SPL
layout and firmware addresses without normal boot-image packaging. Keep
the shared Kconfig contract separate so that it can serve both consumers.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  9 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  9 ++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 +++
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 98 ++++++++++++++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    | 17 ++++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi | 26 ++++++
 arch/arm/mach-mediatek/Kconfig                     | 41 ++++++++-
 board/mediatek/MAINTAINERS                         |  4 +-
 common/spl/Kconfig                                 |  1 +
 9 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 223f1371b9e..10b9a142f37 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,13 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 223f1371b9e..6230b016ca0 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,13 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
new file mode 100644
index 00000000000..ff4557e5072
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
new file mode 100644
index 00000000000..d8aea85f47e
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
+	bootloaders {
+		filename = "bootloaders.img";
+
+		fit {
+			description = MTK_BOOTLOADERS_DESCRIPTION;
+			#address-cells = <1>;
+			fit,fdt-list-val = "u-boot";
+
+			images {
+				uboot {
+					description = "U-Boot";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					entry = <CONFIG_TEXT_BASE>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				atf {
+					description = "ARM Trusted Firmware BL31";
+					type = "firmware";
+					os = "arm-trusted-firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+					entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				@optee-SEQ {
+					fit,operation = "split-elf";
+					description = "OP-TEE";
+					type = "firmware";
+					os = "tee";
+					arch = "arm64";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					tee-os {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				uboot-fdt {
+					description = "U-Boot control devicetree";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf";
+
+				@conf {
+					description = MTK_BOOT_CHAIN_DESCRIPTION;
+					fit,firmware = "atf", "uboot";
+					fit,loadables;
+					fdt = "uboot-fdt";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
new file mode 100644
index 00000000000..c97797405b7
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/* Include within a section: the loader and SPL form one contiguous payload. */
+ddr-loader {
+	type = "blob-ext";
+	filename = "ddr-loader.bin";
+	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
+};
+
+u-boot-spl {
+	size = <CONFIG_SPL_MAX_SIZE>;
+};
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
new file mode 100644
index 00000000000..a7ee09feba0
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <linux/stringify.h>
+
+&binman {
+	mtk-boot {
+		filename = "mtk-boot.bin";
+
+		mkimage {
+			args = "-T", "mtk_image",
+			       "-a", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
+			       "-e", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
+			       "-n", CONFIG_MTK_BROM_HEADER_INFO;
+
+			section {
+				pad-byte = <0>;
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..e572cfe8571 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -207,9 +207,48 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc;arm64=1" if TARGET_MT8188
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config MTK_GENIO_BOOT_IMAGES
+	bool "Build MediaTek firmware images"
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+	help
+	  Enable binman to assemble the MediaTek BootROM image and firmware
+	  FIT from U-Boot and external platform firmware components.
+
+config MTK_GENIO_IMAGE_CONTRACT
+	bool
+
+if MTK_GENIO_IMAGE_CONTRACT
+
+config MTK_GENIO_BROM_LOAD_ADDR
+	hex "BootROM payload load address"
+	default 0x201000 if TARGET_MT8188
+	help
+	  Address at which the MediaTek BootROM loads and enters the external
+	  DDR loader.
+
+config MTK_GENIO_DDR_LOADER_SIZE
+	hex "DDR-loader image region size"
+	default 0x4b000 if TARGET_MT8188
+	help
+	  Size reserved for the external DDR loader at the start of the
+	  BootROM payload. This is also the offset of U-Boot SPL and must match
+	  the offset used by the loader when copying SPL to DRAM.
+
+config MTK_GENIO_BL31_LOAD_ADDR
+	hex "BL31 load and entry address"
+	default 0x54601000 if TARGET_MT8188
+	help
+	  Address at which SPL loads and enters BL31. This must match the
+	  platform firmware's link address and secure-memory layout.
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d0d25b096e5..4a574250fb1 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -22,9 +22,11 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..f9b453df766 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
+	default n if MTK_GENIO_BOOT_IMAGES
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in

-- 
2.55.0

