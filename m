Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C1606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PHI4PWTW;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dQNU62HK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FD4B60D6E;
	Wed, 11 Nov 2026 14:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVxnbZzP0JkA; Wed, 11 Nov 2026 14:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 560EC60D84
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406893;
	b=O45kAPZBdhTIs1czRdSTTrurgILZb+zFusDvfOdvUfyw6LKFwMAPWgHkgVpY+v8E6KUk
	 S4EnEM/+/hr8NeUlRtMLbnjZ11/EeDudyhaIC463jHy6sHvmQGcApITfMlqVX5HGSMzxO
	 MHeti82r/CaYTsvg3nzz8jsQcn6FqqEnj0eAymlD/hS+DyPY6UW5R3Hs8UBhNEUX3ILsg
	 hAeRJMJfBt3oTFW6QnsslHZvf4FzVi0eAS2NyCzsT8iqQQ9Yc7jiNtxroDPj3B2LbfFJv
	 eD8YRbVWMKIJRK+qNBT5et6aD3D2CM35IQDbdcvvAO128ZY/+Rj2xNYRJhoG8KEmtLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GXIY7E/9YYGV5HSFuloG/Qp2YYUYaFbPaEWaL0I/1RA=;
	b=fGmtyTl3qirMOqq006efGHdLbzIfFWTRwYGNZ1HTO8tr4V9DBRVjEsaYpZMqzDVkyV4p
	 3cEDZ+pGBvHzcUiouzbciM1cdxJRhNUMbkaLlz9Zv+e6m3htqmMcbbRoxiBMWFgIai5Hi
	 8OZP+2rcRBGGHMXkkt0Zjh26RqP4zov55o6z/YCps51nQDTiGkKWuHF3hylacPEEV1Ru8
	 HfaeJGVnoEwE913gH6Ix1Xcsg41M6iFs5EWH73Y3V3EYXMhzHqNPPdimNVdy0r2ITC4iH
	 92vt9/xszeD6PyNjtbQhqnrkBP1xp6Uk24HwIsWpjTxUm9NXbgg2q9G7cwsH+qw5ZDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dQNU62HK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406893;
	bh=GXIY7E/9YYGV5HSFuloG/Qp2YYUYaFbPaEWaL0I/1RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PHI4PWTWcGwzJn9Ja/WheEwxUfdPflP627ZhMxBd5b7kmBmUsv3br5GnyjP3670N2
	 I0JJGRg3c2um1Qivjm3Vbth/AwfZvwe3Z3MSWZPnB3a8aYlp+lwoKz2o1UeelAvgf+
	 INgmlTikD8RfzOptZVqhTzozLMoQFp34FH3ZYW7BKyZarUEH08qYanZmu7WlreUVCM
	 Ger1wtVuwxa9oKt4lDk6Xv/DRx9chY7AOL/olMdLAub9WMPvDr5nELQAFyv7KQO+jp
	 riKH0cKXPKAZii4aMf9MYS1iSBfwUNKvYpw4pSxHF9i2CxWk94euiwRRXzV3oacrbp
	 164d+rGk02KqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 560EC60D84;
	Wed, 11 Nov 2026 14:21:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6153317CE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4723E6089E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRcEjPGU3baL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DED16069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=dQNU62HK
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DED16069A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D5CC023161;
 Wed, 11 Nov 2026 15:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406877;
 bh=GXIY7E/9YYGV5HSFuloG/Qp2YYUYaFbPaEWaL0I/1RA=; h=From:To:Subject;
 b=dQNU62HKfbhb+FuYzs7i4LE9XN0ZGM0jJf5yMEdmcUTqB3EkytIDS8ljvdWFEtfie
 tOyGpd8dd8xXkGg+XVa1klslHWErSHlLcDGdgKv50eGeY01qlCLBKF1DVREk7NGhFb
 bkOq5WWhxsaaGwhRh3LzOno+y61sgO+raocfpZGZ0ZVtGI1SS4SxJeWfRunk9ms7RE
 jfPz+GsOh7D7znJVJEYVWsHJbOaHI3t/cOEwL9P7zstTd3iG1aLXKEKCxSrThvPeMS
 fbSledRwpK5FP6GBUrYgEfpLn+uioOH1OarNHFotpsq643TmLMGMcg54Py363oBpM1
 6IkFlcIJpOU6g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 13/15] board: toradex: common: fix stale #endif comments in
 tdx-common.c
Date: Wed, 11 Nov 2026 15:21:01 +0100
Message-ID: <20261111142104.109139-14-francesco@dolcini.it>
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

get_board_rev()/CONFIG_REVISION_TAG were renamed to
get_board_revision()/CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG, but two
trailing #endif comments still named the old macros.

Fixes: 9774462e34fa ("arm: Disable ATAGs support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 2a8589f5e41c..5c0b5d0ef159 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -46,7 +46,7 @@ u32 get_board_revision(void)
 		((tdx_hw_tag.ver_minor & 0xf) << 4) |
 		((tdx_hw_tag.ver_assembly & 0xf) + 0xa);
 }
-#endif /* CONFIG_TDX_CFG_BLOCK */
+#endif /* CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG */
 
 #ifdef CONFIG_SERIAL_TAG
 void get_board_serial(struct tag_serialnr *serialnr)
@@ -306,7 +306,7 @@ u32 get_board_revision(void)
 {
 	return 0;
 }
-#endif /* CONFIG_REVISION_TAG */
+#endif /* CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG */
 
 #ifdef CONFIG_SERIAL_TAG
 u32 get_board_serial(void)
-- 
2.47.3

