Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76149606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GBQ8p5hz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vCINCrbx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47C0840921;
	Fri, 13 Nov 2026 15:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCE8eDMyA-z5; Fri, 13 Nov 2026 15:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B291408F8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582497;
	b=nem/e4Q+rWbGx94W9tMhIguzySGdSSImm6YPXCrW5XJYMxfvXuMoDYQD3uBTVTRqsem3
	 rvgGFQchtNOhORA1xQlgweQT+5ghAcrE3JxnMTne9z2Audvvtq/ei15Tv8Pd4Ihiq3wdt
	 PzlWwQ4r8on3/myaaOaJCRbfkcROc0nKBfh2yIh3Ss0nActGAXJrBYSofYgv0pgnrfwJM
	 mCgFbzji6j4phmmWJ//m0yDwbxFRgCzo3dmRDZbr8SaxgbSOwmdWfNbvpxRvXGCTu1/g5
	 hU6bvIcTRNNO0zetXEjeJ6PaWF8wRq/6vpdVGSUcekMb9/UIcag/UTUMxgJx6PxtFIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KV2xDPSug3Kg8h6WLJfdNRxqpkh7o5/R+jm9E3WcaVc=;
	b=oUdW5KPz4buYEvEzgLZmF+ccCjkRLTR/PsN7bEeye3WhIjsDifCyYbnkff1yGzc5DCq1
	 adsL0UZR+wI8nqW+VHG6VKmlI/sKCrYSGo2vwR9lF9tHxS3N6kG88OQtYs5NHDQoZbEJ1
	 g0hJuXytO0YX03N9l/WTTqvMPM5nLBJLHo3s5jpea1FH2QRg9vn8qv4y4r9Y26/YNbWaI
	 7HY05FYAiImYOAoSFln6+cW9nI1QrV1LtwsoYjbUURahJbL8pVcDDtNnJYguWG4kMGoIs
	 qieqYKk8UL8xZeH5JV6fk9eivAI0UIKPzy5NLB7tOT5oO1jHmDmfhlCmOt3BCZB5nJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vCINCrbx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582497;
	bh=KV2xDPSug3Kg8h6WLJfdNRxqpkh7o5/R+jm9E3WcaVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBQ8p5hzqDpmGaEjqPBFe9flSuQtuLM4m8Jz2AM3avHSV2GLWdMUR2gN9OksZp064
	 4dZCOfYag4ijajJriV8CAHgeGuW1iq4YBga2Co2SN3NmRq028QQO6316Kj/fhTTduo
	 uF5Tr9pHidl/875A6f/7s0csiH+eV+t8DF0jWxSw70y/lw3j0D/py0mMr2n5BCAE7g
	 SYuPRUCX5qrtU1Rr4hSxIJy+dIugYvqmyp0XfbNbqPqi0HxhQJSvAmd4VhIJHPRydT
	 F5FfbFXUHvZO4UMp4tNI9zxHeCvhZjihR7AZaKsQfq7Mfh8RNFfdUqntaGt0IRo6ZS
	 rQkJywgo3AIew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B291408F8;
	Fri, 13 Nov 2026 15:08:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D4081790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A0A14087E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMkc3T9yEHV6 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A702F408F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=vCINCrbx
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A702F408F8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88D92152B;
 Fri, 13 Nov 2026 07:08:08 -0800 (PST)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41263F85F;
 Fri, 13 Nov 2026 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794582491; bh=09eLxTHFsqontGhEjxGhng7q6T9+MsgkckszN+WZVz8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vCINCrbxqZcFp2uhghbSxuPmQ1s/gTOYhTaRwMBKlaR3MzxQlobyb09vytuHQNZsx
 a9yItW0vT6tA2aAcRCnWy+pXsoG+NOV/a7wDxNs+Rz6qxsMl3vxj6XTZ2j0kzklTh3
 xeZGbPd07JtLFSGMPTy25Tf6I3+x/WkMwdnjWv9o=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 13 Nov 2026 16:07:57 +0100
