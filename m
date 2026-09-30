Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E986ECA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB5A60B0D;
	Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gB53fBag9XN; Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F52860A4C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772734;
	b=swVzmj88kXlEZ676xPKF9y3YRiWrNUtIcXLQwTxwO95RoYO2oxW4caDOjsDbiI2SWW4J
	 ybNB++GG3brk2fPt/CKJOCjfuyzjQKTOp3AUU2Rt86mOlLgsysfN6EC2XhIoTNA3Va25F
	 wJsi6XJ0ANfvuYIIV/pyhcupSBbug9B0UlKwMbq8tyspxcMUmT+JZupZmARb0iLt9dSW7
	 VxI7BSceDeGmnOnGOBkpEMSmTQr38Ju9epPxCeSnYj8QE74FXZPDaxIKENzXYsTTM3QHJ
	 18IH//e5i8SwqFVXIcAeNg7lYX+/ItW2b5b01Z05MhblqzD0Quc0DG6nCEOrMexEgWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
	b=maZycNm4nmEuEPNtR1Tv90GXUImfX47qNhh316bvgEFTbHjVN77O9uy0k+mGgqcPCNMq
	 hkTo+Zyv32Yr+nmMtFbix+dmNrlEAtNlBpyGPLJwlmMQN8GEI0K89vPlNI6vtd+udmuw1
	 Lp2B7vloE3v0zHIyBOJeHiGFgQW0zq6x/OIx7tE5RVyWyepKUOsZ3d9tY50FDZ2c1JOfw
	 uQgAI+kOR8TE+horyH4VyfuxH2s1bXVSp+/tXQiJtg/cBcAK6IJ5kPe0lGXchuQFwTNP6
	 Znwy5FYcIYBU2tPV24TCs9ppvluo8B7bCkS1ufN7CLN85WOKfT79IYKbrCNiqRWHS8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XuflB61D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772734;
	bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4xbfqv/DXcs24P5A9Waxs2oIF7c29yPE0aGvX4+2znCgThP6wZAh/SmVoreUBwO8
	 IzNjWoWoilZY1d62U/WTzR+jnK51Pp+MP6GgggFuYNA65eK8W4TLBw+s005G/tkuHN
	 L5SNfUIQ3j8xzmewFQwvoboBVc9RIdfLqZr5plNrmkJ9Q9xKLlDLs+tnSuQ/da0EVH
	 BRjbLcEjMzXYpu5oPLT2vWLpww3ir4Hgugv3ipOlpoBRp2lnS07PtcMbk6u/xQ/SrG
	 qO0kN4xRZZqQ0POjOvOeFI1CT75ruqjTIIk8OWIH4xuMXIF6oZkNFMCesjlNSnXhpu
	 44XGM4AN95+0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F52860A4C;
	Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43CAA33B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 356B460A4C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtIdaPLsLt8w for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D7682608A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790772731;
 b=lv/Fq6ER4q8oRKqr7xEracgQiNeqxhyHp/YqjJ8VQg8ybuZgDczz4vK41aJJtQdkSYuV
 4NFwEexJ+LhHIEc1pN/+S+H4lKOP6FZ/DqEsPz/SbkioZWfbqM2e1zo7LF/GzI92T8BDs
 RxGV1odNMjffJg7nSBe1xuIwRMfKWUrwg/ZdqKm+qK39JQAB9axFBbiplAskH25DsYmI7
 aTHmr5smZgxrDs0lx4sJ3/BzNjMV9OkQc0s4S09pJ01g+eFROwWNJwCbDYQQWi3L6iSfz
 UasXqJdg+B+191Hj1TZv5UFLw9fWfXsyHewzPp6Za8RK83NazHx/vr5xMhXw6urkZzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=rtm4G8JlngwJ4Fhxbe9+SHJEyrXNZ4u2n1tev29qWfhBXmSKMg4evv9Ne0P7R/6d37sF
 eEO7YbUoqcP63Ukf6mF1vqNn27zYnO5paeAtTkKOY2vRaB7aCwsIoYbZun3MWk1GTrES8
 sE/7tTPy12Dk9d+J5e+Wyafg602046VTvMmA5trm7PmgV/K9BZXwWDvyF+Um2cQ0bHARh
 utKJpI+1WaBoYxF/NhVPl1Wf06FVfNAdZm+UAk6Ov1D9NEhsaTFgtz22cS4jSnBQBios8
 B18q8yCbZY0NixteVNCvYVq9SZxRdzrraqYLRihrVae6LRwNjSJkVNsm3o71oidyaLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XuflB61D; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XuflB61D
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7682608A8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:10 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887840c529so1885511f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790772728; x=1791377528;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=XuflB61DegLOCNoenQzbix1bRbI34n4tK3cL8DcQ0yp81H2tlmG9s9lpexqsyK9ElE
 087gSgxZCpKQPlqBss/6xIdwsCwPbFf9He2r3XoeK3wa+FOv7F4Zf9jY9QuvtL7u4D4f
 7b8z5HbCq5udHMb6E52yEWDsaqIIA0lVkXwo2LvrUywG13C0tokz+apvuaX6r8zsMQGi
 Nb31J1ozIEg4Kt/69tb/MMEqjNHSWmmfzyVkuGkerWiIrg3TLFwylFh6R6eN6m3kr0u8
 xI2lw3y4Z0oyYOkM4qGaJpRtjmX1D1p6IGqTGodryCUWHPcwViHwWZjOUa1fHjPgyOH1
 wP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772728; x=1791377528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vQ5ZIn/MbetpdywuKRtnLId+w4IPiTohNwoEewUeWsc=;
 b=rLtiPCzFRMS4f0zOwDeFckjZfIaqwZ86VcJabqwsU5mpwBTtPf6EF/utNGE4TBs4H7
 G4AH0+HdF3AaJehio/F9sTmBXKC0jK5DHS3foeSHOOihunJvHtWRu/I5OpUi5OQ7uP+g
 oKe3OsjHKu7Mx7CQXHprVNfeuCSa5ATA2Ho7Ou5SedSzK0hZTSa7PhP4RTlTPiB8lqVS
 S8d+6jwbSd4WlR38gnfYONngfGygkppKH8ZUeUOqMrlwv6fGuOis1uhes8sGmormOv5k
 t4x6hlVCwYvk2V62M/iy5vGpyEuqHg4dBSV/1s6wR3yN5/2EMn7WVJIes+sH8xMQnxm1
 z/1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVSemcpS9mDPFh0iFHOukeYwavQpwNYmdCYuYZd2ZCd3Nu1RMRKgtZTTr2JvrxsHBtFpWN6l0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kbpnj4vtGNhX+6zGLhQsSbn1IRTZOAldc9G/4993MqwfNviOrD
 Lcxmduv8kkxqauEHDaKZPJ1fIACbXq+6Tqq9JvnBNWHQBfP5G3jMDkYGsVEdMmcZ7lI=
