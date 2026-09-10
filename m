Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E771C79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6BA140B48;
	Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJd58x8oBjpF; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9B3440B94
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070602;
	b=TlPgR+eWFTlswK5xwYo/wu45tH9AcnLBG8XcZNuhUgn/8K1TqbEPF3QUzqVfzHhH69/B
	 GClEDHo+BBn+6ZsF39YUkn+UM4ea/JwRIMYfKwHF/lFFQEI8NnDD5/Ay3fN+hVjTf5A24
	 z7CQOQmNTe9jec2M6pnl/CfwE7yQGsfslYuVa55Ihp+12ZitYOWNy0kIEQlEUN5AmHPoE
	 /fQwWBS8IlsVSpoLkGL/TkbNoxNLCT/3FWy9pRpZMJ3EudRg4FjzhDDD4+tHRSIiJBZYU
	 vO0gb/FHGG9NpHtuGj6T83/kxnWKJHn/gKvSX8cpezm5NrBJLCduG8FQsCTcu50SDZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MKUub4TyUHJqzJ0ddOIRoqHTuWHu/O9qU1qU4XoAdFk=;
	b=iPmHbZjIM1Cs2SflPM912KWGxitlrdHglLO0XeivLsr2JcfA3ju+DDFiZ8HyG7I+RLCL
	 qbdmVhUwEEvw6kmjNw1VbUUQIC8z51PUl77c4eGrVVcguwUsfa6XCM7TsXLNZtrc6f3bX
	 X9B3PSU/7NyiyTc/3ZrRrMDF5NziaHqQyY4U76KCdtqRFwCcvV1+wIM8/3i7VGZn2HgQJ
	 Tg7/fmEz56XeYDCXZQi1bowefZP+KJhNKll05Q8+I9vAGketmm/QN9X4smN7+P209H8hO
	 zCQHW6zv7Bx2cruaybcEPPeyiNu0ySejS1iX76VzO5Nob2czCrRirsOTGgv9YfHhfZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070601;
	bh=MKUub4TyUHJqzJ0ddOIRoqHTuWHu/O9qU1qU4XoAdFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ptl4Mo5P9k/mZ6hmva1BjlaHUtbwy9Z2QPI0qoeQ9HZXQ/5m2ObQ8vJkwtz/swnuc
	 znGZv3KUMycluSl79SDruleQQq5darL9TVI5T3Yz5p0hy3WJbnXmdtZGA6/PA0hAPa
	 kSmySS+7d/HEtwlLHWJt/iAVqTu4+2s2sMC6XUhIkJIv8WMFD2VBsz78rPRTEMX3sS
	 uNnL0Fsc5nHk5PjTYx6G3gsjde3Yej32q9E6F3HGWua5pGpr9rQvFDoaSkC9JaF6PO
	 UEVUlZfEMArrGoobIgzfJCVAdEQldlmP81nnPw+6bAPBjTgApIuShRVx1/Q3roR3Jv
	 8OdXohr6HpJnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9B3440B94;
	Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A49FC498
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B49480F78
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lcxzhsv9bNpi for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 84A6880F20
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070596;
 b=VF6jaVf3Y8Zd8qbsynZqKoCPibUK+ot3/fWcdu/ieLPSWZNL0qau2EnWIY00H40uAd4g
 T4+rwMy9gIXpaldHdf7Tt08MYpizGE1Q2lgE9vIT870kb+Qi7JfljTOS+9+MDcbTd/Jwh
 zVm9O9qfLgWKkuSQN0FwSRi0beAgSWbssTaZbfu9H/CWRNllGfJ9tCxqaYPAoC8Bg+PNN
 7G58NnCdSWjYDgS1pVCQOf3jh26sO5ei9xJuO7NbrIZuQrQZyK+CXaA8xSBw2kmZJGveW
 nhhi2Mxwu9jji+Be9E7lS0ik/mcZNSNiwJFJY48Judsc145srQQGqxmo0G9mhOkcwaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MKUub4TyUHJqzJ0ddOIRoqHTuWHu/O9qU1qU4XoAdFk=;
 b=UXldFUp1UxAS/ENJFthkz8/fQOoDZQRyefbITsxy3N/w+TahaEGjhEwrhhl3AnFodsct
 LgNRACrx+aLLXEyTPg/O8UR1fTXnGgO8O2T+WqAXkcurOc1lGd15O+RycS6NKrmclXIN7
 nl7qgNBS/yibNZ15AqPvY8CAAfC8Gh9mYPAFtYFE50yPCsqa8NDxtdK8UEG/5FyT/hQ0v
 /zovC/jXjSvWqvT/FzOYCxm1CYh9Yb6NSkGpcB8VbEBQVF8G0gs0LCyk6MU+m9alrfpKJ
 ZLBVJHxfl6zbNVlQSEUB/Ds0q0tcZByLqyUjD7tlqIK/jOnfJaydIP+VQrW3BP8I8RA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hrcuuFr4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hrcuuFr4
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84A6880F20
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:16 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4c112aaaee4so74597b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070595; x=1789675395;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MKUub4TyUHJqzJ0ddOIRoqHTuWHu/O9qU1qU4XoAdFk=;
 b=hrcuuFr4RQWnNnaW0WfYwvnNvReZYyr5TC5a2R/tYuYhupjEpG+IPz3L0s4E1tTiU+
 pxIMKo8HaWFbw8x5jyuIRpFdQMTAgxnhJFzKgTOaE2aweBZKuy3aljP39SLkthDKHQeD
 iEzHvrn+3/uLJBvZ5kR8Cj+g85dI/8GtwUf5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070595; x=1789675395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MKUub4TyUHJqzJ0ddOIRoqHTuWHu/O9qU1qU4XoAdFk=;
 b=O0bVAfxQPTcSVaegeYqkpLe/+o1Gio+fc8n/FwPHsfkmAU9WaSQuk9nXAicAWzM1m2
 iwQeVTi1qaTjXE+g36t53fwRfum75noqOwf/whuxdvoeOq2zjpCr9zGPCHZFJjyPcHWI
 o06HXjvVpzqFkUsLcLvgnokzD45EqjIVm4mx5kaRLnQbavhmvjjZHQMpCdjKT1xpFFWO
 e4MIRk1FhdprLx4hNaEqGFL+u2Z+xo2/3l7iUxc2dNo4OeHq2cj3oswgbTOH6AyEJAI5
 xqLjaSOVI6i3cWwXdrn5Nvfzf2p5/X4EErmz3KOugb+9H47k9RlK15sGJhNlAzSM1mpf
 NMdw==
