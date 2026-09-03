Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD4C624DB
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFBDE60B92;
	Thu,  3 Sep 2026 13:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5Ay_kXOK4Zf; Thu,  3 Sep 2026 13:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B5F7C60B6D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441007;
	b=nEtcxaW5yMrcUZ0HGLprHLaKsIFO3aDTwh0qjxi519GOcSluSUK/57A4O9JxP9f0YY+g
	 vxR/t7wvE/rzSJt0WGInaRK9VSBOg5YhocwisLwhU5ylMBj7shf8uX2D/BrSBSXS20ivR
	 W+TsIlJ5l+acBMOmC8ifuPK+DFLxLuRzsms9L9uV9gWc+jHBNuSjfkdH4z9GD/twyPyQw
	 NTh9u3OY9Cvaju0WJjt5FL1jM9OStmBBn54LakvwyoHi1gqMvTfEbBChUkjjL+F3d46Ev
	 OF6jeBm9IEo93rFw94TTOCaA5y4lEByBLegyTk9GkuKNXCz8qI/i6FkXLbDurnEkymA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LJYcYx+MVMCeEhYVM58rii8oOFcXAWR26C6yKzp+p9Y=;
	b=UJYgJDBzHYqYViqWM0ci2Ak+wMWGloYjz7f+B2ZrSmN5AJyG7LpKrQ9X9rRKxKas12Ah
	 CXwL2bNNmHqj34HufLvRtSSuof58usiOtRF45uDRhya9AocVYCgw255quzqjXL8ecVFN/
	 JPfZhMs8MNmUpwrWQjv0KosGrqRT5w2dzXDcaQ0e5vRMfSWfrfoEK1lQ+5uH2kSb9V3S+
	 wUN4L5C7A+zZsOGK4plVyLaNHku9O7ae3+iZRoJMqCpclvmxiY5SxSWkFY3oSU6JF3kU2
	 9X5FcokPJoWXSi/nUNGqB6e9sVMMWH3zBVMpqZvXYnQuPmeLga/vMwpwcS9uPu6UjJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441007;
	bh=LJYcYx+MVMCeEhYVM58rii8oOFcXAWR26C6yKzp+p9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3EUSgEDQj/W5lG/i0gbYlqnHwKGjLsrIrKsk0Pihh9LA/8mXITKZdxEPwVkQ3mZx
	 ZohrW3xe2Fzu3DDm5TqPENkElnBiojeCJgNN9WfjhzpntE7jXLaFNrZcM+UmOIdOBC
	 M3NcqcD69ZC0crxnNc6EJFRmqq2K8vlDofK6tmzzT5QarPuEo6VyFGxpCzx52ZcGh7
	 LKdILFixl+7jo4rCY0T5xfIxFZZdn9Np087QpUo1N98UgnWgJqug/4sZrgQNrbGG8q
	 srNFbO3RdGjBbxMSn+bjRXDShyC9iaro3mNho0KuIVQjzveZ8cGfOC5jM+7MUxzf56
	 sEGBe0FUPdXRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5F7C60B6D;
	Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6160279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC5C140469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rewnYsaWMmAA for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8634440462
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441005;
 b=cag3K1SDgUqI7AGXSWb/bZoDZN1xjSuWee6hekZ/YefiYpAq5Wn+5qMb04WlZLC0G6UA
 Ye8UFKNUs6Tisf9baPod5tvIIDvAneyZn9JQpE6YJFoatcDO3FRQW8qBVIfC43tpHOrgF
 ceSEdAPSgQ+QBUAYHEUwQxQdZHTCn4qf+yMinMAfuOwAN1j9dgeud3sMPV8qdpkC8fvts
 f0A7+sSuYrI8UtRu/4Hku2KQluWJpUylzJF/mVs4RkX1M878mhhHJrXvWn1lYzaGTafeI
 d9NOA9gYFTlA01IxcT++z0qnaZLSnfUyDzmX6i7IWPdxKvMe6g1UlwwaebeyEHn2XZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441005;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=LJYcYx+MVMCeEhYVM58rii8oOFcXAWR26C6yKzp+p9Y=;
 b=qapBVbrQxf1p3CQrBGgMNd7lY6S23BLbRIb900nObnqZ8w8F7Ez8ZjCgrubtGJ/qSVNN
 xfnQAGKSmh7ok1EePLtdpGZ4aBgG5YH7oGPb/ddGSL396A8Vq/qby+PModI5a4+OP6QZL
 IL7uho3f21FrVc6dnnvpA85s6bTK4jtxRbKrGfts0zgf0kW/WmAWH/p5tRZtdrXRWDqds
 uhHWRkMyrJeH0I2rXuSFVcumB8Y+KpyxzEIhbg3I89KChuKk8TRRLfqFswZYxBT9xuT3P
 XFwfLMMgRSdKsqvk7sorfYI/6IdOqi+o/hCIGn4zMiqcPjwqsh9H0wQT4gdOyrzMi9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GG7nPxTm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=GG7nPxTm
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8634440462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:04 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso1633305f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788441002; x=1789045802;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LJYcYx+MVMCeEhYVM58rii8oOFcXAWR26C6yKzp+p9Y=;
 b=GG7nPxTm+PUTHMR8lPFKKsfMhYI2fnjUImQuPVR7WVvLCVRf/POua1DelnTkeMSz4n
 VlnwFzJx5x1gxkqv8WxFaEWREOgssTD3hbASzKhSSMV8V8b1mUhvOGMLPGI0WvhBon+4
 0HAt0uFqLBaKRXkNWy0I418EWzja3WxPWhVsBqvR1NHmH6Ippx4nPx4Zq/mZBsd09zfz
 +gjmctzctLq/gg7CbanPEwXHAKSQXZYlIutPtybGF+Z2NsBaIzbemtLC3TeQtVDrkHCw
 YEdxKM8i2bFsL1AEUxIDw4i2geMAJlqq/ZlLiRQpH21z6p7QXq6AHvRklInczNOBduiO
 MVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441002; x=1789045802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LJYcYx+MVMCeEhYVM58rii8oOFcXAWR26C6yKzp+p9Y=;
 b=Mge/71PWXtYpOPzdIKbxFCSXxrvIP55XNHr0ODuPwfGpLrnleVlDuNe7n10z1lmF/Y
 tbxYEA0kZizom2/Cv3VfTaIuumUyemecTKaVKP4lYOXPY8kSRfm/kmGrhj6tizRCP4zB
 nEqMvaWZuMOJzJlIH4/DmwbNjoFLnzFyj+Y0LAia9G2toFXtP1bNazzoY8BqNN3iiQgX
 v+cAkL4nGEuABsFAWSE/iw8RA6Vl/r4WKLueHoh+tyaiovGXuEJRiFgaT/zwQM45tUuD
 nbsEryxRydz5y/ciWstMlqCtE56sTMa9sugXivOhuWNmk+ZekYAgwOfab371dveAtOPQ
 jYmg==
