Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A3606A33B
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lqfcw4Wi;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=noR9hWEO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EED760D67;
	Wed, 11 Nov 2026 14:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzmkFRoloHTm; Wed, 11 Nov 2026 14:21:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 490D760D9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406895;
	b=B1pHNMP/4EZ6RRW5CsjsDf/kaVk0/ednFN4sPXwdl6kESlgO79acIHD+Y+3ZnZuBRuAJ
	 eBhiBYVWUB8mZoFyBwUej3UeewNdwQD6RFTbUiMhjU437rexEux2JR5Bi+rc3IcN6xhUC
	 ZuHwLX8as1Y35xd+afVE2pgcft4kM3lfn7P0SsqpICN2bkhTyaEbdlxPT/x97tciz3Esx
	 Mg9FbzpAZLh3J9t5yKamBLIaT6AorMTq86rUreb8epbEzLv77f2Vu0kM9a8pWY3oFTTNv
	 O+R1D3Noie7nKjFqWdFJ5JX950lIJ5f5CTq1aZODptiy1X5O5Zdi6tvfHZub5mcy7Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VQFqZEb6fHjfbEXEIkWsD8/ykaFbgnslK/1dsdkALjQ=;
	b=cE6K5bvWMS16E15b1tjMqYKwHtSAdbQshcMRW0yEyEsHI+LaSBOSbSXDgZ+wgP3xQoge
	 XXxcikhG/WmMK8CMiqampAj9dTRE9tPqpBD2KrBeYtsKlUJzspkNYlss4SZv4dud3MUvT
	 SNFkhF1FR4epU6aIIbNhmCapLjNVPYbAIlm4CYZwr32huRtvSy2jcB/RdfpBF0o9P87V5
	 pwH+cMc5wcGgGwcfop3SIhRXhgjMD1apvFjQbnZrxvtQpcLSm+LqomE65GhNb1pSCRuSN
	 MQGt6sfsxqwDvatLfZ1OqDtIxZrLyP19pLRbeMdvWwTsu5S7G9cHJzFmDxzcZ2Czh0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406895;
	bh=VQFqZEb6fHjfbEXEIkWsD8/ykaFbgnslK/1dsdkALjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lqfcw4WieOGZ31yW4pmuF/IPR/pPRIExWtH7spRsSh9a9df7hsLZyZEn4NqCFh+LS
	 J0Fbs2qca8MWjmaked0O1c/i/x8uInH+1z41CPTDdDKzF38GmcSen3yyCGQ+IWUebZ
	 fufCT+/aBM5KUnT6LTKPqUvvKwzECVHpb1RjuTxYDQeFu2ON8pYGcFKU2tLiIgriwo
	 23AkByn/rB5/kXUqV0Y+z097x2gGrOFt0JN39diXUf3qXytYTorbR3VHgE7TdWP9TY
	 49BRuQUFs/JA/opfAaLT1L6LU39+klDgNni9F91naHMSN/Rw93A7RhzL6H/4IconON
	 UBCWOfeskzinw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 490D760D9F;
	Wed, 11 Nov 2026 14:21:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F14917CF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 546FE8122F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVyU--GzcySr for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9098381250
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=noR9hWEO
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9098381250
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C2C0A2311A;
 Wed, 11 Nov 2026 15:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406874;
 bh=VQFqZEb6fHjfbEXEIkWsD8/ykaFbgnslK/1dsdkALjQ=; h=From:To:Subject;
 b=noR9hWEOwBUnc+fEhdnsnAZE03UXe59nO/HC6jZznwh8D5gih+gSk5Iiey0dS+RH4
 u20+zmf/JweCZKHQMT9Dk7IbTVJLmIhToJnxC//Rz7i11hw5UI5IjkkDx987yFzFab
 IqdnEmojNp/ziC2GB+Q519JChE6v0XsXP0M72s2pdeuxo8joUcrPlfaf4q8llZsOvk
 +knK7zxt72NeZlIjQ6x7pLbPCaFIB7d8uxfAcPLB7BXvVpQimQpaisqSvmzJY/GTS5
 fvUNus5nd9VIzIYaGhlQn01mMlS5kSBfhyPPIbez3HzuPMS5l5pUvxadH4TJx6pd9i
 PXRqDUUGgZ/Bw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 06/15] board: toradex: apalis-imx8: report detected SoC
 variant in board_name
Date: Wed, 11 Nov 2026 15:20:54 +0100
Message-ID: <20261111142104.109139-7-francesco@dolcini.it>
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

board_late_init() hardcoded "board_name" to "Apalis iMX8QM" even
though select_dt_from_module_version() (called right after) already
detects QP modules via is_imx8qp() and sets "soc" accordingly.
board_name now matches the detected variant.

Fixes: fe7b2b322ec4 ("apalis-imx8: implement pcb version and soc variant handling")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index ba0e05a5e39e..09223441fbb1 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -361,7 +361,7 @@ int board_late_init(void)
 {
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 /* TODO move to common */
-	env_set("board_name", "Apalis iMX8QM");
+	env_set("board_name", is_imx8qp() ? "Apalis iMX8QP" : "Apalis iMX8QM");
 	env_set("board_rev", "v1.0");
 #endif
 
-- 
2.47.3

