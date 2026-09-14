Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAE4C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 13:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B9ED4066D;
	Mon, 14 Sep 2026 13:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wqm7Jqs6cywF; Mon, 14 Sep 2026 13:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 27E68405BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789392971;
	b=OinHJDCscQLm/J8Y+7hwrkNSApL0tvRIWHRLdOXSB4cYLd0NK6prJjMtuIUbF/KxERu3
	 s0WMG5a2irGsuRhFYwv6sphUyoAADru+VOpOXMSPVhOXIOZ7oNU28uC1CmhXdmQzN16Ar
	 V6MoEOpBhN2nhZtNGfXJmn+uVt2MtDJDOKMmAehhhkpaiklow+NMr7n/UNHpmPXFWN7Ij
	 IB3coxB+J8WMWSTJrBYNeQIc+NDkgXP9tEt7kqwPI/FVeKQfqxlJ+Zv3RaU7ilavOsPin
	 j/1fyVfMXNXhtMPaAmpJHd7p40DMWzN8Lu8zPAuONjBN8O/3vG3PGUjV11pZ9iJELxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789392971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sKJmHZkVCM8yLcBa1bhmbuVw+f0mpAh5ciHiL1v5qt8=;
	b=abEwPeQUdVeK0hP27fx6+XxOdX1EQPwuV2LcEg+EHPwrthvoUe2AOqKzk+I66NWykL2h
	 pzBBVHZcYlyH9b4yYXxkc6x7Ay5lFHdYbY9UHSRf+oy/e1HcZ/P+PwNKuyGZ8lYaJsjYB
	 iGyF9Qo3Z+QenO8Hl88CT5bIe2ukyvpPiYAtjBWFpow4OSzo82ZiwAb9WV4NWWkzFtaus
	 129A85TrAOKOcp0pAk7BTQdykOuMm16X4OpSm+tTTsRSRnzLbY3LOaGxO8FBlwCrwS76N
	 33jLilK/qIyW+6lMP4z4I8Ec0qjE4nqUEgOnlXXkB08wzcGxnJx/T8TKpcNGfqd2VRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789392971;
	bh=sKJmHZkVCM8yLcBa1bhmbuVw+f0mpAh5ciHiL1v5qt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/UZ+LtTGL+cxnuuONbXl8MXuOucTieZKA0PGGDN6K5xIo6Hy5ytknzCEjUtNFzlk
	 vyOUtAXW1JJaQPxq4wi2jyNyvLQU4H4NOmtaNVp20HfIMXmDhnmAKjjQP8SjZEpCgU
	 lAtv/b86trIeO8H5ZmqmaAfMcid1NcIfwerVcJhmaPNtItYOBGZatYSGX6B/6B25A4
	 cvTuZyxwfIBMn3/Q30Z7RfNsd8k6ZsBGzk39TUfU/QcbG1P52rmhI3tZRvwN9WmH1+
	 m0n/wQ+aXScCgkU8VBPcCXX0a5ioMWB7+KMFUKxafO7VmVQkdXzqOMZxuFRL+MmBGY
	 rHA5jzhsAQrdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27E68405BF;
	Mon, 14 Sep 2026 13:36:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 256E7EB
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B11780CF0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BwHwVEAMBg7 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD30D80C06
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789392966;
 b=Wfsa9u8TL/8WHrlBSiBy0Kp9UiISVXRrq5cwFQfDV3me8vcBmcCZ8S0WmW6tw4bg3Put
 cylGSDhhsH2HLWmtjkocjen3+TIXcFpdLhiGSlLyzzQYzMEjSK4Nk8fOvWE+zW6PrW/1U
 d07iTclCbTlysenHBOH6Ic7WjZTPOS66qLNAQfbqJNE/LYO/0Twan+AO/kPz+sYQEo3we
 Vt3OriudFgdDHXgX51rro1vJR9EOX8pIEdsOedQLwiU3pBqFtbgoV3ly/zb1Kto91IFcN
 trbwyzl6KcLZXjiW2BXUUp57M7Sdg1EggLVR869OXtU5VK/YPDPC5r6ho8lWr1gLCbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789392966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=sKJmHZkVCM8yLcBa1bhmbuVw+f0mpAh5ciHiL1v5qt8=;
 b=foi26dRrLpNQriLVFwz5gV4ajMzu2aDeR18rt9yLYOWur6I0CQIbR3kGAyTRPIotVKQJ
 n9EXduMe6KVX+x4Y4aVcmfGjoNmqngAMaGY9v5Q1g6aAJa7Ux4O+Jp0ZKzkvm+rlPyBaJ
 EPwBhxwMcH2ElvbyErvWL77eHtQWICzY/B7Io9bGbpRoT+GenudFf3yAWrr14/IoXy1Lp
 zB61BOx1wOsAkGF5UNiCgF/sCgh+7FkkKqUNVbviRKrVzziEu632j+RUj6rX6Le1/NyYH
 v5XOc7GSmB++Bknw53/yT5mCpbU19fLnrgjCH7PX+NiVyu5H2mCLBLxWc4LwqMGVuZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=c9A36Mpb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c9A36Mpb
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD30D80C06
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:05 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49e6e69d528so20659785e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789392963; x=1789997763;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKJmHZkVCM8yLcBa1bhmbuVw+f0mpAh5ciHiL1v5qt8=;
 b=c9A36MpbteDm6v/pp9ORKcYcH5JkwEg9o5Um4fxVHi6Ke8MuTWTfSvJlEvjebMlg8h
 2IR6tOogFuuD6GKHThGS6zOLQxE8zHOalb7BQe/gC/wEEk6cuT5LjBrdiQqVV/e8yeC+
 UZsZFKXel13E4LdDz6hHHRPg0MmVrCUGrIMcMnKC9HwputyAWOYkbGPJi/jwbJvAQQrN
 G+rJjLJmPHGwMvcnqrJYvhcJuBVWM+xzCNAJLGSqyrPp+MoMsJuLoCY4t2tGR9c6QT9S
 F2VMedxw5If+XEd3aupvh5TEQrCGU9+yb1EzPjHVgr3rYEI11DK1o9eahMTt6lE+Ntbd
 wzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392963; x=1789997763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sKJmHZkVCM8yLcBa1bhmbuVw+f0mpAh5ciHiL1v5qt8=;
 b=daE2dJuMirNsDLQqcqIhuXMo0Oi8FlMfLers9kuF5BupzeyiD1ftEoHKImf3ifftiv
 9B1Hh1At1waam0VzmNhDEYigpJ4nGfEzg6ea7O/LjWP+q42y5w6+xFWDMjCSvZlDAyOA
 6t95GF3SIcJFXq3rp2pXPo+MjFjeo67O+EBv8xOQVSPGaY4gIYueoYfIgzvRas9Gr9Ul
 DNETBgpUDM70mHAAeqKXgZ8xulRLo+5oC/cR0zp5AdWZteXikg+UB/icuaA896YUSg2y
 ejlUnXJUnesxbM4EzmxX5TYZ9+tTeGhGhWUe+dLhKlyDOjA6xgDaOUQdChpW9kO0JGsY
 ZTSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByTRMYwdUYPlo9/Lg6Mbe6g1hrpokwbFJDCZQ3wsCBHdxeWdZUqdJasrliBTQb4wZ2BbHNyzGM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ka8bOI3eaeDWoFYxSID8Z4r0xv4z2z7R2c/D6VLgV3iITYpFzL
 oKsPKjcjK1IJNLuGgIJxea0Qqdz6iUSamT2gD6OIheOt1P5zcfaOVokHDnHdAg3xLUU=
