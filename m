Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C011606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BWVitfGy;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fVKmSQnE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D81FE408E6;
	Thu,  5 Nov 2026 17:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1pyMhL14DMa; Thu,  5 Nov 2026 17:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13447408E0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901281;
	b=sFHe/OYRmJ3638G1W6kvJBbShtIFxC0sLpRD5fa6ARxe0XAFx8gia8TToOTCqoeyWauy
	 1Up/HP3giSMPc55quaRptDI2C6mJuaiu+q2HDwniut2rzOYGzIuvkVVxOcvH9iacusZ84
	 SHslKkZ3niQ7l0TVbY8yIDTxeK+4d5f7F3fFXTdRRMDKt0d5Ts8c15fNq+/QKP5H3Kq+H
	 pd0NA/4Ex9i78g80kKLHWK8/fbDpw6YkVfC1m9iG8Dr+zMPKSjIjyfbpUj1Jde5wwmQxl
	 Cl2F//Gx0pmD6iDx8s1M2JCx6LFjQpr+HaIS7ASyRMTJ2XhizlYH/dhNq7YG8d7MEug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mjm+nm+gUGpOoGgUSqLJucIMXYf7u/oxR3GGgRzPIpY=;
	b=Gd9H4cQySm9Rf/Ln7mdQukj/nHnyiyCboUC8JwInVmxmNdR2TwSKp3Zvzv6X/HKiquii
	 rS7sDjxaPuQJu5+s6ynJopqVfveDdtmU3i/FJbm8WY8pHKC8pSETEyDfQ48kaKzvvOgiW
	 +4FczTvTvhlmlE7TUgSeVUsvwYvZaK+QvkI476pvpiLQVHdaGhVQIRIjEyeoZygWexII7
	 842HsFyfHLXPWVsePHFN/Y8xHPXsY+Jn4JtNxdvAVtEPI9ActRFx9uddbKFNPaRaK5D67
	 J0FplUk3u7uby99QiRcdf5oMik5sUP2bAVzh4aMOnYwMM80BhMy3mkM30VPNEZQBuMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901281;
	bh=Mjm+nm+gUGpOoGgUSqLJucIMXYf7u/oxR3GGgRzPIpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BWVitfGyaHtEvY7tIJ9LLcayx0JXrTtYZNAdMSuVcx4rx5uXiClqkrKEz4/bRT6CU
	 oOXFFBbdibX0Mu0s63eEmPXmitkywtbprKa/R1dhTVJxSyOpnYnONo4K4kXD0v+RuT
	 03IQ5yqhGwjGxD7VsiObHkfbn7UAmLCGXLP3vK6SXcqp7wO/Q7aniQKhxmXVQs5QUS
	 1rscl3G0taYWf1LHOq5MTWj6Q9y7EM2kYwl4lNHrSen6zbOcHnKIG1snq1ZEf3Do6+
	 yDc7vdW0L73Z2rp/KQ10t8MxDVaRQwwPEYekLg4YYLd2AFXQUqHyNoHTyUpuERUhYn
	 NVidhOGSlm1Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13447408E0;
	Thu,  5 Nov 2026 17:54:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29C1B1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1045A607F7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWVDNLr0ErmT for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A91A60697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fVKmSQnE
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A91A60697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:32 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-704597ef1d8so951365eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901272; x=1794506072;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mjm+nm+gUGpOoGgUSqLJucIMXYf7u/oxR3GGgRzPIpY=;
 b=fVKmSQnETqSSkf01UGnpQdk2KIBd6QJaNF7BbTzjR3xefnCCxBpoNHA6vskLjlzZu1
 0fS4bmCLtNacr3u0pPHB/8EEECzkvOGcsS98Ru+qcucjhsMGRbuyO58qr17XceXi1b6e
 xCPf8F3ZDUAjG0m1RoE1OeL0+pLljbv+hegFEb9fbEThQA26I8agX6WYYzjXTt5H53oC
 9+E+zwOUZnfdJDUNyFkeaOORE/nKNIpxt4iZdaY7nQ+5oHy0Zt5tvW7Acvj+5wHp0dZI
 cCgw5jomiJVw0yVZ9RyZeJVm4MZ9OAxpe7Mwq/aOLzUr6JS6lfZ8PW/CPVxTZ7pqN3+4
 0xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901272; x=1794506072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mjm+nm+gUGpOoGgUSqLJucIMXYf7u/oxR3GGgRzPIpY=;
 b=iyyHjGeUJPkdBuojBNYu9AB4p/WQ8OhWqXTvmbaSp5J1xflTIT6WqiAt49fLfkruxa
 GtlRBqJlvHvJ+AFmvJLaGxTIQD4WIyhzlUwfRrAq1whg6+1cq9ARx/GgCO2wQJz2PJtr
 KEeS8dq9Lml+Y22cXlr0BaOxEFA/uBETxUq1kStgul9cNFc29hw7mkUeKRl33PjDfj3d
 7VRLooopo9GicN1uWkwb+OT+TVaTFb8U29oOqiNHM8JPtl9rZyEkhybPeh4Ws9XgEEEY
 dyBglqVAg4Zl0R9j5EHT3BmyWoSe2gr5KAmzAEwl37XW6i2TyEiZYLZ4rLdhoRK27Pds
 DB/w==
