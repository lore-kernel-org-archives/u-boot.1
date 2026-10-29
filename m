Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mLYrWMtf;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CHu8ewSP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B700606B0;
	Thu, 29 Oct 2026 19:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fx9rEJ_mO4m; Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F71960A79
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793302761;
	b=rEiFzNXCGQDyfXolznY5h4Wygk7+rE2blg68KTfCqk0bB9Gp4WgruHi8ygL1dW2Tatk1
	 uNsCoB7d7mdSmjq4y/8N8uMndUtO8a4lCLXP5doksw4SuNXNtLk1v03P8ZnNOwwFny9hd
	 PSFSAMnFXsruZW+THFgEcBIPF9E6k5cKdAlGq4BZI5k+HtK+xrZTVAfSuW/l94cnfvdYC
	 dIK8g9W5txzLOTvK4nMBhqMzFI4zHG/vRRxInq1IJX1V7Q1TMHHpmlwE6llWbbUBQ8lOv
	 Nf+8SCul7bnZVgvogcYL9oHwZ9rkr1RBRTZqZYGBHdJtkYM6V/pkid2e8oMYpnl8bqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793302761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NENnmIDfNyjlP/GmJm48eEV6xA1au0PdtuLdnQI0R1A=;
	b=iFAEMtT//xE3kAGJhYU/3CrxIKiEmOeT92Wtk/Z7D4TyOMtm1vo855REjaIVkpO2B/WN
	 HQb0DejSTFlyn2rgIaAGOq1L1zB8pUHZXKlhWmeamky91dTSoRBDUYDv57p5Qh/CvPfLg
	 M7XP2QvVf5x2rDWUCfH9lWrfEsaRSJjsLaWb86+DSsCBlOXjNokDwFaM0bLT2D49ZixrR
	 j8liKcrIJ3cmIywKqFFXBFY28oKyp5Zoe1LbMAJrXJGyNUMd5Fn+iyVTMtC1Lvu2UcLBy
	 L0EFpCfw6jSODTxjlwRsDv2O7OZLY1ZLjuvKU/ItWiNYtI8Z/GTKYqqRU7a4HPL6gjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CHu8ewSP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793302761;
	bh=NENnmIDfNyjlP/GmJm48eEV6xA1au0PdtuLdnQI0R1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mLYrWMtfG8JccCMTulDyBOr2Lnr7D6d462HQCKk4+Bf16xEefJ3u8hnt1jAYWhrrO
	 Th6UcUuU8i5+tV/LhV4nRHtERK1uYobFHOOEOFaQci/kyLwSirlK/Se5JuM3WV4mG1
	 9nGgpBQm9+pUq7xVSqk9bh7q/w6iHa3VxnaVu2ZAGNRVSGmS6c3cP1OrLadFd/mPko
	 S6N7R3GC0ROAZFIaD2Yw7RGey2mWLZNRcIlpXgSmo4xx4Giwp1yLK2unObaHNvlYG5
	 Ny4P2SmOXKJBGw/D/rrqUs63/4L+dXe71dk+Ga40rJmpmet7jP/7jV9+drtDPMT9eX
	 3oW2Hz2ofLd/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F71960A79;
	Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ADC42E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F29BE60A5D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id beSZUMMy3S1t for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53C8760667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793302757;
 b=BYzYliIwIVLwqZUF6MHdVfcB4RG7D4x3Yr0Zn0SCXN+wxJETMcAApBso5PaBw//OIXqC
 5ZlZchbU04HHYdU8+UYZqrLwXT4A/UooXhEaWy1/n6/sMrJRkpN9OFidsC1wKP7UBat3C
 xKnxsapibm1lVpI+1hW21epgnXZSJlYdspHxJE2yNQAbP1+SByYBM1Rt+WRn74SAJ90iY
 1Q9dL/o1dEw9YSIex7yOjQI3XVBKOIC0+hwppEerA/t9TZ8oP7gk6nzhLp1Bbd+xBA6aO
 6beb1f5BGS70+uTOPbA0FvqJJQvF+dQGrA5PeMVvQhtGfK4hbAx99SISSfCvY+LpYvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793302757;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=NENnmIDfNyjlP/GmJm48eEV6xA1au0PdtuLdnQI0R1A=;
 b=Vl+mEJ2kIKJZfUd7j8fejQzgwXFlMsIULdWSF3UKJLvYgFr83MKc640vI2nLEHGECv3K
 V6p3Nhv0N6r0WpnY4gdc+++oZPGW88Q1Tbb1/ORmwzYbUBg/aSBk5h6RcKqc1uoUBTEQh
 EiZCsZ2Mn9hSlAWaFqLxpfDUVTOzCQNeMq6/ncy9IXScbDKI5zBr4ZYdtpAGpUFID/ykv
 TsOh9xPvDNwVZNRUoYz3Mk/htSOLr6z2zsC9y8CSzh2AUzlNs5OxMo97XXEOLUtRoHp/I
 mm0Z7iBJrFqaWR3vSwfetmbveL65uGVQg6kgnq6tn2+1SV21RcsYxOEOFqJ/dgfRcEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CHu8ewSP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CHu8ewSP
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53C8760667
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:15 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so18727955e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793302754; x=1793907554;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NENnmIDfNyjlP/GmJm48eEV6xA1au0PdtuLdnQI0R1A=;
 b=CHu8ewSPGufgqo4zHLX9iX4m0IBy/d9W2tw6p8nMdHQPUGvX7iOrhiJB0Hn6iz9SFT
 QChIEh3VqAUw1jOkA0tFOyXu4G8F/BZnchEg4P4QdiGRs17IljsPpTvhTnzX4uwKgwHu
 5Hu/kfG1i2PYdGW/BVpnM6TzrR7f99bWiBy/XCH7qpyC3WQTkRJ5bSFsmuzG1jH/bRH1
 nN8swEMlTxl1ZRySw5iA/FMnQb3sCO90IUxE07A8hJffSYv8WQspxRzYYZFhRnkhUFjz
 q7gTZ2eOW3qEAzZOF1kuVfCO4l2AFOVjBisM+yzsrTOFTTVGQLxLdtkzQ1ZUsj11DcuD
 B3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302754; x=1793907554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NENnmIDfNyjlP/GmJm48eEV6xA1au0PdtuLdnQI0R1A=;
 b=12Kl2QBHleQjPj6ueqANxIrp5OPBESrbuQgGqam6TPnaj+iSt23DhyqEnxFfAHk1pe
 vysxPWPwFQvlhUUe5Q/9UR7zgYH2q0+kAy9Zry4wloe443+R5nm7OswwDW9vGaLaWMtT
 dlGnz0MDrp3g26bGG6/WfiDlFYQv2aLn2qHTB3MgPjrIRu0O+FRrZDdRMF4YuaAUAVIJ
 xkzkIDoVP8Djg8yUg5v8k/eWB8Oq/87E0NH2NElNC/PpSdEp5lgkmTdyQ9zTzmeyL2y0
 T4ykJsvoW3fHvjAzbwGZl7NTew/2wujgH1gXKP2+tcGR+U7VbYd60lS2mrM6hMR7vS4H
 ayFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfg0AtNb9lKhzWIGbCYF3C9o2kx+NNn82lLfkA2uV20zUVw0L0i3cKL5oqtU0lTLCnzSZeBDs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7r5yOnXlQyNtC585r2WHtaf5MAmmHzxy8spOLPXQ55HGiZx0d
 sqqcn+GvMMXZtpFoE4AvJ3bIH4QKPUaxX1o7qIUWvq12TswqDOVzBWW4NQ65L2n5yDbsQWhJgLw
 1Rb6Y
