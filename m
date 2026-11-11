Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BC606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BTsLgKUc;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=one2SfYG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABDD260DCB;
	Wed, 11 Nov 2026 14:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAXwPrqEP3vz; Wed, 11 Nov 2026 14:21:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9592560DC5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406907;
	b=TDR5NCXAb4AJ9e0/Hv88PjtlAL77sIabkmqqHmz31j3R0CnobZxlfboZS8dXO0xPw339
	 heTt992Wklk5m6F/gJbQoVhL1AZBuduDfA6HudhMPPYg3WiBaipWz/djYzaCjv0RMh3iA
	 Bvp1ye9bCkOSRIubf1eUpgW27f9uc5bhzIB82pPAaFnHMeUdEjRi++75h+WCfWOS3qyyu
	 w66VJQ3/BSXvv7imWOOWPe5xRtaNr+zjEm9xLO05iJFfBqNkqtGir6MSGQ6r5F8wfW8/3
	 myNi819KrIpKdZtVsP+NdkhKo4C9ylqE9bMTPWfmaMPVzF+H4dxPVJxfmUbcMBXjRqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HWzBnmwQ9MoHbUSEKRIeT1p80D7BYxBfEdbvHVsngt8=;
	b=K0cV2PTleZxkEn+klOh5UyVfbxJqxO/pdxWk7sFNZYwG/ZVYW1HL+JJUzdqh/TWIJXJT
	 t0HgVPEIMTES8tbsXi81kI8EuwR9fZsph0tBDCWiLY6fnUnZ3uMufVrEo1bnd9CgaDyu9
	 tKwIW8RI4c24puLILLT5stkNJ4zAPkl9kMTGlxIi9NVhvfZ8LQL2LvlzmaJlw4mTKkbqZ
	 ApcBLw9nyAzzOI1fzVZGED/frUS1Dm4Y25AEPYi5eyDtHTwOWEOar0+gVdshLTZecsmj5
	 s5dQt7BLGRPiLkzgIq9O3N5wutDbIqSvKNmvQYDiE/G4T+tLBT0J6mM9AMNZSR9p2Ag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406906;
	bh=HWzBnmwQ9MoHbUSEKRIeT1p80D7BYxBfEdbvHVsngt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTsLgKUcRaqCnXc9HmsxooPHajQ1eBtr6dDE/F+dpLVA16AIhPa8wRCYCl4miGvqy
	 r9SIYX5F9a5hHErSDZbd+snLpg5pS9Vy+cPPJMUMDpRi7yIfhv0WXuPybkM3giAPtc
	 hBVXza/roirAGJs8voxq3nWVDdLl+DerUdRez6Za8BNfZvqCE/9ZdU03r3QmqmWcX3
	 gpRTgUeIAJ3lQcfgKYG2ZTHySqIjssCfdgTvVdNQSGMUbuL7uGC59/ND8J9s6/hFf8
	 mqCli/OUnunv8FiVlijHD2fvSEka0/RBLBaHDurqrQMnbKsqxDtPMz32iweCHit82Y
	 H2TKufMFZaUFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9592560DC5;
	Wed, 11 Nov 2026 14:21:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2649017CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17A1340891
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BOXvcDHCjow for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 906E440801
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=one2SfYG
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 906E440801
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 19D8223160;
 Wed, 11 Nov 2026 15:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406875;
 bh=HWzBnmwQ9MoHbUSEKRIeT1p80D7BYxBfEdbvHVsngt8=; h=From:To:Subject;
 b=one2SfYGmVGn1yJLhgh/Lf9bBPjxiOReFmm4KB0KKeYktFQIq0ktW5VCN+fifo5qx
 9lisHNTlVjbg4PY0HYvniVi3aP8iWWoimLGAfZVWn64E4Uf/uJQE0BbkP+2f0Pr6Oy
 GoTOB+msrs49NiIdi0qnY1eCDk81PYxvFFPLLsx0vDJwZah/IQaUSU3YF4JcV9VNcO
 uWEbUbUdt1gqr4JGiqE79qSI8ZvPcpZMjsvUm+pyraobmTQvPRrYtF3m0uzDkc7YW8
 2978P6nFCTHEjD/k/WUYNM4yCk98PenyP+W6eLihcSeQtx7lIDVYIsoJOZ6SPP3UQV
 c/FMbnvnxEKSw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 09/15] configs: verdin-imx8mm: remove empty #if/#endif block
Date: Wed, 11 Nov 2026 15:20:57 +0100
Message-ID: <20261111142104.109139-10-francesco@dolcini.it>
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

The CONFIG_ENV_IS_IN_MMC block has no content, only a comment; it has
never contained any code since the file was introduced.

Fixes: 7d080773347c ("Convert CONFIG_SYS_MMC_ENV_DEV et al to Kconfig")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-imx8mm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index c54383b886eb..c79df4ab46e6 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -51,10 +51,6 @@
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000
 #define CFG_SYS_INIT_RAM_SIZE        SZ_2M
 
-#if defined(CONFIG_ENV_IS_IN_MMC)
-/* Environment in eMMC, before config block at the end of 1st "boot sector" */
-#endif
-
 #define CFG_SYS_SDRAM_BASE           0x40000000
 
 /* SDRAM configuration */
-- 
2.47.3

