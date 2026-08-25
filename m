Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A36CC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41FA960736;
	Tue, 25 Aug 2026 22:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yn1oIi6eL2yE; Tue, 25 Aug 2026 22:41:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787697714;
	bh=K998AM2Wo+6M0O2epP3ts7ZS9AAFpMrkwfvooI2DwQ8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L4X0rVKDMZLcFiRmlNhrwCIEojvZPc6XPLCBkPyVMfYFJW8uBHJczegTvKq2C6B5g
	 uMpw+eTttE9Py+aziI87ZZLkbv88aEFMlrHcdupzqjO6CsViT0D6mKM6rsugrsFGBq
	 A3xF6jnMRzblm7m9NwMzcAGkjiB2CTq3De7PDAR7TYoqoPeB/QE0+AeVlYjhTPb9rN
	 760Yx5zD1CMzg1oj5VdOZKd/SuLWUKH8AHaR6Z7eWVLHSzUEN3oQ36J/jSFMH213dp
	 aRS5rXDPovPFc3z3i0HzftDtQxDVQTFyGI69c1lcgASWY15u83Dkqo63hduSBFN9/0
	 RUhSHTmCC2JeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07CB1606F6;
	Tue, 25 Aug 2026 22:41:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D41C2FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EBCC40612
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkMMj3bFVw5w for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:41:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=hoUqBdKD
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE6E040606
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:41:49 +0000 (UTC)
Received: from LT2ubnt (dynamic-176-006-060-003.176.6.pool.telefonica.de
 [176.6.60.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B6694415D2; 
 Tue, 25 Aug 2026 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787697706;
 bh=K998AM2Wo+6M0O2epP3ts7ZS9AAFpMrkwfvooI2DwQ8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hoUqBdKD4NJcI42Dn+cTPwX4XAz6ivFi0NBbC3654GBejSMDQ4XelwR3CKRtzi2gj
 Uz3JbFVIMamEOYT+ANUdDO/kpNFBAJIbLDl8yyoH/feBQLiTzt85lIj6swf3uyyjQ1
 B3PtnvWOTUrWQdgnnvOzA96jotskHRpi/43m8qvxphS9eDSFb20YUzs2OwqrigkHJ2
 rbyV3LtWBUpDylWtolsDGt7G6d0qU+jqNQDHIMlYrneHPSXPJXjmSZ3V1SJ6S27gX5
 OEaQZ3nKZ0zLjrWwcwzkZ9SmTRMv5SK+pt7h+UimMclf9WkGVVl6AFvqU1uKjZNXoT
 uDQuOUOtLohcbR/bzTNiaLdvWSM1t7c8DGZJZSXLxzYi3CqvYvdQ2dWhPHGxb6hyqh
 rXhY1S/EbeBvCzWhBGyqzAdGs71v96PGQnYh7C71R/fCdY0vWeeAkTXwZurN7w9npC
 fZUvHEJeatmgag5F60Cu4tCT6UpxU/Fh9ZQbSo9r2EuE7JZ0pAtjjTorIZtsmE1fw4
 GQ6C0rq6D7ieqMv3cwzUo+aJydN+serLUpqOHaOA/HmUMDDecU20TIRfzMe1XRDOHp
 kjspQL+HxJOPLSdZJVw8qwRlrHNH4/JulBt6S//Qlh220vGh/lIT07OAEkVAZPINi6
 9e+iRyXkQ7gnnIIm63wjKSpU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd/efidebug: do not allow invalid boot order
Date: Wed, 26 Aug 2026 00:41:41 +0200
Message-ID: <20260825224141.141745-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The `efidebug boot order` command should not allow to create a boot order
containing non-existent boot options.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/efidebug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a6faa36b500..e2739b1df04 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1423,12 +1423,28 @@ static int do_efi_boot_order(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_FAILURE;
 
 	for (i = 0; i < argc; i++) {
+		u16 var_name16[9];
+		efi_uintn_t size;
+		efi_status_t ret;
+
 		id = (int)hextoul(argv[i], &endp);
 		if (*endp != '\0' || id > 0xffff) {
 			printf("invalid value: %s\n", argv[i]);
 			r = CMD_RET_FAILURE;
 			goto out;
 		}
+		efi_create_indexed_name(var_name16, sizeof(var_name16),
+					"Boot", id);
+
+		size = 0;
+		ret = efi_get_variable_int(var_name16,
+					   &efi_global_variable_guid, NULL,
+					   &size, NULL, NULL);
+		if (ret != EFI_BUFFER_TOO_SMALL) {
+			printf("%ls not defined\n", var_name16);
+			r = CMD_RET_FAILURE;
+			goto out;
+		}
 
 		bootorder[i] = (u16)id;
 	}
-- 
2.53.0

