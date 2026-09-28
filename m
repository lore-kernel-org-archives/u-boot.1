Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588DFCA5FAB
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA9076064A;
	Mon, 28 Sep 2026 22:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ku9dOeDcfGIn; Mon, 28 Sep 2026 22:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5569A60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634962;
	b=gHcJd3/lNM1N5epiVWvgKRd7yXum6fb4MyUNBTSBtVbxH4AasVYuXbj2gqevNfL4RSFD
	 /jfVwBj5Td/bxobqStxuGgeCcXEY7U4WZC97tGslcYxW9GENp3oYmqocQRxlR/SHmWPDx
	 zoIbrvlFG0fsVjyj6+aCvJVqE9n+8kU1lO7VGgTWtQpPI9Q7UJlovBHBYuZACh7Z1qwMi
	 St+o3deMLzvWNJeFJf0aLmxRSoG6LDvFc3BK784cxf3wUU5Wq0Y1wVAhqE7k3FSFeiBlR
	 q7ufQ0HjtrIj7Z4l0A4Ibx4U5sttkcUaOI/yuxrtP0uuwb6fNCmTCmHjqPfeRHCR9TA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/rOWIRrX2U2ujdgICCLW1ZupQB/a72ByRX9AkmHhR+Y=;
	b=ZpZ1mg2fLAi5N8mM+AVqsWS8GeugB6HBE/mRQZ0AnylB5kzcX6ObX5TR78x/iG99MS7g
	 vMe5aZLIxTLCsZIn4Lg54l7BQr+edeatISBJ1eiAFlB+ayOnIMx/HC/ieIIfuD4hAa0YJ
	 GDt0r16rO57tHxH0QTDM88WFK2Gpnkfw9jCvH8XtRlU0tmjedWKL9rokGfkZVZuCQ2rPj
	 t+mL4GuF/QszuoepxdgBAVVXC4vHiNoD8a5scXKeXA+K41H1YWexGMpKmcNl02J2k6q1o
	 GdsT6LTwGbor8JxyRcvLFSM2f7CTm704tUo89cRjzfTE5xx7xQ9pGtTkxG58t9BkSBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634962;
	bh=/rOWIRrX2U2ujdgICCLW1ZupQB/a72ByRX9AkmHhR+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EJQAuhVATSVC5F4GmNhtjzOXVsjKB2EYh81E/Z0vYd7OTmZkl7d6WLsIC7ltDM+12
	 H3+6HER2Iz1osJxfRV0sWnCO99/VRPjJDKFwwNo6t+17zkDxA5rvCIRQeX6RXGmGtI
	 MmGSRgvtfNFDgKJEK7SjgpyrCMclFnsN9io0pB0WoIpJDJUHR1uvtBEYqGMoCMNLSi
	 kCZnfeLUJNiv3XQ5PmlJAEadT6CUHo8GHRJB52yCUP7znEzoGKjaAG4fR6T/9CQAje
	 SrPPUbGVd7ZBUhRbFsH1U+rSxGfwwKRtkbRe0hC22/ovz63Fs1qp5KMusrVkG3D7gI
	 pIQvCmFn3+WJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5569A60614;
	Mon, 28 Sep 2026 22:36:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7A8261
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A845C40509
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mzfsYiHca-Ao for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B071140508
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634956;
 b=QeziY1gpckef2D5kYGAe/IA2w+DSB7RErxPiaxjvFUvtqvX+gSoh09OopFlthsvaCtrI
 YnGRxHdm8pKE84PTwuzOebuHW+/AmYGXeOcdxLCiC6QE9d26D2tPgEnAILFv5mUS0t2MX
 riYDYBvtDe3UwetIOgU8X68dz7giDpnBwfthjKQXX1S5OvrRdB6gULYvtRHBDg0/uw3ox
 rVkrC4S3cB3LqtHbuYjZGRUKyKOVezWTHt1r4eGeyevC1fPl3jtVeet2sivZC5Pz7+wVf
 WtwY4obBxdJkicH79RWTxIBsoG9AQoqPemVfiYjOfk8+WEHes2d+EGPjWim2x2G04LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634956;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/rOWIRrX2U2ujdgICCLW1ZupQB/a72ByRX9AkmHhR+Y=;
 b=DPdJxwgaSFb+AtVhlsFrMer/eHBmiNsVA4CpQMXjoY2Xgid3qD+uqQpgjHWqKgFmOvV8
 7/5QlfjOYD80thKp3RTmeVl2dsR4TWB6XmGhde+MEMeXX973j88mppAuRVUmdW8PZfU0z
 s3Uij4ObA60hP7d//dWag5l/5dR8gNqXq5npbkRakjB1GzHXerAF5iy8D6z4fRqAp+Uft
 UlBkHJwydVLsecq6cS8Mt0Wfs/ZZBnduEYNCku7WGmBb7/B7ihzG66OjuT1ltaWd9wqUo
 VVkELtvj2HjloYA0VMyVbHKlNYkmIpfwP7rPAyjffGHbYrqu/LDH5na3rAkYLkJHorw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q1HzhEX9; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q1HzhEX9
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B071140508
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:55 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4dc0so3398974e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790634953; x=1791239753;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/rOWIRrX2U2ujdgICCLW1ZupQB/a72ByRX9AkmHhR+Y=;
 b=q1HzhEX9l88Q1C7vk1c6XMxKI0XBz4RA6O3uPp/FvImIUQyCMx5T/yRHsGHWRrzrEX
 ZDhBrb7cpTmQIwaLMGJrZlKm+sxSRi4NZUABnfeeNM39Md0FevLrdpyDZGnhmRc6GCkt
 UwLmhwEOHRK6MzAGrKyf89PN3/71eBmw7MvJmnTlAxleMRKDPlnlhnHaTWL7gRFycebT
 +I1cj51gbL01hIA1Uy+r8MM3OFkJ0u4f6QB8swk8AAgfgUAsl/GXWuza5fhLJYqWiy+F
 hX+DhWjZkbYA5VMJxxRVmxoQT2U3z7W6sOdIK0S7PG3OroiyDL/Usxh+Xt9h0txnq0XM
 RhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634953; x=1791239753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/rOWIRrX2U2ujdgICCLW1ZupQB/a72ByRX9AkmHhR+Y=;
 b=0KNyabup3f+GiYO/vitBElhsp+57TO0QSXjEM9CQ9mTg/CMKR+XGTB7Jw2HcBsnspC
 G4vffRY0pwjKDjWPVoid5EuSVeISTyJCk05dshS8DPLIBRi10IhSdjH3nkTiVvyQlAx9
 JskTWqkesF8JruoNtGTklLPcKQ6FcuJdLedYNVxJjDuvJ5/ePNQr+slBMK8yMnPjtIdk
 +DpaWEMbcrcWN0S3LQxdWWwU7NdTVchMskGbUKft7kKs61f5Ub9zFgw5S91mxTQ6f9+w
 sHJ+ZG1htRo5VwIRaqzZCKGWNplLhTUClSZneTY4BwFNTsnHgJfPyYOtVleU0wo56umU
 TSDQ==
