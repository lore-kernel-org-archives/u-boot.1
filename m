Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAD606A320
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YegkSa06;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=fDRSZ2ve;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=4bGnNOJG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7A1C4077B;
	Sat, 24 Oct 2026 18:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uz1Rd-ONDgYL; Sat, 24 Oct 2026 18:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1160E40786
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792864876;
	b=QX2zM8DJwluWSdZ2wWBC+u9qPN4m9WOAV276FZGAekE2JeMWo3ZzB/AKmH30Dii8dRdN
	 sA5Y1xOMh5PVVgmSwH/Mxk99EayKohHbOitYqdm0dQiLe09jNg0enjv8HF/JUe+tFarKl
	 mEcxHbnr/Mh8ndOYrmanmp/MCrhIIT5IhdcuQ/5XFGmjUXDZNfp6Z5v6gnJHHnRPp8zoh
	 Zh3CPP8y4yV9hAOan8NlrnQlUDokzfqzi/RNcV570LadMkMZxAVbJ+41AETwVozYrWp7m
	 5bxvDhyz1XKo8cY5KVnZKbh7EbrnWkM4Pa9Yf2xiDawhIIw0qR+nuOgSwU5LABnlhWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792864876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mRxpwg1pRuvt0lp3iu+uMNi2+dkD4g5bK09iC7qK074=;
	b=if5zWzEXSPIwHB0WwpvYTYfkqDIBIL4sB6KJ0BqVmWLz7zvNvViN8g8/+zwrKuKKCgqS
	 csaW27lWmfzLTeCFzm0n2RJ8SGTKmL/VX2PjztW6yUBrX4ZuuwNajenryDKGO7ut/RQlF
	 LvdZ0huRJAu1U7khCERRIsxHY3q9WYoFzJkJasLshMGXB9MMjkDYPzp5wxzmpRLEEjUL/
	 nlppEdczTwnJlZEZiQpXP9ZdG/QcNg+AMxlTFCgJuu5b4O8emnGJBa141V+vFJyE+0g6I
	 jgg9yy20iWPV+XqofKHUSr+X+T0VNckPwPV1rbFX9UgM/nFjuvjihuvsRdpEV4sYClQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792864876;
	bh=mRxpwg1pRuvt0lp3iu+uMNi2+dkD4g5bK09iC7qK074=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YegkSa066UZZ+BqjTrw2EgHEiVBc8t1jCFSiNfJmgfaLvzL3vC9zhjjbC51YrIR9O
	 /V9Pn6CLTWtyPC5RUVG8R0iS9tEMUn2NBJmGw1HBnxuqO1ob3bLOerAw93PYm79Q3P
	 UsCfKcmznJjmuEp9xSZ1hK/RG+NDpEgAufyZqL4FKNbLFl7gG7ZD6Xsa6Cp4tbgII1
	 /fYKXPyIKW2u6+flhT2IB/goOvWxy2uWuYk0vQbxaWLl5N0iqyqUUnh3LvORLCFU1i
	 UBj73Sv5EYnQ0kk4IIO1qwmY7rVkZqiLF2CLvptQIN97jMRvWZ9EhDDntaTVq9xCU9
	 sRr62jvOFQy+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1160E40786;
	Sat, 24 Oct 2026 18:01:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 9BBA9380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 818B360640
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 5JdIt533CMJv for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2804160635
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792864873;
 b=oGu501xWAufVIOCfTyWX5FM9XC+GhIYAqZebRCBJye0/Azx29U0ZQkSLXFFEw6xUQ9Gm
 Ct90oX2HT8Ru1iL0B2N2OItVNQgs2PLNlrhh3gfHkIryIT3smugBqjr/9Bn0j2iUhOrp2
 3VSBesiANKpg3WTyoXZHbr5CHX/dIlsK0PTHe6zqKTuWiQ8+gHU3Q2dr2xWDIFphvAdiC
 kIOsXZYBFH/NJGLFpOiPYj1Ay0tO39B295JxDLSMz9cqtzAEn7VNPfmzf9tVVcX6M5EsX
 +33tfsQWgkqeWoLETheKXGzu4iJUfMbRfBZ7xLHZYchqa9H4CaIYzN42zmDOA1SJOCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792864873;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=mRxpwg1pRuvt0lp3iu+uMNi2+dkD4g5bK09iC7qK074=;
 b=VK3WDnsjWTVdIeWO4qUpTWR6sU62zgOSAnegorR/Y8vtn5OeNtHvkrcC7obr/LpnK7fx
 Xym8/F18zfH6y8m/cVpe0g9l4XtVs1G8sLiJO54jdXr/ghiLOqsRQvcb67SmaBCvhCRwA
 X/WBftgjlSn232/0V4OiuD8Vh8zAcIdSICY3y2O+iqyGBbGm72V1K/dBgv1MhAGM8OXhi
 wTN4htQBrns+ynP+uXPU8g0GqCdlHW588HlNVvI22GEvHKPlUpRZ1HrAhicIzt8ywqqmd
 b8BP4HY8E/p7Bx7rKljpvBLMfMa+mhKdEqeu70i1zfYuVJBrLSFnD5sqRJF0fe0BfCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=fDRSZ2ve; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=4bGnNOJG; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=fDRSZ2ve; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=4bGnNOJG
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 2804160635
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792864848; bh=mRxpwg1pRuvt0lp3iu+uMNi
 2+dkD4g5bK09iC7qK074=; b=fDRSZ2veWAmMq3v/EAPqxUXyTtMRBsvytPKXPjnLrXplJsU0wo
 eQehixRSQPTMkxaxgOwfZLlHasZ8dEPsrjt5ZBgtnQPimYP7zeTLJ+5DklBMOfMTUIO2wWRyQkN
 O6LnYrEjvJHMoHd8OrHAPgvNmwYMfzObV24YEUxbOVYcic2ty+KF/K8n8twDR3/wW3uc79/7h3A
 R8/OFlpJUiZbMsRvwVDOSY9bxn5IUfh00QC7vVM3marH0n1A4NN8494G8vea+i4RQcsNdqZ9fIY
 izYbiHBV1E0pUaK03VpMhwcB5pN+GgC/celb6U2N3K6AiBczyNTKvQN2oHCJftUmxUA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792864848; bh=mRxpwg1pRuvt0lp3iu+uMNi
 2+dkD4g5bK09iC7qK074=; b=4bGnNOJGSK+C6T1qvnu4fvLXJ/RgkQPkZJBv7nug+plDmH9Ze4
 BnmQ0PCWz4P2/qIgnT4WdBqqrsAb22/Ny1Bg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH] MAINTAINERS: powerpc: Add mpc8 regex to match drivers
Date: Sat, 24 Oct 2026 18:00:47 +0000
Message-ID: <20261024180047.8158-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
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

The POWERPC entry only covers arch/powerpc/, leaving mpc8 drivers
and headers under drivers/ and include/ unrouted.

So to fix this problem, adding a N: regex for mpc8 would be a good idea

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
NOTE: This sits on top of pengs PR,
If you dont pick his series, conflicts
shall happen!!
---
MAINTAINERS | 1 +
1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d331ce92d1..050b48eeac3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1453,6 +1453,7 @@ POWERPC
 M:	Bradley Morgan <brads@mainlining.org>
 S:	Maintained
 F:	arch/powerpc/
+N:	mpc8
 
 POWERPC MPC8XX
 M:	Christophe Leroy <christophe.leroy@csgroup.eu>
-- 
2.47.3

