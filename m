Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76B1C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6890A40A08;
	Thu, 23 Jul 2026 13:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmQzyOXfoFWX; Thu, 23 Jul 2026 13:23:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3ACF40A1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812986;
	bh=zPbzsODObm5n3A0U0IZS4baTFGL0NmR/n25iXx5bjp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDX0whCCpk+2cftEAmrSb9uSoyl32CBVOqd84DYrFUHOuinyq9+1IGUw5XLRQ+tRI
	 4wwMQQtQspZeJNKiU8QuRbFEwhf9jApOxvvMV0VmhZQOMCepDgTRqzhm600mHcL9nz
	 JZJfAFY0otAL1vSJFgNxmHSEsihj8mRAV2kd8YEbhIZOJnhCmxTbyg89h/Dyl9HqlC
	 qTerYpGGFEmiF6i4FXDj3ZKdOiY7ZFrQUrgTpLU3gE4d0MZ7tukN1gutFg6QnMHZfJ
	 IcHcH2cYSRobGGmd6hWaIGv5jz2qanWtjnkm3/2kVlU8oqGPsO1P1sQ8vou8ZPYdmq
	 G3EkrcJqr1BOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3ACF40A1E;
	Thu, 23 Jul 2026 13:23:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2B8AEB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8C2660816
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1p7IbHIwLE7m for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:31:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=william.bright@imd-tec.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5F1746082B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F1746082B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F1746082B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F988498B; Thu, 23 Jul 2026 12:31:06 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E35803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 12:31:04 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso392241f8f.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802664; x=1785407464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zPbzsODObm5n3A0U0IZS4baTFGL0NmR/n25iXx5bjp0=;
 b=f2Jv9yLZwh9/LTub5IP2A+nB1z+l1gbMSjhezyyoHrGwywe+YMMfRO8ND7JuH72vRz
 EIDUZkMOa4OObeTkawp4fZzkI+CfMlEOzoK0E1T1NG3JZhPJK0zZ4Bz8rs2iWPZQoToE
 PGIcYZLxF/slT6hpEg7VZhNIXZx7R4xysgFsIxm89IUZRUnKBYnGojFREoggvvtOGC7W
 g4M/7JmE3SgJAHw31PzpEHXRXOScgr1JbnF1eg3SKeozfWGZthWCw6fFE+J/tsL66cYh
 Fy+ChvaBKSxDAuer2yYHCYb/+0sn9bq+0oO7apYxIHLaSGWV8j9xBMIEc1xQiKr5dnJq
 j3EQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RolFv2lF7217y29jx3zBOMMmca9DHnc3QrnbPhUlnWWUo5BQXjshsTb/bfaa6bNBPBUWCVSELM=@lists.denx.de
X-Gm-Message-State: AOJu0YxjBYWoHEDR6nDDfctx5lrr2E4Yc50VMJWbRvu8IE1c02pSI5aR
 njQRDfOCttqz/V2AcEUPpIuDdnZKfQp1Dh3Kee3+70oFoBZ3jWmucDW4z/NIukWhpEs=
X-Gm-Gg: AR+sD10T+hafdTi2blXmM64lCJvvj3F1XvbtIl8I0xgmvxgQ7Oi/No1Q9gFfmtmOha/
 d1mNAIp/5BPX36hcdjQvCNoTX8PskU7ilCLKqJuA1UaKLH0AqRaszga8GddHYTBLZvU9j1+9qb+
 jbkCT84+rYzXWuFXYK7cb89Zvkbm/v0kjf4zi/o5cb/xK1AGi/KD6nhMq3sKVIuQE6O+GBKLHe9
 yzyCWwZ7J5HIxdwIhb1fQDMADbAzj93JskAuputV6gQDa+pByUBD9IRIul9vYDrI6s/BrEI2yOV
 FwMbsiUgtjeAhTMYb46lpFDTGKBN36LjrUgvr1H2CJg6BUN+5g4NOqUtpx4Xs8OVtTA8WCGPo5i
 kejs6yn5Buvcp2wnzqFppQSWlIvuYZUvffb6DIyPS0S4xoy8gcXLdiy1HEZEf5QSSyqr9UsEjM9
 g5JL1y2mT8tOLq+pGS6WUAvEeHSR/wJhjO+Ym5mcOlznO9zhIKaU/LN1h6aJ28phijuhNvyuDBX
 iWrufcAM8O3NMbOlcABmBLGifLRpl/ITBaSjuEKryLfAfRLpp+Zqg==
