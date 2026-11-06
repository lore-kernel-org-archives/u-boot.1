Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF10606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ieszNX9t;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YEjFuyZh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 776AB81021;
	Sat,  7 Nov 2026 04:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUrc-s4XW1_q; Sat,  7 Nov 2026 04:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFBD7814BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026574;
	b=Tbu9IhcCwUwItg4xuZ47345t1ZhH6oCtfZ305p8Bt8QSBJdJAJIxTt66/qP/2Ple6dR0
	 jwe6mqmbe2Pn/p7XVB0qpYw5oU/pPsgAWBsvpGLpMccl2sm/5ssM7IYh1xX29G8DW2ZdZ
	 yfXCRkyH6ZjRqJwQhrmLLt2ZuIqM2VE/G7co1ZRz2CSG1c+sk71tBLqOKxANvYemLR8MF
	 SP8xfPQGPLMDTGicfz2nexfdIl2vY7p+x2Qyjtkr/FpUp+NwKtEnghOYRxaFV0dMHns+s
	 PoS+IZFm6ZNn4tUBmcyNw5ZeWK5iRVyEUH3Zyg1fSbJEUToSsExzq8FVPj3bW6CLzNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XQYLKT2O/Us3uWpjJRqGAiVWj3QwgxrL8d+4j72FfH0=;
	b=mGt2Rc2ZRfYqIng4TwNplI7TSpNWVxHTGSmXdlYiE25cUT+qP+R2J3/If0gCjYH9+tFQ
	 +jUthm7ZbmvyqkXtbww8S5H9vmYBl56UzwAXc+JaN+O8ruvOQm3plM6azxgqJLV2Hu3Rf
	 CaHXVRVZJzqUvK5/mxHEfpNGz6JrGV+SeqfnAH03CvBTDWYYIzk3CiOQA0Kn28gWi+8d1
	 +E8uGcQAGB4LnfdDmkdOpqMgnBHpHW84OJ+haoDAVMmsALMVUKDXYyYnezTqKii/aNrvJ
	 QE0vGevJSOoppU5or25wOrmaIgOYMeOFsCP9U/xatkIOZjx3vgHSsS1ukihRVaeJHGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026574;
	bh=XQYLKT2O/Us3uWpjJRqGAiVWj3QwgxrL8d+4j72FfH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ieszNX9tXgNrXfIMFEXb4OI6gHrKfqy2pi957F95jqPL0fPYu79rpbbZBMJEze0O0
	 4Iz9DJ67spRF5aIvhJzowN0WA2pXmOKV274BUS+mHJRFYprcigTC/OWkskpzQLZRYI
	 /VvLMZuvuqnl4WBLsGyfzKyFUFj4Jhy4B6tD+wd9Ciwt7IvuDhO7RQ7KnQzy8ompve
	 pn74SxT0qvrrtR9Gzj3AIhG3JVnmfUbHIJ2VCVZjlMZBPhTps6JApt/KvYePnRjsPh
	 ZO9VICgNNGB7jMdR7JxTT+7JjE/0OeCpDMRH86k8bQiPXSmrpaPfmF2u8z/W2xCBRk
	 z5SPUWUP+4+Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFBD7814BA;
	Sat,  7 Nov 2026 04:42:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E007362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F9A060AD1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8hye9Tb9lNWX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C31E60A71
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YEjFuyZh
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C31E60A71
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:06 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7cc53938a8fso770597137.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999766; x=1794604566;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQYLKT2O/Us3uWpjJRqGAiVWj3QwgxrL8d+4j72FfH0=;
 b=YEjFuyZhxwGHxDNf6+5rcyQHPMd8xam0hMDDvLkCquLxb43rclBO1nf4N/WVrKzpRb
 GErVtHHZVAXtY/LdBSv8tH+qcLITC0ezEQ8PEjVhrcrF7xTxAsPr91qCiPHwliN1TP9k
 c+3ao42lC3n/jRbm/jhHvU1pkrIduEFKhsiBYraCFn65NIZ6BWa/FvhwNbKrk6UGaf+x
 eCCreHphzUI5/dZ2hg1fgSdHhkjBSIZMQgAWtcVX0PrehPvY03etI124p2O8eLFYZws1
 tlQC8Bcfc23olkfbPvUN4CgYz+s+PlP6FDLRdnAxmMJrXLhjXQezR1bPHOm9pqxVOXKF
 3fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999766; x=1794604566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XQYLKT2O/Us3uWpjJRqGAiVWj3QwgxrL8d+4j72FfH0=;
 b=glwIi/xQbZO1gEMHknjriMj9FtZHvlUaL6UJnG56WCPBcTrH5NARmWO2QKU0keWon6
 WxfrJ2SxsPkDli4WsebF6Hz3jiCdHL9dEtSdE6sUrZelh3ecOpg6eROh6GLuX88bx5dJ
 XYP+kI2AW6pGnRTTLP4qqmBNbgUh8NufgUlHXWyCPwGiAcZYXdZBgv6VoU1BlThYAr+u
 KcQRgxk05kYXdposuArBxsKV3DilS+DD3pyii1Ipu+stVSe1DqLnrMsD3o6BXVkqzRnV
 PEyKOrrWksU0afLLaw5DznxvKzQorYfSOa3GaTEM7ZFrkSCWyiKhzfvVWpbmXEXLjQcP
 LKsQ==
