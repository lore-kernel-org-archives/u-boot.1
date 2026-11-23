Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6198606A31F
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sx3dmcbq;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WwpmO31q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA70A80DDA;
	Mon, 23 Nov 2026 12:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Juj352ov3ZLr; Mon, 23 Nov 2026 12:45:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A6D080DE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795437909;
	b=W/eiEtkHhjUp7Lz2exw8L98G8Hw6HnPGQpMP5yQUw8jJliyOWOrKMwb/M3n1JQw1CPOZ
	 BRfq/sJvchCqo/7OKNAPtKa79FYxwtLhnm2bkuCgCqmniwVJTex1fOCV7GZ7zotAX2Zw3
	 TeJaHmedPUp0lDWscIpjqa99DSJtUVJkdTPdKAhBzFeCl28o+UhvrSzlaL2W/anEVykMZ
	 1OrT7nidsaoYEAOlJnZGCtnv8n7XG1Y3OdOsvD4CFxxOqhMeX8gjHX6YZ3U/PCCxP+ikq
	 yny/JMfeFsZzYN6WFVFqgU5fmdjlZMA+xJWfvsXL6+x57dyvkrM/K1zUQnXKbvBJ2gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795437909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Gc/YXrJevwJj/wRSQk9SM6xU+fRIfHUZOR0ffdJEyg=;
	b=WrknyK9P5ckCe8TTGXf7t9HQYf/QE1IfbHSwPw4HPuabDfP1gQnF213UhNhc/BdtAzcG
	 M9Pgy/WmCNAP+EatQWh4gKTiB7eSqC3kkKfKW78n1oBuk569J8BtiZJj60Ep9DL5H9R2h
	 04ZxxgYuDJOtO5cq/gq7sHRgmZg+WMjfwPJaQNOJcyn8Hm2tRT/fuOq+ykYPTM0Tfns2+
	 lIgeM8ys4HpAAEufxMoH48DT2AbNK31IUumfxQBfUbvYjGWy++4HAetkr4X4FZ3Km0Yrz
	 z7NTadqqYNNEJ5dGkRO6cgPiO8M7lofobjQHAF2CpvsG50yQdThQ8RSJah7UaGrcx9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795437909;
	bh=6Gc/YXrJevwJj/wRSQk9SM6xU+fRIfHUZOR0ffdJEyg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sx3dmcbqNXSDq9Kq3fIyA+du9lJdTU0yuCFjaMDfXRIL/sVScycrJDLJQfC21VjL7
	 mgrtnMPPwHWwXfb8odKZhgPu+gSaCoRX6ewpoGWfY37unQpfNk1ZqLMSJX5sCBr1T1
	 FR5jYxrywUB3Z3LnK8talhLYNR7LnJcnmR7j64ojWK8rEZCF2bfWvEinJPYHoksdTA
	 9rrbiDE5Ohrv7V385upn9X6wUtzEYJHiCHujeIDpqaM40xlt9ihUn91Gm2o7BqSHKu
	 41mKHhNlotq8S5WwYIXqKpnf0kmVJ4OAj2GmKhRPPkLa2qdnDG0jhJ3rNiyXC3BLwk
	 4PnU4ki89C4mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A6D080DE7;
	Mon, 23 Nov 2026 12:45:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE1D3A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC461405B2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVGge6_43-iu for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 12:45:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CED27405A4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WwpmO31q
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CED27405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 12:45:05 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso29889785e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795437904; x=1796042704;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6Gc/YXrJevwJj/wRSQk9SM6xU+fRIfHUZOR0ffdJEyg=;
 b=WwpmO31qWYrZ5gbk+jR+OzuDSVHmE0kUJ5AraSBBKyXkq7GrhHvW9sEum9Afa7waQy
 yfBeMSGdl41yyRvFrtyZJ9PW7tbRwZ4w29Faqhbmj//+MQunGF/eRuoSLml8M9TYUK1l
 idZQSCgNPkvHVqqxdyEJdpnkYJo7lLv5k3u2Rr47jvWdcatJUR9p2xtDj/ACeJRS9n0J
 lgNi2jplNCP+KKYcEHxHwds4ztWb1i/OzJdWkboSKoBuV9j02mJYGsxp5WWwTHBp31bs
 miRhgsJ+Qq4vWtTwCdJiL3C/CpuP88jo7J8o+jWTHm4iRoVpNBojL3+sTVV2Xkkef+e+
 +Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795437904; x=1796042704;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6Gc/YXrJevwJj/wRSQk9SM6xU+fRIfHUZOR0ffdJEyg=;
 b=wyelxPz8ZgoV1MKBQXbV1WqzrFb06mNLfZHUe5AQB2hfywi1MSOiFU7bNnLMb+ZzrY
 2R+c+IynF53LAj83cFyQW0Z/nT3qXHgBBLsNBVXgosuly/Kaecx5ZKVE95byxPANGEh+
 0Am3LfzqLZGgBpl6qjI1fJZSxPkTn5ulHPHw1WN/yrCC7RpiUpqTof6LNvgMUW2wo03M
 RHsa0Ny/vSrd+pT1s8V4Pg1FjH0V785nsaiMe7fuV47A+zAjVBLbmOygUhvIlr7dsHnC
 cxEz6wBgR8nuy7m5fPZNnQwZIxYgSgl+LXH+gaiDLP2WfrFIfXUxzQcK8V0B8TxyQ0Bi
 m2iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFakVtYIldC0TOBD6DNzTFm8pr66qteUfFi7Jernt9azc9vQJ32oSTmWRvGys7vxQ8x0XdK3Vc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9wHRXFcLvCqFExKvly6unM/83UpM1q+Xs8mnlfZAvBo5fZ1cKl
 twvzDJv3bb664tlpOlGneEVeFpePvfziEIH+qfygVSVA6SEDjLH37ULd6Gzhpd5W4Ww=
