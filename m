Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842FAC9830D
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3192040F58;
	Wed, 23 Sep 2026 21:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvBRfnwo93OU; Wed, 23 Sep 2026 21:18:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 158DC40EF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790198302;
	b=EjG4Pak8aJZW2S6F0wySQWMp0ZAAheEUo7r2shdI2EEKsxChOX7aMgaXdYRkmhEkIaR7
	 mjFGElCmMhQTph6TVySTQwUJTHdCZymh+XQXCp1zTknrcI1WanuLNp4N/ocuZDNqsvcPD
	 6/CtchuJb0UMPv+kO/L/Zp6SZblCHs9m19v87RI0/jLV+U0lse/gcmgiVH+ywyX7iiLLG
	 1mtGSt3M2xyU3YOdDS+Q3LMuCKtyTK9uC7vdh22G3bQm9FQho2fD0j9lvMBycQzwwImpp
	 604tGE7Rc91RcX06j3oX3aUMLC50vHnBTCap3Z0g49+DpSJ1LB2AkdzzyCzPTBhIYLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790198302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mSz8qWsChTBNjc0v0CCXnBN6C5Qfjb7ISGfJ6I9SCxc=;
	b=Pbr29GJ+J+U6kiLHWdqWuipvSnmbOVMcprswYS5ZfGAIHOUjFv8zDwpWN9/ytBCI9Y8I
	 lOkUss3IDGlMXza+YfYeqFtS8ReTwCHRQSnScofsbKwgo1VXvJCAbimDKbTmAtMZuBEhf
	 Icl54IqPB0mDk6+PTs1TyFjKmdr5s5eor0ZimkhZDUf2nWZ0ByHMva0mn6wCGmTNEkxDv
	 AD7xAVcWKSNLMCe9/M6KK4YyUU5paVApWx4Ay5yJbGyhf+bLJN+nLSzii6d5JnR+Y8+1f
	 yEmKbGXFWpiGZz+LCns/FaSnC0RlgfkH7QresKqk6Oc41ismZMVVXfbi11676o7cjVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="au/SgaLd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790198302;
	bh=mSz8qWsChTBNjc0v0CCXnBN6C5Qfjb7ISGfJ6I9SCxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=weC7bDeVSRvTkHHlobKWzv1Pc5CsPk3JKHgVe98rpwrzCAwP+8j+tjlLzTu/faH1u
	 9K3Djaci/BfdD3IgujDLnjiG44sK5uNP7BmeiVRzsj3WcwcEV7Vyca4k9SAtGYlEaJ
	 UGN4PJ8LBcAVYX4xaab/fuHXNF6XP6XInoLIM0ecomvbZxwmdJH6oMMCoCuobIaHgG
	 Z1IC2+1kxCtiLxWZizPENaUThlvhl0K4AhCBj+mC6QOtlaLzF8nDfdqSwLn9fGs9Ob
	 5FfkLl2XLr0k9Imx0hclP20XSCQcvSU9LFpzd2muAOFZumbjWxwoaJfdnBCuOCYmz/
	 mhk+iDHXKBfQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 158DC40EF8;
	Wed, 23 Sep 2026 21:18:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91C4428C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F22740ED9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cr_dwNrHKNji for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 401E240ED1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790198297;
 b=jJczVYGQsnOmhP9hvqrOqIUWqiS6eEig4mKgGjn8F14tEw9MQ2iAy9jyG5qXvKXBdi1g
 CCBVjmEu4wcenI3XC/SyRuWFZyi9tA/NfmginVYu/NTeprQN8dc3ENU8kxNE7FJ/2VZZG
 SveX6ah0DNPdzRpSkEFZ1Pyk3XL7WN57yvuTR39Wz3GvaaOBxSmuVmXSXGBO11JKn4rMV
 5/3yKKDVcl0+bGaF0v/QPOc8y5pKJwEyh5xwXh9wpgWrp0tNN0UzvPgdiM2FAoNyncP1v
 qFIWgHfTthBCpw4Q5o/iLOgb4+XIIXX0EeJV9dF6pQ9SwaUhbwZ5rOEm0Z/52jx0jLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790198297;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=mSz8qWsChTBNjc0v0CCXnBN6C5Qfjb7ISGfJ6I9SCxc=;
 b=RKqqNBzPars/8mkKcqbTgMdY7CbrgMiZre0md5xkWmN4p1jurZAxo/eeQBKjrzm3jJvU
 m19raDao4XaOWukCmOEMhzrm2+D0nowvxq8MDZaGfbtELeAvJAWvjV1LiD3TsVp9rD50h
 jpWCYTv4XVdalK6y9fAdH4+PXZoHNWwK1EQO/LvLNa0nR19l2P9eIPRxU41kE9nWWE1lj
 SuhghJHZ81VvfU4ZhxsWZoU1T8XV0bCtuoj3AwYco8bveGoJeHGPDFDT5Vz5zI9GXP7fF
 ffalISDxLkmWNHtMEKTJd8G6OC9qxNz12voKIz9AyO+czt74TfZLczxEU7BdI5SMICQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="au/SgaLd"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=au/SgaLd
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 401E240ED1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:16 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e66390995so8835245e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790198295; x=1790803095;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSz8qWsChTBNjc0v0CCXnBN6C5Qfjb7ISGfJ6I9SCxc=;
 b=au/SgaLdbQK+YGgVXu+QZWK4LXtQ7uvMmICvzWkG5TZVezVTpo/71WzbuPEN6iwXyR
 AgNrVlLBg0wubbJPAuTEYdpMXDZZsiJO00kJppgY8RP3UrFReJoe3uQlKLAJ1JpF/Y1b
 PdQI6q49VnrH8dzW/1gV1GBqynpJwGJQmHWRkASbgYQtIjkehpzWUAx29KE8oPAk48uV
 LRKLE3QZBOan12024k5EEBH66WirY5+lXRMyY9GRYPW+GXmuMyTG2w3nKpr7O8yvBq4D
 +rSnMUDisJjcd+9eTfR4IQYpZIG/qr9cbj4w8GTQhQy+Kb/zGY5eVikv73Y/OCbXMkiC
 xVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198295; x=1790803095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSz8qWsChTBNjc0v0CCXnBN6C5Qfjb7ISGfJ6I9SCxc=;
 b=Sm4CbAcpcmsVp73yJVUCjQKnt8qFuT7JSeA2209ViZA0BVu8DrW3oUoldxsw2PjbkX
 aQVzrReiccANlkkWWXgR2lL1rESsXttX/RthQ5CwAGS9xGb+6otNw4XcyahgJlAT7lgs
 3vfTZyHftMrFYGP9KbBGoTYUfcrxgYQVbe6liCZf2g4odnlkVPZJbRt/zSyFo4TcqfBK
 BUR3IK2O0lbJZ3cXRNdwtY0NYswEcraoKnAOMPf19S8Jowy8nCMCIiZNuzwLCvwlCeOq
 k94Ndbt117AaN9gzroOMhvkCu3YDpLjiv9/o0anMqISTcl1azE+BEKofFtB/by3mfc9e
 iPeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbU0Sw/V7nO1cMUhrqnQyWw0rovKDlVe4X563LaSgUR9bpHxbcDQJTRSCVE8m3bUdBBsSGelM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZZr06+aVRNKBrMjICOeN+zSjaBx9RIJgzx0PUgIScJw95LIUW
 Nyrys1+5x1ZUnwFB574UpCwjDkwUgIURGpeYtPtYrAJ3cMLhsDC9o+rPnOBBl2Ze/to=
