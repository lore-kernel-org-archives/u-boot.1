Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E1606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EKWsj/4w;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2OlKVyf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E59D80E34;
	Tue,  3 Nov 2026 16:50:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wdeRCpu5hG75; Tue,  3 Nov 2026 16:50:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6317C80F6B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724622;
	b=GUZspW9Hg6m8LVls+HFqB5kr69NhCFCuFHaJSKZsMySWXI2ObNUiIgWbakUmOhLoKNdw
	 Gwsk/+DeQZj7qxtsdo+qBC6WjjNZ5c3ABe30bIzIfZ0ZKE+FVKZ+DLODEXDvZ+cnIFh5Q
	 aOhwJhMs+U0W4TfvsIgcYTHjH3Ck9DS0fXYcVM8XW5a2Ibd2awC+4puQQAfELmChumpD9
	 qzn/PNtwrYd3Id9bXtVuuLFbwfmaKMAjTt49Ec9Sh9krteHUHjjV4iu3BAeJZnVRkOxOR
	 AlOSM0uN/p2jp6TP+OgciZNGIDFd1pOJCcMxU6H0gNsyXpuCLuvrnZymK6MaBibtCMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724622;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mZ7bAJOfoGuG454c196K89OudjiGOeOfxkCt97hUjtQ=;
	b=RnJLGP7bu7yDwpGUrEepxEg9nxTEO8lmbE0bkf3K3n0U2KkdNSZtBG+Fg1JtdqCc3J1X
	 rDsLpIr9NviScKTwWkWp+rISUTR00u8hdMS7YfLWDe1PGmBHAoz2+adaz/vacn/kHdLO1
	 HMBGBgQkQWbMtTwe5DQI75UyKnLuWZnjV8pu+J92iXMuLv3Tu6FR4qGKbSDCBVmkGNvlB
	 gf6lsnIEBrYs6BECvP1CsUtsqoUdMDYkwmxx0Fv48BaR26dVxfr7MMnwLABvOu98nYZsi
	 7Xn2h3BzEPUzfqNABPLt8J4wJDxq1iccmxxKjzgEOESRBcAVMD8u14/D3F4rk9L0EjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724622;
	bh=mZ7bAJOfoGuG454c196K89OudjiGOeOfxkCt97hUjtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKWsj/4w9pxs0+yZYZTsaq/7uynhUpyMehvSTWG+rpZOBTElxegSRUImlfb3jMuMZ
	 o0uBUSXjIx31APgz8V4/BM6KUO15IOtG6PI9aR5a9YIQN9ASlZciYkRS36OpU8cln7
	 h5AmpcAtV29y+m67x8IB13zKQKbBR1aro5+WCvo+wQWhXUEELvZs2S2M7VYTKj8EPE
	 cc4uaIUEiJ6pZwvDxhgGwjMOIA9WlNQvr2mMJV1QbTQHjzUZov93QEs1xQJ/1M8D1K
	 eSyxIhge0XV6WXTgDzkkpqc/d+NEuP7YyzTZ+HiHY0eXDE81DOhuTAArrBykZfvSjx
	 LXwMeXHsC9Bxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6317C80F6B;
	Tue,  3 Nov 2026 16:50:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38CD8235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19DD940726
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqe_jBEUbI77 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3738F4066A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724619;
 b=HqARIvRxlrC+0C19tmIgR//7Qm925e9WPiAjjcvLRLPsu+hLJktSD1Jt3H4ML9MLnNv4
 L66h8IA0yqhDK0TsKrvdQ05JG/swinBxf0jEpwMkIX42o006ljaG54YgNvJixCSR91UqW
 cBTVgB8Bk7L3vcawZ6xZRh70jojL3qTWtgC2ixfJHWOumC75KDWyetC4u0wTuQbaS4S1f
 fJ8j/foljZRr8MMHjqILl7Lb/CkcpiWSkyrKz15EZ6O7JBh65DB7Doxm/rkh4JyxtHKcg
 19SYFXK5Z9yfWrzfdXvbq/1cP6uBiwUpE0gVoJfNvM4CVLFrS7NE8NIsVN3+SuCsTVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724619;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=mZ7bAJOfoGuG454c196K89OudjiGOeOfxkCt97hUjtQ=;
 b=Gf0A6N5Plngmp7dSzuKeKwS0VUF95j7LRsfzMb817iAjt/pobu/wufMXrC8cEZT6ucI2
 cRt8vrqr80aa5SNb9Hvpleo+gai8aol/SNQ5/yaXDhr2+4EI2uY/UYrbFwTxbn8C4bgz6
 44UJ7c792E+6ovcpbqGwPpCKWoSDB79bPH8+bfr7Nontz97bZxwR/PK+5qGc3bgGOG/uh
 enB9D5hFJmEKOlkPtAmAvnytl2ltSCJrvQ+2JOIo2vHPxQ4Jji6ild+MSouWmx+FUxm/3
 yEc1LjUFFptIpbp/Ti1uthvgh7LHCFx0yury4R5if7pf7yEmDJSOOcKC3YQwhHitTOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=m2OlKVyf; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=m2OlKVyf
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3738F4066A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949CD8482A; Tue,  3 Nov 2026 17:50:17 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3678482B
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67a2bd0c297so3727797d50.2
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724609; x=1794329409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZ7bAJOfoGuG454c196K89OudjiGOeOfxkCt97hUjtQ=;
 b=m2OlKVyfRyJCrBKX1eMoSGBwgH/1pC0X+e2XHQVEK9lAasszhKxAR7Rn2L0fg6Vdhi
 8dPqbpl61wN2ZgMgunT9SYgLw3ptbtsnKlsP/2ozDdi+ih2qN1CRmEr3WUFE3ewLdhEZ
 mxz4CiwnjHCZS7dnJtVWasHARuhruW81JxLTLo4TR5zKCoEIS4jW0MaqSUFQymaSKm8O
 axdzQKxvkmyd4zBECsynxewCexSZl9IKK/vipLOY6b82o1J+xL/4Dfb/aZsx78NSlSgG
 7iRd7wtyT0TmQtlFWloAk2yX6KoGFSCtgA6BNZ4g1a5+oTWyOndVjUHidNBI6fnwZQWK
 n9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724609; x=1794329409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZ7bAJOfoGuG454c196K89OudjiGOeOfxkCt97hUjtQ=;
 b=KeDJT7qN5e9LgKq48V9BesmhFyNSUVBb3DgGCnkvsGt91ZHHHbb267947OoEK62Y7v
 +CX9JWGiMbmS83B+BbTQF2DzTX4F6hzOinuOWgFujDbSDReS3QXrcjmYzNeiT6E31B9T
 CFToK3Zi2PfQOhomWDjnu8hUzT/2SSbb2OBqnMZeKxWkKl7x8XCOvjSQBK7gC78eO3xF
 BtIjcg08wAyko8I8afybKiPklD5fdlGlO+8lv7lOxb0IN5jGQfQgkK+I6uPZBYgTGE01
 Jyw7Y73E21Oexc5oku5n8lhATRmvCyFHuSfjC9R7bOwz7Z0JvhCkm/3ClzMwP7YnMxXr
 8XHg==
