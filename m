Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DD606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c7VSNX/V;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=J44CotoV;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=FKV3a5u0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD4D280998;
	Tue, 24 Nov 2026 20:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bwrLKo-bMey4; Tue, 24 Nov 2026 20:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6352808BD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795553946;
	b=rikYoQhdbJ/WMgG6X0zoI1Kv2vwFLlN/rNQ/IAyIW2Mcc0CXH0icRM6/lD6UA1dI8enf
	 0SZjnew1E6TL4NTVug151R0RcdLuRbnigXb7e5KdQKGe79eBrtTW3u65B4GxL785GjTrQ
	 cQTPBr8hAJOGA9NBSwIeTjQJqSzDQCKHFfa5Ei6oWu6YwgBBTJ8U0lj3oLOBCEnyK/IQF
	 /znONJ5mWKAFfaYSBhoGimisxbZ4f+mUM1LL1EHC4h4Sz8NOcIGk3PisUBdmeiFfWjyN+
	 lDUNfhMJdo4vJS0E7PR12WVIeM1B74D70EmLDPXTXISNS1+7xxc74YXQ11EHI5LQq8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795553946;
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
	bh=LN2He6nQX9zGR21WUFu/cCZF70WVrzLE6KSo+sLYLF8=;
	b=J/ikGZhwcCD1cbUuo+OYmcy37JZGBvU+i+QZlk3nzuVcrpg31+J56S+IxS144LnkAJ40
	 3TbR7qI1+iKhU/gY/0evM4ubE2gCSJBKVOCivLv1AjHMusTlVaHNDCsDVcuDneiHEk+Ut
	 AmhYj+tT9STGkT2W4Ih3/Zgi5C9XHmeQYFnf4IRA7us3vNiDZzLGeMOLKAg2pSBiNtzGk
	 8hks+QBxvz9aAfvuLWILexjgtj1bAGDd9JRR3O7jqK2lseeCbeuvuZKE87CxfVDbfUFhg
	 CA+Yh/RtNq4HZpm8losmKFv87uXBxUDQ8XJhuRpA/okgxHUi2+16AULuSZPW2uzaeDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795553946;
	bh=LN2He6nQX9zGR21WUFu/cCZF70WVrzLE6KSo+sLYLF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7VSNX/VUTT5wWfQZlS+cQ0rDq+7/us3/L+p6JlvK5v2pPCAwnWKpNAizuCXaZm4g
	 ZHiS6wZyj/miW1MVLWabZ8p0WK3+vvuUhCoAyoO0Nxyi6Heb6ACTiPCzojxEtM02kZ
	 28aMjzhXBwGcAYa1IIhEfhP2Oxb0eIG/httOcTrq4Qzz/GwOd0yEgRShXV333Rl71g
	 iisqcbO936vqE32uVLh3qumezNxTa3zIMAHKr6jOtdY8hM7OWQXZqd+HwqtnJxuF3h
	 TwOZ+y+FA+JPdH0ohkmPoHHrmycAGodnQ7CyUfIjizTL04vPr7HgpmPG2M7lnwVIjj
	 8rBcTGdWFlcOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6352808BD;
	Tue, 24 Nov 2026 20:59:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 767D426D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73D2F405BF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FeYOU2eDBRda for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0F2240352
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cbd4=jo=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=J44CotoV; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=FKV3a5u0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0F2240352
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795553939;
 bh=LN2He6nQX9zGR21WUFu/cCZF70WVrzLE6KSo+sLYLF8=;
 b=J44CotoVzyOXrNeW9qMOGkjUZFH6GXd9bw5fhqxuumMDkFjQdppEkScRn2KATOuxM3GQwZNfQ
 sX5c57fxB8hGjIbuHH8WbwsWvCl1eCI0oZJE7J1cyttCdUlfVwi9r0tujoJIjvol+JCZ+Rz5E/3
 w/RmnxE0sfew424nNDL9NJVRAMc5UoSQMPkZLPvD/c6l2H7zKFTeiMs1kChcMaBzxz8wGhxekGH
 5hGCXOiunOI2vBHuU/TJR2fs5z9vhV2dnZ8Ymq5ChN4Pa83pEcm21ucbGBaRdQ6QmXRadmlvdg3
 4JjBBHhKiqChdffRj36b5QDSFfc5mnd2hjoGTtKQnkqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795553939;
 bh=LN2He6nQX9zGR21WUFu/cCZF70WVrzLE6KSo+sLYLF8=;
 b=FKV3a5u0FZnulJwi8Emvi1D4qKQl5PsmOAZ76Ij/dm3ZBLlPmAE4y5Tt8xN9feOzpjUjKbH0C
 OZ2y76lf/UescpoedZIIVUi2bGlKc4P4aooqqARt+t29atksXfFXS2S++SFz+4+djxs9KonrNhu
 /cs98f2JShPAHOaQqqBsj4A=
