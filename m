Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A962C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21DBD60C18;
	Thu, 24 Sep 2026 19:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aa0lRXHN2myy; Thu, 24 Sep 2026 19:44:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D42BF60D5C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279057;
	b=lQFu/hI6xQlT+MIAsum0Mx3Nmt6xeFBAlrwBRs+yfb4hJDn+ansN00fSDmfX/GnC1OOy
	 D3I7D6JSigh8vSPm5JXnhzPCi6VSgFxF0i8+OZcXgM1OrvWVrKY98WCYIc1IMhvM3SRdS
	 xgPsNy52gccwXF7Bf1yiIJbfSwaccWrqLnG02DhNByzkyXklY6d1Ph5PGfEr+YOLUVXfa
	 PjG84xIhvyahEGoHunhwIOXepExYnaRQUzrJFfj37su09O89JDeEmCI5DVwq/9LvMSe3M
	 rgyIEyTqJoSJu8yaPHozMzpby+aKbUuE4X7diwuufSkrQ5yCfw2I56XBezMc2lhtaBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7xhINwPACOS6SoVgLiufUcYYkKuUNWTaHfKUhxrPTIU=;
	b=FcbcJ7CJDW+f/E9PorToY6kPcGREQFlCNG8a9muMVX5y3DEiVW6uWk09MM+y2EUkanwk
	 vRBUiUwKhFTgD3DU4hka78s/I04NZ9CTXTvklKGU1wXG7U+j62MaBtr2fq1mUWmsklk6V
	 IQeTQeofTNsyrJ+0CTrkOxzdIxm4Wiyl1qaLlT7kZcRq2Xvw3DTmdoibJTMxq7/egboBH
	 Do07Mx3rKHIndBQZ4GOT3O3sL+IarAunG+iTl7voNBaSjZ6P4uTZGGbxprS2EVqUMqlJ8
	 mlF5w8PL7nxlC8sfn+Klm1TE/WTHf4KmuhC78RDsVKpvxAprQ111QpFJw1fl9lxbcbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279057;
	bh=7xhINwPACOS6SoVgLiufUcYYkKuUNWTaHfKUhxrPTIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=epWAlrRPicUzdNpXAaSKjE2nxyi3VkTuE5fa9uuXn5Bu1PugqRlXgmQQQep9QC9c7
	 PAbZg9AIhfeNWtz8szdUJ9RZXk7dkBTNg4If3zGvDs5ra+uSTLoLYmAhSzHIfEKbXi
	 656C8ZFbrmTYcEUP2RIwFHracG9T6DZkA6WByFUl/etXxlI3NKv9yPNJICFHNMxwgI
	 ZeLzZi+fIscABv67f56x8lp6202T61DYKXeRjHfyMb1GSkJqtxRz6oMBeftEgEtA4Z
	 FXCRkM2Tphrs9KwaPL/TItwStBYHqGTLfovtBb6kUZAqN3gRH3VAl2Z6nKP/mKFlpN
	 aqC+VUqLZxwgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D42BF60D5C;
	Thu, 24 Sep 2026 19:44:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E4EB332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F2C280EAD
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCdI_nS4XnO2 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 581E6811F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279046;
 b=QoIWrD2/z520Rq7xOS8A4XTSq5MQRtIWB+QRep+QLPMoipcsVf3VQxsObyli45KmnG9Y
 cGnsEEC1AK+J+dZBHOPXkKYkuDBSnm/2pOnHDaxyBbYNvxwWefWiES0WCJFdXZVAQoJGv
 VogF1GbRlOcn659xJ/CAqzjKfGIzpuzlYfoK+fFRjfLcQZfnZvQ5kli5PLs4sTms6gm3p
 r90Qs49OOpBRMQq4l4pL7ll8tsar+4CNfneRVNMXScBUMTe4+XmQ3OgyRMd4aAQ+UXL2x
 V59yR1NBHdbH0t3ZJwlwM3fruiQW3KUR55A8FPUnWT266gFhafRo67MNIQGKL9qkumQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=7xhINwPACOS6SoVgLiufUcYYkKuUNWTaHfKUhxrPTIU=;
 b=sC9EonaamQe9kVfsnh5NI6O2UxnYg5VxXQFAI2LIPjvolyzq8AHYbUfoYo+u+/2DbuU3
 bE3VAOTao4qwdnVFmC7YkJRktzU1v02CqrwUpD7o0tJatfXWdfoLrJxJ74p4PabdsDitQ
 yghHE5xHL9ukhvaTxBsTJ3jKv1RiQ9X7qCHd7ZKH1tzy0lfXHi5ARrNU8F8LMiTyNePHz
 LjHiv9qhMgGiogAW0QcI3jsS0dYUzPMZlkf0Nq3va1XO1iQRIewen4k3cTcpuied32OIN
 tYEK2cmkaU2Lk9w1rLq72Aeng/4bTA/BK0Topif27bAvGxhsvS9ijHNJMMgdCP9EOkQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jC0k1isn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jC0k1isn
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 581E6811F8
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:44:05 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so81370a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279045; x=1790883845;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7xhINwPACOS6SoVgLiufUcYYkKuUNWTaHfKUhxrPTIU=;
 b=jC0k1isn2R4qC3FakJxsSMgL0nGRUsYsrQhNytHsQBm7fBrAkN5Fn/1M7IjD7o6hhj
 +wyk3dgTz7dogXkCEvt9ksySQJ5sIlMkas1swE8Z8luQGBtqDuBwjKr4bWzl9kQLrt/8
 Q2BGql6XC7UBkPKj5Qu3TF86XruAB5lIJA8jTe+r8u54hEPYIvelSvhO1ZF7ONAsf8OC
 6effqiCrjioumORuzeTuju9BZAyGW7D2KYkKuXrJOgrGecOFlWKrLeEv5w4h+ulC2hbg
 5i9kXFUaaIrV5LRg+IVbBdWje1USjNmT5bj2L9SkQD+Jv5MyYopGaelWi+pHJx/qYzN2
 /NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279045; x=1790883845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7xhINwPACOS6SoVgLiufUcYYkKuUNWTaHfKUhxrPTIU=;
 b=VQIgRujjvPh9+XiWD710yq6hKWiKBVyZBCyAa6jY5rrcNuHek2mO83PL/PmtMiRVj9
 IaAjgXFjFWlGwZ/IBvxebxoybg1sZbqrh+H0K51bVHIMEi/AizIIiebA0s15CUY6lpgr
 dnQH5l7+m/VQdIO5cKQwwnayvUoWm0YGEX7z5Jj8SdldMSXHaq776U9+HX164go18nri
 y1amJsE9PwfzDPei321tqrjMWidpqsAOmecTJPGSjoUfDJddYJavFJAPsyIxD/CMlato
 pyGV0xh+9Hh9cFloAPaO5eb/p4jgUulmED3vM4PzeIqndtw7RzOkxOi5g+N2WX/wLMlF
 1fig==
