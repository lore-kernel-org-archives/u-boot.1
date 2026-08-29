Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1BBC61DB9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A2D980F92;
	Sat, 29 Aug 2026 01:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6j9xaOQxVpC; Sat, 29 Aug 2026 01:50:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968239;
	bh=1LH5TyonVf5izYtAgvCcrNdWyq6B3IWT09MlM55HXig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phfSgPbQyi156eP9NCEHoYfa5aS7AWM3w3nqorjrT5z6E7zGLQnxZLVPCb2BoTvj2
	 DqOrPQj1H5ghsqeAwlMRO9+oloOkTsBecrWscXOPK3mC0sKMt2Cp1QrBFnK09Og2dw
	 IxDxJoGR8Zo87P9Bw6LHEA5+sdPcmzjjCQI/uuSO0dH/SrgOuhmsP8FQ2eK02Z4jkh
	 Az76vjC7cExaqF8j85QacG2ineKBnzoJpokVuSEhMrN85c1IS0rC1NUIaXVZqeltwA
	 e1laciC46labeKzizKLZd3jAgm7oxBCUiLUGld7b1LUoMXjJdZ+F4MirYx7GK/g5ss
	 LJoFSFGBHxDOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C91FC80F70;
	Sat, 29 Aug 2026 01:50:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71AE9355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52EFA80F3F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3jb8x-jgmeU for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c41; helo=mail-oo1-xc41.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d3oaiSuw
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A118080E75
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:31 +0000 (UTC)
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-6b31010a387so29306eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968230; x=1788573030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1LH5TyonVf5izYtAgvCcrNdWyq6B3IWT09MlM55HXig=;
 b=d3oaiSuw6feVnri0ggZwLFXlD2FGI45G9DNgnGFKW01/+ykRwPvOswp/RUlRIEoQSq
 7HH9hAE/ZCqu5DicTvDudIhUnUITOW09zwSnR++sS2ysE6Tz81shseHN+rbqKajqD3S3
 h6XyYOm0RMhFbnuO4Y/T20XTt41ajaDmNyrpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968230; x=1788573030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1LH5TyonVf5izYtAgvCcrNdWyq6B3IWT09MlM55HXig=;
 b=YEHtQHM+yMVrjcDA+ZtpUgN5t7LwhdQHHxXMM5uNjgolybMqIMUrfNV2skWOhNN2zV
 C0Lt5QyOakkKtwtm16dG6bg/1JF0QyYJ3oU7+YU8PvvgVCd4CRWiWJMGfYV7fvmI1h8J
 ETRMDSPJqhM4RyXWz082aMnAhPJheUoRbj521LIo4M80V87YeWnOHP+jb6H/oP3/RxoL
 3pyFhEpCDs6b9YDDXfHM0OlMEAYDj6dhLIXzjSfksNj3fxL/jdR0FNh2UIUdkGTLQAQD
 MHgjpWAmcryY6mN4WRF+urudzwtd/DnmkLEm/Al6Q1FU1a/XhKS5ACYxLVzEz/CmUZYo
 ZECA==
X-Gm-Message-State: AFuF++lQlguuAheVsv1w7JGe7ZLuMAs1E+jtRHppyb1W4WbFhS0W7GFi
 0SotTTiBp9AIjk/XmRY2+kc9DbWvkK5CoquJct/s8bXvRUsQsfUvAxBFQT+WF3exMVN9bejlh5E
 fs6MHgqfFtMrexc4=