X-Gm-Message-State: APuU4Z+Y9j9I4GQ3aHPncLL9aM+qZ+gIhcZoVVnxWkSV51my4MhXln4C
 A+U9rGk3/7tK/P06IEV2qkAfG41qhr7NLUvMELNWDGo8Tj+TS3I630rxxAtRKB8CI4Q=
X-Gm-Gg: AYBFou2uYK8ZoFkKkV4OJ17YXyreVsDzSayxOrMxW4KWgGw5KI7U2W+HqVbyPeBWk/R
 JBpRHnC0XoKgMFFeNCp+A60yxUZHOe0dkKulS/0QdX18YRpmJHBAEGvhuClA36EOCwN0Av1oq+A
 l1zE6dAnxVQbkWrWyAw6IQXYzdywpkeiEid+RD3FG6rQE8jstm8VFRI6Zl3GI8MhmmiSw7O3wx/
 eQ7FRsC+uON4M8AreF4KfSY2tiE/UxWhIfaU/O6HhCLStXdIRNPUqddg2Bz01BQLpARfEUCYZ3L
 3t/TghsHx6BIs4lXFYJNpv3iq9VFjnR07owKl1gUx7bd4T6Z+TJbrZPhBqaseKl0AYYCH3BVtSt
 drn2WkTfNvbKlPEyP9hzRZeNg/inW2ps7EO6e8XDhsVIldeQt10NZbXZRU/IogB55BqraB6cTrC
 FrM8k8CLJQI04GRWmKfoZeYJA/lLLDiCvfvDnlnN6CdIqN1kUSXifezZWHH3tfqESc24xAQ1SI6
 LBJO2Gnd5WqKzG6xWYkCd/ArPTAlQS49IL8ip6htUU4TvnINwuabfIlFnWeiDviSWztnofELvtm
 fVBHCNv3mmmlF22aIX6dT5jN8aS+S4t7IQ==
X-Received: by 2002:a05:6820:1990:b0:70e:2878:8d7f with SMTP id
 006d021491bc7-716e79f1721mr192471eaf.90.1793901271863; 
 Thu, 05 Nov 2026 09:54:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:37 -0600
Subject: [PATCH v2 2/6] arm: mediatek: mt8189: use phase-aware PSCI reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-2-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2yHUgoNZN9j2k4iSs08/WjTJO2LgFEiVAMX4rdmh9AA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MKy4lGrPhMmlp6ry8gk3frmFVLjUdTTif7tN
 rgTYi/8oBaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCshYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A8H0IAIcuNoyU2aEbrhlCdGF7NLHfAlmS+q3rQX17m2p
 VNsQ1Mqxh2wzdsM2u9QSZ3I9juUxNjsfWl3S0ZueCDkKkxRqxuUJPjBnLpxFhp7jVQO7AI6fmWX
 Njzb6dWSKjcf5pI47djIYCHStjXUp4oELNg+aceZbHwN4ytSVym1QvobWnoPN2nKcGSyj7U+I3H
 1dUyQNwB76OuJt/ZEijoGqZfERgU1BgviUpjPwgCk4+IhQGxqXvuS7PKjaHLDbbojTMWzFAZTJt
 vPXEG0p8zzzDKxrP0x/nbC7y7VrP1UdWzN8gpd7o41U2mPK+DpSdaKb9x7FLZ/pSMwbc8BWVEpJ
 4JXw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make reset_cpu() use PSCI only when it is enabled for the current phase
and fall back to the watchdog otherwise, as already done on MT8188.

SPL runs before BL31 is loaded, so a PSCI system reset is unavailable
there.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index c0b7050c6a3..a0de674c452 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -7,8 +7,10 @@
 #include <cpu_func.h>
 #include <fdtdec.h>
 #include <stdio.h>
+#include <wdt.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
+#include <dm/uclass.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
@@ -32,8 +34,15 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 void reset_cpu(void)
 {
-	if (!CONFIG_IS_ENABLED(SYSRESET))
+	struct udevice *wdt;
+
+	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
+	} else {
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
 }
 
 static const char *mediatek_get_segment_name_string(void)

-- 
2.53.0

