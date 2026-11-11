Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED00606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KjimKxVA;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=Yqo2/lQr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05C7960DA9;
	Wed, 11 Nov 2026 14:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_zYVlLuqztB; Wed, 11 Nov 2026 14:21:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0677660D78
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406901;
	b=VAeQIqgm6mFbAbGwY/8eg8mR+itUqGwG+N9S1UTqiAz3t7xnYz5Z9Mcpivqx198TGn1C
	 PF4dQGv6P0/+T2nZFXUiX/SEPkvUuWsMJyhLN1QtwAZnQ6+NCowsXnHYpNW3HUkDh9j77
	 Umm87PxxDsCenN2JPxk3C63m4qUjstSj13EXEi+VI2R8PmB3LexgZmS0bCR9sV79RNB4R
	 nS2eEjgYlhLiJGklDMwc3wCjSIiO9uv1g8gF2dkES7gbXdwZ7jJUosnHTB0r+vmtyCD2V
	 bDRx5vOp0KXgO3SXm3HTHPdy0EqD8G6tZrJ7UuMByk1/j/fOT6hnjhec/knhWqL5IsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KKTDrEpO1igMp7FTv9ykBK5wpTQ5YfOmmPMIBlrPOvk=;
	b=KxbA1jivOnJlVG5zN3liH0Oha/53hnx/obPAORHur9p4rdIyb3Vlu14X4zn+3gKXgCOI
	 2E5SqvgCZw+fbfWezzbOPHQOhR6vjgYShM4o20XF74K/paCHMOm3j4LsHUYCbovTdjCct
	 mc72am3cTzglx0s/ebr4d5+hrGA5yZdZswsdL5B7SsOuMB2LSlWaW+U1I3ah38FdNM10C
	 iXiF/2AhU6UZTeYM99mIvdem3b8fgUJwwGk2pWdJmclkKSIafOXpb6AMcN0UaGvhfXWwC
	 8oM6fBVr3uoQ00BQYblDQ0nSYu7FHZYzF+W/f3PQI+GXgdpq4P9ogbEj2rqjcughIoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406901;
	bh=KKTDrEpO1igMp7FTv9ykBK5wpTQ5YfOmmPMIBlrPOvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjimKxVAkbdjDIUYZxVdushKoFg8hMkfwTlBg2ZTIdJzNbRbS+56kJLsrT1PhdD/n
	 pz+WZaPoFffHmyf2hfAhNDnpR9edKguKQ40TB04LW7v8lAdIoNZVla7WyUM/qeDIBz
	 UXsY4lvk9lmUEkXok55ng+pTUIbsIpxTCb+whoSJSYT/0iUVT84aNOCkJYKIZlki8r
	 jWx1GyvQchLm0Pzw5l7a0ZeDTpB4ZxtKd09s6hVRhdFFqCgO05Dw5vQC/AlupCv4/x
	 PIrRNJ1ITj01aOQOmFjOYAmbXh1wWEp1zqZCB9GnarLLQlehWiujOL9qkzQw2m+IEF
	 GB7wq/cxqJY2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0677660D78;
	Wed, 11 Nov 2026 14:21:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3C30731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 939D1403A8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXGUVynxUuq5 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C6316403CD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=Yqo2/lQr
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6316403CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4FDC2231F0;
 Wed, 11 Nov 2026 15:21:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406877;
 bh=KKTDrEpO1igMp7FTv9ykBK5wpTQ5YfOmmPMIBlrPOvk=; h=From:To:Subject;
 b=Yqo2/lQr6ngmZsLkRb0g/adnEGt3JAL+m4udiPxzqyGSpHskKgFS3BVqmVl6erBOT
 gPSfagszXnOO6+uhIVdKay76+wvbmRIvJmPSMYqE7x7W3rEpcFxnEuGa7yaTPwv7CX
 qkAtcmeAEqnpe6g3AO3Cm93me71O2ZFD4m7vfdcVvZMcXA4UTu5pdU+AUlImw+f5uy
 Q3NUXPw6Y9mT9ZZDI9El1Yt5kv0TWHclza1B4OGcJzSnbM0n8G7/DihJQ3ReaIgun1
 qSaFj0Bhadgz+ggfufzK3LoUqlzUIkSeuluzXvwyHBdXnYOo7ewgkadzS9U+NGOLgE
 SBe+nrRXvADJA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 14/15] board: toradex: apalis_imx6: fix stale #endif
 comment in board_late_init()
Date: Wed, 11 Nov 2026 15:21:02 +0100
Message-ID: <20261111142104.109139-15-francesco@dolcini.it>
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

The inner #endif at line 743 closes the
"#if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)" block, not
CONFIG_BOARD_LATE_INIT (which is closed further down, already
correctly labeled). Introduced when two adjacent #endif's were
collapsed into one while dropping V1.0 HW support.

Fixes: 405c97fd1dc8 ("configs: tdx: apalis_imx6: drop hw v1.0 support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis_imx6/apalis_imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index e0cc4498d8a9..faca55ef6e30 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -740,7 +740,7 @@ int board_late_init(void)
 	rev = get_board_revision();
 	snprintf(env_str, ARRAY_SIZE(env_str), "%.4x", rev);
 	env_set("board_rev", env_str);
-#endif /* CONFIG_BOARD_LATE_INIT */
+#endif /* CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG */
 
 	if (IS_ENABLED(CONFIG_USB) && is_boot_from_usb()) {
 		env_set("bootdelay", "0");
-- 
2.47.3

