Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D6606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g7Y3/FBm;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=QOw5jGSO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61F04813F5;
	Sat,  7 Nov 2026 05:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kv5bao4dkN5J; Sat,  7 Nov 2026 05:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56D6381324
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794030353;
	b=ig1dg0CPZD5lvodan2WmuZwuFRTBMbrQKEJUAX1rljyLGn+Si5trarMkSvYo3a0ZPWLR
	 sQdJ2pSh7yUQBf+Th+QM2IXiSh9UdTjytQMveJw0MOhqoPBjeXSjVt1pt5NsbYORCoZPI
	 6ELpN0DMSJRWcy2VbuPtitNNJncHOk588XWewo6PQ+RdKYQiPzqMEGI18X0FprrHIAVng
	 zBW9Vnom/3/ZsmO0+XQTDU+WSTpOxxBPZ83scdvqUfQdjOZNNsr8VWcstDTSYag0KeIOn
	 eT9Cu6bcqJrXMED6E0ldbid19W4vWDXEB0L/KjJPCFQXJgLhQT92XdZapd7R3ccaLkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794030353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QtkUUVWpLsdzJEHGEXpHcdq6Puxn0fVgQAINhZ5Dwzs=;
	b=VMMiB+YQbMWkwkxyP0xihogrAchi0WAqy6iic2zvx8mFfmu+L1oNNA4iiruWg0FC5UCx
	 Cow1HhgqibESpP5nEmA6fd0xOvsk6je13SH4gN8MVv+qbT+2oNcL5uLrSuwwm0y81xnTM
	 khfp39uA0jDYMQ2sgWPX2k+sbU69EiTSUMV+rXXNJo2AjAFhZm0pb81KZjz7snZWX8pJF
	 KISuVV7uJiTlEGgtMn07xgycaTwwpucInqH7s7DCtSm3Y06UQtekYEd1ynRq1JoD6wF5g
	 SZbVIj2MlNkGq1p6MehqXs2JIuVmmPsUzzIsLyEbYNrNm5Hq5zHU0hMGyUyMMXZCeCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794030353;
	bh=QtkUUVWpLsdzJEHGEXpHcdq6Puxn0fVgQAINhZ5Dwzs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g7Y3/FBmXmRy45DnSNEF1gQ7IlNEaNlGS/Iruu1c2Hfdxq3JibVJZp6lTRY4+B7VF
	 ObSr8yOteDHhj1Rlw4scA/pghK2XDA7k+gkBzN6wg33x0IN8HzsldMnkpcwfWZWL6U
	 zUFt5zxvdq17zfPv1L9UiV2CgHcnHb9r4nTiKI/PfnqW5cZgoZcSBotPvupDejO6kO
	 S/vsUej1eAd1Pc+m4aiPrGDqAiNvz58Wkflc8qldTmR33hWziU051rU3FOaVkQLvth
	 JMy6pBPGNDiBY7MTcV4M+O5u6gANrdnViHMFVqVDKbl2LFrjj1XUTij8MFRHHYafqL
	 yxTJKNlNMXL+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D6381324;
	Sat,  7 Nov 2026 05:45:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80D92362
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B09F4080A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLc_Wz-QSwPo for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 05:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3975407D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:aad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:64:8a00::1000:aad; helo=mxe-2-aad.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=QOw5jGSO
Received: from mxe-2-aad.seznam.cz (mxe-2-aad.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:aad])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3975407D4
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:45:47 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-54d86748f-4cswk
 (smtpc-mxe-54d86748f-4cswk [2a02:598:64:8a00::1000:aad])
 id 2205d242dcf160e8228b5c5a; Sat, 07 Nov 2026 06:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794030341; bh=QtkUUVWpLsdzJEHGEXpHcdq6Puxn0fVgQAINhZ5Dwzs=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=QOw5jGSOnp94VzuQMnCLZxXgccTsF7EsBgGU80DsTe+jGm3DHg+SgT8D8S3rT30pf
 +20pJ1LExpa8xXiYtt9kPXHJprK2AyzH9KbN1vmPCDx37tLJzAyLRo0z6r+YoTcn2C
 X1O7fa86KV2A5ioXODMWj2nta4aJpNOUoYOtVUD7bplv+kaei+MMMGC4n83yF9/fjg
 IOK21tjemmaOCCi9DtEJbS0DYkjapC2U1j/t2SSDSMuOFwFtBl48Z0Vidw8q8VBXbC
 qJWZBkSm3gj9gKE+vGQrXZG4GWhWcgCPsYklUMb8rW4jHhIIStdG+ePHFh3MNUhxx8
 zyEivfzMEOOjA==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Sat, 07 Nov 2026 06:45:41 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Raymond Mao" <raymondmaoca@gmail.com>,
 "Philippe Reynes" <philippe.reynes@softathome.com>
Subject: =?utf-8?q?=5BPATCH=5D_test=3A_lib=3A_ecdsa=3A_Do_not_report_skipp?=
 =?utf-8?q?ed_hash_algorithms_as_failures_?=
Date: Sat, 07 Nov 2026 06:45:41 +0100 (CET)
Message-Id: <x3.ZqLG.6UGBtjSAs8i.1gxhi5@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The test vectors using a hash algorithm which is not enabled are
meant to be skipped, but ut_reportf() reports a test failure, so
lib_ecdsa fails e.g. on sandbox built without SHA1.

Print the message with printf() instead, so that only real
verification failures are reported.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 test/lib/ecdsa.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
index bc7737837e5..3d5a1e1d67b 100644
--- a/test/lib/ecdsa.c
+++ b/test/lib/ecdsa.c
@@ -379,8 +379,8 @@ static int ecdsa_test(struct unit_test_state *uts,
 			     hash, SHA1_DEF_CHUNK_SZ);
 #else
 		/* sha1 is not supported so we skip this test */
-		ut_reportf("Test %s skipped (sha1 not supported)",
-			   tv->test_name);
+		printf("Test %s skipped (sha1 not supported)\n",
+		       tv->test_name);
 		goto out;
 #endif
 	} else if (!strcmp(tv->hash_type, "sha-256")) {
@@ -390,8 +390,8 @@ static int ecdsa_test(struct unit_test_state *uts,
 			       hash, CHUNKSZ_SHA256);
 #else
 		/* sha256 is not supported so we skip this test */
-		ut_reportf("Test %s skipped (sha256 not supported)",
-			   tv->test_name);
+		printf("Test %s skipped (sha256 not supported)\n",
+		       tv->test_name);
 		goto out;
 #endif
 	} else if (!strcmp(tv->hash_type, "sha-384")) {
@@ -401,8 +401,8 @@ static int ecdsa_test(struct unit_test_state *uts,
 			       hash, CHUNKSZ_SHA384);
 #else
 		/* sha384 is not supported so we skip this test */
-		ut_reportf("Test %s skipped (sha384 not supported)",
-			   tv->test_name);
+		printf("Test %s skipped (sha384 not supported)\n",
+		       tv->test_name);
 		goto out;
 #endif
 	} else if (!strcmp(tv->hash_type, "sha-512")) {
@@ -412,8 +412,8 @@ static int ecdsa_test(struct unit_test_state *uts,
 			       hash, CHUNKSZ_SHA512);
 #else
 		/* sha512 is not supported so we skip this test */
-		ut_reportf("Test %s skipped (sha512 not supported)",
-			   tv->test_name);
+		printf("Test %s skipped (sha512 not supported)\n",
+		       tv->test_name);
 		goto out;
 #endif
 	} else {
-- 
2.43.0
 
