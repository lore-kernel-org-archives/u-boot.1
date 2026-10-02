Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55BECA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E40C40D90;
	Fri,  2 Oct 2026 16:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrkjhKGSIL2P; Fri,  2 Oct 2026 16:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 63B8340D78
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790958972;
	b=HLtk2680a/FvtYW9X/y1p1ryJogyyBBMtFEPWEq6LAByST7geNeywPcB2iE+zACmPy46
	 C0aGGbu4Wtl59LywbLzlPf67VJZ6LlLlD2jODTYgMU4e6xNA5cE8VeydylKeiv3dZ6unB
	 p7F2O4pjAsTIpx3doPj3pm4qbZ69MulDWBeYpSurlRbVZLusw2jL27oUSGDoZ0c4lfefK
	 W3sFBk+R30VSrjpnAj5EwdeUwSPvzxzLRt2dJyEuzDXyMqhg8dsnhYFdj3UslYhFHadN7
	 juUULGKwHPgDt0GG+kSyHSAzRn7JcBBjaagZo8hfgBbGHP4iJccAJ4sBOT5J63pshJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790958972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PTu7Tfu8aPkQCH9UuyysPZrtHHdPGGSayipPvtrUcTA=;
	b=IFDx9s9kqrA2tbZRs8r2Vte3km/VQ9mXG6p8yW7s9Vq07jxcZ1mNS433cC1BBmst6/Be
	 b5hJqsQ99wmcqkcj6piDYfMfVZgj/UkqxthM/Hki3qLWMqj0LroVKGxNM6hbgAbpL1a/L
	 6PW+n5kucOIRwsLy7KxzT2acvwk8oIoNxhB3P/HPOo0AE6kzOEYYY+Bt4tv7S3IG7gVDL
	 QrBzeTAHzxd8TLfN016OqN1SqcBFrIEsdgZB9t8XJvuhcAF3HktajYA5qPXEU9kAnz4BG
	 d6U1YbHezERJRxpACvWXGGCFDhNqcVPWABKrq43hu5fxHyMEgl/U+d831x6qLXGxjzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TX+Typwo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790958972;
	bh=PTu7Tfu8aPkQCH9UuyysPZrtHHdPGGSayipPvtrUcTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0oH74YwY0hOpsV3BEGPX5Jv+2aivGp2ZBioQK8TnzKjdfLfqx6ZxFRKtYWpqJb9X
	 JpMIu+IYwxFlxKGumdN6KsumWmAuPb468frExjWvE6DJ1sqc3uWQAr2x27my+Rt8vX
	 XN/iuq2Y+Uv/AVFGKUuUNA2SJzcpAVQA1U0L6bdvvapYebc0amcu7m9DeEx7wTtzJC
	 CTH3JWukpRbxSUdg/L+87QHC0dpKmn1DxQljCMiqbJy1jsqxNszHorUZbFvA/1BQyW
	 obHT8NChB+fJDFk/PNbbRqkFUQCG/kxBzd1kdTlwcw56TQ7eI/YGz6F5BZeKlfcupB
	 QSkFhbx5HKzuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B8340D78;
	Fri,  2 Oct 2026 16:36:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D515032F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D21E740D78
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORQIrQOGxKxD for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BFA3E40D6D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790958968;
 b=oS/juFQ+2esbsvctVtgExD6ACy/hvGXD3+s76RVroRtSBLEO+sfdQVrNO5V9tHcPJAUn
 PWnbdlSIy8EYnOiiRZpmpqJkSPJZdzITWNTn8a3hfmV2YI55dd3Yaq7JyquSvq0e/QSpF
 oIwWnB5QD9e3eQ91uWc/QB/c17zY+SLGt9Z7vZIA5j/HdDgCXk3zbvkRoWxdVheiqtYSl
 ySfbVV0XJgFazKQlCC89BhkpYsAjqpri57w8kDHUsu7TWXf3ie0SED0ZZz59GgSKXolBz
 NLO8moDp5xB7wsW4xvHO/JgaL2Xn7g2ESrzZFOPciMHBmWXlCQHRH8vZlFt60ZijiNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790958968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=PTu7Tfu8aPkQCH9UuyysPZrtHHdPGGSayipPvtrUcTA=;
 b=VcSPbilz8cnkc6p8FlELuOSq+dzKtqRMDJCxu/Fzpb4t09jd8uT6Kr/oBXnjDI8arYNl
 AQbrbP44rWHp0OkK5I3iYSMue3FDshYCa8Hih+nrbjd7Cadn7UeKN/UjQxXy1YqwtCn5A
 S7T3MQVTXrRWejdC/khwBGPVp+MtdVdV1TTcV6PdWy7JoR0Bj3Yjgojtr3tNpp7gXQRUT
 sr2tGrpLaniL/970ovuKqka/HqSDae/EnUYrkw8syBbMPTs6cG9zuc2ylYbsdaaplEJrK
 7Y+UVB3ViZzqAyajeg5MaNDKdB6CsF6faujsUJzr5ts04ZrjeFUoHMSfDpQ4FOKsleg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TX+Typwo; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TX+Typwo
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFA3E40D6D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff6f0f87so571615e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958965; x=1791563765;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PTu7Tfu8aPkQCH9UuyysPZrtHHdPGGSayipPvtrUcTA=;
 b=TX+TypwoF/YLC/ndGnuvHrO15bDScXCfoH3Ybcf/K5BL79jXBI4lXH9p9B3duELuGt
 QgnAe36sUMd/Ksj8f3V5wFPCl52h24cXsmvJtw3qFfYtGv4Zz+wrYfom4ytW300SRgwa
 m46hJjZvRy+XaI2KgbiIHa3qWKz5rGqMR2NwRMxMTD0gdo2y+wnMV0g8f3pv09eNueWT
 PS64T/c1ecCrZ0efhPg1QMvVCkAvoqezpKidlzELPKPiq7vOWeb87NTgSPYtca/bxGoL
 JQi1O1+KJ6LrJR/u3QIakcxOJykpchBq8JBALm3MbBRTBelpVitz+P8Vsjz1SrOqyhpp
 IyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958965; x=1791563765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PTu7Tfu8aPkQCH9UuyysPZrtHHdPGGSayipPvtrUcTA=;
 b=GWI2QsBSAabfACMCBdLxQUDbCi8v5ZwimRiCNKDIE5MEICJSwvoU5Prr88US5Rah+C
 cASQsemNMnrx/3oe444ziTx6JnP8envJNKFUfkPTXtsy3c8omPH2NVlOqxayJYI4gfut
 pCi5e1zc18s8/p1cvGIe2QVvz8wmGogU1o2IZYE5Jc7LBmlcQXkr9a2NnDAQw1Up/LiG
 FSU6F2AQfsIHc+4cJGTmHdZ7mYgWWiVyc7MIvLcB2SYLgAruGHyFJ7z9SBmrhhK56FE5
 J5B65p4JW8AjL7I+vDc+h32PLp/qovxvTVpnTElBCe0vvtHy9BAR6/jqv9SOkf5Qt+Dd
 Vw6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOr2pzadfEentxzcyruu3TwRUxcSDsMzTtbjdH2izB94ULavxlWkRzL727Mw3RaEZlsqWi6gE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mkA4DvXAKdRXSe9klnyAq5Zob4kY27lVRdUiNKmM1Bsw3SSJa0
 FieL7SaO9QsfgGmFFGyYQYo20SDkxiz2gma20nIwtqUhTHrrPok6n7bZ