X-Gm-Gg: AR+sD11jF4t1vq4eNOsykXqZQV8ZpApUURpilrbjBiDGUx3h9tNuxJNl3bgsGFPPUYJ
 TpR3mQoMG03OUk6w9jXz4w+N7H38AnQTdafLKdWTvpNoLQavcj6C/kRUqmGruzEmjrgabv/2kBe
 +7YirGRtacsXrHpATE4+sIdUMBeX6w1Bd+ioyhoUYytM5xJiZ3xmBOPJFZyurugZEj+CagJlkZp
 y3Wua1lPsBOV7/5v1wW8T18DtQVed3bGsmDnXtkr8KfHtKQ9lWGZlyVsRbtjgea7/XKCVmj0lP7
 8NsScc2kV3vToctMboq9apl/smuKskPhqGO+PWre7x5xrpgGzXpShw1hyGxNmG7dmzUKJsEbcX3
 obJiNPaZbW2zuoE1On/WmyRfgkZ3QT00hgxVLGkPIfkNGIPMepFDo8bEdLIHu/0zElvpeCRKai9
 rhh1EJt7BuMitvn7dMB/Abd1cvyYbX7X9Cd7Keg3wxrIufpsR2/+dtG31pCXcu0IHLIEolFqjAj
 PrYtToFcT6n9tLv0B/6WRI8NxZPGxqt/GZpRomx5w1GAMgrtIUzykvgAphHJhNm6tkBcFMTOhXV
 8NVcx7AxExoRZwyDdKPQqps0Gd+Ql9Ue4w==
X-Received: by 2002:a05:6820:308a:b0:6b1:c472:9d89 with SMTP id
 006d021491bc7-6b1c472c716mr10408622eaf.21.1787968230274; 
 Fri, 28 Aug 2026 18:50:30 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 2/7] MAINTAINERS: tegra: Update and correct entries
Date: Fri, 28 Aug 2026 19:50:20 -0600
Message-ID: <20260829015026.473134-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the main MAINTAINERS entry for Tegra to make use of the "N:"
syntax to catch everything with tegra in the filename. This lets us
remove the incorrect board config header entries for a large number of
platforms while still having the used header files have a maintainer be
found. Furthermore, correct some platform MAINTAINERS files that other
obvious issues (such as .dtb rather than .dts in listings).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>

This is slightly different than Michal's version because it adds the "N"
entry for Tegra overall and so catches include/configs/tegra.h which all
of the boards which had their include/configs/ line removed actually
use.
---
 MAINTAINERS                                  | 6 +-----
 board/acer/picasso/MAINTAINERS               | 1 -
 board/asus/grouper/MAINTAINERS               | 1 -
 board/asus/transformer-t114/MAINTAINERS      | 1 -
 board/asus/transformer-t20/MAINTAINERS       | 1 -
 board/asus/transformer-t30/MAINTAINERS       | 1 -
 board/avionic-design/medcom-wide/MAINTAINERS | 2 +-
 board/avionic-design/plutux/MAINTAINERS      | 2 +-
 board/avionic-design/tec-ng/MAINTAINERS      | 2 +-
 board/avionic-design/tec/MAINTAINERS         | 2 +-
 board/cei/cei-tk1-som/MAINTAINERS            | 2 +-
 board/compal/paz00/MAINTAINERS               | 2 +-
 board/compulab/trimslice/MAINTAINERS         | 2 +-
 board/htc/endeavoru/MAINTAINERS              | 2 +-
 board/lenovo/ideapad-yoga-11/MAINTAINERS     | 2 +-
 board/lg/x3-t30/MAINTAINERS                  | 2 +-
 board/microsoft/surface-rt/MAINTAINERS       | 2 +-
 board/nvidia/beaver/MAINTAINERS              | 1 -
 board/nvidia/cardhu/MAINTAINERS              | 1 -
 board/nvidia/dalmore/MAINTAINERS             | 1 -
 board/nvidia/harmony/MAINTAINERS             | 1 -
 board/nvidia/jetson-tk1/MAINTAINERS          | 1 -
 board/nvidia/nyan-big/MAINTAINERS            | 1 -
 board/nvidia/p2371-0000/MAINTAINERS          | 1 -
 board/nvidia/p2371-2180/MAINTAINERS          | 1 -
 board/nvidia/p2571/MAINTAINERS               | 1 -
 board/nvidia/p2771-0000/MAINTAINERS          | 1 -
 board/nvidia/p3450-0000/MAINTAINERS          | 1 -
 board/nvidia/seaboard/MAINTAINERS            | 1 -
 board/nvidia/tegratab/MAINTAINERS            | 1 -
 board/nvidia/venice2/MAINTAINERS             | 1 -
 board/nvidia/ventana/MAINTAINERS             | 1 -
 board/ouya/ouya/MAINTAINERS                  | 2 +-
 board/toradex/apalis-tk1/MAINTAINERS         | 2 +-
 board/toradex/apalis_t30/MAINTAINERS         | 4 ++--
 board/toradex/colibri_t20/MAINTAINERS        | 4 ++--
 board/toradex/colibri_t30/MAINTAINERS        | 4 ++--
 board/wexler/qc750/MAINTAINERS               | 2 +-
 board/xiaomi/mocha/MAINTAINERS               | 2 +-
 39 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ec830e4a33..a3d14cd049bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -701,11 +701,7 @@ M:	Thierry Reding <treding@nvidia.com>
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-tegra.git
-F:	arch/arm/dts/tegra*
-F:	arch/arm/include/asm/arch-tegra*/
-F:	arch/arm/mach-tegra/
-F:	drivers/*/tegra*
-F:	drivers/*/tegra*/
+N:	tegra
 
 ARM TI
 M:	Tom Rini <trini@konsulko.com>
