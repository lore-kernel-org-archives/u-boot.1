Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E1606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d1MLUsZE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhhkI1zx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E76CC606E3;
	Wed,  4 Nov 2026 07:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXzfLt7gB-Ck; Wed,  4 Nov 2026 07:18:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D562F606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776704;
	b=rw7yZHsB/4BzzuWjj5zM74u4UEKeDdKZODj20ArEx0Y47MxWh6oMRt6Nj7oUjvOWkgd5
	 w5J9ekLzH9XJxsx321pJBfu8apGQ/VH9jUtBRc0nHV8y7Uw00M6KfIFvcojy5DCD5C8eB
	 WmPvmJnxc0kK2bk7lvpuceAHLUCdlbAhT4y8WMSLwrYwkzMwELhtsiLBHVxBRr+TLJNDn
	 7QyS8vMcbyD+RFKicKws2m7p/+1dKyC+EkSNKR8NTnKtMBLNOVr790dCm2fziv+yJFojj
	 xit0Fade+1poHlp4qHVcexrVS8xCmS8Wv0+nFTPkyRB1BwYNFGuwdd/eQkmfjQ4JWSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uSi1vWhi27MvSmw0u08lNcI8dawsByW3JZh1vsssIrQ=;
	b=oUyxAt75GvPkgRimLL+QtQ2XpvBmjC9XUXEby/iQyFyELjYZFwTeJyecYHOIttubfL7n
	 Du3yYeCJZ3BPdhgIWo7pXfonbHldgSd33ZbuLnJuwR6Gj0lU7393PmbeH6HsPMWZ+tPt6
	 nFb2GIRenQ990Nt5fViICpI1Ls1o5IcViOjeEWT0p24U95eBGPkGCeYYD+qW2G6/wflov
	 xriSQ1438o8YgA4B6Tosyo7UnwtaHeqKIqapMfW9ismuIG0ZHMsnYj2WduebPGoQHcKRS
	 t06yDJVUkyT2POCtUPweDf2oosPsZ81A4xHTbhGKlW6KAiOjzzGKv7ki0qOD3obMZcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhhkI1zx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776704;
	bh=uSi1vWhi27MvSmw0u08lNcI8dawsByW3JZh1vsssIrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1MLUsZEV7M+97k9rQlONJ4jzRrirFbiCU717OU6LBAc06V2eLRa6q8ufHOzyLz3N
	 kERtkGJp/o5WJfovVcSxgz2ZXYCEY4beDyOOBM8nK6Va6ZIENr7Hv7lcTYwutHRRSG
	 +J1GLXSedIu5iBs9l4KD6fICp+vSpW4gb3lblP0yryVEH3vVePo+c0EQ/AqvKyCxzh
	 TjUeul97kaMGWqnbzvTv5euNid7HqnWCsIBkn17pqyFIfvj7Fz/KPQahuKxDWkaX/f
	 Ceam3S/iyzpUvNn85HLqlAOC16q500tnDUCTPL0r+FjlOeeKzkYAYl3OfL4MrD+9Yq
	 lH7AH9U9ldtRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D562F606C4;
	Wed,  4 Nov 2026 07:18:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B93162B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F118606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGy-GY4EaB4I for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65EF960698
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776700;
 b=qZ+q0kSrRADJdhjoWxFBFprX6eOgDmZrGBIDOSFfbDVhMRf8m4yf6mG3O4HI34JkTp5k
 q7kbVb7iTn1rUIqOY18p14+0HgVUiy3jf1eKtXPO7aZwnqV9fMTFVq5yIa+yWWKRrLk8R
 tIJJAYbuafHZ0/riev/fKCRmsaOAlb6qJJg4vHl3IBdQDjMoFHhaJc4nXt/qf/MXv8SV9
 6HlRDvenOrXiU2xmISc9lYM8vNVaaK/aiYDNMpSBaX/VkQgk/56kBKo58UiToes4mZZSo
 ojsUlqGZkAmIDYoc9EF20ViwWKGqONhr9iVOYFAdd7LLajbkZq2vSIlvjRVspCIh7FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=uSi1vWhi27MvSmw0u08lNcI8dawsByW3JZh1vsssIrQ=;
 b=HXxCZ2u8nItQSp2lAR68tVOyBP5+vj8brQnBzA1xgd8BU3PqUbgQ+5z/Oid+xQL9Jud/
 eNCnCzgK/xY4iFOjeBT+EZSNjvRuDZ/+EMoJtoWCXS6j0uBJf89RCThZU1n3LcdIIuJ9g
 wvybAcYuvm33GsfVSUqjTTXKS982DtUzbAPcfaU7irXeKPss8FSqA1XN/UB9h3xy8MNW+
 7+uJV/Lq3a7a/GfZjGkTsn28X+0T4yeRYUV+CbSgLrkqVofvU1jlElNZes1PRPETFWHVI
 sbikAm76KyabMN0oE/uoeDiMESUOnjBTNnhV476PFV4Q9fSC+xILw/tlERSarwEgjQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jhhkI1zx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jhhkI1zx
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65EF960698
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:19 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so169036f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776698; x=1794381498;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uSi1vWhi27MvSmw0u08lNcI8dawsByW3JZh1vsssIrQ=;
 b=jhhkI1zxqMLX9mCuLhHQc6T2WoYWmZ8TFtdP39DqZz+O0tVKJEaD4nZFWWqlqglBED
 3n99N3bxoGkw4e0EJLAua+d8N51XYhY3cz7plZ6Kl53rB21Ov+I1n5cwD3hOJEfaKpoa
 Dzi4+7QQHoIB2xj+bsq9DgxBEHvUsW2kTgtwW90lm9ocGQcGV1gISl5/kCyyIWKTaSkC
 QD7AOCspCo2byvTJ8qfl/YgmzYJHWkQHdLKcveYBoea58bO8300jvGxZAekFmt/ft5Zp
 Pc43pj+dsBgKPfmw6ZEzH9rpk9/b6FEb+pHGdfuaBU2m0cQ7icNrn2JNm6iGUmOh9nvf
 w5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776698; x=1794381498;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uSi1vWhi27MvSmw0u08lNcI8dawsByW3JZh1vsssIrQ=;
 b=0k2bWjCCFZf6aG8WsQVrinhBH0/PYsqGbraEtygw0txOOhcAjZOBlO7vYfYCNAzW8r
 i4/Wh+74YyAmKkIisK23oVpMqkdqREZyFLllHj0HaMUGFAOzCMt5WjkdZW+M0b34+Iux
 4FlCbZq+/bkPHSkCk+wLmq1CMz4Yhuzk1QnQyTr9UxRlNTkK7Nq/U7fmRZxVWTiX6p2e
 PWjM8yxO6WOUcneahNHvCVeAaqeppAHbeRXuG+Uk6B9f7dnH0wiacqE1iAKDTfNIB/Iw
 NmU+DpKH38UJlC3UlXTz2NPoU5x9SE+vyYIJGpdqUHlcc5XbNsZjC32PE/eE/u1qhiZ/
 BG9w==
