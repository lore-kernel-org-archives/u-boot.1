Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D68606A337
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LijaXIlA;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QkCXLSCc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAC4A408BC;
	Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-2p6T-ThLsn; Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0351B40882
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901277;
	b=GVlKMmqMjrr5uhXAyqShlZFkvvL0P8pGiUfduvB8qPmMi4QFXsGZ5ucDhSc/RU0J0o2A
	 sqUt6GWITFYYMpr1aOmg80X9sLTm64HJeMA6WjvXFLZlwcV8z1bjR2BvCtAK9T9IVbOGG
	 3hjyHzLry1UzD6dPYW1SnWp4L9HR2abH+v333iMvOjTdyn3fRqxL5vyacsxUhWYUvXutL
	 4WD++g81WeB7NhSA0HMv5kvMXbvkAKj6s33ZFdd/7htKgUuT8/L6fUaLaTkoVRmZCljre
	 H8lns6bzZXG8zVApGfNi+TEUsrsG/ViiTeed49gs9KG2DO100uTy+nAxB635g5iMdQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mPD5fsxZkDEOGejCzBiAzBDzGqGGuikmIb3JKBvN20E=;
	b=BgDWybYwpl9jP0Pbh8ZeHrhq9JiGXoqHvjFLj/E0FZfUKfn/dmYDw+eyNpJ6RKnG3r19
	 aPuKmX6eBXWfgRSIoKeRZLJAWUU88acdi49IZnuNUwdvwjXeUqC6zfWM24vQ3O6COf0LA
	 56hXgavUPN07LB+tMLj3Q110ZrvNN142hHC7icCKMlizezMRoOynAjukQlWU5a9SFwV+e
	 uZ6ab0TwFDdZ15Q92aeey9FPR53NsUMh50jCIaTua7bKzU7e7knAcRmJ9ZUL9sF4yuyaR
	 HigwHzHh+imimUxrJPR5bUK8IMtLUWxKdISIYQAeTMz5LxL5WSAjx6Tjgx6n6ehmiVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QkCXLSCc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901277;
	bh=mPD5fsxZkDEOGejCzBiAzBDzGqGGuikmIb3JKBvN20E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LijaXIlArQdipOla2xm+UutrIgI65g75XC1W7iGmH4KH8nr4Kumb40FJpu4TNeOzH
	 OjArFdLLl6A3qHSgIhtmGjVcthsUOndgruXOIBThcb2/nez6YXhd1VsOa+3SQCqJ3F
	 /QliSUVzx+2Ie+65U64VPYzJEMKPzbgDOQGlYq2T34/1rutRC0ga8HAipMb82RXysI
	 BkaI1o5M61IrWE+W/vWk1UB6fvydNX/ZrBdrvdxAYZAUXPhb/nBH7+cq8VfBQo2D7Q
	 q5Dn936lbtYMts62i/R1WaBg1SUH2pJaCJM/t3+EHzfM6HygY/c3sWDKjeN6EC03qA
	 nkZYaDtDO6/uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0351B40882;
	Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 480CA37B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 398C940882
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v91Zhh-fi5WW for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5794F40880
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QkCXLSCc
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5794F40880
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:31 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6df5e315bd1so1832384eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901271; x=1794506071;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mPD5fsxZkDEOGejCzBiAzBDzGqGGuikmIb3JKBvN20E=;
 b=QkCXLSCcRi7kUq9qRNHRRDU9qaz0L6itCmidHYu8ksEs9wBV+5fHWM91luZ7lvMGfz
 YZLrzHqtsdfiz3tL78woD/pPjEdtBjXDbdml96hPXacYwLS34MP4Bx4kBN+UsLHyIyXO
 hmY5SFTBT8nxBGJGNqPrnkxW3sJvc8lnU2AVbf0XgU8uiM5K7P+Kuv+4btyXJAdVJiI3
 I9YabQmFjm6yIQJSdo7gLbSraljqG9sNL38cvau9mar0olJ/Sk5QAHmsFNdNUPs8f2J5
 Izt170amzM+EK7rkfbzsSKAFxlZbgCnbBJ+tz+3uOkqOx0ug+KbNH/w5nfFv/CMTSlfa
 ITlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901271; x=1794506071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mPD5fsxZkDEOGejCzBiAzBDzGqGGuikmIb3JKBvN20E=;
 b=j6ujQfblIRw8NN/iVlWS1UGlp9svaqAE5rTwiqqXlUVqMblgF1fZI/c4nT9G+JnHxe
 ktOc1fVQJU3UjQI4WYN2llRzpt7EBJDr360OjQuaNRJAOjw/sV+ZLu+fjZ41idDSkjyM
 l5MUDAtP9rABT3cqmESzY63v2zcYoKDZN0Rr0+EgrT8y9GxiTJBq9QxQP469MX0cJFa3
 Z6EsQ6Zi6O/y4f+BRniyhgL1Uv45Yo6fR3Ydf3p41DEVJtj5VcG9vDq5MMeSJEiTY7pa
 GkNy+SYh6LPEczN8UkgnPAcEKD4VQI/EzxZtxySN3LZijH/iHBhc3ltl8jKZitkQwDJZ
 jBMQ==
