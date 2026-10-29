Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01B606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BTj6eeWV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=c7uFJFff
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0871C606D9;
	Thu, 29 Oct 2026 05:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8F9ABLIyiONv; Thu, 29 Oct 2026 05:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D809606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250549;
	b=M72wtjPFfq3DX7yJmH0IcZVd2YyMp3ktQLaGFOIJ5VY3YLNt5o2L2mW2syjFjI2ouEJd
	 H8b8j2EBGHYHOS9m0GhvPKOkURYworQnl6F5aqSZ2Q3c7hWF07nXbqukwVNQK4yf8y7P9
	 tm3ZbV6cFRLw8ApUQcpsJQZpZywu50rsQWzGOC7TyDqboG9yfqNvleIf8RwJ2wOK0bibY
	 xVWbG9Mu0FCH3/rZwnt7LqDPTHz2lTw9dDrBFgPwS6IIiv5pZG1A5JgTIcQxQ/nDAitLV
	 sChsU8UG+fOINelsfPafSRA2eJ2evMoS1mqCrpjbVfwx9NTy5JzUkXOZ1ROJPHhkf8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rOfHKh+xplOQJxwpFfYfhI/KPKtIygCfC0RIqDSKfEc=;
	b=gdPKBVYBD8IOQmBW1cC7Lvz7qaPj1GhY96M81xXceuRErIcb3g3ARcznpcPCqhjwJtc0
	 LR7Mu1qGbhDj2J5ZgPcql2ipC5uLrypaqLAMob2KuWULt4Xk0XErxBEj8FmHRE3AbV+B6
	 jyaAFzSXi1MNTOaJWLaoat47IPtl5uVLNY8ZhkTH6G6u1eCgpccq12ABAPWQL6msRhv4Y
	 ShrUS7LMEZ8t5XwX7BsuOk/gbaUTVQhGUz2n5s6b+2ENW7yGfhRkWvhj3gcL0vz/UzufK
	 Xla2bQJT8e1fgBbqFYZDwA1+8dGCJZ6JQGR9pK1GCbaAhtfkw06iRuUbUrqhTHZLxng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250549;
	bh=rOfHKh+xplOQJxwpFfYfhI/KPKtIygCfC0RIqDSKfEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTj6eeWV6Wywgq5NuOhxX2wwqQ+ykLebhsB/p3hukj62OYl2fy69I2z/zUpCfSQw4
	 t00bbcUYBX5ZQjXCMDxDHbQKyTA0iOI8Du2Mfy0ZylEMpmZqcLq5zT4WIAtiZMio/J
	 bMTs8lXbLyOUO6jmnizZPT/nOGWcQQU0SeKMaoFwODgZfKPs8eHbNRPsC3advmrAxz
	 Dzz3H4G2twb9CSDmCQwznzuAmAJ1NznYduaSXt0E0UFAyG/ASvl8gVLEG/7Db4JgtO
	 sjefgV/fVDKiyBFV8fe13KkJ+3R+wAgYmmoRb4TwNeZKceVNoff6CbODBJyTmuSIo0
	 EpCrj4Jfeaw7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D809606CA;
	Thu, 29 Oct 2026 05:09:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B70D2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 286C340329
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROxpPNP2kQgF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7989040176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250547;
 b=rr0kFOmKeJ2jhWWYNC4irJTDTvol04O3IQPb/86G4+oYQQy75h//dS/GhAdZtmyWiUUX
 LL2Mj+tOeFKiZzP/2JY2tm4a9p7/j18q8dAtVumQGYTBejg7W0iU02hoLszDRr5oKVkAj
 z8q7dVN/gttN3qZfpJh6MApKekYrvvDOU0aA8dTfMnatExmZD1o6H8yOSOzYJX1UozR9k
 mlA6ZPFOmP1FpWSeOmPauj+wRxbae+dVrhnoblZxVpozGUeGSngvpsCTiLyakN4/Zr4YO
 lm+n7DaWjcZ38Vwj0/Uz5rwUCAv2m768p4RqxBgpkoD7ZObadjmCoO5FPKMg35AHHlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250547;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=rOfHKh+xplOQJxwpFfYfhI/KPKtIygCfC0RIqDSKfEc=;
 b=mjY3/hnERbWYdqisgL+AmI1MeTAy16h8oqid+PcnAqcTkisUh4uENDwGn09iy61aNFgT
 C6Jajltz8gJm8PzCI8fY3xtb4EbdLPAWnW2zjoxqwfeTFsBe03vQBd6wqtL8k/etSd57M
 BpQpwe9sWqQcGNNfSfAtALTrdiq0hdknB7UsI46lZx6FQAcbwT62SURiJGR2IF2e1ssP8
 9oJ6ct/rrQqCbj+ig4L61waNYMZNeh3gNLGTM553FEfH9ZtPmRUz6BJ6A/CFQYLoDFNP8
 pkq6FQBZEi7M102+i6kzgoCHr9KnGgbvd/xBH0+15DkBQdH2dqDJtI+L6bCmDnRq9nw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=c7uFJFff; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=c7uFJFff
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7989040176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250541; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=itYrE5GVGLYW+ED9NRVifHK2sK1H4m7Isya4d2FlDK2EX8ekYVUPl03jhtlAJ3Rk7YTywO50VVr9qEAWYitgorKarRI+z51az/asoU585DgU9HS/6PQTTU6X3aJy0qmAfK9LSalnknaezSP7t/Fl1A3El4SbgoQ44oYI7DOcMq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250541;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rOfHKh+xplOQJxwpFfYfhI/KPKtIygCfC0RIqDSKfEc=; 
 b=cVJ3UNW+nN7VGYptxrgdI07t2f2QMCIMouI6/4cGNueJPjBKHbDLZgrNTHBlVqwHjwknyV4Rx9YwsjGEp2f6PhtlZ0/lXPZS1wxH/imwNaYWH9YUFcX+K9kKmm3kUmSHebjjkMbu5O3zA4p8WJL+bVsyZCrREmTXZ5vWjR6qbeo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=c7uFJFffTLxXlCU+zZXH7KPLqazv+Ax8TQu4gH2sssc+ir2pk3DSuVwmz2vFLB7x01cHWNWiiUsUxjavdjVQVyZpw/sAKpCf+D6LIW9M8LjaJo7X8tXoucSRUY9wRaOsWXN/y/EkfzFQbWCj3nVdtXaTV5+C31vIVntCD0fnYNc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=rOfHKh+xplOQJxwpFfYfhI/KPKtIygCfC0RIqDSKfEc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250538164620.3115730180979;
 Wed, 28 Oct 2026 22:08:58 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 05/20] image: Define IH_ARCH_LOONGARCH
Date: Thu, 29 Oct 2026 05:07:22 +0000
Message-ID: <20261029050738.1107663-6-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No functional changes since v1
---
 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..fddbf01e04f2 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -86,6 +86,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
 	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 09cae96b2a8d..01fbb421db2f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
 
 	IH_ARCH_COUNT,
 };
-- 
2.56.0