diff --git a/board/acer/picasso/MAINTAINERS b/board/acer/picasso/MAINTAINERS
index 99f8c0b6d7fa..ab2fe5ebdf5e 100644
--- a/board/acer/picasso/MAINTAINERS
+++ b/board/acer/picasso/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/acer/picasso/
 F:	configs/picasso_defconfig
 F:	doc/board/acer/picasso.rst
-F:	include/configs/picasso.h
diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAINERS
index 3c59632451ff..6a54389c74ec 100644
--- a/board/asus/grouper/MAINTAINERS
+++ b/board/asus/grouper/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/asus/grouper/
 F:	configs/grouper_defconfig
 F:	doc/board/asus/grouper.rst
-F:	include/configs/grouper.h
diff --git a/board/asus/transformer-t114/MAINTAINERS b/board/asus/transformer-t114/MAINTAINERS
index 2e8f01b98df2..01692fd29af7 100644
--- a/board/asus/transformer-t114/MAINTAINERS
+++ b/board/asus/transformer-t114/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra114-asus-tf701t.dts
 F:	board/asus/transformer-t114/
 F:	configs/tf701t_defconfig
 F:	doc/board/asus/transformer_t114.rst
-F:	include/configs/transformer-t114.h
diff --git a/board/asus/transformer-t20/MAINTAINERS b/board/asus/transformer-t20/MAINTAINERS
index 7bf93570985f..28b8f954e7c6 100644
--- a/board/asus/transformer-t20/MAINTAINERS
+++ b/board/asus/transformer-t20/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra20-asus-*
 F:	board/asus/transformer-t20/
 F:	configs/transformer_t20_defconfig
 F:	doc/board/asus/transformer_t20.rst
-F:	include/configs/transformer-t20.h
diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transformer-t30/MAINTAINERS
index 869cc5aeb910..3fdcdd7c027a 100644
--- a/board/asus/transformer-t30/MAINTAINERS
+++ b/board/asus/transformer-t30/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/asus/transformer-t30/
 F:	configs/transformer_t30_defconfig
 F:	doc/board/asus/transformer_t30.rst
-F:	include/configs/transformer-t30.h
diff --git a/board/avionic-design/medcom-wide/MAINTAINERS b/board/avionic-design/medcom-wide/MAINTAINERS
index 3d2cdeca7259..ff777cae7e1e 100644
--- a/board/avionic-design/medcom-wide/MAINTAINERS
+++ b/board/avionic-design/medcom-wide/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/medcom-wide/
 F:	board/avionic-design/common/
-F:	include/configs/medcom-wide.h
+F:	include/configs/tegra.h
 F:	configs/medcom-wide_defconfig
diff --git a/board/avionic-design/plutux/MAINTAINERS b/board/avionic-design/plutux/MAINTAINERS
index 0275680d21f2..fe10cec8b638 100644
--- a/board/avionic-design/plutux/MAINTAINERS
+++ b/board/avionic-design/plutux/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/plutux/
 F:	board/avionic-design/common/
