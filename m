Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F203606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w0gueMGm;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=l4fTYBYh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00E9740946;
	Fri, 23 Oct 2026 00:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNAZMVIBHVYX; Fri, 23 Oct 2026 00:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 124AF40937
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792715251;
	b=QiI64HyPFYLXhxcv4z6ovJCOw530VOEMoG/QsGn9B7MsZecsCNTh4ujemfP5iRUPjCGD
	 JFcksr6Z/dM8SORXBUIl0xRbQrLDz4/w1HtJxf3e3g0XJYFvxB2jE9D+KdTIhNofpgL1B
	 PiUNqdgYpwC/dLP3ImbzicbShEtVKcAvoloKOiexXOGE0tcf6am2MSgsbJdxD7KZop6Ju
	 nbIYss0cGVDB++PNoMaMhrrOevSIYR1gjo/VpX9GR37HSlZUgjmuAImckfJPbmd81yTss
	 vA9L/C082QdgRrkyud/YkUsBHHdcDLc4WCp6H8bQfaXQUpD/iE1JRT9vnbgH1+SnZ6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792715251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UWdStQiGWfFy2te5vCmaLvCOaO4xWGmOTGleI6Dr15Y=;
	b=ay7vQsD+oDpo1F6YcfRMZpPMnBajuE++YaHeB3AkB1PlpaVX3ilJwnLGOr5FmETvHszG
	 +zo/ZS2TSuv19joLZsQTdQh0UDZjFOx/Ls/iquzynJgtdYEVmntKy1rYnskm9ygSVXlqZ
	 kXW9Xb//TuvLb34+Omnbyv7RYlnyipAmrpieQQqPPCfAEOdY1q4KomverR/0dhLBt0PUa
	 HRZKBb/ppiKQC+kGMKN/gJITQkveYJP+rmhQXj4oJn74vvczcytCxWmt0lQUUZzozq10i
	 YotP6C2f0eXtqAShM0YFNAoxSzGsMT7/RVQMvrEobbFFta37DyNNqY9wAnSBhVrIULA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792715251;
	bh=UWdStQiGWfFy2te5vCmaLvCOaO4xWGmOTGleI6Dr15Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w0gueMGmWoxj7PYjrp3JZMq07HZSjbtcmfHlfdgb3zdBk8oNoguCOR/+RG6s1ufJr
	 dM+SRdlwM+yfiQG9jOEfCxjThoFYuQy2TAhEuAMapG20f10hSdqvio2NaaxrjgOoUC
	 wpn98OtVsRxi9zXuRLQGMwTZdx7ubTrCccuIbvlM0rd/kb0lt+nVKETthHrBQrAsj6
	 0d9rq2Unf62SkVowK1P0KmAE/mjzUoK8bnhenRvA82QXnYVaN7L99Eg35JF5J9aO80
	 wUNzrFq1nzoBDb23/HVSPNqAzrFq+mYB2LRK6v+BKKI/3rLc4jdido3uinRE8McvFe
	 sD8jpDGLRa4Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 124AF40937;
	Fri, 23 Oct 2026 00:27:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2DD63A4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94B65400BB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZGAZwJMqhIO for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 15BA5400AC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792715248;
 b=j6LuCUq+Gy+a3gnMyqbk86TJxWDyhMGhcInvuEQ6xBqRQeU4w7dsxao+mM1PATeTtcex
 zKAKFGAys82OcLpHx7s860O8q8ewHrQVb2PAEAZ7cRyTI0oMvC1wH+todknZ7LN5sRh4g
 FIdu4w4vCEXPtrBrZ2QhEuuKmFW4nUtsY3iM+AP69hOCXVmy0dlRrNQq3Uy7SEqk0PM2z
 U9uzGthsGasah1E1nhtXWdarevwB0DlTo91ZOuhcKzXSXQz4VJU+2x4NgYQN9sXaSIny6
 Xa+Y+XUCZigMbVpYGWB2eSN2IK/s9EQCpEcuY8Ku6qpDkYnIZKFXIcaaKF4aEmuH+Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792715248;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=UWdStQiGWfFy2te5vCmaLvCOaO4xWGmOTGleI6Dr15Y=;
 b=WYZFlzGv/k1HYeIZlqa1OKairSu0NmJA0itdcZToUm9JqzUwc3Eq3P1Td5KHFnB5krpz
 eX4u1dim1adZ3aQ86Os1Fz00/w8ZgTgerYFwBm/Pp2FtHmiC7LGO4TbaoohptOwqrzoK4
 LDcd50Plg6x7lxM4C0/yp457/Ai/qp+PJO0WH+ncSxhr06mTeydGSLNI4Gj1vkBwY9vgU
 wl8IYwQcxPvGlqgGCyG2vKZyxyD/O446DUVlMrzhPFOgmZTDE83ATdD8xK4IjTjSi769S
 dIkpZKYSkCXdr71rqSLnnjIlcg3MdZV9drPtJofiMs5HeG2HJJ35QwrMU8jIRtzPXfg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=l4fTYBYh; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=l4fTYBYh
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15BA5400AC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:27:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j9kP81YzrzMlTy;
 Fri, 23 Oct 2026 02:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792715244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UWdStQiGWfFy2te5vCmaLvCOaO4xWGmOTGleI6Dr15Y=;
 b=l4fTYBYh9/OjWzpfCGSEqY/E0kr/XuKDS082L6ULGj4ilVhC5PZUVcA2MSFykcxRYmRXh6
 cETUW+vj6IEhBv4Wwr2VHhUiql7CF/NnQGLfe+lRVnvAgVqIWi807l4PjZqbXMnYb4UF/j
 pEzQrxmust18vGfM+NU6FWCi7/PfxrJSM93sDl5NLPNwvCjABlboW1+OD0eqRepa2HOrOw
 9/pIfoAQTvOMV3Dc8ra76ZyRtX7i9bQ8BZUkmTjPwhdYkg5JTc32YdgAuIfIHxns3PRNMa
 Wd5xp32YuOCE6qs5UH0lGBZc4An72acILwvGFI6Yos6LGqlb50mEDd/l0F0BAw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: r8a779g3: Remove reserved memory node on
 Retronix R-Car V4H Sparrow Hawk board
