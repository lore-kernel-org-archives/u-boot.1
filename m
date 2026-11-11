Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426B606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YlCPIPG1;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=EhnFwWlm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D10C60683;
	Wed, 11 Nov 2026 14:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3bhUsBJrw3h; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BB996069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406881;
	b=p8goilUuemptygSLSy5tNSOK2mVeqo1ML00TOsf8VLDJ8MBJ1VHV52bGND50bgHS2W9J
	 i2/FW2zVJRudl8xVxnk7D2y7sA/T5ABbIjJxPqVP52xPc3ntKsE5dQErKuhfEwywwNB6J
	 /rSHL4200pAG/XIHuFazfseo0V+LO2ENSMSODJAJdidAfNEEAgPNiRCb2utdVHyMVdTxV
	 k1HJaCQ7nLEBFwitGLIITj7DQTk66y4KPla563xC1UM8pVWANeU699lLdtkzPjeQYYT8t
	 DOaw8PZLU+G0mba0bh56cB6lJ7yQ2kQOd3MGKI/MreS9sphbmdGmL78TXBPXCOJQ/DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F86DMafSxIsEuLkXw2zDXK64mO59Dv3imjjdTyCtClw=;
	b=XEj4GGWZJlCLG/ESgZoxfgyxAmqx0t6Ja7HlXcFS12lLcFu//lQRMIWQyYoUsSaqJzBv
	 q+ubUqLWTg6ZKSAwfa8fevK4LT0V6FB6DFL3/5h2SCsIvzTyrIZ+NWvMsMUMx5GxAhXml
	 mziumwqtxKzUrB1ILja2mh1XhQna7/DyP0jLWy2o0ZM7EZmmqje1g7lEde7pBb+f5eoyO
	 UZt9Fia5XeRi0IWjdRAAtDSI8t9h7aLBM+VgpICPsb9yWvrQ/8WPVk6BwgwPap9PVE/wJ
	 JElbub1HzOvrxLJgRhh9Ix/6SKxt+AGu1Pyuvh/WXAeye6+HFR+phGyuHc9zdgCJPYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406881;
	bh=F86DMafSxIsEuLkXw2zDXK64mO59Dv3imjjdTyCtClw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlCPIPG1p/5eGyn9qskqb/sY83tcpE9Lps3KA7Z3ukqPnF9hElmdvRlscNjiCU42e
	 n4vCJjwbXoBYbv25jI7N4cwEVan1Q0ZfSZ8nEwLxBU5O7sxVjjuM6shnUGyAuzxyxL
	 yIT03Eg0w8KqBO6Tcwy1BS0nrP/IHyH9s4JXkcs03Vbg8RmXetmtYn6iIY+jKvwHy7
	 3VkiLgyz1WvXVF9OwU9hhHgZucsySMDLmJVxmkefdoaz4ysP4ZA+D/TsOq2ZhjN9K+
	 qBPWx36lYi7yDEPNp9gI+D46Hxy4365F5MwxMWlKLub79/oaT3whtYaD6ysVzak9iW
	 gOl8EoJquvH0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BB996069A;
	Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD6932FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A389A403C5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9K1Ew-wcUFoh for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3ABF5403C3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=EhnFwWlm
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ABF5403C3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:16 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E13A71FB3F;
 Wed, 11 Nov 2026 15:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406873;
 bh=F86DMafSxIsEuLkXw2zDXK64mO59Dv3imjjdTyCtClw=; h=From:To:Subject;
 b=EhnFwWlmK0PFQtK4Xwnxk5LcXY50RynOwtjK7Wq8+4ZEwcwWa7GKvETmyeYgQ9Fmy
 G4OcSGAvIDCU5h9M/BVA8UUDZZkeoo9di1uqy1TyAotCAilhQSt2Ud4IDw4fi5XJhI
 No9nKanxaj5U+YiatrugyyXbbOIOvCqh0QQ3SO4wGLBKs3s9st2/Cjxw1PzcyVe06t
 QL/IxmWOkzZGvhM2HkbRa0qJbLrsJCw69P4PiVvRkJePXrdhAHuPXKp8VTqALYaHa5
 s6ap28f1+EUKtCHA7LIj97nuja47KAiC5F/fY2489iO8EHNNU7Q0KgNo7cl+Mhkkkc
 N2mX32ugyVMMA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 04/15] board: toradex: apalis_imx6: fix do_fuse argv[1]
 NULL deref
Date: Wed, 11 Nov 2026 15:20:52 +0100
Message-ID: <20261111142104.109139-5-francesco@dolcini.it>
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

argv[0] is the command name itself, so argv[1] is only valid once
argc >= 2. Running "updt_fuse" with no arguments has argc == 1 but
still dereferences argv[1] in strcmp(), reading past the argv array.

Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis_imx6/do_fuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/apalis_imx6/do_fuse.c b/board/toradex/apalis_imx6/do_fuse.c
index 8721276bed83..411a6300e1cb 100644
--- a/board/toradex/apalis_imx6/do_fuse.c
+++ b/board/toradex/apalis_imx6/do_fuse.c
@@ -54,10 +54,10 @@ int do_updt_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned val;
 	int ret;
-	int confirmed = argc >= 1 && !strcmp(argv[1], "-y");
+	int confirmed = argc >= 2 && !strcmp(argv[1], "-y");
 
 	/* can be used in scripts for command availability check */
-	if (argc >= 1 && !strcmp(argv[1], "-n"))
+	if (argc >= 2 && !strcmp(argv[1], "-n"))
 		return CMD_RET_SUCCESS;
 
 	/* boot cfg */
-- 
2.47.3