X-Gm-Message-State: APuU4Z+D6BbueIkYthnrmbA+5vzTHbxd1KAWSOzfXnjXdLD5l2SjPjxW
 GZb4UE2LD8dMf2R1UgRRa4BieU3eovq8e4B0VnY+U7t1OdI3H0b6MnTTgjltSTC5
X-Gm-Gg: AYBFou3M4bX6d25NmJu6E56ysf5MCPzMHEGq4ZAHgZUL29Qg3UmrCOt8aslc8BW8x1h
 UA1qWwkYbUplQzJfkepa1K5181ouSFewJub7xx88P75QdDB6NxL4wT0dxeBE+3wwDxkyeUOYfm0
 OsrFWkG4yy9yY2bPjVHctucp15I7XEr/Xp9iZHfOytLEhoqRSBKl/FVro8MaVe6V/wgWQ6U3Jz/
 TqJXq/OYMHeJiAxdYaaNupcLRossgecZ5Zy+qiaq5PxBkHuHj6WroX+x45ixdBxaYNmYRtr16to
 vqf5AtRtoMv/5Wnt9ChblWBQ5PwsBFub7j0DIS8nGO3r+YZbHIpUOONwhiXGmncQhXAq/RkfLpZ
 O/hCa0BWc9ZFEK+icH1fr548t0WHHfhpPdWX/P9HYY43sTUknm6bVYSaaHbry8WlUPUklnrHfP0
 t3S282T4ojGGnMlh8azQerRdrEPB537tbUNL+CtLhkkyKPvB+ebbpSLbhjh92cPF9M4sfuE1db+
 WxAbvUivO4nzZ9M+1mf96CBTJG03u7rUYjEMHYeImoKJzpW4a8f0iJxns9xNXEtHwiV7xLGOBvQ
 koYbtgK85r4PELAUN+m2EQJsMJ1ZGOMR/Ndz25uT3ceiuSu1uqDb+PjzoA==
X-Received: by 2002:a05:690e:4810:b0:67a:557c:d8e8 with SMTP id
 956f58d0204a3-67ba506dfe8mr6925791d50.71.1793724609230; 
 Tue, 03 Nov 2026 08:50:09 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:08 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 4/7] fs: jffs2: release dirents on comparison read errors
Date: Tue,  3 Nov 2026 13:49:50 -0300
Message-ID: <93a2122c2f1481bae2b35ca844bce5980a7c30c0.1793724561.git.wpopov@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Release the other raw dirent before returning when one comparison read
fails, avoiding leaks during sorting. Handle failure to read both nodes
without attempting to release a missing node.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index f32846442d9..fe44271b270 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -607,11 +607,14 @@ static int compare_dirents(struct b_node *new, struct b_node *old)
 	if(!jNew) {
 		printf("%s: failed to get new record memory at offset 0x%08x\n",
 		       __func__, (u32)new->offset);
+		if(jOld)
+			put_fl_mem(jOld, NULL);
 		return 0;
 	}
 	if(!jOld) {
 		printf("%s: failed to get old record memory at offset 0x%08x\n",
 		       __func__, (u32)old->offset);
+		put_fl_mem(jNew, NULL);
 		return 1;
 	}
 
-- 
2.43.0

