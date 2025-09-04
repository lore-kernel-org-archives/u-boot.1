Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A30CA1002
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 00:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E33583734;
	Fri,  5 Sep 2025 02:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2HIx7Sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D31837F2; Thu,  4 Sep 2025 22:27:13 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AF0836A4
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 22:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benjamin.doron00@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4b5e35453acso7540661cf.2
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757017629; x=1757622429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=65Di6B08i7KXjMJZE+CJ65TO2UwYFQujfH+Gfjs8dvQ=;
 b=V2HIx7Sy8iWdprNXVRhngqSEqIYPx/xNXiaetJjsE69vNZ/jQR4UPnHYvkOYf6um5O
 utKYBtmgqTIf3TbCKkUFpGAWGIzaX9McOBC2ZP+3voxPE4mMgXZHspA4U2z6qRtyukcZ
 VvSAzvUBRa7i93JYtxl2g4MaDLd4mU5YlxLHhi6vbBMPXk/DaOmrXYXyh1RWWwG0QT0y
 8kIoSPTwmuX9tBTGwCsK9lQvoXi5WjJVX8wYVtiUXiA7X2G2ML2mBm5gkY418T6qbylb
 A0g09Kmb7Z/kHaBqyXqlx2KzO3O220K9M2wa7pQ8fvW6g0zDxhyznTlkZujK0l8NXUA9
 VC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757017629; x=1757622429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65Di6B08i7KXjMJZE+CJ65TO2UwYFQujfH+Gfjs8dvQ=;
 b=RMlI9xMmTLNAkY9Zjgaqy7pw+NGRATEWdwywhI7UlzIKRi82hptFyK+LNFOzLx/Eo0
 aSheeu74osTFFA2bnvhbInAtSB8O6rR9X+NQnj2/8end0MWN4s5LypCR5L/CA2GGfVLi
 m44CHmogbxxOXAIlGKnKH58Nb5mnzSsJBpj0splrdBltuCt1oOw/xFdj8GdUKPwp/LVD
 bIFkvzem7uvx514/mbbR41/n0QdqZfW+v4llBHOM+e7xEwUFpu6S+XbGLzuH0KagICgD
 qZLhkFO0K4QfDm5/Kdt7vIf7Q/PYeUgV8XxCPFPwj0GM6iPLokTJ3Rl9nqZ22fiLSdZB
 dpDg==
X-Gm-Message-State: AOJu0Yz77YviM6Qk/avONlpWWTvwc0TY9sL8jTkMdrmyUKSjyU5BFWa1
 seTHeT4DPyr5lc15qqxOhuiSSD0fkuDClRqlX3aql68Gg5mGK1GbAMNkTKKN2A==
X-Gm-Gg: ASbGnct7DO1jh5jm+VzHKpPvlm3uvZjgE14Ln8qZgIYBr6jfJmTluuCOIPjkk26ZI+V
 UdjRj3sHEwiUoqWu28cjpAYuU279U8B9oFGRcoiikBy6PTq7NxGNkEot/3HYmtaKWXkd5oAanCm
 OMfhTNPpY5CG5VnYluHsxeXtSzZ90UHfIt5btk2HeBy0UsxxW6eZqSzhaDruTpX42YLkWcQo489
 OdRW84Fp+FWwbhnK9+0JZBRflWDsyqsvQcvnj7XtRBo2tianbUCCNM09Zdw/yFNIKwt52mrbUPB
 1rjpKwlgB6C5dR9HEvphmn7SkX5LSJwt06tSKjEqDCD//fkIW4maHzUZLXFJPEHsUd4cib36Bq7
 cLlJS3XFb/S8xOzJSey8xp4DGrjg1yre8T7BzkojedlrR2c6aq4C+CTlH0b0wSRVtPMn/wY8rvJ
 i32RhkOuw7oBE2YJpKiSI3aIwkofpEqpmRxoQ=
X-Google-Smtp-Source: AGHT+IFQam9hWMyzuCW/jQcYH+Ivib2b6oIC3VQR/qLiPiDZvTvkHnjpFedUizHQoOn9yK8x4gUEoQ==
X-Received: by 2002:a05:622a:1a94:b0:4b5:e871:23ff with SMTP id
 d75a77b69052e-4b5e8712e52mr8729871cf.62.1757017629372; 
 Thu, 04 Sep 2025 13:27:09 -0700 (PDT)
Received: from itsturtles.sec.9e.network
 (pool-173-33-154-235.cpe.net.cable.rogers.com. [173.33.154.235])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f635cbesm34722511cf.5.2025.09.04.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 13:27:09 -0700 (PDT)
From: Benjamin Doron <benjamin.doron00@gmail.com>
To: u-boot@lists.denx.de
Cc: Benjamin Doron <benjamin.doron@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] configs/coreboot_defconfig: Set X86_LOAD_FROM_32_BIT to use
 own GDT
Date: Thu,  4 Sep 2025 16:26:37 -0400
Message-ID: <20250904202649.272566-1-benjamin.doron00@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Sep 2025 02:56:15 +0200
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

From: Benjamin Doron <benjamin.doron@9elements.com>

It appears that coreboot's GDT has changed recently, as the latest
U-Boot builds throw general protection faults early in the entrypoint
(arch/x86/cpu/start.S) while attempting to setup the segments.

When this config symbol is unset, U-Boot relies on the GDT loaded by
start16.s. However, this is never compiled into coreboot builds, so instead,
it uses whichever GDT was loaded by coreboot. This is subject to change.

Selecting this config symbol makes the 32-bit entrypoint code
load a GDT that matches U-Boot's expectations, fixing this issue.

Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Benjamin Doron <benjamin.doron@9elements.com>
---
 configs/coreboot_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index dfb97a3d302c..fbf6a4fea088 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -1,4 +1,5 @@
 CONFIG_X86=y
+CONFIG_X86_LOAD_FROM_32_BIT=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_NR_DRAM_BANKS=8
-- 
2.51.0