-F:	include/configs/plutux.h
+F:	include/configs/tegra.h
 F:	configs/plutux_defconfig
diff --git a/board/avionic-design/tec-ng/MAINTAINERS b/board/avionic-design/tec-ng/MAINTAINERS
index 645be8186aa6..1ce903ccc6b3 100644
--- a/board/avionic-design/tec-ng/MAINTAINERS
+++ b/board/avionic-design/tec-ng/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec-ng/
 F:	board/avionic-design/common/
-F:	include/configs/tec-ng.h
+F:	include/configs/tegra.h
 F:	configs/tec-ng_defconfig
diff --git a/board/avionic-design/tec/MAINTAINERS b/board/avionic-design/tec/MAINTAINERS
index 36088e7daccf..76d2f9f42504 100644
--- a/board/avionic-design/tec/MAINTAINERS
+++ b/board/avionic-design/tec/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec/
 F:	board/avionic-design/common/
-F:	include/configs/tec.h
+F:	include/configs/tegra.h
 F:	configs/tec_defconfig
diff --git a/board/cei/cei-tk1-som/MAINTAINERS b/board/cei/cei-tk1-som/MAINTAINERS
index f1817401a5df..f9ee3d6c8484 100644
--- a/board/cei/cei-tk1-som/MAINTAINERS
+++ b/board/cei/cei-tk1-som/MAINTAINERS
@@ -2,5 +2,5 @@ TK1-SOM BOARD
 M:	Peter.Chubb@data61.csiro.au
 S:	Maintained
 F:	board/cei/cei-tk1-som/
-F:	include/configs/cei-tk1-som.h
+F:	include/configs/tegra.h
 F:	configs/cei-tk1-som_defconfig
diff --git a/board/compal/paz00/MAINTAINERS b/board/compal/paz00/MAINTAINERS
index ba174cd190db..95fd8fba26c1 100644
--- a/board/compal/paz00/MAINTAINERS
+++ b/board/compal/paz00/MAINTAINERS
@@ -2,5 +2,5 @@ PAZ00 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compal/paz00/
-F:	include/configs/paz00.h
+F:	include/configs/tegra.h
 F:	configs/paz00_defconfig
diff --git a/board/compulab/trimslice/MAINTAINERS b/board/compulab/trimslice/MAINTAINERS
index 4eb868c0c838..1567f8691c2d 100644
--- a/board/compulab/trimslice/MAINTAINERS
+++ b/board/compulab/trimslice/MAINTAINERS
@@ -2,5 +2,5 @@ TRIMSLICE BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compulab/trimslice/
-F:	include/configs/trimslice.h
+F:	include/configs/tegra.h
 F:	configs/trimslice_defconfig
diff --git a/board/htc/endeavoru/MAINTAINERS b/board/htc/endeavoru/MAINTAINERS
index 85f439f4672e..ff46e79f8001 100644
--- a/board/htc/endeavoru/MAINTAINERS
+++ b/board/htc/endeavoru/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/htc/endeavoru/
 F:	configs/endeavoru_defconfig
 F:	doc/board/htc/endeavoru.rst
-F:	include/configs/endeavoru.h
+F:	include/configs/tegra.h
diff --git a/board/lenovo/ideapad-yoga-11/MAINTAINERS b/board/lenovo/ideapad-yoga-11/MAINTAINERS
index 77e82534a95c..7da9ca79ef8c 100644
--- a/board/lenovo/ideapad-yoga-11/MAINTAINERS
+++ b/board/lenovo/ideapad-yoga-11/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/lenovo/ideapad-yoga-11/
 F:	configs/ideapad-yoga-11_defconfig
 F:	doc/board/lenovo/ideapad-yoga-11.rst
-F:	include/configs/ideapad-yoga-11.h
+F:	include/configs/tegra.h
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
index 13c8588d0b92..556407a1caa7 100644
--- a/board/lg/x3-t30/MAINTAINERS
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/lg/x3-t30/
 F:	configs/x3_t30_defconfig
 F:	doc/board/lg/x3_t30.rst
