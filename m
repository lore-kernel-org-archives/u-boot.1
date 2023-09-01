Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACB1CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9A086932;
	Fri,  1 Sep 2023 12:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SKiPvnHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5659586906; Fri,  1 Sep 2023 12:27:02 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759088693C
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57358a689d2so1125504eaf.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693564014; x=1694168814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NmMRlMmHbAXwjiLaquucgjFfrDauScedEYe17PD+cM=;
 b=SKiPvnHVwv7jEJKNACqz3wJ8TxHAfBctprySrsuQs/9FthiK/iuCZk7AYWWVafwqtW
 1EVYdGlc4lUbJvGrJvYJQtOzJCYHL+mV4/+7kSPCZBFs/DO00u0Zuog+/S6H8Xzv6KpJ
 zAIColgEAlgy96Ibm8PjZILD1+lb4FBU6D0QaSqZPwZhu/7Fe5LtnQ0aOs2l7hwJ03RZ
 Cn0bZr/VuQ73nRmri1/n1XgvbKuPpqe27zMNSdwERiXZienoZN3MCTSMlbf5IOJJwPGP
 SvbZQ4d0JSV2HezBDtZO50DqchCxlSB7eAnOYxexiQBb1gcKZxhKI50bnzbt+ERzEbuK
 ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693564014; x=1694168814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NmMRlMmHbAXwjiLaquucgjFfrDauScedEYe17PD+cM=;
 b=DOoZoYSptEToBa8wXkqxlSM2AzMDZFwrRaRGyNURv9EjR1RAlrK1vQl1YUs2zCJp15
 BJflMEeXiTy6Rz4leTxl2u2htUHWmQAydUT8NLZ6u8cNAKZ5ys7SplUfVZyJ0eu6svYf
 0pzGjX9K++bxOXYYnSGcpcdWDP+KthWqkJ6cG4QWbY1b+qgaN/FXJxQSdUq9vvEIQFlA
 5X2G99vD4mN8yjP+jw8Uc0w3UAPjOBuF1vgGRIrox6YVHWa2ptlq39sDQBG3GbnwfYgw
 63OMXwDO/OT8yJR2+egKSUYX/4v9pCSGzIokn2UOnXsnPT/6XUt62Tv9CDn9MnuocIQM
 ey7g==
X-Gm-Message-State: AOJu0YwEQVcxJi2CjJ/kB9UNRrIVQs2gcH00s+MS6CCU81LqUpsWEzkU
 dFStmv+ZFhTBQcaIwzgASI4WXQ+y7mbATJamCPE=
X-Google-Smtp-Source: AGHT+IEkLBdAoCcWVU0iRbks8f0VwuwWmIO0TY7sp8Mrm4llFfjzhDEe0t8GWc+ngPxKrLoauyoSig==
X-Received: by 2002:a05:6808:1150:b0:3a8:7c67:7f5 with SMTP id
 u16-20020a056808115000b003a87c6707f5mr2733211oiu.1.1693564014597; 
 Fri, 01 Sep 2023 03:26:54 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 b15-20020a63714f000000b0056c24c2e23dsm2526016pgn.25.2023.09.01.03.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:53 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 6/6] doc: uefi: add HTTP Boot support
Date: Fri,  1 Sep 2023 19:25:42 +0900
Message-Id: <20230901102542.609239-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901102542.609239-1-masahisa.kojima@linaro.org>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
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

This adds the description about HTTP Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 doc/develop/uefi/uefi.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index a7a41f2fac..fd87bb1edb 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -594,6 +594,27 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
+UEFI HTTP Boot
+~~~~~~~~~~~~~~
+
+HTTP Boot provides the capability for system deployment and configuration
+over the network. HTTP Boot can be activated by specifying::
+
+    CONFIG_CMD_DNS
+    CONFIG_CMD_WGET
+    CONFIG_BLKMAP
+
+Set up the load option specifying the target URI::
+
+    efidebug boot add -u 1 netinst http://foo/bar
+
+When this load option is selected as boot selection, resolve the
+host ip address by dhs, then download the file with wget.
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file extension is .efi and file is PE-COFF image,
+load the downloaded file and start it.
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

