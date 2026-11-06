Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94004606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xJIxOglV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XfgeySLw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DC4D60DAD;
	Fri,  6 Nov 2026 21:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S4G2WD_A2au1; Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19C2D60DD1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001023;
	b=qGpb61TgNVpgEdTmEXCY26ZVkj+lcbgJJMgpSz2IUu/HCm8WqBJPwZdRC4hKFxhNbCxF
	 4huYCKH1Pd4MWAZngR9weTdi2MHqn2XUuARIS5EGcJmab3eBfwKwMpBOwQV+cizEbJpGl
	 vVzBEuIxSsg8kVtgOMvWC2W9Q15ubb12wLa56CY4UZNKwmLpMsN4sN6kqtlT6d42U6TgT
	 EMx2mhBznmGI+7CRR7lwFKF/2oQRtlEZHADVmapNjXlGCJvCQcwze1bspQVqec7HohSh6
	 R7yV84SCl0EE69QWpen/QWBqmDUXR80xpqg7XWMSVGbchYmDnhPVpzKOYSU1C6d0WIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6/AQcwwHTwoqNz1s6w29BrCqWUfKZwkzZ9QYx1M/dlc=;
	b=U4sy5dsEx0zBV+bBHfeYmQQYRfDgAP6eI4rn0katYab3E1UXGMW6rULtAr1pTz9h2sCN
	 X44SAHFjWnp7jkhMPJwQMigDR/vDCNi4Q5ycKE1H139qYusJv6vghnWxExuyCvlhM8g/B
	 bo1DyQagmVy0bYimjykf5Kdvzl5dDkGn9/jHS2geZHubijOYVh/sOzthA97bR/yOqkwMi
	 gPmlIW/pjeazNaEZDnYW2kY9yrZGtQPiX+MoauvLbzLvBI+5haXgzgSK2GbzBcWV27sQm
	 7p4iCeYJfjUv9AwmYaYZaM9NCXx08COowILX6UdP8X6VPm3B96j69/2KqjoTpnziZ0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001023;
	bh=6/AQcwwHTwoqNz1s6w29BrCqWUfKZwkzZ9QYx1M/dlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xJIxOglV5pY8i0Vu0zmjvG5A/xyRiGnkJ2kaJ02NVUzamA30db1lEnrBWGjA+2VEy
	 vAsbwpsKe83qrjxkKitCmsVefsREpUoZNTJI2qnT09NdxvyzDV2MRfU8HsFz7uNQej
	 MNOA1+tbGecIizjHEDuBTZslEnm1zuezrfemwIfrS1eqJEfkshFxrsEpF9U4uQZTsx
	 JX5lDTTNJrVp+0yS8MDt/4yEGAgNGhYOnf2+7NS3R6fOtpQla4mMygEOFmxi2HNznM
	 t3gIbfDFsBJNlCyu8j32BqRtH0VB68HIgYlQQ9CeBHdsRcGRXZJ4TXh9LD9OxEjIba
	 z+mnRWiD7S6iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19C2D60DD1;
	Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D24E235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A716407C4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hQtTpEV7JfV for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BB3F407BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XfgeySLw
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BB3F407BC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:59 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-51f2e9e6987so55545b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001019; x=1794605819;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/AQcwwHTwoqNz1s6w29BrCqWUfKZwkzZ9QYx1M/dlc=;
 b=XfgeySLweUvbE94ZJbrTw8+Pptk79kf6jnquZLANtTTBcpN0Cy5mHIt5Ww+dM8zyz7
 nGwb++iAcrZpPskMu2Vj8jvQeq4UiJhzOfQwcfsgMUL604xM0l/VEt0qV14NLjV+7Kdu
 eBLOyd4xHeSRh1rYJPz66BGlkfZWUicj/hFvjuQB6Z8QZygPmMx9T3exXx7KCMZK1BTJ
 8BKeeO5ajmQCFiRrzOZXh+IpBgwvc3FnCUqwiXx3N5C1QzZ2IirSvSxUzuoPnGYJyo0m
 zZJWGTm1RrTZEnYCTwoojDYTLDhh9bgWrfc9l67iTKO0YroXJVYohSZ21LoI51/FiA/1
 22ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001019; x=1794605819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6/AQcwwHTwoqNz1s6w29BrCqWUfKZwkzZ9QYx1M/dlc=;
 b=RCwMwiQWDdtZqB540VjqlCqBY3mxqiZcQv8TJwYmkple8lAQ7QBwckTCy0VL9eIcIw
 JTzSDGVbEVGbcrsap4PmE3pHMrdipoOqmJ8j/DNzyQIU9TV7djYUvBYIS4H+30fdGicD
 JaU+WPNouYkU/xbhnAmjgcvDYO7q83ntue8Clmru4btZnjuSTEn38bgKBO0QFrHQTx+0
 SmJQVEtJ4dFQQ/H5e3197cnQy4g8dpmKg1Vp/T6UdDPh7Jv00WSH47o2/BF6WwztbKr2
 /68WYKL3QW8oclvyTAjoWuHMQNEmcpXtHZLyMNU+cL+3gqvXbQ20B9O+REmKNbdjLTpy
 js7Q==