X-Gm-Message-State: AFuF++k+I54VU0YmNAUjCpQCVPLzxzYTEmwk2ShA4ZNretqU//XlutKc
 Sk+sd9pobxJEwbEvp2DTs7Q97EI8THuPJzRwc66yq4wdFgTK3cWNQXfKlHGICZL+0j8vAr1mEMa
 LdTetU7EOIeOGUfQ=
X-Gm-Gg: AYBFou3aSCUQlHDQtdHU+yqLdif8509ys5R1MiiNzEKgrWnwZP8TEFj/a23FRIzJEsc
 SzYnDgUZOTEVx+k4X89aB7hpmCY/1dJQqacJ0rhaork2jGYasRIc08UDZTM4vPsEIl0eHUTcm96
 iw5Wp9NgHADFEDAmTKyNdkufrKpPPTt1G5lecaTayuySpKlma0SJU/foSKZttfYlmRifbhZnPU0
 bASFyWF2tKmTQDD3VRBT2Js4d0YlKoReEbXIRINAe5Wo0RqLLc6+9N2ZUAyriLR1DSGz6HpSXMO
 yPuLm6kH9rWJERJLYI7WVO/Tf9FZuMkah21+QJkk7wVrQig2/cgqEqwYxBNjOui1UMi4Fn0q82i
 IF28wvHOwX/x1rahIjKrsjmYsHDOyMp0E3heP+IE/XyysQLBM153zxgTBARqLxcKZ5JjKvPX/8I
 haDfgFTnFCASzhLXyvcoH2pydcnRnFOEpp+VmVG+X6vm5T6DuDz5l+T3OncPKcsj3JzFl2Y/LHW
 BtiSkntoHdSv0564sdpIo0Rp4jedud159o3Gc8R4duFGIhDx2kX0Hjb9O0HuCK6oVA5O3/Bv4/h
 LjE4xh1S0U4weRcxss+oVwhl3uoatJO/2YQ+MbgZf59Y
X-Received: by 2002:a05:6808:678b:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-4c319e4beaamr463682b6e.15.1789070595086; 
 Thu, 10 Sep 2026 13:03:15 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 2/7] MAINTAINERS: tegra: Update and correct entries
