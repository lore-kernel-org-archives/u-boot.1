Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B5DC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0218480A23;
	Sun,  9 Feb 2025 22:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fSGF5fFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D0E809D4; Sun,  9 Feb 2025 22:15:46 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF74880A23
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so12364185ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135743; x=1739740543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc8XWWZV5DVrSq/A1YR5fRsoPm4b6w766BrxNsntLmE=;
 b=fSGF5fFe3iecLeSt85TnMmfW4UVdylV0EZT+beU9+n5sk4gPy8fsBEGph1z9x3WJQE
 SmdkLbK2KOMBFX12gUsw+MQ4W2jvq7LBoUEStrzPnG2Iwuu9eR8q/dOca0ejJZndS8xT
 oHf+dQ2jZ1NSSStyvXoOR/XCaqEAnRpzJKom4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135743; x=1739740543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rc8XWWZV5DVrSq/A1YR5fRsoPm4b6w766BrxNsntLmE=;
 b=MxbKXR8cKvWLeeRPVvcPISQxLcw6dlMoz6PGHbvL6lOanHF90NwV29gwwKvNVQ6iNg
 EW5/uMxVB/JCK5UimzugM6X3q/JEjkWtqw/5CoII3fVAR6LlVrxQLBveR54218pnky9U
 WlDuFllcC/h4F6h5dG5iMBcRttAbEjwIzhs5j/5tNrFb0PuANdZ9gyhPagKnfP4vhefq
 L3T14MxytVWxJv4f/WMTWjQYn7mBclI5RmR59g9PbW8LcENYAg9GAL0VMgQiH8VKOfgm
 962wisIdJc+FfXFOmPKvNOb1WjLrmiLstC3LErm1bFM9RWwKd9R2cKbMq763hldXw9kF
 DvvQ==
X-Gm-Message-State: AOJu0YyaCQjrXfM2vCd2Rf6XTCvzc+HQOcDVSU2R4EW63E9vLW8pOqUN
 wVGzZe7yHYLJO4Rc2XBvlWvFrtqtvmyOWK1R8/OtACJgLHxr0gGPvseA/Doe72LkDBIn77qrhN8
 =
X-Gm-Gg: ASbGncu8mBFMWHgN8p0B9RKCNt/2HsxbFW6HN03td80aeZvooXaF+tkN6uIAqeHi87u
 6oVWDzQavXz75AHG8oQThghlXThgeVkUVft6FQ1kJr10rS9oOetxy44MKNdmoJJnMUByNCzxGRx
 UAkdo2PCXKu8Oe25sjnwMV8doOXS6YAac9yp7h+21TrpF+GIz8JnvTUIVUT5z24EPS2e9es+++U
 Aj/oI53nlmstLKoHOsMH5mAUf2SgbzQCEro3O66I1PTeToYJSlP7yt9eRQdQ60gSNfhUwh3R+x7
 eCGjY5WxXA/oGRI2N7SjLECXXn9MpBP7QAjbZly0DBnB/+J2uOhr
X-Google-Smtp-Source: AGHT+IFQfU86QTN7ZQA3EBYrbznpoetT6KlQuP4hVrMYa2J/Xk9Wu2BYfjf7inQRbjV+Uc1rlHcipg==
X-Received: by 2002:a05:6e02:170e:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3d13dee46e4mr87995425ab.16.1739135742942; 
 Sun, 09 Feb 2025 13:15:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 09/35] rockchip: dts: Correct the OS for U-Boot
Date: Sun,  9 Feb 2025 14:14:30 -0700
Message-ID: <20250209211502.2299245-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The U-Boot section is currently getting an invalid OS. Use the correct
value to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v2:
- Put this patch before 'Factor out arch and compression'

 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e50..e9ed1d4b573 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -50,7 +50,7 @@
 				u-boot {
 					description = "U-Boot";
 					type = "standalone";
-					os = "U-Boot";
+					os = "u-boot";
 #ifdef CONFIG_ARM64
 					arch = "arm64";
 #else
-- 
2.43.0

