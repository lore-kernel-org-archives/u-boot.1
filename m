Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2528C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E1482F7F;
	Mon,  7 Apr 2025 19:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NSs6cEiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8113A82F6D; Mon,  7 Apr 2025 19:00:00 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C529682F14
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 18:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so1057721966b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045197; x=1744649997; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1mpVCeVHRvZXNGAVacYsBt6SSKaMGB4+AUgqfPNSP/w=;
 b=NSs6cEiGRSw+AuQqSGJ0fHa7/EIpg4t1eRgurrTDPxqsXX6DO0NYnoYlF41gK1ECwx
 tiSiBN3MeIEgiuWExVbuCdvDNRAIDlUzhqUdd8OTej2AZiPvOhoZQiBYFOofQnE6drWQ
 KP7lo9fapueKXSuPusYvxyaa8eZ33gWdvV26uNmsBz2T4Cfjvyb8KvLv7hmwb3vVO6gd
 80KJOMNGA9x5+XELBEHB3qz/UHwKZgpMA1tuunHmH7VofgwD4A9ISJRtfq7UM2Y1c6HG
 uYB8FWGDMehgExbXVVcWN8wzpuz2He7V8Ge9cF7PDGlKdZ4sfu3jju0JpmoMMJeqWeBP
 3Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045197; x=1744649997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mpVCeVHRvZXNGAVacYsBt6SSKaMGB4+AUgqfPNSP/w=;
 b=PiTuOj6RMVOas72EIc8PBT5IHuaYvvt3xiIVjrrdWepAQbD8iz6K6SXNaf0yUEQ5SN
 25lHPlRJe0XsZdu582ACY2rilAPelIO+QnHZQrXLlR5LbkGFfhrA6ijruvkNVM3WgOJy
 oOyStdt4uQpnYqz82x/JgASr58JcLZLAvj9w9uvJx0lRzr7yawFwTurpV4geBONlHW1V
 QUFiJx0p+tfbRs+zv6xYdZlDkhfZmE5onu/5zskGe6bpLYFRDwTD+/z7CdKi9YHkv/Qv
 xPtme5toA4Z+BSWl2ROznizi76sfth2pkt5vmn0ymWmV2CHJkC2S7mn07SMheV+dz1oH
 gqSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbkkpnZMBQvxNDbZDoYecRm9htTON374ylB53waZvEljM8kbbfwjCAxP//x0kGRHYipHZArwk=@lists.denx.de
X-Gm-Message-State: AOJu0YyjqbnZ5D2p/GjNSvxOszAdIbdZ8BGdA4tWf9J0lwGrNS8CIkaW
 rv9jQmwsXcWHa4jd/KmXySjV52bBEm/3NUl/wUWv3ij4+IsC1A+neO00IlNe74Q=
X-Gm-Gg: ASbGncslvIFay3M8EreoQr3KBS4GkcvYMK3uADtqdhAohW0j8QsBo+B+tpi45D5TL9e
 qEnb+9FpusuNvZisWQ3UIwKnuLjtoMd9lRh1F6NpgV/4i3Tgiz1kTN1BfBx0exDJOzNt5iI6glf
 eFqkyVw1Z/RE+wip1KUz01/rR7joomGCsfcGLzpTduQ8eYSIZWaqbfo+HBSpjhIWeR19Ra6XI4Q
 Hj3zSNkDAhwMvQ0a+exZ3bbAft5GQTcU/D4PMFfArw2t/Hpk9sGmB0U21qtml7FJQxLSm6FPD60
 A7EREX5+OWOcA5Umr00sFThh3e1c/kbOeLVKEVAU3Vj+QiyEqWpKRWjqmw==
X-Google-Smtp-Source: AGHT+IFy2ES4kSudJ6+IS1+XNoseKiPK+TfZPFuUgq74bbAqubIV1Jv6b3Il9rIxRFI/JzLlMWtGGA==
X-Received: by 2002:a17:907:9690:b0:ac6:b80b:2331 with SMTP id
 a640c23a62f3a-ac81a56552dmr22424866b.4.1744045197117; 
 Mon, 07 Apr 2025 09:59:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:56 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:23 +0200
Subject: [PATCH 02/13] board: dragonboard410c: Fix RAM size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-2-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

DB410c has exactly 1 GiB of RAM. Some of it is reserved, but this is
described separately in the DT.

This was fixed before in commit 1d667227ea51 ("board: dragonboard410c: Fix
PHYS_SDRAM_1_SIZE"), but was reintroduced when DB410c was converted to use
the upstream device tree.

Note that there are variants of apq8016-sbc with 2 GiB RAM (e.g. the
Geniatech DB4). They need the WIP SMEM memory map parsing [1] to use the
full amount of RAM.

[1]: https://lore.kernel.org/u-boot/20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org/T/

Fixes: ed8fbd2889fc ("dts: msm8916: replace with upstream DTS")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm/dts/apq8016-sbc-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
index 585d54d29623823145e6b43eda89c05f31fc4403..c8a46ed14483f6939e7a666b2b279c803476ac63 100644
--- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
+++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
@@ -6,7 +6,7 @@
 / {
 	/* When running as a first-stage bootloader this isn't filled in automatically */
 	memory@80000000 {
-		reg = <0 0x80000000 0 0x3da00000>;
+		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
 

-- 
2.47.2

