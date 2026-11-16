Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF481606A880
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZzAaquC/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yX5aW8UE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C11BF406B9;
	Mon, 16 Nov 2026 18:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2sYWk1Ncs3q; Mon, 16 Nov 2026 18:39:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 48C744078E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854388;
	b=PXF1rRhFXcdnrWC4hvdmFrnG8GjyYPH1EqHpo8/kTXyKQWDXf+40r7uiMbKv1Vt8pNWE
	 xNlRVvF9iJHFe9iXdZejBScHc7Ku8piYkeFqI32EcHRoWT++D8QL2tFQ/M5cuoG1WvMuo
	 4MV+ze26ABfT5zEWrFoXekHG92MfcESjkxTD/GpjdZ47NLyGURpi06Y6ayy/9Z6J1NNz/
	 7uSM+z5kqM2XYpxCaUAHdiqt7FSWNllei5H6Su0oxkmrBajNBHBiy9AmeZV0mQGYc8Jkj
	 +OJNp6+Of/TXE6ZmcFo2BalUq451r+43fUACJhXiphn6K28/6I2vcu05sVhJnq7YyoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hBr/K3oCiVXCty13k1GkZC9YXmG9soMTNxmEYQmcN0I=;
	b=EzQ3agoVSjl9QdaKMNvk7Z/Be/bixQYbnZJi9bvEgEx0WNEUVeb6ckbMv+PbRwNaQl2R
	 TYIT3Y0JK07xENMohS8kRLRPnFTIhE5gq4eDVKHtC8F0g31eZynJn1PAslC+FjpHPTsx+
	 muWiUsATfYyqmmNBve0jy4NcfD6cBzZFWi97XTR8ajvz3I4WjoyCdKXuu1QyqKGAvyuMJ
	 p+NlD2a5IUudv2a+O3FXLS2WX5ldG+UePgPFxPMpMCmxeLf2KWnqf9FKZEOWNmNXejDE7
	 hHA1lQWW4o2sXPAoO36q7xGfSYp6KaW+zQxapuvTXZQlSh2yoG+BBhtY/n13K8Lmppw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854388;
	bh=hBr/K3oCiVXCty13k1GkZC9YXmG9soMTNxmEYQmcN0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzAaquC/1+4dpx8YRehArH6tGSIMJnePzzT7TvMJYPe60bOeFFafUO44Q6uFynH5P
	 o/9iK0ftfjFAC+btVYCC/mUD9dE0c63Bmm09BxqqOyHkslmd6CpI5aVcQ22aQoZNdj
	 XzSxQD9bYnBfOitqqLb8QzARnip3SVvR6rfwwz3ZO9T1T1zzNr/UEbGNUgYWX4LjGy
	 Gx2zRtOmHY3Z3o+tt3LcSctK5m8Eh3eKegVk0Zr3ZKkj2InRLwYOIRLFUijviacPvL
	 BSvvf+cbvDS96yI+kNCruWsyz1veCwxSraaH8+KTWyLiMvRz6w/+jIRKFpo2apMLOP
	 UkQdBQeL8K1cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C744078E;
	Mon, 16 Nov 2026 18:39:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EAD813C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6086E80C50
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvJPLIAetBRF for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:39:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 712C080BCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yX5aW8UE
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 712C080BCC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:39:42 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso1190905e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794854381; x=1795459181;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hBr/K3oCiVXCty13k1GkZC9YXmG9soMTNxmEYQmcN0I=;
 b=yX5aW8UEcdUicKoOwNNFys1qX1vc9bLKLA94GsZQnsqUHUKAmOChz46UZJG6jdKTc8
 s3s6Y2+vnnUlwFq1RdF9IXGQpaZed+JIUusE08Z40caE/jsORtyxUVvM91cApBycrBaN
 F9g9wuludm5CuSi+vPdjBYwJ460aXNfV2Ztw4225GLIOjWGZgUYonlWMtuEXtMH09p5c
 QRjTVKUiXsoDHO9j6sskfPuqE3quHSDxFZBpfLyUb3qfi4Fk8XrViAvLJPPqcA5nLggZ
 8+ujRGvuF5MaJ5S0ubcC3f/EoHh8Yebam3rsdaycAFHAPm79vkd6C9BiiQn1GG22iQH1
 +2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854381; x=1795459181;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hBr/K3oCiVXCty13k1GkZC9YXmG9soMTNxmEYQmcN0I=;
 b=MBp/n3swe4KPh13kFuubtZAfHFzCTQjHuDZygcoZYErzlt5k3ZkAjLwmfBeWIj9LWv
 /pUteDxNa4uUsuaEx2lOrMkauvgzAlKZj5noRaXyC+YeXm3zirrKQybm2aH1z/IS1R30
 S3NdHzQH2K4DIBuIuKaDZTyKr/gkf0MydRPqhlmIFQO9bciChyMWh5e3tXads0+TfPdq
 0QEfswvbsA4F6hqGOPvb32DUVhg0hYPh1BVgOBgTD61fAJGNKn/m5qbXtR7eUEwgW6gi
 NJZNTn45jV46pEya6Gmp7QGQ23pYUQgbEKXqXOFNVsTzeVxBA/Ec4YmJf/7+CtFhyKA+
 /INg==
