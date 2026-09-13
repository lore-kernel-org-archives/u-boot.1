Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2BCC88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 04:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D48D6063F;
	Sun, 13 Sep 2026 04:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVj4L0F8BBUP; Sun, 13 Sep 2026 04:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DFDDA60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789273416;
	b=TGvWhVpRHO/Ui+4K0DtvdSqSRmz2xgnPQ7d4X8hIiDwE9ToE/BE4txcW07nFtHTHsiCu
	 D/RldzZA/oKEKNPfw+TuTzetBYucY127484Jcx9jMFB4pxSxlT6bLqt0R7hP+sR1Zxw9W
	 O4fdiBdnGKGe1P+nWnJk1V4VDC/Al5cvAFFbTAGao2BpniVor2IP6y6OhbvILwty8QaBw
	 LOsoKyx5sNWFMiCxXUXETVtvaujNsNlJ5bnvotQDr9p31lusoLPhgBlw+nq9o9352zCg2
	 Wwp+fMcmKD1IT25eDYXhTvuPnhOkREDBLKFenqhSIUDGNzSgAxXN243IPS2oe7YymSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789273416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v5xy1r3la7UYWmo/S+gBHC6hBQ8pfyOuc+oCCKZCxSg=;
	b=U0jP747x+xP0UgxkdDF1VE7qRR6S3Oe25kHsOUH88luiB7BB609FrRGdjKRrbcaNfQcK
	 vWEwP/ZEUjQ/iTLAoDa++saFfxESXsFYWXOtT4SRda1HqZb4Ju51BmtkAWYh1cqBXYcTe
	 C9VOwydZfbrGrSBmLkSk8NXdCqZ+updBA6WhZOpTMiEP3dQhsNhyL7UpW33Mm5stKsoML
	 iWD/wun9EZ5nSE0Z+V3jmvdECZ6FTLhC4YzgB/pcGyzaq0W4jUF36MnDdyIYE1Wf3eNL6
	 1urWNc76rK9RooD5nc3RhlC8GhP5u8DSdmc7N7ZuMkBDZXhejlZ4sDUcjsLY4nViEEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EIiUXrJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789273416;
	bh=v5xy1r3la7UYWmo/S+gBHC6hBQ8pfyOuc+oCCKZCxSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ccbEVNnhql029Jz9h/uUwwVoppw9MmuDW2MHShoTP/vSiQWBb+CySKzbmY1d8kSrc
	 bqsMFiPUIsCo7oHdezBzKCHvjvMQHDqQqBUOS3Ug1E10fShyeWOh0yeAsYsFPoI5KH
	 BEF0rok6bMa/aKZWpwV+dEz9ijLK83KFWs9BfrpX0j8QAGNSiYPhJoVjsJb5sA/nNM
	 53JNlL2op7EtRlByFg0rj6Bh69kNezkjMpVxVg0LYAA+/qOkcs1WlYeHiNqQcIz9M5
	 JpLN/s/M3p5jRoPRPWQh54WSnSN3drYSOeS4dqefRgZaq7vKwsiCOWhX08UEl3FYd8
	 H8sTnVxkY6Nhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFDDA60621;
	Sun, 13 Sep 2026 04:23:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 06C2C109
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0D5B60621
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBMtKezddBY7 for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 04:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2FA560617
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789273412;
 b=o7VQ68uqMuuZvGcqcA2wAp9r79MOXpSl7/Dc8vjtl39fIjZU6fR58nulW4OCboqXamhp
 0lUZGqWXIw0F2qyuyENVBgTXG8qN6dD9nrrz4LxsZLSzrR+4/z1Z6c5nYEr7DCEVrUa+L
 B14c5jORVBUhldLIlnYJzHSseBOwq63Dv2Plm0wm1jT35qlyY5RoDPTcPgCKJafgxznN6
 thNHQxJAs5A8OU/g5AE7HpVVmT1lpNQg4y9qneODoTfoM4Ay8tvusgT5rvIeEPJ4OM+pJ
 SrE+m1e92W9dqiTiSxGwyawxv9vZIZi/LqW6anBsIKbhnh9rctKzdiTqEFTcDQUC6Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789273412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=v5xy1r3la7UYWmo/S+gBHC6hBQ8pfyOuc+oCCKZCxSg=;
 b=ENOIN72YarNxcBuI67hXanUXNAPySOF30TOMpsOW23QK+8Kqlka0B0OLJ8/MMqyIIIYF
 6MsQj43eXkWfkB6Fc2G4yGXZWEbsBXmq64VQPz9MGX87pZj7iwYtcyK17VeFz4c8CRFJ2
 Fdzngf1gL00s57aPRL3VSKMovt0RjPSbB8on7zIEzkLJxqjtsmrGmrLsPhYMAYCrBsO5R
 t+6ZvN8OXnJ+V6KcJ3m/QwPklkJ4wHdCP2kNZH+rK+KonMVpxIQbZjmbtcwLAy2JOilIa
 baxZNEacqUJ4HPfzX4quYFtLiA6I+1yp4lINz3SjQbKxZCUGbOpg6EPruVdBHByYgVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=EIiUXrJH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=EIiUXrJH
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2FA560617
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:32 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so3314025ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789273412; x=1789878212;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v5xy1r3la7UYWmo/S+gBHC6hBQ8pfyOuc+oCCKZCxSg=;
 b=EIiUXrJHJHLa6gmS65wECaA1Hpwyp+/wdnCT7b58RdMlfydyWLrQTOg+CEK9jt57wi
 QmElM8A2NFqDQIeCRWjHO8rikEBqmRIn5wunIOKfIMXhTcZ0JiGANm/ZpjGRsNVEP47e
 vu+NFhmL4pO5mrtu1wIZYb5MY8/4vgD0PKsOPoaI99HiDcLZK4saf49hU1UrC37U4ZVp
 S0+u87uIG+VG6Yr4Ija/oueL5gldnpYUTzQMP8pmSCD2uJezIPYofJYlig+ijStl7Rmr
 nLu3Y/GpSulIatUwEqkkkjRfysFRvWBSnH297fA30T/DynwNkhPaRg6gl92HPXkoGwj/
 inkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789273412; x=1789878212;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v5xy1r3la7UYWmo/S+gBHC6hBQ8pfyOuc+oCCKZCxSg=;
 b=tAc4jWnFHUNVwuwwSbTJlQ5t+KX+XSphgE73NujtsmpZ0Li7MwPmUWkNndtDf3fByQ
 xXJ3d2nHQZXMC0z7caMy78QYNpkGXUTuKckkRp6jiMfGkGwq2sE/rATYLp/itJGflcK8
 BNi7Pr1EFuAQCMAmXX30gCcHlPZyxNZdF0KmF1/nUVoUcrpXPKoUk/+VFQ3sozAThzb1
 +jxY5Xq5AvCZEYtgl/wvWPn9FkC/x5YaJOKwdilsI/7mCJzUEZKEb13QR300UKcOoOVA
 ikDT2eF2MCJvP1wWDNSMixsqJOLo9U++uS0dx8qOnpkjXVFFue6a4lhOyvbwjlGF/i/0
 bKHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkD4CdZCSU6ln6RYapj2grSKblfvC4PTUc2pzc4cFBXf0n2gLTRSfuiU3PJgD59Ggb2R026S0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mdZKm3a6wWDibYdCbZAx+0dekMGrJlRA7SF7y1Vugl1E91mdTV
 VuTTFQAfo3god4urTMCGH0Kl7/mAicWRGZOAYThNYJ2kt+USBhmd0bjIOg8jsaBCpms=
