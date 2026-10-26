Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pBfF/6sr;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tSzvDLA8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 053F180CF0;
	Mon, 26 Oct 2026 21:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DH4DcdVka0HK; Mon, 26 Oct 2026 21:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4500780A98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050149;
	b=IM9M/Fe0xu16tehhVuHky9cuX6TTQeOHjq3SFV5cVzO2sFwynJUKXmdpGGw3G9hsGq1Q
	 9B0YrHqIa9opj1O3gs5XdXkmkGqxfgz/e+QafND63ccd2OAKKa+87YCfAgg07ZohzG4ko
	 QIF3XQXJtMhhWHYzWVQSVYdvwPo8hQnXSb1l5fQ9uaKKHj+nLzh60usVnHwGmp8ssqTdg
	 On13Lb7/W6VdKkEBJsNEtIP2n5NIKALatUn7fNQNWALAUS61jI2IeDg94bAeDVhKST04w
	 KjgMSNqFuZbBZVpyyI8/zPjH0tezie01NJOWuvWigvTgMVyA+TXPZQLet/W1FJZjEcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=slJNoAjkg56/Pdv9ozd7eKnpq+MNeJEShAFMGpAnhGQ=;
	b=XLaCzqByXLsDM+CioVkaOJwTbTL6gi6O9/VzRoeq/uJoKszllL36k9/G3d9Ccr4WqiOW
	 /8P9NnmNMg1mlV/4pyccEt5DRyqud2T/U0d1yvmD55y2s1nPXoY/x3z4R0Buna7vp+WmO
	 I12W5VDomC89R8IxdL9PLs/5fu/l4uztbnpwKIkUyeceH3s2FZAN3YGO5X6ECuYCHlaBj
	 C8b4pbfzbllz1ljsFpcWBIbR8Mf5BpCaYdv5fcQxbXG7KpAcuCPpDohM0uYZfRKPtxFPW
	 KE6B//rksI1B5zICGPFY5vyYejxrOSYVCY+KjVEyC/RHaM+IuJSedKdkhVAWSs50Q0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050149;
	bh=slJNoAjkg56/Pdv9ozd7eKnpq+MNeJEShAFMGpAnhGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBfF/6srN8F1P+PX2yqfcFt0WW+fkrR4bfGHb5/dQmGm34nzH27sdK4Mq2Hvm5fjh
	 LBaYUoX91jgxahxPS1uGdsXYEdnp+q7tet0+wH979sK2SUFL2fTHbgVOwG3Q6SOPrq
	 yrXIcCmuWoMwiKhrU1H/vYcPXpeyOUJGkO9P5kBHYFbT9NOdeGH55lR58yHAnmqJLz
	 pku/84n1AP6urN9MIPgMP6v16dt+snX7UH39WeTWNwunpUZ8X5XOPd1VB70byjQg/t
	 avXbLyjKT3R17N803j5wivTj4qz5JmjKkqFUlL2zXsvrgxYhSPgWQpfPwePD58iYDm
	 93zfXBzT2PyUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4500780A98;
	Mon, 26 Oct 2026 21:29:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB825380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD2B940556
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqSRRxqiXVwr for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 055A34053E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050144;
 b=Slms5FGTa5SnajYXwGbsfo3O2yz+4JhfkAWjVK4ONaUPsnOtWKlaWrmZPkdcjuaZQOBw
 Z91tmSVJH5wg2VClA9wObrg+pmU0ozBi098GdeZGRSO5luhOZgIuQvS1LnMLm2nw8CDn8
 yCqbXnk9b7hS3wyg8BGcuaK9QW6psRE/1quvhk5AAyjtgeHVrZnvaeEI4x+MRxv6kRZ4y
 sPEggoNKyW7YKUabpopIPwnEGLULR4nr94AHaQ0Lnkwpl0z7iUlZj3kBgv6ssBjgW0pgr
 iaNGsg2I1a1sWHOOd2zQBBeRyGm4EEnHLeDVDrtCZ6Fx/JTwUfRK7BsMmZvjwsB8e5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050144;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=slJNoAjkg56/Pdv9ozd7eKnpq+MNeJEShAFMGpAnhGQ=;
 b=Dxib70OL8fl0vEH1Y6UnpLORW6Jkq3JAu/9WofZfwQukpxgPjwAsSORf7yjbHAQqN1Ks
 3JqxEo96mBeyq/Ak+fMuNOTkdO+yVoVggGJnhxlKnqcjA7PYrrarWxlfl9CUExv0MH3Nc
 VCmT75SMV6C2O5SEFlwi32WhHrWsiNwheJqvdZJDr3slRUfyKBVHAHe4Cw3xtvxw2VUVN
 mBrnpcoxdMbKk+ldcLP+i3Yn9cGrFqCYFirK3RRD4MErAk7KT+8ew3PczgX9TmfNHrkqK
 vhpM31Po0VgtEP5gcZADjSlVEJt0iFgZJjhSM+vIZK8wA5pBSQTzBsK+XlFDYqJEsHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=tSzvDLA8; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=tSzvDLA8
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 055A34053E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:29:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jD6FR6P57z8t9v;
 Mon, 26 Oct 2026 22:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slJNoAjkg56/Pdv9ozd7eKnpq+MNeJEShAFMGpAnhGQ=;
 b=tSzvDLA8xFjnJ2JuYNsbWtO9DSpqg/RunRenaTT+HJEZ/OKRr6yF63Xx+KyddfXkbRR78F
 Mky0bpFZRnvahW0fTrFqWk9rO1pPEBuxRcwyG6FBQlIGwDwYscio+CEZJZTjSEn0wcBNIb
 OKJoa+2kecXpX8ZedCmZNBTzOm3eFmrGkLklKP0iHEFRk+1vj1wZRD6xfMsVpCxbIsUajt
 zNGdA7nKU1EZCc9IwAI19Yt8W2W8LwqydAC5trzPXtdbW/QDjzDfA8sgTvLgHUDicSlJFt
 BI1Ql+bDJCk48a7EBSXkJ9BkKZC7tjf0WBm1Z55Pqcv0Jnnyn+voAzETI+85tg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] common: update: Port DFU TFTP to LwIP
