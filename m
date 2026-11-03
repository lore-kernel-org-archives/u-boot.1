Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C412606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hSzAhw5J;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plzgzBdd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC03640754;
	Tue,  3 Nov 2026 16:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HL_xo9FbqlN; Tue,  3 Nov 2026 16:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4034D40693
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724625;
	b=RfCo7H2zxml5IEniZdNYzbrwqxZyxqIslgy6RShPAJDv2o3/h9nG28WlYaRp6iyG6iNH
	 c1IvpPCHjVAdNpQto68FlA8/hzMAt4XBXkur6ban9JOh7mwhRsGLqRiDnaxY2BMWvX4o2
	 RtQJTGPpxpUaLH0eWu+RJhrhLLv3vY/y9T1UlF3ooMxqm/BC6MZlo/9pt6r8WZ6b3t0GX
	 jsyFbbMFnBYGGzLuRx3w84Phy3OsCpS3rIYcH0tBTpbPRiY7m0u3bbB93rADJhslvMLec
	 p/asHYzUNH8UyUiLtyjsqqd8w05uuuDn/rLuj8cUh3Akqukl3/1Reb+pGClX2ecy7Iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3bKtEI11eIVbE+ucUSNOE/og5omqap4Qu69AnQCJRl0=;
	b=ZjwkFumJ0RVYv6aydszq3wPtfrIGj5twQQvNF13VcXpmcozxfAEp6cvqM2PeujNohxVc
	 Tc1lr+NNJl6llY1xTeAiUCrvAf4qiFwizgeNL/EgDgA8J5p26iWN3BrcWQJ1KoUTRwZp/
	 FGaqJst17mm1/ppTPsoBSERqkBe+VvJua0DsYSdV8k217AO/W0H9DzSmsw/XZqpZUAcuB
	 /kxN8ymJY+4DzqRerXV20tJkdO6ztlCoc6Ff6KEElxUE0cuQLTUSDMeWIrLaxvwBa4a16
	 glPAwfEVrxBxHMAE7F6IAVwkVN9GniRoEGhadtJTnkrzML96Q+Uk5CwgXPxzjsL+TpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724625;
	bh=3bKtEI11eIVbE+ucUSNOE/og5omqap4Qu69AnQCJRl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hSzAhw5J2nW95nyJ6oigXajRFE8SIZmKOkGS3+1wO0/avQSgb5zB2YJhykW5b+j28
	 qA8Lzh2P78UwdNMfto9Jpf4dFCMJsLTbrY+AZDXbZFE8TR5YMWhKjjlBnAjmEsnLlP
	 X/zA6U66ghZdedB/rJ3hVPk75ezaE85hAlIdDKC/Rx7fCv+blWUNmDPv122vRp8T8o
	 Fyf7YmmZS0Tb3/QE0RdsfDhP+DblNFEF31VK2glt/0ggPgqxHW1tmsvRoQvEb1VUTI
	 UMQ+Y2b8N8vPJO5yrYJEBa6xbLDIMdt63RG9pPrkcPrEg5H889oUTgDlOb7Rh2xAnE
	 GrqAXvFQoyROQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4034D40693;
	Tue,  3 Nov 2026 16:50:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D11602AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2BB740068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDKPg0P-FYzi for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CFE5240062
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724623;
 b=EgCBfdqmizi+RodlJDtlzSyDZbdrXEyuEjo6Cl9EVJLUwQuANmNiefNS4IkUTEkjLR0X
 +eCHVow0fG1JTLFMZ6M7rE8Bz925w5741SoHUGVHlfNhCpbaySVcZ4ZbLyffUE/zbH7jk
 yFaWefKeUlX1vZiyJCnPIfn2HsvvI5QM5xpVABKFP5PQJhT0fwdKpYgyZ+ppbtWU7NNXG
 ixH0HI8mTQ8DoMCyswV2aPsAJdJ9HXv0s6sOIWz5eMkzkHJnGJl3H3Vi6F/evZIyxaNa+
 3wF40ZG/DCEFJDwok04UtAzgybBDtGXicPML7itXPbM41irojg6CKUqbNIqgzJTWoDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724623;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=3bKtEI11eIVbE+ucUSNOE/og5omqap4Qu69AnQCJRl0=;
 b=Tf7bKKk1sb4YNhFYFbqMfxAlhO89tkuV4QO0PCC5u/a+f7uEvncI8R6Gae/0WKKz5P92
 VYKNi7Ok4iiWvpWNRm51y/PN+SUh3F4YXcegUq6yLRTYTyGBjwEsYP1LBuYdx63MYRocI
 uvheTTJegZaNHYbuDeVUsCa7n8/qtELxdLHk8h8ztRGrbG2BdXYIIWyd+3ksjYOfnS72O
 vzXnaViZ5D7ZOae2gcT5J0n56onLYS4Rfxk3XI2gV/6/a5fy38ZZGrrUqLhTYpbsfeqWg
 E42SlgAaSVDF3JyXh7658CBovLXiMpIx3fJqtFY4PeUAgEM/+Q384Rf9c80O2yajwWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=plzgzBdd; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=plzgzBdd
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFE5240062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456CE8480F; Tue,  3 Nov 2026 17:50:20 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D8884823
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-675617e81f9so4060664d50.3
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724612; x=1794329412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3bKtEI11eIVbE+ucUSNOE/og5omqap4Qu69AnQCJRl0=;
 b=plzgzBddMFqGQl8JSYlaaBgLS/lj0rzmcleMqcEBe0QMPAC29CawYGTfg82v03b+4h
 Q4bgIN9p6KUVVZDCx3xsfIV+ch5aGn35kJCowYB4mqyaKK8ptHPXqf6uZKCIWd594CzD
 OyQ2WkLFERMGMGxkLCVo4w7QbPJAJiYrB/77ZluZZ34HCN13I8CEAAyBbW2kjJDDtznu
 z3EJqun8dvPaCmb2vnO4ZlYzL3dq5c0Sejgzgm6TlbYssf0dJU5aIQhn+6jLSsJ+3p33
 kpzV3qbAjHEEiBUenLlI3uox0wPaXAK7eSBQq/auyYokQzkr+ELlpm51qRW6cWJKbAN1
 J5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724612; x=1794329412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3bKtEI11eIVbE+ucUSNOE/og5omqap4Qu69AnQCJRl0=;
 b=Me9h5PnGCuOWov3v4xhys8jkIwU/wGTKb6lZs9fFYGAussldRyVpnFt9iAdNEbLFxT
 RiupniCy101S2TUd8v+MLw3zqbbGTklACZT0XLCdSaA9jVR+wLBWRtFP5EVNEciOrPyU
 19VIbEpqg9WOEiWWVp3TuUmNcKwrBrwEZ1WmQVGoc6NHT1ekh57YPeB6yWp6CeifHtPj
 y8adEVpq9iFhw80BarrQ0tyTytjYIt/DmQkcEQcDB+tjZTFvOkYnnFkGkpuNt/feTcUs
 Pdc8EPqpLi6wpOIRTnhdbFnV3ygB9AxvL6AEfGbH8McngfXXHbuvEb5+zna2g4CJxpB0
 eR3g==
