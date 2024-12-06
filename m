Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DDE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30483895D7;
	Fri,  6 Dec 2024 14:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCdfOw75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0FA89613; Fri,  6 Dec 2024 14:11:32 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA36989616
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 14:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84198253281so126942639f.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733490686; x=1734095486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ct9s+6kLjMtDx7Hz0xX6uj0nfVi2vFR9ciUSYADI20k=;
 b=DCdfOw75w0GnFH5hCAC0arD+kLXH8FbT1VSXddW8TwhNGTv0yR9dcJi7UnoYDZGYan
 0wXtddxNTvVy3U8lBhxcHYhMbJyZNyWLuPcF8ndJbZ3eHgEjXH400piK8uCNXb4tpe+p
 OMWN20SI8Hu+l8RNG8sTEZkdHsLp0KbC6+5ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733490686; x=1734095486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ct9s+6kLjMtDx7Hz0xX6uj0nfVi2vFR9ciUSYADI20k=;
 b=si1l3JoZsYkvqWHj4DTxUi1742FKHvopfdTEDwWYCCR8EEMIpzYb1LK1vPX1X0G5UF
 5PhspJWZLmflm3G/Vq1kA68cRyiyYPIEuQSq6RcLSaTu5QVAVQPfPc/zwQHyTivWs7VM
 T/1s06kX0ukuUpPXOmNfJCn32V8LB4I0GhrV6FUDQTCk3CmCcwbS9PYyKGYpC2M9DpvK
 tLBTtnXMdeyr+c3Onwas3uaFEIGHGLuylv6fPtjwMk5szpvKSmL4SrsB6fVJHVpTpZLk
 HXlqP6FrxHjYoMWC3eEVdb/M77mFNHDOP0PCTZm/liB0DNQnceqxDhh9LybDyjfUvgx7
 BTWw==
X-Gm-Message-State: AOJu0YzM7t+y28puGYmdePZ1kQU4dtwUOIwyThLCMPbpPQB2lBl8SEFs
 DRd3p/LlUnzK190zkbtRLhF9bzZCci/1O+PaTgmJ/WvFvLEtW0TWVq8YjZubtc1IZHWR8fK3224
 =
X-Gm-Gg: ASbGncuaowCGV+1rzj/XWf+NdRjPcQzcVE9J574TwrZIuvkXbdqmdGY2gOYwilwaAlK
 ppdsBOUJQKuIEsbWCt0CZ1Hs2gpyccVeSOi3tzZSQKG3NcPUx1STr4ySQTLdAtwiXOkQpy0V/97
 P9ZrZzintRBL7DhDksPpdi4XdTLE813XWfuYu6jlT9+3GRaUue8o+MyI+QzuxEZgmL/+g0GKw4L
 V4HZ8okn1FyJUEJgUo02WyQajj8q2hFytC8CnQhq38Ev36XqO8ZbUUtFdo2Qva1cxuoBENu0kCz
 iW8Tf/Uyw0k=
X-Google-Smtp-Source: AGHT+IE8IaPhMqA8uoNYfkhyUssLYv66PIGZJMpVXR2uXmWNhMGtbww39IYgHZaqutlNwDLFLoaoOQ==
X-Received: by 2002:a05:6602:640d:b0:843:ea96:f707 with SMTP id
 ca18e2360f4ac-8447e23ad98mr313881639f.8.1733490686492; 
 Fri, 06 Dec 2024 05:11:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5b3b9sm97382639f.35.2024.12.06.05.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 05:11:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] fdt: Allow expanding the devicetree during relocation
Date: Fri,  6 Dec 2024 06:11:12 -0700
Message-Id: <20241206131113.2865416-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206131113.2865416-1-sjg@chromium.org>
References: <20241206131113.2865416-1-sjg@chromium.org>
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

Some boards set fdt_high to -1 which means that the FDT is not relocated
in boot_relocate_fdt().

A comment in that function says that we assume there is space after the
existing fdt to use for padding, with the padding size set to
CONFIG_SYS_FDT_PAD

However, there is no guarantee that this space is available. If using
the control FDT, then global_data is immediately above it, so expanding
the FDT and adding FDT properties will cause U-Boot to fail.

Add a new Kconfig option to provide the required space, enabling it by
default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c |  6 ++++--
 dts/Kconfig      | 11 +++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 8baaa2341a3..ed30aeeab23 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -553,8 +553,10 @@ static int reserve_fdt(void)
 		 * section, then it will be relocated with other data.
 		 */
 		if (gd->fdt_blob) {
-			gd->boardf->fdt_size =
-				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			int size = fdt_totalsize(gd->fdt_blob);
+
+			gd->boardf->fdt_size = ALIGN(size + CONFIG_OF_EXPAND,
+						     32);
 
 			gd->start_addr_sp = reserve_stack_aligned(
 				gd->boardf->fdt_size);
diff --git a/dts/Kconfig b/dts/Kconfig
index 41a758e83a6..360611edd01 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -219,6 +219,17 @@ config OF_OMIT_DTB
 	  This is used for boards which normally provide a devicetree via a
 	  runtime mechanism (such as OF_BOARD), to avoid confusion.
 
+config OF_EXPAND
+	hex # "Amount to allow the control FDT to expand"
+	default SYS_FDT_PAD if OF_LIBFDT
+	default 0
+	help
+	  Some boards make use of the control FDT to boot an OS, thus when
+	  image_setup_libfdt() adds extra things to the end of the FDT, there
+	  needs to be enough space.
+
+	  Set this to the number of bytes of extra space required for the FDT.
+
 config DEFAULT_DEVICE_TREE
 	string "Default Device Tree for DT control"
 	depends on OF_CONTROL
-- 
2.34.1