X-Gm-Message-State: AFq9FYL2sr7bicayTa/ePbQ1xB72pnz3KPH6LJv+YVRTiDUQSwjlmZEE
 quhlor3lEYPGbjxZ5QuLz/XVhetdtFgWEAqLgOwLF83JEH3nupk2be61sXGcvb4=
X-Gm-Gg: AYBFou3sOb+gK9DXaB0IHcZU9t3NTHpnDIB7Fp/Zq/3qiCyvgmdMHceKqVIeA0opcFD
 uUc8fdpEfdKPly/8TD7JV/TzFqIg6HRzQrxqxHyJild9VIy2YPoJ0ctK8mFKkEoeFp7h2XrJc00
 h1I05gBKdeVUBIREbJjlM8XWgsnVTDoxF/jQydO1Es8boV4eY3MM/af5+ZTUJCsC68WLKkzuO1q
 IVxD1wQQdslwtQOHcnvbaKWXr4+Lm2uDCacJyCExx6qUNBwJHJBwyBPWIgY8XUb1nUhrOzMsiXC
 MfmNP8S/BS+BvXni0u0DR8LR15buKB/I/uev/oMpHUQyXs2lVGwyKFcthEJHrxbkVu+puzGxgFQ
 E2RFdn1aq4W/RVH6nzLV0sw0pVkhH6TRptrzxvQN//VO86j325+jjerVyNYdSVAfs0Rgx6QjNq4
 x2P3RMsWKrNfS0vOSoQ83pPl+ii5lG6KUjSXyChlm/evk7TR6A74vZvjmxnhPV