X-Gm-Gg: AZFdTZcQ6AsEqC2FKaaPyRcD0kM/IKSYYf8runHVe4GQbgPNwSQjRRscuHwMtzsD7+K
 GUv0x9rY6SQYZrN/1i0Trw1VadE/OqUUH0NvlJv5bDmy3mk0wXPHh9zn9+dXx0ZHZ1wwC1FMQyd
 CkWK/Yq8UQEUmVKM+cAocjAq1JrwULsaxuNYa62C/3aycleGqYAMuTn75FuWjP5sSWPFzYvdOvZ
 OCBt5T+BF6/XkgdLDxeQ0+LtDqAUHloa2HVujjXlOuc7qg9KxrVQcQatHWQBN4UttgBPUsn96OW
 xJIsUn7xMt+ooPpABHB8P6G+/t1ceB0hXaBkJ/7O6s6JLdkJw2Je7o/wNDbrMUUwwRY16zbIu2N
 nFRdHHUj4igfqe/PJ22XIs9S5U9y0UZPiJ5PRhPzjo8hFPKszRGYodH+pT+YZgto5iKv2Jvcvm0
 EjshItq7NftlppiluCi6iXxDd+UD9zXOuJy+Opda/NEbk1aG9KxCFgfSe6qvXIVZKt4bZ6g/Xu9
 HqkxKhplm8zp6GOPnsU1MVyFJU+DBLnCfPUviToApByrAJPZTFNSPLBALarBYGUHaWHyQZiU9Cz
 0mSt0o7opJ5YXGLGPHVLJSOoUKVNXX5fUTIaLRPpD67wNHy3urgdHjc9gF7I+RcRJtMU36tlpxb
 aeIKujGhB8Nl2t1nTMXaDmif4FEvRNtznSSXO04GyufXbqdei2BnlYYOo5yvrvAczed8=
X-Received: by 2002:a05:600c:530f:b0:4ba:6d8:dfad with SMTP id
 5b1f17b1804b1-4bb88811eecmr223666045e9.14.1795437904144; 
 Mon, 23 Nov 2026 04:45:04 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm347228835e9.7.2026.11.23.04.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:45:03 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 23 Nov 2026 13:45:00 +0100
Subject: [PATCH] arm: mediatek: guard watchdog reset by phase support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ccaione-upstream-mediatek-reset-wdt-guard-v1-1-8de81c406ab6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXNQQrCQAyF4auUrA04I7bgVcRFmsQapbVkZqpQe
 ndHXX7weP8KSd00walZwXWxZM+pIuwa4BtNg6JJNcR9bEOIB2SmOlEsc8quNOKoYpT1ga5JM74
 k41DIBbuOWyY5xp4E6t/serX3r3W+/J1Kf1fO3wBs2wdFC+/JjQAAAA==
X-Change-ID: 20261123-ccaione-upstream-mediatek-reset-wdt-guard-77c6cad52bad
To: David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

Without SPL_PSCI_RESET or SPL_WDT, reset_cpu() on MT8188 and MT8189
still references wdt_expire_now(), which is not linked into SPL.
Only use the watchdog fallback when it is enabled for the current
phase so these configurations can link.

Fixes: cdc0564d4f4a ("arm: mediatek: use phase-aware PSCI reset on MT8188")
Fixes: c96905d0d61a ("arm: mediatek: mt8189: use phase-aware PSCI reset")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 2 +-
 arch/arm/mach-mediatek/mt8189/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index b2cdec8c218..96dc1feab66 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -35,7 +35,7 @@ void reset_cpu(void)
 
 	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
-	} else {
+	} else if (CONFIG_IS_ENABLED(WDT)) {
 		uclass_first_device(UCLASS_WDT, &wdt);
 		if (wdt)
 			wdt_expire_now(wdt, 0);
diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index a0de674c452..1c9714baffe 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -38,7 +38,7 @@ void reset_cpu(void)
 
 	if (CONFIG_IS_ENABLED(PSCI_RESET)) {
 		psci_system_reset();
-	} else {
+	} else if (CONFIG_IS_ENABLED(WDT)) {
 		uclass_first_device(UCLASS_WDT, &wdt);
 		if (wdt)
 			wdt_expire_now(wdt, 0);

---
base-commit: 0b3875426f261150e6cf9ee14aacad9b76c07937
change-id: 20261123-ccaione-upstream-mediatek-reset-wdt-guard-77c6cad52bad

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

