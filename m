Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F06FCA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C3E8156B;
	Fri,  9 Oct 2026 22:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2bADuGSm3FG; Fri,  9 Oct 2026 22:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 794E1814DE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583966;
	b=cPO+FHA3UyEcrYCUXUhgSlDLXgB4FHyrm49f1nCXt4WAtNPk7HAFciBDDEdnlcKrdYql
	 1e+L0Tqu6SICsb0zv/Hd2NqnCiRBm5oQidmMHV3y0icuPNE0BnMh9S0hjsqiXlsMkLVRF
	 6Hz2sfgtSavSJg+dPg+2cJKqNMoaPXSp6meS1ukmD70RyqGw8PBxMdA4oftRznK39eq27
	 5PGnlX22HCAipmDVHywQlT6OOChLwGepDLwMg8nKm5c+ykmltYkYZnPukL+8LXZDa7rdM
	 xOyocLgyMm0pQ3J5xgs4m433Zbkhbu1c7Cq7Nj6Fis1s0RoJ/xvs25Mm33XGmG2ASqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	b=RFBSSZY3PVWZJnauuZLIqKgV+ALn5CODx3AuCZLnRNPvHHPcz/b6NxPAgaGFlHs91XiJ
	 fU4xc0W2GyZRveTgC9yShWbAbih4MajS4Zzkhw1N/COEsULfNmNyxAJnkQMSZd8Iwo9mi
	 RUGPTyXbVjMlpPpp5/O3XVVRqK3eLgsU8hFRwdHFloKzNe3Pfcd/b4OSkMOKMVi3a84w7
	 TH8U1zB42o6YJulPKXKbuWlRO8SLZAGSZRa+VUlB/798rWWJ7fwLmV31bPVnnkh+7Qrrx
	 jAiKFtx/TFA6NHkunqbd+JsAor6CO6RSmoMY0TZSacWFyVr1yq4nqewWY3QcuyvvCfw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=qdesp+pI;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=84oFqjL7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583966;
	bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cehhzlILWLCjrT3Dv7Kcf0NPiqx/M3e5PrNUwWXw67BhqwavOcwqWEYimPfh+hv6v
	 tgFFvzapmD03RZjC1b3sC3+p5AKy+A47BFej9eAOxehyc+XxlX9LJJusKPk6QIWolA
	 K/TQmQQzv3xd4nn0LKEzhX+qD+QbUlVkrZ9lfh2yCWq5WPHWD55BYakzT+VBsA5rPP
	 VcZHYX2bjMtgnBpSUxYt3cfrneniXfEruKvUt3cMDBufxnw4qJd2Iul+fRvLYDUDUE
	 V1XHMwNkf6YEryRDtl8iteyRSbkvrHPgvuU4pjQQA0EEjfva4/+AWR+dOeNYxh6IjE
	 xUt1XQUZxNc+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 794E1814DE;
	Fri,  9 Oct 2026 22:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 8CD3130F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 7B8408123E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 9ZY93INPgfsR for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 75E54812F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583838;
 b=TfwUVkK/cyzKQExJcm3axwmuy3DqTt1mWl4nr7Av4Z6eLgwR9bwwXede5UHAViU1g+bV
 ojAjVladszDFoJnwAQQRfPX5Z3z/upUIEWLFmXyfH9xclO0WSdNpi3W/+yBptrKfaPbRS
 OYQxD5IFvcc9+f7c0pG5j+goltxgzoJOnHJsU5G7SnKxutNldgQkqAffifPVJlKxV1iRq
 TP9nqKTop3SrwPdzipXMqfKDQdFCu8AxCdHQvVh19JSTf5701/jePnK5Ijhnck8Zmfm1E
 5DstIutbc1Cih5k1qhaDkb5BRSPrDrVNqRcCvCqqIn4VN2EV1SVA6fAF2a2I+5gvZEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583838;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SbR4HZzcOpaPhXXHbxl12J9ufGWqLO1Nzx3Dd03bpSE=;
 b=ATSgPZkCAyD6zej9T86k93YPmY80whnOA37ngZeB9ugV0RDwMWZxTbN+DAr+jVQevNjv
 hh+uGiOPjiYb5+lJhsr//8k4Z8Z7v9YlGixmNP5UnWzIHp9Wj68SgqHP6/s/cXzMHdlwI
 Vc3j1910hVhqSGRznqmvpxTGwKAKmMu4MXBsDejLAezMGI2x5TctNDU4qAmYU1KrD2iai
 ZAAV9BuwRbJcWz0f54xhM8wCXoFFKlP8HBQgO8EYQrB3bxeB65wsrM2B1wD/bCgjZOZkX
 HbHaI7ObACQT1ROKtBj6phtATF65HOd1/C6ii1fJZRf/o99Q9txSZY1gUthOzx6wNhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=qdesp+pI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=84oFqjL7; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=qdesp+pI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=84oFqjL7
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 75E54812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583828; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=qdesp+pI6xdAgb9tZ1Lz+ThRF/7uR/unM8gpnNgxdeTJDyg6w+
 HgqzMNgf3JEB4VyDUPfK1/De5YGqmIiNV+csrl1CQSjsHWjiOmqiYUlXZCSFpcCEV8yvrsZ2vuA
 r14k8LtUS1Xb6iC+Zn4wZtxkF8GFuz27pyxvzpaxR37zgMrX8igRVupzIoKeCjSB6WcFr61NmBw
 jnTjkCkBYlk1TTJkLHa6qvcV0f2+S9CxVj/6VPFCyUDaF+ajXEpQQvq6xkBJtrN3DfB2gYNfZ1g
 NxTI56VONShW7FQMZwavGMJhA8TWOaX6cZOlrO7rPuUJ1/pT23ZtQI43yT3sGlVk0zg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583828; bh=SbR4HZzcOpaPhXXHbxl12J9
 ufGWqLO1Nzx3Dd03bpSE=; b=84oFqjL7XkmWFofHkdJ5P3c0Ovo+Y2WQJ/Sp+jXIfmqtxAQ7ab
 o26HZbJTSYzjjmIM0LkinW2ySXb2nMI9TlDw==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 26/26] MAINTAINERS: powerpc: Add me as PowerPC maintainer
Date: Fri,  9 Oct 2026 22:10:16 +0000
Message-ID: <20261009221017.20385-27-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:54 +0000
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

