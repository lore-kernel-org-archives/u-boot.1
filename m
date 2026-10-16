Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E4CCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90741409BA;
	Fri, 16 Oct 2026 06:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpcGNPjT3gkV; Fri, 16 Oct 2026 06:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C54BF40990
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133862;
	b=U6h1vkq3OaTYmiQvFEJ2X96KirnqK9HOGCiLFuxDr+4EjV5fip6Gx0wkz5HLJy91Ljp4
	 apg4BtmwaGHGYtjptyX30iylOnHuzJ7M0YT2UiACtorfLZGyfFJEloeX6pfbBv6pgP92V
	 zh2RqzpiW3TEvgIWCSgOAZKy9u49QPrpEP2hMy8IXBS4GByVUBkyxyKxe037Jf9ECQ26i
	 LmsmqRXHTwGpxMj/sGUgv7me2Qy1JqydEBViY18zPNWV6MKbUsu17oripjozVmqzfg0x2
	 5rp0h8IT/qCdJroN6WUSInJUXjWzV7Jcs4XkNQZTamhpEoV3O4NHi5n3j43qLoMgT6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VyPd5PbgnBdYVZVStRXmXaJsgyQ/orE51GwtoaRHvsY=;
	b=HTu7Df8YookwrPCk5HzSEa7MVUzgd13FqCD+4NK2OANuEDDY4SytW4s5kRfqTOLAHAVF
	 HQ+/kVp2pX90nb2+U4AKHtxwU7iC4mf5HtDfHWQcMr7sCbbHsHUtsBSH3XMonZM+be7dB
	 cX8RrIo3EQjKphnzfV46wev0FkSLvoTtE8AzsS+6ftyEGpiqTHf/ZEZ+dKmBMsmexcHDt
	 T/xocKipSNT1pOTsPRAylPnqfqg7GySLjvRDWM7S/TGtFW/85jRR5RpjF4ZQMAD59s57y
	 xe0FAFXQ6TkfXKkRa/4NephqD2587IN//qtPBcLQ5pUIvIS7zRm86oBfJh3F+12UJOw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133861;
	bh=VyPd5PbgnBdYVZVStRXmXaJsgyQ/orE51GwtoaRHvsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnDSLmZ/Q94L1RxhmhhAbv6D2rSMQVjaRSWP/B0DLuYAlbjGFeyMHrmaYES148bs4
	 d5B5IwFy+R9nMcGWeSbSRPqmHou/+NWHCYjkdGi11Jx3iN/xfK45BMH3wxKW4IJ68M
	 9MgrvCjs5l3+vmfFfgSCIKpE0m2leFYrUivEfu0eWAEgNRRUD70dMTGB5E2lYkhHWp
	 3QVw3RQAqdakU6ZiH2QFfLR16XX4TJAZLy2hAucbaSpDNdayYuwscjJCMCT9YDQ1Nl
	 IjNBjVRe1J8B9ejyQLTYXA/3JnrIkAPHP4LFJVsTV68p1KGGJ98oezArgRox6qY4AN
	 lKWtqcxt1GIQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C54BF40990;
	Fri, 16 Oct 2026 06:57:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8C1F1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEA7A400DB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ljx0soxK00zJ for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 294E340050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133860;
 b=VNkwQLKnsgmVXNA7sHQynV4fbPyCKA0bcbu6CjihM15WdLcYOcQNj0erXN+mSevKNGBY
 cqWjsdOY2aLV/YTqtakHP5x28faXiWBUfamh4EbHf/p6rIm+3ZPA6vQ20WjNapzWCMg4p
 dF5MSkjAbmttRCw9BNx3/Q5IlSAB8cU+wGjoKn/tmC+QhvcHvP2wfrwVo3z4YIQbmuLpj
 x5S65CupzBq1cnUtkeOk28SCL64vdH76o0wbUbL+tlamxmVOn5S6aOOuz4wAtIfHWsg/V
 CjshIgP7SuIPvMoGbn79lqXuMciXjmox//YcZ7A06JBqFiYjpPsqXcLr4KB685AwGqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133860;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=VyPd5PbgnBdYVZVStRXmXaJsgyQ/orE51GwtoaRHvsY=;
 b=dN3+QaNVS76X6TgMb8DUt26GbNAAC0p5kLl599kxtQfGhmSnbr0AJ4MBXENiwxhCZUDn
 O8xQdJFd57osvpdhUARulCUD30/DUXcod26r4qA/toYUT8VAG8REDbib6+VhSO3eW2SJQ
 3fGxdBFaDiiHeQYhdxVEhT86rr3MlAxc7CG3ETSCXVYBVloygH2HXKmEgpoUMrRLNBfZg
 17u66iGnoz+aL3niZFJdqV4Y0oSyMmMDBgafXduoX6AfxbBcwhVLPhDnSe+M6p/CEDfgf
 Yc9rTCuXhhLzWyZwStkbYdMmXL2RwA/T+n7i1weVMaWEEhnPFmBS7Jl3+ox8VBVoA7w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=cMjh2Msa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=cMjh2Msa
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 294E340050
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133853; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DMOa8/il55CEb6f6MqwYJ4NdLyD2Z+pKr3GLIx9yOTGS7oD+Z4RnirBXjhEmrgbjjf/vxQ+3NW46VUoKvzWqiPze6cSyNyzN9TNTfdeOtd9q8aLpatwj4gzDIRvtbChMvPk3ZdiJGB6HTJNc9fJ7pYMT5EozW8nvYnUCE+vBPDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133853;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VyPd5PbgnBdYVZVStRXmXaJsgyQ/orE51GwtoaRHvsY=; 
 b=oJAbBiXJP3nKlwHNI2xeLyYMBBLvwWHivovEDXLarJVX0D7WNtS2mqeSDQ8XlrCopB0Mh+aWpi1ooXHIRn3VbGYUscM2gnfHWyh6i8a40rO0GdIhAYvIBwlkk/hn5hr6BveiiSAsBrXtUv/s8M6QhvP60Lq3nhNDhRgaHr4c2fo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133853; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=VyPd5PbgnBdYVZVStRXmXaJsgyQ/orE51GwtoaRHvsY=;
 b=cMjh2MsaYMP4Vl1kez755WdF8M+tOGng3SD4h0esUGs7Avm30vtmYnRI1j+Hz+wS
 nDf9KANN4WFNrMY4wYlLiqbK7++N3sLrealw3LU3A3AkVlEejGHaV+jBZjPy+Pm1JY8
 YWci0nIrxx5+bf4Vz7fuIH+0aGgP1I+Yqa6rvz00=
Received: by smtp.zohomail.com with SMTPS id 1792133850545281.6746067573073;
 Thu, 15 Oct 2026 23:57:30 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 12/20] board_f: Add LoongArch path of mon_len calculation
Date: Fri, 16 Oct 2026 06:54:52 +0000
Message-ID: <20261016065500.137544-13-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

gd->mon_len is calculated in the same way as SH and RISC-V.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch since v4, to ensure U-Boot correctly reserves its own space
for relocation, even without SYS_MONITOR_BASE enabled through
MTD_NOR_FLASH.
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index ead7b6dd743e..bb29b056f3c8 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -277,7 +277,7 @@ static int setup_mon_len(void)
 	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
-#elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
+#elif defined(CONFIG_SH) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
 	gd->mon_len = (ulong)(__bss_end) - (ulong)(_start);
 #elif defined(CONFIG_SYS_MONITOR_BASE)
 	/* TODO: use (ulong)__bss_end - (ulong)__text_start; ? */
-- 
2.55.0

