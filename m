Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47583606A32E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M/qwOmgG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DL4112h3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C7188125A;
	Tue, 10 Nov 2026 13:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2NipD0fTObo; Tue, 10 Nov 2026 13:05:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8363A81271
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315923;
	b=pg23DsdTBYmCBrqv1JoRYLuICOY0JedOgw62jUXgID4i39mfI2BgsU97YKZoj6KeNAkW
	 pUWM3XcNV8vt3seoM00Qh37R69op7v9buJ/L+BUAazqiTCzQDNc7Wh51lMa7YHPYbdu1F
	 biVtEOR0rXGuz/WwHJPq2P11oWCwUSvDwz+Xt7TZS7Eo9m/hxt4PfLPHjfs2LP/c1oIbD
	 QLNwxb2rOAcjfblvW3/fcN805M1IiZOIwtAdfwj+nQMdc2+1VCL/HCkdyJUd3QKfPY6rP
	 noLXpZj6dQICbEMubmE+au1wsWVP29iuWynyRkiiH3WCKz1Pl80nYzsqGqMEcv/rjrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=k/9QElsA73fQFbim2/8akLJRrOwtRUI8b2XtBeukJzQ=;
	b=MOLmydlabEEHH+5qnKwWWnGj0jDlLmsDPEraR9eFiAqcTvc79QzKADZzdfPM2ZLPKV8r
	 PhHVeVcVyP5PHvreZoZDTZcxs4dgjw1idHlRFHL58gIpBAMGqsyPGlKLIhHF2t2W9vHn+
	 yKHEfPfaj8+BSJqkXiZL+BpqpoZPJTWamKOj1woUr8afnmu2SNEGeZG2y8Rp2w5myD/p6
	 OFj5eiefrC6iJbHWhO7LQYy2jUt7CMtHdCgc6pNGQay9z10Rt1pa3adVlHS7gAHBRpRTg
	 6kuWYrt3RjGJOx3S0k8C3vgf/vrWvx7bzh4amEFq/4Uj10DNfw1KbyTkHbVUKQ0JW2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315922;
	bh=k/9QElsA73fQFbim2/8akLJRrOwtRUI8b2XtBeukJzQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=M/qwOmgGf2xXphA/4IHVEwsgovlEtlUUgv9eutbuvPuUhIL6c2mSuopnu5TN/4s1d
	 eAvjuLucjTt04S/F93iZbdqzSVxMFPbo5yZtQOgsAKsvWjak2QWyy/HwBFtOMoAR7I
	 xA+urVbWPb6rF/zx3i7kKeJ11NWw1/j6m6duoU14fhwGHqHPi4C7YLogKDk8iwFmRg
	 PEJyFTivFcaShDUdwX3plJBUK3IAWbDZ61Rcew/XT4xqzr2fbvDGEafvt5su7GnJNI
	 9a75EPkYZlE3xrVElUtFVP7TIZXp91yXP9jw5AoIVk2tOZazyXJCK65qxQw/Ko0VYA
	 OI1XPF8MHEnWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8363A81271;
	Tue, 10 Nov 2026 13:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3603C335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 05:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B9614031E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 05:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZpkAwjkzV3p for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 05:32:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4363140098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DL4112h3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4363140098
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 05:32:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAB6143D06;
 Tue, 10 Nov 2026 05:32:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1FAA21F0089F;
 Tue, 10 Nov 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288741;
 bh=k/9QElsA73fQFbim2/8akLJRrOwtRUI8b2XtBeukJzQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=DL4112h3ufjmv5uJ3b5qrcoxxhrMrtXJP2ph9ganXPJjkct/U/eZnV0cQlWldOl17
 C5dnmsTi7VwldWlWkqEdvLseKWCaOiOVU5kDDtHfqZ/Qts9nLbSXofDayFkrrxfEl3
 LbIo1OT/kE6YqdlE/LMMeQkc5jw22gRODK+0Y4Y8PKCbksALkFY2EllKmIkyWYEVpn
 yDiEaaDIMnyzO/6kDt2AO/seJpoV5nnr+3Ei1/4yaMxJbqyRP0eI01N4KKwWSGbi7o
 RybvzU/HTeUrB4Fi/9rLB2/THM0L48iKIYqfhoAba4g1PnVoS0I1qt/Je8maE8DMYV
 XS3W8vMVDyYPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7544148892;
 Tue, 10 Nov 2026 05:32:20 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 05:32:19 +0000
Subject: [PATCH] lib: rsa: build the engine code only when OpenSSL supports
 engines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-rsa-no-engine-v1-1-8dfdd9e5dd7f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1jCqEDEVRBDElwwg0FxW1VC3
 J3Qjm/4/wDjJGzQFwck/ojJphlUFhAXrzOjTNlQV3VLRBUm86gbss6ijOS6GDrXuPDwkJs98VO
 +v98w/m3vsHJ83RM4zwvsZVZtcQAAAA==
