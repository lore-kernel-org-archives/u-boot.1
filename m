Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FCTs0Ykk;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=0SI9QN0a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8FF780EF1;
	Mon, 16 Nov 2026 12:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l47SZd6vicms; Mon, 16 Nov 2026 12:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B296780EEF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794833800;
	b=OC0FhnO4WmviMV9F6UkfqIpGeqAyOXdbQgMAM5jffSFWSzPwNMElzjyaht4gREh56Vte
	 cZOf4HTAICguM5a6nUYdfFaz2twvA8iSi06n30CuJZLKBcgwlImyBxbVX04BcozclohbP
	 FZLUvrv6lkonQdDes8Tmb0jPEtEDRncpUuTGhUpxZ7O1xZ1xSQPVc4CVmhGizmmjBTBNt
	 nElVHWJF/EqvcJpNRcPLdOjQqjwHZzWLZZaSKBuJDrtDv0LeBRi50wrt2UIVs5rxFZOo+
	 L73dBfqzl4UP/1O6QW/5zO+obqogdeiq3oEAjcGp1EDk2uV/fbnwurlutMa3cj7a+wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794833800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8x+0FEfjYtOOHV2cuZYucmZoYgm5sl2cutGv9zetF0Y=;
	b=aM3C3ugHFG1XL8v+Sr/AthDvFdqBt6ezOgPXyZ6JsYgLO1z1j3KILA4P1jh+r+AtGjYI
	 YEWbhYBn6iGkiyYdqStCwl02OtPnxzNnryRzWOhYV0fQpNS+9KjGk6a/5x4u/9snzaZ+t
	 2Q40/pROTH6VPbaAGMlOybDE6Qfg/Z0qqlkqvubqrvjUbxLcXu3Qcii/LQ6vmi0eogyqv
	 5hnTca1aNsZZgf1WH1mImGg/81evzyOu1fEzFDwFM6Zo2OlHQs7Ew1p9BaXXdKqG71PAr
	 YY9kT+QBmJcddwepdoXCCaROYttFJJhYA3IO5MTVwT1ijq1DS5MGaMcL3k7Uo/q+twA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794833800;
	bh=8x+0FEfjYtOOHV2cuZYucmZoYgm5sl2cutGv9zetF0Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FCTs0Ykk6FQMfpgBmZ34ffiGKXWwW8xLLwKhSX4bZWBIj+cdq1smwuW3udUOSOSfB
	 3/uH/u6Oe7rWc1ffxDzzyg3J2ChiD5KoTkePodDqpWSZs8nid0zQ9EL1N2kYRES2oZ
	 aWGiVC6XxM1D/SfSySJKdAYGNQ156I1XPyX8PoE9TCJ9Ui+sgeV5XeHgI9C6PlsmXy
	 LhIVITOVNvgEA8Chtl5sB3QOrWKxJILf7lCzA5kB26FG20qPhRuMiwfb0XTqVN0UQK
	 8Bs9YbhPVhA7mMxYrpjB30hhHjVHMRPXMTp9SAypffNdOWoxIKjE/Mjv3F1U+EW6X6
	 qZaDDDTleg5YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B296780EEF;
	Mon, 16 Nov 2026 12:56:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 86352169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77C17406C0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:56:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXgGw4atYeuw for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 12:56:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E201A406B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=0SI9QN0a
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E201A406B9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:56:35 +0000 (UTC)
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 0B78D223E2;
 Mon, 16 Nov 2026 13:56:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794833792;
 bh=8x+0FEfjYtOOHV2cuZYucmZoYgm5sl2cutGv9zetF0Y=; h=From:To:Subject;
 b=0SI9QN0ac2ZpzB8I+ks/gBB/eNVHpSWN32jZxegkNlg9Ej4oX+1AOhf2xFBsO53cw
 s7++2YxTRtS4a26IyTk80W2RrqDwvU80E893uwHu90jLq2lqLBPI+oxgkNB5xUv8io
 pWXCPljOqSNs+pcWgj9m2eYSr1od+5AcV4x6b16iDk3B8HDfEOral3aJSC8GQaD5Ir
 85qluDD6zj4RVIXd2o4KRbZ1ylA82z1AUNpeOk9lERT3s95BOKKeDE1C70yz0+KfoZ
 Zr0GFnFVbyuJZZP9xXFt5VxpnyXrxsDSKbhkXFDlPXdGesx+p5ckU+t3EBVbk3gmSq
 aPpt9NXkOfwzw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/3] board: toradex: verdin-imx8mm: remove
 CFG_SYS_UBOOT_BASE
Date: Mon, 16 Nov 2026 13:56:18 +0100
Message-ID: <20261116125622.174214-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

CFG_SYS_UBOOT_BASE is only used by the SPL NOR/XIP boot code, which is
not enabled on Verdin iMX8M Mini, and the module has no NOR flash.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-imx8mm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index c54383b886eb..901365b13efc 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -9,9 +9,6 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-#define CFG_SYS_UBOOT_BASE	\
-	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-
 #ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
-- 
2.47.3