X-Gm-Gg: AYBFou31EXcIeX30Ms3YGXMJHqJIcuM/QsI1D//SAe3HZcDB8KHsFpckBWwepKF0pBK
 yRkQosdjBNVUYbHJpBLZ8OCDIpyLL5XtghqFKroy9Yn/WFGL8LCiyTjdTFujBXTbyhSSZlwYG6x
 ukh4vHlGuM5qcvxqhdVYjWN7L21dmHKwSfIaLLG/h0X/JJERAADpN9KBqVhGbJeVZz1Bw2Tssj5
 ACs/I3P7HSv1aAK1bBmme2UhcmpiY9fy9pUA977RYjZASD4hrJ2cAfIqtExDlM14o3yMV+PVS+r
 fawzvQvsxoBZMEUQTPLMrp8lzTsXDAWgy+15THXZ3VUhjIDRERvKn+BZFHg57xWT2lgpw8EIHOK
 jCPv5oVKnLZAqSnlPZsmE+4RisbjUY1hB2sII08tXmjq00Unv8UPX8/ea8HGm8B3MYI578hTnss
 nYL0y5KkEm/ajlxsA2f5HVYsTrq58ddqgIdWXd64trSqufWJaoAOkE1ZVymJ6Py0HJis7AQTXXL
 jqjFQn4STHSQEfH/F/zrIhCfaB3V8oQG/OfhDJEhhUqSmv/PrgnwxxKrwX78wJupmXiBglfqRTK
 91HSNXsx4rRS/sI0DbaDI1wheDqxjmqCIWdT