X-Gm-Message-State: AFuF++ly3C7Ph0FtiIVHXZCNKOGL7jvdw9HyyNPanITL/BvnB6HKlRjT
 h4xyd2ZvN91s2X9aQaGMZChq8Td+gBkjICa5SaZLdMpAlNT3g/sUYSdFLJQiPIcofPM=
X-Gm-Gg: AYBFou1/6K6LWCDv2SBC/iqNxIzG2z8ItMhzeCpjuua0Ou2EnGlBtGHCm8HEULrfwt8
 dg1DFOJMIciAnii678hxX70S/FfU9r+Uj8Q1xVlHXJOg/zpKdgb+mhU0PHFRSvxiJzAFEKZPRN2
 VmIScOjLE6nz3wFJRrEHWMqTbgOaJYQWCpDbUmgvYgqJaftwdnhCOKYhU09yLpMs9QB1V+9wMEA
 2sLWVvmmv6avCBF/AmGHWq7s2tvnB3XR/9Hxyt7Nl9fx0EDD68HTYcYbHFETeE1YWGu7fNHwV98
 vVA4OITkPRIYktikDuSwK352e5CnXFbPJzceiLZ2sk7mOW0W8k0qipXoNyXNT6sZFDledpbyF+Q
 bBrNuL7lmPuaI8oiLyLbulE3M7OPOlU1FPJgT/GIr/ZVRdoQvRZch/zWDAEwcLMSa8jbYHm40MR
 bscvLEHQq1PfrWqpMtcxF4EE73QFTW4zTBUMxwDJpq1d8Mj0KiWXtQc7IuvsdVU6CKSLTWJlJMP
 rvn2tAvgYIIutXl8tG+QK5FESim9el+T5m1Xc1kUfK9M/xXsnFP8i4/1R2LLrd/CDuovZT9qX0n
 jYWO
X-Received: by 2002:a05:6000:3106:b0:481:51b7:290b with SMTP id
 ffacd0b85a97d-48488f20a95mr19776729f8f.14.1788441002195; 
 Thu, 03 Sep 2026 06:10:02 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:10:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 03 Sep 2026 15:09:50 +0200
Subject: [PATCH v3 3/5] bootmeth: efi: use the firmware-owned devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ccaione-upstream-ebbr-v3-3-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

When a firmware-owned devicetree source is configured, stage it at the
same fdt_addr_r value used by the normal EFI bootmeth fallback and pass it
through bflow->fdt_addr to efi_install_fdt().

Use firmware_fdt_stage() in both disk and network paths. Only -ENOENT,
meaning that no source is configured, permits the existing ESP, network
or prior-stage fallback. Any failure after a source is configured ends
that bootflow.

The firmware-owned devicetree is complete and authoritative, so do not
apply extension-board overlays on top of it; those combinations belong in
the FIT.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/bootmeth_efi.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e187dc39912..f58e90b6d21 100644
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
+	ret = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
+				 &bflow->fdt_fname);
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
+	ret = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
+				 &bflow->fdt_fname);
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