X-Received: by 2002:ac2:51c4:0:b0:5b8:f1fc:b2c4 with SMTP id
 2adb3069b0e04-5b8f1fcb44dmr2667787e87.15.1790634952501; 
 Mon, 28 Sep 2026 15:35:52 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9deba80c6sm863466e87.28.2026.09.28.15.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:35:52 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [RFC PATCH 2/4] net: lwip: add httpd command
Date: Tue, 29 Sep 2026 01:35:30 +0300
Message-ID: <20260928223532.482192-3-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223532.482192-1-sochnev.v.74@gmail.com>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
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

Add a command which receives the first file uploaded with an HTTP POST
into memory, so that a device can be recovered with only a web browser
on the host.

It uses the httpd application bundled with lwIP. Pages are served
through the lwIP custom file hooks, so no generated fsdata is needed.
The lwIP fs_open() and fs_close() clash with the U-Boot file system
layer and are renamed for the two lwIP objects.

GET / returns an upload page with one file input per target in
$httpd_targets. A file is sent as the raw body of POST /upload/<target>.
Unknown targets, multipart bodies, concurrent uploads and files which
do not fit into free memory are refused. After an upload $fileaddr,
$filesize and $httpd_target are set and the command returns, so boot
scripts decide what to do with each target:

  httpd && run httpd_do_$httpd_target

The size cost is about 11 KiB on qemu_arm64_lwip_defconfig.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 cmd/Kconfig                       |  11 +
 cmd/lwip/Makefile                 |   1 +
 cmd/lwip/httpd.c                  |  12 +
 configs/qemu_arm64_lwip_defconfig |   1 +
 configs/sandbox64_lwip_defconfig  |   1 +
 include/net-lwip.h                |   1 +
 lib/lwip/Makefile                 |   9 +
 lib/lwip/u-boot/fsdata_uboot.h    |   8 +
 lib/lwip/u-boot/lwipopts.h        |  14 ++
 net/lwip/Makefile                 |   1 +
 net/lwip/httpd.c                  | 373 ++++++++++++++++++++++++++++++
 11 files changed, 432 insertions(+)
 create mode 100644 cmd/lwip/httpd.c
 create mode 100644 lib/lwip/u-boot/fsdata_uboot.h
 create mode 100644 net/lwip/httpd.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961d..8c10e8c3c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2288,6 +2288,17 @@ config CMD_TFTPBOOT
 	help
 	  tftpboot - load file via network using TFTP protocol
 