X-Gm-Gg: AYBFou0cH2xVBuGw2jPzf9btLphTqAxmO+/naKGFICQMMrVbX0DGW/1+jybtdIReaQ6
 qtkfmDFgbrxDzH63LNx9VYiGWadDvuJbdl5x4Eez3eRT7WeKztlvMfPfvOTizhQqDTW76aeU5bx
 dKPXq7ACoN2513K0XcR+Ijsmfd8rXBc6ExE2i9dcj7n2I/6mxI/gezTEzr65je4ZjTr2ajzo9fn
 +2t8Ier+oPsw1LC7znCSjVCpYIot9gHlU0fjL2a5QCofZAdjbLiKI3MZ+wVGAVt3OHkJA9i76lS
 46kQrRA3a/6db02gJ8TaYaGViJ/7cPDxwLR22+h+5nrM2JyyaFFYv7hMskPRAn5noPoNb8nmP4A
 y9xWMm2mr0fqHCMJfIosHMXLnyiax/rA4pJav5knXq2cGN/LQJzHGUB+knS8amykUQ2FdLyYWB8
 J0Stb73z9N+NgW0l81BnMpiEl56mlgAhxXHZVOYj5oZB6Od802cEG/8IB95C/ToejcHcmRzoRXp
 /SAh23hDqI=
X-Received: by 2002:a05:600c:548b:b0:4a0:53e:b7bd with SMTP id
 5b1f17b1804b1-4a027594e23mr58654405e9.18.1790958964844; 
 Fri, 02 Oct 2026 09:36:04 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.234.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7135338f8f.39.2026.10.02.09.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:36:04 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 02 Oct 2026 18:35:59 +0200
Subject: [PATCH 2/4] arm: rockchip: Avoid TPL_LDSCRIPT configuration when
 unneeded
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-config-v1-2-11bb20983682@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
In-Reply-To: <20261002-config-v1-0-11bb20983682@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

There is no need to define TPL linker script file through TPL_LDSCRIPT
configuration option value when CONFIG_TPL is not selected. Avoid this
useless row in the configuration with no side effect on binary outputs.

Involved boards being built without TPL are a subset of those based on
RK3328 or RK3399. Anyway, keep aligned PX30 Kconfig with this fix, too.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/px30/Kconfig   | 2 +-
 arch/arm/mach-rockchip/rk3328/Kconfig | 2 +-
 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index adba1b49a52..ee36cf213be 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -75,7 +75,7 @@ config SPL_SERIAL
 	default y
 
 config TPL_LDSCRIPT
-	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
+	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds" if TPL
 
 config TPL_TEXT_BASE
 	default 0xff0e1000
diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
index ec1dae8d413..032d90927f3 100644
--- a/arch/arm/mach-rockchip/rk3328/Kconfig
+++ b/arch/arm/mach-rockchip/rk3328/Kconfig
@@ -22,7 +22,7 @@ config SYS_SOC
 	default "rk3328"
 
 config TPL_LDSCRIPT
-	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
+	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds" if TPL
 
 config TPL_TEXT_BASE
 	default 0xff091000
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index d84a9da8ed5..250e3728948 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -142,7 +142,7 @@ config SYS_SOC
 	default "rk3399"
 
 config TPL_LDSCRIPT
-	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
+	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds" if TPL
 
 config TPL_STACK
 	default 0xff8effff

-- 
2.34.1

