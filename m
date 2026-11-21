Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB689606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uMLVKaGB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doUYTk1b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B81164066F;
	Sat, 21 Nov 2026 19:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kD7vgPBhno1V; Sat, 21 Nov 2026 19:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD46A406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795291117;
	b=s+dmgg3vgyYiVDyRwQ4iGGglOs8brbEQz+rh96yLfIWVHONERQvLkFicZeZK1kpjB8sq
	 lLlBAzwNOcQEqlCEFxldKRU80QQy3+C8UnY2icF1qH3Gdb1Bj0o6JeCV/SQi5a3FVn6ky
	 YLHTZJN804UHHgu+EkRx6RCdP/qhjBpXQ2Jhmkfc5Xlu5cAK6jqz1+1ZoIsF/1CvEd8tH
	 T6Mu9c857xUDkbPEn56EZlukEHnC6sj41vfLQ8ktmZKPpq4gQoWvb1SxoDVR9Px9rxdnv
	 hFOkthPKoHgr5ztSWTX/x20ZQUuVisr1SiGn7wQp7rCXVEiC+BfJyY77BKHUZJ2c+zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795291117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m73v923DV095HZqD7slYkYT7v7jJim3s0XloNg7kOys=;
	b=DC2tj6FXabimAvF3gT2ZgFJC97PG2Ebf7kEzUkOzW4Wkj11I6QQztSA9NyL7RT2HWTUF
	 X2/dqJbhg5RozMVl1jSe/OO7UWrAHWdW+91MLk7EIk8T+6K9jBoeE+tNDEeOBYTPLW1HJ
	 vqvuJCinnBw3Rmvf+s3CDZVYwDygCD9dixviaRCWhuUFr0UScAkYDotdTd8pJURXzaWC5
	 4ukr0L67c2XNTJRFSDqhB/73oZucRfNG8Mocg45o/9UXU6+Be0DDPwVUN4ln6jHgUncFL
	 vz2DlF4dwNd73dHuQmhu5oZn82+ifVIcsozK/lh8EZdP6kEM1+V0QCgDqBhvOSIgjkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doUYTk1b;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795291117;
	bh=m73v923DV095HZqD7slYkYT7v7jJim3s0XloNg7kOys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uMLVKaGBJPwSpEJ9DLky1PqNB9L3RHuaIZfr7EXvH2oZBLz7SEX0fli6jNcFJtwdZ
	 VGApMc+P+big0B8o/iLrlsVpBVTPHQYFTRjcWZXrcwiBBlpXoI9gqXjKevdix2Is5Y
	 uXF/cXk47Sv6bk+bMx256H8A7sQeiFulLK3BRrWgcGJy9gfq1+vmtnotLtwCcrJB7u
	 rGYqQVHyeZ0JLEZxLh1U7vuGy3O+LZeSERFHRRMt3Zd+Y9Vxj8mMtiTRXa3uYhUFDg
	 g+VWv5BRjnuwTTFXojE+4tUfmqNrBDOEImnVlnivhbQahO7x8Z9YwmuujeB95ZQt37
	 b2DwSINHoJWxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD46A406D8;
	Sat, 21 Nov 2026 19:58:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B38759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1245640718
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txJLtPQimmRM for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 18:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 468E140715
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=thallescampagnani@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=doUYTk1b
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 468E140715
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 18:58:09 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-38692f62b22so2779644eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795287489; x=1795892289;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m73v923DV095HZqD7slYkYT7v7jJim3s0XloNg7kOys=;
 b=doUYTk1b1puus1P+W8Q2beUUZNY9ZLd8CAeDX9KVgpVH++yT22GZOwbwPrLKsTJT3/
 /1vi7Kv6L16FbWQnxqnis7+0yIDa5FGjCoSvn4BNSryi6eo6n/+VsH22OVXSqtU603df
 KiBepWNQzFkSXlVNYIgwbtS339DWfa0SOJQBpKqxRxxGbPfS7amV0jZCZ9kk4krNBwqK
 zxbLwirTrXd3IGBAzmAhzXPVIPk+9htNpl8J+hN+NR1WC7Td7AfAxaI6ZZ7ogqMR+iEP
 DF+VQb0nyZO6kbYCP8Xg0qka0BR5z6qvF9dwprVoOz8/22W1WCZanPdPHlph99qEvWi/
 ckVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795287489; x=1795892289;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m73v923DV095HZqD7slYkYT7v7jJim3s0XloNg7kOys=;
 b=xbr/cEeC0g+wItz06lb/aIEnovrJJ65J71p+0SXNwDJFOHbJ6DBcMI2aAKRuC+RPYw
 5Lh85M5yODTBNQuVYuM3EnrTBc3WRZt2V4jgB61pwwMeOfTOQQvVP4imrxQ0E8IeyKmc
 Sxx3Z/SGMEpz/0G6kNzHC70yqqfJkng6vFuHqEXl/pcf8IYxyNDJFa0Im0GOZovG8F25
 mMTs+7nWrvSE2GbRzXWB4IVqB4i/7bQTghjog/7nFvLONmZtJ915bNZeEMiQJqvNN13o
 V73YWhLYJqb06hYpk0i0eE+cwJjb+lhCTNhMEbO363vfCbWiD2sKY2H07sqFXFL+TT2j
 8btg==
X-Gm-Message-State: APuU4Z9AQBrXRZ//J+QWOhpETJRZFnXrmXDpp+/IpaflkaQ/Ovi4jYGo
 ftTNk65J8YEBz3t1h069T9nxLbckO3xOsxv5sl6DRqIFZTKVJuAIReY2dyxuUfXN
X-Gm-Gg: AZFdTZcneV9iEcY6e6xFZaEYEpPUw5riagFQ3nZELRtzaiR2mEL9zeyICG6WSypc2pL
 +iNOy6452yNV5Ke0e8F1Ifsl6P5VEtrMrCfBwVeds2st4VjtxteogVK2aSHdrYJokH6RtvdgG4B
 GKkfHMjpoHqSJpA8nSHKZ6juvCcZUyJ4eja0y9H+LehD1cZA6petkbKLmAGa0DfbpBni24ETCQ7
 hrhAhpoij4mUW4eEhrFcNd+aaynAXuT7P0aI4+YcbG33vCxuwDJ4pW7nOZAT8pMzzOlQftzjHOO
 ST2rxaxJDUi/DCGPwrsaKXToxR+eibBFZw4qcUb7/eSSrs0vEeDDY5J4hd/qUohNttofJeGmAis
 bL+rU3tulDqDAsKwUC0S0T9rVAOYCtTW4geZSwVkNaTMQZhI6u3jVg8YJ5ci+IM/o4q+CjdcRJ7
 t7mG7r8n71SH6BPlJorlTEpxKiQ9ssAdp2BYqTAnl7fbGfDVuJ3hNzt42RVVwvBgc+2HduQ4E/8
 PqXpsS/V5K9atPHK8T87NsnSap6x2AAHybntj4hfOqELIv87DUdd/NiCsBlQxIhnyERMfHu/ISr
 tSLtDsRwvNuEll0rCUBwKheN85YnkzMX
X-Received: by 2002:a05:693c:88d8:b0:386:954f:7c18 with SMTP id
 5a478bee46e88-386954f7cf0mr4300518eec.31.1795287487290; 
 Sat, 21 Nov 2026 10:58:07 -0800 (PST)
Received: from qqlt ([2804:14c:5b81:8b94:5fa9:2af4:7818:7c81])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm20383004eec.12.2026.11.21.10.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 10:58:06 -0800 (PST)
From: Thalles Campagnani <thallescampagnani@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Thalles Campagnani <thallescampagnani@gmail.com>
Subject: [RFC PATCH 1/3] ram: spacemit: add K1 DDR init native driver
Date: Sat, 21 Nov 2026 15:57:36 -0300
Message-ID: <20261121185739.531651-2-thallescampagnani@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121185739.531651-1-thallescampagnani@gmail.com>
References: <20261121185739.531651-1-thallescampagnani@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 19:58:34 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a clean-room, GPL-2.0-or-later LPDDR4/4X DDR controller and PHY
initialization driver for the SpacemiT K1 SoC in SPL, replacing the
need for the external proprietary ddr_fw.bin blob.

The driver brings up PLL1/PLL2, runs MC/PHY Device_Init, detects
x8/x16 geometry and density via MR8, programs the address map and
hardware DFC table, performs PI write-leveling/read-gate plus
independent memory-pattern Vref and per-DQ eye centering across all
frequency points, and supports automatic rate fallback
(2666->2400->1066, 2133/1333->1200->1066, 2400/1200->1066).

Tested on Banana Pi BPI-F3 (8 GiB Samsung LPDDR4X and 16 GiB Micron
LPDDR4X) across 1066..2666 MT/s, including multi-core Linux 6.6.63
memory soaks up to 8 GiB with 0 errors. LPDDR4 (non-X) and native
single-rank x16 paths are enabled but untested on silicon.

Signed-off-by: Thalles Campagnani <thallescampagnani@gmail.com>
---
 board/spacemit/k1/MAINTAINERS        |   2 +
 drivers/Makefile                     |   1 +
 drivers/ram/Kconfig                  |   1 +
 drivers/ram/Makefile                 |   1 +
 drivers/ram/spacemit/Kconfig         |  10 +
 drivers/ram/spacemit/Makefile        |  10 +
 drivers/ram/spacemit/k1_ddr_boot.c   | 300 +++++++++++++
 drivers/ram/spacemit/k1_ddr_boot.h   | 116 +++++
 drivers/ram/spacemit/k1_ddr_eye.c    | 438 +++++++++++++++++++
 drivers/ram/spacemit/k1_ddr_eye.h    |  32 ++
 drivers/ram/spacemit/k1_ddr_init.c   | 617 ++++++++++++++++++++++++++
 drivers/ram/spacemit/k1_ddr_init.h   |  62 +++
 drivers/ram/spacemit/k1_ddr_spl.c    | 117 +++++
 drivers/ram/spacemit/k1_ddr_tables.c | 213 +++++++++
 drivers/ram/spacemit/k1_ddr_tables.h |  86 ++++
 drivers/ram/spacemit/k1_ddrt.c       | 627 +++++++++++++++++++++++++++
 drivers/ram/spacemit/k1_ddrt.h       | 116 +++++
 drivers/ram/spacemit/k1_ddrt_io.h    |  41 ++
 drivers/ram/spacemit/k1_ddrt_priv.h  |  25 ++
 drivers/ram/spacemit/k1_ddrt_regs.h  | 277 ++++++++++++
 include/spacemit/k1_ddr.h            |  22 +
 21 files changed, 3114 insertions(+)
 create mode 100644 drivers/ram/spacemit/Kconfig
 create mode 100644 drivers/ram/spacemit/Makefile
 create mode 100644 drivers/ram/spacemit/k1_ddr_boot.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_boot.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_eye.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_eye.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_init.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_init.h
 create mode 100644 drivers/ram/spacemit/k1_ddr_spl.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_tables.c
 create mode 100644 drivers/ram/spacemit/k1_ddr_tables.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt.c
 create mode 100644 drivers/ram/spacemit/k1_ddrt.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_io.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_priv.h
 create mode 100644 drivers/ram/spacemit/k1_ddrt_regs.h
 create mode 100644 include/spacemit/k1_ddr.h

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index c1d6b8f3a1c..f0819ed60b8 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -14,3 +14,5 @@ F:	drivers/pci/pcie_dw_spacemit.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
+F:	drivers/ram/spacemit/
+F:	include/spacemit/k1_ddr.h
diff --git a/drivers/Makefile b/drivers/Makefile
index ff6853b06a2..af6606aac84 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_ARCH_IMX8M) += ddr/imx/imx8m/
 obj-$(CONFIG_IMX8ULP_DRAM) += ddr/imx/imx8ulp/
 obj-$(CONFIG_ARCH_IMX9) += ddr/imx/imx9/
 obj-$(CONFIG_DRAM_SUN20I_D1) += ram/
+obj-$(CONFIG_SPL_SPACEMIT_K1_DDR) += ram/
 obj-$(CONFIG_SPL_DM_RESET) += reset/
 obj-$(CONFIG_SPL_MUSB_NEW) += usb/musb-new/
 obj-$(CONFIG_SPL_USB_GADGET) += usb/gadget/
diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index acd6d9cfd6a..d3a4c6f8d27 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -145,6 +145,7 @@ source "drivers/ram/octeon/Kconfig"
 source "drivers/ram/renesas/Kconfig"
 source "drivers/ram/rockchip/Kconfig"
 source "drivers/ram/sifive/Kconfig"
+source "drivers/ram/spacemit/Kconfig"
 source "drivers/ram/stm32mp1/Kconfig"
 source "drivers/ram/starfive/Kconfig"
 source "drivers/ram/sunxi/Kconfig"
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index 82afd5fcbcc..54710b6c89a 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -32,5 +32,6 @@ obj-$(CONFIG_ARCH_RENESAS) += renesas/
 obj-$(CONFIG_CADENCE_DDR_CTRL) += cadence/
 
 ifdef CONFIG_XPL_BUILD
+obj-$(CONFIG_SPL_SPACEMIT_K1_DDR) += spacemit/
 obj-$(CONFIG_SPL_THEAD_TH1520_DDR) += thead/
 endif