+config CMD_HTTPD
+	bool "httpd"
+	depends on NET_LWIP
+	select PROT_TCP_LWIP
+	help
+	  Act as a minimal HTTP server and receive the first file uploaded
+	  with a POST request, e.g. from the built-in web page. This allows
+	  recovering a device with nothing more than a web browser. The
+	  command returns successfully after the upload, so boot scripts can
+	  act on the received image.
+
 config CMD_TFTPSRV
 	bool "tftpsrv"
 	depends on CMD_TFTPBOOT
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 245683a96..84e8cb736 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
+obj-$(CONFIG_CMD_HTTPD) += httpd.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
diff --git a/cmd/lwip/httpd.c b/cmd/lwip/httpd.c
new file mode 100644
index 000000000..b86fc4d2d
--- /dev/null
+++ b/cmd/lwip/httpd.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(httpd, 2, 0, do_httpd,
+	   "act as an HTTP server and receive the first uploaded file",
+	   "[loadAddress]\n"
+	   "Serve an upload page and receive a file sent with\n"
+	   "'POST /upload/<target>' into memory. Valid targets are listed in\n"
+	   "$httpd_targets (default: file). On success $fileaddr, $filesize\n"
+	   "and $httpd_target are set. Press Ctrl-C to abort.");
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index 06ed5a131..0d937c5b4 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -8,6 +8,7 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TFTPSRV=y
+CONFIG_CMD_HTTPD=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
diff --git a/configs/sandbox64_lwip_defconfig b/configs/sandbox64_lwip_defconfig
index 0e9272853..3447d379f 100644
--- a/configs/sandbox64_lwip_defconfig
+++ b/configs/sandbox64_lwip_defconfig
@@ -3,3 +3,4 @@
 CONFIG_SANDBOX=y
 
 CONFIG_NET_LWIP=y
+CONFIG_CMD_HTTPD=y
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 7819f9823..709961251 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -90,6 +90,7 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
  */
 bool wget_validate_uri(char *uri);
 
+int do_httpd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
index c3f0e916f..e9dea9eff 100644
--- a/lib/lwip/Makefile
+++ b/lib/lwip/Makefile
@@ -55,5 +55,14 @@ obj-y += \
 	lwip/src/core/udp.o \
 	lwip/src/netif/ethernet.o
 