X-Gm-Gg: AYBFou00iicvh8zsCrz6J19GSjjeQcb04jkf52kb2z/Mo1sSRzlyUcziTA9RuEIPiHp
 Bf7RHeyKHkYlfFCeresRV/TiasEgZX7Zjjvz7H6UIU5SwcP5bX1uDuyi7LqG5mTkcRyqrXC7IDC
 5oa8aETlmWOMvbynFFgN0IcQ0r7PLxYYnhPnSZmUe1Do+vK9fO3aaeP3Wh3q/x7lkOMp2kO5mUR
 EfseG7M063/kbUYYLftbdOqTlf5cTAz7oqaNLKiANDZEvrPJwLSFPAkqfjttHoeOpYqnC5PBPMB
 bx36cLFIR/jxujYBhhd1TcZTj5jFkbfLeqgFpVz8OUJOpigtPLpbyk9Yx/ujUkqvF1umA2PC9ko
 bM52kPBKp6rfXmNx2Tqehvhm5H1hnnmdtzF5tlrySp1rGs6zy/2TJQhuL2xO7BGbIZjZeLjzNE8
 TJNQywRD4DYDSQCXB41jeuAkxsfH9m9obMBfVtS+QLkPuA4RXrBx34xBxwfOgW2/QzTAUKu3bFl
 fd6m2ZKpjt5iUYDn13lp2WMu3h2aSAcqSfUYqQiDbJDC633KCHaS0ppmVSWO5c=
X-Received: by 2002:a05:600c:8b22:b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49fe66d3392mr7369485e9.11.1790198294902; 
 Wed, 23 Sep 2026 14:18:14 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm8684345f8f.22.2026.09.23.14.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:18:14 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 23 Sep 2026 23:17:43 +0200