X-Received: by 2002:a17:902:d486:b0:2d9:68b7:c324 with SMTP id
 d9443c01a7336-2dd4bc331d4mr88681145ad.3.1789273411952; 
 Sat, 12 Sep 2026 21:23:31 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm19389409eec.15.2026.09.12.21.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 21:23:31 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 13 Sep 2026 12:23:11 +0800
Subject: [PATCH v2 2/4] pci: spacemit: add DesignWare PCIe host controller
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pci-v2-2-4fa1a8b5de06@riscstar.com>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15.2
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

Add PCIe host controller driver for Spacemit K1 SoC using the
Synopsys DesignWare PCIe core. Supports up to 3 ports.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---
v2:
- Locate the phy by index instead.
---
 drivers/pci/Kconfig            |   7 +
 drivers/pci/Makefile           |   1 +
 drivers/pci/pcie_dw_spacemit.c | 391 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_spacemit.h |  78 ++++++++
 4 files changed, 477 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 42edc73bcdaa..86fafc5a3c73 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -498,4 +498,11 @@ config PCIE_DW_IMX
 	  Say Y here if you want to enable DW PCIe controller support on
 	  iMX SoCs.
 
+config PCIE_DW_SPACEMIT
+	bool "Enable Spacemit K1 PCIe"
+	select PCIE_DW_COMMON
+	help
+	  Say Y here if you want to enable PCIe controller support on
+	  K1 SoC.
+
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 3873f357a45f..f839ea1d396f 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
 obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
 obj-$(CONFIG_PCIE_DW_AMD) += pcie_dw_amd.o
 obj-$(CONFIG_PCIE_DW_IMX) += pcie_dw_imx.o
