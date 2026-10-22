Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A251606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NqETebiL;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ng47JjDd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABFB8409E4;
	Thu, 22 Oct 2026 09:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUpqcpSJSH5Y; Thu, 22 Oct 2026 09:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E90D40920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661200;
	b=ZXMvu/8hcwzvxRUuklURtREuYK3J0H6g9ygA6N18VOZrzQc0PNeayY3hrwUs70a4sP9g
	 CzuNyeg3aZXwpP14hL4NLvvZ/WrDdfJZ2am3fypvQLcIjmWUA5lv9L8xNazBJfa4PSOxT
	 gXHaS5gnzHaMSIZokT0wyPYStCiz+6dl96arUOfC1yvsSjqeaKI2cBBZYg4NHP0hIX59c
	 q2lTU01zQ2LOPLbBrT+ZLBmqL0jnfmGDcUJJHXxAd6IwZsRvz25HpwFyd93U2a0um83MG
	 9GZcxEloK970rzHwHelfJMtX6NdgqYYgjk84eed7XBsx5L4F2K1pOmdB7pPpTFBThWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BPoX/ziOZnY9POPeXfN8IwHHTgIpLz8+v7tBHSiGox4=;
	b=VeEJ6/AFUgha85CfumTzTDL2rDngX6LYf4SPpPiPl5ExKVySOagqDzqaTHbicEYD13Dk
	 ugGQ+ODibaMOS1gbgOaueSOxgQoBfTmpy3rdhE7cqIspNrYrX23Habt8lY8GA3tP/bhWP
	 Zi3OrjjxrKG7NVSeiHvRvju90PCMWZyh9mb3br/UaeygwWOGoDccAT0cTDNkcMN6KuShT
	 85eqceq6i8kG2nxKqc30cIWQJ/CL0joDnif6eVinZK0oBE/aD0o4zq7MDlYZANDzt2qZX
	 3QWnpPDiil1mpSdQ46MBHap1A5KzzfMD1IuidqEFEQApaakqQ58uzeqa22p3DianUSw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661200;
	bh=BPoX/ziOZnY9POPeXfN8IwHHTgIpLz8+v7tBHSiGox4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NqETebiLoELBc6mIu3SNuL18rH4PzpXYRsD44PuiEFJzp9dXsiuiolSpwzagpeDXe
	 oDsGy4JKEFqGECzDTJC7/cfEN900tOnLbqpdUWQvqal/czBjgD6Z3loaxODjPSE/mU
	 0Fc3wNSLbrL51wmxbkSn51D4kwNfcN70mWF0hqt8HFu0Xuu0KtWkpAT0lRZvCZcIUA
	 OExJxSX4wfhtWY/puecznDwnmhRCNWE8NxyyOjBjHVVL4OTSU4OBjSbhHRWnzCIVBc
	 gjxM2/I7BExT6EmlLVS4JkPrpFl+SHagUwpcHWwyldh4fcCNwpeU19+VQgVWipJL1l
	 daAsKdVLQCxIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E90D40920;
	Thu, 22 Oct 2026 09:26:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24E423AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 167698121A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyXybfrJqPJc for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F85981199
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661190;
 b=ZFJRDDyspJDGFn+VrucJEfVE8EwL2Sp4fBHsG+tqf3+HP431V1E/1UxUUmICps9HOrtw
 zh34qe/35VoAVuUk51ybuISiu4SPLORu2wmOk5JQoLerfpr8QR6PtD9/j7o746aNllKRF
 p8RROAarVVghMpDwoKckOfkVVNlah4R40Hh/+yze339455K7tu8X5uPTtsK5D2kpg+Kr+
 6+vEl8kRqeDSD32gBC8aMdgG4GIJY4hlf+hyC92eZk9rGkYn+7xVqLT+xa1OEuFcdil3Y
 n9jhFMeRmDB62sw35OP5m4QyAar/2KfL7OlhtuzbyKTc39dLhsQi9arph3xHk0+t49Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661190;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=BPoX/ziOZnY9POPeXfN8IwHHTgIpLz8+v7tBHSiGox4=;
 b=mb2z+h/hHoofyUL4CbC7wjwlyDrwBcB8YzwXnpfiK6cVLmRawyJYfn6FVLroOWiWGyPg
 8crRvM96Y130umLiD6CpZL1Wwqf5z0cIJcI9+d8F9qWGx5Wmq19h9pBtt0WffKYGEg7lj
 aueYHFsgf7Vb7nx8vLm8EjapuIY8JLsOUM2PVNZjPXWJB4KfVvR9PNUv2AmJc43iVcHDY
 LeFpj1lHuHYCZQBBxDjOqyyq2DxHnP/jMq5x+17Sja9298edoehjoM4bhPfRmSATwLtZY
 pcLfgJEoRlAvlFkYlN+PKX766Wb2Awafj4Kx3HLKKG53mTcWk/RtOlVuWcrygM2rYvg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ng47JjDd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ng47JjDd
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F85981199
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so569561f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792661187; x=1793265987;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BPoX/ziOZnY9POPeXfN8IwHHTgIpLz8+v7tBHSiGox4=;
 b=ng47JjDdASwxQ4J8wmYwMWYtKdLValzzJlbpaYqFfakJv0BR9LbdkYWh3KYEfolfcx
 chfZuLAsU4pzJTmhZp3x9MyGi6Xiu6TVSilS9YoPoKKvw8ifg+zWfH5wnbmegWDYL3An
 12ZiJLCOYeKLDbuK2zFxYPoP834nbAXoDO+k4iOSyr12R9nKQguwsqFhTt5zRGAohj4/
 4CmeE4yBbGZ2RvAcnEzumazQ0RrlmuEas2IrCUqIxnAzSz2QSvI8sEluH8jbe+DwIIb6
 tjNLxuetVupWd6PWNP394zB47Blit8WzfXmw0Qspdnss97Ep6ZEKR5irm3hDvkpPBpyZ
 ohaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661187; x=1793265987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BPoX/ziOZnY9POPeXfN8IwHHTgIpLz8+v7tBHSiGox4=;
 b=lSTG16G2fG2++cl+0ZHNmQLSfteI2GDtHCg/p59lUAxQ7PGUYKp+uUtKwZPwwUnP1R
 VQwQP/NN2iBKnYThWybSFJoSYVnn4FFSJfUWeXIfiKXeZsoUu2WvWCD3zBtVk88/WMhb
 NACob+pD74e4h0d1ozCMi2O7/8ZiDLAomgLSg8K78OYH1EdpTAEor0iqGwX/JTNDf2IK
 F0UQqKDfe4B2s58D3leqMRKjh0xAlkKqP5bxTGsG29djewJp/LHpdkgXXZXVE+pZ6D0K
 QIMB957/4qMzlXLPajPQLE0dCS8/pYiuAiLGzILpFaphhM4qyvAOIsTA7hvdh9aDVafe
 MOSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR/ViUwACpqHPc1axUUAykIAS+1WCKbapQMqDwcgoyQftVTK72p5XhtH/fYyRHZsQH5+Ph5Mk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+5HCzEB2SZywVlVS01FF5O76FcPkWz+Mn6H2MBex++9fXOLFI
 uNS7ZvgjBpmdXJbloDcbbD257twdKQJRwnPLwj3onDpCz7C2htxalPFXzcPpicxMx3I=