X-Gm-Message-State: APuU4Z+0/JTcja5JDROdQzQiILniNHlRRmOGPrcex5m8oSjyKqJGndiT
 u/WIMc+L2bmhHu5E/blGgkNev7TEghGmTI5oD0m4UxQRWEv0XzT3DR50yicPKk0dopc=
X-Gm-Gg: AYBFou2qM6cRGsu23MayhmEedW0RPxC2RX5iLFlLUqeNvu2gEE8B9whU1kc9tp0uXod
 DRrTgxZaODbSA/9S/B39hlZOCq89pC+14p2GVTf/5k4YRWou/SmSMjN1FAq7eCfmQunReoU6u3T
 GGz55wdv56uJ2ZQrbUxzlFT10Vj8e2u9MEK6maOD943XELbNVzecfYlZBJ6ltmVPJI4ZLAPlYvk
 zvP+WQmVV2wmgepbqOhyGLv93asB/axvz4klAsy1ZLRDA/esr6cTpNKqiGapdIC7p9pQ2jPoZA2
 0x7TITL7WOG50LeaUzUf2UAMx/tx21Q/iYtKlr4ezOiNpWNDXIm9Xwy32tG/fqQkkICOogbpjGD
 msO86AVSo3l1VIBJ5reeFX0T0UrPuToaNNhcpMNjIpOH/ahgBA7keS2HK6BWuQ4O7neqc3TXWYh
 PnKSrMosPcGdn+JY/kMAS+jPfDyW0ExszZDGBSdBz/ezU3oLwQRZeQJfL1KpYdD82jGETiFO7k2
 u2kJmK4ZwWI5QV6lNzgsEgxgfU1FsjFI4Dm6jWLnG5Sai0Ujc/65SNmSpBT0U/7YAUd6Fa4vkCC
 kfIMszZgurGMF8hieZuBasKlu47MV/k=
