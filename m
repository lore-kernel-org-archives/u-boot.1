Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437F8C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4139586A23;
	Mon,  4 Sep 2023 16:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilmDzYtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C1C8693D; Mon,  4 Sep 2023 16:42:07 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536AC869DF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso66969839f.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838523; x=1694443323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LumpcXMFKia4/R3jfpoaG2QirIcauF1cDeA+t94K0Y=;
 b=ilmDzYtvNqppObQ3kvimwi9V7HQBRTPuPIggHjk/QvVKUIYDF1rZpnv0aruedjbVVY
 q/zxNe+0EUCK6TsxXWcee9Edt1SkiFLxedMdsPQWIBNCPG9sFLXrS0jGJS47StgpF/eA
 iQulpmX1mpMbnkoHO92P+vXz5HC1z1QPmZOHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838523; x=1694443323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LumpcXMFKia4/R3jfpoaG2QirIcauF1cDeA+t94K0Y=;
 b=SzQ3pk5AywUzsedLil+gGk4YLTOjQGSBdNKHqZU3azHAO6Me9/ixW7ricidoKuIG0l
 EpWxnoOlsb2HQiu4HFAvIglmwJub0c7Mrtsl/VrTn0SgrqKzhhsDtXY9WBz1C59+nNaG
 YkN86kK0bnwkEYmpj7FY0ydUtj06vNBOCdTvdSMtNo7fmLsROg3MO8AQkr5oBxiq5z+D
 799+7LQnVxqdrovIvJ1DmYrEVgAwx8AFeld3dtVsyc+Wy4zaqQD6TEtlCm0cysyrpZRD
 m7APyqgJLf2ZnkawliCWIqtJtksX0PZgqoCQWCe0Yq8LtBecSpM8ABFmhBH/HvLMuVTX
 cAEw==
X-Gm-Message-State: AOJu0YzSAcV2pqC8YNkR1ClDkMvLEr21yfmpuAFAlg7eRSi/3k9zojvG
 Ksu1lk7xb0+OStadUu/R6O0jUJ4gX/nW8sxFnvw=
X-Google-Smtp-Source: AGHT+IFuJjT65TCPTK60hIDsqVZEbJWcpNg9gQ390pGiXbZCXJCPS4RPE8JEVYXGpE1Tm3EYqwUNkQ==
X-Received: by 2002:a05:6e02:13f0:b0:32c:9c5e:900c with SMTP id
 w16-20020a056e0213f000b0032c9c5e900cmr9874788ilj.8.1693838522983; 
 Mon, 04 Sep 2023 07:42:02 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:42:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/20] boot: Drop CMD_MTDPARTS condition for
 FDT_FIXUP_PARTITIONS
Date: Mon,  4 Sep 2023 08:41:22 -0600
Message-ID: <20230904144131.2699824-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

Changes in v3:
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS

 boot/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a7dcd6b0ae07..e8bc7dfddc77 100644
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

