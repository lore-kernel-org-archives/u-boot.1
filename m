Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D997CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36C7A40688;
	Tue, 13 Oct 2026 08:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GOYnrARemZbn; Tue, 13 Oct 2026 08:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7AD784052A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878585;
	b=nPNXSFX1KppJeCL+1+l8u5qT6AhxCEkfrZYD7jCd5lyKwNiPuq6bZ02mlNNmYGUPXmXv
	 ZpA7aDU55afImeRCshz0tU59DuXiurBuRgj0uZiLPk4R6V+1HbOpk41a4+vx5vv33ehV4
	 Z+q2GLZ6d6w5yuN8RF/37//P19FLU/pdozKZEbTgZ85II1acQVuTunam1YP0UxPkgxQb9
	 3SCOkZPxWWfnKv/JtcZvOs9GmputLiFw1Oe4S8bncd255KUeqxtobGuFipolJw6aAtR9/
	 N7d4SYu5f8GMl+yZbcqWUPYFKn2oR5E8Jvs+GvsYejgkc0+th4u8soOoM7Nccgnt/nA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R28dsWFxwoIe9e7bAiuapOOz11fzjSVycK3AKNnJxB4=;
	b=T3uzjMxJhJ8r2bOMP5wRzUYRPLig5UfqnWS18J1yJ3dbKOlJp79EsMxoZxk90SKYatCb
	 zUJ++BcY2FAITRcozM0/MB3wUfPjjinnPGtmty1lifsWifpnP6HyhTT/6kjj5ZNNDfItO
	 Rzc10o87FO+dxIvyh+Oh8FLPivtFOGEUW7oNr22+P+AEl4d5QYMPccJDT0M8cZWIPGa2y
	 5Psdc4Lx0L0p0Jbl/5+UM1HRCoal0/2KSsFMP5nV6lBHmFz1x3Em30CNq5zY8Ln2Sft4Y
	 5h6z5qOhj8BAVhfj5n0AvvxmlMD6Z2LJ1nS1odehEJTeZxzFBcTmFUq947lG0uAQo8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+YCjAo0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878585;
	bh=R28dsWFxwoIe9e7bAiuapOOz11fzjSVycK3AKNnJxB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xIN3FVnbQFiMP/b0hV9pAETSMG/ls7PB/6rmpc5L0CO+SIfNbJbXMKwzJ199rBnN1
	 BNMTIlCrhppsohNEIT2DgYwj8TOHGzQfotu7ASUKyTLoQl/LBydTLOaBks/nO4tth1
	 KOe5BMInIirkOWrrYgvEyjrhwB7WbMRc0+Z9Kza9cryrabWgGR4FRh6lHkE3tZd1M8
	 7/YTg6/XBd97D8sA9U59kjt2GilIR4lgQyZEzWELv5Pc4mO66UhET9w1MT48cpsQon
	 YaqJswXyPadVjABCzQZwmjb2INUJdAsVR/qo9+ejkgs3Z3AivJ3zfLO+0aqPnKbeO2
	 uYEc6D3aTJERg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AD784052A;
	Tue, 13 Oct 2026 08:03:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE912788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0CA9406AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSjy_GY2fnDJ for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2831E4065B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878578;
 b=ZekH6IAvRDZvoYxvC6NcHmq8pHQtFxuhazxbXUmSrUB2GX5x56Frs35GPVmgejXToPb7
 Xl6nlpLzChRdvf84yeetLymg8u4vHDDWWzti8H+xr7Ps9msoaFOhjeEK5Wc5oRpW+4Gwu
 oUe1Nx8hsCNGbaI6XnC4geQCTUVG/Cmgq6/SfDkFW5t8TckLNlklEz2G8WavDm5ZwMYEP
 aryLe3YwJ0oWQQCeBig9SWAKwAFlWL4wPF7wn13fQ1c2ab1V78MgGee28W4f6TBWJohxk
 q0gMLdRyXBiCAO1CT6Bf5fb/ruzhFWMAFjyhMMOOyF0Uhx/VXNHZArYRLqRRyIPdkfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=R28dsWFxwoIe9e7bAiuapOOz11fzjSVycK3AKNnJxB4=;
 b=SjM1pdRRoaGTiZBSZAbgOKvGuU6v3CHak3pe8OrWfnpmbmUrFs6rALmIXKcxIOZuLvbu
 5ZjvFgiXyBCvkUyUW7/72LWvmzMGLNQlnucx3prTq1utziqEwspFCWUCKIB7Vl0qnvpvu
 tVQnEIqKkONx6653FHKuc8g+X20V4y3+lL5lqaqrA5VpcmFxFt0lWDeb0JuQM7QDk2lAt
 XtINCL/iZNEDwjqo7oES+skpXN45/DxxNuZNWRs2aYl/8sCo4znt3sFWpJVxffpq+fPA/
 2FZxFTtlAl0DFD7VHVV31Ys5rW1y/yXzzZ/4amhoZ6e2XghOP7trfpOuMdK9yMdLCeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=C+YCjAo0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=C+YCjAo0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2831E4065B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:57 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3a7fecf8440so1347346a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878577; x=1792483377;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R28dsWFxwoIe9e7bAiuapOOz11fzjSVycK3AKNnJxB4=;
 b=C+YCjAo0gNNqnmrh0ZxKNlIth6CQBvPHtCNdeyqVyuMAeW47eP1tg+Tmd9c0ufIawO
 R5S5zKINmQWUIM11R4VmNjIB0SI/WXn6RovqfDCW7HkxDKeVNW7QyYai+GtA5/+Ab5Gq
 +BGBNXgcrqZeVrH93RZovGQjCWajbHlNlgYErIuB2UK4PklXRWrh5PoOeSyBbI9Ypis0
 dw5uelPlZLRTtnITWB5nn9Wos3pCOcq7MdJMgLl96ndhcVswsP2gttCcO5QkLKhduTtc
 Kn0MicVggb7F98U32ZgkERbxryhWEGPUH1oC7Kw4p5RJSWiVV/yYdFQu9r78Bgzzb4mR
 pzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878577; x=1792483377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R28dsWFxwoIe9e7bAiuapOOz11fzjSVycK3AKNnJxB4=;
 b=R4RyUgvG9wlKVUCy393DM+3G+WY7YHnE5eJJyQVZB74qnb1tfKWv6nKJgORThiH7b8
 z++0Rk/meqe07RdVR3wSURddpOlBKoDWLzVByuGbFFPk+moNvN5HDTBbMKlFTyEUfdaP
 6PaDXgmAoVBaOFu7VEVIfqIDgWCT6uzT1YCTbc+PqfplIkhOK/9yrLxsiNyauO8Utew2
 S/Psw9oTmai0mMyTNs95/UoXsaSJDKhc5MEyYSinZrKNfRv9I51viBBYKkKOhqYyVoXo
 p5QNScNX2Ht+RVqbwfq64U78P9NEtf84AZofaRPNYEJz0JaXcizg9qRsdO2Fxal0zFww
 8yaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBztb5KUM0syRwNJdEmURkTNXl3ma89e6GdzLYmstxEpQZckGMcqtGU38sCmkHqlyHOlzCMi/kQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsiFRb0XL3A8pTixflI+QO6BsMXh2uEZij4ee32vg4KEA+ADVN
 apVTZmmvbrbVIP+WS+UI01X7K3JqndY86xuLrWMja+np43EYIO6wN9xZ
