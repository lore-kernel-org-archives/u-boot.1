Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5F606A32A
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RrakuC9J;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=RMQ4UQsK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B96A340A52;
	Fri, 27 Nov 2026 12:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QW6hAEj3S4Ek; Fri, 27 Nov 2026 12:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0239240A2E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784200;
	b=qxl+z00O5ACZrbUFXNAg984U4pDdeM3ZzW0FDgs8rlElBw5sJhe4s18DQwPsoqDeaM1x
	 PFq85GC2kBw8xm0nOJcbisuyQzvJwW8Q2Pfq+xN0hP937YBG+s/jFF/UvukswWDXcNSXB
	 9c4se6e5XnXSyg6mjT2gfPe2u7+w0pALva75H1PnftHiuNy7KqulmGJ8V3P/anczkQXj/
	 CJcHbIUAKbdzdSjgDxzGjAKhaTFCOo5ol4GJX5yIxjP4CZgm+MhsLInUPfZqbWkQt20Eq
	 j2qdI0eNH4qdgG5Rc1UWpJ1PNC5pcSpxjbjjkG/l7hwBE5xKy88ftWuuuSUShgaZfog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=moXey17TuoJB73heW0v1I+658gHkHpYgcRXD7utkB4M=;
	b=iQs3ICvw8JpBvsGVJXm9mjYvI92r0viIn22M5GqeqnBBb4uvz4PNj7N6urM5uicVIYcc
	 eG4R/9tftzMm8eX8C2Wtvbs7X4bYahs6K8XuIpheMmCfAKUQrbB/uzoGozzEd7vLnH2ML
	 5PDRXV8oKiLfVf8SA2cfxIe6hpt1sHsXCB3Mxp7I9YJ66hWT9ca58qMdtSfDci7++CXxP
	 ZWAX7hHpMFg9wus9TJ9cHrhlOB4GAXeegP2Mgchh1EQtabbFmgIdVwW3dUJ5IQGXuc7DG
	 hqIUw7OH0WDjElNQ1Ho+Uu/EMgGVYnCZgSOWFdg5V1yoTHKx3JICv52KjwIuzzFjtmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=RMQ4UQsK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784200;
	bh=moXey17TuoJB73heW0v1I+658gHkHpYgcRXD7utkB4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrakuC9JW+olwsbPgF/7j6Hhs9DxZW7SrK9CGnWwgcNivim0fzoAXz8kyYlyMkP+J
	 9iVfhpiZeh6kyV2LvmQm4kigfUBqckpVX/OdPRkP0vS2MYVFMump5TFENQOizFE1YQ
	 FusYH0ZHJFuYvgM5nekbpj1S6B31euzvDW2ONf/0KsvbEInnokH1SfYUnzCBRQxFHi
	 QZE2m0vWyUZZJlAR6ZiqyMLVFm785KOb71kgCHj5jEqx+VXVIbMs582jt2oXw8sf2p
	 04W3pj1Z/T+MSPEwiX8XhjoYsOrRLTpI/69hAzP+eFCq1rK98Cp3f/YknQ7VV07NIy
	 6xBJk8ajfWocg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0239240A2E;
	Fri, 27 Nov 2026 12:56:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21681373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12FD040A30
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOxRdnhpb4OZ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13304409F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=RMQ4UQsK
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13304409F9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=moXey17TuoJB73heW0v1I+658gHkHpYgcRXD7utkB4M=; b=RMQ4UQsKASlSXcq5T1ssb2vrTe
 KjuckV8dezr11nBwZ4o+Vhf1SH7Zp0eRrvLz79ttHClHM2mwhVj8HmhF+Jo8Oz7c9ASO4rjaLuj6F
 kPXK3FxLUomKiDncqj3lgMJDKHijql8FXmBNalcUoPXvRALu7N+70v47+TpuB9IhavhR6AKGR2eNg
 tfCZtMa8QebpHFfypkmDlZzGhIWrWtZSYj47MA521ABDepCnEStI7h0yGSE9Zr2Nq2TSGyrjl0nkT
 0U3QuxUXdDpHVy4wOxb+fdgBI4tvJzCLHD8CHQWaFY8rFaOBGKnkRf1tmgwo1hdjVTkdOwL704v6C
 ox/9geFw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV3-0006Gr-0N; Fri, 27 Nov 2026 13:56:25 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV2-0003Uw-1S; Fri, 27 Nov 2026 13:56:24 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Fri, 27 Nov 2026 13:56:22 +0100
Subject: [PATCH v2 2/6] configs: tqma6: add memtest config
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-update-tqma6-v2-2-3465ac0d32eb@ew.tq-group.com>
References: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
In-Reply-To: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

Add meminfo and memtest with default memory range for 512 MiB of RAM.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6_mba6_common.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/tqma6_mba6_common.config b/configs/tqma6_mba6_common.config
index 415589db03e..78786c53f29 100644
--- a/configs/tqma6_mba6_common.config
+++ b/configs/tqma6_mba6_common.config
@@ -5,6 +5,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_TARGET_TQMA6=y
+CONFIG_SYS_MEMTEST_START=0x28000000
+CONFIG_SYS_MEMTEST_END=0x2a000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
@@ -22,6 +24,9 @@ CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y

-- 
2.53.0