Date: Thu, 10 Sep 2026 14:03:04 -0600
Message-ID: <20260910200310.3503830-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
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
platforms. Furthermore, correct some platform MAINTAINERS files that other
obvious issues (such as .dtb rather than .dts in listings).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Per Svyatoslav, drop adding include/configs/tegra.h to the board/
  MAINTAINERS files.

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
 board/avionic-design/medcom-wide/MAINTAINERS | 1 -
 board/avionic-design/plutux/MAINTAINERS      | 1 -
 board/avionic-design/tec-ng/MAINTAINERS      | 1 -
 board/avionic-design/tec/MAINTAINERS         | 1 -
 board/cei/cei-tk1-som/MAINTAINERS            | 1 -
 board/compal/paz00/MAINTAINERS               | 1 -
 board/compulab/trimslice/MAINTAINERS         | 1 -
 board/htc/endeavoru/MAINTAINERS              | 1 -
 board/lenovo/ideapad-yoga-11/MAINTAINERS     | 1 -
 board/lg/x3-t30/MAINTAINERS                  | 1 -
 board/microsoft/surface-rt/MAINTAINERS       | 1 -
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
 board/ouya/ouya/MAINTAINERS                  | 1 -
 board/toradex/apalis-tk1/MAINTAINERS         | 2 +-
 board/toradex/apalis_t30/MAINTAINERS         | 3 +--
 board/toradex/colibri_t20/MAINTAINERS        | 3 +--
 board/toradex/colibri_t30/MAINTAINERS        | 3 +--
 board/wexler/qc750/MAINTAINERS               | 1 -
 board/xiaomi/mocha/MAINTAINERS               | 1 -
 39 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9ccca5ca44..341c308e3efc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,11 +671,7 @@ M:	Thierry Reding <treding@nvidia.com>
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
index 3d2cdeca7259..c0f75035be9f 100644
--- a/board/avionic-design/medcom-wide/MAINTAINERS
+++ b/board/avionic-design/medcom-wide/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/medcom-wide/
 F:	board/avionic-design/common/
-F:	include/configs/medcom-wide.h
 F:	configs/medcom-wide_defconfig
diff --git a/board/avionic-design/plutux/MAINTAINERS b/board/avionic-design/plutux/MAINTAINERS
index 0275680d21f2..0b76fd5348cf 100644
--- a/board/avionic-design/plutux/MAINTAINERS
+++ b/board/avionic-design/plutux/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/plutux/
 F:	board/avionic-design/common/
-F:	include/configs/plutux.h
 F:	configs/plutux_defconfig
diff --git a/board/avionic-design/tec-ng/MAINTAINERS b/board/avionic-design/tec-ng/MAINTAINERS
index 645be8186aa6..36bd28b7cd90 100644
--- a/board/avionic-design/tec-ng/MAINTAINERS
+++ b/board/avionic-design/tec-ng/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec-ng/
 F:	board/avionic-design/common/
-F:	include/configs/tec-ng.h
 F:	configs/tec-ng_defconfig
diff --git a/board/avionic-design/tec/MAINTAINERS b/board/avionic-design/tec/MAINTAINERS
index 36088e7daccf..b1fa0eff7755 100644
--- a/board/avionic-design/tec/MAINTAINERS
+++ b/board/avionic-design/tec/MAINTAINERS
@@ -3,5 +3,4 @@ M:	Alban Bedel <alban.bedel@avionic-design.de>
 S:	Maintained
 F:	board/avionic-design/tec/
 F:	board/avionic-design/common/
-F:	include/configs/tec.h
 F:	configs/tec_defconfig
diff --git a/board/cei/cei-tk1-som/MAINTAINERS b/board/cei/cei-tk1-som/MAINTAINERS
index f1817401a5df..20affd32d424 100644
--- a/board/cei/cei-tk1-som/MAINTAINERS
+++ b/board/cei/cei-tk1-som/MAINTAINERS
@@ -2,5 +2,4 @@ TK1-SOM BOARD
 M:	Peter.Chubb@data61.csiro.au
 S:	Maintained
 F:	board/cei/cei-tk1-som/
-F:	include/configs/cei-tk1-som.h
 F:	configs/cei-tk1-som_defconfig
diff --git a/board/compal/paz00/MAINTAINERS b/board/compal/paz00/MAINTAINERS
index ba174cd190db..477ef604a82e 100644
--- a/board/compal/paz00/MAINTAINERS
+++ b/board/compal/paz00/MAINTAINERS
@@ -2,5 +2,4 @@ PAZ00 BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compal/paz00/
-F:	include/configs/paz00.h
 F:	configs/paz00_defconfig
diff --git a/board/compulab/trimslice/MAINTAINERS b/board/compulab/trimslice/MAINTAINERS
index 4eb868c0c838..da557f8e1083 100644
--- a/board/compulab/trimslice/MAINTAINERS
+++ b/board/compulab/trimslice/MAINTAINERS
@@ -2,5 +2,4 @@ TRIMSLICE BOARD
 M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/compulab/trimslice/
-F:	include/configs/trimslice.h
 F:	configs/trimslice_defconfig