X-Gm-Message-State: APuU4Z+l1ajsxNgjrzZUk1XQDCs/W1VlDxyIrBUWK2qTU9AynKgpp/9u
 R1iaxqgEA4RgMusWQm4+34mdHTFOUGWp8wHKcsxogCHLMyFDSlq4o60s/umQ3yCF
X-Gm-Gg: AYBFou3vmR8gny5mwQoFCf+ujhkaC8htbXdE1rvNRS1YwPngGXDGMSkYYB4ieN8S/eg
 Ivx1+iwTWabTVCued8mXxiBiaKtsYT1nujPLtS+31IoOkGwzi+ZmDftP/4Ps3tktsSOGluiWeaV
 PXC+bRMOoQHSBBYR3R5AaYPII3O7Wk84dLihfrdaT/HEcuDF5KRKAcgC1oSkTOJUvqyuWvyAf6X
 PrC0zzBUHuBERGaBPBwfsgnsAwLvW4TNnd6QMXHOwiox7+m1IVFTTxGjWd0PsPm6FtMaWN5j4Hj
 NB3ZlFryB8BH1HMZU4DXV3MjzZWMlbDLwl5HxGROddyPYfC8iKE2ydmvpBzZQkbjvNZhEwG6ERH
 HBRQbwNsKwwbs7tLHORO5bEmjFrAVuSEp9H5QBP2/Y4/7gPdKNUG9K8nrrevxgsBNrK++omet69
 azFUgtBwV26K0NdYMmx1VPfE4xIUozjgegDwWe7sccHSCAF4yWDjmsmDzqB0Uw6obadq7/X57F0
 w6yyDpojhZ/zXUIWzEKbJ8BUeC0zSp16Ej0wVL4W9in+2Q8UenNQjWCj0fZbXej0ETTlt/4L4XC
 W7g7UEOjeF9+Yj59Q0VbeAaElWEo9Z86NCLCFYNEwR737ObxRMnufEdD5io+hcncf54=
X-Received: by 2002:a05:6102:6f08:b0:7d1:cf05:f2fc with SMTP id
 ada2fe7eead31-7d2a164d1d6mr1713916137.27.1793999765845; 
 Fri, 06 Nov 2026 13:16:05 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:16:04 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 6/6] board: nxp: ls1021aiot: Keep the IFC enabled in the OS
 device tree
Date: Fri,  6 Nov 2026 18:15:38 -0300
Message-ID: <716c225394c802b79bd92f9aad26a881d45c2b72.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793999703.git.mateuslima.ti@gmail.com>
References: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
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

Changes in v2:
- Rebase on main, no other changes
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

