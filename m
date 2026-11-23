Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D394606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tttcApoS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7V9oMWz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FC0980E5D;
	Mon, 23 Nov 2026 21:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZuSAoTuszHy; Mon, 23 Nov 2026 21:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5CE2780E9D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795468669;
	b=ZU4omFt8Ms/Nzkfv+XsuxA4x+htPf/PnreSpsmqSRkypcRD6/TrB9ZPkcWepJrgezNI5
	 TPqs+YjEz+OFUpyDvaUCb8Uq/d9rIrLGt++jAgtcywgqMRoijwuKx9vIInc9hXSNdY+Hd
	 DYWqvyw7lXgxY4guXhbzYuZSVRV/6eg509ZfHJ+bpUzZSfXz4eUSwKQZin6BxuJBPHERc
	 M11NtGmuxWnqSANA3x6qUSaZkZOGiuvjeGmM7oMrM6BJs7TrFUtl/bl4dil5mpPFuxIAl
	 r10EaSGOTuNRpzpjRGhUeIcl9qhUwR3DzOckAMFyh5/sp20E6Du+7lrzPkvQKSnyadQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795468669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DYNtcOCFu1JsOnpzvKoh5+zDJWLnXmSeFbR+yRm1FO0=;
	b=mb6rQ3mxu927dcOZM1P+2U4nzX5AQ4TyLh6EtU6riLo++LLXBauA1Oa7zSnHGeqK2raa
	 z+cLRXTZPAUVsnn6v1DNoSWkm4qfbYO+Tj9n6TyG9AnXOB8kljoLjR5/VZ8kO1zKA0/Dk
	 r1xiJEYYpf8elM0fCQFrpIMZutQUHumODtF91AcOk3O4Zz+s0vno2U6e4Q4+cajTbe6ga
	 /KS0dQ/SUOkZFx97KKP2f7d4U6mlGASoF5yiv1xVxsMJNnbSACO+3DLOm+4Tfcqhhj5gw
	 yiRDQwUPI/2v8PPC5qlFD58Zo237+thoFvvOHRmm7LvueulK73zWIEzICK4UzlTdrhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7V9oMWz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795468669;
	bh=DYNtcOCFu1JsOnpzvKoh5+zDJWLnXmSeFbR+yRm1FO0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tttcApoSXnwCwr8m+OMhCBv/1yizDFQgk6XJSwjZfGth6hc9/cpKqeAExAkGaTdrh
	 fCqrywleqxTKb4A32EHiXepIl2C9AUOIv4re4Sqmq7BbiiK1iGJ534B9r2uoyWcdav
	 tQhyQ5g5htfosdubPeOBW6glEYbQuG/2POPXvVbOXPXNCvcUlBKlws5liMF9ryaxsI
	 QbBGIBSDbltZOqgRLL6Q4VduHPiQ9bWiwGrzjVfP35HSiemkl4ZTbrgkhrQK4UoVLB
	 LFQVH6uEuS2QvLBxDi5sBERF8GM6Mmg1ZOLcE9CnAghkUcO6r2byX55nOA5p+/9ddj
	 IIxReFSM8qFtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CE2780E9D;
	Mon, 23 Nov 2026 21:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAFC0311
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D08A880E9D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vga3UOzu19CL for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 21:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E7F680E5D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=F7V9oMWz
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E7F680E5D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:17:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BBD7602CA;
 Mon, 23 Nov 2026 21:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57141F00A19;
 Mon, 23 Nov 2026 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795468664;
 bh=DYNtcOCFu1JsOnpzvKoh5+zDJWLnXmSeFbR+yRm1FO0=;
 h=From:Date:Subject:To:Cc;
 b=F7V9oMWzZV+WjQc8ZX1vyeLSYD3e5zK2yAf/RoeqIyc6DNJ9aPZDV1OkiERNsAA+m
 rm/ZaVriOTmdSzOy9vpIFnc82uWd6a1YZdyWuR4PDdv9hoaMhqbB/HX+ebhmmGm/ct
 M0k533BhhkQNVRfA+EjrHM1luP1AvcNBSAQKVcI99clF+7+ANTOXigxJTzGjNDQmiV
 m0Jy+CVniiauCha6WupqeivbX5YT10svWjr+ooaUEfLlnsnZlaPWzp6m4kFkAvZutn
 NqMTdZ2iakemHfM0z227LRhmhNNBsRzWCwxLBXJkKz6hGGH/RiF1gTHKpl7jF82gPD
 CcFgpGqE0VkCQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 22:17:42 +0100
Subject: [PATCH] arm: stemmy: Recognize legacy Janice and Codina machine
 IDs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-ux500-secondary-bootloader-ids-v1-1-a90bd12873cb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQrCMAwA0KuUfC/QVB20VxE/aptpQBpJVCZjd
 xd8F3gbOJuwQwkbGH/ERQeUQFOAdq/jxigdSoAU00yUDvheTzGic9PRq33xqvp6aO1sKN2Rjsv
 cc2w5E8EU4Gm8yPoPzpd9/wFOiiCecAAAAA==
X-Change-ID: 20261123-ux500-secondary-bootloader-ids-14f6d90c9911
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The stock Samsung secondary bootloader on Janice
passes machine ID 3294, Codina has similarly ID 3297.

Some of the secondary IDs are already supported but apparently
I missed some.

Fixes: 5d50adae908d ("arm: u8500: Package Stemmy device trees in FIT")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 board/ste/stemmy/stemmy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 8526deeb29bc..49b92ce632fe 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -70,6 +70,7 @@ int board_fit_config_name_match(const char *name)
 	const char *dt_name;
 
 	switch (fw_mach) {
+	case 3294:
 	case 5000:
 		dt_name = "ste-ux500-samsung-janice";
 		break;
@@ -77,6 +78,7 @@ int board_fit_config_name_match(const char *name)
 	case 5002:
 		dt_name = "ste-ux500-samsung-gavini";
 		break;
+	case 3297:
 	case 5003:
 		switch (fw_board_id_get()) {
 		case 0x101:

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261123-ux500-secondary-bootloader-ids-14f6d90c9911

Best regards,
--  
Linus Walleij <linusw@kernel.org>

