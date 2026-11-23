Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAD606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QBu/ywUi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDJ0NzYg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB87380E07;
	Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKw68vNfg7QP; Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1295780DE2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456816;
	b=iEcQxUUHrMzjGKv+QBluKbmqz3l6LQLCgb/BQ0XvlJeXR+7VjrSfCKznJVmUX1+BDKJK
	 /ghkfnstFj0KhofCpSKl9wSsahmoy1lYxl4ozxkYPLY3wmyoeKravr+AzxWEYsd30BnZD
	 Xgn/UFMHSZ1PN2ISST09CeaHuRW6p4/Q2irdz8Uhuvd6sZyWw9IQagxI3Iy/9dqgPOVgh
	 XrzX3wfQC28xBXzrZSkAnMNNskHKCDtkQ1ekgmQXxjHecpKArZUmjO5odhhes3qUk+c9e
	 1t/HzBaAXrm3HO99eRPUW8lrYhNZ6IbvDRowIqHsPeg0gRYkp9m7gpWz0ugh6r26uCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eGVDdLqjAm5Xg8rVcKTBY8Fxv7df7cjD4cVzeObTCAI=;
	b=NM0Xw4uOHEq4TtmM0/EROGpfQYxbrzTcppnhJG6XoAjEF/Aj73kCJvOmjbC7EnAG0H+3
	 TsycmCqC2RKYXShl7S+IAvhgJm4j6POpWJlOWiO8vUr7UjzHWcwiXfAfeaA4bmXM00uJ3
	 kJIgT3fvGoU9iSBKSaafGLHlILTzowuxYyY4R1j2a85RYdkPlXvbVjjPQnW+CrrmamogP
	 jdEy/ZrtNuX6wgimpX1e5g0NSs3oxEqiPH5DCwPI3mfQWYvS1iXTFXBey9a0nWDC86ppM
	 QoNgQB1E5UXwkeTo1MN7U6d/Fc+NlouXLScmSxMFQhkljaL9xzTdp6AkBcWGaMlBrXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456816;
	bh=eGVDdLqjAm5Xg8rVcKTBY8Fxv7df7cjD4cVzeObTCAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QBu/ywUiyNVFnudAvEG+3BUJkYl/quygGsNz1vNUXYJwkDPKs5boHNNtZC4FfGJ3f
	 dsvSj3RZ0RPAuaSFtw3Nbjwxdnm1qMszg2NgxjfRPQnPZ2udmqr/OSOFyVpvdzR54o
	 QQOzhE56SvQfrYlDXvt2tIE194A9sb7chNvE8YNX/wMVPSC4L2AmZTrbiQHrJdVBHP
	 9EmX3pOun4IDp8h7YFBrNvW2lX6pgyV56pyDa9zajyNqpqZV8o8tW0UJdg2p3BgKa1
	 bRwXyJmiJhI3vS9tjlXhMCuDsieVbP6HZD5oSFYGBtnF7K90Lvj9+vtet7/gEuH3mg
	 mSWHKCInGGzRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1295780DE2;
	Mon, 23 Nov 2026 18:00:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3091759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4B8A605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fE07JrmckQ3P for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDEE460661
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RDJ0NzYg
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDEE460661
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:10 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so33826355e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456808; x=1796061608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eGVDdLqjAm5Xg8rVcKTBY8Fxv7df7cjD4cVzeObTCAI=;
 b=RDJ0NzYgEYe50ItklmW+cBgeepDMDU9CaGE8TjQLe4W4hqBZs5x3hyKt/4EsIulIrw
 FRl9UbvZUSlPZqawAklsjkEyymw9JcJXDlFdF33rscFvJlgM67put2Nd0eV/yPgXI1Xe
 LJbYOL7OUf6Qxqa9A1BSxydKsoDYE4vcHSqABBIhIfH6orjrrA5Jv3LJgcJblaLkA6AK
 pwfxIS5knBTVOqC9TWX2CQODByOo3X+W2+ZZ8f8PbxR4uKGhCCYl3AnWebC7ED/q59pS
 d4g+Bpqn6Z4T3f5P9NzabuvMGpaQPegu7ouVLBqerUUW6Y0IETdLSOe6zgYiK+POn20z
 9Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456808; x=1796061608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGVDdLqjAm5Xg8rVcKTBY8Fxv7df7cjD4cVzeObTCAI=;
 b=TPinEhZzTNFe2SUbbPMM5MG7bajwHsCpKv04x0mkpGMbBtmgiteeIAv+cGKA3koTR6
 46Hfnof8Opy80RdddIaNqM+n4EXc4bNjwf2DE2Ltrip5iR3Okdk1HvlQFN+CZe76sBA5
 /Cw1q/n+b/D/FIE1b6/9ErOdUh6X12t/zJrY8UPxovVncgJSfj5lcBnWUovAx/P3CtO4
 6fWBav+DWRrtgvlrYy4uPJaK629zobHmXOGj50pYbw2WWw0meJ6RJPBLx0pqr/p2rt1T
 MYqqmk+8YDt8GOS2/kZhVylG3m4ppdSAZzNlINlRbnZV9XZDKp5D3TPwbcIwyAfRwAUB
 ZLxA==