X-Received: by 2002:a05:6000:2306:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-48e6e303c80mr31773382f8f.31.1793776697752; 
 Tue, 03 Nov 2026 23:18:17 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecac1a1csm2184070f8f.12.2026.11.03.23.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:18:17 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6/6] usb: gadget: f_sdp: refuse unauthenticated loads on a
 closed part
Date: Wed, 04 Nov 2026 07:18:16 +0000
Message-ID: <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

On a part with secure boot fused closed, the i.MX boot ROM's serial
download mode only runs an image it has authenticated, and NXP treats a
ROM that reads out memory there as a vulnerability (CVE-2022-45163).
The SDP gadget in SPL takes the ROM's place in that chain but does none
of this, so a host on the USB port of a closed part can run any code it
sends:

- SDP_JUMP_ADDRESS first calls sdp_jump_imxheader(), which calls the
  entry of any IVT it finds, unchecked, before the FIT, container and
  legacy image paths that authenticate;
- SDP_WRITE_FILE writes anywhere, the running loader's own BSS, heap,
  stack and page tables included, so that what it wrote runs before any
  image is checked;
- SDP_READ_REGISTER reads any address.

When sdp_is_closed() says the part is closed:

- skip the raw IVT jump, and take an image only by a path that
  authenticates it: a FIT with IMX_HAB (spl_load_simple_fit_fix_load()),
  a container with AHAB_BOOT (spl_load_imx_container()), a legacy image
  with IMX_HAB whose header starts the range the i.MX jump_to_image()
  authenticates (else the entry point comes from an unsigned header).
  A container on a HAB part, a FIT on an AHAB part and a script in
  U-Boot proper are refused. Where SPL searches for a FIT or container
  header and finds none, an IVT image on a closed part included, the
  jump ends in the existing panic;
- receive and drop a WRITE_FILE that wraps, starts below DRAM
  (CFG_SYS_SDRAM_BASE: the ROM, the peripherals, the on-chip RAM where
  SPL runs) or touches this phase's BSS, malloc areas, device tree, page
  tables or stack (once relocated: the stack up to ram_top);
- refuse READ_REGISTER.

Each refusal is answered with a failure in report 4, and the gadget
waits for the next command. Read-back of a download through
READ_REGISTER, as imx_usb_loader's verify option does, no longer works
on a closed part. An open part, and every other platform, behaves as
before: these checks only apply when sdp_is_closed() returns true.

Fixes: 5661f08a7144 ("usb: gadget: add SDP driver")
Fixes: 2c72ead73874 ("usb: gadget: f_sdp: Allow SPL to load and boot FIT via SDP")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/gadget/f_sdp.c | 125 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 8bd8f239766..7d12f0b8444 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -22,12 +22,16 @@
 #include <log.h>
 #include <malloc.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
+#include <config.h>
 #include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/sections.h>
 #include <g_dnl.h>
 #include <sdp.h>
 #include <spl.h>