X-Gm-Message-State: AFuF++kmbD9l5TQL3y7ndJDfR+vPZRGBtGuUBls2XI6ObHzKfMed4ER5
 2qaoTHjhXGjSbdDvSXdZbiIklifimMp/FrpjutgwiYM9igkSyqfYNCc6J5qNYjcKoRw=
X-Gm-Gg: AYBFou1OjOm0t4Xy1V5Z/w8WmD6oMPhOy0lX6KJPNKRf95yt8PoaSHQ4oTeAwSyuDpQ
 Oj4y7mfy3oD8x2MGFr3F8h5MBo7eeHXvBC2RUKkogDezVwZed5WfuanI3TWK8KFmtbB2DVXyHTl
 2ofhAV1b2+GJN5KwM8j8VUWSsh8mM9Ejx3Mt0wqGSst2xSw1F6VMGQPK4iRlesgR6LHRPCWR2RY
 rZOiYNY2k2qmLFHArtW0wzphB3XRlCmAB/FBna56lOz4QVJalZoOd+7F/uodqh1T+kbpy3cUL9g
 /dDo8HWKI32K6nqy4ykVksDylLDjaNO58STzMEdyCv42e7VBnPB9eReEpRQqFhrrfN66TV51FF3
 icJsImr7v3W9h0aHxVAem1+KGrRtiBgYtu5JfobJpGhQ03J3MbD3XUezSJGM6fwuRbM41r6vs6S
 EfpkIw4HotbDqWIxcnpwuVNA4Xym6ieXk8Jrp7bQUSibp06IXMfbPyGNGwFNAcyNQcumrGYkTfU
 cw=
