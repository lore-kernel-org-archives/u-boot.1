Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F0BC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AC66608C8;
	Tue, 28 Jul 2026 13:21:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGAo6RO6U9Ip; Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45E3A608A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244866;
	bh=P8zA2lhyIRY0C1VwjfLs32JRAQqDgBjQMXDlCxeDd6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cC0CkIC2CSIY0Y3icUg2FRuLCzkW9CXsTPJn2Nu6eMpElLzS9PA93kqwcnDqSvkZV
	 hQHWBF7wurA1Ti2xg9Y+IYf2V1vp9Rv7cItp38jVUjblfKLiCnrD/y2b3emcrewtKU
	 0XtFILlELg/Tk5/sMk+Hc7eW78kU8y4Y/2nZQ2v+XgOEZJ6mF7HcHGMyoeq69TpieH
	 f3zzRC3uNAlM216SyY8Fi6Kr/JSY19IwFG/3VhHN3+OqudVO784Yctcewcs/mpp+b2
	 l3kB/05dYm8PtQ7Ywpvrxa/mhoHWe7FNtZ//65VFLyAKyjgpt52yf9us3CKj5jggwS
	 zqwww2aKLihBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45E3A608A9;
	Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E18F54BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DF9340215
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CsSyGZHNhF4P for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:21:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1EE7040935
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EE7040935
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EE7040935
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:01 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso20178955e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244860; x=1785849660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P8zA2lhyIRY0C1VwjfLs32JRAQqDgBjQMXDlCxeDd6A=;
 b=b8YNcR/pQ4isu8l1ayTtB96ghMY6uAuk7FBZNtjpK5ef+RCmc/uHS8dDrEfGSjnJw3
 WiqxGIFqRd31qFwpk2PWJfNhnk806JQju1o2TDtaxZE4S7DQvIlqUDHm2+m4jkn/KAwr
 PCEFHmk7s58HbCSrITz5K5Eko+bH0bFmFHac2PIJ4mmlAbI8Mt5TYI0P4pq3XuQAtjsY
 z+ff93C+5/IiEYvwgXa+H9XlhwdtnPPCia+Lm14To6VQF1cYPfK+GcX/+w1S0Er1dSWH
 JntF0u0RlpPmdxFIff4oYzwh4dclFl1J3Xp1Op3RyL/fNxFIttvyiG8BfEFPZSLyMBMc
 penQ==
X-Gm-Message-State: AOJu0Yz3XXRH9npyG6cq5y6PiN+lYHXV/mgxKEp9IoAWZkeeV4yXrR/R
 5jcIYQ7sSrDXeekpmF9C5oa3zTzUhTxI6YlYKRkmaRaOhRrjVPVi/J7WqNFESNBg+Tk=
X-Gm-Gg: AR+sD11CNpM/5Xb5UK7PbjMoq56+UdBLWfA3362BtC6t9RlZCr6SRn6qQ6zqI7FZdJy
 BpNhpBdseehc14T2fxH3s+2QxgERE+GwFOSNGN1ZOeautOqRB0ZOI/ES/zb1GxP7e5CAx1fh23m
 fFWZ50pGjbkjwJ9pCYRghqLAopkZZyXtETnd+ljX0pRkbqhOqb6mFiWae5r3IU7RhuwZ4bCle8s
 KhF/xknvq5MQzDjmsX/05FSh+WRH7yDoQqlr5KKSkUzIf7Kf7NVsKL5vxUko3W2mu6jLk3kqbxK
 Eeh0tstLqrIgIpG3Ft9n/s+x3Ci0+FuJ2hTELUx0KE+3W4jtMX5pfdCAdjZGR2klPMMfVCGZnqK
 ZOeJNS3U6VUdl/dMy8hsrxHR/NJxFWAYMc+kIXbWz3FRTYHtsPsHP7fRUzYXkOXsRwhhBTTzYvW
 pFhF9yXKG1SwkGz3BhAF5ZkRw3kw9SFOKerU5pIl35TyN8HKkvr70stT1GwFajMqpsc7dfKw==
X-Received: by 2002:a05:600c:3547:b0:495:6b78:6f4 with SMTP id
 5b1f17b1804b1-496c6413230mr28457695e9.8.1785244859813; 
 Tue, 28 Jul 2026 06:20:59 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:20:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 28 Jul 2026 15:20:45 +0200
