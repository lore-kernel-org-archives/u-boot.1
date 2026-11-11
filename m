Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51A606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IQbvj/ID;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=SADIam9U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B2588145C;
	Wed, 11 Nov 2026 14:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWxZSR2fHyod; Wed, 11 Nov 2026 14:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD460813EE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406891;
	b=ETspnewrq/1C41vXOARxxZ2ocMLjHRdsrq84/BzyPv4otSesbGWJ9lxEKuBCV2Sg9UU0
	 FFr7VObL7RLrSI1aNZGWCOk3c84wFxQeXJW8uKOFLELAKwKtA91MDaQrxc4ZlBRVwFULU
	 BKmntdgR9Mtkqk4DEap+SV76ZIF2BVrDQMPjj6ov92eqdOn75CEk/zZZOK9f0Z7u/Sa8l
	 zvtWNE5UpfqLcLJfZjkifPxqBVR0eOPrRr1Vh1walut3RizNU18y36mALBTGmm4Aoh7Od
	 EcjcHc1i2RR06bE8fhl4g5Bo9FXGvDa+6SBZVwFKFhDXW6/jz1SRIBb5H5q0LdAdMmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+zhxj1lUj+2xBTjM2mXS3MfHmqGJaIAyw+iBkYfpKTk=;
	b=UJ9R9DGcEqxNMQePTo8y3AX0tOrjNfNLNqMA6/o1VhNABxJq29UpdGhky9hxvedk5SZy
	 E8mMNa+FvggGVAaPuly1tXQp75dDSVBTrcFTfkyo8wvuV3/0J/60MBQAx48BkUpXbuLaF
	 EFDQsj6Pg1HZyaEh+w05Cu0RETfEaxz7u/Y9dF7cyY5GViyS/eivyJoXDuwG9KCsRX1rl
	 C/GqjSJvLdbbBInqW9iQBhzAtFA/ngEtzR1dn9C+Lx+e4UGrEZK2FaPEBCY2k9rkfg+N+
	 oFohPTmL9PouovVWZHGIa5r3A3s3M+y4xnuqr98CPqVmcWLcQtFhxSliBeBR5hs4MMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406891;
	bh=+zhxj1lUj+2xBTjM2mXS3MfHmqGJaIAyw+iBkYfpKTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IQbvj/ID/tlispO71RyvqtgIm6lkNxr0W07xDUlsIK+cWyrs/PZ91Z7TU2CwDEewR
	 gTchxlkeZ5YcTOidAcDAdgc6dk1RtvF9tVH0mMTUtk1VedtBEKqXcaurq6eZjtUXzW
	 OlaDbQb/6Ubu5j8eunzqBWxzJrdcMGytaB3DA1VBSYg3bgcauOgtvGcVQxe1n0NFmU
	 X5OuEgwKFPeQqwrC8RuOOk5OncZw3s1NIyRd3mCuqf+x7ND0N/O791JbfOTXqXKhib
	 3vJeXdLThE3phRXzCYsTPeJ2QIWF6net+LcMy/GQbKFEkYImWSqIJ3wNPeBKlwTkot
	 yQnP8/BpUYJXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD460813EE;
	Wed, 11 Nov 2026 14:21:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 584A217CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47C9C403D2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBe8G6Kx5Wc6 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7DF8D403B9
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=SADIam9U
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DF8D403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A304023126;
 Wed, 11 Nov 2026 15:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406875;
 bh=+zhxj1lUj+2xBTjM2mXS3MfHmqGJaIAyw+iBkYfpKTk=; h=From:To:Subject;
 b=SADIam9UHvEufIsa2lsC9NBwMfRFw2wQWh/7yEoISCmyQLka3NonVC9eslcaBnx+J
 Ab9v+5J+cdRhX/Kz1HtIi+RFcH2KFwXzoQZVNkyiGNE90uXGVY/VYOwhSvMOa9CTfq
 fTvZ5obTMKb6xNkCfEuqcML4G2UxZwMr+jlDejjCAQQ6H4q2wexsXw1+0mGp+16hQ5
 6zsvnWNhH1/uKDqV4L6AAwR63hKhuyH2zVf1mvmZTr/b3s53cSJlfRWGCx1fj8o+9L
 8dRwi7gK4is8BlBqn469pfKaZFU8d6+qrXO8NG7oiYquMkNWULIWngLrmK2vd+xw5i
 SvMx2Skd6Qx+Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 08/15] board: toradex: colibri_imx7: un-nest
 board_late_init from CONFIG_USB_EHCI_MX7
Date: Wed, 11 Nov 2026 15:20:56 +0100
Message-ID: <20261111142104.109139-9-francesco@dolcini.it>
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

board_late_init() (USB recovery bootcmd and NAND/eMMC variant
selection) was nested inside "#ifdef CONFIG_USB_EHCI_MX7", which
guards the unrelated board_fix_fdt() USB quirk. CONFIG_USB_EHCI_MX7
defaults to y but is user-selectable, so disabling it silently
dropped board_late_init() entirely.

Fixes: 46307ef01e08 ("board: colibri_imx7: use SDP if USB serial downloader has been used")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/colibri_imx7/colibri_imx7.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index c63812bd966c..234d86dde609 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -342,6 +342,7 @@ int board_fix_fdt(void *rw_fdt_blob)
 
 	return 0;
 }
+#endif /* CONFIG_USB_EHCI_MX7 */
 
 #if defined(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
@@ -369,5 +370,3 @@ int board_late_init(void)
 	return 0;
 }
 #endif /* CONFIG_BOARD_LATE_INIT */
-
-#endif /* CONFIG_USB_EHCI_MX7 */
-- 
2.47.3

