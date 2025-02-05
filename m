Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B0FC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9762480836;
	Wed,  5 Feb 2025 02:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQFBd3oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B247807D7; Wed,  5 Feb 2025 02:57:00 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939F1805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e15717a2dso3476943a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720614; x=1739325414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLny6Pbnz4Zqh7vHhlkrGxh4VLs4v8iYBeqWFUU5sII=;
 b=PQFBd3oSvD7gWn4DR+Gop7oGJtKIaxe0kSobO+j75jsQrWP79ld9lj+vDSyR8o0/Vy
 ur5equOn6XYxU0nb2z+Ors/kdXqyviYMpLS8kTTnDqEQH86FSbTVDtCCBSuTxqIOU4sn
 zXot0nJmSr6UihfJIuBW+DCxM9NZ+JwaVdQxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720614; x=1739325414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLny6Pbnz4Zqh7vHhlkrGxh4VLs4v8iYBeqWFUU5sII=;
 b=qfbjEoVk1hPPDr3drX6yCMTMHbjDMOujNcprtjt1t+XlXFnjkv2ONe8DkTvENu09Vv
 EsPsuB2mPDyQSeSHhU1mTEJQQBnEl/PqEXXjJhC2Irotj4rAbWQTX/zLYg7gW4AUlume
 AJl/Bhwwn4pjEYQ17yFjaalk2f92/O7RcFNbNzPQSNezNXNX0L7Ftsto90/aGimWnkrE
 ODTSi7+R+aQWyRsnqoNJkJTsJNry/Djhnx04/XQoVAMLy6qgfHbfMdT1UwxABLfZa9kE
 RtbyEez3AlJLdaGKyCdI9BSYX9i5OQIiPFroeZTWu6w7ov6RBjtNBvvmC21GYKXF3qze
 LQAw==
X-Gm-Message-State: AOJu0YxCekbxBlkSo7QIUX94PvTF+fl6eSWJR/oskxFyLlV40kY1L2I/
 RBr0Y5krP3b+uzF5z9RWC5lKh6Z48pg0PKLzrM3BgmykEuJyVO+3YyXfZax7cvzA0q3KjgwtW0I
 =
X-Gm-Gg: ASbGncvYeAsw+PUstyiQVT9g7VGM9zrxv3yPcIfaea/qNAmbva8yLQUW+rO4NNStTyj
 R860yVNSaTfwv6sTW7Yc7Mn2f2jIB8TEaSmtyR1qalSQsuGucKXlUV6x3+frCafAnPbMhQW5Eh8
 k6s8P7SBjDgJanL3kjYA3wSJKxHjSDeCUCEkulIUOypTXsdp54KOmMlyw01GUi8AEbpwscPQwCr
 JpSDgy9MEr8Rtqw6o/HvUb1uFkiWJFT0lKgXFKILP2+RydVDU8tynXXms8T9Dstr/WWqVIy2mSM
 ZYJLl9aml1gCObuLkMNq9j09EU1pJ3cdSMfCudEKi7vfmOYEuMAS
X-Google-Smtp-Source: AGHT+IEljdKEDoWz+0I9AEAW2LZjVgK026B6Qlzm0eanGu1hG9EPdIedJ5N0IuTUcGwCnoABDxBIuQ==
X-Received: by 2002:a05:6830:61c9:b0:724:9f31:c1ac with SMTP id
 46e09a7af769-726a41e5a8amr769508a34.14.1738720614003; 
 Tue, 04 Feb 2025 17:56:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 11/29] rockchip: dts: Correct the OS for U-Boot
Date: Tue,  4 Feb 2025 18:55:01 -0700
Message-ID: <20250205015606.2686149-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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
---

 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4cf7c49a74c..281119a53d3 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -48,7 +48,7 @@
 			u-boot {
 				description = "U-Boot";
 				type = "standalone";
-				os = "U-Boot";
+				os = "u-boot";
 				arch = ARCH;
 				compression = COMP;
 				load = <CONFIG_TEXT_BASE>;
-- 
2.43.0

