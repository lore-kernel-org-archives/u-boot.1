Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D325C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA61D84A3A;
	Tue,  7 Jul 2026 21:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="IrSA0i4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D7984A3A; Tue,  7 Jul 2026 21:12:04 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F5A849D2
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-491bc1d4e6bso3224469b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451520; x=1784056320; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qlqKZGvN81+IXT/iqDRFbb0h2Bt+lYTD3yi2XOB1P6U=;
 b=IrSA0i4FgqswgjDZPfJ4R8NDl+4HRun825KHeDKGLp8JJWHgMXW/lEFhdWqyAXlJIS
 ZJNQ11ZfXxt7YsiNk7R94DJNYSf2bfBcZNozV9Uh7EaskRZzdcn0Lxmh1e6OybjEDIno
 lFSgGJ50YaZR/FVlddL3jJde+VuKSkkz/vXO1XVFCorN4wYwmNuozHZ+aevrd33gPNtI
 HhWdKDdNRVqJcVLroLbPEmp4RhtyMYqZ+vBI32xdSlWhdw0HaWwxpMRu5W5ARwiHA8Xo
 lap/kqOhBPdG1mnVowtNYuefYMvgvjiUHAbeGkb/BWwXqqH/htQsvS1P5RVVh30B1zmn
 1Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451520; x=1784056320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qlqKZGvN81+IXT/iqDRFbb0h2Bt+lYTD3yi2XOB1P6U=;
 b=Ay8cBe/cck4Pe0wz4AmGSr9jkuY1YAf0fIcHM7EdicDqHyRH8UT/jmVmBumE8WUu0N
 e13Fwil2dnZq2z/PLiU36ADS0f6ElnR2Zh9fQo9uKoOVCwXS7RKHMvuy8xzzjYFMccX9
 q7YMnKVxtbHNo8mqtbUUEmv42Q4T416GYgDnWI5TkE5PNZ1C5Mra/C2qs+/nRe35iKru
 iYiP6JkFx4w6D/2ft3AUWrHmaxRIsOaHTUbges+UAsWi0BsVB74zTHmzWaxb3eFW5orI
 /gdzQUJqhTFGHJJ+WMVJN/xDogn3fCGRuDLeeYMDYig3Ya06Ad37xUod/ak79201FBOW
 vAjg==
X-Gm-Message-State: AOJu0YzVbK9ik+lxTW8YACtWcXAI8ATglgteqwvVATdW+sCSbLXrKXvp
 42qSnpshgYuRBrwO2Y2KlUl3E9v+OL4C9WCDTV7s16Y8VYja96zBlZytvsNJT22xego=
X-Gm-Gg: AfdE7cmlgyMsnMV6PVJyTGor0/eflihRyCkKM+In6Oweysb3txfdgcS6amdXvlukDzb
 0yJPq1lp28Jr2Nbp4KBrsQRmVw4UzfJzaPg2Gbqk/bbAXBKXDJ+Bfuzz+l4r1U54u2CP60up06A
 fgE4cuLuo3HCI0AbIXeHTQSok02Tid7sAdSUlfoxmNtXjm7rIAUbnszE8wqgM7UCmbXfM6RNWcE
 ZM7HpGFDDKc1+VeOf1AyXrYV2hDkVr4dlInGtWpte+qdGmh0XyIkHnVvOE2pnfUvYQiqOxROkaD
 vRhLb+ebM5QObHxvqCQQpyRQf93YrulWwNwZJQ4u0qq7+qSkQeo5sEEf2/NOBLY/Jx2NJt1kRRx
 MY6wks9S0ree8D3ZMVhpl0/9g5ek8VApbmrpxXQRG0xWvaGjFTqgLkVkG247lWjtagNXMluqIzP
 HDLYPVGMGKlFElr3j5ow==
X-Received: by 2002:a05:6808:14c6:b0:486:4892:d553 with SMTP id
 5614622812f47-49fd8df6a4emr5567497b6e.0.1783451520611; 
 Tue, 07 Jul 2026 12:12:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:04 -0500
Subject: [PATCH 02/15] clk: mediatek: mt7623: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-2-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GqhQ3za4mgX5b3bjMPBw9jyxhPX+AAHTlVj9eqVx1s4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8d7/vvnOVCmGvhorC+Bj1/ql9uqswZ/B/51
 dNO5cuqWh2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ao2wH/Rxrk91yDWaMo0VELspiU1pPR6TCh5L4oJrOKXa
 nB9O6mTvoOFfGB+kHpSqnXUjtnyL7fhdKM+YsrMQYRGJQBN2kqIU9xTt8hQkQv+ivly1sU/4NGJ
 jRfchnOcUrKqiYEA0+C1qPBCgGi/9fAtuy1Z5O4CKRp/YSCcfOvizbiSjkf2DtrdOaZci1eHcPT
 VdYDgbVbSFCUjq0dAoydR6q5VXpuUda3fXDmDoZ0fJkrElUPe+UFCvPZUWRVZ46m37ZASGtteDy
 LPZoMecr/ydP6SUtKQSowKczjLvJFaz+/TMvYROZ4QUc3cfpC+Dnm5YAVcI9Y5T9uvLwkQfnM/D
 wtqc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change driver names for MediaTek mt7623 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 994413a6a1b..0bc19be55d5 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1153,7 +1153,7 @@ static const struct udevice_id mt7623_mcucfg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_mcucfg) = {
+U_BOOT_DRIVER(mt7623_mcucfg) = {
 	.name = "mt7623-mcucfg",
 	.id = UCLASS_SYSCON,
 	.of_match = mt7623_mcucfg_compat,
@@ -1161,7 +1161,7 @@ U_BOOT_DRIVER(mtk_mcucfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7623_clk_apmixedsys) = {
 	.name = "mt7623-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_apmixed_compat,
@@ -1171,7 +1171,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.name = "mt7623-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_topckgen_compat,
@@ -1181,7 +1181,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7623_clk_infracfg) = {
 	.name = "mt7623-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_infracfg_compat,
@@ -1191,7 +1191,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_pericfg) = {
+U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.name = "mt7623-pericfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_pericfg_compat,
@@ -1201,7 +1201,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_hifsys) = {
+U_BOOT_DRIVER(mt7623_clk_hifsys) = {
 	.name = "mt7623-clock-hifsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_hifsys_compat,
@@ -1211,7 +1211,7 @@ U_BOOT_DRIVER(mtk_clk_hifsys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7623_clk_ethsys) = {
 	.name = "mt7623-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7623_ethsys_compat,

-- 
2.43.0

