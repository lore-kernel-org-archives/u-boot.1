Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7AAC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9185D405E9;
	Sun,  6 Sep 2026 15:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGB3oxJGV_iv; Sun,  6 Sep 2026 15:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6EA5E405E5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708634;
	b=HGAXrJmVo7z5unoRYAFs/mjPFnQIumBjINlriezl+BeCqUwSCJnyNcSNsy32zKaam+6H
	 V81jLn/c1rBdqudVNsq2uwUBguBr1ZE158omHjOK7MMUdX3GkGy7uI9HRChSxqrqOxSCI
	 jxJYP2SY0TQGcr+PLyda/SkZcyeLOKVurgaScHyrMfAkC3TFurVLkTIjtF2aNNN2M4xHs
	 aJZxqjx7MthnAStrOJx3OvlmMjritIaJxizyYZROZRJxRpf9exsqQMFIhJ8FFsh2i7Coc
	 SdTYpV16Wz8sPmgGvI4VCAgMLBLF1Mu1yc9swU4257V2O7IoeLwE+pI5kXaNjmmRONw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DPc9zHq4FCNpuASlGHbSEL23EUDoKnjhL0adfmvv+yc=;
	b=QX973AyrzguPfYRc4ji4Nkx/02wo39/ZgzcJaNIXmwmdAXABxCUK2avKgpvEx7rQULq5
	 AAf71xZhtgDJHOi+j1kE17qm9A+luRluDxINeOUu6EtWYUl3y9NHPkhxilfCBVFIdL8bM
	 iJZSjt7cZQudSz0MY2TWPmO78ctBgorB5ncUdvxDgdUuOMzDjF/SmVOB+R+bLF6VmgZwt
	 qBnInO8tjHgWKerV6K5DD+NsoiUx3tg71RmssYU2XOsUOviGJHoUtct2jjUXLx6bABMLT
	 EPrv6v8UUwlnDVrtkmfTFkhWjyOmDq3qKZ/xtgZZ7jglVAcu1Q2pKYaCkgHYE68PrLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fuqnciR7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708634;
	bh=DPc9zHq4FCNpuASlGHbSEL23EUDoKnjhL0adfmvv+yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tR6bSijZxHwmX3GnKhz5Vjtf5ZO1fqLnGKiRvibwjfIzS0Y3C7CT3PskfImwvBuJn
	 qZaf3hDQoy2KC9EZsMGma7WDLvzG4An346x2MBN7CgcZCN9xNhZYC+2G3oM2tP19yJ
	 bmZ75+WiQ+JUSJ6fmitkJdv3NYCUWUIFkQfogtIQejI4TnAzTL4OmN78K8iK1rfpI/
	 fmMZAAoQHSYQlk6nL9AnzGUOP/BB6BycJkf6zThl8YyV/2SxHCwqxYls+jvBuLKDTA
	 DYTbPHCifoDuiXhMkkFCsd3EwJ5EkabuJPxwyuY2OqXl1HBXCjO77KywSGzw1dkjRZ
	 5gWbm82L0rWCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EA5E405E5;
	Sun,  6 Sep 2026 15:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CAFAD970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B160C405D0
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q9v4XQIaXmH6 for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C66AC405BD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708630;
 b=Xb3+HjJu+ptBDs3fAPpVKECCTxFM6bKgwDZYVHYi7GwDWQWTm/R3mEwyNBRiyUJ8JqG6
 KPQt6wfENG2CcgYaHn9GhEJDySTFaGcF/qIhAk8PDsW3k+thvBcOJ2HxiMcyDB4h2o4Pv
 M0YRA/0kl4eSoMBX6jJUL0Ya5cjMicwJaQr/ohnE0u42D31BkoD2Td156mWL37S5bQdy6
 3AUCiRLBDjaDYKlqf5ED6Ss0EpPe/Tv5cauX57GX/WjS6vzWjjeR5Cocec4kHv+F66LTM
 v1pTh2YHNANVNkRgu8lun+lO3uwD8zbGtFtM35AMJC0F5YPG4laWnlVDUjNtB9dt1Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708630;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=DPc9zHq4FCNpuASlGHbSEL23EUDoKnjhL0adfmvv+yc=;
 b=JtF3u+FwPfZzsb/pKQjW3RTdhh5rzTLDpDpNVGmcz8kpJU605RKx8onN6m+TB/2bb8VB
 Okp2FpdAJgb99SewsbiQshFJbx5GOggBB3AYet9HZFml0EXzQgawJ0QGM7aRTlJVePRjh
 n/YpSSnhcJKwCHdz7JwR91zznOPnSDSEpJZeATlDombchF9LgXD0xcgv4WIZMwoPFcsdI
 2AeS4I1YNyDheVX2QmQaukrk7/5vIYGkizzExv1EXbFZ6dhLLDroe3/KhHWfJwMZ/I7PV
 gAILrAJwjrYy9fYroxx4tOXoa/sJooKpBsEPB31iQlt/U8y3gpihp5gUcho60dOCSEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fuqnciR7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fuqnciR7
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C66AC405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:29 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so1722938f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708627; x=1789313427;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPc9zHq4FCNpuASlGHbSEL23EUDoKnjhL0adfmvv+yc=;
 b=fuqnciR7+fa5acfcdOGJmBwjYqy+2xpbt5EX+p6E9W/GgrtIgCR4IrDQMVDJ06fJmj
 O7BmTc2TdnvsrNjVs0r961DGeW+ykrBkQqV1MzBlW+ctKksTCVK6/SBnIZRUq+3lDh1I
 OE3I5Y4vElYBgSWLpUFOBwAt4q6IVCjwlwA9xtYJCH5Izub0woOrWH23yn2hVafbX9mX
 d0K2B3apWAnu2MqoiTJAC6mBku07ho55RHZkuDQg5F5Vtag9Hm6XNSnNJ46lt2wBaM+/
 pr6XN1kSuoqaXKbuTvutAkmBI0Nck+HpXGfxFZcVRoWLdi0n12duATx2A1gE9bqfBavO
 kkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708627; x=1789313427;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DPc9zHq4FCNpuASlGHbSEL23EUDoKnjhL0adfmvv+yc=;
 b=SyduYEi2J04mNK4+4Fi/F6CyUePVF2pvD3PwA61MR1EhzcGtPLA5OkCAgI9g9mEhQp
 t5ZfGIVaauxXoQ47nVid97eZ/cPodFAYQ+au+H5x1H7BMfJ6Oo3V8KA7dkQEhER55FKM
 +abvA1O+yLxHnDXCHCLmFFyyKYvl2NfMOJgY9a3DWT/WlPx57Q2HnAbR1Qe4STpbe3eG
 fqAztVFXOTrzz6MvFjZHoHlD9Ol+Vz8UVoedYBYHhT09AQIN1uprNuugpSytKWjab/PV
 ufGmMUfxKNDvvbn07ozMm/X8Z1yyjGbguUpYCz8eFXziaOiMF5gylYY+LbiAVwD7VY8f
 zmYg==
