Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D9C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC75560698;
	Fri, 31 Jul 2026 17:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CtWv9iLP8bt; Fri, 31 Jul 2026 17:18:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4620260ACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518336;
	bh=vkDrUE54Hn/AvDBoq2NF+VudruFE+nBVsIZu11746vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lqcGPXo4avjUZxYD1z+BAkvD98uxS4tO0ABumiT9ChSUabtpJnAam+VXD3YPjcV/C
	 HIVtRx9QQqYxMIWPmQWyvkooVXT/wc6q54a4TBldsMlja+K+vgmT90ArchWwI6Xm5G
	 hZhCNWrOYEgKD3NVxe4cv2yQJzmQn/51iDT8C5JOfz7qbWQjX+qwfa55YsX2J1nKTI
	 07lG7HP2a8Tq7tdx3jDD3mrU6eABLmNIM87hOTOEu6rEP/T/dFux0x/BGyceetyq9I
	 gpGPIx7PHHmnvK9edtjtEM87sKI6NBaNmRFtx340/2mY4HW5jkE/D9CqUWTlAMm9vn
	 wb9mO+KW+UJtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4620260ACD;
	Fri, 31 Jul 2026 17:18:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CEEF36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FD4C40E41
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZg0iZvarM9d for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2C40C40E3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C40C40E3A
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C40C40E3A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:31 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso1298348f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517889; x=1786122689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vkDrUE54Hn/AvDBoq2NF+VudruFE+nBVsIZu11746vw=;
 b=KV0h/PVmw+3Sv8jJfnNvedD+edkyZbamXNqRqC9zgm5f3voiNQ3LTJEJdow4vcuBcG
 uZwJwZ/Im78XbMWfGr95WcUs5WXfkgBGiO0mAfx3T5KSwsGKSdR23cepeA0LtW451vEd
 bzkRZD9lqiv1RAq/emT9aiJcxIgbTrf668aTQthVIs3lnizVfZTMK28PhJiNZcaYmDkQ
 PZzqTvMEnH2SU57Rm4gJPGh0uHF9GD7gQM7DnFWM2mvv/pMkFqP/PCQBustZhV3HCAHx
 yQ8yFDVBlC7CZjb61vTmomZWem54w0FksoykLnhtg22AXe35Nupnd3V0+8EVh2ke8wxe
 LLbg==
X-Gm-Message-State: AOJu0Yxm0mJtUfexoA5U751ncY+W7FQxxgRWv3l96FrrhIarQ/Z4z0cV
 jUMwulORCElwWgYEni8FpTy+H9qIpX6yrX/hNw4sG3FwEaHowBZ5B5QfWzGjXCi12Pw=
X-Gm-Gg: AR+sD11dFykQW35g3/g2ursIBBq7tqqTMnhHr1nxusxJAy10LW2GKrbarW4dXETB61P
 mOXYCKkWxRm+i0X8gDADPpeF0SyP9lBnmqlzIgXRdUKteib5zuwjjFRF5EAe+deNoSO0wyQQdTp
 OGK7WFAT3aHyldgs8URHEB/wrD+mge4yjSalvU9jGhtHS2wmPAJ2080Ta6nEI1Wsil5/yHRl1MC
 T6cpiqqvsJTi3kkmqtRyASTVnT9P5QpcyeuXbMm9yfVmKvsuCwr2ETCjwMXMCZTaylWx8eCtlxK
 vrnH52HrXwUn75yT/vw8XVOivyaSeA0EYcXq2KV3WNy1p9RWovR1SZ0MAPr92RXcs1srdBgZK8v
 uAPKe4wJX+0CzuTrLf/RbljUYCUq58wCROKg8ObyDz+Vsmw7LSJqCD9Y3eEmZ3U7hzJSX7ui4Yu
 V1Kde60ND4gX9FHrXXF4fPySOH3ixXnDVuLpNa2JHydxm0mvKlgShyA9MA4QQuW1JQG899Svlna
 lCwvV9KBAlgip+3J/jdVpFuZ93zcqcGN8ZPtK9zuA==
