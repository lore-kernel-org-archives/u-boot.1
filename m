Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DBACA6001
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA4F080DC7;
	Tue,  6 Oct 2026 15:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DONWT1hsCaFa; Tue,  6 Oct 2026 15:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2A84F80DAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299506;
	b=Chv4DqfP1MiRjr55o81jY1LF503xwWMsAF3Nd8zzA7EEzuJ0L4pVRlWOo12yFac1ZGKP
	 CJ1FmsUoWb6cLFymJ7OvfT5bImQKsjznUFSl5JnGX2HNWP59ZZqBDXTEzhrosHxQlQicK
	 w9Si3+nOTQgXHmwmMFNENsrlPTreJMq+HuZQqiPl1TirZJXblFa4UIBNpVpcWw0T9a+s+
	 Rwj43BNCpio1wH8fqns7kIE0trEtoAufRLqzldJoA43ZXYuRY9x5aqpL6q5clY9m0GXpb
	 R0pFlbUOVau2poZlKnu45aQ8O1Gu+Kmb3Yw4KlQoXDsnHFbVcr6LS2aWxowX/pqrY6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=juhR35FWl2LmwZI+mCztB/qaxK8qZhBr/HdWlt85S3I=;
	b=deU9Vpg68/xxClNZSAu/EI8/w4bRVkJWvhKoAzfyEWtARU37QkKvA5y0QsBD5r5mNjgd
	 bVf8uCNm+NCCCZUvm4FsN/JOQ8XTiT9lg6vc3PZMbGAnbmBwXAvd9IRGGHmx+r89oOCPn
	 +RcKLLJ3x3YZJv1l6KZrcXYFRpRvXtikdQRDDrfMs8arPDXPdWomWoMI4puSssZBhkcIf
	 oxOmpzj4O2RIKYAeLg1nnHqVhgGNsoz5pfpBERFIC15+hOJWN6uOvefwHmknBJpzV+pPh
	 98qJoitEbZBmwUn2j4rW/oW+I8x5Zke5NkUDJon5iaCBibaTG9MK/AzFG3LB5UDOdnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299506;
	bh=juhR35FWl2LmwZI+mCztB/qaxK8qZhBr/HdWlt85S3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=loS+XMc3LPq/0Yk41+8xrpnrq6/O/I9CEcDMhgh54VHQbHw9wk019VQWgJeQOrKxm
	 SvVlmLcyBTo71ihQ7aYpRPD44ld7qMUGdT+97WSADnwcZhItM+Inzz1YOdnTAQxYrH
	 yK+DT2Y5lI8RwDypbquNGZWFiyVHv35whqRAcc/qyT0mljhOsjLfQYmtrCoHojXsRH
	 30RdSDg+yFSvqQLPqapU6+lu/8ZabetDi8doD+mtGqayBKWowiNbOhWAFpjE798gu/
	 pVju/59W4BWR1jxEI66zRHkpCrHiBXPQ31jwq5furx1ONTpLyJJ3MJhjWLgVMKni+F
	 SvN0k/C1YH52w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A84F80DAF;
	Tue,  6 Oct 2026 15:11:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFD3B75
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5C8A607E5
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGTXUL4WhBfH for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2D68607CC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298924;
 b=G0A6jBuzVagb+urw/sRuKy5tUV+IjCGaoYEdCkK61UMbfTT4QacpoQQXYK/fpCq0aSdV
 bxo/D/XMGMjGHpq/otPuj8rjuxI5P+jgbSZAVG1DyVTm9NN/N6GkpLn3PL8iDjxAT8U0w
 mEfWjHxVUqW9amTHLPXQOr5BqNDB75T89ft9m+Jh5uz5dGCilI47Ty4/APaXB99Cosova
 BuAiJ7DukqPy1i49Il8oJHkCAIn6hjV/+K0GvjNwygkJQiywPjrDtZijLXFLaWhmS5MeW
 WCnH8zPT9Idn6KjxpsbDC/PrEbYzh2fvagSdxrlytrlDRIV/jacNO5CpmtEyWAQRrPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298924;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=juhR35FWl2LmwZI+mCztB/qaxK8qZhBr/HdWlt85S3I=;
 b=X8ZVk6mf1AAvQa2uYy07I7c1I1KPgiRgi5QVDSehTsCEXd3oKJHHa1IFsIA5lYEFUuvU
 JZb0xISqGp+TbSf28SfD1AGJlod2xH8axK3azuMRpSbLomRM2UeMw4iWSBrUPBvnnp0cP
 8EwgcDKv7Ie7I2kNLkjMjjF1u2sepMD/HvXTUPxNEXZXh/0kevuEk3BXvAYCshX41E0jN
 2oZr0slCQjn9L82QfDMwt/4iDA/A5g1dlcsfCihPWC1K8+ZcsmQ6WCCSDlEga6uOY8+N4
 EkxymlBAYxIhEgnCDM9ppAoaEXF4UpIFaalYFIntq0Nx3xKecmh+aNTrb3IvV8m3Dsg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RrRPZR+C; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RrRPZR+C
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2D68607CC
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:03 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so6165255e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298921; x=1791903721;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juhR35FWl2LmwZI+mCztB/qaxK8qZhBr/HdWlt85S3I=;
 b=RrRPZR+CO8uTIqtEEmGSR8YUML+Ae858JLJ3/5pJeEWvfwIqbYu7wb4mOr5G9kZKF7
 eR3HZbS2gYRAd3wxt9K/EN/RnM74R46svt1vycHsvntKt8mzrilAIhj8DRcauFtSGf+f
 SulVpuVQQLCapwLbH4Dky987w+CAyOHJNwrrUbcnkpBOWPlLbFpAKQaoKnokC8w242Ka
 6zs3yUsN0OnAMhuXB4TbvIeyezJgrqrufYpqMQYyYDlA3Di8LaRG4ZbToHODGCA8igXw
 SDdklH890QTg2gAANEcEFpPZAez86v+mYo8jZwAgB9ZglXxgrDsSAlqQ3FmdjKwgl7Ww
 orsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298921; x=1791903721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juhR35FWl2LmwZI+mCztB/qaxK8qZhBr/HdWlt85S3I=;
 b=shD34hKl4oTtE/9sgzFUJFup0msqSnAVkCzPytD4w0C3m2FGB1ilwdQ4QBkmYam0NI
 ermRb5OOZv4+XG0ViJuUxPhGjdk3ROZfOR66SDo1IlkA55JAF4mRilw6xYh7DGb4EZno
 NeMeUHHnLpj6bg1hVGoBEbWS3pkdHQKQO3qED/JUPTEIN2MdjUmjZXMKG1SfbGhvVX0v
 tAoDeza8/KYPyLLydMa9Nx2GJLzwk4Jt0TpE9iDlVfjawWjoIJ/BV1W2N8ubcTrqwGFU
 giIltNoR2qwSps8j+1yTCCDISrAgi5BwwFdh4VjyURbkchi5Ksi6PvkWaS2qSd2mv9FE
 Zjkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztheCxWB7rn15En4nVcBUZdCULofYxXvGBeOiOfpatwP57lzhkLhU9+F4oxK3x0zJDad8WmKw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIha++5CNQkTYCqGgi0IONjlkzwTiZCvU/Fdf3OmXDVdsbqHYB
 byeu4U/tAapdfxT0Jc+ige0byyL9CxPPHH7c7Y3dXsCxdNZDOwBZPfeI8wfhN26s+hU=