X-Gm-Gg: AYBFou15fjnDHbzxofGfHY6Y1m54x6C09HOs86HIhadg0ZVd/DaDLOkp8/HIkybP2JL
 NBSS4gbqz24UAUaIGTCmj/n2ygRgOtl78pS6SjeZ2DHePpAa5ycwcfAoV3Xj56NJXy2wUQY1ih3
 ZjgxirR6J2wxmq6VlnbWThnXqxkYEv51k/Iw0SUes2h+Yt6CSNLxF9twQdDX7sha6p/r+wbCZ/5
 SQHNsf1aO3dTwhQchXC9lF4eToQ3c3OmQ/cAct/zPtBqFtFcn7vTEYdrQu4odPb9M3RVg4HE6+R
 J3F17a0hatA4p1xAjsajYGlspOeif8gdAA2rgys4ugnwp/lpdzgvLxPeYnv6/phkPmrpwpwUcpq
 5qUqz/lxdRARyA6DfgFgPHKh/zECD+G9K0lxx4tPHNF1gc1rwpZsZX5ksZzfNLGTw4vGcgORQyF
 WEpH+NkJQ925Li9lKGtKvOuaPKKaXksOp61DwG4xaExJx/txyPkeGg+antPKRmKU2EdtYcwdBCJ
 O6ErdL4AFqIdKVW14LPzS/OxZD+Ey2RLH9trnnJZx5XzpMs/gexKUQTghpeFNhaJgLAecLxOiJP
 74Z+1htYzsEN
X-Received: by 2002:a05:600c:19c9:b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-4a01b1b74d2mr20124115e9.12.1790772728476; 
 Wed, 30 Sep 2026 05:52:08 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm9928905e9.0.2026.09.30.05.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:52:07 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 30 Sep 2026 14:51:33 +0200
Subject: [PATCH v3 1/4] arm: mediatek: simplify SPL boot-device selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ccaione-upstream-mt8390-da-v3-1-ae6091c7eda0@baylibre.com>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
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

Use phase-aware configuration checks to make boot-device selection
easier to extend while preserving the existing device priority.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-mediatek/spl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 6f1ec052b95..125ebcd784f 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,15 +33,14 @@ void board_init_f(ulong dummy)
 
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

-- 
2.56.0