Subject: [PATCH 2/2] efi_selftest: verify get_variable() never returns
 append_write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-append-v1-2-4cb63d522562@arm.com>
References: <20261113-append-v1-0-4cb63d522562@arm.com>
In-Reply-To: <20261113-append-v1-0-4cb63d522562@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=09eLxTHFsqontGhEjxGhng7q6T9+MsgkckszN+WZVz8=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq9yfYy0YrgMG3Q0XDqkpv4ZSBeHTOIrCyFr531
 M3Eh2UBfI2JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCavcn2AAKCRDLSfhWdqMG
 lM12CADENcGi1tX9xc8Y+cl/E+Vmp75cAsTctq1paovj/o4hl+a83uAMPgn/1B4tcVXgDIVZwVm
 wK2edOiisNwAdGjp8WkCOgqLM25IiuM8ftvoYEzRlm9TmV47J32bkfprXdGx4Vg1NmLLNoUz6N/
 jmJD+Z0seJVRg/2+hteqxC1kll1dLzCFPfBYKUDDo+OCX/2vpJj4kCqwAk8xn/2PRm2Nrx33TQB
 Ro+Vx1t4PjX0+lp2MMik35g93UtQqM6eBak4CS8x1qoY1xRrQGgZ7ILepJGXqBmSOAi5ptuvJId
 Lv1mAtFfLkRvPOYUJu3z1JynHPU7ymNE/SLf+crDo9wczoCE
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Verify that EFI_VARIABLE_APPEND_WRITE is never set in the Attributes
bitmask returned by GetVariable() when it succeeds.

This can be run on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest variables; bootefi selftest'

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_variables.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
index 976eee8dcef..35d6387009d 100644
--- a/lib/efi_selftest/efi_selftest_variables.c
+++ b/lib/efi_selftest/efi_selftest_variables.c
@@ -65,6 +65,10 @@ static int execute(void)
 		efi_st_error("GetVariable wrote past the end of the buffer\n");
 		return EFI_ST_FAILURE;
 	}
+	if (attr & EFI_VARIABLE_APPEND_WRITE) {
+		efi_st_error("APPEND_WRITE in returned attributes\n");
+		return EFI_ST_FAILURE;
+	}
 	/* Set variable 1 */
 	ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
 				       EFI_VARIABLE_BOOTSERVICE_ACCESS, 8, v);
@@ -88,6 +92,10 @@ static int execute(void)
 		efi_st_error("GetVariable returned wrong value\n");
 		return EFI_ST_FAILURE;
 	}
+	if (attr & EFI_VARIABLE_APPEND_WRITE) {
+		efi_st_error("APPEND_WRITE in returned attributes\n");
+		return EFI_ST_FAILURE;
+	}
 	/* Append variable 1 */
 	ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
 				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
@@ -109,7 +117,10 @@ static int execute(void)
 			    (unsigned int)len);
 	if (memcmp(data, v, len))
 		efi_st_todo("GetVariable returned wrong value\n");
-
+	if (attr & EFI_VARIABLE_APPEND_WRITE) {
+		efi_st_error("APPEND_WRITE in returned attributes\n");
+		return EFI_ST_FAILURE;
+	}
 	/* Append variable 2, write to non-existent variable with datasize=0 */
 	ret = st_runtime->set_variable(u"efi_none", &guid_vendor1,
 				       EFI_VARIABLE_BOOTSERVICE_ACCESS |
@@ -149,6 +160,10 @@ static int execute(void)
 			    (unsigned int)len);
 	if (memcmp(data, v, len))
 		efi_st_todo("GetVariable returned wrong value\n");
+	if (attr & EFI_VARIABLE_APPEND_WRITE) {
+		efi_st_error("APPEND_WRITE in returned attributes\n");
+		return EFI_ST_FAILURE;
+	}
 	/* Delete variable efi_none */
 	ret = st_runtime->set_variable(u"efi_none", &guid_vendor1, 0, 0, NULL);
 	if (ret != EFI_SUCCESS) {

-- 
2.53.0

