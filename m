Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18E606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gpg2DO3A;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ICLTw7RH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 568A5406FB;
	Sun, 25 Oct 2026 04:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYlWKaI9bChb; Sun, 25 Oct 2026 04:47:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B49B406E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903653;
	b=oUkoaQyui+NMOATPzmTeivoPXr7CWE6uoez/vuSx9k+zWx3aZEE4ZDRjzRGBt3UcBdTz
	 7vwZW1XCSN2h+DE3aKLN2jSJ53K6GDPALYZ6XwDchtjFyPST62MHsrWSUcwG0WWalAW+q
	 3WNkmcwobVSB2mGPkCO5xZMKwJEmuYbz5tgpLn2OsJ/aPd+Z3GfvS68jVPtzWJMoF8Pxj
	 IGYHhwlj/yJEsr/uylkMmF8NhNe2lnocioEQNi315kcTyNCbVPAQaLKYQWoJ0NKAlRfCV
	 aXqJ1XqvyMhOQJfQ1/di889E6krzOLxTkDYtzrSoUzBdg1l+zw+2vKjj3M7hrFch8Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7XRPSc30E1U+W2C29l3ceapD4kY/E5Lk/kjvaLyRx8c=;
	b=FXPPB59ri5A7dCd4vQmxupFJljdNZ+k1i3w+sOcgSOl8Kxm7rqRCjKJ2sjFRsRcmODv4
	 P0X/GkxENbx7CAwYPwOdyTM8MpbpxmE8i54/R+wS9Iqd8yYdSkfUFMA9IUUszwu7kkplf
	 +9qzhtlq8Zg7M71DhKcM8hlfQhP6YrROTvln9pun5ORwC9j8i1VBCkTPGuejUqfQUQyWd
	 SjxzLaiYR1+m4/rlIad0NQSKpR73+UBRJB0xzytcpWSHwUAdAAf+Z87PeWoN5P3jTM4s1
	 HzMxoAvyRArz8iQGb5IdwPy97u8ictVT5XbT8jq3hX9whArUqM9DDUp9uv9QNNLK08A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903653;
	bh=7XRPSc30E1U+W2C29l3ceapD4kY/E5Lk/kjvaLyRx8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gpg2DO3AIquzIafw9msdFk9eEX8so8aC4pjiAxOkMWUzfEfW68lf4KnTIT1m6A5xx
	 wR7kxM+p8oL3QtY9Qv7DwUimfZmGz5vdBv2SyrNlfluoa/DB71Z6n8MpmYStNt4YsU
	 d3DIwpKzTpsTn7cnBtEiNi+XgYJJxFwJGYlnWBhmVEa3o+/7ELHy5yhqlVEq9DBc8O
	 ROC7YaHp5huHn7um8DP/a7WbQlIVu2V9ORzpzvHOQNhAS9pkcKLBImzDKgSVZ2Pw14
	 jUmA0SUhCMJdX6nz4pafLFFzh7E/CB2pm0Nuo1hh0VXDHwwy87mcejsYjupMuUNPrm
	 735cIN/zxliTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B49B406E4;
	Sun, 25 Oct 2026 04:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D44F0765
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1F0380E2B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20LiYFerij3d for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A56780DB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893638;
 b=BDXdzL15o9/yvjFjDkGSvUbsfuMORX+V1xStLF/Bu/oCCJgOrundCCUmK0VaOnyxQWtq
 M/0+MwieU5TVmK49l4Uqw5/vqzgmi0xTz8njQ/RCy3kEDsJRmWMCMABEQasJkJ16L4g7s
 g+ZRChGXuYdw2dEG3SASqOi2wxurlBubBi8IqGhr6WsEkjYsEp3i23JS1oCrKzH9zCLFn
 DaUniWe3p0jfVxwfuAYvqHxwiDKM3v6Jqk2s004zLeYX6bCXGaRHFD7gWd6KVoFaL/h3s
 eikEE4td/JFPh+S3+20oBZXsdhfXKVBcpabGmASG9Pn2d6sYfB2HtDBWjw6kKAGXZsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893638;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7XRPSc30E1U+W2C29l3ceapD4kY/E5Lk/kjvaLyRx8c=;
 b=OV6aTb42EN79Rba/Hvw9vKAzGsS+DVcemwclqRK2bB6VRzAgZdJGezZwGVbiPQogUAFY
 vDIXRUUrh1jWKxlfq+IlFGRPyyTnz9rn4BnDb1wonEkimEWVN4JjkYfp92DXWqvlailNU
 G5KqdY80e9We9aom/jZaGZRZLzrVKXYDkU/gK17aYyF7v4UQfWhDhsO2OFSsM2ss0x8eB
 wGPMZj6ld9ThJcC2pQK/j/bIiYRgIeLz3Ai+W+kEVIunEYXZl1KYioYZHb42p/22+0TMM
 4w+LeSAtxDjkfxEMXdJBV4h2CdmMDhOWWQdUhRo0wgEfYIBV4v0Cg0IxmCIWa4m3Vtw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ICLTw7RH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ICLTw7RH
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A56780DB3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:37 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5ead4026fe6so809490e0c.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893636; x=1793498436;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7XRPSc30E1U+W2C29l3ceapD4kY/E5Lk/kjvaLyRx8c=;
 b=ICLTw7RHoec7Z/XvQ31URgQzl/vSfz6HqEqNfeRMUVWF17dmEOEyjAj+eejMo2uLKE
 b1xgg3yyY224VbUbZXaTXR1L0gtF1orVodvneEneAf8t+0jbT3lLJbDRZYDBanhou/CD
 XLYjV6Ns8YyPN5uOno7iF1vuNrlxineWICv1QFlobi9aK9UunlIXIZukGOgSfFKzuk7L
 TmDwpBz7HSIBH/JLsSGJGtVLh6oAEu6wVNm8DLWaUPIguJ31V9RDkj/K+MsaSCr5I05x
 D256jSklPWaoeHMGBD/Igwf5LHoIVAF6K/wDiDq+EubUWEFpll+E21cFzBolKgdhGMLS
 eoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893636; x=1793498436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7XRPSc30E1U+W2C29l3ceapD4kY/E5Lk/kjvaLyRx8c=;
 b=eHWAvGZQoC7Vjz7cGP+q3wy+/V+3rtlEQpWqgkNU8WZIku36u4PlSNnz8ueKN9PUn4
 BPF4eHi9aHLlgpm/wRMTWkaVxRf8oGxesmrr7EXfMGgJM/bjnL7+xhU+05mavKWj5EvB
 IjKobfEAEY426T9WFaKrPQHPpfctcFjb8HWGcyLzhUPTcJXl55dx1IIPUUobvrRDpmeU
 LtS6qRvLeRGzkFEQqxdiwrc/rCEJbxYdUHRzCID+RfPSXRuapNhqyx3UdC21p94vKjz9
 vweMTqujqBG2InDDXH6CJRMXLgJhybLl1K3VYnr8SjQbE54Nkc2FEbZ1oE/X0iyi2zkR
 peRA==