X-Gm-Gg: AYBFou0kOGEFiEpcpEbCvhky7HVsyjk4xHOYtoUEWaidss4XhHbSI1Yrqp+++eI8dR6
 ZcOzwWubqTC0OlK3vZOsXZu/UaLjUCMnbeKRugfBniX2/TlZGkc+7r3/y6X+cvl2PVosLyVrwvg
 I/wTtYGIPP2iINY8Jvs7cKGM4Ug3jZEqDbhU6Q3w1N6BVpjMXybxbkZAAYOCloU35KodXg85nn2
 3VjKqX120pB9eNh3nlU3Xefk/CheKPtedfM10o/jArgxUHlJWmaTXWGM5VlarmECunf0c62g8e8
 k+eQEEgvKu1QWCLkOEm8PVf3Gio3XwoJ4Bv3lJfWdXLKtS2aQzZRrp8m8XIW9XZtF/iFkOO/A/q
 XgnW6p2PFEivRMgZVDk/aTm87VaEK8vSnf7/TkdLn0QPuOOd5G8314GUKbqVhf+JxzNvAlXF0y7
 bP8DeUYMvj8t6EvbcztFH+hiShgXxEfCxEQhKUUVraVvopQ6T7MDrpZX1cyH2ZIvy97OlKNnujH
 fAuf3XjsWRtOx2D/fr5WTiH3BbTRmYGkk/8i/AyEa+bPJaHyBq3RNQ0UZZXAvs/GzodvYfFPp1B
 N42rf+m0rCSXRrSiEveXVWnUeA==