-F:	include/configs/x3-t30.h
+F:	include/configs/tegra.h
diff --git a/board/microsoft/surface-rt/MAINTAINERS b/board/microsoft/surface-rt/MAINTAINERS
index 1bbd896de928..78343e92a45a 100644
--- a/board/microsoft/surface-rt/MAINTAINERS
+++ b/board/microsoft/surface-rt/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/microsoft/surface-rt/
 F:	configs/surface-rt_defconfig
 F:	doc/board/microsoft/surface-rt.rst
-F:	include/configs/surface-rt.h
+F:	include/configs/tegra.h
diff --git a/board/nvidia/beaver/MAINTAINERS b/board/nvidia/beaver/MAINTAINERS
index 20d5836b9ec8..1dd1fad7fbfa 100644
--- a/board/nvidia/beaver/MAINTAINERS
+++ b/board/nvidia/beaver/MAINTAINERS
@@ -2,5 +2,4 @@ BEAVER BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/beaver/
-F:	include/configs/beaver.h
 F:	configs/beaver_defconfig
diff --git a/board/nvidia/cardhu/MAINTAINERS b/board/nvidia/cardhu/MAINTAINERS
index d3c3e368c17b..3984aa8d57b7 100644
--- a/board/nvidia/cardhu/MAINTAINERS
+++ b/board/nvidia/cardhu/MAINTAINERS
@@ -2,5 +2,4 @@ CARDHU BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/cardhu/
-F:	include/configs/cardhu.h
 F:	configs/cardhu_defconfig
diff --git a/board/nvidia/dalmore/MAINTAINERS b/board/nvidia/dalmore/MAINTAINERS
index fe86375ca9b4..5c8c08a2bdaa 100644
--- a/board/nvidia/dalmore/MAINTAINERS
+++ b/board/nvidia/dalmore/MAINTAINERS
@@ -2,5 +2,4 @@ DALMORE BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/dalmore/
-F:	include/configs/dalmore.h
 F:	configs/dalmore_defconfig
diff --git a/board/nvidia/harmony/MAINTAINERS b/board/nvidia/harmony/MAINTAINERS
index f3508edc3f56..2c25611dc358 100644
--- a/board/nvidia/harmony/MAINTAINERS
+++ b/board/nvidia/harmony/MAINTAINERS
@@ -2,5 +2,4 @@ HARMONY BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/harmony/
-F:	include/configs/harmony.h
 F:	configs/harmony_defconfig
diff --git a/board/nvidia/jetson-tk1/MAINTAINERS b/board/nvidia/jetson-tk1/MAINTAINERS
index f0d8f5eb8e52..15a7a04de392 100644
--- a/board/nvidia/jetson-tk1/MAINTAINERS
+++ b/board/nvidia/jetson-tk1/MAINTAINERS
@@ -2,5 +2,4 @@ JETSON-TK1 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/jetson-tk1/
-F:	include/configs/jetson-tk1.h
 F:	configs/jetson-tk1_defconfig
diff --git a/board/nvidia/nyan-big/MAINTAINERS b/board/nvidia/nyan-big/MAINTAINERS
index 779077729c92..91a48bda0a8f 100644
--- a/board/nvidia/nyan-big/MAINTAINERS
+++ b/board/nvidia/nyan-big/MAINTAINERS
@@ -2,5 +2,4 @@ NYAN-BIG BOARD
 M:	Allen Martin <amartin@nvidia.com>
 S:	Maintained
 F:	board/nvidia/nyan-big/
-F:	include/configs/nyan-big.h
 F:	configs/nyan-big_defconfig
diff --git a/board/nvidia/p2371-0000/MAINTAINERS b/board/nvidia/p2371-0000/MAINTAINERS
index e6d04bf7c5e1..d3f6d64731d4 100644
--- a/board/nvidia/p2371-0000/MAINTAINERS
+++ b/board/nvidia/p2371-0000/MAINTAINERS
@@ -2,5 +2,4 @@ P2371-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2371-0000/
-F:	include/configs/p2371-0000.h
 F:	configs/p2371-0000_defconfig