X-Gm-Message-State: AFq9FYL/tPHwc3453z4gd/uCSx0yFBEhcCDxauD5by6YOkX+esj5PDMO
 tHWulPV77uZPqSDUb7a7d/mS8zU6YnFP7wVDqFQ00eCC9lC3ymAt8wB25e/WtTZT
X-Gm-Gg: AYBFou2n5Qn39BskATbSE3ZlRCUJoUhGND8HBWfZgpB40TyuuYwZk8Y8tythV6KTL5n
 4QrtMJJ47k3K5wZUUk6NpmkEEPMbZa8p+H2m87CkKFiQKsttosyZunRoMzkcxjrIWSBiqhfndMH
 M/EwV1LAniR9UrWLHCZkV7cGAFoZ3icZ4gRIz8LGbE30OL6woK8kqWmzfuD91qCAwvLYn3neH4L
 u1iQlmDlwWsnFCLd3noFe2+T0tzjxZqYjZP4y9mT1azfeHY9uLEAGgF9F7lvV/1rB8gXAG5BUu8
 sWuZi+++thfMeDhirLItNsJnYXn/HftAVrhvc0UOBin8+Ip51tKvq4TkZ8PNtYjexA6p5cTiVk3
 7j4hW0RrmBijq6OB18WxQNwMl4Ji6bpv79Fqcu70oTk4C5j6GSLE3BS631Vh+wTJD+3Kz/EbN6t
 phztMCqmGjvs+RxqGUbIoznshzglX4S88SJkRInYnJgv9u75pzRkSHpT8Mgs6GNP9jwgNasIpQ0
 y/SQCIFDpY7t5LSVMA9v7V550L8LsWtXhuuJpD2sR5wP5ccYIEN3B6sa2lV/THp9rwvYH1ndtIW
 srd0BmWShU2TyBW3jhDJDVYf0AI=
X-Received: by 2002:a05:6102:b10:b0:7cb:288a:b66d with SMTP id
 ada2fe7eead31-7ce5cd41424mr791761137.20.1792893636590; 
 Sat, 24 Oct 2026 19:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:36 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 6/6] board: nxp: ls1021aiot: Keep the IFC enabled in the OS
 device tree
Date: Sat, 24 Oct 2026 23:00:12 -0300
Message-ID: <1e504b62f926ec1d45dd88830b5466725f9b3f0f.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ft_cpu_setup() disables the IFC node of the OS device tree when U-Boot
boots with QSPI enabled (CONFIG_SD_BOOT_QSPI or CONFIG_QSPI_BOOT), since
the IFC and the QSPI share pins on most LS1021A boards. Both
ls1021aiot configurations enable QSPI, so Linux never sees the IFC on
this board, although its system CPLD sits on IFC chip select 0 and
works alongside the QSPI flash.

Keep the IFC enabled when the device tree passed to the OS enables it,
so the CPLD driver can bind; a device tree that leaves it disabled is
not changed.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 board/nxp/ls1021aiot/ls1021aiot.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/nxp/ls1021aiot/ls1021aiot.c b/board/nxp/ls1021aiot/ls1021aiot.c
index 52a3c3abdb4..66f7ca659a0 100644
--- a/board/nxp/ls1021aiot/ls1021aiot.c
+++ b/board/nxp/ls1021aiot/ls1021aiot.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <clock_legacy.h>
 #include <fdt_support.h>
+#include <fdtdec.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/immap_ls102xa.h>
@@ -183,8 +184,23 @@ int misc_init_r(void)
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	int off = fdt_node_offset_by_compat_reg(blob, FSL_IFC_COMPAT,
+						CFG_SYS_IFC_ADDR);
+	bool ifc_enabled = off >= 0 && fdtdec_get_is_enabled(blob, off);
+
 	ft_cpu_setup(blob, bd);
 
+	/*
+	 * ft_cpu_setup() disables the IFC when booting with QSPI, but on this
+	 * board the system CPLD on IFC CS0 works alongside QSPI. Keep the IFC
+	 * enabled when the device tree enables it.
+	 */
+	if (ifc_enabled) {
+		off = fdt_node_offset_by_compat_reg(blob, FSL_IFC_COMPAT,
+						    CFG_SYS_IFC_ADDR);
+		fdt_set_node_status(blob, off, FDT_STATUS_OKAY);
+	}
+
 #ifdef CONFIG_PCI
 	ft_pci_setup(blob, bd);
 #endif
-- 
2.43.0

