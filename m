Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B48606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iIVerM1H;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c/xd7lGf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5609E4041A;
	Sun, 25 Oct 2026 23:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ktoZrc3aU49; Sun, 25 Oct 2026 23:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00B76403C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792970326;
	b=fVML0MnL2wSUplcj4bDJt77qKFU3vWtTCaLCVxJpQHu9sjCutZGcdH14OsJZlmPIGNVA
	 X219Khwx8/Ps2H2AnMhfN+jDB3jBW6rF+V5nFCqIvgehvlCztSKA2NN9pa89EQs3tvKZS
	 6uqYC4XUHgworNWzA2jUEhRZpJxTv6c2vDhJZV2TM9jVEUwXPEOatzYaW0gPSKL8KV2mq
	 jWOFnvElD+TPTjz8LhlBEwj6aQi9/kTQUiVS0jfIoSCQrGZkuQXvTXVZCbExukqZuujrL
	 UfWAmSVfdrJ6b29ByEH1K3cQQGddATdNgSYqMpLgwZdpQ4tgfoLSuYZVbTkJYcbW4bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792970326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OYAhaHguNrrNR9FgLk8olIpk9wsh5g9s9e8J7H2e68A=;
	b=UmM4+JuCGqPPS8z37kgp9vkI6FEAw1SaYK4rfcvChzQ6mw8Gt6kruLOWN2iN06zSRirW
	 FuraNKnY7xDTP6FmsVZJBsL/6eLa/JYrnR/NFuwh7AQXpAAJqw+qjkyrovjP0MuftyTsk
	 17ygFTwXNvH5u/DYXcAL3f31K+86szn4kV0HRylZA5sqxDFufVPIIVuOoUzETaSAE6nyx
	 MAdUTEj6PVhZ/RBB9qm0ucY1DPyxjrl1DiF9F0VzaO4sYW0P95r6iA5AZOFvvHCz26EYV
	 3QkWOX4D5//qpW+Am3PIgancPRTQdso9mS1VgPsgY00a0g1JNBfPQMuon9tWLMkIQFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792970326;
	bh=OYAhaHguNrrNR9FgLk8olIpk9wsh5g9s9e8J7H2e68A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iIVerM1H/VTn1M4aEIl0oPB/BWTN6OOBCStr4vXBW/zqe0aPVL1HLs9zjzM3ZTPXG
	 rxrzr4gKXMpPmGHy4wWWcvrI9O3yIdGRkb6yWzf/cDfqduYz7b9EiGKo25PDkLmXp2
	 grLMeovYd2b0s6jRFfENcZmUg+EzFtFarT1j+gwGcRjQE7qbvPat/Kl1TZ0KJO0ReG
	 KnKyoV83071NEqK7Sa/R8yhX364UHPjgsaVkeaNqXIzo+bpz57iqo6XVguNHmRhEHs
	 CS5Y89ToSNhjEK7Sk3+u8v6fnSSRvjC+6J67K0NMWZvJC2zgJhiRztKxtpXBRFasrX
	 CnYFCd4DITZvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B76403C5;
	Sun, 25 Oct 2026 23:18:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D23BC380
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4418605A9
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIKyLWn1YBTX for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 23:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 223A560639
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792970324;
 b=l3H6j02HjKTutksQsNTHs47CPjHK5MszCpzPEfedVb5Y1Xr7ohGdVmFnGXI4Vcjg3BQw
 NcBoM9J6y03lcX6NrH3G+8c+vOJKGmiOo7WxWycGq4GiaOgJVgJJmwb2WsollQM8qTcZb
 r5jibPxRFymWSwUisfjaLX7S9tmdnGvVGfOOlBgOHTBcfao2Brleg9rC6yAMaqOxPsZ/l
 eDjOMD4BVTJAi6rpRWi5V5/zb1zGPw5TSDG0uXTJXhCspbzb/J0fVjRqRu5JugmagTQOT
 7fS4bZYee8482s3jPtE4wJ5zoto5ENy23by9ruy0GNa0xdQoMQxtoRlYMSiYwYN6Dvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792970324;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=OYAhaHguNrrNR9FgLk8olIpk9wsh5g9s9e8J7H2e68A=;
 b=OTE7I78tluHXOkkgkKRhlQk6PXHHHB0NbdyKvizp2ShoBuKeclylpC6bKM+tS5ldNjHJ
 Hqbfp9C8nIbISIXRepmdkPiF5Kx4h8h+gFBQ456KCyGZwGgGjCbkQs6J6edzxH9uxftPy
 wnmaI4cs9jV20a4l9huLvsvJnKuAT1HFFm2stLQiOwoO8Bijq2MpQJ2EP0w+Xwu/7VHEe
 6D/G/QaTP4hkEQhgilYsK+CRL9GznC7dSf4mlimRrJylATKiV5Pm7e1Hs2QeMyONijt8L
 3++85jUFY6o0BUWXWOaz+4RQC6A5WwjpIFZQ9pYUS3QZEhDt9owgfHrM9XS4JPiP9EQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="c/xd7lGf"; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=c/xd7lGf
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 223A560639
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:43 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jCXkS1xp4z8v1k;
 Mon, 26 Oct 2026 00:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792970320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OYAhaHguNrrNR9FgLk8olIpk9wsh5g9s9e8J7H2e68A=;
 b=c/xd7lGfUUhzp1f8PJW3uv0jKdYwyHC8FrGEnDDAnx3IjbjDE05wPd0WCA2j1RuYAve0z7
 pFycUP0C3maSgEa2O7h0P/AJL8PKETlrC44UQcDZE9UOiGh+0Vbq0LVXQp06mq+V4zbLS7
 6RX9pqOatOnJUuKAt8/AeHlMrOcOJL2BZabf+mlv6CJ08IxCV0LilRfTmfAdPvpN1j9z06
 emsLOBnQtmImDcWiGw9wN/xqxBNVECIUqCF/Th6nZBG53CY38hJdWBye5gOukHrk4vETai
 8jG002Cmrj4jEnFWCcpF49vSd+6k7KrDOuw8lpzZj9+b2+rq38779tBHK1fQCg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 MD Danish Anwar <danishanwar@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
Date: Mon, 26 Oct 2026 00:18:25 +0100
Message-ID: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6yxj33cug7cgjj54u55jya18iu5s3k4f
X-MBO-RS-ID: dcb8aad72dd8ac20ed8
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

Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC, else it shows up
in configs which do not have remoteproc enabled.

Fixes: fb49d6c289d9 ("remoteproc: uclass: Add methods to load firmware to rproc and boot rproc")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 7f9e35283f9..cde572d61c1 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -151,6 +151,7 @@ config REMOTEPROC_TI_IPU
 
 config REMOTEPROC_MAX_FW_SIZE
 	hex "Maximum size of firmware file that needs to be loaded to the remote processor"
+	depends on REMOTEPROC
 	default 0x10000
 	help
 	  Maximum size of the firmware file (elf, binary) that needs to be
-- 
2.53.0

