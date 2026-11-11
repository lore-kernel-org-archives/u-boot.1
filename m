Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4D606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FAADTHpW;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=F7wUNaqE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA22660D7B;
	Wed, 11 Nov 2026 14:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4-EBsCY-r-g; Wed, 11 Nov 2026 14:21:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3131A60D66
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406887;
	b=rD9qyvg3MCkFgB4Vhy0I9wZ4Drpq3Q3M9OUbI1jfaRqYdK3cCSbsN7xzHSbeSl9VnTPa
	 a02RVorGHRmVpfS3fHTLdBg2EF1rkOPYv3aliuqgRnaeOY3AOGawyFmjHzLgRYJA7rdOS
	 M5gkknICfqmdTObeUW6R167lZwtSDb96H/kAsMjs85wMEcj7Ly6eNtV00LZCsrYo8Uedt
	 LpPjVoGDFEf0MN33+sdtLB31aXdASVnTVqBlnBPdBZT1XkTFF+IV+bEmQ2z7koALNTHPP
	 ZQH4NOF57HJXBXInLkhFho0xOOojPrQknyGzYuPLDvGppBSEFYWVBU6FhX1KdpdB6PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g/f1plt6RjtnMaWix1/bKqGZhsINjPOIt85/3AEMtaM=;
	b=iy2TsAlsMxl7Bv+Qk8ul16hbhRAB7mkMM/R87cmNncXIK4DOcW4QsXg3TpDP8LbJG05z
	 fC5nUeDJuM+8q/GYDCALHQG0bl7Wum1YMxVeI2jevgDBIOd0oQkutpUQPZYaM5Fh3k2Rd
	 J+F9sE8d2AaJG/4eD4hD8nfzXZmShgFzJhUOeuyfoKgPUAEzp5bJccRXV28oWvQLD2sQM
	 S4bT39KQl9milcUyG5cktBz0Ey6xdFOoudFGPdXg/qdfyKYT6U8pUAT3lXq/B0lrGZBwt
	 mZFURriaqeAlvUJG/si32DstiGXHHyMemLtox4ynuZj0gap1zCTqdo9pt4XG4oExuGw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406887;
	bh=g/f1plt6RjtnMaWix1/bKqGZhsINjPOIt85/3AEMtaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FAADTHpWtfF0tJkk0+oxi7Gh3qHkywSowbhLb0YB5A4uGnaqVtdFsdHag7mGo5fIW
	 EywPT+y6uVenh1+Lq8UcNXSlIatsth5ooyWXP3VwnnDOBXdqPDVKty/tyn9n+0tUam
	 B29i/cFOnAjLXdMMPdmured22M/dJYo+HFIvwiSpA1PnV+LHS6kbSy3Ncy/RyKyD5c
	 x9MX0k5KgjcXIbMwAbqEJpEDjdSgJSvjOq/M+TPwu6AVRIME3zVbHRmxkyLBk3fdy+
	 U/8PP4OIqiDq5odg/+tiLN40btISYAYQJGtbER09DD/mdVB7Ba2DTdYc+6ScKzPVn/
	 PS+s0P3n92mBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3131A60D66;
	Wed, 11 Nov 2026 14:21:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E395D731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E10EC8127C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wo4how5etJN for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F19838122F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=F7wUNaqE
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F19838122F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:16 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 906ED1FB70;
 Wed, 11 Nov 2026 15:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406871;
 bh=g/f1plt6RjtnMaWix1/bKqGZhsINjPOIt85/3AEMtaM=; h=From:To:Subject;
 b=F7wUNaqEu8BPuIfFSYfxkYfYpNy+PCfX0XcNRxdmj0ER4Ixf+rKCFrNmgmQTp+dyX
 OZfuW9+W0dapZY29gVe3TLmfZN2iekwm0P30LrOnXA8TXEMq8XGPy7zMDhMLDK0sOy
 M9tNrBtskRtc7vv7rYGBEQloWkEPTyYB6ZZ5HCrFfexxIGH4i+r6bOE9iC/wECl4K2
 OmfxLUBnSgdNb/OraNZx8J7ST9xvjMg1nQw8o+20dB/P2e/2RrHfPokudJjEjVPZLI
 xfc+wW5rH2JbiSrMuAN6AWtW9vWDpC4NeujPMHtpcz1fePnOxgKFTJmqssxPZCwheB
 Tycg5QfNvg2Hw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 01/15] board: toradex: tdx-cfg-block: fix carrier config
 block buffer over-read
Date: Wed, 11 Nov 2026 15:20:49 +0100
Message-ID: <20261111142104.109139-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

read_tdx_cfg_block_carrier() allocates config_block with size
TDX_CFG_BLOCK_EXTRA_MAX_SIZE (64 bytes), but the tag-parsing loop
bound-checks offset against TDX_CFG_BLOCK_MAX_SIZE, which is 512 on
any board with the config block in MMC. A malformed/garbage carrier
EEPROM can walk the loop well past the 64-byte allocation.

Use TDX_CFG_BLOCK_EXTRA_MAX_SIZE, matching the actual buffer size.

Fixes: 0c6b5588ef4a ("toradex: tdx-cfg-block: add support for EEPROM")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index f01f3ea68f88..b55fde388a2d 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -613,7 +613,7 @@ int read_tdx_cfg_block_carrier(void)
 	offset = 4;
 
 	while (offset + sizeof(struct toradex_tag) +
-	       sizeof(struct toradex_hw) < TDX_CFG_BLOCK_MAX_SIZE) {
+	       sizeof(struct toradex_hw) < TDX_CFG_BLOCK_EXTRA_MAX_SIZE) {
 		tag = (struct toradex_tag *)(config_block + offset);
 		offset += 4;
 		if (tag->id == TAG_INVALID)
-- 
2.47.3