X-Gm-Gg: AYBFou2hpIF2oMqY3kO+uqgXkDsF1G/SrZFRXHLO3mzMcfwAqKGeHjR+M/bZ4hOnMZb
 ZKqJpBXqG/aOMqQLzIxi42/YRBNFpocxgTSVSvb84Ter6EprclvXHuwL230pZy8Mx2UivAWmKTW
 TzvgWKZzTtKmmKq6rPxgS5+dGj0zmUoGuKpa4C/EvAS3e+catSS+s7TNijgRDIfnzY+5aLU3wsb
 8z8+hAp5Zk5Sbds+T/f6vr2XOGAkIcGyvK5f7nHd5xkb6tW0cOBAFQchgtFlGoR2I2NczWrvRnP
 xNtoOI0ubesnPkg/+OebFL0qxXkOryPZoiWUOuDfSHx1V5FJcPL55J9ZSkIJBv5vIidDUxjAU9F
 oye1DYFPnZzGo6uo1KtgftkG/kcQ8WeTxjYI1SksJbFxk2S+9hFyGBCU/udugQ6XHvMtaLW+1Pf
 QE4uGxvIyj/tSvD0U6yVyOvA2xNQpQO9pXu5s98zLIY0EklNFer7uzfo70tcRxhkTqtX19ocOI4
 2WQR2RDPqumIIuhqideGKv72P4WqEzVK4QzqJ0Ev8ojw0Gw3zb3LMOpRjqskts6NTfYvb6P6NrC
 Xf5/kaXAfqk8paoiboDJFIM=
X-Received: by 2002:a05:600c:564e:b0:4a0:108:3b54 with SMTP id
 5b1f17b1804b1-4a17b55651bmr21776555e9.32.1791298921528; 
 Tue, 06 Oct 2026 08:02:01 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:02:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 06 Oct 2026 17:01:49 +0200
Subject: [PATCH v4 5/5] arm: mediatek: enable caches in the SPL download agent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-5-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
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
 Carlo Caione <ccaione@baylibre.com>, 
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

Genio SPL runs fastboot with the MMU and CPU caches disabled, making
image downloads about twice as slow as with the U-Boot-proper agent.
Enable caching to remove this provisioning bottleneck.

Keep the page tables clear of images loaded after fastboot continue,
and disable D-cache and the MMU before handing off to the next stage.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/download_agent.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
index 193817cce98..4da2b1a283a 100644
--- a/arch/arm/mach-mediatek/download_agent.c
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -4,13 +4,20 @@
  * Author: Julien Masson <jmasson@baylibre.com>
  */
 
+#include <cpu_func.h>
 #include <dm/uclass.h>
 #include <fastboot.h>
 #include <init.h>
+#include <malloc.h>
 #include <mmc.h>
 #include <spl.h>
 #include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
 #include <linux/errno.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 static int mtk_mmc_boot_prepare(void)
 {
@@ -61,6 +68,19 @@ void spl_board_init(void)
 {
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		/* The heap stays clear of the images loaded after fastboot. */
+		gd->arch.tlb_size = PGTABLE_SIZE;
+		gd->arch.tlb_addr = (ulong)memalign(SZ_64K, gd->arch.tlb_size);
+		if (gd->arch.tlb_addr) {
+			/* SPL skips arch_cpu_init(), which enables the I-cache. */
+			icache_enable();
+			dcache_enable();
+		} else {
+			puts("Cannot allocate page tables; running uncached\n");
+		}
+	}
+
 	ret = mtk_mmc_boot_prepare();
 	if (ret)
 		printf("MMC boot preparation failed: %d\n", ret);
@@ -70,6 +90,12 @@ void spl_board_init(void)
 	if (ret)
 		printf("Fastboot failed: %d\n", ret);
 }
+
+void spl_board_prepare_for_boot(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_disable();
+}
 #else
 int board_late_init(void)
 {

-- 
2.56.0