X-Change-ID: 20261110-rsa-no-engine-187cb7858b4a
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Eddie Kovsky <ekovsky@redhat.com>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794288740; l=5048;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=8vIq9x7mmtXhjFfbVpDBv1WfSQuuLSYG8L2+i8KEkuw=;
 b=/gDYIXub6b4WgMLZAPQJLooerMvtALoC0PomC2D6WZnUagC7HOZNSaEr6Xq9+9j7U/ugJjBVt
 jC9rhwrFUipB0G5FuObos4B2DlGm89zDaXbwPOmtCwcxNiIIy/pKPb1
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

OpenSSL 4.0 removed the ENGINE API: <openssl/engine.h> only has
deprecated declarations left and the functions are gone from libcrypto,
so building the host tools with it fails:

  rsa-sign.c: undefined reference to `ENGINE_load_builtin_engines'
  rsa-sign.c: undefined reference to `ENGINE_by_id'
  ...

OpenSSL 3.x can also be built without engines (OPENSSL_NO_ENGINE), or
hide them behind OPENSSL_NO_DEPRECATED_3_0.

Compile the bodies of the engine helpers only when OpenSSL is older than
4.0 and has engine support. Otherwise rsa_engine_init() reports that the
engine is not available and returns -ENOTSUP, so "mkimage -N <engine>"
fails instead of quietly signing with a key file of the same name. Keys
from files work as before; with an OpenSSL that has engines nothing
changes.

This is the "unbreak the build on OpenSSL 4" part that Quentin Schulz
asked to be split out of Eddie Kovsky's "Add support for OpenSSL
Provider API" series (v5) in his review on 2026-11-05, following the
design he spelled out there (the condition, the OSSL_ENGINE_SUPPORTED
name and failing with -ENOTSUP inside the engine helpers). Eddie did the
groundwork for this; I'm happy to drop this patch in favour of his v6.

This only fixes the build. The binman engine tests
(tools/binman/test/fit/dummy-rsa-engine.c) still need an OpenSSL with
engine support, and OpenSSL provider support is a separate topic.

Tested by building tools-only_defconfig against OpenSSL 4.0.3 (link
failure before, clean after, no ENGINE_* symbols left in mkimage) and
against OpenSSL 3.5.9 with engine support (unchanged, ENGINE code still
built); with both, mkimage signs a FIT with a key file, and
"mkimage -N <engine>" fails with an error.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Eddie, Quentin: this is only the OpenSSL 4 build fix from Quentin's
review of v5, kept to what he described, so the tools build on OpenSSL 4
while the provider work continues. Eddie, if you would rather carry it
in your v6, please say so and I'll drop this one.

I developed this patch with Claude (Anthropic) as a coding assistant: it
read the review thread, wrote the code and the commit message, and ran
the builds. I reviewed the result and the testing is as described in the
commit message.
---
 lib/rsa/rsa-sign.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 0e38c9e802f..aedf68cf966 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -19,7 +19,17 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
+
+/*
+ * OpenSSL 4.0 removed the ENGINE API, and OpenSSL 3.x can be built without it
+ * (OPENSSL_NO_ENGINE). Keys can then only be read from files; asking for an
+ * engine (mkimage -N) fails instead of silently using a key file.
+ */
+#if OPENSSL_VERSION_NUMBER < 0x40000000L && !defined(OPENSSL_NO_ENGINE) && \
+	!defined(OPENSSL_NO_DEPRECATED_3_0)
+#define OSSL_ENGINE_SUPPORTED
 #include <openssl/engine.h>
+#endif
 
 static int rsa_err(const char *msg)
 {
@@ -101,6 +111,7 @@ err_cert:
 static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				  ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef OSSL_ENGINE_SUPPORTED
 	const char *engine_id;
 	char key_id[1024];
 	EVP_PKEY *key = NULL;
@@ -156,6 +167,11 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 	*evpp = key;
 
 	return 0;
+#else
+	fprintf(stderr, "Built without OpenSSL engine support\n");
+
+	return -ENOTSUP;
+#endif
 }
 
 /**
@@ -230,6 +246,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				   const char *keyfile,
 				   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef OSSL_ENGINE_SUPPORTED
 	const char *engine_id;
 	char key_id[1024];
 	EVP_PKEY *key = NULL;
@@ -292,6 +309,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 	*evpp = key;
 
 	return 0;
+#else
+	fprintf(stderr, "Built without OpenSSL engine support\n");
+
+	return -ENOTSUP;
+#endif
 }
 
 /**
@@ -327,6 +349,7 @@ static int rsa_init(void)
 
 static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 {
+#ifdef OSSL_ENGINE_SUPPORTED
 	const char *key_pass;
 	ENGINE *e;
 	int ret;
@@ -371,14 +394,22 @@ err_set_rsa:
 err_engine_init:
 	ENGINE_free(e);
 	return ret;
+#else
+	fprintf(stderr, "Engine '%s' isn't available: built without OpenSSL engine support\n",
+		engine_id);
+
+	return -ENOTSUP;
+#endif
 }
 
 static void rsa_engine_remove(ENGINE *e)
 {
+#ifdef OSSL_ENGINE_SUPPORTED
 	if (e) {
 		ENGINE_finish(e);
 		ENGINE_free(e);
 	}
+#endif
 }
 
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261110-rsa-no-engine-187cb7858b4a

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


