Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144F7E7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A0786D5E;
	Tue, 26 Sep 2023 08:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="urqT0lUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6C186CBC; Tue, 26 Sep 2023 08:58:41 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7F586C00
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6926d5ad926so1330558b3a.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711518; x=1696316318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhuiLnSkd0r2pmrfb876f/HtkofBDp54nLWt1Hr6m10=;
 b=urqT0lUGOG36960yyVhvdxL96fYVgvddYJxY6pgTpiklJYk6ErQoSPrApBxNV0peBA
 +F5nhURetB+0BPkLEGB01paQi+e/ST/0ONU74+oZThO3LhyaIO3ZrFiHyLjVYaNF5TJ/
 A82QAK1RyfKhtasBCp9BaVQsxGSmJbJZc1rXaTcmmybLFi2BQ6KL4afKNmakTJHrdeoz
 Eb8GWXmMLSLmC9rSUlzwTVdbxzJIOci7SeLCq6PYcF6ICqd3Hh3FWuuW3pWetQGlphPO
 N7HPQoQGpPr6HntNO11HnoQFiPcQc0yhsqH4Nu3vKoIF0oDo4nDrtGJOA2OnNdsyiKXG
 k9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711518; x=1696316318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhuiLnSkd0r2pmrfb876f/HtkofBDp54nLWt1Hr6m10=;
 b=o9jK0Ribf6WIOc4l6v+jt9peIwnZGNx+yEu8eDfM5+rXmSRtR3qri7oRmYxAP5mE8t
 4gxLzd1vHR08xnIEXo8WZBGdcRFojzUxX4Uf9PG3sCOlvUZxGBc4VSGTqHcUjNv1g7ur
 rMq/TmH0jhk1O+UEEjQ0r4OGG/2kyppqnLsKvnnT5O7dkN9NxURSrY5vNjB8iEqrDCCE
 m1Fnjj84XgzXEWurgkLApc49gmhejDQYulMBQKP1vc30VGBu2NR69qtFx/8xmUxcck/m
 ngPCTg2ndxbAMaXr9h51mQTUb0+I9NfDhmUd8/Sn9ZEHthicgdCAv5hrvzesWWkuzT4c
 QGpQ==
X-Gm-Message-State: AOJu0YzazxwRLMXThPbF9L7q/b4LzbnR0JJeshDqQSTIlwkNs9CicXmz
 l3BfeC+oadQSbIdUtXYV7qljhg==
X-Google-Smtp-Source: AGHT+IE9+JbNIxuhjnJBNGtz5BSyvYYKIY2lpCJ7lJfKYYrQMxia7r6PBnYnQRhkrvksbWerLakshg==
X-Received: by 2002:a05:6a00:134e:b0:690:d0d4:6fb0 with SMTP id
 k14-20020a056a00134e00b00690d0d46fb0mr10680682pfu.3.1695711517794; 
 Mon, 25 Sep 2023 23:58:37 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:37 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 12/16] sandbox: remove SCMI base node definition from
 test.dts
Date: Tue, 26 Sep 2023 15:57:46 +0900
Message-Id: <20230926065750.734440-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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
index 5e2bf8623dff..36de6a37cf6d 100644
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

