Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC7606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SwazlrFc;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=b5B7Qfrr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C9081492;
	Wed, 11 Nov 2026 14:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6irUqD8qqm_W; Wed, 11 Nov 2026 14:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D27D18143D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406909;
	b=McYJjIJyUGglvGyD3U1BM8nMONbY8yBGscgqS9uDHfqilez/O0DyVe+6gTFoAw1IfjdA
	 Vq0jd+ZRYN75PKpfaL32dmPAFLsgTdI41svmAH1ZG7fnTPhongw4Ahw3Rxn22VVLSZxLV
	 XxTJftCn6xK5fG1MtB6aGskiEDnT47jufvGN74WC+4HLkyAuZZRY809xyw9+zhl7c0KCO
	 gogXmXMjiKkuCT3YMWxKunb2hJHg9/lP0VdsqO6aC2sy8FRt3vNM0JGSe9xE5O+ki9bK2
	 qjEuat8Q0mzZTtWiuGPexLSR4N+MFKUt/Lh3wGVkFicRuPkYsDBpDuOC8iFFa1tMnLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5Tj8fkD6wSwmAPzWrgjjGrBl8MKhbEnVpogVzD1E36Q=;
	b=GXxFs3Jz0E3W7kHX+EMkjaDPR9uarcAW+FnQAUdkhpQi55sHT3aTAqm3Oz1vlcET7mdn
	 RxvsG5WG98fxl71bDstccaqoXLLZezukjYtMMfRsNvapyNIk8a8gWXHRwlyrCeoB79dsB
	 s6S36RHjk6lvODaJI1Cq8a5re5pGry5tkdHyJQY/vEyV5JJ9zjgrLzkARHgK7/PAXK+Nt
	 GIzEKjZ6wWYVZftObgBw2+SkEwZch/ujNjjnlf+r8g5UKzH2pkove96ownO+ZMrw8HmAS
	 yJUDoeBm5LTy5QEIGn7F5+yJB3joag2PNe96SvWP5GdmLET4v24MXcrA59qHl1p6dSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=b5B7Qfrr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406909;
	bh=5Tj8fkD6wSwmAPzWrgjjGrBl8MKhbEnVpogVzD1E36Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwazlrFcbRNJVB/7lMVauBUXhh5QE7QVrUt/E+PqXUAAHRfQMOECCKLMWB4P53NOk
	 ni0wGnT43Mt2d+Eq3pqHJqGy1XBgQ05prkq6x6ClP31tzoA3TbaXPD2bZnmBQ02wQk
	 koUPMIGz9W70YoeHC1H7cuw4pqA/IV+gt4u97e2Mzs3aCwdmB2tO3GP2DgxohVULGG
	 9dGuIjT1wv0Clis2eDKoPxn4vzYu9GsobhAFTrU+lJtK8Ym2pBepyuXblMyNhSvUJx
	 qZhesxum9/Odfvj5lZ0/bmq8tyM9AJ1xQhwFQp1G/K/uuIBmHbVm75QoSXdGzvTwv7
	 7zJtsRrokESRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D27D18143D;
	Wed, 11 Nov 2026 14:21:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EE2C5335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1BD381288
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZozqyDLci3aD for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AD8181450
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=b5B7Qfrr
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AD8181450
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id BEC96231F2;
 Wed, 11 Nov 2026 15:21:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406878;
 bh=5Tj8fkD6wSwmAPzWrgjjGrBl8MKhbEnVpogVzD1E36Q=; h=From:To:Subject;
 b=b5B7Qfrrgi0WbAMuW711wzsJhzY/yJect9kZK1WkM/zNTfpdhA22ql6rtK+HB+7ii
 k05KHmzj5ef5qVp+BHxbmNYepye+rKD5pXAAK2gkVKGJcamWQuVKbl5noCMk+h2Toc
 4/Ny0dO+4+3RQcp23F3V9DGRuq4plolTmYu6f4yb2C7Fw2c+/5WWYmip7/HrzyUQjL
 U7JdILqm5SwOzotp51ntLlpKXkLw8iHvL5Hg8lChoHYK2hkugvmvj5PPlXBBW8ASWI
 xi1TydwPJowbo5l9P8nEK/ImsSkjTv3HPvtQymb4fof4oCFfRYsQO7oynrdjfM1DqG
 4h7rzYlmaKIUQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 15/15] configs: colibri_imx7: add missing defined() in EMMC
 #elif
Date: Wed, 11 Nov 2026 15:21:03 +0100
Message-ID: <20261111142104.109139-16-francesco@dolcini.it>
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

"#elif CONFIG_TARGET_COLIBRI_IMX7_EMMC" was missing defined(), unlike
every other conditional on this symbol in the file. Harmless today
since an undefined macro evaluates to 0 in a preprocessor expression,
but inconsistent and -Wundef-unsafe.

Fixes: a62c60610f51 ("colibri_imx7_emmc: add Colibri iMX7D 1GB (eMMC) module support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/colibri_imx7.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index c340dfb11894..b6a0183494e9 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -17,7 +17,7 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 #ifdef CONFIG_TARGET_COLIBRI_IMX7_NAND
 #define CFG_SYS_FSL_USDHC_NUM	1
-#elif CONFIG_TARGET_COLIBRI_IMX7_EMMC
+#elif defined(CONFIG_TARGET_COLIBRI_IMX7_EMMC)
 #define CFG_SYS_FSL_USDHC_NUM	2
 #endif
 
-- 
2.47.3