X-Received: by 2002:a05:6820:178e:b0:6cd:3fdc:a93c with SMTP id
 006d021491bc7-6d44234f88dmr3177981eaf.89.1790279044881; 
 Thu, 24 Sep 2026 12:44:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:44:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:52 -0500
Subject: [PATCH 14/15] clk: mediatek: mt8516: merge the apmixedsys driver
 into mt8516-clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-14-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=m4tQvMmAjXEaMU2X+VsEg9WGBB4qVrFvUEKN54ENnA4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX1Z8X49idsSO57u+Ke8h8TIF+0o2R9xivQeI
 Z/O7XjdB56JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9WRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABOAH/0DTeoNyu56Bg6N1wMNs2jtDiCnoH3PHYj4qOog
 m3psIkuOVwahQukilrv+qyckJUE50fXz01RTQYVgn/dfmSYtIeeVnXoqoy3MdlZSgQuOE3iM2iS
 gcxClXUZhRx4eLPcB3ofPVAuwf/3DMW5ySGgsXT4k3m2KEPQjTZELddYoZBv7/J3Weir48gTtg+
 ZJ2fRHPoEyb0yZyTfCIr5Ca5YwaVmRxHWn23g3ocMKSxBKQ4f5+HlqQLuqA8YuuXLZtIP6vVIJg
 3KLT0MK17OsfFay5q8qd0DMvmC+NuidizhE3AabIspShcBpl/QsV0MMpaGcADNi90jw5Q8X3woU
 jf9E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Move the apmixedsys compatible into the mt8516-clk of_match table and
drop its separate U_BOOT_DRIVER entry.

It was only kept apart because it used different clk_ops. Now that all
MediaTek clock drivers share mtk_clk_ops, its entry is identical to
mt8516-clk apart from the of_match table.

mtk_pll_early_init() looked the apmixedsys device up by its driver,
which would now also match the topckgen device, so look it up by its
compatible instead.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8516/init.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8516.c    | 16 +---------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8516/init.c b/arch/arm/mach-mediatek/mt8516/init.c
index d9fe8fc8505..99574c14822 100644
--- a/arch/arm/mach-mediatek/mt8516/init.c
+++ b/arch/arm/mach-mediatek/mt8516/init.c
@@ -16,6 +16,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/sections.h>
+#include <dm/ofnode.h>
 #include <dm/uclass.h>
 #include <dt-bindings/clock/mt8516-clk.h>
 
@@ -41,10 +42,11 @@ static int mtk_pll_early_init(void)
 		[CLK_APMIXED_MMPLL] =     380000000,
 	};
 	struct udevice *dev;
+	ofnode node;
 	int ret, i;
 
-	ret = uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(mt8516_clk_apmixedsys), &dev);
+	node = ofnode_by_compatible(ofnode_null(), "mediatek,mt8516-apmixedsys");
+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, node, &dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 6402fbb80f8..9f25f1dffcf 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -769,15 +769,11 @@ static const struct mtk_clk_tree mt8516_topckgen_clk_tree = {
 
 MTK_GATE_CLK_TREE(mt8516_clk_tree, top_clks, ext_clock_rates);
 
-static const struct udevice_id mt8516_apmixed_compat[] = {
+static const struct udevice_id mt8516_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-apmixedsys",
 		.data = (ulong)&mt8516_apmixed_clk_tree,
 	},
-	{ }
-};
-
-static const struct udevice_id mt8516_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8516-topckgen",
 		.data = (ulong)&mt8516_topckgen_clk_tree,
@@ -789,16 +785,6 @@ static const struct udevice_id mt8516_clk_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
-	.name = "mt8516-apmixedsys",
-	.id = UCLASS_CLK,
-	.of_match = mt8516_apmixed_compat,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};
-
 U_BOOT_DRIVER(mt8516_clk) = {
 	.name = "mt8516-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

