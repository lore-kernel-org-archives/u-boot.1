Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DE3C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE00D87ABC;
	Fri,  1 Mar 2024 14:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zZEHdLEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1136087EAF; Fri,  1 Mar 2024 14:25:10 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB07875FC
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-299354e5f01so2535896a91.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709299505; x=1709904305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UTDmFkKQiHsEDj4xEh96L6UqewC8Q7WO/418BH2YH90=;
 b=zZEHdLEzcitBvEdIVYT2B4IK+oDRH9f1djGhcjxcJEQHE1gljSkk1qXjrS3cZiU0rW
 bhfH1hz7EAxgkoCvrdR1Gqo0RM5RnBp+iRStR9QGWpQ/fbmo+txYV8I9Uf5UgS3KkPs5
 Ikck04OwbzFKBkuskYDfix3qQfzvJvrwVhtQ8itx1jLZicKGqjVC9SdyuRbDkbRjOzR1
 2/6nipYCid5cFoVENmxzJahWN8spVOSITvn19k5Lk7y9WUGrmqXVveqnqQOW0IIYp77f
 X3FW8eMDnj3fJtsogic3q97U4PcFDDzEbDaY2KDPXCgcy46Cn9ZGargdlQV0LoogmdVu
 M/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709299505; x=1709904305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTDmFkKQiHsEDj4xEh96L6UqewC8Q7WO/418BH2YH90=;
 b=VB52JTBBxEOkUjPiLEVDzKAmv23M7ZR1xYV29xPPd3gn2YnbxeVUS3zI53H1tBq6ub
 bI39qDrmHFLPKiQbDCMCkz/p8VmD+wQzoZ7xQvAQZlKkui0FUANmIW3IR5Gv8MawMChM
 lfB/TBKlVIW9H+xlSE/LUpbpKg0awk7x0aL8MnV+WN7u4818KKEIouGIZwu51eQp+RF7
 tOUDf5zQkMgdCuXt6apWOQwCIuYJwLERqWgXEsC8YG3C9tYvDtPR/A6baZK/166nuWsL
 4MuKoDLsQ07AYdByaHwEj66nEZTbT5tLYD1UZ4g60sCzH4dXuNB0lTrWVUFAta06sTLf
 rBWw==
X-Gm-Message-State: AOJu0YzFyTh5TJHTPMtRP3oQjdXGRAs03gjFucbHFZPjj8aqq9k+yeZq
 gjWmXHX7+5/y8R5xfV2TLWGjob12f9bYD0C//Ekh1VP1bZun5yg8yOpe/OWIylCsST77cFXtslz
 h
X-Google-Smtp-Source: AGHT+IHeVbBpx4uMykWgIk6mm/er5FVYd/nYOEdT07zTVU1wZUv0ocDlGAwcXUAkGfY27X5J4rrBZQ==
X-Received: by 2002:a17:90a:101:b0:29a:ea3d:5776 with SMTP id
 b1-20020a17090a010100b0029aea3d5776mr2473793pjb.11.1709299505057; 
 Fri, 01 Mar 2024 05:25:05 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.98]) by smtp.gmail.com with ESMTPSA id
 l22-20020a17090b079600b0029a8e5355fcsm3171078pjz.53.2024.03.01.05.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 05:25:04 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, paul.barker.ct@bp.renesas.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] doc: devicetree: Lets avoid short reference link names
Date: Fri,  1 Mar 2024 18:54:53 +0530
Message-Id: <20240301132454.3492762-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Short reference link names like "dtspec", "dtrepo", "dttweaks" etc.
interrupt the flow of the document text. Lets avoid them and instead
expand in place for better readability.

Suggested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 doc/develop/devicetree/control.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index c94d84192b71..4cc1457d4ea8 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -36,10 +36,10 @@ What is a Flattened Devicetree?
 -------------------------------
 
 An fdt can be specified in source format as a text file. To read about
-the fdt syntax, take a look at the specification (dtspec_).
+the fdt syntax, take a look at `the devicetree specification`_.
 
-There is also a mailing list (dtlist_) for the compiler and associated
-tools.
+There is also a `devicetree compiler mailing list`_ for the compiler and
+associated tools.
 
 In case you are wondering, OF stands for Open Firmware. This follows the
 convention used in Linux.
@@ -89,7 +89,7 @@ Failing that, you could write one from scratch yourself!
 Resyncing with devicetree-rebasing
 ----------------------------------
 
-The devicetee-rebasing repository (dtrepo_) maintains a fork cum mirror copy of
+The `devicetree-rebasing repository`_ maintains a fork cum mirror copy of
 devicetree files along with the bindings synced at every Linux kernel major
 release or intermediate release candidates. The U-Boot maintainers regularly
 sync the `dts/upstream/` subtree from the devicetree-rebasing repo whenever
@@ -118,7 +118,7 @@ as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTREAM is not
 set` and set `DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
 
 This should include your CPU or SoC's devicetree file. On top of that any U-Boot
-specific tweaks (see: dttweaks_) can be made for your board.
+specific tweaks (see: :ref:`dttweaks`) can be made for your board.
 
 If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
@@ -243,7 +243,7 @@ Dependencies
 
 The DT schema project must be installed in order to validate the DT schema
 binding documents and validate DTS files using the DT schema. For installation
-instructions, refer to the DT schema project page (dtschema_).
+instructions, refer to the `DT schema project page`_.
 
 Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
 installed. Ensure they are in your PATH (~/.local/bin by default).
@@ -333,10 +333,10 @@ used it before Linux (e.g. snow). The two projects developed in parallel
 and there are still some differences in the bindings for certain boards.
 While there has been discussion of having a separate repository for devicetree
 files, in practice the Linux kernel Git repository has become the place where
-these are stored, with U-Boot taking copies via devicetree-rebasing repo
-(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
+these are stored, with U-Boot taking copies via
+`devicetree-rebasing repository`_ and adding tweaks with u-boot.dtsi files.
 
-.. _dtspec: https://www.devicetree.org/specifications/
-.. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
-.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
-.. _dtschema: https://github.com/devicetree-org/dt-schema/tree/main
+.. _the devicetree specification: https://www.devicetree.org/specifications/
+.. _devicetree compiler mailing list: https://www.spinics.net/lists/devicetree-compiler/
+.. _devicetree-rebasing repository: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
+.. _DT schema project page: https://github.com/devicetree-org/dt-schema/tree/main
-- 
2.34.1

