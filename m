Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB421606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PHFn7mM+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=vky6ENmk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BA6D405D2;
	Tue, 27 Oct 2026 23:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LEvKGoQVlAXp; Tue, 27 Oct 2026 23:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27EBC405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793142968;
	b=DVywTK4tKT34TSWPHlV1WTw/bEj0p37q8hq7iLLQ8SodgVhrjjqYiiI8YDVoSk9ZdTPU
	 GXwXnA7+q/QeMsRgSn0qrVBtI83G3lnZdEzijbB5DTLA2WXtweku0lq6q60PzJJ/NXVoZ
	 nLa/poxZsS32qMRgXMZQjCV7ki62rsU4Bd6TZSkxRMKxitH4nJJaF/oLakvLiiHVGrDq/
	 8tzVQ/Us/k+5wwXOBxSqCW7j9Bmw/t9X55JlFxt5U3Ax/MUNDyrc+vEryYZu5XAZWX9US
	 nq2BwDOgRxW7n6z2h+ImU2JvjapWC1Gw+qnPLPw653XeLmkphTmY9UMa6y2nIi/+OSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793142968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bGQ9pB/vz5LNtZmeD+2BPfUAA/mbbXI/zJGw9XGcL3g=;
	b=d/VHkQXwvQjnTVyMeFUqe6y+OLvpZywsH5kbroVyM6lozCJNW26MecSDRlfLFEvltdsu
	 d1XM5GJUuSV3PG8PLzhHV37+QTEU7P1tJhk9ugy9+kBlDFwy/FHTCvG6UU4cFg8REPJW2
	 I52pLwLLjhxFXDEtZx5fEJ1JOUvrPsQpMttxabEAyLpsgCG5T+33mRXeS5SiGgirFcFXM
	 TJJux/pxcXl1h/5h09yNfkLVI8W5a7s5m8mCX3TBJnAOCvI1nae3WZ5sShN1oFqiqe/2g
	 JO0yk8yxA1cRrKBLfmv6cwp5hsQTheo2vjqve/ZTJxUFi/xMCM/cnJSDtVRSmxpvfHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793142968;
	bh=bGQ9pB/vz5LNtZmeD+2BPfUAA/mbbXI/zJGw9XGcL3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PHFn7mM+P9YVTndvBzA3N2i7Ec/ls6+p2sRxs8SnCgcMuAmG/mbRj5q6UJ1fI6h47
	 wWztcVcVWNzL4D7f5+t+uLOB8hRR8HR0I5HsGF3MMJY4AJ/N+DohUUKf4UWyYUowZD
	 CQCfhrBivV6t6iLqSrWTOHIXC1Xr43AehRyekDtSCFoHnykbNxmk9qIdKRyFfGFFLU
	 j7f1nlglkHc6TsSLA0WYoh3qlT9AxOwFcCHiPd1RQMz0dImm2U7/I9SsBvGEm/Lu5+
	 yoxhRQQv55LIoJjXFxcGbwmPkhZ3hCUf7GGdysM8zng4JjpEhAozn9uCJrYP7ZDm1/
	 QSRpoEee8D7ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27EBC405A6;
	Tue, 27 Oct 2026 23:16:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B24CFD1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A42E0401C7
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BmN-6qEa11a7 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 23:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 96F4E4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793142961;
 b=QgkK1f3u9uQhXwH5q+c+YNr9fiFodWBRBRlZdkAxLNNunjGxsgmzG2br1ZMjPUcfyQzd
 fGynC7cq0oqz0GaWpipsTMmaRyVe+4/4Me5fbv+CkOdpUlEsiP6ekEOmwQScqtWKsiZhL
 dyLkF7BWFikLOMESI9QxRbx6exWQDnO1bZWJq5Yv0/BKXG1uYz0QvcZbs60hrbjxubA0A
 DGrrqYRK6YTMHvKT5kk8jjPdOTNZF0OfMqs2qrWfmge+SfYBKdeioSrKpGbYOGP2DhHuQ
 R3dlcY/mdbFvLjOIB51/o95vK0dcVlhMfZuP+Ae/S5jgKpw/dQ//3c+HqKCvG2Ahf5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793142961;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=bGQ9pB/vz5LNtZmeD+2BPfUAA/mbbXI/zJGw9XGcL3g=;
 b=EnmLPZ8eZQ5q6tafLQa90SxhDF5SObezOG8sQ2nO/ShR/VqN+7EcHUpcGolmxzG8Ivfk
 vACBJ19qlioOWVQipFqhFOqSL91toMCGuJuGIbRp3ge73+J2r1F1pP3FCI9Z8A1Owwz0X
 QTUBy4/tgYVnIBoA3f1S1q7aMrvp9jv16z/zrq5pNPGeGRmRHVHrJ+3Ha7rAa20BvyYnq
 PJq2zQkMJ8wT4CV7nVnUHc7u6gJeYKPR5mMZFEMjG8/chpMIxyIn4SDapsX4eH2iT6zMF
 8RG+OwGD+TeCkIvm0h/agsz2L58ZnfKAv92tG9W+sUjA5qY9BgAk4bxpeYHNLUWAa/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vky6ENmk; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vky6ENmk
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96F4E4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 23:16:01 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jDmZP597dzMlVb;
 Wed, 28 Oct 2026 00:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793142957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGQ9pB/vz5LNtZmeD+2BPfUAA/mbbXI/zJGw9XGcL3g=;
 b=vky6ENmkvUWN46aFbAuv/E/qorn5FTQHpSIty7V3dIyDzaYcGpWI7qiWNHQgvKEXIam+hY
 9Y2l7Xch8QS8A4VgumkrFSojV9ghwUOSx3343N4BXHWVbFwO9caSARPr+LO1rmlWf+1VMf
 8qPzDAKUGYMitxzV7gRnLyfee+JC2U69KQ65GkAH5GUNCY5ToaLxEWfkyFKeEO0VU8Zr0b
 zlxdDxcFjTFpVAr2qNKc4cBPrXUf8M5ggBTlsdZENwxoW7zZomqTedXTglNLZhHJUxs1na
 bgDXnp4m1t5krTNKDs7d/2hDKgHRhG+8e0Q1zl7O9Zrc5OAaUiEZXwHLpm0ILg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] tools: mkimage: Fix discarded const qualifier warning
Date: Wed, 28 Oct 2026 00:15:28 +0100
Message-ID: <20261027231552.60390-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
References: <20261027231552.60390-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pk1nncfhumz6y5fpeo5898m4muktdjtz
X-MBO-RS-ID: f09b997ce719adccc86
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
V2: Add RB from Simon
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4b6c16ed403..a55eba39d13 100644
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

