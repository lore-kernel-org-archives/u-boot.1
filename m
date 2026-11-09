Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F6606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PMvS0CGT;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cyoH3OkV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8964880DD7;
	Mon,  9 Nov 2026 03:27:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2Qvaapw3hzf; Mon,  9 Nov 2026 03:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1B6280A7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794194835;
	b=gZla7EvgLHoyUjh/qONE+r2Hy/kWrYvoE2zaO/kBvm/mPdlqhcLbDOgebO6bvTkBVWFa
	 0IY5D++d1rIeJrJEY2fBDiVLZBybcjYH23HqkNiUVbfXV70dPNbDTTrGmuxsIyAdNu6w+
	 AfEopZYxAeNBNvpDE7AIIgtwIJrg9+0UohRX8CUemB+a9jkDkTbI9JlMaATQhq2C2GPhr
	 tleOTzngNQPK0HioFBJeFzM3SciDax6Mf4HhDa4drVB9c5+CufX986fqxjGUBp4rnONbI
	 jCnwmPGt5k07qxpADgXJncK0uayrg3U/v4jNU4xeKxBRQOI0pSXjr9FKOP7hJqt2mDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794194835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C9ci1JSSnfL7on8lfYqpZse6+IUvE6tWpJ+UyhiID1g=;
	b=MC5YQ5UapRpKueLgwMfcnqqcc+abF3flSqANs0zU+5i0BPJ6/gxAx8dSrgaXAEOLBjTm
	 8ZBVN5lBFKKI5heKdfvLUz4Sj4/Heoh8mGygy8KnN/wagQejEzgejanNG+kLNZCpP84+H
	 40DAL5gVNVpnFElDWOnkjFSnH0aDddD79Cp6nG3QY2OFIiu7wrbYlm5/C4rqzXKRGjh7K
	 bZlPyiicE4fh8lq9+BYI+u1oIyOIClEeVucZTA2uQg13tsFm1AQw3AX68xe60+IA/Cb9v
	 TQR11yEAlxU/0O9QccyYj8fLVvOej96rycuy3iVVcUmh/o+UFJQegY2yads1VQfQSqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cyoH3OkV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794194834;
	bh=C9ci1JSSnfL7on8lfYqpZse6+IUvE6tWpJ+UyhiID1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PMvS0CGT5J60u/18A3GCBR5IzhdaW06aMhxzjKGcLi0LenFA+hytlAsix/piEoR/A
	 skLp3HsgJcjBOy7fOD0eJ6MKPg+IpPToGOTmVWpEhvqVTEAFa40pdacmO8/bnzMeEx
	 W36ZyKR7su8KbH9ocVS38UbAkEKVMCWwX/KoLT5CwSDFLnySCydXGYRbLVDDq6U2gw
	 zgtnBXbI1A6pU2HGd/6bMzkpWx2zIh8Ip+2PRvMWRr7E4+qviOd1ghY5Ag0m2fXk11
	 yO5JnFE40TxKWbiSCsY+FFlXa+6g0nU9VT4Jjsm7add34iHrC5vnYyoMqYCfUKrpmX
	 08AtVOcRA5dag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B6280A7B;
	Mon,  9 Nov 2026 03:27:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1981C1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F38C380DA4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZQny9c1dNFg for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 03:27:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AF2180E35
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cyoH3OkV
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AF2180E35
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 03:27:08 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jNFZd3dPnz8tcR;
 Mon, 09 Nov 2026 04:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794194825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9ci1JSSnfL7on8lfYqpZse6+IUvE6tWpJ+UyhiID1g=;
 b=cyoH3OkVQjH3+qduyDn/4J/U7P+DB6spUJ5IbiyUKU0ZHTv1TT5gSExhHtbef3K8h1JKbL
 e0ct/qgnlb090ETZDylgS8Tuer8rTpDfh/h6KwQhTtvRKugABn1PlpI8RT4EeYe6O8jeLn
 cKktAScXQTBzaQz/xnm4/GQ1aFIRh4bYgKnnym8lc+y0xyvBiq1p+HOeuGJQuf+CHv2w1M
 Jh6pkrrChj9LFbSgqFYNaxDNyQSzbrZpvZGgrkZTknieTj0/2+qWWtuBgqeW+tQNXIkTdn
 AjT+uUrJbjVSLTd0y6V3ZQQlZhP6p9BXya9n8mJ2Mc1OH/JoIxpnOHj9FqMegA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] common: update: Port DFU TFTP to LwIP
Date: Mon,  9 Nov 2026 04:26:46 +0100
Message-ID: <20261109032700.2839970-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
References: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6778883eb0513016939
X-MBO-RS-META: rfpjehsobsx4h15kar6t5y5hhm8yhw8w
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
V2: No change
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