@@ -36,6 +40,8 @@
 #include <imx_container.h>
 #include <watchdog.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 #define HID_REPORT_ID_MASK	0x000000ff
 
 /*
@@ -69,6 +75,8 @@ struct hid_report {
 #define SDP_WRITE_REGISTER_COMPLETE	0x128A8A12
 #define SDP_SKIP_DCD_HEADER_COMPLETE	0x900DD009
 #define SDP_ERROR_IMXHEADER		0x000a0533
+/* Status of a command refused on a closed part (HAB_FAILURE is 0x33) */
+#define SDP_ERROR_CLOSED		0x33333333
 
 #define SDP_COMMAND_LEN		16
 
@@ -113,6 +121,7 @@ struct f_sdp {
 	u32				dnl_bytes;
 	u32				dnl_bytes_remaining;
 	u32				jmp_address;
+	bool				dnl_discard;
 	bool				always_send_status;
 	u32				error_status;
 
@@ -293,6 +302,61 @@ __weak bool sdp_is_closed(void)
 	return false;
 }
 
+/*
+ * On a closed part the image is authenticated when the host jumps to it, so
+ * its download must not change what runs before then: it has to land in
+ * DRAM, clear of this phase's BSS, heaps, stack, device tree and page tables.
+ * SPL runs from on-chip RAM below DRAM; U-Boot proper runs from the top of
+ * DRAM, which the stack range covers there.
+ */
+static bool sdp_write_allowed(u32 addr, u32 cnt)
+{
+	const gd_t *g = gd;
+	ulong start = addr, end = start + cnt;
+	ulong sp = (ulong)&start;
+	ulong top = (ulong)g + sizeof(*g);
+	const void *fdt = g->fdt_blob;
+	int i;
+
+	if (!sdp_is_closed())
+		return true;
+
+#ifdef CFG_SYS_SDRAM_BASE
+	if (start < CFG_SYS_SDRAM_BASE || cnt > U32_MAX - addr)
+		return false;
+#else
+	return false;
+#endif
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		/* ram_top may be 4 GiB, which a 32-bit ulong holds as 0 */
+		top = (ulong)g->ram_top;
+		if (!top)
+			top = ULONG_MAX;
+	}
+
+	/* Stack (up to ram_top once relocated), BSS, heaps, DT, page tables */
+	ulong busy[][2] = {
+		{ sp > SZ_64K ? sp - SZ_64K : 0, top },
+		{ (ulong)__bss_start, (ulong)__bss_end },
+		{ mem_malloc_start, mem_malloc_end },
+		{ (ulong)fdt, fdt ? (ulong)fdt + fdt_totalsize(fdt) : 0 },
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
+		{ g->malloc_base, g->malloc_base + g->malloc_limit },
+#endif
+#if defined(CONFIG_ARM) && \
+	!(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		{ g->arch.tlb_addr, g->arch.tlb_addr + g->arch.tlb_size },
+#endif
+	};
+
+	for (i = 0; i < ARRAY_SIZE(busy); i++)
+		if (start < busy[i][1] && busy[i][0] < end)
+			return false;
+
+	return true;
+}
+
 static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_sdp *sdp = req->context;
@@ -326,6 +390,14 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 		sdp->dnl_address = addr;
 		sdp->dnl_bytes_remaining = cnt;
 		sdp->next_state = SDP_STATE_TX_REGISTER;
+
+		/* Nothing is read out of a closed part */
+		if (sdp_is_closed()) {
+			sdp->error_status = SDP_ERROR_CLOSED;
+			sdp->next_state = SDP_STATE_IDLE;
+			break;
+		}
+
 		printf("Reading %d registers at 0x%08x... ",
 		       sdp->dnl_bytes_remaining, sdp->dnl_address);
 		break;
@@ -339,6 +411,12 @@ static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 		sdp->dnl_bytes = sdp->dnl_bytes_remaining;
 		sdp->next_state = SDP_STATE_IDLE;
 