X-Gm-Message-State: APuU4Z8NCcBLYwc4bhGSq0TFJrBiBZSwgeip2N20+fwbUg7FA8J8aa6l
 KYABSL2AkC29Aep54b2vqQBNTpQA2CX4h2mxSxAz2inN6zg+zLWlop+/wO97cQwJ
X-Gm-Gg: AYBFou1/387j6ou1KSWCGtg98XNfLSHX1y98gme3aUUixlluAQV7Q/fwqxySH0BpaHX
 /iNo+1RBdLYSimDFL+aXT4OheU9mGo0RLsTBUs3KaLX8AMd2G6aaAh6X/fUG4GbPqBNbvJrM50W
 BhX9ej+coe0ICjG92gH2tcmZ5ZfCtOWStRVZ/Hi+8SKSVdZdyI6+JCRBLkCiISE8QNCRJDHb0E+
 cMJdKYR2nuU6znlGc3SMzDPSvi5hS8LvzbfI8IqnsDPrl2X1+bc7WSlk3Accb2HI4lXtZ9T53qc
 UWr/EGvcXS2Sz1WqFkcdrCf6/NmQe7VaNed8HkLlOwu55xlD8LOX63fly+zG6StvqMeyO7LD6+b
 wdMzH63YeR04cTxlX7xxArKhnPY/1Mfsb+QQafTOdqgK5bGolEnmCNTpBriaeEzoRK/r1dhqJ/i
 BS0+CzPyHA+7Bv22+1IbghnU6mG6iObKHZlGreiwgZJN4krjbKa2DHmNB6IWgqwBqNKjAmtf0Pf
 9LhZAqDter8H0wGaCrFCt23ZAnmnp3niV3k3pWRo8HOMPa/13Fu9R6Ai7Sg5mbd4HksxjvxpSGZ
 nx/6bDjMsAuuZ5SHbKvX3P/Avmy/x2/7UvXQXSPAvcf/uvedj4J2ugj8zQ==
X-Received: by 2002:a05:690e:1916:b0:677:c18f:7257 with SMTP id
 956f58d0204a3-67ba4e95baemr11176807d50.23.1793724611789; 
 Tue, 03 Nov 2026 08:50:11 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:11 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 5/7] fs: jffs2: retain the selected raw dirent when listing
Date: Tue,  3 Nov 2026 13:49:51 -0300
Message-ID: <c59bd687a3980090f1c50240728ff8f11fa30144.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Retain the latest raw dirent instead of copying its header into the
previous node. This avoids writing to memory-mapped flash and keeps the
selected name and metadata in the same node.

Release the previous node when replacing it, or the next node when it
does not match.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index fe44271b270..0021697c907 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -1019,10 +1019,11 @@ jffs2_1pass_list_inodes(struct b_lists * pL, u32 pino)
 				if (match) {
 					/* Use next. It is more recent */
 					b = next;
-					/* Update buffer with the new info */
-					*jDir = *jDirNext;
+					put_fl_mem(jDir, pL->readbuf);
+					jDir = jDirNext;
+				} else {
+					put_fl_mem(jDirNext, NULL);
 				}
-				put_fl_mem(jDirNext, NULL);
 			} while (match);
 #endif
 			if (jDir->ino == 0) {
-- 
2.43.0