Subject: [PATCH v2 3/5] bootmeth: efi: use the firmware-owned devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ccaione-upstream-ebbr-v2-3-4efb529140d6@baylibre.com>
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Randolph Sapp <rs@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785244860; x=1785849660;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P8zA2lhyIRY0C1VwjfLs32JRAQqDgBjQMXDlCxeDd6A=;
 b=pueeHFOscRX5pLVjtt3vetEZtw5gR5y+RIWL6ixRWPleL3x3dEtYXyItPvnlr7/YgQ
 X8pimWre0iiFMK/EYNUV5za+gOQ0b6nzjIEWsv5jZIkw3seQcukVxYtJ6LblG7WZcuB4
 vC2UMWv3Gvp9cYF/txMFBZBMpDvcHFtltO1jy+WC/InZI+/zFe7m+Ngrn0akZ4oW2mvY
 Znx6YmfhlA0mhlYe5i4O1d3r26VprScogL16IKivYkgyY/pO6bmmS9CDpNJYRC1hhn3v
 71En/kTauE9mddYzh6Ws0pcygM7imSCiZpuj5lBi7f5U6la756zJv0rIaYDOLoUHqyaV
 LvBw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pueeHFOs
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

When a firmware-owned devicetree source is configured, stage it at the
same fdt_addr_r value used by the normal EFI bootmeth fallback and pass it
through bflow->fdt_addr to efi_install_fdt().

Use the shared helper in both disk and network paths. Only -ENOENT, meaning
that no source is configured, permits the existing ESP, network or
prior-stage fallback. Any failure after a source is configured ends that
bootflow.

The firmware-owned devicetree is complete and authoritative, so do not
apply extension-board overlays on top of it; those combinations belong in
the FIT.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/bootmeth_efi.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e187dc39912..469a07e9540 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -17,6 +17,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <extension_board.h>
+#include <firmware_fdt.h>
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -100,7 +101,7 @@ static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
 static int distro_efi_try_bootflow_files(struct udevice *dev,
 					 struct bootflow *bflow)
 {
-	ulong fdt_addr, size, overlay_addr;
+	ulong fdt_addr, fw_fdt_size, size, overlay_addr;
 	const struct extension *extension;
 	struct fdt_header *working_fdt;
 	struct blk_desc *desc = NULL;
@@ -130,6 +131,22 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 
 	fdt_addr = env_get_hex("fdt_addr_r", 0);
 
+	/*
+	 * A staged firmware-owned devicetree is complete and authoritative,
+	 * so return without considering any other devicetree source. The
+	 * extension overlays below are deliberately not applied on top:
+	 * such combinations belong in the FIT as configurations.
+	 */
+	ret = efi_stage_firmware_fdt(fdt_addr, &fw_fdt_size,
+				     &bflow->fdt_fname);
+	if (!ret) {
+		bflow->fdt_size = fw_fdt_size;
+		bflow->fdt_addr = fdt_addr;
+		return 0;
+	}
+	if (ret != -ENOENT)
+		return log_msg_ret("fwf", ret);
+
 	/* try the various available names */
 	ret = -ENOENT;
 	*fname = '\0';
@@ -222,9 +239,9 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	char file_addr[17], fname[256];
 	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
 	struct cmd_tbl cmdtp = {};	/* dummy */
-	const char *addr_str, *fdt_addr_str, *bootfile_name;
+	const char *addr_str, *bootfile_name;
 	int ret, arch, size;
-	ulong addr, fdt_addr;
+	ulong addr, fdt_addr, fw_fdt_size;
 	char str[36];
 
 	ret = get_efi_pxe_vci(str, sizeof(str));
@@ -268,6 +285,24 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fname)
 		return log_msg_ret("fi0", -ENOMEM);
 
+	/*
+	 * Read fdt_addr_r once so the firmware-FDT source and network fallback
+	 * below stage at the same address. A configured firmware-owned
+	 * devicetree outranks the network-provided one (and the prior-stage /
+	 * built-in devicetree below), so a DHCP/TFTP server cannot replace it.
+	 */
+	fdt_addr = env_get_hex("fdt_addr_r", 0);
+	ret = efi_stage_firmware_fdt(fdt_addr, &fw_fdt_size,
+				     &bflow->fdt_fname);
+	if (!ret) {
+		bflow->fdt_size = fw_fdt_size;
+		bflow->fdt_addr = fdt_addr;
+		bflow->state = BOOTFLOWST_READY;
+		return 0;
+	}
+	if (ret != -ENOENT)
+		return log_msg_ret("fwf", ret);
+
 	/* read the DT file also */
 	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
 	if (ret == -EALREADY) {
@@ -279,10 +314,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("nam", ret);
 	}
 
-	fdt_addr_str = env_get("fdt_addr_r");
-	if (!fdt_addr_str)
+	if (!fdt_addr)
 		return log_msg_ret("fdt", -EINVAL);
-	fdt_addr = hextoul(fdt_addr_str, NULL);
 	sprintf(file_addr, "%lx", fdt_addr);
 
 	bflow->fdt_fname = strdup(fname);

-- 
2.55.0

