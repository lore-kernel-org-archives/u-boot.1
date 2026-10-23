Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2D606A334
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fon0JeSg;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mNSONQ2V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95B480FA3;
	Fri, 23 Oct 2026 10:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zReaWErPzp_w; Fri, 23 Oct 2026 10:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC1668116A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792750223;
	b=h7UrHVd7n3YDOOxpQUb/Lf4G1F2f4cAAwSZmYPmFEKS+961mZzxkl9dj4hLS3I8bS4MR
	 sUNclZp71HMc0JLShUZq3aU52pn8QF6nC9S+WDtr6lSHZGrUvJF7xRew89g4T3KguILb3
	 WgOWWvo7bHAzZI5HFwtu7+aLUR9RmOt09qCGLkdijdofb6aUloatvxZ+VC08sSuCdZYHx
	 xOaBt+MpfZDdjfDYDR7AK7hT05F8qjguHchbYK1roM4uxjPVH8oplcJFQ7/BbLHrNAERc
	 QIhjR2rnwO2WOcHJ4xxg48wYt7WFjfHJAWVIUk9GsPkABiHAvz2AYLitSjXJbyzl9uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792750223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ajNCrWlTg2SopxFuepJmct/SbksQ+3CwAGDGhSWEC+w=;
	b=RMhs0utgKmyz7xIrDXNScudMKhiqs/mlh9cxsoW5/RAh7Drgrigm1uIScZ5+1QlqJANL
	 K9AHCdl5T6gpO9z6hbwP8Hac1dndvKl8NHcFEdBVQTOEijMsJRCQpjdtjzPHGxYaQFF3N
	 gwMiOfJvZObYQ6UZVKtUYTtD9s6Mgo+GvS4DxvdDktz/P4LWtN6bpjMB2KFYXVMcOsYfI
	 zGrkfJ3NWitR2ApF563xo2QJX4ybkUO3VY5fLWD3gUS9eMy5ABAVw/64JOakMJB5cu9ie
	 BsVCfBdc6Lv8DhTMovFadEKB6zjYGppNLfmm5dWSKdT6s6U5dP+bBuLZWwaIPjuEzFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792750223;
	bh=ajNCrWlTg2SopxFuepJmct/SbksQ+3CwAGDGhSWEC+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fon0JeSgId93KKyC8k+DJk+nPc3ISX0Xkoypl1IkAoIw6so2jH7pgDBfdPyR09PY7
	 MJF8FYx1ex4gLpnpIsjD4EyEVVJ+uulW5/6Obe2rJ+ElbaJb6fXXC5drxFYaHHNoAN
	 F/3EpqQ/OAn6EkOcTmwFz164XNiqbBKK9OBfOjUnNZHIPHlVTTwQKdunYC5Ljw04uS
	 rCHEiLAqmUgb6AXkMiPjNCHrL78m9AtisMjvhwMQVD/o2q57e7lBHblv+u+BVBhRkO
	 CBLD8ATKXxe+U8yLoFnXn+chquihh4ojnp1cbp2JvkF2FqFesoL+uG+907aKVlDWJz
	 zvsr7/kDlwKkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC1668116A;
	Fri, 23 Oct 2026 10:10:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21D733C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0C2C40911
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfThf7QfOKa1 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D04B7406AC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792750217;
 b=kOLCkJdCPqPivirErW8TgzOFX+mnFPB1agrlKF0qQVX5gXWrqWzIlk1AM8A+2ZLOF3GQ
 cxjKwC6PhMZcqFsc3LssxGNL63UT7AAQsltMfKhcC38Wv6SlZq/x2kYVu+No/kbdtDWWY
 eOWAIrbAIAK+f90S5ra5mokPAv+lPe7La6AcEK9XQ55mPKbRVwx88+P6SsuL8sz+hOoa5
 EjmfQAm0IGDShNxeU5qD9F/hZGwxJltbWhzfYnGahQ42RLnT56UDcnoHQmkoYnODxy2e5
 GARtWirb9HOUwjD7IvXjsBIOb/7+KdKaCIH6INqgPGGUO1GQfnZFkFWmdjm+TS+Rs+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792750217;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=ajNCrWlTg2SopxFuepJmct/SbksQ+3CwAGDGhSWEC+w=;
 b=ENsH23eD7pp35H9wrVnvpNoh6Rpq+6hSLnD/G73XFqv0ZFj0TSO0oG2eRL3ITIXeebic
 MRk4ciN+04w6JqoidrhIzyq+UShu+mUtnTxGpbdddhUGMOPKu6BacKZieRzjTIUeTfKvA
 djghCfFJio7Wwmo7qY+mrQccCn7kUZa72QcZ1wy1DFYZ02ZuSc19CpRIV6agYrmj+jltC
 Y1KH2Uc2ew6PKyW02UN8pEOM3aqP86PScQQAOITgIr6KYBPiSC1PsA0NBs7v/6Q+PB320
 ElmhZ3quYIlqAt3rvGJXi/L3JjoedN5jmS7wnm3JJoZXbc7xJWRypeQ8aBm7aIiilwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=mNSONQ2V; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=mNSONQ2V
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D04B7406AC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9E4DFC6344F;
 Fri, 23 Oct 2026 10:11:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB42D60398;
 Fri, 23 Oct 2026 10:10:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E7131032900E; 
 Fri, 23 Oct 2026 12:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792750213; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ajNCrWlTg2SopxFuepJmct/SbksQ+3CwAGDGhSWEC+w=;
 b=mNSONQ2VskWD1JEKItPzquD8tSylgSBa8OLcY7Akc5kTc9xCsZGBfLK4lgFDp1vhPKymIs
 cCb2zKyBcjaM6SbHgPohSDrlzQV6XCVqbH+jXcI1i+/0d+bXo5IeZOutdBpEpTsZPlkyia
 KioNvImmxXPu8gLoTPio3lL7s7cg8mv2TzBw3KIEOs6vb9Rmxjz6SmHmyhqWDBQBIILKoh
 3Ah3xy9KCTDau4F8U+7Rg9h/ElrTx1aaZpGBOKU/ZcTnn/PbRYeMXhJQi99JLPGy/9c5MG
 LyC4hFGPLvNrb0rNtnnuOAAxPBQsoIKyjrJ3pJBsLx5P+1bUG7ei5Xk5EEjnig==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 23 Oct 2026 12:10:09 +0200
