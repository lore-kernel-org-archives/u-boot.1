Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2E606A335
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I+o3GkW4;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=MjmKCx4r
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3A0960DB6;
	Wed, 11 Nov 2026 14:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhqSzN0gUy1O; Wed, 11 Nov 2026 14:21:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3ACBB60D98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406899;
	b=YXmtyXEyhbLc6C1EkA7+/BkQG65+VppktqqE4s4Te9GPY7R8xKG2QX4R4p/S/xnshIrf
	 nk58HvulUZmpPst6/UdIFjcWS2rL2dwuZ+4WJbSUHkLxnlwTUa9DHBiu1xvDBlmCtf4Xs
	 bnIQfVx80whvCg1ZB3j1bJ3vCFR9XF/1Rrmr0Yrry8SuTyFKrVQ1iQXQBYYOIidUPFDkA
	 sPkd1Z88XfC7/l9K8QPKIVRU1GIg2Lc9gAUsRdUvEHaGmeLAvkh5kOC0j8L7TyEEDIHXo
	 OCJEGjIm8zLVlUpiiipZFI8/FlYXZvKEOQgwWO21LpI9wgW7PModj+DOEp9Eo0KIjYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hbIcSMqfnYeoCEcSa+w4tfsE79PzO9DxqvH9HkeAm68=;
	b=rLcfcH/e3ySWiPF0GCD+lCOVEvfPz/mN3kpsn+WGU1d2tPC6a8z06zZq74sDdWR5ZDuL
	 qsvmOTaaBUYfahtLq80ag5c91HKZUOtbPsxQRoI8C9w3EVYUd6oUQCFZtnFTCZaX04G2R
	 ofI+w5g6XBtR2btew+FdKoNHCjxfE04al/5mYAD8I8KztGCwHMmEz+dlaybZKzEMiEFor
	 ati6Li+KejQ30oGgaHLZGmSMUPEsNejWN49OUmqgXR9KngyOw9Epl+TzucOznAmEaZH2K
	 vq/YXYuL4yAo7eJdqO8igqOcvXDoYMDERyJqRbtOFowa9F2CPf1NkMYfr6VvDmt0A0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=MjmKCx4r;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406899;
	bh=hbIcSMqfnYeoCEcSa+w4tfsE79PzO9DxqvH9HkeAm68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+o3GkW4z+Jch8VOhUON30l4y0h5qvC5OlhTDJEpEvpHV51mzo8frSPC3Wv/9CZtA
	 We5hNYUqEUtsckgEFZBhTnppTHZUma4RilCjMMflWYIegBU7XmK/alVO5HSPOdwZuo
	 hflPTMCktvBpjNts+/eiM0g06PqN39Zek3HYKhGLjRmFtxZH4EZOdjUAZBeRYQqy9e
	 kHR4kCxL5w+8BiGiYs5ZxhTKR7A5Iql0cIO5jXKZ/P6BO5uAdUfkc60B4i5prVhLVw
	 reupkBsX0LI07+HXgHi5ZBDIuD84YZnhvqTH2q4ZFNzVKTXB/W+iOzKnl+YtDlUn6g
	 5tdzUbS2Is57g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ACBB60D98;
	Wed, 11 Nov 2026 14:21:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AFAF335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 814246089E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6gxpIKSGVAV7 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B822260885
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=MjmKCx4r
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B822260885
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id F24F02315E;
 Wed, 11 Nov 2026 15:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406876;
 bh=hbIcSMqfnYeoCEcSa+w4tfsE79PzO9DxqvH9HkeAm68=; h=From:To:Subject;
 b=MjmKCx4rg8ILgQOWUivLPTBlPjG5Gm+zWiJxCAOuaakvAWVaj+lR/aYmLhgdTuce3
 K9Nh8XgBs6vq1cJ+GNobhNAfBFMplOHRyjuCv09T6Qffh61x0dpNBTCZG6dRDph7oP
 22R6HGXcNcvmi+Z3RnVAV+TcN+Kf0x9dN4ZsOb60soRz9JiKWxBFc4x2OymOF2AmVa
 I4JJOQWMFbo9rs+18+5IqsZH/FhSr+jSYnfu8KQc3CnBlyAl+/QoRML+QpoBhGuebN
 WjmFWhgqbLMtrQcZaPgRC01K8GTD+X15hJXRBUEawnVQgW37MYYpWKfjXy3rM1f0f5
 nFUyKu2SAvWqA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 11/15] board: toradex: colibri_imx6: remove dead
 ldo_mode_set()
Date: Wed, 11 Nov 2026 15:20:59 +0100
Message-ID: <20261111142104.109139-12-francesco@dolcini.it>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

CONFIG_LDO_BYPASS_CHECK is never defined by any Kconfig/defconfig in
the tree; it's leftover from the NXP freescale board template this
file was copied from at initial import. The guarded stub has never
been compiled in.

Fixes: a02d517b0182 ("arm: imx: initial support for colibri imx6")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/colibri_imx6/colibri_imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 69a3c5f3dfd6..9e736d178dc6 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -700,14 +700,6 @@ int misc_init_r(void)
 	return 0;
 }
 
-#ifdef CONFIG_LDO_BYPASS_CHECK
-/* TODO, use external pmic, for now always ldo_enable */
-void ldo_mode_set(int ldo_bypass)
-{
-	return;
-}
-#endif
-
 #ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 #include <linux/libfdt.h>
-- 
2.47.3