X-Received: by 2002:a05:6000:4007:b0:47d:f437:beef with SMTP id
 ffacd0b85a97d-47fd32f1481mr6079943f8f.25.1785517889078; 
 Fri, 31 Jul 2026 10:11:29 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:48 +0400
Subject: [PATCH v2 04/10] binman: Add support for externally provided Linux
 kernel blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-4-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585; i=alchark@flipper.net;
 h=from:subject:message-id; bh=cht8v4fiqF8vOJd606vpgJMvSuEnDv03H62y3tRoVWs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFcy1Axf5ad6VG0XW3S2wuY5Pk/+FzMqCcWazIw8E
 F7qKmjcMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFTHX2dkuHV4qUJ4l8bEX7Ymnru6795dO1dcgDeY7e/TPhs34eXGbAz/gzf2+30
 UD5WKEFcQ2bL4kXDDl6ZqftdejRXcG73ObMthAgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517889; x=1786122689;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkDrUE54Hn/AvDBoq2NF+VudruFE+nBVsIZu11746vw=;
 b=4JZlzzmOyjamU3kUTbmw7QnPPCumF8w+/qCYfnRCXsM65FskzL1HmcGAxAxoZfCNdJ
 f0/bwEnGVkYStjVj8eidxRtOhvD1Guc1Nnw1dTn/5Sqp06UhQu3ZC61grqb3+TRNBK0S
 xdUhhU7CswKPZhrL4QH8+Myide1LuxEHUxR29Bn5UWNYXUHkiB4EW126advMWKzcaypF
 VAa/YXTAmmlrGV3P6iM5dv7PLWul+ppbf4+tY4i1Jna7+oYj59LB3umrsOYBR/I8VYKf
 3MAaLpUj0HtaJRVfyCDSOvL8iP6nvxI9X6vguS2p+o89tps6FaTknxmEfFmYBMYVP5te
 X1tA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4JZlzzmO
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

Add an simple named Linux kernel blob type to binman, activated by the
"LINUX_KERNEL" make variable. No processing is done on the passed blob.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 Makefile                           |  1 +
 tools/binman/etype/linux_kernel.py | 22 ++++++++++++++++++++++
 tools/binman/missing-blob-help     |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/Makefile b/Makefile
index c5cc8276fa08..246efa2c23be 100644
--- a/Makefile
+++ b/Makefile
@@ -1692,6 +1692,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		$(if $(KEYDIR),-a keydir=$(KEYDIR)) \
 		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
+		-a linux-kernel-path=${LINUX_KERNEL} \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
 		-a opensbi-path=${OPENSBI} \
diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/linux_kernel.py
new file mode 100644
index 000000000000..74bef0ed8247
--- /dev/null
+++ b/tools/binman/etype/linux_kernel.py
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Flipper FZCO
+#
+# Entry-type module for Linux kernel binary blob
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+
+class Entry_linux_kernel(Entry_blob_named_by_arg):
+    """Linux kernel image blob
+
+    Properties / Entry arguments:
+        - linux-kernel-path: Filename of file to read into entry. This is
+            typically an uncompressed ARM64 Image.
+
+    This entry allows binman FIT templates to consume a kernel provided via
+    make variable, similar to how BL31 is passed to atf-bl31.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'linux-kernel')
+        self.external = True
diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index 27dc620bd359..c8c56e3ad9b5 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -32,6 +32,11 @@ If CONFIG_WDT_K3_RTI_LOAD_FW is enabled, a firmware image is needed for
 the R5F core(s) to trigger the system reset. One possible source is
 https://github.com/siemens/k3-rti-wdt.
 
+linux-kernel:
+A Linux kernel image is required to build a Falcon mode FIT image, which
+lets SPL start the OS directly instead of U-Boot proper. Build with
+LINUX_KERNEL=/path/to/Image, or disable Falcon mode image generation.
+
 opensbi:
 See the documentation for your board. The OpenSBI git repo is at
 https://github.com/riscv/opensbi.git

-- 
2.54.0

