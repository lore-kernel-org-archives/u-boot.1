Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFB606A32C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=itMIH6d/;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=kq7olVSn;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=rUGbJYda
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0FD060B12;
	Wed, 21 Oct 2026 16:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGN_yfxolPA3; Wed, 21 Oct 2026 16:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20BD760B59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599420;
	b=ZB1IcxGMb27ICctPR2WTDBhoKezMB0I4T+8VUNNoRuwVV5Xt6Plqun2Hm2NjNfNkzzyO
	 yBqlslI84y5n8bEgP0rg+oW5e67fuJ95/2eDyx77bVCzgiEWCPT9CIDQv6NdbqUFyGqSU
	 sxiREE/ANcQwNi1yUi47n66YDDVQ0ONnJ2CDDXT8QpM+FqeJIfD9XyCBPJyx7n/ZRi+IH
	 j9mBwuG78F4/ABkYDsf+Jdz71qQR6sLi4z9GyrQHZsr8HGh7Xft6lG1UY9JDyKTDs/CFG
	 Fqf2l0ZyMGvAK9M6aMrxGlGQHbvujX2hwozDNyu28tfVFyA5PSxMGogulG0Knb6WvlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	b=GhKl+a2AGQ+i05JirmH8rB49A5a9+CkN44sqTFncuad+ji8HqXOxR6ljwlQddVljERIV
	 I7qYKL5vuj5+ObCFQHPuOWqw7/0GGbLVUypYIZJolHfnAamOI2fAYu4QjdEGus9romhOY
	 7xuU28pWy1VV8TfkTexr4sE4qVNcUBkGCByuP6/PvQnAWfnE8KmrRGh4hjo0HPEIhL5OD
	 dQiCVSli3HUq0pBBPS5KOIlEsE/I3eRbgEQ4N3HHBcQ9QaGPx1RUyHXMUzNLFB6Bi2Gpq
	 tHJr86yEk0PdDQQikj9gJZ6XnuJPeQtcv7t+K8hbTtH6s1RneMZwOdSgym/hUtPEwiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599420;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itMIH6d/6LHOliraXjrVy4tDQKW5p0iUdx5P1priatRt5QNGBQfrjSYi+MnBpSH9B
	 AmWttWXDjbbMqSLgH67IBlOx6AnRreVRrweLozkTEqCOUJXSU4pw2Wd1XqVn0lLwFA
	 5GoyGVflgvcTBIj2EmW9W7qqR5Y6ZavKS45KMbHJUwy7mibPgISx3n/FDdbzEvVKTI
	 37YZKF7V6dLF0UalDYTbZ2mhfljdmZ1wijIoPUDefCodBCioVStSQdfFHV9VZRV0w0
	 vKiioY1JC0W7Rd+SAVDpE3t0cUZIpsEFjLVWcFhe/HfXX3kDz9d70ouxXdWIO7UJpx
	 CxssMDXck/zKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20BD760B59;
	Wed, 21 Oct 2026 16:17:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 281B41184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 0E5D94039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id Ascjs9cvmVOe for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0970C4016B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598527;
 b=dTqmXOaoRM/UAWcsiU4KO7VamDuqi5yuUbvUaBPkCYWxEADLu/7l7ZIFTejw7axE6BTq
 ALr9x9Lz5dmajCnQr7i6UWmeR5d/Ta8/+WRj8BXzYQ9f/IZRvks9tIM7qL6J0IVHt7c6m
 QtMTgdArov3RFbSy9g60iDujSmEhGplS+HRc0ESEuq7aAc5TKCcqRWdZGAjk2XG8qoyDf
 15zys7aLJxcrLlTV1bkYFyLH6OJawzxv8JUI93oVouqptxUC9O8lKTnlRHEFQQhpGGJFv
 oqGbJWXj6vQ5eUQR8Wxti8oTlp6w5ZOpUQvENiZGWhLU1K1h3X4CI9174VLhgHoIm2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598527;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
 b=LDo5EW+nYapxC6TxTEJbj3qk5c0dvfzWPIvebmVdYORH5yatPGIvNmnXpiLnWt77Zxb9
 MfU8QZgH20X7ad7FnI6gIlR3iz5CUDIWjyJzhj2SEESpztsxw28mYXXr+4Xrbw4mN4sck
 bJQ6UcS58+QGgZlpuqDAJlVhWquGkV9ww2UU12z2w0Etqa9eInQl/hxwV1pJlUdQRVKoh
 zXyHEO2pyqu+v6wQjLqWKkLhH37jq5E3cbToNCsrtchlJN4JOvcRwwAWVDaU+HoCmKGD3
 9/qI6ibBZl8/73q2yOizmcsGaXGoVIO35mz6fwzReF+LpAI4XFeGKSQDCgMm7ywOdQg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=kq7olVSn; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=rUGbJYda; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=kq7olVSn; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=rUGbJYda
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 0970C4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598517; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=kq7olVSnfcNB7B2OsGygD3JWRrstjp5JIAiRm0zfJvgFfxLCHF
 wsAAKGfrJfZfpK6AWucx0b+8eN84bGmNrn07j4JBzbp4WWsBVHXkxHGGj03fLSwFt6zI6TCsnZ+
 SMF/3FD0W/2aCx0oCWYHaqPtFsGs6HzYDmqVQXKdmsZjsMcQNPiEm0+zIzdN/BtCZBMXPQyh2Bz
 6V0tEXw6j/xhE+mcTOIfn0uDGNIhzEisXreweWoRIIZxTjMf/kLlMzX8ESHVesEuz0A0weTH1aB
 KPBoDe0gYA4B7Z4vl9HslusLMEoM45W6tnWllVqihjlKXvmYb+Ey9iNNtRp3PhsdIUQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598517; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=rUGbJYda264VD67yqtJDRBIv71/U2erkKolf7/QlanBiFSkfe6
 74GOjEI2Foxl5P0HtWfQ12qiZDkyo016QeCA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>
Subject: [PATCH v3 26/26] MAINTAINERS: powerpc: Add me as PowerPC maintainer
Date: Wed, 21 Oct 2026 16:01:22 +0000
Message-ID: <20261021160145.10430-27-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
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

PowerPC has been orphaned since 2022. Add me as maintainer.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..1d331ce92d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1450,7 +1450,8 @@ F:	drivers/power/
 F:	include/power/
 
 POWERPC
-S:	Orphan (Since 2022-10-21)
+M:	Bradley Morgan <brads@mainlining.org>
+S:	Maintained
 F:	arch/powerpc/
 
 POWERPC MPC8XX
-- 
2.47.3

