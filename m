Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12317EC8732
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 02:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E3486A45;
	Fri,  8 Sep 2023 04:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h1kzt9h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2136B86A38; Fri,  8 Sep 2023 04:52:35 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5511B8645F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 04:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57328758a72so330259eaf.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 19:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694141551; x=1694746351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhAR65M4soRG9S95MgJJZMHxp3xYHMV9h+mVgJ4WbmE=;
 b=h1kzt9h3Xp6dnxt9kCCX04xeAGvIYu5KeHjwACvrn9ZrN2eG+zEewrgVfSCS+2yQ0T
 m/j5nii52a+Gorsc2v1rbtwSMA/pz93m1Jqab74R9Bt0/zrTPVj8JArA4Io60Bv+cftf
 0ZiiOqhUkpZpHY9NgemCBqehH03+jCGZs9UueZZ9dDyXs5I2VrXRjVW8IVZ6CbS1whmf
 NZb/JKayg4SQ3e6h7Mlj43KKpIXCKytZn9o2m2jFFDLqouIdLqUP0jSaU+cd4aAuQwxx
 GESy69miNhb89FS59HXKE90zGwc1TCRSep+0IVTXAEG3FneP41UyFBdbbOWBpLHGJZ8H
 CskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694141551; x=1694746351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhAR65M4soRG9S95MgJJZMHxp3xYHMV9h+mVgJ4WbmE=;
 b=Wc6GjXKuRTGgcsK/tTbm5DthHKEVeTHhBa56uA48MRxlRKR7amdg2VUe4dKaiv2xkQ
 yiLI7moE3da0rtAVtQUyeXWERFErubxEzL5U2kKiYagoPn/OqJZFqXQsmwMfw0ORpImd
 WKeOlA9TJVJ07WD1V24KGGvyhfwOJ9DIVWZq8fYwUQeCUsTMjkj4HM1FaxSI+Y4MM05q
 RZJxMV8YOiHOivNa66dU3vVdOvTjAosZIIR+woMUP7hmgZ6rhB2B/L6IQK/RwdtNXczl
 wbyiXX3525GT8+AE+YQZLMZtM4pNJUULlsOX+zUJk844ru9Zof7Gu4QGeZz0XVQtuLA4
 kcCw==
X-Gm-Message-State: AOJu0YyifFXqjzm3ydRn8WsmA0J0kCPSU0PE0XlsASaGqxTCCcDMdTw2
 I/Br+Nclg7+fd62ggRYolZEDiw==
X-Google-Smtp-Source: AGHT+IH5qgs16hbxS7OgGlPlEhLtXiRpCp/qygHpU5z//3DIh01ZIyI7h5kGt7slbyCtWuzZR82egg==
X-Received: by 2002:a05:6808:1901:b0:3a7:5724:8bfd with SMTP id
 bf1-20020a056808190100b003a757248bfdmr1915054oib.1.1694141550916; 
 Thu, 07 Sep 2023 19:52:30 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001c0ce518e98sm417286plf.224.2023.09.07.19.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 19:52:30 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v3 07/13] sandbox: remove SCMI base node definition from
 test.dts
Date: Fri,  8 Sep 2023 11:51:32 +0900
Message-Id: <20230908025138.44405-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908025138.44405-1-takahiro.akashi@linaro.org>
References: <20230908025138.44405-1-takahiro.akashi@linaro.org>
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

SCMI base protocol is mandatory and doesn't need to be listed in a device
tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/sandbox/dts/test.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..dc0bfdfb6e4b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -693,10 +693,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			protocol@10 {
-				reg = <0x10>;
-			};
-
 			clk_scmi: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
-- 
2.34.1

