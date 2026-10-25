Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E354606A322
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ibGNlgku;
	dkim=temperror header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eVB1vR6O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D8C360641;
	Sun, 25 Oct 2026 23:18:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJp-Ks6TsyWn; Sun, 25 Oct 2026 23:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25610605FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792970309;
	b=Z7Fike2QKx1COgWqvKadyWg07EuPGe5Qy1Bm1cJQtj9Adjyu/GUIcbkqRf15xbul4you
	 GBCuT9ViCAgkwUXcDQYdw81F9CEBGyyRcoVebYsChSrjme2ICf2w/bQISqXwuZeaDRNWy
	 DuluLwqHyUgGLqGtN/2OwDlxzXZ6RKWyQWYZq+RWLNGwCEQmqc3yBmzaijGYOB4/uJVQj
	 RJ6l6xowXSKfrcqb4qn9gWsHs44YmPtlce4n64Swu0oPyTzXI5pWKzrsNg+pxLzCUC8aG
	 ibSa6SOlMF9YPO+W8JWv6boSZcpBYEcVfzBnYGE/AWkSfuWbRCTQjdTs6upIGMG8xaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792970309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FLvjQ7yVZ0hjrbm01Mz6QKezYS7/Fvl7MNDgAjK50q8=;
	b=OeDPlduZpP/hQ44kQaapaWVdlz8HT6/MFT+UkQ1N2lvQlcpWqEsFqt7BmeTTyvp8ZAVB
	 mo52T6FXDJAGXJBwz1NAUQiu2acc5SikZyUOt6Db6BE6pNez5d8sTg5d8GPyH+vsDQ3zz
	 JfD4aBROkx0O0kGyekKHsYPb1busTIS3cmoXnvjl6c3e+k7/jnyOo7bCF13CvThQxWBbW
	 rnUMlvWDcUubh+KKgz+XshDBttEncdKZS2CbbflIUZqW0XGgJlApXeEl3si8cZR3YElEY
	 OEudfTqoa1HLYd81rZGzUVutSvfuTZiOtyPuVj/P/3hfc14myqC/3o3a8k+jmZubSow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792970309;
	bh=FLvjQ7yVZ0hjrbm01Mz6QKezYS7/Fvl7MNDgAjK50q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ibGNlgku/YjBIH7ymv6WLxGCfydlrNoWCarGWKnb/yy8Y85f6zkJANYdZPNgzM9d7
	 OhHS2aMUT4nCA79D17wUUTGbcYe2efonJ6kVjJK46sM4yoJsQ/IiEi9yF3hRB+d7/9
	 f7a25oXDLI+JOnHsMJ9MZScNBXeGaAVIBAw2nVCMukgzix+1bFXHR3A61JxxRnSkNu
	 8yvUq7QaxjaGFy0upPCe/BHPTxAsvLTb/C7RzrWhJLlY9+JW0APFd8KdhxS1aKELPD
	 ErdoTz6qMNMSe1Znd1vRZ49/rnj0hSnimwgPBsNtT50VseOUgWNLQQycViCwhIBqlM
	 3/aDRQbgRbyDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25610605FF;
	Sun, 25 Oct 2026 23:18:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C235E235
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3FEC4008E
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftupkFAS9KWA for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 23:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 22D6940050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792970306;
 b=g2a2R+/ExPkhrrFsBjI3YAXDa+Td7HciwP6IUlQVqRGf3hPWqcD1mBYb5wc2dT0ImyRO
 c4/90eS+WiviFcI7L1nmAuDYxAkVI+NaefwTlOn7XjojjR03jZfQuokApcFORT0iYU72s
 hW3nz1A/c+yntoyWOPO0gE40eXakdXqpg8v1O22vp4n9Z1Juh43yc1HkrjjQTj+kN6iyi
 1ImpnIpop+S1Pe0IH2TOMD4hcjjvF33rr3kJHR1kS5RRvL1ZmWsMC80upsbLeL1HtnUSg
 DbqE1eugufjo2jC0P+kCtaZIoz22nuXXnBz2GZMPNpabIg5HnrxBwSKW/nD/Y3x0YUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792970306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=FLvjQ7yVZ0hjrbm01Mz6QKezYS7/Fvl7MNDgAjK50q8=;
 b=ANRXSA6YKiiFGoSI2OBXJ7ReY1WrL2Zl801Y1yyCcLUEw0eVKkKiMEVy0KQyHSLJE5Pc
 kFGZUpmvpaTlkL1XSB6lGwbw2ABGHH5CUM82oCtP4ZWaLUbjeFiAb0twuvlBllLkX5R6L
 4UNU/b1HIn8kv0pX1TjRaDS74WIBv/7z3S1bg9UapOeRl2/rwytAccadGm6IQDoAX+Oa9
 0XsDaSdMIlkqkq0jXHpTEsX+9ZggOzwNiBVRSZv2fikx2VHuTaP5oAXJYvJJogG3xtQ5n
 5rLLGj/Tvzd+MSaVyWs83UBS9Ki0NBoDGJeVckYNnaqG6jIRPKDW82EVLI936XR7QsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eVB1vR6O; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=eVB1vR6O
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22D6940050
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 23:18:25 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jCXk61qNCzMlWp;
 Mon, 26 Oct 2026 00:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792970302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLvjQ7yVZ0hjrbm01Mz6QKezYS7/Fvl7MNDgAjK50q8=;
 b=eVB1vR6O4gqKnqSeQ5DjFua3GUVe/qjPciCunYblik92y/3cryheWh5ejDDP8wEuUK2qsI
 ee2XHHNxpTZLWQwuG9NipAjTYQpLVWVszSeVb1aSzhNam60OWqxh75AnO9UUEyzN/jn7aE
 3qzU9OCHTkRsm48isjfWcBCirJaZHL/hPQDVU6P8Vsm8rhopl1yCGT5gj/G07zTDk3Q5tr
 HN+d2jDm1BYtGgO6cQJ84AXyniAg4cAuvQq8xqMy/c2RUOLqMwcgL1sQaMtkaH2/JVrbXN
 U2t7bgMSnZew9hiMLkDa9Vh6i+42l6Fb5eFmIwx+/WiBXLrEaLhZvrrCA8eFHQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] tools: mkimage: Fix discarded const qualifier warning
Date: Mon, 26 Oct 2026 00:17:42 +0100
Message-ID: <20261025231817.1155249-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025231817.1155249-1-marek.vasut+renesas@mailbox.org>
References: <20261025231817.1155249-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n57y7xmqaeap3aawkskpip5jekxngso8
X-MBO-RS-ID: d118dee60d9f8068524
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

GCC 16.1 defaults to C23 and glibc 2.43 added const qualifiers to
serveral functions. In particular strchr() will now return a const
char * when a const char * is given as input, and a char * when
given a char * as input.

Fix the following build warning by aligning the data types:
"
tools/image-host.c: In function ‘fit_pre_load_data’:
tools/image-host.c:1797:14: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
 1797 |         name = strchr(algo_name, ',');
      |              ^
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index aaf5c1b98e2..3982ffb3dfa 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1765,7 +1765,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	int pre_load_noffset;
 	const char *algo_name;
 	const char *key_name;
-	char *name;
+	const char *name;
 	int ret;
 
 	if (!keydir || !keydest || !fit)
-- 
2.53.0

