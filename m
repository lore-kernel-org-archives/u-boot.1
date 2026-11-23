Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F28606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iyoXK2Eu;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YW5UjQvH;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=L/pvTmMI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 881A24075D;
	Mon, 23 Nov 2026 15:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q29Pxbjm_OQn; Mon, 23 Nov 2026 15:07:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E12940749
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446434;
	b=YZnYoA4EplO3awhws4PQDu5DOSmhuSmxYxXUDdtRr6F5spIclujH7T1V21i4RoXvGuOq
	 nGeVLAQSlmx7qUrNu8GZ/kUDbFTpFNAkE99CIUTTSE8LSH4eKXVFBwz5zLrfwAJuMjY9h
	 lkbGRj32SYomqqf36Ni8vPsT9hdcgxYR01vZ15bwVgek1T/RwJy8aqiG2NBCikSpuhWiP
	 rZs9MC3hfTikFeYGT3OBUFn7imY7GWvUG3eSVfTy5dBnCMcu68k12cyyb7DqXxp8x9gtp
	 qOxQCu0NCbQz4BOCxmdnAdmJ559dSRJns0TfgnyDhMgwSviDCDSBoTXfWTTdavEke7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qgAAWFboI7WSGgH8O6WpPumuiYcVjIyPfhyw1FQbjqY=;
	b=jW0mko6fAC79ts72pajPPuwLg2lGgELOmYc9Z2nxh+8Cyosw+OuWmXSki1bHJ7Omkjbz
	 1euzJGVatdWG85zKL6MQHyF0/In1nj6WBKEJdrK3PQD2PlsfZ4r6p5v3sJe8pkm+VQZh+
	 CtXXQCXwLCU0KcvlEZzh9wr9A4t/M8zOyDKZ0jdu/W/ZDh8rP0WkAEUTmy2qTWTZJbUCH
	 BFin3brqK3wb3T6WyJYRDULST9IZJVv1GQhy0MLZu/c0VQNfoXJT+d0jkNz0MtpCvx7e6
	 KpiQmHuyRcXb4MEtpHuZ59VcerxgvEBwDfOQm5gzVdFbtM0v8B3W4ocTOJhP6W4OluQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446434;
	bh=qgAAWFboI7WSGgH8O6WpPumuiYcVjIyPfhyw1FQbjqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iyoXK2EujakayAHMI9uNxVrtZxKZYsm4EvlJ00rTRa+QlPMpIh3EX22u2pQ3TLVJu
	 0JzR0BDWNxCV9BYSv/Irl6yR3K7MUMfoFC9XqNq7EV4mC33FjyjkwtzMFpmUtKdIdR
	 h+6QiUSJf2u9TesYe5yrhK5DDWwq3A2vS0jc6Gz/pxSjN11OgLNcUVfWtdGnq5jQs/
	 VRJmDi/nIaJoaOqTql/u9/oePt+rt1c0MJycgC7UsxPM/CUkx/W8mqtAp75jBy7icS
	 IgMWt6SY4umx0Cmt5TE8rhm4emU9yQ8zhjHeXWXJjFx7TOpnUT78iOIq836mP7s297
	 GWO4h8YaDcaEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E12940749;
	Mon, 23 Nov 2026 15:07:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23FD5371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1634A80DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vj-UI2WMwh0P for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FD1380DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eede=jn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YW5UjQvH; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=L/pvTmMI
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FD1380DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795446428;
 bh=qgAAWFboI7WSGgH8O6WpPumuiYcVjIyPfhyw1FQbjqY=;
 b=YW5UjQvH6w0TlZlhha5pSVZuyRVX98iPyXugSSv1TiqXwGpdyBVVApZfknTB+6+JtH5L8Lfyg
 WT7hhkbMyoOqWV+kUCDh4FP36iOUMEbbVk+5dDoz2KDTe7kS93U6SgwK1490CHzCPoGwxiJSgiv
 oDuMzEUr9JBaL5zvlQ2L3FU310Lfyqp4iXBO2YH6YKKWfNKNUPWHJlEEe+BfrjRoC4j0kfp5akI
 WTowR8yj/hGAA9RHj7JeqEO/YtOUIb4byGMF3qRNzlyn0hnoYsi6/CJQv0ktq2GGwqIyyp/8M7i
 vGtSb+HOu5CUvDIFSN1+53mBPJRVYBB5+WylgBG0e6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795446428;
 bh=qgAAWFboI7WSGgH8O6WpPumuiYcVjIyPfhyw1FQbjqY=;
 b=L/pvTmMImLSCweiZSYhhEwhRrPGCWO/kqAGm2IpIjhIP6s2FcKh0+uAkLXQ4mZvcThi2MvZbi
 wRw6akB0/4kVTTEWk0dacoVQ6EMRi43XZisXnh9rDdzlVYDTZ2OCQDf3nbLWj76k1xObfrox2Ma
 MiLinEqXYTlhBPXNu3fxv8g=
CFBL-Feedback-ID: 6b04569a31d91c9369aee1a3:1e851151b56c90f5e96c6de8c50249a5
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04569a31d91c9369aee1a3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] rockchip: sdram: Allow reserving a region at start of
 DRAM on ARMv7
Date: Mon, 23 Nov 2026 15:06:53 +0000
Message-ID: <20261123150655.1397175-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123150655.1397175-1-jonas@kwiboo.se>
References: <20261123150655.1397175-1-jonas@kwiboo.se>
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

Vendor OP-TEE blob provides PSCI that is used to enable CPU cores on
RK3506. The OP-TEE blob is expected to be loaded and executed from
0x1000 and uses memory in the 0-1 MiB area of DRAM.

Allow ARMv7 SoCs to reserve a region at start of DRAM by specifying a
size using CFG_SYS_SDRAM_RESERVE. When defined, start the first DRAM
bank after the reserved region similar to how the first 2 MiB of DRAM
is typically reserved for use of TF-A on Aarch64 SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/sdram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index b58919137015..47cd13cf95c3 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -330,7 +330,7 @@ int dram_init_banksize(void)
 		gd->dram[0].size = ram_top - gd->dram[0].start;
 	}
 #else
-#ifdef CONFIG_SPL_OPTEE_IMAGE
+#if defined(CONFIG_SPL_OPTEE_IMAGE) && !defined(CFG_SYS_SDRAM_RESERVE)
 	struct tos_parameter_t *tos_parameter;
 
 	tos_parameter = (struct tos_parameter_t *)(CFG_SYS_SDRAM_BASE +
@@ -353,6 +353,9 @@ int dram_init_banksize(void)
 	}
 #else
 	gd->dram[0].start = CFG_SYS_SDRAM_BASE;
+#ifdef CFG_SYS_SDRAM_RESERVE
+	gd->dram[0].start += CFG_SYS_SDRAM_RESERVE;
+#endif
 	gd->dram[0].size = top - gd->dram[0].start;
 #endif
 #endif
-- 
2.56.1