X-Received: by 2002:a05:600c:3b9f:b0:49c:fc6c:be1b with SMTP id
 5b1f17b1804b1-49e7a691b0cmr39783155e9.33.1789392963305; 
 Mon, 14 Sep 2026 06:36:03 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6c0cb676sm236400905e9.14.2026.09.14.06.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:36:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 14 Sep 2026 15:35:46 +0200
Subject: [PATCH 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio 510
 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
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
 Carlo Caione <ccaione@baylibre.com>
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

Some provisioning flows need U-Boot's command support in addition to
fastboot. Provide a U-Boot-based download agent for Genio 510 and 700 so
these flows can run without relying on firmware already stored on the
board.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8188-genio-da-u-boot.dtsi         |  3 ++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi    |  4 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi    |  4 ++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi | 62 ++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                   | 30 ++++++++++++
 arch/arm/mach-mediatek/spl.c                     |  3 ++
 board/mediatek/MAINTAINERS                       |  3 ++
 configs/mt8188-genio-da-uboot-fastboot.config    | 20 ++++++++
 configs/mt8370_genio_510_evk_da_uboot_defconfig  |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig  |  2 +
 10 files changed, 133 insertions(+)

diff --git a/arch/arm/dts/mt8188-genio-da-u-boot.dtsi b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
index e9078f37157..2bbe9f2b8f4 100644
--- a/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
@@ -6,6 +6,9 @@
 
 #include "mtk-genio-binman-u-boot.dtsi"
 #include "mtk-genio-da-binman-u-boot.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT
+#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#endif
 
 &ssusb0 {
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 608987ca6d7..8b665d59a5f 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -16,5 +16,9 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8188-genio-da-u-boot.dtsi"
+#undef MTK_DA_FIT_DESCRIPTION
+#undef MTK_DA_DESCRIPTION
 #endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 6c6c85e8767..f52cc820d90 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -16,5 +16,9 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8188-genio-da-u-boot.dtsi"
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
index 59489c0fe65..5614cf70cd9 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -273,8 +273,38 @@ config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
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
index 6f1ec052b95..75b51f4986e 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
+	if (CONFIG_IS_ENABLED(RAM_DEVICE))
+		return BOOT_DEVICE_RAM;
+
 #if defined(CONFIG_SPL_SPI)
 	return BOOT_DEVICE_SPI;
 #elif defined(CONFIG_SPL_MMC)
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 27aeb4dff07..73d7873b8a3 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -29,11 +29,14 @@ F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8188-genio-da-spl-fastboot.config
+F:	configs/mt8188-genio-da-uboot-fastboot.config
 F:	configs/mt8188-genio-da.config
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_da_spl_defconfig
+F:	configs/mt8370_genio_510_evk_da_uboot_defconfig
 F:	configs/mt8370_genio_510_evk_defconfig
 F:	configs/mt8390_genio_700_evk_da_spl_defconfig
+F:	configs/mt8390_genio_700_evk_da_uboot_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
diff --git a/configs/mt8188-genio-da-uboot-fastboot.config b/configs/mt8188-genio-da-uboot-fastboot.config
new file mode 100644
index 00000000000..5e493726c7c
--- /dev/null
+++ b/configs/mt8188-genio-da-uboot-fastboot.config
@@ -0,0 +1,20 @@
+#include <configs/mt8188-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT=y
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
index 00000000000..282ec12bacf
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8188-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..0302fb5e8c2
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8188-genio-da-uboot-fastboot.config>

-- 
2.55.0

