Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46690C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4858804A;
	Tue, 27 Feb 2024 17:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q0ftauzD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CErrPO6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C8288005; Tue, 27 Feb 2024 17:10:18 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1642D88015
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBJ6dPsz9ss0;
 Tue, 27 Feb 2024 17:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6VmvoPpCoD/avmJ/5F9kNWSE52llV6zrR3CTqG0TNQ=;
 b=q0ftauzD+5oErJOs3OeksABqB0ZEiLuL2pkNreRKgbGpRy8BpuhAH/f8ZMIsnEQPVMq8Db
 3J0m/3OF5pgIbMNVIEj4q98HbkCNumN1oyyZb35av+bwyN9uTNoAECnGhhhzWifLuEnCRN
 zN/2BAdb12ZVVEG0u3FUddd9MH9dZ9MIKEGs8kZwX8roNgIkrpJyKM8La0Pr4J5QVRMzKz
 I74LWSZUzjAgBQ6OVEaWHnG55ip9BtkON0Df3tWnuduUrc7k5aZUoF+702feZjiC1TkgOo
 n/zfAEAD3Rop0bxZkeGeitoOAxX0e68uP/1xGqclPb5z0jttamkdIpwX9Bzv4A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6VmvoPpCoD/avmJ/5F9kNWSE52llV6zrR3CTqG0TNQ=;
 b=CErrPO6etM2Ho7mNNlp8V5uq4CePITe+YwGlQsxMEtB795jkZLhv41YNQJTIlGLZYzfbEU
 4GoezQt7hf2ddx0fLBEBw0n7vT8KJd2xIaZVNSzxGrCnxpNqqUXOyFEw7Eu6oduPra26SZ
 XgDHJsZNpSw/FTRtH5y5vwGaLAo8F0e/D9sFu6aeazcMvLdsngk5uW37DlIL2HXOXug2a2
 qHZmOD+dFJ6mMADpLr5Fn1pKXdKQobtgkimt955djkCK3nTUtqY0hs6ATmkXZxuw4SZ3zq
 itkjsB4Bw55qL1yADOMoqz/jGBsrfv5aEqsrM4yI6i5n8VqB8RPUYL0w9sVkLw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/19] ARM: renesas: Simplify weak symbols
Date: Tue, 27 Feb 2024 17:05:50 +0100
Message-ID: <20240227160912.412181-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b4kjxh9efoihqydotfrqajtz815hrufx
X-MBO-RS-ID: 8c898c9bf2660ec114c
X-Rspamd-Queue-Id: 4TkjBJ6dPsz9ss0
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

Simplify the weak symbols use in cpu_info.c by using the __weak macro.
The result is identical, but the syntax is much simpler. Furthermore,
drop three more rmobile* symbols which are now unused.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 66ac6b3fcfb..2f9a4374a96 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -36,26 +36,20 @@ __weak const u8 *rzg_get_cpu_name(void)
 	return 0;
 }
 
-static u32 __rmobile_get_cpu_type(void)
+__weak u32 renesas_get_cpu_type(void)
 {
 	return 0x0;
 }
-u32 renesas_get_cpu_type(void)
-		__attribute__((weak, alias("__rmobile_get_cpu_type")));
 
-static u32 __rmobile_get_cpu_rev_integer(void)
+__weak u32 renesas_get_cpu_rev_integer(void)
 {
 	return 0;
 }
-u32 renesas_get_cpu_rev_integer(void)
-		__attribute__((weak, alias("__rmobile_get_cpu_rev_integer")));
 
-static u32 __rmobile_get_cpu_rev_fraction(void)
+__weak u32 renesas_get_cpu_rev_fraction(void)
 {
 	return 0;
 }
-u32 renesas_get_cpu_rev_fraction(void)
-		__attribute__((weak, alias("__rmobile_get_cpu_rev_fraction")));
 
 /* CPU information table */
 static const struct {
-- 
2.43.0