diff --git a/board/nvidia/p2371-2180/MAINTAINERS b/board/nvidia/p2371-2180/MAINTAINERS
index 815377490c7f..49d6062ab6b7 100644
--- a/board/nvidia/p2371-2180/MAINTAINERS
+++ b/board/nvidia/p2371-2180/MAINTAINERS
@@ -2,5 +2,4 @@ P2371-2180 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2371-2180/
-F:	include/configs/p2371-2180.h
 F:	configs/p2371-2180_defconfig
diff --git a/board/nvidia/p2571/MAINTAINERS b/board/nvidia/p2571/MAINTAINERS
index c165135a9432..23b9c6e83e3b 100644
--- a/board/nvidia/p2571/MAINTAINERS
+++ b/board/nvidia/p2571/MAINTAINERS
@@ -2,5 +2,4 @@ P2571 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2571/
-F:	include/configs/p2571.h
 F:	configs/p2571_defconfig
diff --git a/board/nvidia/p2771-0000/MAINTAINERS b/board/nvidia/p2771-0000/MAINTAINERS
index 1a49e63231de..7dbdbe0bcea2 100644
--- a/board/nvidia/p2771-0000/MAINTAINERS
+++ b/board/nvidia/p2771-0000/MAINTAINERS
@@ -2,6 +2,5 @@ P2771-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2771-0000/
-F:	include/configs/p2771-0000.h
 F:	configs/p2771-0000-000_defconfig
 F:	configs/p2771-0000-500_defconfig
diff --git a/board/nvidia/p3450-0000/MAINTAINERS b/board/nvidia/p3450-0000/MAINTAINERS
index 40700066bf39..6b93e40c842d 100644
--- a/board/nvidia/p3450-0000/MAINTAINERS
+++ b/board/nvidia/p3450-0000/MAINTAINERS
@@ -2,5 +2,4 @@ P3450-0000 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p3450-0000/
-F:	include/configs/p3450-0000.h
 F:	configs/p3450-0000_defconfig
diff --git a/board/nvidia/seaboard/MAINTAINERS b/board/nvidia/seaboard/MAINTAINERS
index 7926ca19a896..b4759028a778 100644
--- a/board/nvidia/seaboard/MAINTAINERS
+++ b/board/nvidia/seaboard/MAINTAINERS
@@ -2,5 +2,4 @@ SEABOARD BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/seaboard/
-F:	include/configs/seaboard.h
 F:	configs/seaboard_defconfig
diff --git a/board/nvidia/tegratab/MAINTAINERS b/board/nvidia/tegratab/MAINTAINERS
index bfd9eae86581..903279523a3d 100644
--- a/board/nvidia/tegratab/MAINTAINERS
+++ b/board/nvidia/tegratab/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra114-nvidia-tegratab.dts
 F:	board/nvidia/tegratab/
 F:	configs/tegratab_defconfig
 F:	doc/board/nvidia/tegratab.rst
-F:	include/configs/tegratab.h
diff --git a/board/nvidia/venice2/MAINTAINERS b/board/nvidia/venice2/MAINTAINERS
index 221df654d741..3ce3c6e1d26e 100644
--- a/board/nvidia/venice2/MAINTAINERS
+++ b/board/nvidia/venice2/MAINTAINERS
@@ -2,5 +2,4 @@ VENICE2 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/venice2/
-F:	include/configs/venice2.h
 F:	configs/venice2_defconfig
diff --git a/board/nvidia/ventana/MAINTAINERS b/board/nvidia/ventana/MAINTAINERS
index ba65a2bfc2fb..a83fec521335 100644
--- a/board/nvidia/ventana/MAINTAINERS
+++ b/board/nvidia/ventana/MAINTAINERS
@@ -2,5 +2,4 @@ VENTANA BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/ventana/
-F:	include/configs/ventana.h
 F:	configs/ventana_defconfig