X-Gm-Gg: AYBFou3Dd5wS2/CViJZMi0E5PDky6c8EeMaJWvHBhlWxt8I2ccrQ1ewplxRvJ6jfSE9
 u96gkGevCBTMahyzlqPm5N41GDqUYhIjTQkfG9z2mj7QVqb9cvnmTDpkUOzO+8P2urpSelYGT6z
 UvR8AAjBMizXctm5j5W9gmqpAv9hIS212F1BWxIpOS1m75SqtBS/JIpsm8NuEtypAHekYcMnHth
 mq933DAAaAnfPV+7hzkPamQqGXzyADIXsL7WIdRZ+OHJeo0HXKO1My7XbGoOX9wZuG3Lla/lKPf
 bIwfCyDJD4avbwUVEPrq+v5HfY5vASPAq1edNf9y915salX9iWXj0Ky0rQFNXolGLSkqjeGmhEx
 AmuyekEMUmbYvxIizqxG9OobgDK34INzb+txHN/X9Xum/aTIbC471TU1pDkVakWw7+4VY7w8O1y
 T88omNhq7S50jDQX+ARXGKWXenWDhh0ZrW0aFG45x/W4A2iRGGpqBniXtBV/ERtQRybp4Tm52zf
 ktxpeLYZwn4meS1ZzBVa8Fs7CD0YKuT26UW+qrGDal3RSZM0Fg2DmNyUCInq12tLS7KJC70D6tp
 BbwXoC88IO7XpQ5R9jnZ/f6PXmcZkMDXQGj6tzmEWniM2CA8r+qJ1JvTEiuqqs0Cac+XoIeUBLR
 VpRggF8KnyRMIf/VPlw==
X-Received: by 2002:a05:600c:4f94:b0:4a3:5a42:b29c with SMTP id
 5b1f17b1804b1-4a967202997mr165935475e9.26.1793302754007; 
 Thu, 29 Oct 2026 12:39:14 -0700 (PDT)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm1987645e9.3.2026.10.29.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:39:13 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 29 Oct 2026 20:38:59 +0100
Subject: [PATCH 1/4] power: pmic: mtk-pwrap: honor fallback compatible strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ccaione-upstream-mtk-g700-usb-v1-1-6b0dda25be38@baylibre.com>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
In-Reply-To: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
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

The MT6365 device tree lists mediatek,mt6359 as a fallback, but slave
selection compares only the first compatible string. Consequently the
wrapper reports that no PMIC slave was found even though its existing
MT6359 support matches the node.

Use ofnode_device_is_compatible() to consider the full compatible list,
as the regulator-binding path already does. This allows the Genio 510
and 700 USB supplies to be resolved without changing the device tree's
PMIC identity.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 468af1fba04..2e206207136 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -692,7 +692,7 @@ static int mtk_pwrap_find_slave(const struct pwrap_slv_type **slave, ofnode pmic
 	}
 
 	while (of_match->compatible) {
-		if (!strcmp(of_match->compatible, pmic_name)) {
+		if (ofnode_device_is_compatible(pmic_node, of_match->compatible)) {
 			*slave = (struct pwrap_slv_type *)of_match->data;
 			return 0;
 		}

-- 
2.56.0

