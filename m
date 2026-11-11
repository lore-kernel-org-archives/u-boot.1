Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D93606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xpgb4asl;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=zgX8hBOI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3396C81450;
	Wed, 11 Nov 2026 14:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFMtA8eLVqNp; Wed, 11 Nov 2026 14:21:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 845358145C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406885;
	b=pURqmnZXxxHL8li1yW0jT+MblQATbj5lYYIXbDxjgelfldSE/sshBZnP5KVh0tFOZgcP
	 JTnMxq2otBrCf7/IPm170qaOMuE98X83hueAg8rqYdbMFdN7gSUj8qIXaoH0OcMpt9cqP
	 DQvQaY5tnPoWIf2qkZhych4MBLqmx25aF3pdP9qjGH74AaeeKUgqdgzZGNya3kLsv5xtL
	 l2mDmSs6CzcAKW9Gmb28LmjyelKfOjH8yJRXfoYFV/q5mCxXMdpANjBpZYlo4V0+FApGv
	 cTN8n42CUawBdQSX18hffrmgraeC07qnkPTZUK6+24CNwIpd1pw0YxfCrLF0TyqnALw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uSZvs71bYrfheUKOFJYspyiRucLb7R1bbHEfTzluo1w=;
	b=Crb99dH2Uye2sXyRxO85/pmWmS5U4tyR2sGAbtZC0Y3FrQTkkeqdUSj52h0oHp6iBIOe
	 NxPP1HC4pVfZmnsOh3pWsJaRRLzFdti4wNxTDFa02sEu+riSiJ27+91Z+qjFISv4EJ9YP
	 PNieJrX/oEFpviBt+Al7NLY0Ju4TTk3+SLFWuSjcSwGrIDY01oUkvnrxOZKG3Aw3hGp1R
	 TEsX4aj2jByqVmHhkh8XlA6z6tDTsXsp5r5U5ySNlt04/AIZhOy+6tre/xLclLtfsFhu2
	 qsHLpuBWDLjFEm/UG+YIbdxYWAdVKCfW1FSfe8+4JWfhCd8DZ7I4TK9/5g9/IT0q+uQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406885;
	bh=uSZvs71bYrfheUKOFJYspyiRucLb7R1bbHEfTzluo1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xpgb4aslbm2oiGojq0q2YbqsReUH7YTgcK5+GdvbHjFIxLuV7TClELeEG8b1Ajj4+
	 gMbQla2WUv/9ACpA5ZbOlsVadZP9EyRTwdsmOMrFj3OHLyw1G0HMcH4vDd3B2AvFmq
	 aruUFwuu8aWHWrPYagpwhJcaKVIAVes+4gYnpavOtkZRKpVYjE2BkAyK7HxgF1h3bp
	 OKPXG0ExUQF3l97D99+PbTk7JgCq/U4Kfd1sVpDMnyq12mPWb+C+eqZm/win3sMcKY
	 4fFud8WdO3sdf6r/FDtzJfGZu5TeR30Kea5ubSCbGSLU8T/UQk8LnJUNRI4wdqexyR
	 SOb95CmQLqnWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 845358145C;
	Wed, 11 Nov 2026 14:21:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA30E17CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A91AE403D2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwxuwTRG2MIp for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 13E8C403B9
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=zgX8hBOI
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13E8C403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:14 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0C59321447;
 Wed, 11 Nov 2026 15:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406872;
 bh=uSZvs71bYrfheUKOFJYspyiRucLb7R1bbHEfTzluo1w=; h=From:To:Subject;
 b=zgX8hBOI6wFLzKCyOBaJH2hbiYP6c+jLErdL9/UfmwVRg+z9FjQOMNIbUNCAK8NKz
 W9k0wzwQZf3fer4vueyHzwy9tI2HGBEjtHGLLATcacKfKwBEiaGSvdXjqwtiSsMwQY
 mjXVBE4j/yAqLKhB6R/TWdtsWaj/4uDoaH2xROr0pyCYvHbZ/huBjW3jVn9L099POZ
 ZpMxO2Z8Qh3y7VeXfbSDq1IYsS4sMYug+W6eUAwSHK8b2+d/F6K6zHX2w3Zq7lACxS
 AKoyRdq4WFhrEg9Cq9VAuuvQddUG85j4hd76uXyOOcGdAzC/1BK+922CEW/iw7deK0
 tQaoMRvDxVaIQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 02/15] board: toradex: smarc-imx8mp: fix always-false
 phandle check
Date: Wed, 11 Nov 2026 15:20:50 +0100
Message-ID: <20261111142104.109139-3-francesco@dolcini.it>
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

fdt_get_phandle() returns uint32_t and 0 on failure, so
"phandle < 0" is never true. On a missing pinctrl phandle this fell
through to fdt_setprop_u32(..., "pinctrl-0", 0), corrupting the DT
instead of bailing out.

Fixes: dde53eae88d6 ("board: toradex: add Toradex SMARC iMX8MP")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/smarc-imx8mp/smarc-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/smarc-imx8mp/smarc-imx8mp.c b/board/toradex/smarc-imx8mp/smarc-imx8mp.c
index 38fb3d61f5bf..e3fab50f6424 100644
--- a/board/toradex/smarc-imx8mp/smarc-imx8mp.c
+++ b/board/toradex/smarc-imx8mp/smarc-imx8mp.c
@@ -62,7 +62,7 @@ static void ft_board_assign_uart(void *blob)
 		return;
 
 	phandle = fdt_get_phandle(blob, pinctrl_offset);
-	if (phandle < 0)
+	if (!phandle)
 		return;
 
 	fdt_setprop_u32(blob, uart_offset, "pinctrl-0", phandle);
-- 
2.47.3

