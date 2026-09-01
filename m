Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B89C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 23:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E2DB407EC;
	Tue,  1 Sep 2026 23:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPHIgARYqi7o; Tue,  1 Sep 2026 23:59:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788307195;
	bh=ZDw0wyjHleaWDbqCSanfrVUuR3fKvzv4W1dJgi79n1Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xmP6N/KQ2B9i9PORY3PokXJx+EOF+Yebq17pWcI19z0NEQFp9/AElXH3Rpo5L9IUp
	 ZM5Zv3rJ6gCbqQmQOvZZfMfneaObuz7hTrEYx42egjUkg2dqBWzP7qfbQN+2pTcGTN
	 eHqWKCzKECfhKR4mxUxMeG/XgTT3Ygl75/gFoRUUm0U61x60Ewc+UzCZHU1UhLzD/r
	 dqacHmvvqJUHQXbYzo07reuX9KnJ1ANNP8g8Wl4WtwLMJ+HCd5Vqn5CFoF20DP0Css
	 YI1lfFFruUcUaF34Z71f8RhLDFWA+QPJUfAKoCiWI0QFu9sdJu/fmrEiK4T71apuNB
	 brFq+TTyNyXQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B57240781;
	Tue,  1 Sep 2026 23:59:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DB72FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 664914013D
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5-TwLixxr76 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 23:59:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ZYp5/VV2; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=a1OZgkUv
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C19A40076
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:59:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hZNBv1bZzz8txx;
 Wed, 02 Sep 2026 01:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZDw0wyjHleaWDbqCSanfrVUuR3fKvzv4W1dJgi79n1Q=;
 b=ZYp5/VV2sSI83omJclVh3u6CAYUGGqAmPt8CEAnEbziF2eQrOoBNkKACiBDy/s/8IRg+MY
 u+Rx4J6LucjdFaeQ79diB+TxZdCcAlIzVwq91SAcRkWR2HkbSFgitBX9ZoH5V/u+NNDLVc
 Xeewx/9XA71xoGKlxUz0vvBCFLnuyjQbXNXJLzrbKMhpfXL8mHo+xA0csuKH910JUH1BHT
 nAqXYeUZNfl/rQi03MurTmlaW/YkGIRoTaBgj8iuGgphkNIMZBHon4HmFbRtk1W883XdLJ
 5sedB2QwDSaHu5blKcfv5NTnVWVuC/clO5eZAohP4j2+XYI1Ad+zBtJr8jCXeA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=a1OZgkUv;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZDw0wyjHleaWDbqCSanfrVUuR3fKvzv4W1dJgi79n1Q=;
 b=a1OZgkUvjCEwKnmYKjaCYEpkm0GciCHgpgUVIWBtkEzGjwXyLxQY8OwSGNFBTCgsyH+VGp
 hR2Madlg6x45FXMPcQJ8igU86IYr3XMhUwL8fgVebhlJW0fHeQ4qwUgTkICjzwvphsjRDK
 7ajgTAihlCQl1ybma2lnNmzw7sMp/NIpDOyLry5k2N3VBl5S8D4WHaFvi79amECelxF43P
 Mhq2Ht6JgjfnRHsM254PsQucUiCaWBLRXmxB44zUeDBv5clejuRcvsRqMKtFq0yUt9QX/o
 fDvrLGJ+lfrWZ3W3Ug0hZPMsPGMJ2Zej7VGmGlGqRyA1qErxlxMpA9PXJ+UKhA==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: smccc: Implement SMCCC 1.2 support
Date: Wed,  2 Sep 2026 01:58:59 +0200
Message-ID: <20260901235947.350315-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c6o4bkqfbh9shmkfugcweuyx7i77wuo6
X-MBO-RS-ID: 76448fcb62242ef7d74
X-Rspamd-Queue-Id: 4hZNBv1bZzz8txx
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Introduce command "smc64" available on ARM64 only, which uses SMCCC 1.2
to exchange up to 18 registers between caller and callee. This is useful
when interacting with e.g. Hafnium or OPTEE-OS via FFA.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/smccc.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/cmd/smccc.c b/cmd/smccc.c
index fa04bb05ca4..ed42ee19c0c 100644
--- a/cmd/smccc.c
+++ b/cmd/smccc.c
@@ -49,6 +49,45 @@ static int do_call(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+#ifdef CONFIG_ARM64
+static int do_smc64(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	struct arm_smccc_1_2_regs args, res;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	args.a0 = hextoul(argv[1], NULL);
+	args.a1 = argc > 2 ? hextoul(argv[2], NULL) : 0;
+	args.a2 = argc > 3 ? hextoul(argv[3], NULL) : 0;
+	args.a3 = argc > 4 ? hextoul(argv[4], NULL) : 0;
+	args.a4 = argc > 5 ? hextoul(argv[5], NULL) : 0;
+	args.a5 = argc > 6 ? hextoul(argv[6], NULL) : 0;
+	args.a6 = argc > 7 ? hextoul(argv[7], NULL) : 0;
+	args.a7 = argc > 8 ? hextoul(argv[8], NULL) : 0;
+	args.a8 = argc > 9 ? hextoul(argv[9], NULL) : 0;
+	args.a9 = argc > 10 ? hextoul(argv[10], NULL) : 0;
+	args.a10 = argc > 11 ? hextoul(argv[11], NULL) : 0;
+	args.a11 = argc > 12 ? hextoul(argv[12], NULL) : 0;
+	args.a12 = argc > 13 ? hextoul(argv[13], NULL) : 0;
+	args.a13 = argc > 14 ? hextoul(argv[14], NULL) : 0;
+	args.a14 = argc > 15 ? hextoul(argv[15], NULL) : 0;
+	args.a15 = argc > 16 ? hextoul(argv[16], NULL) : 0;
+	args.a16 = argc > 17 ? hextoul(argv[17], NULL) : 0;
+	args.a17 = argc > 18 ? hextoul(argv[18], NULL) : 0;
+
+	arm_smccc_1_2_smc(&args, &res);
+
+	printf("Res:  0x%lx 0x%lx 0x%lx 0x%lx : 0x%lx 0x%lx 0x%lx 0x%lx : 0x%lx 0x%lx 0x%lx 0x%lx : 0x%lx 0x%lx 0x%lx 0x%lx : 0x%lx 0x%lx\n",
+		res.a0, res.a1, res.a2, res.a3, res.a4, res.a5, res.a6, res.a7,
+		res.a8, res.a9, res.a10, res.a11, res.a12, res.a13, res.a14, res.a15,
+		res.a16, res.a17);
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_CMD_SMC
 U_BOOT_CMD(
 	smc,	9,		2,	do_call,
@@ -58,6 +97,16 @@ U_BOOT_CMD(
 	"  - arg SMC arguments, passed to X1-X6 (default to zero)\n"
 	"  - id  Secure OS ID / Session ID, passed to W7 (defaults to zero)\n"
 );
+
+#ifdef CONFIG_ARM64
+U_BOOT_CMD(
+	smc64,	19,		2,	do_smc64,
+	"Issue a Secure Monitor Call v1.2",
+	"<fid> [arg1 ... arg17]\n"
+	"  - fid Function ID\n"
+	"  - arg SMC arguments, passed to X1-X17 (default to zero)\n"
+);
+#endif
 #endif
 
 #ifdef CONFIG_CMD_HVC
-- 
2.53.0