Subject: [PATCH 2/2] omap4-var-som: forward MAC address to Linux
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mac-eeprom-v1-2-f7a5817d455b@bootlin.com>
References: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
In-Reply-To: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SOM's MAC address is extracted from the EEPROM during
initialization. Linux can expose an ethernet node allowing us to forward
it through the device-tree.

Enable CONFIG_OF_BOARD_SETUP to patch the Linux device-tree with the MAC
address previously extracted from the EEPROM.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 board/variscite/omap4_var_som/omap4_var_som.c | 7 +++++++
 configs/omap4_var_som_defconfig               | 1 +
 2 files changed, 8 insertions(+)

diff --git a/board/variscite/omap4_var_som/omap4_var_som.c b/board/variscite/omap4_var_som/omap4_var_som.c
index 8348cad4f9b..309e3ca0f7a 100644
--- a/board/variscite/omap4_var_som/omap4_var_som.c
+++ b/board/variscite/omap4_var_som/omap4_var_som.c
@@ -9,6 +9,7 @@
 #include <asm-generic/gpio.h>
 #include <dm/uclass.h>
 #include <env.h>
+#include <fdt_support.h>
 #include <i2c_eeprom.h>
 #include <init.h>
 #include <linux/delay.h>
@@ -207,3 +208,9 @@ int board_mmc_init(struct bd_info *bis)
 	if (IS_ENABLED(CONFIG_MMC))
 		return omap_mmc_init(0, 0, 0, -1, -1);
 }
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_ethernet(blob);
+	return 0;
+}
diff --git a/configs/omap4_var_som_defconfig b/configs/omap4_var_som_defconfig
index 1f3557dc1c4..d23cf569ff6 100644
--- a/configs/omap4_var_som_defconfig
+++ b/configs/omap4_var_som_defconfig
@@ -18,6 +18,7 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 # CONFIG_BOOTMETH_EFI_BOOTMGR is not set
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="omap4-var-stk-om44"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y

-- 
2.56.0