Date: Mon, 26 Oct 2026 22:28:28 +0100
Message-ID: <20261026212853.453191-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
References: <20261026212853.453191-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 609006bc9488d1dc4fe
X-MBO-RS-META: cr5qxso7gwrb6xdi6wpghhnatkkehghp
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

Make DFU TFTP compatible with LwIP by implementing a slightly different
and simpler TFTP loading using do_tftpb_raw(). The loader supports all
the functionality that was supported by legacy network stack, but has
to implement CONFIG_UPDATE_TFTP_CNT_MAX manually.

Tested on Renesas R-Car H3 Salvator-X(S) board using both:
=> env set updatefile update.itb ; env set loadaddr 0x50000000 ; dfu tftp
=> tftp 0x50000000 update.itb && dfu tftp 0x50000000

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 common/update.c     | 27 +++++++++++++++++++++++++++
 drivers/dfu/Kconfig |  2 --
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/common/update.c b/common/update.c
index 06e53cbd402..1c3ecf47a39 100644
--- a/common/update.c
+++ b/common/update.c
@@ -30,6 +30,8 @@ extern int tftp_timeout_count_max;
 #include <mtd/cfi_flash.h>
 static uchar *saved_prot_info;
 #endif
+
+#if CONFIG_IS_ENABLED(NET_LEGACY)
 static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 {
 	int rv, ret;
@@ -77,6 +79,31 @@ static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 
 	return rv;
 }
+#else
+static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
+{
+	/* save used globals and env variable */
+	char *saved_netretry = strdup(env_get("netretry"));
+	int i, ret;
+
+	/* we don't want to retry the connection if errors occur */
+	env_set("netretry", "no");
+
+	for (i = 0; i <= CONFIG_UPDATE_TFTP_CNT_MAX; i++) {
+		ret = do_tftpb_raw(addr, filename, NULL, NULL, CONFIG_UPDATE_TFTP_MSEC_MAX);
+		if (ret)
+			continue;
+
+		flush_cache(addr, net_boot_file_size);
+		break;
+	}
+
+	env_set("netretry", saved_netretry);
+	free(saved_netretry);
+
+	return ret;
+}
+#endif
 
 #ifdef CONFIG_MTD_NOR_FLASH
 static int update_flash_protect(int prot, ulong addr_first, ulong addr_last)
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index eeae2fd65ad..224a229866b 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -11,7 +11,6 @@ config DFU_OVER_USB
 
 config DFU_OVER_TFTP
 	bool
-	depends on NET_LEGACY
 
 config DFU_WRITE_ALT
 	bool
@@ -20,7 +19,6 @@ if DFU
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
-	depends on !NET_LWIP
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
-- 
2.53.0

