Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0378ECD9B5
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D0683B0B;
	Fri,  6 Feb 2026 00:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fU3LGw24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FDE800AE; Fri,  6 Feb 2026 00:52:18 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88782800AE
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45c70afbeebso970740b6e.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770335534; x=1770940334;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IcqXFxa7UNGxVkb4LjSpb7nbh5Jt1d32fGvi1mcBbqE=;
 b=fU3LGw240Qp6epe74j9HcJt36UdtHQAeRVp7wNrymO+TJ9h82ac0MbT/cYNcEj88aV
 3PnvBE0eTBq1oWggFUsrRKmULMXHbtmUc/HvN0yz/tV1xP2pAWY547yLWY3plrAmnJ74
 MJliWxn3nUPbNPiIieryNwU+gw037k+LPkK09TnyB98jlqPS/Kqh4ACgH+psgv2rrPdt
 QrWxmOkYHktFZcp160PYpt8q44U+a2dr+R6TwVU5f+t1ukA0QnDS6DudHZaimhw8k3Z3
 s8TExUM6bOmHL6WZvX7o5OvcFXmCIDPiZ2UqVZK3DZBpxhv6j3rHlJulwqApJ2uBNlHX
 oFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335534; x=1770940334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IcqXFxa7UNGxVkb4LjSpb7nbh5Jt1d32fGvi1mcBbqE=;
 b=LNMyezeFYyML57E7+NnTFoFI6j8oZXoeV3QLRieAa2DDawFVzba0+FNRJ1sFwE1UNp
 mMIlx9Pec+olQ20LhTITOI6sjaxGdSj5PEI8sAXnpewWheKBUltWeQtEuyUZ8dc39gXc
 AEeLqgBhOkIw+7Tf3s6zHGPm22XAFHp8fOYGTrJI/XBRQSI8YZQengAl8JZs7mR+1sGq
 f7kBvY2M0udI3Ns2IxxnVE7PodFNeoYZjAjN3gGY8SHuuqTKa9f0PukhJPXlb4t6mElh
 4JMaumUWkq0ndmkKvoVFawxdBbU3EtDNMZs1PHgKcqjrpXK+Na8xKFgFDjxdOMLftgD7
 8cVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX39X3u3aA6HS6Hy+XGK18AfKfyyRLNq7p8MrNkE++hoB6MW2ptdVDZUiVkJv4dWRmPGZKxnhE=@lists.denx.de
X-Gm-Message-State: AOJu0YwVcMWekYfIAQlOsUELN/YYFu5RX3q7Yb23n9Vaf+UmXdGt4dQf
 0rm5tdoSfiS8h8RUztrR/gCUzmQovVgg+ZV80wvHBnZ1/xr8Y+SMR6iBOgPf/d6tQ98=
X-Gm-Gg: AZuq6aJHox7lOmdTTukx147AMCvn4a+GZlcFUqRqhGSqCkJl4RoVc2xzHjobvpj24uC
 SDZmi6RnYUE2WJmKWV42SZEV7JWD1suy8vAxk+4Pq460fLzuPwS9LDyh5WpfSSlP/LynoBeLaBc
 UjriRnbU23lgbIevaatS6vR4VlCmGRYskZ9jDxhMQoLv8h/R9o24fnzg65qvYeXiIl1Vd4xELia
 wwclJ84OrYChqSWuK3rBzsT3mi6gzT7xlMNDAJEc3VzCDQZsb2xR9+LHoQrgkMGm78ix/SnEzuh
 MqMksT7q5H27YY3irxUIyxF+UdGpXhjODd3NSzA+NyBSuDU6NygfGi00ViAiWuYKHtf/BsrGfGE
 JIzL1gO/6w9MJ9sM465gHI85+AkWdvhsMbXwIPIH45lJIFDqbE9y7jYMSsb6hStTRac/7L4El49
 0c1SlmYx9Z8USFmgM=
X-Received: by 2002:a05:6820:4b15:b0:662:fd74:61d0 with SMTP id
 006d021491bc7-66d09ac26e2mr537964eaf.7.1770335534226; 
 Thu, 05 Feb 2026 15:52:14 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3adcae3csm312165eaf.9.2026.02.05.15.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:52:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 17:51:26 -0600
Subject: [PATCH 2/5] board: mediatek: mt8390_evk: remove empty board_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mach-clean-up-duplicates-v1-2-b7d4a43c18eb@baylibre.com>
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
In-Reply-To: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=f9ky2WuqbmXYjRAvzIVgmtJ/BHoA9ZpleuDqy5iFJx0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphS0QwMDVOSx5RX97xRx9y+VHRwCzPH5gS81NF
 BE+rc1BXcWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUtEBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AR1sH/20W9fv+8dKH/zO0SU7GOecHMO2pVS6ZjhRwB71
 Kj3zW4VvAVb0pbkFIH+YEkbbOfuD/umK7dg0hMgSvJ3+rgQ7zx6pzPqX2WweeGMFQiATK89/xMo
 dXwYF+N+P7sh43XHtYBQL8isGT8PRO2cV8v67wh8dh7DCdJQhPaco96rD3rfEdLKfLvX6XWvyxH
 mGJAo26xZVGjDRoleNig5PoZ975YQTXQ9o5I1zxEiMSj2BUZKLrZJ6D64AkVSaJuF00VjLs4x1K
 2eNvsbXidKE9iNda8x8Wks025vh1vz7rP8EVnMDojZfOOX6/tb6xFruzAdu2t4Y90E5H3cCHU2I
 4TxM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 00:52:32 +0100
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

Remove empty board_init() function and adjust defconfig to not require
it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/mt8390_evk/mt8390_evk.c | 5 -----
 configs/mt8390_evk_defconfig           | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/mediatek/mt8390_evk/mt8390_evk.c b/board/mediatek/mt8390_evk/mt8390_evk.c
index 1ca40366a55..5731199bf83 100644
--- a/board/mediatek/mt8390_evk/mt8390_evk.c
+++ b/board/mediatek/mt8390_evk/mt8390_evk.c
@@ -7,11 +7,6 @@
 #include <linux/types.h>
 #include <asm/armv8/mmu.h>
 
-int board_init(void)
-{
-	return 0;
-}
-
 static struct mm_region mt8390_evk_mem_map[] = {
 	{
 		/* DDR */
diff --git a/configs/mt8390_evk_defconfig b/configs/mt8390_evk_defconfig
index 9bc1d922587..06437be625e 100644
--- a/configs/mt8390_evk_defconfig
+++ b/configs/mt8390_evk_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_IDENT_STRING="mt8390-evk"
+# CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y

-- 
2.43.0