X-Received: by 2002:a05:6000:611:b0:47f:73d3:bfc6 with SMTP id
 ffacd0b85a97d-47f8d761907mr3061270f8f.46.1784802663714; 
 Thu, 23 Jul 2026 03:31:03 -0700 (PDT)
Received: from [127.0.1.1] (host86-157-235-39.range86-157.btcentralplus.com.
 [86.157.235.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm13439289f8f.16.2026.07.23.03.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:31:03 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Thu, 23 Jul 2026 11:30:51 +0100
Subject: [PATCH v2 1/2] doc: board: qualcomm: document SM8550/QCS8550
 building/flashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sm8550-hdk-v2-1-78f0ce2adb3c@imd-tec.com>
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
In-Reply-To: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784802664; x=1785407464; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zPbzsODObm5n3A0U0IZS4baTFGL0NmR/n25iXx5bjp0=;
 b=QHabTSJsqmwdGTneixdfLEacObj3hRGVZCaszMl3F0xMGQFWuOrEPNeK+NldKuH0VN
 o+6Yc/DtlP+lXlHAEcZ22rpOlLBGMYeFwxC+vrNGVsQTOUSasEyHWSqMfKmkW8vA1EHu
 2eeNznfc/zSHl4C+ZLZ9P+A8qR/eM0XQJVhTsVTibZpg3Ibgsg3dTqEjHNdFWPnLs6Jz
 ZolJTeoermWPJtRA91rAGSujBk/sg7YBAXFl4yDP8VBvtn4iRa1bXt0CxScUxW0tqcxW
 8rbbOU7yJVsbP3/UgbXa+4UQtzGdNL+3HS1spnyFh+5w7mip4wbbbCDDSpzSATvj2T2B
 ECgA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256
 header.s=google header.b=QHabTSJs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=william.bright@imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="QHabTSJs"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Introducing documentation support for Qualcomm SnapDragon Gen 2 SM8550
and QualComm Dragonwing Q8 QCS8550. Documents the build and flashing
steps.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 doc/board/qualcomm/dragonwing.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index 028ec340d15..3024c50cdc5 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -4,19 +4,22 @@
 Qualcomm DragonWing
 ========================================
 
-Qualcomm DragonWing are industrial-grade boards that provides various series
-of processors such as IQ6 (QCS615), IQ8 (QCS8300) and IQ9 (QCS9100).
-These SoCs are used for factory/industry based applications.
+Qualcomm DragonWing are industrial-grade boards that provides various series of processors
+such as IQ6 (QCS615), IQ8 (QCS8300), IQ9 (QCS9100) and Q8 (QCS8550). These SoCs are used
+for factory/industry based applications. Note that the QCS8550 is a derivative of the
+SM8550 with the RF modem removed, so the SM8550 defconfig works for both the SM8550 and
+the QCS8550.
 More information can be found on the `Qualcomm's IQ6 product page`_,
-`Qualcomm's IQ8 product page`_ and `Qualcomm's IQ9 product page`_.
+`Qualcomm's IQ8 product page`_, `Qualcomm's IQ9 product page`_ and `Qualcomm's Q8 product page`_.
 
 .. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
 .. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
 .. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
+.. _Qualcomm's Q8 product page: https://docs.qualcomm.com/doc/87-61717-1/87-61717-1_REV_D_Qualcomm_Dragonwing_QCS8550_QCM8550_Processors_Product_Brief.pdf
 
 Installation
 ------------
-First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300``, ``QCS9100`` or ``SM8550``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_qcs8300_defconfig

-- 
2.43.0