diff --git a/board/ouya/ouya/MAINTAINERS b/board/ouya/ouya/MAINTAINERS
index 7f664b2e65ff..52f3e6bcf6cc 100644
--- a/board/ouya/ouya/MAINTAINERS
+++ b/board/ouya/ouya/MAINTAINERS
@@ -5,4 +5,4 @@ S:	Maintained
 F:	board/ouya/ouya/
 F:	configs/ouya_defconfig
 F:	doc/board/ouya/ouya.rst
-F:	include/configs/ouya.h
+F:	include/configs/tegra.h
diff --git a/board/toradex/apalis-tk1/MAINTAINERS b/board/toradex/apalis-tk1/MAINTAINERS
index 393c8dcf8016..6ac3df370e7a 100644
--- a/board/toradex/apalis-tk1/MAINTAINERS
+++ b/board/toradex/apalis-tk1/MAINTAINERS
@@ -5,4 +5,4 @@ F:	board/toradex/apalis-tk1/
 F:	board/toradex/common/
 F:	include/configs/apalis-tk1.h
 F:	configs/apalis-tk1_defconfig
-F:	arch/arm/dts/tegra124-apalis.dtb
+F:	arch/arm/dts/tegra124-apalis.dts
diff --git a/board/toradex/apalis_t30/MAINTAINERS b/board/toradex/apalis_t30/MAINTAINERS
index 368decf66744..e36fcd6a81af 100644
--- a/board/toradex/apalis_t30/MAINTAINERS
+++ b/board/toradex/apalis_t30/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/apalis_t30/
 F:	board/toradex/common/
-F:	include/configs/apalis_t30.h
+F:	include/configs/tegra.h
 F:	configs/apalis_t30_defconfig
-F:	arch/arm/dts/tegra30-apalis.dtb
+F:	arch/arm/dts/tegra30-apalis.dts
diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibri_t20/MAINTAINERS
index 58842434024f..b52135bf5570 100644
--- a/board/toradex/colibri_t20/MAINTAINERS
+++ b/board/toradex/colibri_t20/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t20/
 F:	board/toradex/common/
-F:	include/configs/colibri_t20.h
+F:	include/configs/tegra.h
 F:	configs/colibri_t20_defconfig
-F:	arch/arm/dts/tegra20-colibri.dtb
+F:	arch/arm/dts/tegra20-colibri.dts
diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibri_t30/MAINTAINERS
index 73859fd25c2e..393ef3901f2f 100644
--- a/board/toradex/colibri_t30/MAINTAINERS
+++ b/board/toradex/colibri_t30/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t30/
 F:	board/toradex/common/
-F:	include/configs/colibri_t30.h
+F:	include/configs/tegra.h
 F:	configs/colibri_t30_defconfig
-F:	arch/arm/dts/tegra30-colibri.dtb
+F:	arch/arm/dts/tegra30-colibri.dts
diff --git a/board/wexler/qc750/MAINTAINERS b/board/wexler/qc750/MAINTAINERS
index 017f6f2b707e..9dae5c17a668 100644
--- a/board/wexler/qc750/MAINTAINERS
+++ b/board/wexler/qc750/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/wexler/qc750/
 F:	configs/qc750_defconfig
 F:	doc/board/wexler/qc750.rst
-F:	include/configs/qc750.h
+F:	include/configs/tegra.h
diff --git a/board/xiaomi/mocha/MAINTAINERS b/board/xiaomi/mocha/MAINTAINERS
index c3871a15a35b..42c0013ea651 100644
--- a/board/xiaomi/mocha/MAINTAINERS
+++ b/board/xiaomi/mocha/MAINTAINERS
@@ -5,4 +5,4 @@ F:	arch/arm/dts/tegra124-xiaomi-mocha.dts
 F:	board/xiaomi/mocha/
 F:	configs/mocha_defconfig
 F:	doc/board/xiaomi/mocha.rst
-F:	include/configs/mocha.h
+F:	include/configs/tegra.h
-- 
2.43.0