X-Gm-Message-State: APuU4Z8PUB3f7TgedfjorJ2YuQ3apmDaAuPr5IhxDwM8XlTAtfSZ2Rwr
 EZ6oEZDlS7LzCCY8IYdSmnNqqmlclKsJsVxaiBKRx8FxrdpTFzYX1MaP
X-Gm-Gg: AYBFou238o33wdCsoXBr6W/ToXXiiyQKsKEJH1mLXNTLXlJ0fmeBVD0PI8Fi37O1dnU
 QT+VAGTKkr0xuNolkGDBP1z0yg8/SUqRazN6Uk7Aj5kb1WKN09oiochI4mPBPIQ0e4+mDtVIbF+
 PD7nVYGUOBpdZtbIVzxFQjmsO1Efu/Khbf+pmHxa4lF0cscy3PDDC94hPX/HvuwaP1FbaIuFOk7
 EPM9898uD4DM/Wl9i4yHJQ3PDvTW6SaCtt+XIy2h/lma4MgbblrL803SUp+xFqnr4FpJFnLxtqS
 9fm8DiPP1/zaRV1IgMpqyjnh7qOGRCkJKoLm6rKOJFDewTLP/ole/FCBXvVn/LvfvOweer9J80b
 BwI2GSKWxTUa/dnXOfEulfO/XSpT2rC/OS1s18y2c2jlj7ryKK70Z6rIYFhUF89zPxRRNTORmEs
 GLO3YKVq+SndFPDxkD2s8259S175TwbtqXFptyJ+x4pHKkDkGhUk4cV8QyFzx+7lkuHNulb7uKR
 2F0rbnCCGlKAVDSBJViv9dfsjfTXDb+QQTgq4Vo/U5obduzByAhl4CwtBAg7FSuqHzBxg2ScQ8z
 git/QCclBSr74zd8sKdQoQf+FXP58gU0Rpl9XXAj
X-Received: by 2002:a05:600c:747:b0:4bb:60b3:7ea9 with SMTP id
 5b1f17b1804b1-4bb78334051mr7063125e9.0.1794854380756; 
 Mon, 16 Nov 2026 10:39:40 -0800 (PST)
Received: from [127.0.1.1] ([151.71.173.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm23947618f8f.49.2026.11.16.10.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:39:40 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 16 Nov 2026 19:39:35 +0100
Subject: [PATCH v3 2/3] ram: rockchip: add DDR3 sdram type config option
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ddr-multi-v3-2-fe9fb30a3169@gmail.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
In-Reply-To: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add new RAM_ROCKCHIP_DDR3 sdram type configuration option and drop the
PX30 and RV1126 sdram drivers' fallback behaviour, which consists of
using DDR3 sdram parameters when no RAM_ROCKCHIP_XXX config option is
selected. Instead, the drivers code now raises a compile-time error if
none is selected. The default value of RAM_ROCKCHIP_DDR3 is true if all
other RAM_ROCKCHIP_XXX options are false: this preserves the overall
default behaviour avoiding impacts on defconfigs.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig        | 8 ++++++++
 drivers/ram/rockchip/sdram_px30.c   | 4 +++-
 drivers/ram/rockchip/sdram_rv1126.c | 4 +++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 74422947452..f51ae6a4542 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,6 +24,14 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config RAM_ROCKCHIP_DDR3
+	bool "DDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
+	default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
+		!RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
+	help
+	  Enable DDR3 sdram support on Rockchip SoCs.
+
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
 	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 37e62120504..bdb9cc9031d 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -130,8 +130,10 @@ struct px30_sdram_params sdram_configs[] = {
 #include	"sdram-px30-lpddr2-detect-333.inc"
 #elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
 #include	"sdram-px30-lpddr3-detect-333.inc"
-#else
+#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
 #include	"sdram-px30-ddr3-detect-333.inc"
+#else
+#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
 #endif
 };
 
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index b371f597d23..3d7cd076a51 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -83,7 +83,7 @@ struct rv1126_sdram_params sdram_configs[] = {
 # include	"sdram-rv1126-ddr4-detect-784.inc"
 # include	"sdram-rv1126-ddr4-detect-924.inc"
 # include	"sdram-rv1126-ddr4-detect-1056.inc"
-#else
+#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
 # include	"sdram-rv1126-ddr3-detect-328.inc"
 # include	"sdram-rv1126-ddr3-detect-396.inc"
 # include	"sdram-rv1126-ddr3-detect-528.inc"
@@ -91,6 +91,8 @@ struct rv1126_sdram_params sdram_configs[] = {
 # include	"sdram-rv1126-ddr3-detect-784.inc"
 # include	"sdram-rv1126-ddr3-detect-924.inc"
 # include	"sdram-rv1126-ddr3-detect-1056.inc"
+#else
+#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
 #endif
 };
 

-- 
2.34.1