diff --git a/drivers/ram/spacemit/Kconfig b/drivers/ram/spacemit/Kconfig
new file mode 100644
index 00000000000..3e0e1737c70
--- /dev/null
+++ b/drivers/ram/spacemit/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config SPL_SPACEMIT_K1_DDR
+	bool "SpacemiT K1 LPDDR4/4X DDR driver in SPL"
+	depends on SPACEMIT_K1 && SPL
+	help
+	  Enable the native open-source LPDDR4/4X DDR controller and PHY
+	  initialization driver in SPL for the SpacemiT K1 SoC, replacing
+	  the external proprietary ddr_fw.bin blob.
+
diff --git a/drivers/ram/spacemit/Makefile b/drivers/ram/spacemit/Makefile
new file mode 100644
index 00000000000..e96d49d36c8
--- /dev/null
+++ b/drivers/ram/spacemit/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_SPL_SPACEMIT_K1_DDR) += \
+	k1_ddr_tables.o \
+	k1_ddr_init.o \
+	k1_ddrt.o \
+	k1_ddr_eye.o \
+	k1_ddr_boot.o \
+	k1_ddr_spl.o
+
diff --git a/drivers/ram/spacemit/k1_ddr_boot.c b/drivers/ram/spacemit/k1_ddr_boot.c
new file mode 100644
index 00000000000..f5ba6c5cc3c
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_boot.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 LPDDR4X boot sequence (doc 31): which passes run, at which
+ * frequency point, and when the controller is re-initialised for x8 dies.
+ */
+#include "k1_ddr_boot.h"
+#include "k1_ddr_init.h"
+#include "k1_ddrt_io.h"
+#include "k1_ddrt_priv.h"
+#include "k1_ddrt_regs.h"
+
+struct k1_boot {
+	const struct k1_ddr_boot_cfg *cfg;
+	const struct k1_ddrt_env *env;
+	struct k1_ddr_boot_report *rep;
+	struct k1_ddr_hw hw;
+	u64 t0;
+	bool mc_clocked;	/* MC reads are safe only once SW-FC and MCK are done */
+};
+
+const char *k1_ddr_step_name(enum k1_ddr_step step)
+{
+	switch (step) {
+	case K1_STEP_NONE:	return "none";
+	case K1_STEP_ARGS:	return "args";
+	case K1_STEP_PLL:	return "pll-lock";
+	case K1_STEP_SWFC:	return "sw-fc";
+	case K1_STEP_MC:	return "mc-program";
+	case K1_STEP_DFI_INIT:	return "dfi-init";
+	case K1_STEP_DRAM_INIT:	return "dram-init";
+	case K1_STEP_TRAIN:	return "training";
+	case K1_STEP_MR_READ:	return "mr-read";
+	case K1_STEP_MAP:	return "address-map";
+	case K1_STEP_DFC:	return "dfc";
+	}
+	return "?";
+}
+
+u32 k1_ddr_final_fp(enum k1_ddr_type type, u32 data_rate)
+{
+	switch (data_rate) {
+	case 1066:
+		return 1;
+	case 2133:
+		return type == K1_DDR_LPDDR4 ? 3 : 0;
+	case 2400:
+	case 2666:
+		return 2;
+	case 1333:	/* same fp0 bank as 1200; PLL1 uses the 2666 VCO */
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+u32 k1_ddr_dfc_plan(enum k1_ddr_type type, u8 fps[3])
+{
+	u32 n = 0;
+
+	fps[n++] = 1;
+	if (type == K1_DDR_LPDDR4)
+		fps[n++] = 3;
+	fps[n++] = 2;
+	return n;
+}
+
+u32 k1_ddr_fallback_rate(u32 data_rate)
+{
+	switch (data_rate) {
+	case 2666:
+		return 2400;
+	case 2133:
+	case 1333:
+		return 1200;
+	case 2400:
+	case 1200:
+		return 1066;
+	default:
+		return 0;
+	}
+}
+
+bool k1_ddr_can_fallback(int rc, enum k1_ddr_step step)
+{
+	if (!rc)
+		return false;
+	if (rc == K1_DDRT_EINVAL || rc == K1_DDRT_ENOSYS)
+		return false;
+	if (rc == K1_DDRT_ETIMEDOUT &&
+	    (step == K1_STEP_PLL || step == K1_STEP_SWFC ||
+	     step == K1_STEP_ARGS))
+		return false;
+	return true;
+}
+
+static int k1_boot_end(struct k1_boot *b, int rc, enum k1_ddr_step step)
+{
+	struct k1_ddr_boot_report *rep = b->rep;
+
+	rep->rc = rc;
+	rep->fail_step = rc ? step : K1_STEP_NONE;
+	if (b->hw.pmu)
+		rep->clksel = k1_r32(b->hw.pmu + K1_PMU_CLKSEL);
+	if (b->mc_clocked) {
+		rep->status = k1_r32(b->hw.ddr + K1_MC_STATUS);
+		rep->ctl_freq = k1_r32(b->hw.ddr + K1_MC_FREQ);
+	}
+	rep->total_us = (u32)(k1_now(b->env) - b->t0);
+	if (rc)
+		k1_log(b->env, "k1-ddr: %s failed, rc %d\n",
+		       k1_ddr_step_name(step), rc);
+	return rc;
+}
+
+static int k1_boot_pass(struct k1_boot *b, u32 pp)
+{
+	const struct k1_ddrt_cfg tc = {
+		.ddr = b->hw.ddr,
+		.cs_num = b->hw.cs_num,
+		.boot_pp = pp,
+	};
+	struct k1_ddr_boot_report *rep = b->rep;
+	struct k1_ddrt_result res;
+	int rc = k1_ddrt_train_pass(&tc, b->env, &res);
+
+	if (rep->n_pass < ARRAY_SIZE(rep->pass))
+		rep->pass[rep->n_pass++] = (struct k1_ddr_pass_summary){
+			.rc = rc,
+			.boot_pp = (u8)pp,
+			.rx_vref_idx = res.rx_vref_idx,
+			.tx_vref_dq = res.tx_vref_dq,
+			.fail_stage = res.fail_stage,
+			.phy_status = res.phy_status,
+			.gate_cs0_b0 = res.gate[0][0],
+		};
+	if (b->cfg->on_pass) {
+		const int orc = b->cfg->on_pass(b->cfg->pass_ctx, &res, pp);
+
+		if (!rc)
+			rc = orc;
+	}
+	return rc;
+}
+
+static int k1_boot_dfc(struct k1_boot *b, u32 fp)
+{
+	const struct k1_ddrt_cfg mc = {
+		.ddr = b->hw.ddr,
+		.cs_num = b->hw.cs_num,
+	};
+	const int rc = k1_ddr_dfc(&b->hw, fp);
+	u8 discard = 0;
+
+	if (rc)
+		return rc;
+	/* doc 08 (P-19): the first MRR after a HW-DFC may read 0, whatever the MR */
+	if (k1_ddrt_mr_read(&mc, b->env, 0, 0, 14, &discard))
+		discard = 0;
+	/* the engine re-sends MR14 from the new bank: a cheap check that it ran */
+	if (k1_ddrt_check_mr14(&mc, b->env))
+		k1_log(b->env, "k1-ddr: warning: MR14 differs from the fp%u bank\n",
+		       fp);
+	return rc;
+}
+
+int k1_ddr_boot(const struct k1_ddr_boot_cfg *cfg,
+		const struct k1_ddrt_env *env,
+		struct k1_ddr_boot_report *rep)
+{
+	struct k1_boot b = { .cfg = cfg, .env = env, .rep = rep };
+	enum k1_ddr_step step = K1_STEP_NONE;
+	struct k1_ddr_geom g;
+	u8 fps[3];
+	u32 n;
+	int rc;
+
+	if (!rep)
+		return K1_DDRT_EINVAL;
+	*rep = (struct k1_ddr_boot_report){};
+	if (!cfg || !cfg->ddr || !cfg->pmu || !cfg->dfc_win || cfg->cs_num < 1 ||
+	    cfg->cs_num > K1_MAX_CS || !env || !env->now_us)
+		return k1_boot_end(&b, K1_DDRT_EINVAL, K1_STEP_ARGS);
+	b.t0 = k1_now(env);
+
+	b.hw = k1_ddr_hw_init(cfg, env);
+	rep->final_pp = (u8)k1_ddr_final_fp(cfg->type, cfg->data_rate);
+	k1_log(env, "k1-ddr: %s, cs_num %u, %u MT/s, final fp%u\n",
+	       cfg->type == K1_DDR_LPDDR4 ? "LPDDR4" : "LPDDR4X",
+	       cfg->cs_num, cfg->data_rate, rep->final_pp);
+
+	rc = k1_ddr_pll_init(&b.hw, cfg->data_rate, &step);
+	if (rc)
+		return k1_boot_end(&b, rc, step);
+	b.mc_clocked = true;
+	rc = k1_ddr_device_init(&b.hw, false, &step);
+	if (rc)
+		return k1_boot_end(&b, rc, step);
+
+	/* cold PHY: enough to read MR8 before byte mode and map are decided */
+	rc = k1_boot_pass(&b, 0);
+	if (rc)
+		return k1_boot_end(&b, rc, K1_STEP_TRAIN);
+
+	const struct k1_ddrt_cfg mrcfg = { .ddr = cfg->ddr, .cs_num = cfg->cs_num };
+
+	rc = k1_ddrt_mr_read(&mrcfg, env, 0, 0, 5, &rep->mr5);
+	if (!rc)
+		rc = k1_ddrt_mr_read(&mrcfg, env, 0, 0, 8, &rep->mr8);
+	if (rc)
+		return k1_boot_end(&b, rc, K1_STEP_MR_READ);
+	k1_log(env, "k1-ddr: MR5 0x%02x MR8 0x%02x\n", rep->mr5, rep->mr8);
+
+	rc = k1_ddr_geometry(rep->mr8, &g);
+	if (rc) {
+		k1_log(env, "k1-ddr: MR8 0x%02x: no address map for this part\n",
+		       rep->mr8);
+		return k1_boot_end(&b, rc, K1_STEP_MAP);
+	}
+	if (g.x8) {
+		rep->byte_mode = true;
+		k1_ddr_mc_reset(&b.hw);
+		rc = k1_ddr_device_init(&b.hw, true, &step);
+		if (rc)
+			return k1_boot_end(&b, rc, step);
+	}
+	k1_ddr_map_apply(&b.hw, &g);
+	rep->size_mb = g.area_mb * cfg->cs_num;
+	k1_log(env, "k1-ddr: %u MB (%s, ROW_%u), cs0 0x%08x cs1 0x%08x 0x%x geom 0x%08x\n",
+	       rep->size_mb, g.x8 ? "x8" : "x16", g.row,
+	       k1_r32(cfg->ddr + K1_MC_CS0_MAP), k1_r32(cfg->ddr + K1_MC_CS1_MAP),
+	       k1_r32(cfg->ddr + K1_MC_CS1_HI), k1_r32(cfg->ddr + K1_MC_CS0_GEOM));
+	k1_ddr_dfc_table_load(&b.hw, rep->size_mb == 16384);
+
+	rc = k1_boot_pass(&b, 0);
+	n = k1_ddr_dfc_plan(cfg->type, fps);
+	for (u32 i = 0; !rc && i < n; i++) {
+		rc = k1_boot_dfc(&b, fps[i]);
+		if (rc)
+			return k1_boot_end(&b, rc, K1_STEP_DFC);
+		rc = k1_boot_pass(&b, fps[i]);
+	}
+	if (rc)
+		return k1_boot_end(&b, rc, K1_STEP_TRAIN);
+
+	if (rep->size_mb == 16384)
+		k1_ddr_mr_write(&b.hw, K1_MR21_16G);
+	rc = k1_boot_dfc(&b, rep->final_pp);
+	if (rc)
+		return k1_boot_end(&b, rc, K1_STEP_DFC);
+	return k1_boot_end(&b, K1_DDRT_OK, K1_STEP_NONE);
+}
+
+int k1_ddr_boot_fallback(struct k1_ddr_boot_cfg *cfg,
+			 const struct k1_ddrt_env *env,
+			 struct k1_ddr_boot_report *rep,
+			 void (*prepare)(void *ctx, u32 data_rate),
+			 int (*after)(void *ctx, const struct k1_ddr_boot_cfg *cfg,
+				      const struct k1_ddrt_env *env,
+				      struct k1_ddr_boot_report *rep),
+			 void *ctx)
+{
+	const u32 asked = cfg ? cfg->data_rate : 0;
+	u32 rate = asked;
+	int rc;
+
+	if (!cfg || !rep)
+		return K1_DDRT_EINVAL;
+	for (;;) {
+		cfg->data_rate = rate;
+		if (prepare)
+			prepare(ctx, rate);
+		rc = k1_ddr_boot(cfg, env, rep);
+		if (!rc && after) {
+			const int arc = after(ctx, cfg, env, rep);
+
+			if (arc) {
+				rc = arc;
+				rep->rc = arc;
+				rep->fail_step = K1_STEP_TRAIN;
+			}
+		}
+		const u32 next = k1_ddr_fallback_rate(rate);
+
+		if (!rc || !next || !k1_ddr_can_fallback(rc, rep->fail_step))
+			break;
+		k1_log(env, "k1-ddr: fallback %u -> %u MT/s (%s rc %d)\n",
+		       rate, next, k1_ddr_step_name(rep->fail_step), rc);
+		{
+			const struct k1_ddr_hw hw = k1_ddr_hw_init(cfg, env);
+
+			k1_ddr_mc_reset(&hw);
+		}
+		rate = next;
+	}
+	if (!rc && rate != asked)
+		k1_log(env, "k1-ddr: running at %u MT/s (asked %u)\n",
+		       rate, asked);
+	return rc;
+}
diff --git a/drivers/ram/spacemit/k1_ddr_boot.h b/drivers/ram/spacemit/k1_ddr_boot.h
new file mode 100644
index 00000000000..5171e6994a5
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_boot.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 LPDDR4X bring-up from a cold controller (docs 25..31):
+ *
+ *   PLL + SW-FC to fp0 -> Device_Init -> train(pp0) -> MR5/MR8
+ *   -> [MC reset + Device_Init with x8 overlays] -> address map
+ *   -> DFC table -> train(pp0) -> DFC(1) train(pp1) -> DFC(2) train(pp2)
+ *   -> [MR21 if 16 GiB] -> DFC(final)
+ *
+ * LPDDR4 (non-X) adds DFC(3) train(pp3) between pp1 and pp2.
+ */
+#ifndef K1_DDR_BOOT_H
+#define K1_DDR_BOOT_H
+
+#include "k1_ddrt.h"
+
+enum k1_ddr_type {
+	K1_DDR_LPDDR4X,
+	K1_DDR_LPDDR4,
+};
+
+enum k1_ddr_step {
+	K1_STEP_NONE,
+	K1_STEP_ARGS,
+	K1_STEP_PLL,		/* PLL lock */
+	K1_STEP_SWFC,		/* software frequency change to fp0 */
+	K1_STEP_MC,		/* MC does not hold a write (no clock) */
+	K1_STEP_DFI_INIT,	/* PHY init_start never reported done */
+	K1_STEP_DRAM_INIT,	/* JEDEC init never reported done */
+	K1_STEP_TRAIN,
+	K1_STEP_MR_READ,
+	K1_STEP_MAP,		/* MR8 density / width not supported */
+	K1_STEP_DFC,
+};
+
+struct k1_ddr_boot_cfg {
+	uintptr_t ddr;		/* 0xc0000000 */
+	uintptr_t pmu;		/* 0xd4282800 */
+	uintptr_t dfc_win;	/* 0xf0000000, where the DFC table is filled */
+	u32 cs_num;	/* 1 or 2 */
+	u32 data_rate;	/* MT/s as passed by the SPL */
+	enum k1_ddr_type type;
+	/*
+	 * optional observer, called after every training pass; a non-zero
+	 * return fails that pass (and the boot) once PI itself succeeded
+	 */
+	int (*on_pass)(void *ctx, const struct k1_ddrt_result *res,
+		       u32 pp);
+	void *pass_ctx;
+};
+
+struct k1_ddr_pass_summary {
+	s32 rc;
+	u8 boot_pp;
+	u8 rx_vref_idx;
+	u8 tx_vref_dq;
+	u8 fail_stage;
+	u32 phy_status;
+	u32 gate_cs0_b0;
+};
+
+struct k1_ddr_boot_report {
+	s32 rc;
+	enum k1_ddr_step fail_step;
+	u8 final_pp;
+	u8 mr5, mr8;
+	bool byte_mode;
+	u32 size_mb;	/* all ranks */
+	u32 n_pass;
+	struct k1_ddr_pass_summary pass[5];
+	u32 status;	/* MC STATUS on return */
+	u32 ctl_freq;
+	u32 clksel;	/* PMU+0x3b4 on return */
+	u32 total_us;
+};
+
+/*
+ * Full bring-up. env->now_us is required: resets, ZQCAL and MR writes are
+ * timed. Returns K1_DDRT_OK with DRAM usable at the final frequency point.
+ */
+__must_check int k1_ddr_boot(const struct k1_ddr_boot_cfg *cfg,
+			     const struct k1_ddrt_env *env,
+			     struct k1_ddr_boot_report *rep);
+
+/* next safer data_rate, or 0 when this request has no fallback */
+u32 k1_ddr_fallback_rate(u32 data_rate);
+
+/* EINVAL / ENOSYS / PLL and SW-FC timeouts are not retried */
+bool k1_ddr_can_fallback(int rc, enum k1_ddr_step step);
+
+/*
+ * k1_ddr_boot() at cfg->data_rate, then the rate ladder on a retryable
+ * failure (2666→2400→1066, 1333→1200→1066, 2400/1200→1066). prepare()
+ * runs before each attempt; after() runs only when that attempt's boot
+ * returned 0 (final independent eye lives here). On a retryable after()
+ * failure the ladder continues. cfg->data_rate becomes the rate of the
+ * last attempt. MC is reset between attempts.
+ */
+__must_check int k1_ddr_boot_fallback(struct k1_ddr_boot_cfg *cfg, const struct k1_ddrt_env *env,
+				      struct k1_ddr_boot_report *rep,
+	void (*prepare)(void *ctx, u32 data_rate),
+	int (*after)(void *ctx, const struct k1_ddr_boot_cfg *cfg,
+		     const struct k1_ddrt_env *env,
+		     struct k1_ddr_boot_report *rep),
+	void *ctx);
+
+/* data_rate -> fp left running at the end (doc 30) */
+u32 k1_ddr_final_fp(enum k1_ddr_type type, u32 data_rate);
+
+/* fps trained after the second pp0, in order; returns how many */
+u32 k1_ddr_dfc_plan(enum k1_ddr_type type, u8 fps[3]);
+
+const char *k1_ddr_step_name(enum k1_ddr_step step);
+
+#endif /* K1_DDR_BOOT_H */
diff --git a/drivers/ram/spacemit/k1_ddr_eye.c b/drivers/ram/spacemit/k1_ddr_eye.c
new file mode 100644
index 00000000000..92278e0bbbd
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_eye.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * Independent data-eye training by memory-pattern sweep. See k1_ddr_eye.h.
+ *
+ * After PI bring-up (WL + DQS gate; the gate cannot be positioned by software,
+ * phy.md), this trains RX/TX Vref and then re-centres every DQ delay from a
+ * pattern moved through DRAM, without the PI harvest (eye-training.md).
+ *
+ * Order: coarse Vref (window width) then fine delay. Edges: binary search
+ * on a short pattern, then confirm the two edges with a longer pattern.
+ *
+ * F6.2 cache flush is not used: Zicbom `cbo.flush` traps in the SPL, and
+ * T-Head `dcache.cipa` is an illegal instruction from this image (FDL
+ * logsRefs after FSBL-eye-f6.bin, TVAL 0x02b5000b) even after THEADISAEE
+ * and MHCR.DE. With D-cache off a short pattern already hits DRAM.
+ */
+#include "k1_ddr_eye.h"
+#include "k1_ddrt_io.h"
+#include "k1_ddrt_priv.h"
+#include "k1_ddrt_regs.h"
+
+#define K1_EYE_RANK_OFF ((uintptr_t)(0x08000000))	/* 128 MiB into the rank */
+#define K1_CPU_HOLE ((u64)(0x80000000))	/* 2–4 GiB MMIO */
+#define K1_EYE_COARSE_W ((u32)(16))		/* 64 B, Vref metric */
+#define K1_EYE_RX_W ((u32)(64))		/* 256 B, delay search */
+#define K1_EYE_TX_W ((u32)(32))		/* 128 B */
+#define K1_EYE_FINE_W ((u32)(1024))		/* 4 KiB, edge confirm */
+#define K1_EYE_VFY_W ((u32)(2048))		/* 8 KiB */
+#define K1_EYE_MRW_US ((u32)(1))
+
+static inline u32 k1_eye_pat(u32 i, u32 salt)
+{
+	u32 x = i ^ (salt * 0x9e3779b9u);
+
+	x *= 2654435761u;
+	x ^= x >> 15;
+	return x;
+}
+
+static void k1_eye_fill(u32 *p, u32 nwords, u32 salt)
+{
+	for (u32 i = 0; i < nwords; i++)
+		k1_dram_w32(p, i, k1_eye_pat(i, salt));
+	k1_io_fence();
+}
+
+static u32 k1_eye_bad(u32 *p, u32 nwords, u32 salt)
+{
+	for (u32 i = 0; i < nwords; i++)
+		if (k1_dram_r32(p, i) != k1_eye_pat(i, salt))
+			return 1;
+	return 0;
+}
+
+u64 k1_eye_cs1_cpu(u32 cs1_hi, u32 map)
+{
+	const u32 start_8mb = (cs1_hi << 9) |
+		((map >> K1_MAP_START_SHIFT) & K1_MAP_START_LO);
+	u64 dram = (u64)start_8mb << 23;
+
+	if (dram >= K1_CPU_HOLE)
+		dram += K1_CPU_HOLE;
+	return dram + K1_EYE_RANK_OFF;
+}
+
+/* CS1 CPU base: map start (8 MB units) plus the 2–4 GiB hole (address-map.md). */
+static uintptr_t k1_eye_rank_buf(uintptr_t ddr, u32 cs)
+{
+	if (cs == 0)
+		return K1_EYE_RANK_OFF;
+	return (uintptr_t)k1_eye_cs1_cpu(k1_r32(ddr + K1_MC_CS1_HI),
+					 k1_r32(ddr + K1_MC_CS1_MAP));
+}
+
+static uintptr_t k1_eye_slice(uintptr_t ddr, u32 fp)
+{
+	return ddr + K1_PHY_OFF + ((uintptr_t)fp << K1_PHY_SLICE_SHIFT);
+}
+
+static uintptr_t k1_eye_lane(uintptr_t ddr, u32 fp, u32 cs,
+			     u32 b, u32 reg, u32 l)
+{
+	return k1_eye_slice(ddr, fp) + K1_BYTE_OFF[b] +
+	       ((uintptr_t)cs << K1_PHY_CS_SHIFT) + reg + 4u * l;
+}
+
+static u32 k1_eye_probe(u32 *mem, uintptr_t a, u32 mask,
+			u32 code, u32 words, bool rewrite)
+{
+	k1_rmw32(a, ~mask, code & mask);
+	if (rewrite)
+		k1_eye_fill(mem, words, 0);
+	return k1_eye_bad(mem, words, 0);
+}
+
+/* Widest 0-error run in pass[0..ncode). Width 0 if none. */
+static u32 k1_eye_window(const u8 *pass, u32 ncode, int *lo)
+{
+	int best_lo = -1, best_w = 0, cur = -1;
+
+	for (u32 c = 0; c < ncode; c++) {
+		if (pass[c]) {
+			if (cur < 0)
+				cur = (int)c;
+			if ((int)c - cur + 1 > best_w) {
+				best_w = (int)c - cur + 1;
+				best_lo = cur;
+			}
+		} else {
+			cur = -1;
+		}
+	}
+	*lo = best_lo;
+	return (u32)best_w;
+}
+
+/* Linear fallback when the PI seed is already outside the window. */
+static u32 k1_eye_linear(u32 *mem, uintptr_t a, u32 mask,
+			 u32 ncode, u32 words, bool rewrite,
+			      int *lo)
+{
+	u8 pass[64];
+
+	for (u32 c = 0; c < ncode; c++)
+		pass[c] = k1_eye_probe(mem, a, mask, c, words, rewrite) ? 0 : 1;
+	return k1_eye_window(pass, ncode, lo);
+}
+
+/*
+ * Window containing `seed`: binary-search the left and right 0-error edges
+ * with `words`, then confirm/expand those two edges with `fine` (F6.3).
+ * Restores nothing; the caller writes the centre or the saved tap.
+ */
+static u32 k1_eye_edges(u32 *mem, uintptr_t a, u32 mask,
+			u32 ncode, u32 seed, u32 words,
+			     u32 fine, bool rewrite, int *lo)
+{
+	u32 left, right, l, h;
+
+	if (seed >= ncode)
+		seed = ncode / 2;
+	if (k1_eye_probe(mem, a, mask, seed, words, rewrite))
+		return k1_eye_linear(mem, a, mask, ncode, words, rewrite, lo);
+
+	l = 0;
+	h = seed;
+	while (l < h) {
+		const u32 mid = l + (h - l) / 2;
+
+		if (k1_eye_probe(mem, a, mask, mid, words, rewrite) == 0)
+			h = mid;
+		else
+			l = mid + 1;
+	}
+	left = l;
+
+	l = seed;
+	h = ncode - 1;
+	while (l < h) {
+		const u32 mid = l + (h - l + 1) / 2;
+
+		if (k1_eye_probe(mem, a, mask, mid, words, rewrite) == 0)
+			l = mid;
+		else
+			h = mid - 1;
+	}
+	right = l;
+
+	if (fine > words) {
+		while (left > 0 &&
+		       k1_eye_probe(mem, a, mask, left - 1, fine, rewrite) == 0)
+			left--;
+		while (right + 1 < ncode &&
+		       k1_eye_probe(mem, a, mask, right + 1, fine, rewrite) == 0)
+			right++;
+		while (left <= right &&
+		       k1_eye_probe(mem, a, mask, left, fine, rewrite))
+			left++;
+		while (left <= right &&
+		       k1_eye_probe(mem, a, mask, right, fine, rewrite))
+			right--;
+		if (left > right) {
+			*lo = -1;
+			return 0;
+		}
+	}
+	*lo = (int)left;
+	return right - left + 1;
+}
+
+static u32 k1_eye_min_width(u32 *mem, uintptr_t ddr,
+			    u32 fp, u32 cs, u32 b0,
+				 u32 nb, u32 reg, u32 mask,
+				 u32 ncode, u32 words, bool rewrite)
+{
+	u32 worst = ~0u;
+
+	if (!rewrite)
+		k1_eye_fill(mem, words, 0);
+	for (u32 b = b0; b < b0 + nb; b++) {
+		for (u32 l = 0; l < K1_N_LANES; l++) {
+			const uintptr_t a = k1_eye_lane(ddr, fp, cs, b, reg, l);
+			const u32 save = k1_r32(a);
+			const u32 seed = save & mask;
+			int lo;
+			const u32 w = k1_eye_edges(mem, a, mask, ncode, seed,
+							words, words, rewrite, &lo);
+
+			k1_w32(a, save);
+			if (w < worst)
+				worst = w;
+		}
+	}
+	return worst == ~0u ? 0 : worst;
+}
+
+static void k1_eye_train_byte(u32 *mem,
+			      const struct k1_ddrt_env *env, uintptr_t ddr,
+			      u32 fp, u32 cs, u32 b,
+			      const char *tag, u32 reg, u32 mask,
+			      u32 ncode, u32 words, bool rewrite)
+{
+	u8 centre[K1_N_LANES];
+	u8 width[K1_N_LANES];
+
+	if (!rewrite)
+		k1_eye_fill(mem, words, 0);
+	for (u32 l = 0; l < K1_N_LANES; l++) {
+		const uintptr_t a = k1_eye_lane(ddr, fp, cs, b, reg, l);
+		const u32 save = k1_r32(a);
+		int lo;
+		const u32 w = k1_eye_edges(mem, a, mask, ncode, save & mask,
+						words, K1_EYE_FINE_W, rewrite, &lo);
+
+		if (w) {
+			const u32 c = (u32)lo + w / 2;
+
+			k1_rmw32(a, ~mask, c & mask);
+			centre[l] = (u8)c;
+			width[l] = (u8)w;
+		} else {
+			k1_w32(a, save);
+			centre[l] = 0xff;
+			width[l] = 0;
+		}
+	}
+	k1_log(env, "indep: fp%u cs%u %s b%u centre %u %u %u %u %u %u %u %u\n",
+	       fp, cs, tag, b, centre[0], centre[1], centre[2], centre[3],
+	       centre[4], centre[5], centre[6], centre[7]);
+	k1_log(env, "indep: fp%u cs%u %s b%u width  %u %u %u %u %u %u %u %u\n",
+	       fp, cs, tag, b, width[0], width[1], width[2], width[3],
+	       width[4], width[5], width[6], width[7]);
+}
+
+static void k1_eye_set_rx_vref(uintptr_t slice, u32 sub, u32 step)
+{
+	const uintptr_t a = slice + (sub ? K1_SLICE_VREF1 : K1_SLICE_VREF0);
+	const u32 packed = (k1_r32(a) & K1_VREF_LO_MASK) |
+				k1_pack_vref(step);
+
+	k1_w32(a, packed);
+}
+
+static void k1_eye_set_mr14(uintptr_t ddr, u32 cs_num, u32 vref_dq,
+			    const struct k1_ddrt_env *env)
+{
+	k1_rmw32(ddr + K1_MC_TXVREF, K1_TXVREF_MASK,
+		 (vref_dq & K1_TXVREF_FIELD) << K1_TXVREF_SHIFT);
+	k1_w32(ddr + K1_MC_CA_CMD, k1_ca_mr14(cs_num));
+	k1_udelay(env, K1_EYE_MRW_US);
+}
+
+/* Sub-PHY A = bytes 0/1 (VREF0), B = bytes 2/3 (VREF1). */
+static u32 k1_eye_train_rx_vref(u32 *mem,
+				const struct k1_ddrt_env *env,
+				     uintptr_t ddr, u32 fp)
+{
+	const uintptr_t slice = k1_eye_slice(ddr, fp);
+	const uintptr_t v0 = slice + K1_SLICE_VREF0;
+	u32 best[2] = { 0, 0 };
+
+	k1_rmw32(v0, ~K1_VREF_BIT4, 0);
+	for (u32 sub = 0; sub < 2; sub++) {
+		u32 width[K1_N_VREF];
+		u32 win_best = 0, step_best = 0;
+		const u32 b0 = sub * 2;
+
+		for (u32 step = 0; step < K1_N_VREF; step++) {
+			k1_eye_set_rx_vref(slice, sub, step);
+			width[step] = k1_eye_min_width(mem, ddr, fp, 0, b0, 2,
+						       K1_BYTE_RX_DQ,
+						       K1_RX_DLY_MASK, 32,
+						       K1_EYE_COARSE_W, false);
+			if (width[step] > win_best) {
+				win_best = width[step];
+				step_best = step;
+			}
+		}
+		best[sub] = step_best;
+		k1_eye_set_rx_vref(slice, sub, step_best);
+		k1_log(env,
+		       "indep: fp%u rx vref %c best %u (min window %u) widths %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\n",
+		       fp, sub ? 'B' : 'A', step_best, win_best,
+		       width[0], width[1], width[2], width[3],
+		       width[4], width[5], width[6], width[7],
+		       width[8], width[9], width[10], width[11],
+		       width[12], width[13], width[14], width[15]);
+	}
+	k1_rmw32(v0, ~0u, K1_VREF_BIT4);
+	return (best[0] << 8) | best[1];
+}
+
+static u32 k1_eye_train_tx_vref(u32 *mem,
+				const struct k1_ddrt_env *env,
+				     uintptr_t ddr, u32 cs_num, u32 fp)
+{
+	u32 width[K1_N_VREF];
+	u32 win_best = 0, step_best = 0;
+	u32 mr14;
+
+	for (u32 i = 0; i < K1_N_VREF; i++) {
+		const u32 v = K1_TX_VREF_SEED0 + i;
+
+		k1_eye_set_mr14(ddr, cs_num, v, env);
+		width[i] = k1_eye_min_width(mem, ddr, fp, 0, 0, K1_N_BYTES,
+					    K1_BYTE_TX_DQ, K1_TX_DLY_MASK, 48,
+					    K1_EYE_COARSE_W, true);
+		if (width[i] > win_best) {
+			win_best = width[i];
+			step_best = i;
+		}
+	}
+	mr14 = K1_TX_VREF_SEED0 + step_best;
+	k1_eye_set_mr14(ddr, cs_num, mr14, env);
+	k1_log(env,
+	       "indep: fp%u tx mr14 best %u (min window %u) widths %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\n",
+	       fp, mr14, win_best,
+	       width[0], width[1], width[2], width[3],
+	       width[4], width[5], width[6], width[7],
+	       width[8], width[9], width[10], width[11],
+	       width[12], width[13], width[14], width[15]);
+	return mr14;
+}
+
+/* One WL code per byte (5-bit field at +0x24; bit 5 is ignored, phy.md). */
+static void k1_eye_train_wl(u32 *mem, const struct k1_ddrt_env *env,
+			    uintptr_t ddr, u32 fp, u32 cs)
+{
+	u8 centre[K1_N_BYTES];
+	u8 width[K1_N_BYTES];
+
+	for (u32 b = 0; b < K1_N_BYTES; b++) {
+		const uintptr_t a = k1_eye_lane(ddr, fp, cs, b, K1_BYTE_WL, 0);
+		const u32 save = k1_r32(a);
+		int lo;
+		const u32 w = k1_eye_edges(mem, a, 31, 32, save & 31,
+						K1_EYE_TX_W, K1_EYE_FINE_W,
+						true, &lo);
+
+		if (w) {
+			const u32 c = (u32)lo + w / 2;
+
+			k1_rmw32(a, ~31u, c);
+			centre[b] = (u8)c;
+			width[b] = (u8)w;
+		} else {
+			k1_w32(a, save);
+			centre[b] = 0xff;
+			width[b] = 0;
+		}
+	}
+	k1_log(env, "indep: fp%u cs%u wl centre %u %u %u %u width %u %u %u %u\n",
+	       fp, cs, centre[0], centre[1], centre[2], centre[3],
+	       width[0], width[1], width[2], width[3]);
+}
+
+static u32 k1_eye_train_rank(u32 *mem,
+			     const struct k1_ddrt_env *env, uintptr_t ddr,
+				  u32 fp, u32 cs)
+{
+	u32 bad = 0;
+
+	k1_log(env, "indep: fp%u cs%u buf 0x%lx\n", fp, cs,
+	       (unsigned long)(uintptr_t)mem);
+	for (u32 b = 0; b < K1_N_BYTES; b++)
+		k1_eye_train_byte(mem, env, ddr, fp, cs, b, "rx", K1_BYTE_RX_DQ,
+				  K1_RX_DLY_MASK, 32, K1_EYE_RX_W, false);
+	for (u32 b = 0; b < K1_N_BYTES; b++)
+		k1_eye_train_byte(mem, env, ddr, fp, cs, b, "tx", K1_BYTE_TX_DQ,
+				  K1_TX_DLY_MASK, 48, K1_EYE_TX_W, true);
+	for (u32 s = 1; s <= 3; s++) {
+		k1_eye_fill(mem, K1_EYE_VFY_W, s);
+		bad += k1_eye_bad(mem, K1_EYE_VFY_W, s);
+	}
+	k1_log(env, "indep: fp%u cs%u verify %s (%u/3 patterns bad)\n",
+	       fp, cs, bad ? "FAIL" : "OK", bad);
+	return bad;
+}
+
+int k1_ddr_eye_measure(uintptr_t ddr, u32 cs_num, u32 fp,
+		       const struct k1_ddrt_env *env)
+{
+	const u64 t0 = k1_now(env);
+	const struct k1_ddrt_cfg mc = { .ddr = ddr, .cs_num = cs_num };
+	u32 *mem0;
+	u32 bad = 0;
+	int mr14_rc;
+
+	if (cs_num < 1)
+		cs_num = 1;
+	mem0 = (u32 *)k1_eye_rank_buf(ddr, 0);
+	k1_log(env, "indep: eye training at fp%u, %u rank(s)\n", fp, cs_num);
+
+	for (u32 cs = 0; cs < cs_num; cs++) {
+		u32 *mem =
+			(u32 *)k1_eye_rank_buf(ddr, cs);
+
+		k1_eye_train_wl(mem, env, ddr, fp, cs);
+	}
+	k1_eye_train_rx_vref(mem0, env, ddr, fp);
+	k1_eye_train_tx_vref(mem0, env, ddr, cs_num, fp);
+
+	for (u32 cs = 0; cs < cs_num; cs++) {
+		u32 *mem =
+			(u32 *)k1_eye_rank_buf(ddr, cs);
+
+		bad += k1_eye_train_rank(mem, env, ddr, fp, cs);
+	}
+
+	mr14_rc = k1_ddrt_check_mr14(&mc, env);
+	k1_log(env,
+	       "indep: eye training done in %u us, verify %s (%u rank-fails), MR14 check rc %d\n",
+	       (u32)(k1_now(env) - t0), bad ? "FAIL" : "OK", bad, mr14_rc);
+	if (bad)
+		return K1_DDRT_EIO;
+	return mr14_rc;
+}
diff --git a/drivers/ram/spacemit/k1_ddr_eye.h b/drivers/ram/spacemit/k1_ddr_eye.h
new file mode 100644
index 00000000000..54549b33d30
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_eye.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * Independent data-eye training by memory-pattern sweep.
+ *
+ * On a controller already brought up and mapped at frequency point `fp`, this
+ * trains write leveling (`byte+0x24`), RX Vref (VREF0/VREF1), TX Vref (MR14),
+ * then the RX/TX delay of every CS0/CS1 byte lane by moving data through DRAM
+ * (CS1 at the mapped CPU base + 128 MiB, address-map.md),
+ * without reading the PI harvest (eye-training.md, write-leveling.md, phy.md).
+ * Delay and WL edges are found by a two-stage search from the PI seed: a
+ * short pattern for the binary edges, then a longer pattern only at those
+ * edges. D-cache is left off: Zicbom and T-Head `dcache.cipa` both trap
+ * in this SPL/firmware slot (boot-interface.md).
+ *
+ * The DQS read-gate cannot be positioned from software (phy.md), so the gate
+ * stays with the PI. With `K1_INDEP_EYE` this is the production data-eye
+ * path; the PI is only bring-up, WL seed and gate.
+ */
+#ifndef K1_DDR_EYE_H
+#define K1_DDR_EYE_H
+
+#include "k1_ddrt.h"
+
+/* Returns K1_DDRT_OK if every rank verifies and MR14 matches the bank. */
+int k1_ddr_eye_measure(uintptr_t ddr, u32 cs_num, u32 fp,
+		       const struct k1_ddrt_env *env);
+
+/* CS1 CPU buffer: map start in 8 MiB units, plus the 2–4 GiB hole, plus 128 MiB. */
+u64 k1_eye_cs1_cpu(u32 cs1_hi, u32 map);
+
+#endif /* K1_DDR_EYE_H */
diff --git a/drivers/ram/spacemit/k1_ddr_init.c b/drivers/ram/spacemit/k1_ddr_init.c
new file mode 100644
index 00000000000..d47c6ca4ac7
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_init.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 DDR controller bring-up: PLL and SW-FC (doc 25), Device_Init
+ * with PHY analog and mode registers (26, 27, 28), address map (29), DFC
+ * table and hardware DFC (30), byte-mode re-init (31).
+ */
+#include "k1_ddr_init.h"
+#include "k1_ddrt_io.h"
+#include "k1_ddrt_priv.h"
+#include "k1_ddrt_regs.h"
+
+#define K1_LOCK_BUDGET_US ((u32)(1000))
+#define K1_FC_BUDGET_US ((u32)(10000))	/* HW-DFC done in < 1 ms */
+#define K1_SR_BUDGET_US ((u32)(10000))
+#define K1_INIT_BUDGET_US ((u32)(10000))
+#define K1_MC_RESET_US ((u32)(100))
+#define K1_ZQ_START_US ((u32)(2))
+#define K1_ZQ_LATCH_US ((u32)(1))
+#define K1_MRW_US ((u32)(1))
+
+/* IO words of the timing banks (doc 26) */
+#define K1_IO_TXVREF_SEED ((u32)(0x4314))
+#define K1_IO_TXVREF_KEEP ((u32)(0x8fff))
+#define K1_IO_DS_SEED ((u32)(0x00440000))
+#define K1_IO_DS_KEEP ((u32)(0xff80ffff))
+#define K1_IO_PU_SHIFT ((u32)(17))
+#define K1_FREQ_AUX_KEEP ((u32)(0xf00fffff))
+#define K1_FREQ_AUX_VAL ((u32)(0x10u << 20))
+
+/* COMMON words, offsets from C0 / C1 (doc 27) */
+#define K1_COM_ARM ((u32)(0x00))
+#define K1_COM_VREF ((u32)(0x04))
+#define K1_COM_DS ((u32)(0x0c))
+#define K1_COM_10 ((u32)(0x10))
+#define K1_COM_14 ((u32)(0x14))
+#define K1_COM_PRE_KEEP ((u32)(0xffff0fff))
+#define K1_COM_PRE_BITS ((u32)((1u << 11) | (1u << 13) | (1u << 15)))
+#define K1_COM_TXDS_KEEP ((u32)(0xffff00ff))
+#define K1_COM_RXODT_KEEP ((u32)(0xffc0ffff))
+#define K1_COM_RXVREF_KEEP ((u32)(0x0000ffff))
+#define K1_COM_14_KEEP ((u32)(0xff9fffef))
+#define K1_COM_14_VAL ((u32)(3u << 21))
+#define K1_COM_10_BIT ((u32)(0x10000000))
+#define K1_COM_A0_30_VAL ((u32)(0x1077))
+#define K1_DQ_CS0B0_VAL ((u32)(0x4349))
+#define K1_PHY_INIT_POR ((u32)(0x100))
+
+/* DFC table: commands whose top byte carries the CS selection */
+#define K1_TBL_CS_BYTE_2CS ((u32)(0x13))
+
+static uintptr_t k1_mc(const struct k1_ddr_hw *hw, u32 off)
+{
+	return hw->ddr + off;
+}
+
+static uintptr_t k1_pmu(const struct k1_ddr_hw *hw, u32 off)
+{
+	return hw->pmu + off;
+}
+
+static u32 k1_cs_field(const struct k1_ddr_hw *hw)
+{
+	return hw->cs_sel << K1_CS_SEL_SHIFT;
+}
+
+struct k1_ddr_hw k1_ddr_hw_init(const struct k1_ddr_boot_cfg *cfg,
+				const struct k1_ddrt_env *env)
+{
+	return (struct k1_ddr_hw){
+		.ddr = cfg->ddr,
+		.phy = cfg->ddr + K1_PHY_OFF,
+		.pmu = cfg->pmu,
+		.win = cfg->dfc_win,
+		.cs_num = cfg->cs_num,
+		.cs_sel = k1_cs_sel(cfg->cs_num),
+		.type = cfg->type,
+		.io = cfg->type == K1_DDR_LPDDR4 ? &k1_io_lpddr4 : &k1_io_lpddr4x,
+		.env = env,
+	};
+}
+
+int k1_ddr_pll_init(const struct k1_ddr_hw *hw, u32 data_rate,
+		    enum k1_ddr_step *step)
+{
+	const struct k1_ddrt_env *env = hw->env;
+	u32 v = 0;
+
+	/* reset values are not established: logged for the record only */
+	k1_log(env, "k1-ddr: pmu before: cc_ap 0x%08x hw_slp 0x%08x clksel 0x%08x pll1 0x%08x 0x%08x mck 0x%08x\n",
+	       k1_r32(k1_pmu(hw, K1_PMU_CC_AP)), k1_r32(k1_pmu(hw, K1_PMU_HW_SLP)),
+	       k1_r32(k1_pmu(hw, K1_PMU_CLKSEL)),
+	       k1_r32(k1_pmu(hw, K1_PMU_PLL1_CTL1)),
+	       k1_r32(k1_pmu(hw, K1_PMU_PLL1_CTL2)),
+	       k1_r32(k1_pmu(hw, K1_PMU_MCK_CTRL)));
+
+	/*
+	 * Drop enables first so a re-entry (rate fallback) can rewrite the
+	 * VCO words. 2666 and 1333: complete pair (fp0 = PLL1/2 ≈1333).
+	 * 2400/1200/1066: RMW leftover [15:8]=0x3B; if a previous attempt
+	 * left the 2666 pair, restore the BootROM words first (RMW of CTL1
+	 * alone would leave 0x203c3b55 and still clock 2666).
+	 */
+	k1_rmw32(k1_pmu(hw, K1_PMU_CLKSEL),
+		 ~(K1_CLKSEL_PLL2_EN | K1_CLKSEL_PLL1_EN), 0);
+	if (data_rate == 2666 || data_rate == 1333) {
+		k1_w32(k1_pmu(hw, K1_PMU_PLL1_CTL1), K1_PLL1_2666);
+		k1_w32(k1_pmu(hw, K1_PMU_PLL1_CTL2), K1_PLL1_ANALOG);
+	} else {
+		const u32 analog = k1_r32(k1_pmu(hw, K1_PMU_PLL1_CTL2));
+
+		if (analog != K1_PLL1_BOOTROM_ANALOG) {
+			k1_w32(k1_pmu(hw, K1_PMU_PLL1_CTL2),
+			       K1_PLL1_BOOTROM_ANALOG);
+			k1_w32(k1_pmu(hw, K1_PMU_PLL1_CTL1), K1_PLL1_BOOTROM);
+		}
+		k1_rmw32(k1_pmu(hw, K1_PMU_PLL1_CTL1), K1_PLL1_2400_KEEP,
+			 K1_PLL1_2400_BYTE << 8);
+	}
+	k1_w32(k1_pmu(hw, K1_PMU_PLL2_CTL1), K1_PLL2_VCO);
+	k1_w32(k1_pmu(hw, K1_PMU_PLL2_CTL2), K1_PLL2_ANALOG);
+	k1_rmw32(k1_pmu(hw, K1_PMU_CLKSEL), ~0u,
+		 K1_CLKSEL_PLL2_EN | K1_CLKSEL_PLL1_EN | K1_CLKSEL_EXTRA_EN);
+	if (k1_wait(env, k1_pmu(hw, K1_PMU_CLKSEL), K1_CLKSEL_LOCK,
+		    K1_CLKSEL_LOCK, K1_LOCK_BUDGET_US, &v)) {
+		k1_log(env, "k1-ddr: PLL1/PLL2 not locked, clksel 0x%08x\n", v);
+		*step = K1_STEP_PLL;
+		return K1_DDRT_ETIMEDOUT;
+	}
+
+	k1_w32(k1_pmu(hw, K1_PMU_CLKSEL), k1_clksel[0]);
+	k1_w32(k1_pmu(hw, K1_PMU_HW_SLP), K1_HW_SLP_SWFC);
+	k1_rmw32(k1_pmu(hw, K1_PMU_CC_AP), ~0u, K1_CC_SWFC_KICK);
+	if (k1_wait(env, k1_pmu(hw, K1_PMU_CC_AP), K1_CC_SWFC_KICK, 0,
+		    K1_FC_BUDGET_US, &v)) {
+		k1_log(env, "k1-ddr: SW-FC to fp0 did not finish, cc_ap 0x%08x\n",
+		       v);
+		*step = K1_STEP_SWFC;
+		return K1_DDRT_ETIMEDOUT;
+	}
+	k1_rmw32(k1_pmu(hw, K1_PMU_MCK_CTRL), ~K1_MCK_ON, K1_MCK_ON);
+
+	k1_log(env, "k1-ddr: PLL locked, fp0 up: clksel 0x%08x hw_slp 0x%08x mck 0x%08x\n",
+	       k1_r32(k1_pmu(hw, K1_PMU_CLKSEL)),
+	       k1_r32(k1_pmu(hw, K1_PMU_HW_SLP)),
+	       k1_r32(k1_pmu(hw, K1_PMU_MCK_CTRL)));
+	k1_log(env, "k1-ddr: pll1 0x%08x 0x%08x\n",
+	       k1_r32(k1_pmu(hw, K1_PMU_PLL1_CTL1)),
+	       k1_r32(k1_pmu(hw, K1_PMU_PLL1_CTL2)));
+	return K1_DDRT_OK;
+}
+
+void k1_ddr_mr_write(const struct k1_ddr_hw *hw, u32 mr)
+{
+	/* no done bit for writes: tMRW between commands */
+	k1_w32(k1_mc(hw, K1_MC_CA_CMD),
+	       K1_CA_MR_WRITE | k1_cs_field(hw) | (mr & 0xff));
+	k1_udelay(hw->env, K1_MRW_US);
+}
+
+static void k1_write_io(const struct k1_ddr_hw *hw, u32 off)
+{
+	const struct k1_io_cfg *io = hw->io;
+	const uintptr_t a = k1_mc(hw, off);
+
+	if (off == K1_MC_TXVREF) {
+		k1_w32(a, K1_IO_TXVREF_SEED);
+		k1_rmw32(a, K1_IO_TXVREF_KEEP,
+			 ((u32)io->ca_vref << 24) |
+			 ((u32)io->tx_vref << 16) |
+			 ((u32)io->soc_odt << 12));
+	} else {
+		k1_w32(a, K1_IO_DS_SEED);
+		k1_rmw32(a, K1_IO_DS_KEEP,
+			 ((u32)io->tx_odt << 20) |
+			 ((u32)io->rx_drv << 16));
+	}
+}
+
+static int k1_mc_program(const struct k1_ddr_hw *hw, bool x8)
+{
+	for (size_t i = 0; i < K1_N_MC_GLOBALS; i++)
+		k1_w32(k1_mc(hw, k1_mc_globals[i].off), k1_mc_globals[i].val);
+	/* a controller without clock or still in reset drops writes */
+	const u32 ctl0 = k1_r32(k1_mc(hw, K1_MC_CTL0));
+
+	if (ctl0 != k1_mc_globals[0].val) {
+		k1_log(hw->env, "k1-ddr: CTL0 reads 0x%08x after writing 0x%08x\n",
+		       ctl0, k1_mc_globals[0].val);
+		return K1_DDRT_EIO;
+	}
+	k1_rmw32(k1_mc(hw, K1_MC_IO_PU), ~(1u << K1_IO_PU_SHIFT),
+		 (u32)hw->io->rx_pu_cal << K1_IO_PU_SHIFT);
+
+	for (u32 n = 4; n-- > 0;) {
+		k1_w32(k1_mc(hw, K1_MC_FREQ), k1_freq_bank(n));
+		for (size_t i = 0; i < K1_N_MC_TIMING; i++) {
+			const struct k1_bank_row *row = &k1_mc_timing[i];
+
+			if (row->io)
+				k1_write_io(hw, row->off);
+			else
+				k1_w32(k1_mc(hw, row->off), row->fp[n]);
+		}
+		if (hw->type == K1_DDR_LPDDR4)
+			k1_w32(k1_mc(hw, K1_MC_WDQS), k1_mc_wdqs[n]);
+	}
+	if (x8) {
+		for (u32 n = 4; n-- > 0;) {
+			k1_w32(k1_mc(hw, K1_MC_FREQ), k1_freq_bank(n));
+			for (size_t i = 0; i < K1_N_X8_OVERLAY; i++)
+				k1_w32(k1_mc(hw, k1_mc_x8_overlay[i].off),
+				       k1_mc_x8_overlay[i].fp[n]);
+		}
+	}
+
+	k1_rmw32(k1_mc(hw, K1_MC_FREQ_AUX), K1_FREQ_AUX_KEEP, K1_FREQ_AUX_VAL);
+	k1_rmw32(k1_mc(hw, K1_MC_FREQ), ~K1_FREQ_FP_MASK, 0);
+	k1_rmw32(k1_mc(hw, K1_MC_PI_CFG), ~0u, 0u << K1_PI_CFG_SEL_SHIFT);
+	for (size_t i = 0; i < 3; i++)
+		k1_w32(k1_mc(hw, k1_mc_refresh[i].off), k1_mc_refresh[i].val);
+	return K1_DDRT_OK;
+}
+
+static void k1_phy_analog(const struct k1_ddr_hw *hw)
+{
+	const struct k1_io_cfg *io = hw->io;
+	const u32 d2 = ((u32)io->tx_pdrv << 5) | ((u32)io->tx_ndrv << 2);
+	const u32 d3 = ((u32)io->rx_odt << 3) | io->rx_odt;
+	const u32 rxv = ((u32)io->rx_vref << 16) | ((u32)io->rx_vref << 24);
+
+	k1_rmw32(k1_pmu(hw, K1_PMU_PHY_BIAS), K1_PHY_BIAS_KEEP, K1_PHY_BIAS_VAL);
+	if (hw->type == K1_DDR_LPDDR4) {
+		k1_rmw32(k1_pmu(hw, K1_PMU_PHY_LDO), ~0u, K1_LDO_4);
+		k1_rmw32(k1_pmu(hw, K1_PMU_PHY_LDO), K1_LDO_4_KEEP, K1_LDO_4_088V);
+	} else {
+		k1_rmw32(k1_pmu(hw, K1_PMU_PHY_LDO), ~0u, K1_LDO_4X);
+	}
+
+	for (u32 n = 0; n <= K1_MAX_PP; n++) {
+		const uintptr_t s = hw->phy + (n << K1_PHY_SLICE_SHIFT);
+		const uintptr_t c[2] = { s + K1_SLICE_COMMON0, s + K1_SLICE_COMMON1 };
+
+		k1_w32(c[0] + K1_COM_ARM, 0);
+		k1_w32(c[1] + K1_COM_ARM, 0);
+		k1_w32(c[0] + K1_COM_ARM, 1);
+		k1_w32(c[1] + K1_COM_ARM, 1);
+		for (u32 i = 0; i < 2; i++) {
+			k1_rmw32(c[i] + K1_COM_VREF, K1_COM_PRE_KEEP, K1_COM_PRE_BITS);
+			k1_rmw32(c[i] + K1_COM_DS, K1_COM_TXDS_KEEP, d2 << 8);
+			k1_rmw32(c[i] + K1_COM_DS, K1_COM_RXODT_KEEP, d3 << 16);
+			k1_rmw32(c[i] + K1_COM_VREF, K1_COM_RXVREF_KEEP, rxv);
+			k1_rmw32(c[i] + K1_COM_14, K1_COM_14_KEEP, K1_COM_14_VAL);
+			k1_rmw32(c[i] + K1_COM_10, ~0u, K1_COM_10_BIT);
+		}
+	}
+	k1_w32(hw->phy + K1_PHY_COMMON_A0_30, K1_COM_A0_30_VAL);
+	for (u32 n = 0; n <= K1_MAX_PP; n++)
+		k1_w32(hw->phy + (n << K1_PHY_SLICE_SHIFT) + K1_SLICE_DQ_CS0B0,
+		       K1_DQ_CS0B0_VAL);
+	k1_w32(hw->phy + K1_PHY_OTHER_24, 0);
+	k1_rmw32(hw->phy + K1_PHY_OTHER, ~0u, 1);
+}
+
+static int k1_dram_start(const struct k1_ddr_hw *hw, enum k1_ddr_step *step)
+{
+	const struct k1_ddrt_env *env = hw->env;
+	const u32 chk = hw->cs_num == 1 ? K1_INIT_DONE_1CS : K1_INIT_DONE_2CS;
+	u32 v = 0;
+
+	k1_w32(k1_mc(hw, K1_MC_PI_CMD), K1_DFI_INIT_START | k1_cs_field(hw));
+	if (k1_wait(env, k1_mc(hw, K1_MC_PI_STATUS), K1_PI_INIT_DONE,
+		    K1_PI_INIT_DONE, K1_INIT_BUDGET_US, &v)) {
+		k1_log(env, "k1-ddr: DFI init_start not done, pi_status 0x%08x\n",
+		       v);
+		*step = K1_STEP_DFI_INIT;
+		return K1_DDRT_ETIMEDOUT;
+	}
+	k1_w32(k1_mc(hw, K1_MC_PI_CMD), K1_DFI_INIT_CLEAR | k1_cs_field(hw));
+
+	k1_w32(k1_mc(hw, K1_MC_USER0), K1_USER0_INIT | k1_cs_field(hw));
+	if (k1_wait(env, k1_mc(hw, K1_MC_STATUS), chk, chk, K1_INIT_BUDGET_US,
+		    &v)) {
+		k1_log(env, "k1-ddr: DRAM init not done, status 0x%02x\n", v);
+		*step = K1_STEP_DRAM_INIT;
+		return K1_DDRT_ETIMEDOUT;
+	}
+
+	for (size_t i = 0; i < K1_N_MR_INIT1; i++)
+		k1_ddr_mr_write(hw, k1_mr_init1[i]);
+	for (u32 cs0 = 0; cs0 < hw->cs_num; cs0++) {
+		const u32 sel = (1u << cs0) << K1_CS_SEL_SHIFT;
+
+		k1_w32(k1_mc(hw, K1_MC_USER0), K1_USER0_ZQ_START | sel);
+		k1_udelay(env, K1_ZQ_START_US);
+		k1_w32(k1_mc(hw, K1_MC_USER0), K1_USER0_ZQ_LATCH | sel);
+		k1_udelay(env, K1_ZQ_LATCH_US);
+	}
+	for (size_t i = 0; i < K1_N_MR_INIT2; i++)
+		k1_ddr_mr_write(hw, k1_mr_init2[i]);
+	return K1_DDRT_OK;
+}
+
+int k1_ddr_device_init(const struct k1_ddr_hw *hw, bool x8,
+		       enum k1_ddr_step *step)
+{
+	const struct k1_ddrt_env *env = hw->env;
+	int rc;
+
+	rc = k1_mc_program(hw, x8);
+	if (rc) {
+		*step = K1_STEP_MC;
+		return rc;
+	}
+	k1_phy_analog(hw);
+	rc = k1_dram_start(hw, step);
+	if (rc)
+		return rc;
+
+	const u32 freq = k1_r32(k1_mc(hw, K1_MC_FREQ));
+	const u32 pi_cfg = k1_r32(k1_mc(hw, K1_MC_PI_CFG));
+	const u32 phy_init = k1_r32(hw->phy + K1_PHY_INIT);
+
+	k1_log(env, "k1-ddr: device init%s: status 0x%02x ctl_freq 0x%08x pi_cfg 0x%x phy_init 0x%x pi_status 0x%08x common 0x%08x\n",
+	       x8 ? " x8" : "", k1_r32(k1_mc(hw, K1_MC_STATUS)), freq, pi_cfg,
+	       phy_init, k1_r32(k1_mc(hw, K1_MC_PI_STATUS)),
+	       k1_r32(hw->phy + K1_SLICE_COMMON0 + K1_COM_DS));
+	if (freq != k1_freq_bank(0) || (pi_cfg & K1_PI_CFG_SEL_MASK)) {
+		*step = K1_STEP_MC;
+		return K1_DDRT_EIO;
+	}
+	if (phy_init != K1_PHY_INIT_POR)
+		k1_log(env, "k1-ddr: warning: phy_init 0x%x, expected 0x%x\n",
+		       phy_init, K1_PHY_INIT_POR);
+	return K1_DDRT_OK;
+}
+
+void k1_ddr_mc_reset(const struct k1_ddr_hw *hw)
+{
+	k1_rmw32(k1_pmu(hw, K1_PMU_HW_SLP), ~K1_HW_SLP_RESET, 0);
+	k1_udelay(hw->env, K1_MC_RESET_US);
+	k1_rmw32(k1_pmu(hw, K1_PMU_HW_SLP), ~0u, K1_HW_SLP_RESET);
+	k1_udelay(hw->env, K1_MC_RESET_US);
+}
+
+u32 k1_ddr_size_code(u32 mb)
+{
+	switch (mb) {
+	case 512:	return 0x0d;
+	case 768:	return 0x01;
+	case 1024:	return 0x0e;
+	case 1536:	return 0x02;
+	case 2048:	return 0x0f;
+	case 3072:	return 0x03;
+	case 4096:	return 0x10;
+	case 8192:	return 0x11;
+	case 16384:	return 0x12;
+	default:	return 0;
+	}
+}
+
+int k1_ddr_geometry(u8 mr8, struct k1_ddr_geom *g)
+{
+	/* x16 per JEDEC channel; 1 Gb has a row count but no listed size */
+	static const struct {
+		u8 dens;
+		u8 row;
+		u16 ch_mb;
+	} t[] = {
+		{ 0, 14, 256 }, { 1, 15, 384 }, { 2, 15, 512 }, { 3, 16, 768 },
+		{ 4, 16, 1024 }, { 5, 17, 1536 }, { 6, 17, 2048 },
+	};
+	const u32 io = mr8 >> 6;
+	const u32 dens = (mr8 >> 2) & 0xf;
+
+	if (io > 1)
+		return K1_DDRT_EINVAL;
+	for (size_t i = 0; i < ARRAY_SIZE(t); i++) {
+		if (t[i].dens != dens)
+			continue;
+		const u32 area = 2u * ((u32)t[i].ch_mb << io);
+		const u32 code = k1_ddr_size_code(area);
+
+		if (!code)
+			return K1_DDRT_EINVAL;
+		*g = (struct k1_ddr_geom){
+			.area_mb = area,
+			.code = code,
+			.row = t[i].row + io,
+			.x8 = io == 1,
+		};
+		return K1_DDRT_OK;
+	}
+	return K1_DDRT_EINVAL;
+}
+
+void k1_ddr_map_apply(const struct k1_ddr_hw *hw, const struct k1_ddr_geom *g)
+{
+	const u32 start = g->area_mb >> 3;
+	const u32 code = g->code << K1_MAP_CODE_SHIFT;
+	const u32 geom = ((g->row - 10) << K1_GEOM_ROW_SHIFT) |
+			      K1_GEOM_COL10 | K1_GEOM_BANK8;
+
+	k1_rmw32(k1_mc(hw, K1_MC_CS0_MAP), K1_MAP_KEEP, code | K1_MAP_PRESENT);
+	k1_rmw32(k1_mc(hw, K1_MC_CS1_MAP), K1_MAP_KEEP & ~K1_MAP_PRESENT,
+		 ((start & K1_MAP_START_LO) << K1_MAP_START_SHIFT) | code |
+		 (hw->cs_num == 2 ? K1_MAP_PRESENT : 0));
+	k1_w32(k1_mc(hw, K1_MC_CS1_HI), start >> 9);
+	k1_rmw32(k1_mc(hw, K1_MC_CS0_GEOM), K1_GEOM_KEEP, geom);
+	k1_rmw32(k1_mc(hw, K1_MC_CS1_GEOM), K1_GEOM_KEEP, geom);
+}
+
+/* the port of the MC itself does not feed the engine unless it aliases the window */
+static void k1_tbl_put(const struct k1_ddr_hw *hw, u32 idx, u32 data,
+		       u32 addr)
+{
+	k1_w32(hw->win + K1_MC_TBL_DATA, data);
+	k1_w32(hw->win + K1_MC_TBL_ADDR, addr);
+	k1_w32(hw->win + K1_MC_TBL_INDEX, idx);
+}
+
+/* the listed flow addresses both ranks; one rank gets 0x11 in that byte */
+static u32 k1_tbl_data(const struct k1_ddr_hw *hw,
+		       const struct k1_tbl_entry *e)
+{
+	const u32 a = e->addr & 0xffff;
+
+	if (hw->cs_sel != 3 && (e->data >> 24) == K1_TBL_CS_BYTE_2CS &&
+	    (a == K1_MC_USER0 || a == K1_MC_CA_CMD || a == K1_MC_PI_CMD))
+		return (e->data & 0x00ffffff) |
+		       ((0x10 | hw->cs_sel) << K1_CS_SEL_SHIFT);
+	return e->data;
+}
+
+static void k1_tbl_seq(const struct k1_ddr_hw *hw,
+		       const struct k1_tbl_entry *seq, size_t n, bool mr21,
+		       u16 mr21_after, u16 run_end)
+{
+	const struct k1_tbl_entry e21 = {
+		.data = K1_CA_MR_WRITE | (3u << K1_CS_SEL_SHIFT) | K1_MR21_16G,
+		.addr = K1_MC_CA_CMD,
+	};
+
+	for (size_t i = 0; i < n; i++) {
+		const struct k1_tbl_entry *e = &seq[i];
+		const u32 shift = mr21 && e->idx > mr21_after &&
+				       e->idx <= run_end;
+
+		k1_tbl_put(hw, e->idx + shift, k1_tbl_data(hw, e), e->addr);
+		if (mr21 && e->idx == mr21_after)
+			k1_tbl_put(hw, mr21_after + 1u, k1_tbl_data(hw, &e21),
+				   e21.addr);
+	}
+}
+
+static_assert(K1_TBL_SNAPSHOT + 1 + K1_N_SNAP_GLOBALS +
+	       (K1_MAX_PP + 1) * K1_N_SNAP_BANK == K1_TBL_SNAP_TAIL,
+	       "DFC snapshot layout mismatch");
+static_assert(K1_TBL_SNAP_TAIL + K1_N_SNAP_TAIL == K1_TBL_SNAP_END,
+	      "DFC snapshot tail mismatch");
+
+void k1_ddr_dfc_table_load(const struct k1_ddr_hw *hw, bool mr21)
+{
+	const u32 freq = k1_r32(k1_mc(hw, K1_MC_FREQ));
+	const u32 ctl0 = k1_r32(k1_mc(hw, K1_MC_CTL0));
+	const u32 win_ctl0 = k1_r32(hw->win + K1_MC_CTL0);
+	u32 idx = K1_TBL_SNAPSHOT;
+
+	/* the window may or may not alias the MC: worth one line on the UART */
+	k1_log(hw->env, "k1-ddr: DFC window ctl0 0x%08x, ddr ctl0 0x%08x (%s)\n",
+	       win_ctl0, ctl0, win_ctl0 == ctl0 ? "alias" : "separate");
+	k1_tbl_seq(hw, k1_dfc_flow, K1_N_DFC_FLOW, mr21, K1_DFC_FLOW_MR21_AFTER,
+		   K1_DFC_FLOW_RUN_END);
+	k1_tbl_seq(hw, k1_dfc_exit, K1_N_DFC_EXIT, mr21, K1_DFC_EXIT_MR21_AFTER,
+		   K1_DFC_EXIT_RUN_END);
+
+	k1_tbl_put(hw, idx++, ctl0 | K1_TBL_CTL0_BITS,
+		   K1_MC_CTL0 | K1_TBL_REQ_PMU);
+	for (size_t i = 0; i < K1_N_SNAP_GLOBALS; i++)
+		k1_tbl_put(hw, idx++, k1_r32(k1_mc(hw, k1_dfc_snap_globals[i])),
+			   k1_dfc_snap_globals[i]);
+	for (u32 n = 0; n <= K1_MAX_PP; n++) {
+		k1_w32(k1_mc(hw, K1_MC_FREQ), (freq & ~K1_FREQ_FP_MASK) |
+		       (k1_freq_bank(n) & K1_FREQ_FP_MASK));
+		for (size_t i = 0; i < K1_N_SNAP_BANK; i++) {
+			const u32 off = k1_dfc_snap_bank[i];
+			u32 v = k1_r32(k1_mc(hw, off));
+
+			/* the table keeps [31:30] only */
+			if (off == K1_MC_FREQ)
+				v &= ~K1_FREQ_SEL_MASK;
+			k1_tbl_put(hw, idx++, v, off);
+		}
+	}
+	k1_w32(k1_mc(hw, K1_MC_FREQ), freq);
+	for (size_t i = 0; i < K1_N_SNAP_TAIL; i++)
+		k1_tbl_put(hw, k1_dfc_snap_tail[i].idx,
+			   k1_tbl_data(hw, &k1_dfc_snap_tail[i]),
+			   k1_dfc_snap_tail[i].addr);
+	k1_tbl_put(hw, K1_TBL_SNAP_END, ctl0, K1_MC_CTL0 | K1_TBL_EOP);
+
+	for (size_t i = 0; i < K1_N_DFC_MARKS; i++) {
+		const uintptr_t phy = hw->win + K1_PHY_OFF;
+
+		k1_w32(phy + K1_PHY_MARK_DATA, k1_dfc_marks[i][0]);
+		k1_w32(phy + K1_PHY_MARK_ADDR, k1_dfc_marks[i][1]);
+		k1_w32(phy + K1_PHY_MARK_CMD, k1_dfc_marks[i][2]);
+	}
+	k1_log(hw->env, "k1-ddr: DFC table loaded: snapshot 0x%x..0x%x%s\n",
+	       K1_TBL_SNAPSHOT, K1_TBL_SNAP_END, mr21 ? ", MR21" : "");
+}
+
+/* the doc 30 list, read right before the kick and again on a timeout */
+struct k1_dfc_regs {
+	u32 status, ctl0, misc, pre, freq, pi_cfg, pi_status, phy_init;
+	u32 cc_ap, isr, hw_slp, clksel, win_ctl0;
+};
+
+static struct k1_dfc_regs k1_dfc_regs_read(const struct k1_ddr_hw *hw)
+{
+	return (struct k1_dfc_regs){
+		.status = k1_r32(k1_mc(hw, K1_MC_STATUS)),
+		.ctl0 = k1_r32(k1_mc(hw, K1_MC_CTL0)),
+		.misc = k1_r32(k1_mc(hw, K1_MC_MISC)),
+		.pre = k1_r32(k1_mc(hw, K1_MC_DFC_PRE)),
+		.freq = k1_r32(k1_mc(hw, K1_MC_FREQ)),
+		.pi_cfg = k1_r32(k1_mc(hw, K1_MC_PI_CFG)),
+		.pi_status = k1_r32(k1_mc(hw, K1_MC_PI_STATUS)),
+		.phy_init = k1_r32(hw->phy + K1_PHY_INIT),
+		.cc_ap = k1_r32(k1_pmu(hw, K1_PMU_CC_AP)),
+		.isr = k1_r32(k1_pmu(hw, K1_PMU_AP_ISR)),
+		.hw_slp = k1_r32(k1_pmu(hw, K1_PMU_HW_SLP)),
+		.clksel = k1_r32(k1_pmu(hw, K1_PMU_CLKSEL)),
+		.win_ctl0 = k1_r32(hw->win + K1_MC_CTL0),
+	};
+}
+
+static void k1_dfc_regs_log(const struct k1_ddr_hw *hw, const char *when,
+			    const struct k1_dfc_regs *r)
+{
+	k1_log(hw->env, "k1-ddr: dfc %s: status 0x%02x ctl0 0x%08x misc 0x%08x 0x148 0x%08x freq 0x%08x pi_cfg 0x%x pi_status 0x%08x\n",
+	       when, r->status, r->ctl0, r->misc, r->pre, r->freq, r->pi_cfg,
+	       r->pi_status);
+	k1_log(hw->env, "k1-ddr: dfc %s: phy_init 0x%x cc_ap 0x%08x isr 0x%08x hw_slp 0x%08x clksel 0x%08x win ctl0 0x%08x\n",
+	       when, r->phy_init, r->cc_ap, r->isr, r->hw_slp, r->clksel,
+	       r->win_ctl0);
+}
+
+/* doc 30: SR exit gives the DRAM back; a held bit 22 needs an MC reset */
+static void k1_dfc_unstick(const struct k1_ddr_hw *hw, u32 sr)
+{
+	const struct k1_ddrt_env *env = hw->env;
+	u32 st = 0;
+
+	k1_w32(k1_mc(hw, K1_MC_USER0), K1_SR_CMD | K1_SR_EXIT |
+	       (hw->cs_sel << K1_SR_MODE_SHIFT));
+	const bool parked = k1_wait(env, k1_mc(hw, K1_MC_STATUS), sr, 0,
+				    K1_SR_BUDGET_US, &st) != 0;
+	const u32 cc = k1_r32(k1_pmu(hw, K1_PMU_CC_AP));
+
+	k1_log(env, "k1-ddr: after SR exit: status 0x%02x%s, cc_ap 0x%08x%s\n",
+	       st, parked ? " (still parked)" : "", cc,
+	       (cc & K1_CC_DFC_KICK) ? ", bit 22 held: MC reset before any DFC" : "");
+}
+
+int k1_ddr_dfc(const struct k1_ddr_hw *hw, u32 fp)
+{
+	const struct k1_ddrt_env *env = hw->env;
+	const u32 sr = hw->cs_num == 2 ? K1_SR_STAT_2CS : K1_SR_STAT_1CS;
+	const u64 t0 = k1_now(env);
+	u32 v = k1_r32(k1_mc(hw, K1_MC_STATUS));
+
+	if (fp > K1_MAX_PP)
+		return K1_DDRT_EINVAL;
+	/* the engine would park the ranks and never reach the PLL handshake */
+	if (v & sr) {
+		k1_log(env, "k1-ddr: DFC to fp%u refused: status 0x%02x, ranks in self-refresh\n",
+		       fp, v);
+		return K1_DDRT_EIO;
+	}
+	if (k1_r32(k1_pmu(hw, K1_PMU_CC_AP)) & K1_CC_DFC_KICK) {
+		k1_log(env, "k1-ddr: DFC to fp%u refused: bit 22 still held\n", fp);
+		return K1_DDRT_EIO;
+	}
+	k1_rmw32(k1_pmu(hw, K1_PMU_AP_IMR), ~0u, K1_IMR_DCLK_FC);
+	k1_w32(k1_mc(hw, K1_MC_DFC_PRE), K1_DFC_PRE_VAL);
+	k1_w32(k1_pmu(hw, K1_PMU_CLKSEL), k1_clksel[fp]);
+	k1_w32(k1_pmu(hw, K1_PMU_HW_SLP),
+	       K1_HW_SLP_DFC | (fp << K1_HW_SLP_FP_SHIFT));
+	const struct k1_dfc_regs before = k1_dfc_regs_read(hw);
+
+	k1_w32(k1_pmu(hw, K1_PMU_CC_AP), K1_CC_DFC_KICK);
+	if (k1_wait(env, k1_pmu(hw, K1_PMU_CC_AP), K1_CC_DFC_KICK, 0,
+		    K1_FC_BUDGET_US, &v)) {
+		const struct k1_dfc_regs stuck = k1_dfc_regs_read(hw);
+
+		k1_log(env, "k1-ddr: DFC to fp%u not done in %u us, cc_ap 0x%08x\n",
+		       fp, K1_FC_BUDGET_US, v);
+		k1_dfc_regs_log(hw, "before", &before);
+		k1_dfc_regs_log(hw, "stuck", &stuck);
+		k1_dfc_unstick(hw, sr);
+		return K1_DDRT_ETIMEDOUT;
+	}
+
+	const u32 freq = k1_r32(k1_mc(hw, K1_MC_FREQ));
+	const u32 pi_cfg = k1_r32(k1_mc(hw, K1_MC_PI_CFG));
+	const u32 st = k1_r32(k1_mc(hw, K1_MC_STATUS));
+	const u32 clk = k1_r32(k1_pmu(hw, K1_PMU_CLKSEL));
+
+	k1_log(env, "k1-ddr: DFC fp%u in %u us: ctl_freq 0x%08x pi_cfg 0x%x status 0x%02x clksel 0x%08x\n",
+	       fp, (u32)(k1_now(env) - t0), freq, pi_cfg, st, clk);
+	if ((freq & K1_FREQ_FP_MASK) != (k1_freq_bank(fp) & K1_FREQ_FP_MASK) ||
+	    ((pi_cfg & K1_PI_CFG_SEL_MASK) >> K1_PI_CFG_SEL_SHIFT) != fp ||
+	    (clk & K1_CLKSEL_LOCK) != K1_CLKSEL_LOCK || (st & sr))
+		return K1_DDRT_EIO;
+	return K1_DDRT_OK;
+}
diff --git a/drivers/ram/spacemit/k1_ddr_init.h b/drivers/ram/spacemit/k1_ddr_init.h
new file mode 100644
index 00000000000..4cfabdae74f
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_init.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/* Building blocks of the K1 DDR bring-up, sequenced by k1_ddr_boot(). */
+#ifndef K1_DDR_INIT_H
+#define K1_DDR_INIT_H
+
+#include "k1_ddr_boot.h"
+#include "k1_ddr_tables.h"
+
+struct k1_ddr_hw {
+	uintptr_t ddr;
+	uintptr_t phy;
+	uintptr_t pmu;
+	uintptr_t win;		/* DFC table window, MC offsets apply */
+	u32 cs_num;
+	u32 cs_sel;	/* bit 0 CS0, bit 1 CS1 */
+	enum k1_ddr_type type;
+	const struct k1_io_cfg *io;
+	const struct k1_ddrt_env *env;
+};
+
+/* one CS, from MR8 (doc 29) */
+struct k1_ddr_geom {
+	u32 area_mb;
+	u32 code;		/* CS map [20:16] */
+	u32 row;		/* ROW_n */
+	bool x8;
+};
+
+struct k1_ddr_hw k1_ddr_hw_init(const struct k1_ddr_boot_cfg *cfg,
+				const struct k1_ddrt_env *env);
+
+/* PLL1/PLL2, lock, SW-FC to fp0, MC clock (doc 25) */
+__attribute__((warn_unused_result)) int k1_ddr_pll_init(const struct k1_ddr_hw *hw,
+							u32 data_rate, enum k1_ddr_step *step);
+
+/* MC banks, PHY analog, DFI init, JEDEC init, MR, ZQCAL at fp0 (doc 26..28) */
+__attribute__((warn_unused_result)) int k1_ddr_device_init(const struct k1_ddr_hw *hw, bool x8,
+							   enum k1_ddr_step *step);
+
+/* PMU+0xb0 bit 21 pulse; PLLs stay locked (doc 25, 31) */
+void k1_ddr_mc_reset(const struct k1_ddr_hw *hw);
+
+/* CS map size code of one CS, 0 if the size has none */
+u32 k1_ddr_size_code(u32 mb);
+__attribute__((warn_unused_result)) int k1_ddr_geometry(u8 mr8, struct k1_ddr_geom *g);
+void k1_ddr_map_apply(const struct k1_ddr_hw *hw, const struct k1_ddr_geom *g);
+
+/* command flow, timing snapshot and analog markers through the window (doc 30) */
+void k1_ddr_dfc_table_load(const struct k1_ddr_hw *hw, bool mr21);
+
+/*
+ * Hardware DFC to fp (doc 30). Refused while a rank is in self-refresh. On
+ * a timeout the ranks are taken out of self-refresh; kick bit 22 may stay
+ * set, and then no DFC may be kicked before an MC reset.
+ */
+__attribute__((warn_unused_result)) int k1_ddr_dfc(const struct k1_ddr_hw *hw, u32 fp);
+
+/* MR write from the active bank; mr is the low byte of the command */
+void k1_ddr_mr_write(const struct k1_ddr_hw *hw, u32 mr);
+
+#endif /* K1_DDR_INIT_H */
diff --git a/drivers/ram/spacemit/k1_ddr_spl.c b/drivers/ram/spacemit/k1_ddr_spl.c
new file mode 100644
index 00000000000..d5dda2b9050
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_spl.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * U-Boot SPL entry point for the SpacemiT K1 LPDDR4/4X DDR driver.
+ */
+#include <log.h>
+#include <spacemit/k1_ddr.h>
+#include <time.h>
+#include <vsprintf.h>
+#include "k1_ddr_boot.h"
+#include "k1_ddr_eye.h"
+
+#define K1_DDR_BASE	0xc0000000UL
+#define K1_PMU_BASE	0xd4282800UL
+#define K1_DFC_WIN	0xf0000000UL
+
+struct k1_spl_obs {
+	const struct k1_ddrt_env *env;
+	uintptr_t ddr;
+	u32 cs_num;
+	u32 data_rate;
+	enum k1_ddr_type type;
+	u32 pass_idx;
+	int eye_rc;
+};
+
+static u64 k1_spl_now_us(void *ctx)
+{
+	return timer_get_us();
+}
+
+#ifdef DEBUG
+static void k1_spl_vlog(void *ctx, const char *fmt, va_list ap)
+{
+	vprintf(fmt, ap);
+}
+#endif
+
+static int k1_spl_on_pass(void *ctx, const struct k1_ddrt_result *r, u32 pp)
+{
+	struct k1_spl_obs *o = ctx;
+
+	if (!r->rc && !o->eye_rc && o->pass_idx >= 1 &&
+	    pp != k1_ddr_final_fp(o->type, o->data_rate))
+		o->eye_rc = k1_ddr_eye_measure(o->ddr, o->cs_num, pp, o->env);
+
+	o->pass_idx++;
+	return o->eye_rc;
+}
+
+static void k1_spl_prepare(void *ctx, u32 data_rate)
+{
+	struct k1_spl_obs *o = ctx;
+
+	o->pass_idx = 0;
+	o->eye_rc = 0;
+	o->data_rate = data_rate;
+}
+
+static int k1_spl_after(void *ctx, const struct k1_ddr_boot_cfg *cfg,
+			const struct k1_ddrt_env *env,
+			struct k1_ddr_boot_report *rep)
+{
+	struct k1_spl_obs *o = ctx;
+
+	/* Final DFC re-sends MR14 from the bank; re-centre at the live fp */
+	if (!o->eye_rc)
+		o->eye_rc = k1_ddr_eye_measure(cfg->ddr, o->cs_num,
+					       rep->final_pp, env);
+
+	return o->eye_rc;
+}
+
+int spacemit_k1_ddr_init(u32 cs_num, u32 data_rate, bool is_lpddr4)
+{
+	const enum k1_ddr_type type =
+		is_lpddr4 ? K1_DDR_LPDDR4 : K1_DDR_LPDDR4X;
+	const struct k1_ddrt_env env = {
+		.now_us = k1_spl_now_us,
+#ifdef DEBUG
+		.vlog = k1_spl_vlog,
+#endif
+	};
+	struct k1_spl_obs obs = {
+		.env = &env,
+		.ddr = K1_DDR_BASE,
+		.cs_num = cs_num,
+		.data_rate = data_rate,
+		.type = type,
+	};
+	struct k1_ddr_boot_cfg cfg = {
+		.ddr = K1_DDR_BASE,
+		.pmu = K1_PMU_BASE,
+		.dfc_win = K1_DFC_WIN,
+		.cs_num = cs_num,
+		.data_rate = data_rate,
+		.type = type,
+		.on_pass = k1_spl_on_pass,
+		.pass_ctx = &obs,
+	};
+	struct k1_ddr_boot_report rep;
+	int rc;
+
+	rc = k1_ddr_boot_fallback(&cfg, &env, &rep, k1_spl_prepare,
+				  k1_spl_after, &obs);
+	if (rc) {
+		log_err("k1-ddr: init failed at %s (rc=%d)\n",
+			k1_ddr_step_name(rep.fail_step), rc);
+		return rc;
+	}
+
+	log_info("k1-ddr: %s %u MB (%u CS%s) at %u MT/s (fp%u)\n",
+		 is_lpddr4 ? "LPDDR4" : "LPDDR4X", rep.size_mb, cs_num,
+		 rep.byte_mode ? ", x8" : "", cfg.data_rate, rep.final_pp);
+	return 0;
+}
+
diff --git a/drivers/ram/spacemit/k1_ddr_tables.c b/drivers/ram/spacemit/k1_ddr_tables.c
new file mode 100644
index 00000000000..e001da8a522
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_tables.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * Silicon tables of the K1 DDR bring-up. Per-fp rows list fp3, fp2, fp1,
+ * fp0 in the order of the documentation tables.
+ */
+#include "k1_ddr_tables.h"
+
+#define ROW(o, f3, f2, f1, f0) \
+	{ .off = (o), .fp = { [3] = (f3), [2] = (f2), [1] = (f1), [0] = (f0) } }
+#define IO_ROW(o) { .off = (o), .io = true }
+
+/* doc 26, MC globals */
+const struct k1_reg_val k1_mc_globals[K1_N_MC_GLOBALS] = {
+	{ 0x044, 0x00040300 },
+	{ 0x048, 0x00000001 },
+	{ 0x050, 0x000000ff },
+	{ 0x058, 0x3fd53fd5 },
+	{ 0x064, 0x100d0803 },
+	{ 0x080, 0x00000000 },
+	{ 0x180, 0x00010200 },
+	{ 0xa00, 0x00000000 },
+	{ 0xac0, 0x00000000 },
+	{ 0xacc, 0xffffffff },
+	{ 0x200, 0x00100001 },
+	{ 0x204, 0x00000000 },
+	{ 0x208, 0x00100001 },
+	{ 0x20c, 0x00000001 },
+	{ 0x220, 0x05030732 },
+	{ 0x224, 0x05030732 },
+	{ 0x2c0, 0x14008000 },
+	{ 0x2c4, 0x000000b8 },
+	{ 0x2c8, 0x0000ffff },
+	{ 0x2cc, 0x00000000 },
+};
+
+/*
+ * Programmed LPDDR4X timing banks (fp3, fp2, fp1, fp0). These are the
+ * boot words, not measured optima. Isolated fp2 accepted ranges and
+ * latency optima: docs/firmware/timing-sweep.rst (logsRefs/031).
+ * Must-keep on 16 GiB live fp2: +0x300[15:8]=12, +0x3fc[7:0]=0x5e,
+ * +0x13e4 overlay bytes, +0x3b4[31:24] >= 5. 8 GiB: +0x3ac[15:8]
+ * 24→16 load-faults (logsRefs/033). Candidate intersection (not shipped):
+ * +0x3b0[7:0]=16, +0x3a0[15:8]=3, +0x3fc[23:16]=4, +0x3ac[15:8]=17.
+ */
+const struct k1_bank_row k1_mc_timing[K1_N_MC_TIMING] = {
+	ROW(0x300,  0x00000c18, 0x00000c18, 0x0000080e, 0x0000080e),
+	IO_ROW(0x30c),
+	IO_ROW(0x310),
+	IO_ROW(0x314),
+	ROW(0x34c,  0x0007204a, 0x0007204a, 0x00030848, 0x00030848),
+	ROW(0x38c,  0x00360020, 0x00430000, 0x00280018, 0x00280018),
+	ROW(0x390,  0x042a0020, 0x05350028, 0x03200018, 0x03200018),
+	ROW(0x394,  0x8096012b, 0x80a80151, 0x807000e0, 0x805400a8),
+	ROW(0x398,  0x01330133, 0x017f017f, 0x00e600e6, 0x00e600e6),
+	ROW(0x39c,  0x00101010, 0x00141414, 0x000c0c0c, 0x000c0c0c),
+	ROW(0x3a0,  0x06100808, 0x07140a0a, 0x050c0606, 0x050c0606),
+	ROW(0x3a4,  0x00000003, 0x00000003, 0x00000003, 0x00000003),
+	ROW(0x3a8,  0x0000020f, 0x00000213, 0x0000020c, 0x0000020c),
+	ROW(0x3ac,  0x2044142d, 0x36541838, 0x18330f22, 0x18330f22),
+	ROW(0x3b0,  0x17140814, 0x1c180a18, 0x110f080f, 0x110f080f),
+	ROW(0x3b4,  0x08000b00, 0x08000e00, 0x08000800, 0x08000800),
+	ROW(0x3b8,  0x00000800, 0x00000e00, 0x00000600, 0x00000600),
+	ROW(0x3bc,  0x02020404, 0x02020404, 0x02020404, 0x02020404),
+	ROW(0x3c0,  0x00000004, 0x10000004, 0x00000003, 0x00000002),
+	ROW(0x3c4,  0x00000004, 0x00000004, 0x00000003, 0x00000003),
+	ROW(0x3d8,  0x00008190, 0x0000d94e, 0x00008190, 0x00008190),
+	ROW(0x3fc,  0x000d0065, 0x000c005e, 0x000c005e, 0x000c005e),
+	ROW(0x13e4, 0x13000802, 0x13000802, 0x0a000402, 0x0a000402),
+	ROW(0x13ec, 0x00000480, 0x00000450, 0x00000480, 0x00000480),
+};
+
+/* doc 31, byte-mode x8 re-init */
+const struct k1_bank_row k1_mc_x8_overlay[K1_N_X8_OVERLAY] = {
+	ROW(0x13e4, 0x19000a02, 0x15000802, 0x0c000402, 0x0c000402),
+	ROW(0x3b4,  0x08001400, 0x08001000, 0x08000a00, 0x08000a00),
+};
+
+/* doc 26, LPDDR4 only: ddr+0x400 in every bank */
+const u32 k1_mc_wdqs[4] = {
+	[3] = 0x80001e06,
+	[2] = 0x80001b04,
+	[1] = 0x80001500,
+	[0] = 0x80001500,
+};
+
+/* doc 26, written once after fp0 is selected */
+const struct k1_reg_val k1_mc_refresh[3] = {
+	{ 0x380, 0x0030d400 },
+	{ 0x384, 0x0004e200 },
+	{ 0x388, 0x0c800000 },
+};
+
+/* doc 25, PMU+0x3b4 per fp */
+const u32 k1_clksel[4] = {
+	[0] = 0x3b50,
+	[1] = 0x3b04,
+	[2] = 0x3b40,
+	[3] = 0x3b00,
+};
+
+/* doc 26 / 27: ODT Tx 80, Rx drv 60, Tx 40/40, Rx ODT 60 */
+const struct k1_io_cfg k1_io_lpddr4x = {
+	.ca_vref = 0x9d, .tx_vref = 0x19, .soc_odt = 4,
+	.tx_odt = 3, .rx_drv = 4,
+	.tx_pdrv = 6, .tx_ndrv = 6, .rx_odt = 4,
+	.rx_vref = 0x55, .rx_pu_cal = 0,
+};
+
+/* doc 27 / 31: SoC ODT 80, ODT Tx 120, Tx 48/60, Rx ODT 120 */
+const struct k1_io_cfg k1_io_lpddr4 = {
+	.ca_vref = 0xb2, .tx_vref = 0xa7, .soc_odt = 3,
+	.tx_odt = 2, .rx_drv = 4,
+	.tx_pdrv = 5, .tx_ndrv = 4, .rx_odt = 2,
+	.rx_vref = 0x33, .rx_pu_cal = 0,
+};
+
+/* doc 28: around ZQCAL */
+const u8 k1_mr_init1[K1_N_MR_INIT1] = { 1, 2, 13, 3, 22 };
+const u8 k1_mr_init2[K1_N_MR_INIT2] = { 12, 14, 11, 23 };
+
+/* doc 30, command flow for the 2 CS case */
+const struct k1_tbl_entry k1_dfc_flow[K1_N_DFC_FLOW] = {
+	{ 0x00040303, 0x00000044, 0x00 },
+	{ 0x13000008, 0x00000020, 0x01 },
+	{ 0x13010000, 0x00000028, 0x02 },
+	{ 0x1302000d, 0x00000024, 0x03 },
+	{ 0x13020001, 0x00000024, 0x04 },
+	{ 0x13020002, 0x00000024, 0x05 },
+	{ 0x13020003, 0x00000024, 0x06 },
+	{ 0x1302000b, 0x00000024, 0x07 },
+	{ 0x1302000c, 0x00000024, 0x08 },
+	{ 0x1302000e, 0x00000024, 0x09 },
+	{ 0x13020016, 0x00000024, 0x0a },
+	{ 0x13008000, 0x00000028, 0x0b },
+	{ 0x1302000d, 0x00000024, 0x0c },
+	{ 0x13000010, 0x00000020, 0x0d },
+	{ 0x00000002, 0x00002008, 0x0e },
+	{ 0x00000002, 0x00002008, 0x0f },
+	{ 0x13000001, 0x000013d0, 0x10 },
+	{ 0x00008000, 0x000033fc, 0x11 },
+	{ 0x00000000, 0x000033fc, 0x12 },
+	{ 0x00040303, 0x00010044, 0x13 },
+	{ 0x10000100, 0x000013d0, 0x14 },
+	{ 0x00008000, 0x000033fc, 0x15 },
+	{ 0x00008000, 0x000033fc, 0x16 },
+	{ 0x13000004, 0x00000020, 0x17 },
+	{ 0x1302000d, 0x00000024, 0x18 },
+	{ 0x00000002, 0x00002008, 0x19 },
+	{ 0x00000000, 0x00002008, 0x1a },
+	{ 0x00040380, 0x00020044, 0x1b },
+	{ 0x00040380, 0x00020044, 0x12e },
+};
+
+const struct k1_tbl_entry k1_dfc_exit[K1_N_DFC_EXIT] = {
+	{ 0x00040b43, 0x00000044, 0x180 },
+	{ 0x13000010, 0x00000020, 0x181 },
+	{ 0x00000002, 0x00002008, 0x182 },
+	{ 0x00000002, 0x00002008, 0x183 },
+	{ 0x13000001, 0x000013d0, 0x184 },
+	{ 0x00008000, 0x000033fc, 0x185 },
+	{ 0x00000000, 0x000033fc, 0x186 },
+	{ 0x00040b43, 0x00010044, 0x187 },
+	{ 0x10000100, 0x000013d0, 0x188 },
+	{ 0x00008000, 0x000033fc, 0x189 },
+	{ 0x00008000, 0x000033fc, 0x18a },
+	{ 0x1302000d, 0x00000024, 0x18b },
+	{ 0x00000002, 0x00002008, 0x18c },
+	{ 0x00000000, 0x00002008, 0x18d },
+	{ 0x00040b00, 0x00020044, 0x18e },
+};
+
+/* doc 30, snapshot: CTL0 first, these globals once, then the bank block per fp */
+const u16 k1_dfc_snap_globals[K1_N_SNAP_GLOBALS] = {
+	0x048, 0x054, 0x058, 0x060, 0x064, 0x148, 0x14c,
+	0x200, 0x204, 0x208, 0x20c, 0x220, 0x224,
+	0x2c4, 0x2c0, 0x380, 0x384, 0x388,
+	0x080, 0xa00, 0xac0, 0xacc,
+};
+
+const u16 k1_dfc_snap_bank[K1_N_SNAP_BANK] = {
+	0x304,
+	0x300, 0x30c, 0x310, 0x314,
+	0x38c, 0x390, 0x394, 0x398, 0x39c, 0x3a0, 0x3a4,
+	0x3a8, 0x3ac, 0x3b0, 0x3b4, 0x3b8, 0x3bc, 0x3c0,
+	0x3c4, 0x400, 0x3d8, 0x34c,
+	0x13e4, 0x13ec,
+};
+
+/* doc 30, after the four bank blocks; the CTL0 line with EOP closes it */
+const struct k1_tbl_entry k1_dfc_snap_tail[K1_N_SNAP_TAIL] = {
+	{ 0x00020200, 0x000013e0, 0x27b },
+	{ 0x13000010, 0x000013d0, 0x27c },
+	{ 0x00010000, 0x000033fc, 0x27d },
+	{ 0x00010000, 0x000033fc, 0x27e },
+	{ 0x13000008, 0x00000020, 0x27f },
+	{ 0x13000004, 0x00000020, 0x280 },
+	{ 0x13020000, 0x00000028, 0x281 },
+	{ 0x13000001, 0x000013d0, 0x282 },
+	{ 0x00008000, 0x000033fc, 0x283 },
+	{ 0x00008000, 0x000033fc, 0x284 },
+	{ 0x10000100, 0x000013d0, 0x285 },
+	{ 0x00008000, 0x000033fc, 0x286 },
+	{ 0x00008000, 0x000033fc, 0x287 },
+	{ 0x1302000d, 0x00000024, 0x288 },
+	{ 0x13020003, 0x00000024, 0x289 },
+};
+
+const u32 k1_dfc_marks[K1_N_DFC_MARKS][3] = {
+	{ 0x00001100, 0x00010000, 0x20 },
+	{ 0x000000ff, 0x0001001c, 0x21 },
+	{ 0x00000000, 0x0005001c, 0x22 },
+};
diff --git a/drivers/ram/spacemit/k1_ddr_tables.h b/drivers/ram/spacemit/k1_ddr_tables.h
new file mode 100644
index 00000000000..fbdc067de45
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddr_tables.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * Silicon tables of the K1 DDR bring-up (docs 25, 26, 27, 30, 31).
+ * Kept apart from the code so test/check_tables.py can diff them against
+ * the documentation.
+ */
+#ifndef K1_DDR_TABLES_H
+#define K1_DDR_TABLES_H
+
+#include <stddef.h>
+#include <stdbool.h>
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct k1_reg_val {
+	u16 off;
+	u32 val;
+};
+
+/* one MC word per frequency point; io rows are computed from k1_io_cfg */
+struct k1_bank_row {
+	u16 off;
+	bool io;
+	u32 fp[4];
+};
+
+struct k1_tbl_entry {
+	u32 data;
+	u32 addr;		/* MC offset | flags */
+	u16 idx;
+};
+
+/* resistance encodings 1=240 2=120 3=80 4=60 5=48 6=40 ohm */
+struct k1_io_cfg {
+	u8 ca_vref;	/* ddr+0x30c[31:24], MR12 */
+	u8 tx_vref;	/* ddr+0x30c[23:16], MR14 seed */
+	u8 soc_odt;	/* ddr+0x30c[15:12] */
+	u8 tx_odt;		/* ddr+0x310/314[22:20] */
+	u8 rx_drv;		/* ddr+0x310/314[19:16] */
+	u8 tx_pdrv;	/* COMMON+0xc[15:13] */
+	u8 tx_ndrv;	/* COMMON+0xc[12:10] */
+	u8 rx_odt;		/* COMMON+0xc[21:16], twice */
+	u8 rx_vref;	/* COMMON+0x4[31:16], twice */
+	u8 rx_pu_cal;	/* ddr+0x2c8[17], VOH */
+};
+
+#define K1_N_MC_GLOBALS ((size_t)(20))
+#define K1_N_MC_TIMING ((size_t)(24))
+#define K1_N_X8_OVERLAY ((size_t)(2))
+#define K1_N_DFC_FLOW ((size_t)(29))
+#define K1_N_DFC_EXIT ((size_t)(15))
+#define K1_N_SNAP_GLOBALS ((size_t)(22))
+#define K1_N_SNAP_BANK ((size_t)(25))
+#define K1_N_SNAP_TAIL ((size_t)(15))
+#define K1_N_MR_INIT1 ((size_t)(5))
+#define K1_N_MR_INIT2 ((size_t)(4))
+#define K1_N_DFC_MARKS ((size_t)(3))
+
+/* where MR21 goes in each command sequence when the part is 16 GiB */
+#define K1_DFC_FLOW_MR21_AFTER ((u16)(0x18))
+#define K1_DFC_FLOW_RUN_END ((u16)(0x1b))
+#define K1_DFC_EXIT_MR21_AFTER ((u16)(0x18b))
+#define K1_DFC_EXIT_RUN_END ((u16)(0x18e))
+
+extern const struct k1_reg_val k1_mc_globals[K1_N_MC_GLOBALS];
+extern const struct k1_bank_row k1_mc_timing[K1_N_MC_TIMING];
+extern const struct k1_bank_row k1_mc_x8_overlay[K1_N_X8_OVERLAY];
+extern const u32 k1_mc_wdqs[4];
+extern const struct k1_reg_val k1_mc_refresh[3];
+extern const u32 k1_clksel[4];
+extern const struct k1_io_cfg k1_io_lpddr4x;
+extern const struct k1_io_cfg k1_io_lpddr4;
+extern const u8 k1_mr_init1[K1_N_MR_INIT1];
+extern const u8 k1_mr_init2[K1_N_MR_INIT2];
+extern const struct k1_tbl_entry k1_dfc_flow[K1_N_DFC_FLOW];
+extern const struct k1_tbl_entry k1_dfc_exit[K1_N_DFC_EXIT];
+extern const u16 k1_dfc_snap_globals[K1_N_SNAP_GLOBALS];
+extern const u16 k1_dfc_snap_bank[K1_N_SNAP_BANK];
+extern const struct k1_tbl_entry k1_dfc_snap_tail[K1_N_SNAP_TAIL];
+extern const u32 k1_dfc_marks[K1_N_DFC_MARKS][3];	/* +0x10104, +0x10108, +0x10100 */
+
+#endif /* K1_DDR_TABLES_H */
diff --git a/drivers/ram/spacemit/k1_ddrt.c b/drivers/ram/spacemit/k1_ddrt.c
new file mode 100644
index 00000000000..1ac51701d5b
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddrt.c
@@ -0,0 +1,627 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 LPDDR4/4X training pass.
+ *
+ *   enter SR -> PHY_INIT -> WL -> read gate -> Rx Vref sweep -> Tx Vref
+ *   sweep -> PHY_STATUS -> exit SR
+ *
+ * The PI engine finds the edges; this code only arms it, sweeps Vref,
+ * applies the max-min rule and re-runs the PI at the winning Vref.
+ */
+#include <stddef.h>
+#include "k1_ddrt.h"
+#include "k1_ddrt_io.h"
+#include "k1_ddrt_priv.h"
+#include "k1_ddrt_regs.h"
+
+/* the PI has no hardware timeout; observed stages take 10..122 ms */
+#define K1_PI_BUDGET_US ((u32)(1000000))
+#define K1_SR_BUDGET_US ((u32)(10000))
+#define K1_MR_BUDGET_US ((u32)(10000))
+#define K1_DEFAULT_POLL_LIMIT ((u32)(100000000))
+
+struct k1_pass {
+	const struct k1_ddrt_env *env;
+	struct k1_ddrt_result *res;
+	struct k1_ddrt_pi_stats *pi;
+	uintptr_t ddr;
+	uintptr_t phy;
+	uintptr_t slice;
+	u32 cs_num;
+	u32 poll_limit;
+};
+
+struct k1_harvest {
+	u8 dq[K1_N_DQ];
+	u8 dm[K1_N_BYTES];
+};
+
+void k1_log(const struct k1_ddrt_env *env, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (!env || !env->vlog)
+		return;
+	va_start(ap, fmt);
+	env->vlog(env->ctx, fmt, ap);
+	va_end(ap);
+}
+
+u64 k1_now(const struct k1_ddrt_env *env)
+{
+	return (env && env->now_us) ? env->now_us(env->ctx) : 0;
+}
+
+void k1_udelay(const struct k1_ddrt_env *env, u32 us)
+{
+	const u64 t0 = k1_now(env);
+
+	if (!env || !env->now_us)
+		return;
+	while (k1_now(env) - t0 < us)
+		;
+}
+
+static u32 k1_poll_limit(const struct k1_ddrt_env *env)
+{
+	return (env && env->poll_limit) ? env->poll_limit : K1_DEFAULT_POLL_LIMIT;
+}
+
+int k1_wait_n(const struct k1_ddrt_env *env, uintptr_t addr, u32 mask,
+	      u32 want, u32 budget_us, u32 *last,
+	      u32 *polls)
+{
+	const bool timed = env && env->now_us;
+	const u32 limit = k1_poll_limit(env);
+	const u64 t0 = k1_now(env);
+	u32 v = 0;
+	u32 n = 0;
+	int rc = K1_DDRT_ETIMEDOUT;
+
+	while (n < limit) {
+		v = k1_r32(addr);
+		n++;
+		if ((v & mask) == want) {
+			rc = K1_DDRT_OK;
+			break;
+		}
+		if (timed && k1_now(env) - t0 > budget_us)
+			break;
+	}
+	if (last)
+		*last = v;
+	if (polls)
+		*polls = n;
+	return rc;
+}
+
+int k1_wait(const struct k1_ddrt_env *env, uintptr_t addr, u32 mask,
+	    u32 want, u32 budget_us, u32 *last)
+{
+	return k1_wait_n(env, addr, mask, want, budget_us, last, NULL);
+}
+
+const char *k1_ddrt_stage_name(enum k1_ddrt_stage stage)
+{
+	switch (stage) {
+	case K1_STAGE_NONE:	return "none";
+	case K1_STAGE_ARGS:	return "args";
+	case K1_STAGE_SR_ENTER:	return "sr-enter";
+	case K1_STAGE_WL:	return "write-leveling";
+	case K1_STAGE_GATE:	return "read-gate";
+	case K1_STAGE_RX:	return "read-training";
+	case K1_STAGE_TX:	return "write-training";
+	case K1_STAGE_SR_EXIT:	return "sr-exit";
+	case K1_STAGE_STATUS:	return "phy-status";
+	case K1_STAGE_MR:	return "mode-register";
+	}
+	return "?";
+}
+
+static int k1_fail(struct k1_pass *p, int rc, enum k1_ddrt_stage stage,
+		   u32 cs)
+{
+	p->res->rc = rc;
+	p->res->fail_stage = stage;
+	p->res->fail_cs = (u8)cs;
+	k1_log(p->env, "k1-ddrt: %s failed: cs %u rc %d pi_status 0x%08x\n",
+	       k1_ddrt_stage_name(stage), cs, rc, p->res->pi_status);
+	return rc;
+}
+
+static uintptr_t k1_byte_base(const struct k1_pass *p, u32 cs0,
+			      u32 byte)
+{
+	return p->slice + K1_BYTE_OFF[byte] + (cs0 << K1_PHY_CS_SHIFT);
+}
+
+static int k1_pi_op(struct k1_pass *p, u32 op, u32 cs,
+		    u32 done, u32 *status, u32 *first)
+{
+	const uintptr_t stat = p->ddr + K1_MC_PI_STATUS;
+	struct k1_ddrt_pi_stats *s = p->pi;
+	const u64 t0 = k1_now(p->env);
+	u32 st = 0;
+	u32 polls = 0;
+	int rc;
+
+	k1_w32(p->ddr + K1_MC_PI_CMD, op | (cs << K1_PI_CS_SHIFT));
+	const u32 snap = k1_r32(stat);
+	/* the write drops the op's done bits; seeing them set here means it did not */
+	const bool stale = (snap & done) == done;
+
+	rc = k1_wait_n(p->env, stat, done, done, K1_PI_BUDGET_US, &st, &polls);
+	p->res->pi_status = st;
+	if (status)
+		*status = st;
+	if (first)
+		*first = snap;
+
+	if (s) {
+		const u32 us = (u32)(k1_now(p->env) - t0);
+
+		if (s->ops < UINT16_MAX)
+			s->ops++;
+		if (stale && s->stale_first < UINT16_MAX)
+			s->stale_first++;
+		if (polls > s->max_polls)
+			s->max_polls = polls;
+		if (us > s->max_us)
+			s->max_us = us;
+	}
+	return rc;
+}
+
+static u32 k1_sr_mode(u32 cs_num)
+{
+	return cs_num == 2 ? 3 : 1;
+}
+
+static u32 k1_sr_mask(u32 cs_num)
+{
+	return cs_num == 2 ? K1_SR_STAT_2CS : K1_SR_STAT_1CS;
+}
+
+static int k1_sr_enter(struct k1_pass *p)
+{
+	const u32 mask = k1_sr_mask(p->cs_num);
+
+	k1_w32(p->ddr + K1_MC_USER0, K1_SR_CMD | K1_SR_ENTER |
+	       (k1_sr_mode(p->cs_num) << K1_SR_MODE_SHIFT));
+	return k1_wait(p->env, p->ddr + K1_MC_STATUS, mask, mask,
+		       K1_SR_BUDGET_US, NULL);
+}
+
+/* exit waits only for the SR bits to drop: STATUS goes 0x77 -> 0x11, not 0x33 */
+static int k1_sr_exit(struct k1_pass *p)
+{
+	const u32 mask = k1_sr_mask(p->cs_num);
+
+	k1_w32(p->ddr + K1_MC_USER0, K1_SR_CMD | K1_SR_EXIT |
+	       (k1_sr_mode(p->cs_num) << K1_SR_MODE_SHIFT));
+	return k1_wait(p->env, p->ddr + K1_MC_STATUS, mask, 0,
+		       K1_SR_BUDGET_US, NULL);
+}
+
+/* the harvest latches only the last PI op: copy it before the next CS */
+static u8 k1_harvest_take(uintptr_t base, struct k1_harvest *h)
+{
+	u32 w[K1_N_DQ / 4];
+	u32 dm;
+	u8 worst = UINT8_MAX;
+
+	for (u32 g = 0; g < K1_N_DQ / 4; g++)
+		w[g] = k1_r32(base + 4 * g);
+	dm = k1_r32(base + K1_PHY_HARVEST_DM);
+
+	for (u32 g = 0; g < K1_N_DQ / 4; g++) {
+		for (u32 k = 0; k < 4; k++) {
+			const u8 m = (u8)(w[g] >> (8 * k));
+
+			h->dq[4 * g + k] = m;
+			if (m < worst)
+				worst = m;
+		}
+	}
+	/* DM margins are kept but never weigh in the minimum */
+	for (u32 k = 0; k < K1_N_BYTES; k++)
+		h->dm[k] = (u8)(dm >> (8 * k));
+	return worst;
+}
+
+static void k1_read_lanes(const struct k1_pass *p, u32 cs0,
+			  u32 off, u32 mask,
+			  u8 out[K1_N_BYTES][K1_N_LANES])
+{
+	for (u32 b = 0; b < K1_N_BYTES; b++)
+		for (u32 l = 0; l < K1_N_LANES; l++)
+			out[b][l] = (u8)(k1_r32(k1_byte_base(p, cs0, b) +
+						     off + 4 * l) & mask);
+}
+
+u32 k1_ddrt_max_min(const u8 min_per_step[16])
+{
+	u32 best = 0;
+
+	for (u32 s = 1; s < K1_N_VREF; s++)
+		if (min_per_step[s] > min_per_step[best])
+			best = s;
+	return best;
+}
+
+static int k1_stage_wl(struct k1_pass *p)
+{
+	k1_w32(p->ddr + K1_MC_PI_WL_CFG, K1_PI_WL_CFG_VAL);
+	for (u32 cs = 1; cs <= p->cs_num; cs++) {
+		const int rc = k1_pi_op(p, K1_PI_OP_WL, cs, K1_PI_DONE_WL,
+					NULL, NULL);
+
+		if (rc)
+			return k1_fail(p, rc, K1_STAGE_WL, cs);
+	}
+	return K1_DDRT_OK;
+}
+
+/* trained code is (1 << 16) | (g << 8) | g; reset value 0x0a00 is not */
+static bool k1_gate_code_ok(u32 v)
+{
+	return (v & (1u << 16)) && (v & 0xff) == ((v >> 8) & 0xff);
+}
+
+/*
+ * RGATE clears only bit 1. With bit 2 still 0 right after the command the
+ * classic (st & 6) == 6 tells PASS from TIMEOUT; with a leftover bit 2 from
+ * an earlier RD it cannot, and the PHY gate-error bit decides.
+ */
+static int k1_stage_gate(struct k1_pass *p)
+{
+	for (u32 cs = 1; cs <= p->cs_num; cs++) {
+		u32 st = 0, snap = 0;
+		int rc = k1_pi_op(p, K1_PI_OP_RGATE, cs, K1_PI_DONE_RGATE, &st,
+				  &snap);
+
+		if (rc)
+			return k1_fail(p, rc, K1_STAGE_GATE, cs);
+		if (!(snap & K1_PI_GATE_BIT2)) {
+			if ((st & K1_PI_GATE_MASK) != K1_PI_GATE_PASS) {
+				k1_log(p->env,
+				       "k1-ddrt: read-gate TIMEOUT on cs %u (pi_status 0x%08x)\n",
+				       cs, st);
+				return k1_fail(p, K1_DDRT_EIO, K1_STAGE_GATE,
+					       cs);
+			}
+		} else {
+			const u32 ps = k1_r32(p->phy + K1_PHY_TRAIN_STAT);
+
+			if (ps & K1_ST_RGATE) {
+				k1_log(p->env,
+				       "k1-ddrt: read-gate error on cs %u (phy_status 0x%x)\n",
+				       cs, ps);
+				return k1_fail(p, K1_DDRT_EIO, K1_STAGE_GATE,
+					       cs);
+			}
+		}
+	}
+
+	for (u32 cs0 = 0; cs0 < p->cs_num; cs0++) {
+		for (u32 b = 0; b < K1_N_BYTES; b++) {
+			const u32 v = k1_r32(k1_byte_base(p, cs0, b) +
+						  K1_BYTE_GATE);
+
+			if (!k1_gate_code_ok(v)) {
+				k1_log(p->env,
+				       "k1-ddrt: cs %u byte %u gate 0x%08x not trained\n",
+				       cs0 + 1, b, v);
+				return k1_fail(p, K1_DDRT_EIO, K1_STAGE_GATE,
+					       cs0 + 1);
+			}
+		}
+	}
+	return K1_DDRT_OK;
+}
+
+static void k1_set_rx_vref(struct k1_pass *p, u32 step)
+{
+	const uintptr_t v0 = p->slice + K1_SLICE_VREF0;
+	const u32 packed = (k1_r32(v0) & K1_VREF_LO_MASK) |
+				k1_pack_vref(step);
+
+	k1_w32(v0, packed);
+	k1_w32(p->slice + K1_SLICE_VREF1, packed);
+}
+
+static int k1_stage_rx(struct k1_pass *p)
+{
+	const uintptr_t v0 = p->slice + K1_SLICE_VREF0;
+	struct k1_harvest h;
+	u8 taps[K1_N_BYTES][K1_N_LANES];
+	u32 best;
+	int rc;
+
+	k1_rmw32(v0, ~K1_VREF_BIT4, 0);
+	k1_w32(p->ddr + K1_MC_PI_RD_CFG, K1_PI_RD_CFG_VAL);
+
+	for (u32 step = 0; step < K1_N_VREF; step++) {
+		u8 worst = UINT8_MAX;
+
+		k1_set_rx_vref(p, step);
+		for (u32 cs = 1; cs <= p->cs_num; cs++) {
+			rc = k1_pi_op(p, K1_PI_OP_RD, cs, K1_PI_DONE_RD, NULL,
+				      NULL);
+			if (rc)
+				return k1_fail(p, rc, K1_STAGE_RX, cs);
+
+			const u8 m = k1_harvest_take(p->phy +
+							  K1_PHY_HARVEST_RX, &h);
+			k1_read_lanes(p, cs - 1, K1_BYTE_RX_DQ, K1_RX_DLY_MASK,
+				      taps);
+			p->res->rx_min_cs[cs - 1][step] = m;
+			if (m < worst)
+				worst = m;
+			if (p->env && p->env->verbose)
+				k1_log(p->env,
+				       "k1-ddrt:   rx step %2u cs %u min %3u dq0 %2u %2u %2u %2u\n",
+				       step, cs, m, taps[0][0], taps[1][0],
+				       taps[2][0], taps[3][0]);
+		}
+		p->res->rx_min[step] = worst;
+	}
+
+	/* the sweep may arm the read-leveling bit even when the winner is good */
+	k1_rmw32(p->phy + K1_PHY_TRAIN_STAT, ~K1_ST_RL, 0);
+
+	best = k1_ddrt_max_min(p->res->rx_min);
+	p->res->rx_vref_idx = (u8)best;
+	k1_set_rx_vref(p, best);
+	for (u32 cs = 1; cs <= p->cs_num; cs++) {
+		rc = k1_pi_op(p, K1_PI_OP_RD, cs, K1_PI_DONE_RD, NULL,
+			      NULL);
+		if (rc)
+			return k1_fail(p, rc, K1_STAGE_RX, cs);
+	}
+	k1_rmw32(v0, ~0u, K1_VREF_BIT4);
+	return K1_DDRT_OK;
+}
+
+/* the die only sees a new Vref(DQ) once the MR14 command is sent */
+static void k1_set_mr14(struct k1_pass *p, u32 vref_dq)
+{
+	k1_rmw32(p->ddr + K1_MC_TXVREF, K1_TXVREF_MASK,
+		 (vref_dq & K1_TXVREF_FIELD) << K1_TXVREF_SHIFT);
+	k1_w32(p->ddr + K1_MC_CA_CMD, k1_ca_mr14(p->cs_num));
+}
+
+static int k1_stage_tx(struct k1_pass *p)
+{
+	struct k1_harvest h;
+	u8 taps[K1_N_BYTES][K1_N_LANES];
+	u32 best;
+	int rc;
+
+	k1_w32(p->ddr + K1_MC_PI_WR_CFG, K1_PI_WR_CFG_VAL);
+
+	for (u32 i = 0; i < K1_N_VREF; i++) {
+		u8 worst = UINT8_MAX;
+
+		k1_set_mr14(p, K1_TX_VREF_SEED0 + i);
+		for (u32 cs = 1; cs <= p->cs_num; cs++) {
+			rc = k1_pi_op(p, K1_PI_OP_WR, cs, K1_PI_DONE_WR, NULL,
+				      NULL);
+			if (rc)
+				return k1_fail(p, rc, K1_STAGE_TX, cs);
+
+			const u8 m = k1_harvest_take(p->phy +
+							  K1_PHY_HARVEST_TX, &h);
+			k1_read_lanes(p, cs - 1, K1_BYTE_TX_DQ, K1_TX_DLY_MASK,
+				      taps);
+			p->res->tx_min_cs[cs - 1][i] = m;
+			if (m < worst)
+				worst = m;
+			if (p->env && p->env->verbose)
+				k1_log(p->env,
+				       "k1-ddrt:   tx vdq %2u cs %u min %3u dq0 %2u %2u %2u %2u\n",
+				       K1_TX_VREF_SEED0 + i, cs, m, taps[0][0],
+				       taps[1][0], taps[2][0], taps[3][0]);
+		}
+		p->res->tx_min[i] = worst;
+	}
+
+	best = k1_ddrt_max_min(p->res->tx_min);
+	if (p->res->tx_min[best] == 0)
+		best = K1_TX_FALLBACK_IDX;
+	p->res->tx_vref_dq = (u8)(K1_TX_VREF_SEED0 + best);
+
+	k1_set_mr14(p, p->res->tx_vref_dq);
+	for (u32 cs = 1; cs <= p->cs_num; cs++) {
+		rc = k1_pi_op(p, K1_PI_OP_WR, cs, K1_PI_DONE_WR, NULL,
+			      NULL);
+		if (rc)
+			return k1_fail(p, rc, K1_STAGE_TX, cs);
+	}
+	return K1_DDRT_OK;
+}
+
+static void k1_collect(struct k1_pass *p)
+{
+	struct k1_ddrt_result *r = p->res;
+
+	r->vref0 = k1_r32(p->slice + K1_SLICE_VREF0);
+	r->vref1 = k1_r32(p->slice + K1_SLICE_VREF1);
+	r->txvref = k1_r32(p->ddr + K1_MC_TXVREF);
+	for (u32 cs0 = 0; cs0 < p->cs_num; cs0++) {
+		for (u32 b = 0; b < K1_N_BYTES; b++) {
+			const uintptr_t base = k1_byte_base(p, cs0, b);
+
+			r->wl[cs0][b] = k1_r32(base + K1_BYTE_WL);
+			r->gate[cs0][b] = k1_r32(base + K1_BYTE_GATE);
+			r->tx_dm[cs0][b] = (u8)(k1_r32(base + K1_BYTE_TX_DM) &
+						     K1_TX_DLY_MASK);
+		}
+		k1_read_lanes(p, cs0, K1_BYTE_RX_DQ, K1_RX_DLY_MASK,
+			      r->rx_dq[cs0]);
+		k1_read_lanes(p, cs0, K1_BYTE_TX_DQ, K1_TX_DLY_MASK,
+			      r->tx_dq[cs0]);
+	}
+}
+
+static bool k1_cfg_ok(const struct k1_ddrt_cfg *cfg)
+{
+	return cfg && cfg->ddr && cfg->cs_num >= 1 && cfg->cs_num <= K1_MAX_CS &&
+	       cfg->boot_pp <= K1_MAX_PP;
+}
+
+static struct k1_pass k1_pass_init(const struct k1_ddrt_cfg *cfg,
+				   const struct k1_ddrt_env *env,
+				   struct k1_ddrt_result *res)
+{
+	return (struct k1_pass){
+		.env = env,
+		.res = res,
+		.ddr = cfg->ddr,
+		.phy = cfg->ddr + K1_PHY_OFF,
+		.slice = cfg->ddr + K1_PHY_OFF +
+			 (cfg->boot_pp << K1_PHY_SLICE_SHIFT),
+		.cs_num = cfg->cs_num,
+		.poll_limit = k1_poll_limit(env),
+	};
+}
+
+int k1_ddrt_snapshot(const struct k1_ddrt_cfg *cfg, struct k1_ddrt_result *res)
+{
+	struct k1_pass p;
+
+	if (!res)
+		return K1_DDRT_EINVAL;
+	*res = (struct k1_ddrt_result){};
+	if (!k1_cfg_ok(cfg))
+		return K1_DDRT_EINVAL;
+	p = k1_pass_init(cfg, NULL, res);
+	res->phy_status = k1_r32(p.phy + K1_PHY_TRAIN_STAT);
+	res->pi_status = k1_r32(p.ddr + K1_MC_PI_STATUS);
+	k1_collect(&p);
+	return K1_DDRT_OK;
+}
+
+typedef int (*k1_stage_fn)(struct k1_pass *p);
+
+int k1_ddrt_train_pass(const struct k1_ddrt_cfg *cfg,
+		       const struct k1_ddrt_env *env,
+		       struct k1_ddrt_result *res)
+{
+	static const k1_stage_fn stages[] = {
+		k1_stage_wl, k1_stage_gate, k1_stage_rx, k1_stage_tx,
+	};
+	struct k1_pass p;
+	int rc, xrc;
+
+	if (!res)
+		return K1_DDRT_EINVAL;
+	*res = (struct k1_ddrt_result){};
+	if (!k1_cfg_ok(cfg)) {
+		res->rc = K1_DDRT_EINVAL;
+		res->fail_stage = K1_STAGE_ARGS;
+		return K1_DDRT_EINVAL;
+	}
+	p = k1_pass_init(cfg, env, res);
+
+	k1_log(env, "k1-ddrt: pass pp%u cs_num %u\n", cfg->boot_pp,
+	       cfg->cs_num);
+
+	res->sr_stat[0] = k1_r32(p.ddr + K1_MC_STATUS);
+	rc = k1_sr_enter(&p);
+	res->sr_stat[1] = k1_r32(p.ddr + K1_MC_STATUS);
+	if (rc) {
+		k1_fail(&p, rc, K1_STAGE_SR_ENTER, 0);
+		(void)k1_sr_exit(&p);
+		res->sr_stat[2] = k1_r32(p.ddr + K1_MC_STATUS);
+		return rc;
+	}
+
+	k1_w32(p.phy + K1_PHY_INIT, K1_PHY_INIT_VAL);
+
+	static_assert(ARRAY_SIZE(stages) ==
+		       ARRAY_SIZE(res->pi),
+		       "stages count must match res->pi");
+	for (u32 i = 0; i < ARRAY_SIZE(stages); i++) {
+		const u64 t0 = k1_now(env);
+
+		p.pi = &res->pi[i];
+		rc = stages[i](&p);
+		res->stage_us[i] = (u32)(k1_now(env) - t0);
+		if (rc)
+			break;
+	}
+	p.pi = NULL;
+
+	res->phy_status = k1_r32(p.phy + K1_PHY_TRAIN_STAT);
+	xrc = k1_sr_exit(&p);
+	res->sr_stat[2] = k1_r32(p.ddr + K1_MC_STATUS);
+	k1_collect(&p);
+
+	if (rc)
+		return rc;
+	if (xrc)
+		return k1_fail(&p, xrc, K1_STAGE_SR_EXIT, 0);
+	if (res->phy_status) {
+		k1_log(env, "k1-ddrt: PHY training status 0x%x\n",
+		       res->phy_status);
+		return k1_fail(&p, K1_DDRT_EIO, K1_STAGE_STATUS, 0);
+	}
+
+	k1_log(env,
+	       "k1-ddrt: pp%u ok: rx vref idx %u (min %u), tx mr14 %u (min %u)\n",
+	       cfg->boot_pp, res->rx_vref_idx, res->rx_min[res->rx_vref_idx],
+	       res->tx_vref_dq,
+	       res->tx_min[res->tx_vref_dq - K1_TX_VREF_SEED0]);
+	return K1_DDRT_OK;
+}
+
+int k1_ddrt_mr_read(const struct k1_ddrt_cfg *cfg,
+		    const struct k1_ddrt_env *env, u32 cs, u32 ch,
+		    u32 mr, u8 *val)
+{
+	u32 v = 0;
+	int rc;
+
+	if (!cfg || !cfg->ddr || !val || cs >= K1_MAX_CS || ch > 1 || mr > 0xff)
+		return K1_DDRT_EINVAL;
+
+	k1_w32(cfg->ddr + K1_MC_CA_CMD, K1_CA_MR_READ |
+	       ((cs + 1) << K1_CA_MR_CS_SHIFT) | (ch << K1_CA_MR_CH_SHIFT) | mr);
+	rc = k1_wait(env, cfg->ddr + K1_MC_MR_DATA, K1_MR_DATA_VALID,
+		     K1_MR_DATA_VALID, K1_MR_BUDGET_US, &v);
+	if (rc)
+		return rc;
+	*val = (u8)v;
+	return K1_DDRT_OK;
+}
+
+int k1_ddrt_check_mr14(const struct k1_ddrt_cfg *cfg,
+		       const struct k1_ddrt_env *env)
+{
+	u32 want;
+	int rc = K1_DDRT_OK;
+
+	if (!cfg || !cfg->ddr || cfg->cs_num < 1 || cfg->cs_num > K1_MAX_CS)
+		return K1_DDRT_EINVAL;
+
+	want = (k1_r32(cfg->ddr + K1_MC_TXVREF) >> K1_TXVREF_SHIFT) &
+	       K1_TXVREF_FIELD;
+	for (u32 cs = 0; cs < cfg->cs_num; cs++) {
+		for (u32 ch = 0; ch < 2; ch++) {
+			u8 mr14 = 0;
+			const int r = k1_ddrt_mr_read(cfg, env, cs, ch, 14, &mr14);
+
+			if (r)
+				return r;
+			if (mr14 != want) {
+				k1_log(env,
+				       "k1-ddrt: MR14 cs%u ch%u = 0x%02x, TXVREF has 0x%02x\n",
+				       cs, ch, mr14, want);
+				rc = K1_DDRT_EIO;
+			}
+		}
+	}
+	return rc;
+}
diff --git a/drivers/ram/spacemit/k1_ddrt.h b/drivers/ram/spacemit/k1_ddrt.h
new file mode 100644
index 00000000000..97a1933405b
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddrt.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 LPDDR4/4X training: one pass at one frequency point.
+ *
+ * The pass runs from SRAM, inside self-refresh, and drives the PI engine
+ * through write leveling, read gate, Rx Vref sweep and Tx Vref (MR14) sweep.
+ * PLL, controller/PHY init, mode registers, timings and the address map are
+ * the caller's job and must already be in place for boot_pp.
+ */
+#ifndef K1_DDRT_H
+#define K1_DDRT_H
+
+#include <stdarg.h>
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+enum k1_ddrt_err {
+	K1_DDRT_OK        = 0,
+	K1_DDRT_EIO       = -5,
+	K1_DDRT_EINVAL    = -22,
+	K1_DDRT_ENOSYS    = -38,
+	K1_DDRT_ETIMEDOUT = -110,
+};
+
+enum k1_ddrt_stage {
+	K1_STAGE_NONE,
+	K1_STAGE_ARGS,
+	K1_STAGE_SR_ENTER,
+	K1_STAGE_WL,
+	K1_STAGE_GATE,
+	K1_STAGE_RX,
+	K1_STAGE_TX,
+	K1_STAGE_SR_EXIT,
+	K1_STAGE_STATUS,
+	K1_STAGE_MR,
+};
+
+struct k1_ddrt_env {
+	/* monotonic microseconds; NULL means only poll_limit bounds waits */
+	u64 (*now_us)(void *ctx);
+	/* printf-like sink; NULL discards */
+	void (*vlog)(void *ctx, const char *fmt, va_list ap);
+	void *ctx;
+	/* hard cap on status polls per wait; 0 selects the default */
+	u32 poll_limit;
+	/* per-step Vref minima in the log */
+	bool verbose;
+};
+
+struct k1_ddrt_pi_stats {
+	u16 ops;
+	u16 stale_first;	/* first status read after PI_CMD had done set */
+	u32 max_polls;	/* status polls until done */
+	u32 max_us;	/* PI_CMD to done (0 without now_us) */
+};
+
+struct k1_ddrt_cfg {
+	uintptr_t ddr;		/* controller base, 0xc0000000 on K1 */
+	u32 cs_num;	/* 1 or 2 */
+	u32 boot_pp;	/* 0..3, already active */
+};
+
+struct k1_ddrt_result {
+	s32 rc;
+	enum k1_ddrt_stage fail_stage;
+	u8 fail_cs;		/* 1-based, 0 if not CS specific */
+	u8 rx_vref_idx;		/* winning PHY Vref index 0..15 */
+	u8 tx_vref_dq;		/* winning MR14 value 21..36 */
+	u32 phy_status;		/* phy + 0x18000 before SR exit */
+	u32 pi_status;		/* last PI_STATUS read */
+	u8 rx_min[16];		/* worst DQ margin per Rx step */
+	u8 tx_min[16];		/* worst DQ margin per Tx step */
+	u8 rx_min_cs[2][16];	/* same, per rank */
+	u8 tx_min_cs[2][16];
+	u32 sr_stat[3];		/* before enter, after enter, after exit */
+	struct k1_ddrt_pi_stats pi[4];	/* WL, gate, Rx, Tx */
+	u32 vref0, vref1, txvref;	/* final register values */
+	u32 wl[2][4];		/* [cs][byte] */
+	u32 gate[2][4];
+	u8 rx_dq[2][4][8];		/* [cs][byte][lane] */
+	u8 tx_dq[2][4][8];
+	u8 tx_dm[2][4];
+	u32 stage_us[4];		/* WL, gate, Rx, Tx (0 without now_us) */
+};
+
+/*
+ * Train one frequency point. Returns K1_DDRT_OK only if the PHY training
+ * status is 0 and every gate run passed. Any other value must stop boot.
+ */
+__must_check int k1_ddrt_train_pass(const struct k1_ddrt_cfg *cfg,
+				    const struct k1_ddrt_env *env,
+				    struct k1_ddrt_result *res);
+
+/* Mode register read; must not be called while in self-refresh. */
+__must_check int k1_ddrt_mr_read(const struct k1_ddrt_cfg *cfg,
+				 const struct k1_ddrt_env *env,
+				 u32 cs, u32 ch, u32 mr, u8 *val);
+
+/* After the pass: MR14 on every (cs, ch) must equal CTL_TXVREF[21:16]. */
+__must_check int k1_ddrt_check_mr14(const struct k1_ddrt_cfg *cfg,
+				    const struct k1_ddrt_env *env);
+
+/* Fill only the register part of res (taps, gate, WL, Vref); no PI access. */
+__must_check int k1_ddrt_snapshot(const struct k1_ddrt_cfg *cfg,
+				  struct k1_ddrt_result *res);
+
+/* max-min rule shared by Rx and Tx: first index holding the largest value */
+u32 k1_ddrt_max_min(const u8 min_per_step[16]);
+
+const char *k1_ddrt_stage_name(enum k1_ddrt_stage stage);
+
+#endif /* K1_DDRT_H */
diff --git a/drivers/ram/spacemit/k1_ddrt_io.h b/drivers/ram/spacemit/k1_ddrt_io.h
new file mode 100644
index 00000000000..13699ac1d34
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddrt_io.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+#ifndef K1_DDRT_IO_H
+#define K1_DDRT_IO_H
+
+#include <asm/io.h>
+#include <linux/types.h>
+
+static inline void k1_io_fence(void)
+{
+	/* Order DRAM pattern writes before subsequent reads/verifies */
+	mb();
+}
+
+static inline u32 k1_r32(uintptr_t addr)
+{
+	return readl((void __iomem *)addr);
+}
+
+static inline void k1_w32(uintptr_t addr, u32 val)
+{
+	writel(val, (void __iomem *)addr);
+}
+
+static inline void k1_rmw32(uintptr_t addr, u32 keep, u32 set)
+{
+	clrsetbits_le32((void __iomem *)addr, ~keep, set);
+}
+
+static inline u32 k1_dram_r32(u32 *base, u32 idx)
+{
+	return readl((void __iomem *)(base + idx));
+}
+
+static inline void k1_dram_w32(u32 *base, u32 idx, u32 val)
+{
+	writel(val, (void __iomem *)(base + idx));
+}
+
+#endif /* K1_DDRT_IO_H */
+
diff --git a/drivers/ram/spacemit/k1_ddrt_priv.h b/drivers/ram/spacemit/k1_ddrt_priv.h
new file mode 100644
index 00000000000..63efde5efa5
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddrt_priv.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/* Helpers shared by the training pass and the controller bring-up. */
+#ifndef K1_DDRT_PRIV_H
+#define K1_DDRT_PRIV_H
+
+#include "k1_ddrt.h"
+
+__printf(2, 3)
+void k1_log(const struct k1_ddrt_env *env, const char *fmt, ...);
+
+/* 0 without env->now_us */
+u64 k1_now(const struct k1_ddrt_env *env);
+
+/* poll until (reg & mask) == want; budget needs now_us, the poll cap does not */
+int k1_wait_n(const struct k1_ddrt_env *env, uintptr_t addr, u32 mask,
+	      u32 want, u32 budget_us, u32 *last,
+	      u32 *polls);
+int k1_wait(const struct k1_ddrt_env *env, uintptr_t addr, u32 mask,
+	    u32 want, u32 budget_us, u32 *last);
+
+/* busy wait on now_us; a no-op without it */
+void k1_udelay(const struct k1_ddrt_env *env, u32 us);
+
+#endif /* K1_DDRT_PRIV_H */
diff --git a/drivers/ram/spacemit/k1_ddrt_regs.h b/drivers/ram/spacemit/k1_ddrt_regs.h
new file mode 100644
index 00000000000..cc5bcf59561
--- /dev/null
+++ b/drivers/ram/spacemit/k1_ddrt_regs.h
@@ -0,0 +1,277 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2026 Thalles Campagnani */
+/*
+ * SpacemiT K1 LPDDR4/4X controller, PHY, PI engine and DDR PMU register map.
+ * Every value below is taken from cleanroom/docs (03..08, 20, 25..31).
+ */
+#ifndef K1_DDRT_REGS_H
+#define K1_DDRT_REGS_H
+
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+/* MC, offsets from ddr */
+#define K1_MC_STATUS ((u32)(0x0008))
+#define K1_MC_USER0 ((u32)(0x0020))	/* init, ZQCAL, SR */
+#define K1_MC_CA_CMD ((u32)(0x0024))	/* MR read/write */
+#define K1_MC_MISC ((u32)(0x0028))	/* CA on/off port */
+#define K1_MC_CTL0 ((u32)(0x0044))
+#define K1_MC_TBL_INDEX ((u32)(0x0070))	/* DFC table port */
+#define K1_MC_TBL_DATA ((u32)(0x0074))
+#define K1_MC_TBL_ADDR ((u32)(0x0078))
+#define K1_MC_DFC_PRE ((u32)(0x0148))
+#define K1_MC_CS0_MAP ((u32)(0x0200))
+#define K1_MC_CS1_MAP ((u32)(0x0208))
+#define K1_MC_CS1_HI ((u32)(0x020c))
+#define K1_MC_CS0_GEOM ((u32)(0x0220))
+#define K1_MC_CS1_GEOM ((u32)(0x0224))
+#define K1_MC_IO_PU ((u32)(0x02c8))
+#define K1_MC_FREQ ((u32)(0x0304))
+#define K1_MC_FREQ_AUX ((u32)(0x0308))
+#define K1_MC_TXVREF ((u32)(0x030c))
+#define K1_MC_DS0 ((u32)(0x0310))
+#define K1_MC_DS1 ((u32)(0x0314))
+#define K1_MC_MR_DATA ((u32)(0x0370))
+#define K1_MC_REFRESH0 ((u32)(0x0380))
+#define K1_MC_REFRESH1 ((u32)(0x0384))
+#define K1_MC_REFRESH2 ((u32)(0x0388))
+#define K1_MC_WDQS ((u32)(0x0400))
+#define K1_MC_PI_CMD ((u32)(0x13d0))
+#define K1_MC_PI_CFG ((u32)(0x13e0))
+#define K1_MC_PI_WL_CFG ((u32)(0x13e8))
+#define K1_MC_PI_RD_CFG ((u32)(0x13ec))
+#define K1_MC_PI_WR_CFG ((u32)(0x13f8))
+#define K1_MC_PI_STATUS ((u32)(0x13fc))
+
+/* PHY: phy = ddr + K1_PHY_OFF, slice = phy + (boot_pp << K1_PHY_SLICE_SHIFT) */
+#define K1_PHY_OFF ((u32)(0x40000))
+#define K1_PHY_SLICE_SHIFT ((u32)(14))
+#define K1_PHY_CS_SHIFT ((u32)(8))
+#define K1_PHY_OTHER ((u32)(0x10000))
+#define K1_PHY_OTHER_24 ((u32)(0x10024))
+#define K1_PHY_INIT ((u32)(0x10028))
+#define K1_PHY_MARK_CMD ((u32)(0x10100))	/* DFC markers */
+#define K1_PHY_MARK_DATA ((u32)(0x10104))
+#define K1_PHY_MARK_ADDR ((u32)(0x10108))
+#define K1_PHY_TRAIN_STAT ((u32)(0x18000))
+#define K1_PHY_HARVEST_RX ((u32)(0x18200))
+#define K1_PHY_HARVEST_TX ((u32)(0x18300))
+#define K1_PHY_HARVEST_DM ((u32)(0x20))	/* after the 8 DQ words */
+
+/* per-slice: COMMON of subPHY A at +0x3000, of subPHY B at +0x3200 */
+#define K1_SLICE_COMMON0 ((u32)(0x3000))
+#define K1_SLICE_COMMON1 ((u32)(0x3200))
+#define K1_SLICE_VREF0 ((u32)(0x3004))
+#define K1_SLICE_VREF1 ((u32)(0x3204))
+#define K1_PHY_COMMON_A0_30 ((u32)(0x3030))	/* slice 0, subPHY A only */
+#define K1_SLICE_DQ_CS0B0 ((u32)(0x0064))	/* byte 0 of CS0 only */
+
+/* per byte block (32 words) */
+#define K1_BYTE_TX_DQ ((u32)(0x00))
+#define K1_BYTE_TX_DM ((u32)(0x20))
+#define K1_BYTE_WL ((u32)(0x24))
+#define K1_BYTE_RX_DQ ((u32)(0x30))
+#define K1_BYTE_GATE ((u32)(0x70))
+
+#define K1_PHY_INIT_VAL ((u32)(512))
+
+#define K1_N_BYTES ((u32)(4))
+#define K1_N_LANES ((u32)(8))
+#define K1_N_DQ ((u32)(32))
+#define K1_N_VREF ((u32)(16))
+#define K1_MAX_CS ((u32)(2))
+#define K1_MAX_PP ((u32)(3))
+
+#define K1_RX_DLY_MASK ((u32)(31))
+#define K1_TX_DLY_MASK ((u32)(63))
+
+/* PHY_STATUS (phy + 0x18000) error bits */
+#define K1_ST_WL ((u32)(1u << 1))
+#define K1_ST_RL ((u32)(1u << 2))
+#define K1_ST_WDQ ((u32)(1u << 3))
+#define K1_ST_RGATE ((u32)(1u << 4))
+
+/* COMMON Vref word */
+#define K1_VREF_BIT4 ((u32)(1u << 4))
+#define K1_VREF_LO_MASK ((u32)(0xffff))
+
+/* PI operations; the command is op | (cs << 24) with a 1-based cs */
+#define K1_PI_OP_WL ((u32)(0x10400000))
+#define K1_PI_OP_RGATE ((u32)(0x10100000))
+#define K1_PI_OP_RD ((u32)(0x10200000))
+#define K1_PI_OP_WR ((u32)(0x10080000))
+#define K1_PI_CS_SHIFT ((u32)(24))
+
+#define K1_PI_DONE_WL ((u32)(0x01))
+#define K1_PI_DONE_RGATE ((u32)(0x02))
+#define K1_PI_DONE_RD ((u32)(0x06))
+#define K1_PI_DONE_WR ((u32)(0x60))
+#define K1_PI_GATE_MASK ((u32)(0x06))
+#define K1_PI_GATE_PASS ((u32)(0x06))
+#define K1_PI_GATE_BIT2 ((u32)(0x04))	/* RGATE does not clear it */
+#define K1_PI_INIT_DONE ((u32)(1u << 31))
+
+/* DFI PHY init_start through PI_CMD (doc 26) */
+#define K1_DFI_INIT_START ((u32)(0x10000001))
+#define K1_DFI_INIT_CLEAR ((u32)(0x10000100))
+
+/* sequencer parameters (opaque magics, doc 04 / 20) */
+#define K1_WL_P0 ((u32)(0))
+#define K1_WL_P1 ((u32)(10))
+#define K1_WL_P2 ((u32)(100))
+#define K1_WL_P3 ((u32)(30))
+#define K1_WL_P4 ((u32)(68))
+#define K1_RD_P0 ((u32)(80))
+#define K1_RD_P1 ((u32)(112))
+#define K1_RD_P2 ((u32)(0))
+#define K1_WR_P0 ((u32)(16))
+#define K1_WR_P1 ((u32)(96))
+
+#define K1_PI_WL_CFG_VAL \
+	((u32)(K1_WL_P4 | (K1_WL_P3 << 8) | (K1_WL_P2 << 16) | \
+		    (K1_WL_P1 << 24) | (K1_WL_P0 << 31)))
+#define K1_PI_RD_CFG_VAL ((u32)((K1_RD_P0 << 8) | (K1_RD_P2 << 16) | K1_RD_P1))
+#define K1_PI_WR_CFG_VAL ((u32)((K1_WR_P1 << 6) | K1_WR_P0))
+
+static_assert(K1_PI_WL_CFG_VAL == 0x0a641e44, "K1_PI_WL_CFG_VAL == 0x0a641e44");
+static_assert(K1_PI_RD_CFG_VAL == 0x00005070, "K1_PI_RD_CFG_VAL == 0x00005070");
+static_assert(K1_PI_WR_CFG_VAL == 0x00001810, "K1_PI_WR_CFG_VAL == 0x00001810");
+
+/* self-refresh (doc 07) */
+#define K1_SR_CMD ((u32)(0x10000000))
+#define K1_SR_ENTER ((u32)(1u << 6))
+#define K1_SR_EXIT ((u32)(2u << 6))
+#define K1_SR_MODE_SHIFT ((u32)(24))
+#define K1_SR_STAT_2CS ((u32)(0x44))	/* bits 2 and 6 */
+#define K1_SR_STAT_1CS ((u32)(0x04))
+
+/* USER_0 commands; the CS byte is 0x10 | cs_sel (doc 26) */
+#define K1_USER0_INIT ((u32)(0x10000001))
+#define K1_USER0_ZQ_START ((u32)(0x10002000))
+#define K1_USER0_ZQ_LATCH ((u32)(0x10001000))
+#define K1_CS_SEL_SHIFT ((u32)(24))
+#define K1_INIT_DONE_1CS ((u32)(0x01))	/* STATUS bits 0 / 4 */
+#define K1_INIT_DONE_2CS ((u32)(0x11))
+
+/* mode registers (doc 08, 28) */
+#define K1_CA_MR_WRITE ((u32)(0x10020000))
+#define K1_MR21_16G ((u32)(0x95))	/* MR21, bit 7 RFU */
+#define K1_CA_MR_READ ((u32)(0x10010000))
+#define K1_CA_MR_CS_SHIFT ((u32)(24))
+#define K1_CA_MR_CH_SHIFT ((u32)(18))
+#define K1_MR_DATA_VALID ((u32)(1u << 31))
+#define K1_CA_OP_TXVREF ((u32)(0x1302000e)) /* k1_ca_mr14(2) */
+#define K1_TXVREF_MASK ((u32)(0xffc0ffff))
+#define K1_TXVREF_SHIFT ((u32)(16))
+#define K1_TXVREF_FIELD ((u32)(0x3f))
+#define K1_TX_VREF_SEED0 ((u32)(21))
+#define K1_TX_FALLBACK_IDX ((u32)(4))
+
+/* CTL_FREQ / PI_CFG fields (doc 03, 26) */
+#define K1_FREQ_PP_SHIFT ((u32)(30))
+#define K1_FREQ_SEL_SHIFT ((u32)(28))
+#define K1_FREQ_FP_MASK ((u32)(0xf0000000))
+#define K1_FREQ_SEL_MASK ((u32)(3u << 28))
+#define K1_FREQ_REST ((u32)(0x00800400))
+#define K1_PI_CFG_SEL_SHIFT ((u32)(2))
+#define K1_PI_CFG_SEL_MASK ((u32)(3u << 2))
+
+/* CTL_FREQ selecting the timing bank of fp: both fields equal */
+static inline u32 k1_freq_bank(u32 fp)
+{
+	return (fp << K1_FREQ_PP_SHIFT) | (fp << K1_FREQ_SEL_SHIFT) |
+	       K1_FREQ_REST;
+}
+
+/* CS map word: [20:16] size code, bit 0 present; CS1 start in 8 MB units */
+#define K1_MAP_KEEP ((u32)(0x0060ffff))
+#define K1_MAP_CODE_SHIFT ((u32)(16))
+#define K1_MAP_PRESENT ((u32)(1u << 0))
+#define K1_MAP_START_SHIFT ((u32)(23))
+#define K1_MAP_START_LO ((u32)(0x1ff))
+#define K1_GEOM_KEEP ((u32)(0xfffff00c))
+#define K1_GEOM_BANK8 ((u32)(2))
+#define K1_GEOM_COL10 ((u32)(3u << 4))
+#define K1_GEOM_ROW_SHIFT ((u32)(8))
+
+/* DFC table: ADDR = MC offset [12:0] | flags; snapshot 0x200..0x28a (doc 30) */
+#define K1_TBL_POLL ((u32)(1u << 13))
+#define K1_TBL_REQ_PMU ((u32)(1u << 16))
+#define K1_TBL_EOP ((u32)(1u << 17))
+#define K1_TBL_SNAPSHOT ((u32)(0x200))
+#define K1_TBL_SNAP_TAIL ((u32)(0x27b))
+#define K1_TBL_SNAP_END ((u32)(0x28a))
+#define K1_TBL_CTL0_BITS ((u32)((1u << 2) | (1u << 12)))
+#define K1_DFC_PRE_VAL ((u32)(0x80ac0000))
+
+/* DDR PMU (APMU) at 0xd4282800 (doc 25) */
+#define K1_PMU_CC_AP ((u32)(0x004))
+#define K1_PMU_AP_IMR ((u32)(0x098))
+#define K1_PMU_AP_ISR ((u32)(0x0a0))
+#define K1_PMU_HW_SLP ((u32)(0x0b0))
+#define K1_PMU_MCK_CTRL ((u32)(0x0e8))
+#define K1_PMU_PHY_LDO ((u32)(0x398))
+#define K1_PMU_PLL1_CTL1 ((u32)(0x39c))
+#define K1_PMU_PLL1_CTL2 ((u32)(0x3a0))
+#define K1_PMU_PHY_BIAS ((u32)(0x3a4))
+#define K1_PMU_PLL2_CTL1 ((u32)(0x3a8))
+#define K1_PMU_PLL2_CTL2 ((u32)(0x3ac))
+#define K1_PMU_CLKSEL ((u32)(0x3b4))
+
+#define K1_CC_SWFC_KICK ((u32)(1u << 26))
+#define K1_CC_DFC_KICK ((u32)(1u << 22))
+#define K1_IMR_DCLK_FC ((u32)(1u << 4))
+#define K1_HW_SLP_RESET ((u32)(1u << 21))	/* 1 = out of reset */
+#define K1_HW_SLP_SWFC ((u32)(0x40600400))
+#define K1_HW_SLP_DFC ((u32)(0x40200200))
+#define K1_HW_SLP_FP_SHIFT ((u32)(3))
+#define K1_MCK_ON ((u32)(3))
+
+#define K1_PLL1_2666 ((u32)(0x203c5555))
+#define K1_PLL1_ANALOG ((u32)(0x50dd6538))
+#define K1_PLL1_2400_KEEP ((u32)(0xffff00ff))
+#define K1_PLL1_2400_BYTE ((u32)(0x3b))
+/* leftover at ddr_init entry on this SoC, then 2400 RMW of [15:8] */
+#define K1_PLL1_BOOTROM ((u32)(0x2a200000))
+#define K1_PLL1_BOOTROM_ANALOG ((u32)(0x50dd6432))
+#define K1_PLL1_2400 ((u32)(0x2a203b00))
+#define K1_PLL2_VCO ((u32)(0x20238000))
+#define K1_PLL2_ANALOG ((u32)(0x50dd632c))
+
+#define K1_CLKSEL_PLL2_EN ((u32)(1u << 8))
+#define K1_CLKSEL_PLL1_EN ((u32)(1u << 9))
+#define K1_CLKSEL_EXTRA_EN ((u32)(1u << 11))
+#define K1_CLKSEL_LOCK ((u32)(0x30000))	/* PLL2 | PLL1 */
+
+#define K1_PHY_BIAS_KEEP ((u32)(0xffff00ff))
+#define K1_PHY_BIAS_VAL ((u32)(0x0fu << 8))
+#define K1_LDO_4X ((u32)(3u << 10))
+#define K1_LDO_4 ((u32)(2u << 10))
+#define K1_LDO_4_KEEP ((u32)(0xffffcfff))
+#define K1_LDO_4_088V ((u32)(3u << 12))
+
+/* byte b (DQ[8b+7:8b]) inside a slice: DATAPHY0 A, DATAPHY1 A, DATAPHY0 B, DATAPHY1 B */
+static const u32 K1_BYTE_OFF[K1_N_BYTES] = {
+	0x0000, 0x1000, 0x0200, 0x1200,
+};
+
+static inline u32 k1_cs_sel(u32 cs_num)
+{
+	return cs_num == 1 ? 1 : 3;
+}
+
+/* MR14 write: 0x1102000e (one rank) or 0x1302000e (two ranks). */
+static inline u32 k1_ca_mr14(u32 cs_num)
+{
+	return K1_CA_MR_WRITE | (k1_cs_sel(cs_num) << K1_CS_SEL_SHIFT) | 14;
+}
+
+static inline u32 k1_pack_vref(u32 step)
+{
+	return (step << 28) | (step << 24) | (step << 20) | (step << 16);
+}
+
+#endif /* K1_DDRT_REGS_H */
diff --git a/include/spacemit/k1_ddr.h b/include/spacemit/k1_ddr.h
new file mode 100644
index 00000000000..96d9cc338b0
--- /dev/null
+++ b/include/spacemit/k1_ddr.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Thalles Campagnani
+ */
+
+#ifndef _SPACEMIT_K1_DDR_H
+#define _SPACEMIT_K1_DDR_H
+
+#include <linux/types.h>
+
+/**
+ * spacemit_k1_ddr_init() - Initialize and train LPDDR4/4X DRAM on SpacemiT K1
+ * @cs_num:	Number of chip selects (1 or 2)
+ * @data_rate:	Target DDR data rate in MT/s (e.g. 2400, 2666, 2133, 1333, 1200, 1066)
+ * @is_lpddr4:	True for LPDDR4 (non-X), false for LPDDR4X
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int spacemit_k1_ddr_init(u32 cs_num, u32 data_rate, bool is_lpddr4);
+
+#endif /* _SPACEMIT_K1_DDR_H */
+
-- 
2.56.1