+		/* A refused download is received and dropped, then reported */
+		sdp->dnl_discard = !sdp_write_allowed(sdp->dnl_address,
+						      sdp->dnl_bytes);
+		if (sdp->dnl_discard)
+			sdp->error_status = SDP_ERROR_CLOSED;
+
 		printf("Downloading file of size %d to 0x%08x... ",
 		       sdp->dnl_bytes_remaining, sdp->dnl_address);
 
@@ -414,7 +492,7 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 	}
 	sdp->dnl_bytes_remaining -= datalen;
 
-	if (sdp->state == SDP_STATE_RX_FILE_DATA_BUSY) {
+	if (sdp->state == SDP_STATE_RX_FILE_DATA_BUSY && !sdp->dnl_discard) {
 		memcpy(sdp_ptr(sdp->dnl_address), req->buf + 1, datalen);
 		sdp->dnl_address += datalen;
 	}
@@ -757,6 +835,23 @@ static u32 sdp_jump_imxheader(void *address)
 	return 0;
 }
 
+/*
+ * On a closed part the ROM only runs an image it has authenticated: take an
+ * image only by a load path that authenticates it, else report the failure.
+ */
+static bool sdp_jump_refused(bool authenticated)
+{
+	if (authenticated || !sdp_is_closed())
+		return false;
+
+	debug("%s: refused on a closed part\n", __func__);
+	sdp_func->error_status = SDP_ERROR_CLOSED;
+	sdp_func->next_state = SDP_STATE_IDLE;
+	sdp_func->state = SDP_STATE_TX_STATUS;
+
+	return true;
+}
+
 #ifdef CONFIG_XPL_BUILD
 static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
 			   ulong count, void *buf)
@@ -842,7 +937,10 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 		break;
 	case SDP_STATE_JUMP:
 		printf("Jumping to header at 0x%08x\n", sdp_func->jmp_address);
-		status = sdp_jump_imxheader(sdp_ptr(sdp_func->jmp_address));
+		/* An IVT entry is called as it is, unauthenticated */
+		status = SDP_ERROR_IMXHEADER;
+		if (!sdp_is_closed())
+			status = sdp_jump_imxheader(sdp_ptr(sdp_func->jmp_address));
 
 		/* If imx header fails, try some U-Boot specific headers */
 		if (status) {
@@ -864,6 +962,10 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				int ret;
 
 				debug("Found FIT\n");
+				/* spl_load_simple_fit_fix_load() authenticates it */
+				if (sdp_jump_refused(IS_ENABLED(CONFIG_IMX_HAB)))
+					return 0;
+
 				spl_load_init(&load, sdp_load_read, header, 1);
 				ret = spl_load_simple_fit(spl_image, &load, 0,
 							  header);
@@ -878,6 +980,10 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				struct spl_load_info load;
 				int ret;
 
+				/* spl_load_imx_container() authenticates it */
+				if (sdp_jump_refused(IS_ENABLED(CONFIG_AHAB_BOOT)))
+					return 0;
+
 				spl_load_init(&load, sdp_load_read, header, 1);
 				ret = spl_load_imx_container(spl_image, &load, 0);
 				if (ret)
@@ -889,10 +995,23 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 			/* In SPL, allow jumps to U-Boot images */
 			struct spl_image_info spl_image = {};
 			struct spl_boot_device bootdev = {};
-			spl_parse_image_header(&spl_image, &bootdev, header);
+			int err = spl_parse_image_header(&spl_image, &bootdev,
+							 header);
+
+			/*
+			 * The i.MX jump_to_image() authenticates from load_addr
+			 * on, so the header is signed only if it lies there
+			 */
+			if (sdp_jump_refused(IS_ENABLED(CONFIG_IMX_HAB) && !err &&
+					     spl_image.load_addr == sdp_func->jmp_address))
+				return 0;
 			spl_board_prepare_for_boot();
 			jump_to_image(&spl_image);
 #else
+			/* Nothing authenticates a script */
+			if (sdp_jump_refused(false))
+				return 0;
+
 			/* In U-Boot, allow jumps to scripts */
 			cmd_source_script(sdp_func->jmp_address, NULL, NULL);
 #endif