X-Gm-Message-State: APuU4Z/zW5LygPBbnRVCfdiH9c73malssF0ARY2g0bDlEIKXmBHPdbu+
 GbXumKOm0+k6A93jTNBflt48/tmD70NbyGMvvA4f54j2yBmf/0QnF7ieFBqZkGM7N8s=
X-Gm-Gg: AYBFou14Xc9XxOM05U7jIDhkcBrSUbZSvzyRQ4ry7C6CHVn1OqhefnbqggQ9gMrMLK1
 RNNExST/dEI6Fn9sIaohHtXfWzAVERhkUYvrHEFIBm2H7gm3bPZ8ejGwK4VBzaztxmWcA8l1bQ2
 cJJRFih93gwrg/onQo7tvve6D3bTVViRDy12Hnlpi4+wyCiTc+8nIviJLs01psCKWbRzkZq/x9h
 0ne0CZcZZqEFjIyXc4+pLiLtF49+RYkZD0R1Ejq43q+9zEso82Ss04hOmL/BaJta/oNlk6opxpb
 aOiF4yyWdTgMaMIasbXfbdXCbAvu6ZUM9yHgKXZs6NV2hSh+2b2ZyhAzKuWZVdb4vFfxnF+qI/S
 kTjzOPhaU76r8d6vmmcfHpB74upfI2JLjqref2a7+feaH69J2w1I9wsBNXo9bc9aB9sb9CIlqtI
 HxIXVkhRGmjdf1KzqlJE/ir44RXLBb+itcNScmZCmR94ibMmQgZJpUKa0byrdUGX0C7Tr/XwQCg
 X3e6odIFSqyt3oABxfUUFf6CkcrlaAEJIno2/AfStU5mzfLSm807z6vW0acbrb0wA/bDryCpvf+
 Y2NA5oGAffBXk7IwStlCvUrDgk9LgMIOKQ==
X-Received: by 2002:a05:6820:7408:b0:6dd:4f30:258f with SMTP id
 006d021491bc7-716e79ad995mr150347eaf.56.1793901270828; 
 Thu, 05 Nov 2026 09:54:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:36 -0600
Subject: [PATCH v2 1/6] arm: mediatek: mt8189: fix the reset_cpu()
 prototype
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-1-4994535a3848@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=4MUy58owvK64FG/iwQ6VvHij+QrTlI3gbkj4sKyIECc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MKrtomUCnrmoUFNniJs1dgu3fRcbKvvVPg2u
 69GptEqez2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCqxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AF9sIAIQrrrl81S+60PkeoKZoAUfTnad1taooS/s9LEh
 2c4xEQ8LOrDd2pXceoRrdg5CQ/F9THPdIgzoKrpLkO3e11hZi7xFdTnXxniezOvjIbKaYEijRgz
 LSQ28hTBeviZLKurKuzCcRRtyobcMQrmpy1qPkAdRJpUUbHBafYYN00F8TRq/8zrC71fqHF7xT9
 ctx7BN93GXZGvJvj672JSPCdY1rstI3HT/LH6Nm1WeCocg/OLt1lx2DaT3sr+bFvLQlgF2jwwGo
 zdsF+bzpQyGJTp0YrakU8ilrrjOJr0tCn5paigypE/I23pwhT2HuY60uA9Ff3lTUiSj0kUw9lZL
 HGa4=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make reset_cpu() take no argument, to match its declaration in
cpu_func.h, and include that header.

Fixes: a7c682565b4b ("arm: mediatek: add support of MT8189 SoC family")
Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index 4435c75a656..c0b7050c6a3 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -4,6 +4,7 @@
  * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
  */
 
+#include <cpu_func.h>
 #include <fdtdec.h>
 #include <stdio.h>
 #include <asm/global_data.h>
@@ -29,7 +30,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return min(gd->ram_top, SZ_4G);
 }
 
-void reset_cpu(ulong addr)
+void reset_cpu(void)
 {
 	if (!CONFIG_IS_ENABLED(SYSRESET))
 		psci_system_reset();

-- 
2.53.0