+obj-$(CONFIG_PCIE_DW_SPACEMIT) += pcie_dw_spacemit.o
diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.c
new file mode 100644
index 000000000000..09c56d8a4c4a
--- /dev/null
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Spacemit K1 PCIe host controller driver
+ *
+ * Copyright (c) 2023, Spacemit Corporation.
+ * Copyright (c) 2026, RISCstar Ltd.
+ *
+ */
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm-generic/gpio.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dm/read.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <log.h>
+#include <pci.h>
+#include <power-domain.h>
+#include <reset.h>
+
+#include "pcie_dw_common.h"
+#include "pcie_dw_spacemit.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct pcie_dw_spacemit {
+	/* Must be first member of the struct */
+	struct pcie_dw dw;
+	void __iomem		*apmu_base;
+	u32			apmu_offset;
+	void __iomem		*phy_ahb;	/* DT "link" */
+	int			port_id;
+
+	/* reset, clock resources */
+	struct clk_bulk		clks;
+	struct reset_ctl_bulk	rsts;
+	struct gpio_desc		pwr_on_gpio;
+	int			power_on_status;
+};
+
+static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32 offset)
+{
+	return readl(pcie->apmu_base + pcie->apmu_offset + offset);
+}
+
+static inline void spacemit_pcie_writel(struct pcie_dw_spacemit *pcie,
+					u32 offset, u32 value)
+{
+	writel(value, pcie->apmu_base + pcie->apmu_offset + offset);
+}
+
+static inline u32 spacemit_pcie_phy_ahb_readl(struct pcie_dw_spacemit *pcie, u32 offset)
+{
+	return readl(pcie->phy_ahb + offset);
+}
+
+static void pcie_dw_configure(struct pcie_dw_spacemit *pci, u32 cap_speed)
+{
+	u32 val;
+
+	dw_pcie_dbi_write_enable(&pci->dw, true);
+
+	val = readl(pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
+	val &= ~TARGET_LINK_SPEED_MASK;
+	val |= cap_speed;
+	writel(val, pci->dw.dbi_base + PCIE_LINK_CAPABILITY);
+
+	val = readl(pci->dw.dbi_base + PCIE_LINK_CTL_2);
+	val &= ~TARGET_LINK_SPEED_MASK;
+	val |= cap_speed;
+	writel(val, pci->dw.dbi_base + PCIE_LINK_CTL_2);
+
+	dw_pcie_dbi_write_enable(&pci->dw, false);
+}
+
+static int is_link_up(struct pcie_dw_spacemit *pci)
+{
+	u32 val;
+
+	val = readl(pci->dw.dbi_base + PCIE_PORT_DEBUG0);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
+}
+
+static int wait_link_up(struct pcie_dw_spacemit *pci)
+{
+	unsigned long timeout;
+
+	timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;
+	while (!is_link_up(pci)) {
+		if (get_timer(0) > timeout) {
+			dev_dbg(pci->dw.dev, "LTSSM link training timeout\n");
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+static int pcie_dw_spacemit_pcie_link_up(struct pcie_dw_spacemit *pci, u32 cap_speed)
+{
+	u32 reg;
+
+	if (is_link_up(pci)) {
+		printf("PCI Link already up before configuration!\n");
+		return 1;
+	}
+
+	/* DW pre link configurations */
+	pcie_dw_configure(pci, cap_speed);
+
+	/* Initiate link training */
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg |= LTSSM_EN;
+	reg &= ~APP_HOLD_PHY_RST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	/* Check that link was established */
+	if (!wait_link_up(pci))
+		return 0;
+
+	/*
+	 * Link can be established in Gen 1, still need to wait
+	 * until MAC negotiation is completed
+	 */
+	udelay(100);
+
+	return 1;
+}
+
+static int pcie_set_mode(struct pcie_dw_spacemit *pci,
+			 enum dw_pcie_device_mode mode)
+{
+	u32 reg;
+
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg |= DEVICE_TYPE_RC | PCIE_AUX_PWR_DET;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+		reg = spacemit_pcie_readl(pci, PCIE_CTRL_LOGIC);
+		reg |= PCIE_IGNORE_PERSTN;
+		spacemit_pcie_writel(pci, PCIE_CTRL_LOGIC, reg);
+		break;
+	case DW_PCIE_EP_TYPE:
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg &= ~DEVICE_TYPE_RC;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+		break;
+	default:
+		dev_err(pci->dw.dev, "INVALID device type %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spacemit_pcie_host_init(struct pcie_dw_spacemit *pci)
+{
+	u32 reg;
+
+	mdelay(100);
+	/* set Perst# gpio high state*/
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg &= ~PCIE_RC_PERST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	return 0;
+}
+
+static int pcie_dw_init_id(struct pcie_dw_spacemit *pci)
+{
+	dw_pcie_dbi_write_enable(&pci->dw, true);
+	writew(SPACEMIT_PCIE_VENDOR_ID, pci->dw.dbi_base + PCI_VENDOR_ID);
+	writew(SPACEMIT_PCIE_DEVICE_ID, pci->dw.dbi_base + PCI_DEVICE_ID);
+	dw_pcie_dbi_write_enable(&pci->dw, false);
+
+	return 0;
+}
+
+static int k1x_power_on(struct pcie_dw_spacemit *pci, int on)
+{
+	struct pcie_dw *dwp = &pci->dw;
+	int gpio_val = 0;
+
+	if (on) {
+		if (pci->power_on_status)
+			gpio_val = 1;
+		else
+			gpio_val = 0;
+	} else {
+		if (pci->power_on_status)
+			gpio_val = 0;
+		else
+			gpio_val = 1;
+	}
+
+	if (dm_gpio_is_valid(&pci->pwr_on_gpio)) {
+		dev_info(dwp->dev, "PCIe interface power %s, set gpio %d to %d\n",
+			 on ? "on" : "off", pci->pwr_on_gpio.offset, gpio_val);
+		dm_gpio_set_value(&pci->pwr_on_gpio, gpio_val);
+	}
+
+	return 0;
+}
+
+static int pcie_dw_spacemit_probe(struct udevice *dev)
+{
+	struct pcie_dw_spacemit *pci = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	struct phy phy0 = {0};
+	ofnode port;
+	int ret;
+	u32 reg;
+
+	/* enable pcie clk and deassert resets */
+	clk_enable_bulk(&pci->clks);
+	reset_deassert_bulk(&pci->rsts);
+
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg &= ~LTSSM_EN;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	/* set Perst# (fundamental reset) gpio low state*/
+	reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+	reg |= PCIE_RC_PERST;
+	spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+	/* The PHY is described on the root port child node */
+	port = ofnode_first_subnode(dev_ofnode(dev));
+	if (!ofnode_valid(port)) {
+		dev_err(dev, "failed to find PCIe port node\n");
+		return -ENODEV;
+	}
+
+	ret = generic_phy_get_by_index_nodev(port, 0, &phy0);
+	if (!ret) {
+		reg = spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
+		reg |= DEVICE_TYPE_RC | APP_HOLD_PHY_RST | PCIE_PHY_LANE_CTRL_MASK;
+		reg &= ~GLOBAL_PHY_RST;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+		reg &= ~(u32)APP_HOLD_PHY_RST;
+		spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
+
+		ret = generic_phy_init(&phy0);
+		if (ret) {
+			dev_err(dev, "failed to init PHY: %d\n", ret);
+			return ret;
+		}
+
+		ret = generic_phy_power_on(&phy0);
+		if (ret) {
+			dev_err(dev, "failed to power on PHY: %d\n", ret);
+			return ret;
+		}
+	} else {
+		dev_err(dev, "failed to get pcie-phy: %d\n", ret);
+		return ret;
+	}
+
+	pci->dw.first_busno = dev_seq(dev);
+	pci->dw.dev = dev;
+
+	pcie_set_mode(pci, DW_PCIE_RC_TYPE);
+
+	/* power on the interface */
+	k1x_power_on(pci, 1);
+
+	spacemit_pcie_host_init(pci);
+	pcie_dw_setup_host(&pci->dw);
+	pcie_dw_init_id(pci);
+
+	if (!pcie_dw_spacemit_pcie_link_up(pci, LINK_SPEED_GEN_1)) {
+		printf("PCIE-%d: Link down\n", dev_seq(dev));
+		return -ENODEV;
+	}
+
+	printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
+	       pcie_dw_get_link_speed(&pci->dw),
+	       pcie_dw_get_link_width(&pci->dw),
+	       hose->first_busno);
+
+	ret = pcie_dw_prog_outbound_atu_unroll(&pci->dw, PCIE_ATU_REGION_INDEX0,
+					       PCIE_ATU_TYPE_MEM,
+					       pci->dw.mem.phys_start,
+					       pci->dw.mem.bus_start,
+					       pci->dw.mem.size);
+
+	return 0;
+}
+
+static int pcie_dw_spacemit_of_to_plat(struct udevice *dev)
+{
+	int ret = 0;
+	struct pcie_dw_spacemit *pcie = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	fdt_addr_t dbi_addr;
+
+	/* Get the controller base address */
+	pcie->dw.dbi_base = (void *)dev_read_addr_name(dev, "dbi");
+	if ((fdt_addr_t)pcie->dw.dbi_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	dbi_addr = (fdt_addr_t)pcie->dw.dbi_base;
+
+	/* Get the config space base address and size */
+	pcie->dw.cfg_base = (void *)dev_read_addr_size_name(dev, "config",
+							 &pcie->dw.cfg_size);
+	if ((fdt_addr_t)pcie->dw.cfg_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Get the iATU base address and size */
+	pcie->dw.atu_base = (void *)dev_read_addr_name(dev, "atu");
+	if ((fdt_addr_t)pcie->dw.atu_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Get the PHY AHB base address (called "link" in Linux DTS) */
+	pcie->phy_ahb = (void *)dev_read_addr_name(dev, "link");
+	if ((fdt_addr_t)pcie->phy_ahb == FDT_ADDR_T_NONE) {
+		pcie->phy_ahb = (void *)dev_read_addr_name(dev, "phy_ahb");
+		if ((fdt_addr_t)pcie->phy_ahb == FDT_ADDR_T_NONE)
+			return -EINVAL;
+	}
+
+	/* Get APMU regmap from spacemit,apmu property */
+	ret = dev_read_phandle_with_args(dev, "spacemit,apmu", NULL, 1, 0,
+					 &args);
+	if (ret)
+		return ret;
+
+	pcie->apmu_base = (void __iomem *)ofnode_get_addr(args.node);
+	if (!pcie->apmu_base)
+		return -EINVAL;
+	pcie->apmu_offset = args.args[0];
+
+	/* Derive port ID from DBI base address */
+	pcie->port_id = (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_PCIE_DBI_STRIDE;
+
+	ret = clk_get_bulk(dev, &pcie->clks);
+	if (ret) {
+		dev_warn(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &pcie->rsts);
+	if (ret) {
+		dev_warn(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	gpio_request_by_name(dev, "k1x,pwr_on", 0, &pcie->pwr_on_gpio,
+			     GPIOD_IS_OUT);
+	if (!dm_gpio_is_valid(&pcie->pwr_on_gpio))
+		dev_info(dev, "has no power on gpio.\n");
+
+	ret = dev_read_u32(dev, "power-on-status", &pcie->power_on_status);
+	if (ret) {
+		dev_info(dev, "has no power-on-status flag, use default.\n");
+		pcie->power_on_status = 1;
+	}
+
+	return 0;
+}
+
+static const struct dm_pci_ops pcie_dw_spacemit_ops = {
+	.read_config	= pcie_dw_read_config,
+	.write_config	= pcie_dw_write_config,
+};
+
+static const struct udevice_id pcie_dw_spacemit_ids[] = {
+	{ .compatible = "spacemit,k1-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_dw_spacemit) = {
+	.name			= "pcie_dw_spacemit",
+	.id			= UCLASS_PCI,
+	.of_match		= pcie_dw_spacemit_ids,
+	.ops			= &pcie_dw_spacemit_ops,
+	.of_to_plat	= pcie_dw_spacemit_of_to_plat,
+	.probe			= pcie_dw_spacemit_probe,
+	.priv_auto	= sizeof(struct pcie_dw_spacemit),
+};
diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemit.h
new file mode 100644
index 000000000000..2c17f113b75c
--- /dev/null
+++ b/drivers/pci/pcie_dw_spacemit.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Spacemit K1 DesignWare PCIe host controller driver
+ *
+ * Copyright (c) 2023, Spacemit Corporation.
+ * Copyright (c) 2026, RISCstar Ltd.
+ */
+
+#ifndef _PCIE_DW_SPACEMIT_H_
+#define _PCIE_DW_SPACEMIT_H_
+
+#include <linux/bitops.h>
+
+/* PCIe DW common registers */
+#define PCIE_LINK_CAPABILITY		0x7c
+#define PCIE_LINK_CTL_2			0xa0
+#define TARGET_LINK_SPEED_MASK		0xf
+#define LINK_SPEED_GEN_1		0x1
+#define LINK_SPEED_GEN_2		0x2
+#define LINK_SPEED_GEN_3		0x3
+
+#define PCIE_MISC_CONTROL_1_OFF	0x8bc
+#define PCIE_DBI_RO_WR_EN		BIT(0)
+
+#define PLR_OFFSET			0x700
+#define PCIE_PORT_DEBUG0		(PLR_OFFSET + 0x28)
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_L0	0x11
+
+#define PCIE_LINK_UP_TIMEOUT_MS		1000
+
+/* Vendor and device IDs */
+#define PCIE_VENDORID_MASK		GENMASK(15, 0)
+#define PCIE_DEVICEID_SHIFT		16
+#define SPACEMIT_PCIE_VENDOR_ID		0x201F
+#define SPACEMIT_PCIE_DEVICE_ID		0x0001
+
+/* Application register offsets */
+#define PCIE_CMD_STATUS			0x04
+#define LTSSM_EN_VAL			BIT(0)
+
+/* K1X_CONF_DEVICE_CMD register */
+#define PCIECTRL_K1X_CONF_DEVICE_CMD	0x0000
+#define LTSSM_EN			BIT(6)
+#define PCIE_PERST_IN			BIT(7)
+#define GLOBAL_PHY_RST			BIT(8)
+#define PCIE_AUX_PWR_DET		BIT(9)
+#define PCIE_CLKREQ_IN			BIT(10)	/* read-only: CLKREQ# IO input value */
+#define PCIE_REFCLK_EN			BIT(11)
+#define PCIE_RC_PERST			BIT(12)
+#define PCIE_EP_WAKE			BIT(13)
+#define APP_HOLD_PHY_RST		BIT(30)
+#define DEVICE_TYPE_RC			BIT(31)
+
+/* PCIE_CTRL_LOGIC register */
+#define PCIE_CTRL_LOGIC			0x0004
+#define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_IGNORE_PERSTN		BIT(2)
+
+/* PHY AHB link status */
+#define K1X_PHY_AHB_LINK_STS		0x0004
+#define SMLH_LINK_UP			BIT(1)
+#define RDLH_LINK_UP			BIT(12)
+
+/* PHY lane control mask (bits 0-5 in DEVICE_CMD) */
+#define PCIE_PHY_LANE_CTRL_MASK		0x3f
+
+/* PCIe DBI address calculation */
+#define SPACEMIT_PCIE_DBI_BASE		0xca000000
+#define SPACEMIT_PCIE_DBI_STRIDE	0x400000
+
+enum dw_pcie_device_mode {
+	DW_PCIE_UNKNOWN_TYPE,
+	DW_PCIE_EP_TYPE,
+	DW_PCIE_RC_TYPE,
+};
+
+#endif /* _PCIE_DW_SPACEMIT_H_ */

-- 
2.51.0