X-Forwarded-Encrypted: i=1;
 AKwUvByd79Q0p9Ix6EoZRRHtC5WMw5gamEoeaGLWx+wVjtu7EGIFVvtDyholv+9mFUTKsAF8eM2I1Tw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nEINFwrRUm0JS9VzYdUzOGRm/nvKWkQkLIkP+IhxygsDZs0Jd9
 kjTt+OeunyRbtWo2khM8p5Mg1q+kGeTYI9zVs0EIK5/cDgmVgXqgeCgg/lfX7H7ffkg=
X-Gm-Gg: AYBFou3iY6img0VoM8sCcR4MqpCrWDx/DofaOYDXsoGjloSa4bCSLl1/1/a0DDjAJpx
 bZYD+UQpjShjsMVHQrsl4e6iOWQ1QHOjDrVuoA+cZB5MAIFb1fakfZqfAVZbkBrJzlJi13EabQT
 miYXW0xw7x5zZaGAZi06r08WHwMbaLOOYg3FR+w3ev37KlkyWVN40ggrBKdBl6qBqCdShvFfiT7
 emFS2nNFHgQ5o5JTxpEv8LH44st9LnS8Ueg6wso5SwvsnCG5CL+4cCkxL3XV1B+Kb4VlscBa1Od
 6lZ8US4VGQAjnAP4P+pHP/k9Wqv5QbOfe9qsuZikhmmW0avq4HWnMdUinxQi6VafFG+dL/sIobz
 uE9v5Kf6w+itaUEVv+k2uhfvFD+4OnTOAbXUPLDgFmXY2RS/X6YhKwgdaQxJtteSSnb6MwLwksa
 B6DBdeZtdSl2c+9Wu18XR6SfOj2fLvJClxICDZ4Wb+z+yO2iTPAkVHldfCad8aU/5unTLI0T4zr
 8EHM/4wxYVykUogbpmj3NgCnjwjOgwpHyxPvD7mW9tu8bGm+EFdrcRXGjCP/es=
X-Received: by 2002:a05:600c:474a:b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49cf823f60amr157430335e9.11.1788708627271; 
 Sun, 06 Sep 2026 08:30:27 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:26 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:20 +0200
Subject: [PATCH v6 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-3-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
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
 <pablo.sun@mediatek.com>
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
 board/mediatek/MAINTAINERS                         |  2 +
 common/spl/Kconfig                                 |  1 +
 9 files changed, 214 insertions(+), 1 deletion(-)

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
index d0d25b096e5..57bb3095305 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -24,6 +24,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
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