Subject: [PATCH v2 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ccaione-upstream-mt8390-da-v2-2-8f264678ac29@baylibre.com>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
In-Reply-To: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
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

Prefer fastboot in U-Boot proper when the complete download agent fits
the BootROM SRAM limit. Its shell and boot commands support provisioning
and recovery beyond the SPL agent's flashing operations, without relying
on the installed firmware.

This variant requires BL31 and an external DDR loader.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi    |  4 ++
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi         |  3 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi    |  4 ++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi | 62 ++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                   | 30 ++++++++++++
 arch/arm/mach-mediatek/spl.c                     | 22 +++++----
 board/mediatek/MAINTAINERS                       |  3 ++
 configs/mt8370-genio-da-uboot-fastboot.config    | 28 +++++++++++
 configs/mt8370_genio_510_evk_da_uboot_defconfig  |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig  |  2 +
 10 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 2ee7fb1f40c..86b38b0e484 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -16,5 +16,9 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
+#undef MTK_DA_FIT_DESCRIPTION
+#undef MTK_DA_DESCRIPTION
 #endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index 9d0d057cfc9..4ca46bbe2e2 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -12,6 +12,9 @@
 
 #include "mtk-genio-binman-u-boot.dtsi"
 #include "mtk-genio-da-binman-u-boot.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#endif
 
 &ssusb0 {
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 4fedbda9b3f..648cd0703f5 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -16,5 +16,9 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
+#undef MTK_DA_FIT_DESCRIPTION
+#undef MTK_DA_DESCRIPTION
 #endif
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
new file mode 100644
index 00000000000..a605ad2504a
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&da {
+	fit {
+		description = MTK_DA_FIT_DESCRIPTION;
+		offset = <CONFIG_MTK_GENIO_DA_FIT_OFFSET>;
+		size = <CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE>;
+		#address-cells = <1>;
+
+		images {
+			uboot {
+				description = "U-Boot fastboot download agent";
+				type = "firmware";
+				os = "u-boot";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+
+				u-boot {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+
+			atf {
+				description = "ARM Trusted Firmware BL31";
+				type = "firmware";
+				os = "arm-trusted-firmware";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+				entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+				atf-bl31 {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+		};
+
+		configurations {
+			default = "conf";
+
+			conf {
+				description = MTK_DA_DESCRIPTION;
+				firmware = "atf";
+				loadables = "uboot";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index eece6456e43..c24b1935e2e 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -275,8 +275,38 @@ config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
 	  downloads it into RAM. The download agent also configures the eMMC
 	  boot partition so that a newly flashed board can boot normally.
 
+config MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+	bool "Run download-agent fastboot from U-Boot"
+	depends on SPL_RAM_DEVICE
+	depends on USB_FUNCTION_FASTBOOT
+	depends on FASTBOOT_FLASH_MMC
+	select MTK_BROM_DOWNLOAD_AGENT
+	help
+	  Build a small SPL which loads BL31 and U-Boot from a FIT already
+	  copied to DRAM by the external DDR loader. U-Boot proper then
+	  provides the USB fastboot download agent.
+
 endchoice
 
+if MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+
+config MTK_GENIO_DA_FIT_OFFSET
+	hex "Download-agent FIT offset"
+	default 0x70000 if TARGET_MT8188
+	help
+	  Offset of the directly parseable FIT in the BootROM-loaded download
+	  agent. This must match the external loader's DA_FIT_OFFSET value.
+
+config MTK_GENIO_DA_FIT_MAX_SIZE
+	hex "Maximum download-agent FIT size"
+	default 0x8f000 if TARGET_MT8188
+	help
+	  Fixed region reserved for the download-agent FIT and the maximum FIT
+	  size accepted by this image layout. This must match the external
+	  loader's DA_FIT_SIZE value while the loader copies the complete region.
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 6f1ec052b95..120a94c6598 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,15 +33,17 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-#if defined(CONFIG_SPL_SPI)
-	return BOOT_DEVICE_SPI;
-#elif defined(CONFIG_SPL_MMC)
-	return BOOT_DEVICE_MMC1;
-#elif defined(CONFIG_SPL_NAND_SUPPORT)
-	return BOOT_DEVICE_NAND;
-#elif defined(CONFIG_SPL_NOR_SUPPORT)
-	return BOOT_DEVICE_NOR;
-#else
+	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT))
+		return BOOT_DEVICE_RAM;
+
+	if (CONFIG_IS_ENABLED(SPI))
+		return BOOT_DEVICE_SPI;
+	if (CONFIG_IS_ENABLED(MMC))
+		return BOOT_DEVICE_MMC1;
+	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
+		return BOOT_DEVICE_NAND;
+	if (CONFIG_IS_ENABLED(NOR_SUPPORT))
+		return BOOT_DEVICE_NOR;
+
 	return BOOT_DEVICE_NONE;
-#endif
 }
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 61fefcf9a34..29b59852e45 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -25,11 +25,14 @@ F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8370-genio-da-spl-fastboot.config
+F:	configs/mt8370-genio-da-uboot-fastboot.config
 F:	configs/mt8370-genio-da.config
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_da_spl_defconfig
+F:	configs/mt8370_genio_510_evk_da_uboot_defconfig
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_da_spl_defconfig
+F:	configs/mt8390_genio_700_evk_da_uboot_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
new file mode 100644
index 00000000000..5a85b26df0d
--- /dev/null
+++ b/configs/mt8370-genio-da-uboot-fastboot.config
@@ -0,0 +1,28 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT=y
+CONFIG_SYS_MALLOC_LEN=0x9000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_GZIP=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_BOOTDELAY=0
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_BOOTSTD_FULL is not set
+# CONFIG_CMD_BOOTFLOW is not set
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt8370_genio_510_evk_da_uboot_defconfig b/configs/mt8370_genio_510_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..c696e89c892
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..102f61a3afc
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>

-- 
2.55.0