diff --git a/board/htc/endeavoru/MAINTAINERS b/board/htc/endeavoru/MAINTAINERS
index 85f439f4672e..7ad66e37914a 100644
--- a/board/htc/endeavoru/MAINTAINERS
+++ b/board/htc/endeavoru/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/htc/endeavoru/
 F:	configs/endeavoru_defconfig
 F:	doc/board/htc/endeavoru.rst
-F:	include/configs/endeavoru.h
diff --git a/board/lenovo/ideapad-yoga-11/MAINTAINERS b/board/lenovo/ideapad-yoga-11/MAINTAINERS
index 77e82534a95c..c65bf943c2a6 100644
--- a/board/lenovo/ideapad-yoga-11/MAINTAINERS
+++ b/board/lenovo/ideapad-yoga-11/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/lenovo/ideapad-yoga-11/
 F:	configs/ideapad-yoga-11_defconfig
 F:	doc/board/lenovo/ideapad-yoga-11.rst
-F:	include/configs/ideapad-yoga-11.h
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
index 13c8588d0b92..55cac0ba2833 100644
--- a/board/lg/x3-t30/MAINTAINERS
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/lg/x3-t30/
 F:	configs/x3_t30_defconfig
 F:	doc/board/lg/x3_t30.rst
-F:	include/configs/x3-t30.h
diff --git a/board/microsoft/surface-rt/MAINTAINERS b/board/microsoft/surface-rt/MAINTAINERS
index 1bbd896de928..8c55978f6965 100644
--- a/board/microsoft/surface-rt/MAINTAINERS
+++ b/board/microsoft/surface-rt/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/microsoft/surface-rt/
 F:	configs/surface-rt_defconfig
 F:	doc/board/microsoft/surface-rt.rst
-F:	include/configs/surface-rt.h
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
index 7f664b2e65ff..6cac853823dc 100644
--- a/board/ouya/ouya/MAINTAINERS
+++ b/board/ouya/ouya/MAINTAINERS
@@ -5,4 +5,3 @@ S:	Maintained
 F:	board/ouya/ouya/
 F:	configs/ouya_defconfig
 F:	doc/board/ouya/ouya.rst
-F:	include/configs/ouya.h
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
index 368decf66744..a5db24f0036b 100644
--- a/board/toradex/apalis_t30/MAINTAINERS
+++ b/board/toradex/apalis_t30/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/apalis_t30/
 F:	board/toradex/common/
-F:	include/configs/apalis_t30.h
 F:	configs/apalis_t30_defconfig
-F:	arch/arm/dts/tegra30-apalis.dtb
+F:	arch/arm/dts/tegra30-apalis.dts
diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibri_t20/MAINTAINERS
index 58842434024f..1a86230a0c1e 100644
--- a/board/toradex/colibri_t20/MAINTAINERS
+++ b/board/toradex/colibri_t20/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t20/
 F:	board/toradex/common/
-F:	include/configs/colibri_t20.h
 F:	configs/colibri_t20_defconfig
-F:	arch/arm/dts/tegra20-colibri.dtb
+F:	arch/arm/dts/tegra20-colibri.dts
diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibri_t30/MAINTAINERS
index 73859fd25c2e..026ea0a3b3a1 100644
--- a/board/toradex/colibri_t30/MAINTAINERS
+++ b/board/toradex/colibri_t30/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t30/
 F:	board/toradex/common/
-F:	include/configs/colibri_t30.h
 F:	configs/colibri_t30_defconfig
-F:	arch/arm/dts/tegra30-colibri.dtb
+F:	arch/arm/dts/tegra30-colibri.dts
diff --git a/board/wexler/qc750/MAINTAINERS b/board/wexler/qc750/MAINTAINERS
index 017f6f2b707e..7922514c5d75 100644
--- a/board/wexler/qc750/MAINTAINERS
+++ b/board/wexler/qc750/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	board/wexler/qc750/
 F:	configs/qc750_defconfig
 F:	doc/board/wexler/qc750.rst
-F:	include/configs/qc750.h
diff --git a/board/xiaomi/mocha/MAINTAINERS b/board/xiaomi/mocha/MAINTAINERS
index c3871a15a35b..90215d1325a4 100644
--- a/board/xiaomi/mocha/MAINTAINERS
+++ b/board/xiaomi/mocha/MAINTAINERS
@@ -5,4 +5,3 @@ F:	arch/arm/dts/tegra124-xiaomi-mocha.dts
 F:	board/xiaomi/mocha/
 F:	configs/mocha_defconfig
 F:	doc/board/xiaomi/mocha.rst
-F:	include/configs/mocha.h
-- 
2.43.0