X-Gm-Message-State: APuU4Z9Cd2XiVlYkorQpgPJgJ4alecs1jpdTUgmF4ao9Z1StCgkeOxP3
 +kqACV65tjNvbw8ycXspZWk1cwJlZx5k8E5WcwwGgfLDk9JqiZJts/q2
X-Gm-Gg: AZFdTZcw6VkK0Yx0tnOpIzrQOIL6NDpU7JIBslTt3fTwSh0uhaf0aLFKUFKyHlj45f1
 8uFuCMA+FS6Y+11sxuU3CJX1AsszAPZCwtsY3YPIqAQ+gGpMYfZZJKGv5xWISlUILcp9vKq1gbB
 K91wtEramtMUOsKTaAqO4Ox8sqiLIfRalXqwc5cD95FyoeavM1pqvu0CWnQBSikMFjnyFsw2Xy0
 PUs14+v3bXhHkb+78cuqrbCPbwMV7Wqb1yAZrc0F2nawSRcAqVoy1bwMYPt8XcaWvqVdR46xdv7
 5fIrBXXqa6XvZ+De7ItWHV/naLAAqCL/vQWc+5zKs0tLDV/F0q1QST1DhlGW4RGfUrQhghSjzT7
 g/wCS4FQUDqOg80FExWnrt4QZ1EkzmKxFFVEM/hD/G4pb1EpYmMxR4RIphlS09ucf8hevyUqXnp
 zDXSpiEpaR6DSMcOdA9acT2uEMaJ0sqn/p6e810usDyfMGFkIOn8ztWulGwvdL3tHTf+kbKkAeG
 iHty8pJifzMOtVqCoXVaeLRHiwMaEO3dgCrcdLghKFBJ0sNWyT6gENaogfRtt16c87kzwgE/LMp
 /zKVKoYc9vuQmtOIZrlYQP02EuX8cMk6m/FFIfM=
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4bb88804d4dmr272417815e9.7.1795456808459; 
 Mon, 23 Nov 2026 10:00:08 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:08 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 19:00:05 +0100
Subject: [PATCH v2 2/5] arm: rockchip: Avoid TPL_LDSCRIPT configuration
 when unneeded
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-config-v2-2-be23de2a81f5@gmail.com>
References: <20261123-config-v2-0-be23de2a81f5@gmail.com>
In-Reply-To: <20261123-config-v2-0-be23de2a81f5@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When CONFIG_TPL is not selected, there is no need to define a TPL linker
script file through TPL_LDSCRIPT configuration option's value. Skipping
it avoids an unnecessary line in the .config, and therefore in the
qconfig database, without any effect on the built artifacts.

Affected board configurations are the ones related to RK3328 and RK3399
SoCs that do not include TPL. All the board configurations related to
the PX30 SoC include TPL; nevertheless, align the PX30 Kconfig with
this fix too.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- reword commit message
---
 arch/arm/mach-rockchip/px30/Kconfig   | 2 +-
 arch/arm/mach-rockchip/rk3328/Kconfig | 2 +-
 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index 0088d436d36..23f1667f07a 100644
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