+obj-$(CONFIG_CMD_HTTPD) += lwip/src/apps/http/fs.o \
+	lwip/src/apps/http/httpd.o
+
+# Avoid clashes with the U-Boot file system layer
+httpd_fs_rename := -Dfs_open=lwip_fs_open -Dfs_close=lwip_fs_close \
+	-Dfs_bytes_left=lwip_fs_bytes_left
+CFLAGS_lwip/src/apps/http/fs.o += $(httpd_fs_rename)
+CFLAGS_lwip/src/apps/http/httpd.o += $(httpd_fs_rename)
+
 obj-$(CONFIG_$(PHASE_)MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
 	lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.o
diff --git a/lib/lwip/u-boot/fsdata_uboot.h b/lib/lwip/u-boot/fsdata_uboot.h
new file mode 100644
index 000000000..7fbf64273
--- /dev/null
+++ b/lib/lwip/u-boot/fsdata_uboot.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Empty read-only file system for the lwIP httpd. All pages are provided
+ * at run time by fs_open_custom().
+ */
+
+#define FS_ROOT		NULL
+#define FS_NUMFILES	0
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 1c1adc57c..56ea259e0 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -175,7 +175,12 @@
 #define LWIP_DISABLE_MEMP_SANITY_CHECKS 1
 
 #define LWIP_SOCKET                     0
+#if defined(CONFIG_CMD_HTTPD)
+/* httpd rebinds while connections of a previous run are in TIME-WAIT */
+#define SO_REUSE                        1
+#else
 #define SO_REUSE                        0
+#endif
 
 #define LWIP_STATS                      0
 
@@ -200,4 +205,13 @@
 #define LWIP_DHCP_GET_NTP_SRV 1
 #endif
 
+#if defined(CONFIG_CMD_HTTPD)
+#define LWIP_HTTPD_SUPPORT_POST         1
+#define LWIP_HTTPD_CUSTOM_FILES         1
+#define LWIP_HTTPD_DYNAMIC_HEADERS      1
+#define HTTPD_FSDATA_FILE               "fsdata_uboot.h"
+/* Track connections so that httpd_deinit() can abort them */
+#define LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED 1
+#endif
+
 #endif /* LWIP_UBOOT_LWIPOPTS_H */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5291cbb2a..cd13376a6 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -3,6 +3,7 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_DNS) += dns.o
+obj-$(CONFIG_CMD_HTTPD) += httpd.o
 obj-$(CONFIG_LWIP_ICMP_SHOW_UNREACH) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
diff --git a/net/lwip/httpd.c b/net/lwip/httpd.c
new file mode 100644
index 000000000..f607691ce
--- /dev/null
+++ b/net/lwip/httpd.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Minimal HTTP upload server based on the lwIP httpd application
+ *
+ * Copyright (C) 2026 Vitaliy Sochnev <sochnev.v.74@gmail.com>
+ */
+
+#include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <env.h>
+#include <image.h>
+#include <lmb.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <lwip/apps/fs.h>
+#include <lwip/apps/httpd.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+#include <time.h>
+
+#define HTTPD_NAME_MAX		32
+#define HTTPD_DRAIN_MS		500
+#define HTTPD_UPLOAD_PREFIX	"/upload/"
+
+enum httpd_state {
+	HTTPD_LISTENING,
+	HTTPD_RECEIVING,
+	HTTPD_RECEIVED,
+};
+
+struct httpd_ctx {
+	enum httpd_state state;
+	void *conn;		/* connection owning the current upload */
+	ulong addr;
+	ulong size;
+	ulong content_len;
+	ulong hash_count;
+	char target[HTTPD_NAME_MAX];
+	char *page;
+	char reason[80];
+};
+
+/* lwIP httpd callbacks have no user-data argument */
+static struct httpd_ctx *httpd_ctx;
+
+static const char httpd_ok[] = "Upload complete\n";
+
+static const char httpd_index_head[] =
+	"<!DOCTYPE html><html><head><meta charset=\"utf-8\">"
+	"<meta name=\"viewport\" content=\"width=device-width\">"
+	"<title>U-Boot upload</title></head><body><h1>U-Boot upload</h1>";
+
+static const char httpd_index_row[] =
+	"<p><label>%s <input type=\"file\" id=\"%s\"></label> "
+	"<button onclick=\"up('%s')\">Upload</button></p>";
+
+static const char httpd_index_tail[] =
+	"<progress id=\"p\" max=\"1\" value=\"0\"></progress><pre id=\"s\"></pre>"
+	"<script>"
+	"function up(t){"
+	"var f=document.getElementById(t).files[0],x=new XMLHttpRequest();"
+	"if(!f)return;"
+	"x.open('POST','" HTTPD_UPLOAD_PREFIX "'+t);"
+	"x.setRequestHeader('Content-Type','application/octet-stream');"
+	"x.upload.onprogress=function(e){p.value=e.loaded/e.total};"
+	"x.onload=function(){s.textContent=x.responseText};"
+	"x.onerror=function(){s.textContent='Upload failed'};"
+	"x.send(f)}"
+	"</script></body></html>";
+
+/* Target names end up in variable names and scripts */
+static bool httpd_valid_name(const char *name, size_t len)
+{
+	size_t i;
+
+	if (!len || len >= HTTPD_NAME_MAX)
+		return false;
+
+	for (i = 0; i < len; i++) {
+		char c = name[i];
+
+		if (!islower(c) && !isdigit(c) && c != '_' && c != '-')
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Iterate over the valid names in $httpd_targets. Returns the next name and
+ * its length in @len, or NULL at the end of the list.
+ */
+static const char *httpd_next_target(const char *s, size_t *len)
+{
+	while (s && *s) {
+		const char *end;
+
+		while (*s == ' ')
+			s++;
+		end = strchrnul(s, ' ');
+		*len = end - s;
+		if (httpd_valid_name(s, *len))
+			return s;
+		s = end;
+	}
+
+	return NULL;
+}
+
+static const char *httpd_targets(void)
+{
+	return env_get("httpd_targets") ?: "file";
+}
+
+static bool httpd_is_target(const char *name)
+{
+	const char *t = httpd_targets();
+	size_t len;
+
+	while ((t = httpd_next_target(t, &len))) {
+		if (strlen(name) == len && !strncmp(name, t, len))
+			return true;
+		t += len;
+	}
+
+	return false;
+}
+
+static char *httpd_build_page(void)
+{
+	const char *t = httpd_targets();
+	size_t size, len;
+	char *page, *p;
+
+	size = sizeof(httpd_index_head) + sizeof(httpd_index_tail);
+	while ((t = httpd_next_target(t, &len))) {
+		size += sizeof(httpd_index_row) + 3 * len;
+		t += len;
+	}
+
+	page = malloc(size);
+	if (!page)
+		return NULL;
+
+	p = page + strlen(strcpy(page, httpd_index_head));
+	t = httpd_targets();
+	while ((t = httpd_next_target(t, &len))) {
+		char name[HTTPD_NAME_MAX];
+
+		strlcpy(name, t, len + 1);
+		p += sprintf(p, httpd_index_row, name, name, name);
+		t += len;
+	}
+	strcpy(p, httpd_index_tail);
+
+	return page;
+}
+
+int fs_open_custom(struct fs_file *file, const char *name)
+{
+	struct httpd_ctx *ctx = httpd_ctx;
+
+	if (!ctx)
+		return 0;
+
+	if (!strcmp(name, "/index.html"))
+		file->data = ctx->page;
+	else if (!strcmp(name, "/ok.html"))
+		file->data = httpd_ok;
+	else if (!strcmp(name, "/400.html"))
+		file->data = ctx->reason;
+	else
+		return 0;
+
+	file->len = strlen(file->data);
+	file->index = file->len;
+	file->flags = 0;
+
+	return 1;
+}
+
+void fs_close_custom(struct fs_file *file)
+{
+}
+
+static err_t httpd_reject(struct httpd_ctx *ctx, char *response_uri,
+			  u16_t response_uri_len, const char *reason)
+{
+	printf("\nUpload rejected: %s\n", reason);
+	snprintf(ctx->reason, sizeof(ctx->reason), "%s\n", reason);
+	strlcpy(response_uri, "/400.html", response_uri_len);
+
+	return ERR_VAL;
+}
+
+err_t httpd_post_begin(void *connection, const char *uri,
+		       const char *http_request, u16_t http_request_len,
+		       int content_len, char *response_uri,
+		       u16_t response_uri_len, u8_t *post_auto_wnd)
+{
+	struct httpd_ctx *ctx = httpd_ctx;
+	const char *target;
+
+	if (!ctx)
+		return ERR_VAL;
+
+	if (ctx->state != HTTPD_LISTENING)
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "Another upload is in progress");
+
+	if (strncmp(uri, HTTPD_UPLOAD_PREFIX, strlen(HTTPD_UPLOAD_PREFIX)))
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "Unknown upload URI");
+
+	target = uri + strlen(HTTPD_UPLOAD_PREFIX);
+	if (!httpd_valid_name(target, strlen(target)) ||
+	    !httpd_is_target(target))
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "Unknown upload target");
+
+	/* The body is stored as is, multipart encoding would corrupt it */
+	if (strnstr(http_request, "multipart/", http_request_len))
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "Send the file as the raw request body");
+
+	if (content_len <= 0)
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "Empty upload");
+
+	if (ctx->addr + content_len < ctx->addr ||
+	    (CONFIG_IS_ENABLED(LMB) && lmb_read_check(ctx->addr, content_len)))
+		return httpd_reject(ctx, response_uri, response_uri_len,
+				    "File does not fit into free memory");
+
+	ctx->state = HTTPD_RECEIVING;
+	ctx->conn = connection;
+	ctx->size = 0;
+	ctx->content_len = content_len;
+	ctx->hash_count = 0;
+	strlcpy(ctx->target, target, sizeof(ctx->target));
+
+	printf("\nReceiving '%s' (%d bytes)\n", ctx->target, content_len);
+	puts("Loading: ");
+
+	return ERR_OK;
+}
+
+err_t httpd_post_receive_data(void *connection, struct pbuf *p)
+{
+	struct httpd_ctx *ctx = httpd_ctx;
+	ulong len;
+	void *ptr;
+
+	if (!ctx || ctx->conn != connection) {
+		pbuf_free(p);
+		return ERR_VAL;
+	}
+
+	/* The last pbuf may carry data past Content-Length */
+	len = min_t(ulong, p->tot_len, ctx->content_len - ctx->size);
+	ptr = map_sysmem(ctx->addr + ctx->size, len);
+	pbuf_copy_partial(p, ptr, len, 0);
+	unmap_sysmem(ptr);
+	pbuf_free(p);
+
+	ctx->size += len;
+	while (ctx->hash_count < ctx->size * 50 / ctx->content_len) {
+		putc('#');
+		ctx->hash_count++;
+	}
+
+	return ERR_OK;
+}
+
+void httpd_post_finished(void *connection, char *response_uri,
+			 u16_t response_uri_len)
+{
+	struct httpd_ctx *ctx = httpd_ctx;
+
+	if (!ctx || ctx->conn != connection)
+		return;
+
+	ctx->conn = NULL;
+
+	if (ctx->size != ctx->content_len) {
+		printf("\nUpload aborted after %lu bytes\n", ctx->size);
+		ctx->state = HTTPD_LISTENING;
+		return;
+	}
+
+	printf("\nBytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+	env_set_hex("fileaddr", ctx->addr);
+	env_set_hex("filesize", ctx->size);
+	env_set("httpd_target", ctx->target);
+	ctx->state = HTTPD_RECEIVED;
+	strlcpy(response_uri, "/ok.html", response_uri_len);
+}
+
+static int httpd_loop(struct net_lwip_ctx *net, ulong addr)
+{
+	struct httpd_ctx ctx = { .addr = addr };
+	const char *ipaddr;
+	ulong start;
+	int ret = -1;
+
+	ipaddr = env_get("ipaddr");
+	if (!ipaddr || !*ipaddr) {
+		log_err("error: ipaddr has to be set\n");
+		return -1;
+	}
+
+	ctx.page = httpd_build_page();
+	if (!ctx.page)
+		return -1;
+
+	httpd_ctx = &ctx;
+	httpd_init();
+
+	printf("Using %s device\n", net->dev->name);
+	printf("Listening for HTTP uploads on http://%s/\n", ipaddr);
+	printf("Load address: 0x%lx\n", addr);
+
+	while (ctx.state != HTTPD_RECEIVED) {
+		net_lwip_poll();
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			goto out;
+		}
+	}
+
+	/* Let the response go out before httpd_deinit() */
+	start = get_timer(0);
+	while (get_timer(start) < HTTPD_DRAIN_MS)
+		net_lwip_poll();
+
+	ret = 0;
+
+out:
+	httpd_deinit();
+	httpd_ctx = NULL;
+	free(ctx.page);
+
+	return ret;
+}
+
+int do_httpd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	ulong addr = env_get_ulong("loadaddr", 16, image_load_addr);
+	struct net_lwip_ctx net = {};
+	char *end;
+	int ret;
+
+	if (argc > 2)
+		return CMD_RET_USAGE;
+
+	if (argc == 2) {
+		addr = hextoul(argv[1], &end);
+		if (end == argv[1] || *end)
+			return CMD_RET_USAGE;
+	}
+
+	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT))
+		return CMD_RET_FAILURE;
+
+	ret = httpd_loop(&net, addr);
+	if (!ret)
+		image_load_addr = addr;
+	net_lwip_stop(&net);
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
-- 
2.55.0