X-Gm-Gg: AYBFou0wlRATmVZNaU0tAJbBRsboNLSWoc7k3kzvYg8wFv+yjJmgOBgtcDtT+Dp0Fso
 DtB6sLcKa54oNm6+1vO89Ny9g0E1WXe4NfSCj6ZItaDcg3Gqg2AYzdf7uDKUgTjLut+CmCOEnQ8
 UpAnbxvq6I1lJwA2FZbrodnPNTtP7GTUgeDdbcQghHiMBZCEmlcmOk58LoJ8GIDibfI+3GBTA7q
 Bf0FWSbMcQ5L65R3Irz+5zDlPiOt57cRveVKNUs4ramp98fEtChyR9XJMhHyABl/jsyErzssp2J
 XYrllsYTIheYfDL132wVEOcfF/B8NxKv2YrUTWYRgCqSmKA+/g+W/vZY2kyE/u6KQ4yEab3/ip6
 gd9g5Y3Y14Sj50CaJ0GVjTAWW578DZs2zXcAbKPEdRdgR/xMEalYUSffwCaDC39pbRZyStTaasM
 xKtuSCa38MZy757acQY0l7MOw1ZrZU3aOr8l8vnMttTfei07tZDwKPa20a8zjqSCcOsR1xH7MMv
 Se5NIvcdL9D27csFAjPAfWN2FtiGglOm1JH3ExnJG/dAffIKjPRaAhEOQMX8qAtACQN8eXtyTU6
 5sIvesOXvGMD/ihHJ/t71mXWkQcYqCizPluf6B8/YMsXieiLiic8rw5GMkW8MEcOlpMmY7NTVwm
 aEdDf6pGqOyMu+ow=
X-Received: by 2002:a05:6000:4206:b0:48d:faa4:af9a with SMTP id
 ffacd0b85a97d-48e2d102ea3mr3839195f8f.9.1792661187497; 
 Thu, 22 Oct 2026 02:26:27 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583522esm11426793f8f.35.2026.10.22.02.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:26:26 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 11:26:18 +0200
Subject: [PATCH v5 4/4] arm: mediatek: enable caches in the SPL download agent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-mt8390-da-v5-4-58982fe11312@baylibre.com>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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

Genio SPL runs fastboot with the MMU and CPU caches disabled, making
image downloads about twice as slow as with the U-Boot-proper agent.
Enable caching to remove this provisioning bottleneck.

Keep the page tables clear of images loaded after fastboot continue,
and clean up the CPU caches and MMU before handing off to the next stage.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/download_agent.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
index 193817cce98..2330180846a 100644
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
+		cleanup_before_linux();
+}
 #else
 int board_late_init(void)
 {

-- 
2.56.0