Date: Fri, 23 Oct 2026 02:27:04 +0200
Message-ID: <20261023002722.279852-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d210d8fc8ec91483869
X-MBO-RS-META: mt67yro3dm9h476t45ii8tom5qo3k71o
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

Retronix R-Car V4H Sparrow Hawk board does start TF-A from U-Boot, that
means U-Boot should have full unrestricted access to all DRAM.

Linux kernel commit ed8444006df9 ("arm64: dts: renesas: sparrow-hawk:
Reserve first 128 MiB of DRAM"), which landed in Linux 7.1.y and which
is also part of U-Boot 2026.07 and newer upstream DTs, introduced a new
reserved-memory node to prevent Linux kernel from accessing the first
128 MiB of DRAM, which is used by TF-A. This restriction is also imposed
on U-Boot because it is part of the upstream DT, however, U-Boot should
not be restricted, because U-Boot executes before TF-A and U-Boot does
start TF-A, therefore the reserved memory that would be used by TF-A is
still entirely free to be used by U-Boot when U-Boot is executing.

Remove the reserved-memory node from U-Boot control DT for this board
to lift the reserved memory restriction.

LMB map and TFTP attempt into the reserved memory, before:
"
=> bdinfo
...
lmb_dump_all:
 memory.count = 0x2
 memory[0]      [0x40000000-0xbfffffff], 0x80000000 bytes, flags: none
 memory[1]      [0x480000000-0x7ffffffff], 0x380000000 bytes, flags: none
 reserved.count = 0x3
 reserved[0]    [0x40000000-0x47ffffff], 0x8000000 bytes, flags: no-map
 reserved[1]    [0xbaf10d30-0xbfffffff], 0x50ef2d0 bytes, flags: no-overwrite
 reserved[2]    [0x7ffffd000-0x7ffffffff], 0x3000 bytes, flags: no-notify, no-overwrite
...
=> tftp 0x40040000 192.168.1.1:test.bin
...
Loading: *
TFTP error: trying to overwrite reserved memory...
...
"

LMB map and TFTP attempt into the reserved memory, after:
"
=> bdinfo
...
lmb_dump_all:
 memory.count = 0x2
 memory[0]      [0x40000000-0xbfffffff], 0x80000000 bytes, flags: none
 memory[1]      [0x480000000-0x7ffffffff], 0x380000000 bytes, flags: none
 reserved.count = 0x2
 reserved[0]    [0xbaf10d50-0xbfffffff], 0x50ef2b0 bytes, flags: no-overwrite
 reserved[1]    [0x7ffffd000-0x7ffffffff], 0x3000 bytes, flags: no-notify, no-overwrite
...
=> tftp 0x40040000 192.168.1.1:test.bin
...
Loading: ##################################################  13.7 MiB
         16.6 MiB/s
done
Bytes transferred = 14367056 (db3950 hex)
...
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index c9f302799f1..ecdaf2c9db4 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -7,6 +7,10 @@
 
 #include "r8a779g0-u-boot.dtsi"
 
+/ {
+	/delete-node/ reserved-memory;
+};
+
 /* Page 31 / FAN */
 &gpio1 {
 	pwm-fan-hog {
-- 
2.53.0

