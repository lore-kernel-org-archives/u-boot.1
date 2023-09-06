Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FBBEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A8F86A11;
	Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CfpnrV7h";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q5XEvUdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119968698F; Wed,  6 Sep 2023 23:30:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A20E869A3
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RgwXQ455kz9sSM;
 Wed,  6 Sep 2023 23:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V79lRKPkyw3CDsdMRq8dnhILDTT23E3wyE34sLKrcX4=;
 b=CfpnrV7hv1O9UgfrjU5bT8dsl4HTLlOazY1yiMTj9UgDXo0grpmmN1McBaNknhZ2GGDXub
 wavomPt1kwAGfETeRsphhC1vZ492F1g5EziiaU8yqJiioagq+44ojG69A25YCQLdi4VgVm
 MLcLbMCXJVtO/a2n66jDATALXAu4M3eeESZp7RPL8AN9LoUY1o3Co5croWUbzKDwXS2xeH
 R2s7tYonPCBO8IOjqNtfmwBCFQBR0X7yi7z3UmXbrVfxHGa/gelb3GumizORyrDsn/IgVX
 kLfq6s3Slktv33oZeErNfQggqv9Hq9n4WG9mTnt7ONGMFskxpW3xZup4rRzmMg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V79lRKPkyw3CDsdMRq8dnhILDTT23E3wyE34sLKrcX4=;
 b=q5XEvUdFa2TVKBxtrzROfhIxTJZ1dSDEjKhvLuw8CtjKYJ13Bj0sKNCWxyVzvkz+mrHeOL
 pbCaJTW6Qo3MDRMvXW6ItWyf4NU8dqvHMbKwLbKiV4mwjNFYG6homyJ02LtRR/+fg9SGB5
 0YBlJCsIXwGbr/e2Z2M0lnc4j9NOgCL0sPg4hKM9ednA3tnQY7voPMrSSYMjZf75u+Tc+W
 pHxzyX6hGyfr6INY5WGnIFdN+7/EzFukVUsgu9nzO7oByXD74d7kf+DeZeAVDrwd2ljgzl
 s1LdJsEG8lwwqNZi0Ge2A1qPd08sOI46f1RU96Y2+aqqKSxGxUnSDw/cusaOXQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/35] cmd: bmp: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:50 +0200
Message-Id: <20230906213015.203437-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 990265ecc7bcdea2982
X-MBO-RS-META: me7tu9ctwusy8pzqkueac9etwwbc89bt
X-Rspamd-Queue-Id: 4RgwXQ455kz9sSM
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 common/bmp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/common/bmp.c b/common/bmp.c
index 57764f3653e..bab6fa7265a 100644
--- a/common/bmp.c
+++ b/common/bmp.c
@@ -81,13 +81,6 @@ struct bmp_image *gunzip_bmp(unsigned long addr, unsigned long *lenp,
 	return bmp;
 }
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-void bmp_reloc(void)
-{
-	fixup_cmdtable(cmd_bmp_sub, ARRAY_SIZE(cmd_bmp_sub));
-}
-#endif
-
 int bmp_info(ulong addr)
 {
 	struct bmp_image *bmp = (struct bmp_image *)map_sysmem(addr, 0);
-- 
2.40.1