CFBL-Feedback-ID: 6b05fa911eedfc30af5a5390:84f15e2132be452d2a57df188540842e
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b05fa911eedfc30af5a5390
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH v2 2/4] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
Date: Tue, 24 Nov 2026 20:58:43 +0000
Message-ID: <20261124205846.1536932-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124205846.1536932-1-jonas@kwiboo.se>
References: <20261124205846.1536932-1-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
integrated DDR3 and the RK3506B support external memory up to 1 GiB.

Current memory layout cause issues loading a ramdisk on RK3506G1 boards
due to the default load address used reach beyond end of DRAM.

U-Boot is relocated near end of memory and will typically relocate fdt
and ramdisk as close to end of the free memory as possible. Linux will
relocate a compressed kernel to make room for the decompressed kernel.
For a successful boot there typically need to be enough space in memory
for: U-Boot, compressed and decompressed kernel fdt and ramdisk.

Change the default load addresses to work on SoC variants with limited
memory, keep all default addresses in the 0-64 MiB range with the 
possibility for use of a larger ramdisk on boards with more memory.

			 old		 new
  scriptaddr		5 MiB		1.5 MiB
  pxefile_addr_r	6 MiB		1 MiB
  kernel_addr_r		32.5 MiB	4 MiB
  fdt_addr_r		30.5 MiB	2 MiB
  fdtoverlay_addr_r	31.5 MiB	3 MiB
  ramdisk_addr_r	96 MiB		32 MiB

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Drop kernel_comp variables, they are unused on ARMv7
- Reduce size of fdt/fdtoverlay regions to 1 MiB each (from 2 MiB)
- Move kernel to 4 MiB (from 8 MiB)
- Move ramdisk to 32 MiB (from 48 Mib)
- Update commit message
---
 include/configs/rk3506_common.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/configs/rk3506_common.h b/include/configs/rk3506_common.h
index 5e4ef67289f0..c58048a47e9c 100644
--- a/include/configs/rk3506_common.h
+++ b/include/configs/rk3506_common.h
@@ -17,17 +17,25 @@
 #define ROCKCHIP_DEVICE_SETTINGS
 #endif
 
+/*
+ * RK3506G1/RK3506G2 has 64/128 MiB integrated memory
+ * RK3506B support external memory up to 1 GiB
+ *
+ * Memory layout considerations:
+ * - Keep script/pxefile/fdt/fdtoverlay before kernel and ramdisk
+ *   to allow for a larger ramdisk on boards with more memory
+ * - Keep kernel load address as close to start of DRAM as possible
+ * - Keep first 1-2 MiB of DRAM reserved for OPTEE-OS or TF-A use
+ */
 #define ENV_MEM_LAYOUT_SETTINGS			\
-	"scriptaddr=0x00500000\0"		\
+	"scriptaddr=0x00180000\0"		\
 	"script_offset_f=0xffe000\0"		\
 	"script_size_f=0x2000\0"		\
-	"pxefile_addr_r=0x00600000\0"		\
-	"kernel_addr_r=0x02080000\0"		\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"fdt_addr_r=0x01e00000\0"		\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"ramdisk_addr_r=0x06000000\0"		\
-	"kernel_comp_size=0x2000000\0"
+	"pxefile_addr_r=0x00100000\0"		\
+	"kernel_addr_r=0x00400000\0"		\
+	"fdt_addr_r=0x00200000\0"		\
+	"fdtoverlay_addr_r=0x00300000\0"	\
+	"ramdisk_addr_r=0x02000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS			\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
-- 
2.56.1