X-Gm-Message-State: APuU4Z/YRDQhgxnUtDq7nTEmRx6e53MeB4xhpCcZlMRpO9D894gP0fWE
 n1IMDIJZ8U7QsjNErbhr1utW1ruHn5zij9knzYb7FoLsmkx41UCUGoTQgedgXoJ7DGQ=
X-Gm-Gg: AYBFou0xQ7RF5IQyu/0kGSYsIZW4SwrNufBEDO/qRHrhPO8JaWy/GfHsSZZRM7d58pb
 nFUlcK9f4AkZuT8giJFogeXMwDzc3CPGR39mByz2eu7ItcYNKN9xYQQHoF3pPX3e+D1pnLvJldE
 EEwe1FgCE2hDdZTBcr1Afmmmv5Fxrl1Bnkp1OVb+AYmtsaEdY8Lh65lgJ/uvlFR7zyaSKRL+uTT
 2S+dudqZJ2SFdqiojsTsxdIzPti2EGrrv95bKGRDGT9g/8UC8duH1uac3X72H2JVY6Q4ar6AMsK
 J91Ttrafrlz2lBiTFvOIk80aAgpwLvuGPeHQsrwvsAsrVKSQ8nIEPLA74B/r29oyUNZeuAxS3ux
 F0MJ9i44Ugp2/orOGV75SX+PCN3qIaIsCZof96YFSk3PxYckAaoCgrgpv9tMIXGiEypCs6DfTxs
 sb5FBUqasCC+/1fWvGcXCOrV9o7K5VG6R6epRYLNBgO85MqobaXRRItfABWusCJ5fn0UqOUwD4l
 Yu/t590HvT0vh2FDjp2nRWr5NzLjicsVls8vkYPK4MYdHaLF3BB6A/Vhz4rb8QsqPGl9aicU9n6
 Q6UDtIBFZOrwOg8o3rJZdK6EWFFCvt2coA==
X-Received: by 2002:a05:6808:67c3:b0:4a4:64b0:bf5e with SMTP id
 5614622812f47-567fd21fd92mr135851b6e.2.1794001018782; 
 Fri, 06 Nov 2026 13:36:58 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:54 -0600
Subject: [PATCH 4/7] arm: mediatek: load the next stage from UFS in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-4-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PXMg9SCn/JeXwTy5WerDpzPzcXWPle+aCdySLdFKmo0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khUmi0ggYVhAuny1q5JmsF+f22HxnHywF4Ln
 8BQjeN3N7KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IVBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEbcH/ihKNRpJRtf+e7IURlHpUsS5iXwGYUOI3RCuuyh
 +Yvb/ohSSyguEdo2Cn9GV/5SX0/lniyB+/NBmE3AeJWYcyJ94R6Yj4CA+3xBqZQr8vCnRC0/GZT
 zjbUsP0p2Hlse5jlrjg+9EZUlRcNdBCB7erZLO1+3yqzaEXvMKv+t2Lln0kYFpJo7pTqxvThlGr
 gGUuvOY4pAYIdHgnYZumQC1xW96oiMPNX6lELx4YX7ZtqhfJWKNzSiII1doO5Hmn/CB3p3k8XfV
 6cULRVHE2Jd1YhLM4tFDXFsAv8/YJfYY/TuMetADC7WPbU80OzzF8Q6YvxB0oro53s+bc7TYcfT
 yjYg=
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

Return BOOT_DEVICE_UFS from spl_boot_device() when SPL is built with UFS
support, so that SPL can load the next stage from UFS. Check it after
MMC, like the other storage types, so that configurations which enable
SPL MMC keep booting from MMC.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index cd7841f1a87..b829f5e7450 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -71,6 +71,8 @@ u32 spl_boot_device(void)
 		return BOOT_DEVICE_SPI;
 	if (CONFIG_IS_ENABLED(MMC))
 		return BOOT_DEVICE_MMC1;
+	if (CONFIG_IS_ENABLED(UFS))
+		return BOOT_DEVICE_UFS;
 	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
 		return BOOT_DEVICE_NAND;
 	if (CONFIG_IS_ENABLED(NOR_SUPPORT))

-- 
2.53.0