X-Gm-Gg: AYBFou0/YNrPogK4ssiLHHXsM518qkr73W6NUqIiMsrm8N0yyiyrl+tFCFVO/6eOmSB
 V5UI6gcqpOqx7ypSrLfDx5ryECeofERrfi3LpY3ceHvlqriJnllSC/mT3ld25FV3IJkzViKa1t7
 NfzR3MpCmwUfwOeekMrCc6ultN3Uotm6JRakLMGRQRgqsYt4onWP2QMPG/udiYivjOqEaTnnlfL
 hfv6d3Kgl8qp0rtyxOMK57GzJkYlfWsy1ONHws5cfGnXOAcVM8sSHRSJqImRVQl717gkPZQCZ4r
 XuNpMvwcYUIGmIzuhuNON34xvUzszfBZ8x7PY32JCBolX5QrzXkDPUOXY5EgAA9GNOGgGh6Rvn2
 vJei0Dy0leexSH4KJBQWLBqayEWuvB3UKXEiItg1rjRiGwCwWh1v8vbGAUUdli1O2pRRUI+OjNH
 C5NsfQa/qjclRTVaWo670oqa0hEgUh5bgr0Oz4DVVLeUsrCwdfsDKb1/t9PEJ6Y+9Kd1ysI4tPg
 A2p7TsI
X-Received: by 2002:a17:90b:164b:b0:3ab:1b1c:8a70 with SMTP id
 98e67ed59e1d1-3ab3ad2a629mr9134224a91.38.1791878577112; 
 Tue, 13 Oct 2026 01:02:57 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:56 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Ted Lee <xrli@nuvoton.com>
Subject: [PATCH v3 6/6] ARM: dts: NPCM: modify ethernet delay time
Date: Tue, 13 Oct 2026 16:01:54 +0800
Message-Id: <20261013080154.1942483-7-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ted Lee <xrli@nuvoton.com>

Modify npcm8xx ethernet reset delay time.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Ted Lee <xrli@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm845-evb.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/nuvoton-npcm845-evb.dts b/arch/arm/dts/nuvoton-npcm845-evb.dts
index 1535defe38f..5d6da401b7d 100644
--- a/arch/arm/dts/nuvoton-npcm845-evb.dts
+++ b/arch/arm/dts/nuvoton-npcm845-evb.dts
@@ -152,7 +152,7 @@
 &gmac0 {
 	phy-mode = "sgmii";
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,reset-gpio = <&gpio5 30 GPIO_ACTIVE_LOW>;    /* gpio190 */
 	status = "okay";
 };
@@ -160,7 +160,7 @@
 &gmac1 {
 	phy-mode = "rgmii-id";
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,reset-gpio = <&gpio5 2 GPIO_ACTIVE_LOW>;    /* gpio162 */
 	phy-supply = <&vsbr2>;
 	phy-supply-microvolt = <1800000>;
@@ -189,7 +189,7 @@
 	snps,mdc-gpio = <&gpio2 27 GPIO_ACTIVE_HIGH>;     /* gpio91 */
 	snps,mdio-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;    /* gpio92 */
 	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-delays-us = <0 10000 300000>;
 	snps,bitbang-delay = <1>;
 	snps,reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;    /* gpio93 */
 	status = "okay";
-- 
2.34.1

