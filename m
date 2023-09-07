Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910A2EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA8486A6B;
	Thu,  7 Sep 2023 18:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MScR7HhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C431C86AA3; Thu,  7 Sep 2023 18:00:02 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091C186A93
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso48842639f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102396; x=1694707196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXZhwLJ5ywef7l28qt7irOZE2+DY8gJY7dZBYDvNe88=;
 b=MScR7HhPlVeYThLQvBmbUgFAduoDlrlyD6zVlKyS9WOnFVqImg/12HpG9RDW2k2dRq
 M6BQ3mhRa0z9h6KLHD6x696cP/yKxkivIFiHJmBPPPrgYKFx5n8PVdPA/BrB/L2WYwvQ
 cW3enSC/+Zod8K27IfRScljLXWLuKArTaZ/hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102396; x=1694707196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXZhwLJ5ywef7l28qt7irOZE2+DY8gJY7dZBYDvNe88=;
 b=Hxmns+SU6TP+2Oc/ycbAcdeaY+tUjuazW6TEk2bMBBi10u0M2nT0K1ZFlOYbRNjIpB
 eFwjvcFEN3ck4h8/v8BQ/k/zJtQ/CGg/ykWMoPg08/FUZuNxvu3o1YOTStdHV0VeYkxq
 UFmkXnTyFSBFoZI7QrlQI7qx2eTJghfB4NUtxMjbZABhsdae5NWU+QmfgP306PriG22X
 sfecuNej/ixb5OMbOBRO/Ysl/cxHivW84w4NyHyEjCgQIGqFwHNRH0CY9gc5LJ0pfJB0
 BMiT/jckSx2p2BCiaF99gzH1VPD+/9p2j0OTLMpayKI3zE2xoirTk+jxAelVR/bpYu5o
 u9nA==
X-Gm-Message-State: AOJu0YxDC8dU7C7+tDW7rxTQuInlHKHELWbsQvcxTDWHo3pEuPHH1HmI
 4taFTLmulq9lqBrhw05f+ttlspRLkteBvJLQ3ss=
X-Google-Smtp-Source: AGHT+IF/7VaQrcTTS1cfhHdJQ4nyhNZ1qjRfwbMX1W96dDdDLf7QBKw2glKLIDWV2+dqPZYCfeFbvQ==
X-Received: by 2002:a05:6e02:1068:b0:345:c72d:33a5 with SMTP id
 q8-20020a056e02106800b00345c72d33a5mr45123ilj.19.1694102396695; 
 Thu, 07 Sep 2023 08:59:56 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 21/22] boot: Drop CMD_MTDPARTS condition for
 FDT_FIXUP_PARTITIONS
Date: Thu,  7 Sep 2023 09:59:26 -0600
Message-ID: <20230907155933.48511-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

This is not needed, so drop it. Also use a capital 'O' for the option,
while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS

 boot/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a1592a74e624..235c5a7a9933 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1476,8 +1476,7 @@ config OF_STDOUT_VIA_ALIAS
 	  exist / should not be used.
 
 config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on CMD_MTDPARTS
+	bool "Overwrite MTD partitions in DTS through defined in 'mtdparts'"
 	help
 	  Allow overwriting defined partitions in the device tree blob
 	  using partition info defined in the 'mtdparts' environment
-- 
2.42.0.283.g2d96d420d3-goog

