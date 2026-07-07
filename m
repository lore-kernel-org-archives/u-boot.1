Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13502C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A95C8499C;
	Tue,  7 Jul 2026 21:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mm.st header.i=@mm.st header.b="5yWU24JD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncKQAG6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A12849F0; Tue,  7 Jul 2026 19:01:43 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E698849F0
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 19:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zaba@mm.st
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 18FE71400147;
 Tue,  7 Jul 2026 13:01:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 13:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1783443699; x=1783530099; bh=2dBk+IiPHnNxVKHpewUdLIgzcWhL30t0
 YY4uO20Nbvk=; b=5yWU24JDzH4Jcz6VRQLz7lbG8ykTtKSMyb1jOFgsbzm+BIZe
 9Es5HLZl6sifTTlJipyKlvcuBZeKjBX3BaE844OykEdT/ooZ7PGctOwa0pUCsave
 SqTE98aT+Li9JS526G86xV2N83ZWe4AvAjAehGfTOsybTxt5aWc9sDmpVbR1EJIN
 9CZErfmxbF8xAdRm8kXp4BB6Vn+qZ3mEPwwmVruLMut0WKykkLqqIGKIWBHlkEpg
 4DNfDrQywjdyJOBFe6EvKDc1UuIEmXwPXFHEVY3rx8HLmwd43+Kaaggb5RQCQIUF
 NGfruiDC/bKDQfkIm+Kkbc9hMpeDz4gwDVbWIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783443699; x=
 1783530099; bh=2dBk+IiPHnNxVKHpewUdLIgzcWhL30t0YY4uO20Nbvk=; b=n
 cKQAG6kprtGphC/RWH/YoLKDtacGOuInazT4qKUCD7AX+w4aww9XKG9QaAKA2B87
 S28n8OFnGmwnWSVytgFy1OCqe4+KJpNm28aNvBjGC34RrB1wlDfcnxqipG8TNq+8
 LverjYOhnh/FL447cECs3i7/b6o1qUPZAzraowqTxanZw3qcIr36vWEbVh/1G81D
 iqeX1EUIt4Qw/FmDDXJIj2wnQ+z8Ei9dAmBMnje7lhcYBXT28fSokrQvS22Vr0ie
 UouPll4xuifVx+AHhJTS1keeWTpSHIr4fUMAnTv+wyzOhdWH1xQJgFsXteFrTn7G
 sOJItMmz28EzC43BXaD9g==
X-ME-Sender: <xms:8zBNajFuRPphZ-657r4g9oO5hVZznG7Ir6nF_AarjcPFzWtW1uTNSA>
 <xme:8zBNanzoIM8aJQzSGfU6aVM2pev0xaLuPU2Dop47pdML1jnIQHU-W22jt5eCW4UPc
 JGKtetqqNb8bl68l5zqb5_OlEsqZGYVGK97fLf_2wltnIGzHwhFVA>
X-ME-Received: <xmr:8zBNaihtsNAtPQ7QLs_9afNTji6Uo-s5eIT_y_MiDnQ93na53JYLtiI6pPe9b1WgGbDkcSLH4F0ZZuHoFQ>
X-ME-Proxy-Cause: dmFkZTElWXKgYqW6faJrWQjN8fJ0Q6VOuEDZY+f7h/HIJpEng5H8Hn9Xt6GaDQsVQJ+H2o
 wiMR2WakN5NEtitidRBK4r9iTXPAXgNfuLur7f69FiVd1BtOxRBHiCmhR4hdhwuSSEgVyU
 lVPKKH+PQiiED+rR9MwzEkg7dijnnzegDJaVSXBh76iDcNVF0L2qNMrvsatn1GyHUYGGId
 JQ8c/tngg4bkLUkZtbh7zI8fB322onsnbSwvW4qbU8/BsqHrXq7qozWUuQiTmM7wPb3hH6
 +KQ+UHcsXBgRLUSYy0vLmPKDcaPI5chTjmSAt9byaQ4RBYjaYsiB+1+lYxZukj4uOuX8rY
 cH4VAGFEdWEUcPPw2Ms1FVaLvsnfHp4nNAlSrWvTvmUCzu5V2nmNZ34C0aM4wjOB/ebAC+
 yDMXzwy7U0LKkpF6UmnyoED+ItZTuhoNjtoj6xdER0Vbe7PSTRi5omtITN4KW+6EK25wEF
 WKWHq3x4N0pXFal1FgLQAwFnkTiLd2yKdtiSoyu91xLMEeqklVZ+stFbQ4myJv06IMgJr5
 fy9sAI+9JVSMFzS3lk3yNkCLMQw6x2fvDinsIlvPLVed8uJ9WoTvO4/4qqQCaUrFOXQDTJ
 YdYo0LAstui3rZF/3Jo1kSs5OJS7OqbkRFPXGXlLE85b7l8U77MHB+f0NAYw
X-ME-Proxy: <xmx:8zBNaqzt2pas-ANpwbtdN9hpzZNmljuWyhctDXx0u91jEAmk9qQiFw>
 <xmx:8zBNatI1sZlKjBXcM56TGpUhN1X6U6xR4g6ENdk13hGbhkU81KDTtg>
 <xmx:8zBNapQX-GoEWPSlAhNhRpC1g-41tHhF9lh_i-zuQirXeZQn4_ABig>
 <xmx:8zBNatoLFPMyDl7NSUq_S2_Dlv_nSl4kWdRhyZgGI-AlrAMJ37CAxQ>
 <xmx:8zBNau4KewMXK2US0tp5Bf0lireKR1TlwCtNrgnVMalOIlDoPl4MfW2d>
Feedback-ID: i4e034308:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 13:01:38 -0400 (EDT)
Date: Tue, 7 Jul 2026 20:01:32 +0300
From: Vsevolod Kozlov <zaba@mm.st>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v2] lib/mbedtls: Do not use ERR_PTR with mbedTLS error values
Message-ID: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 07 Jul 2026 21:14:49 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

MbedTLS functions usually return zero for success and negative error
codes to indicate failure, but its error codes lie way outside the range
of -MAX_ERRNO, so using them with ERR_PTR creates values that do not
pass the IS_ERR check and lead to crashes.

Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
---
Changes since v1: Convert return values of all mbedtls functions at
 their call sites instead of trying to do it right before returning
 ERR_PTR.

 lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++--------
 lib/mbedtls/x509_cert_parser.c | 10 +++++--
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
index bf8ee17b5b8..6d255250e62 100644
--- a/lib/mbedtls/pkcs7_parser.c
+++ b/lib/mbedtls/pkcs7_parser.c
@@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_sinfo_mbedtls_ctx *ctx)
 	}
 }
 
+/* Convert mbedTLS error codes to negative errno to avoid creating
+ * out-of-range ERR_PTR values */
+static int wrapped_asn1_get_tag(unsigned char **p,
+				const unsigned char *end,
+				size_t *len, int tag)
+{
+	int ret = mbedtls_asn1_get_tag(p, end, len, tag);
+	if (ret) {
+		debug("mbedtls_asn1_get_tag() failed: %x\n", ret);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Parse Authenticate Attributes
  * TODO: Shall we consider to integrate decoding of authenticate attribute into
@@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
 	unsigned char *inner_p;
 	size_t seq_len = 0;
 
-	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+	ret = wrapped_asn1_get_tag(&p, end, &seq_len,
 				   MBEDTLS_ASN1_CONTEXT_SPECIFIC |
 				   MBEDTLS_ASN1_CONSTRUCTED);
 	if (ret)
 		return ret;
 
-	while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
+	while (!wrapped_asn1_get_tag(&p, end, &seq_len,
 				     MBEDTLS_ASN1_CONSTRUCTED |
 				     MBEDTLS_ASN1_SEQUENCE)) {
 		inner_p = p;
-		ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+		ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 					   MBEDTLS_ASN1_OID);
 		if (ret)
 			return ret;
 
 		if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, inner_p, len)) {
 			inner_p += len;
-			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+			ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 						   MBEDTLS_ASN1_CONSTRUCTED |
 						   MBEDTLS_ASN1_SET);
 			if (ret)
 				return ret;
 
-			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+			ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 						   MBEDTLS_ASN1_OID);
 			if (ret)
 				return ret;
@@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
 		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGEDIGEST, inner_p,
 						len)) {
 			inner_p += len;
-			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+			ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 						   MBEDTLS_ASN1_CONSTRUCTED |
 						   MBEDTLS_ASN1_SET);
 			if (ret)
 				return ret;
 
-			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+			ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 						   MBEDTLS_ASN1_OCTET_STRING);
 			if (ret)
 				return ret;
@@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
 			mbedtls_x509_time st;
 
 			inner_p += len;
-			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+			ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
 						   MBEDTLS_ASN1_CONSTRUCTED |
 						   MBEDTLS_ASN1_SET);
 			if (ret)
 				return ret;
 
 			ret = mbedtls_x509_get_time(&inner_p, p + seq_len, &st);
-			if (ret)
+			if (ret) {
+				debug("mbedtls_x509_get_time() failed: %x\n", ret);
+				ret = -EINVAL;
 				return ret;
+			}
 			sinfo->signing_time = x509_get_timestamp(&st);
 
 			if (__test_and_set_bit(sinfo_has_signing_time, &sinfo->aa_set))
@@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_message *msg,
 	 * info. Assume that we are using RSA.
 	 */
 	ret = mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg);
-	if (ret)
+	if (ret) {
+		debug("mbedtls_oid_get_md_alg() failed: %x\n", ret);
+		ret = -EINVAL;
 		goto out_err_sinfo;
+	}
 	s->pkey_algo = "rsa";
 
 	/* Translate the hash algorithm */
@@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
 	mbedtls_pkcs7_init(&pkcs7_ctx);
 	ret = mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
 	/* Check if it is a PKCS#7 message with signed data */
-	if (ret != MBEDTLS_PKCS7_SIGNED_DATA)
+	if (ret != MBEDTLS_PKCS7_SIGNED_DATA) {
+		debug("mbedtls_pkcs7_parse_der() failed: %x\n", ret);
+
+		/* MbedTLS error codes lie beyond MAX_ERRNO and are not
+		 * suitable for ERR_PTR. */
+		ret = -EINVAL;
 		goto parse_fail;
+	}
 
 	/* Assume that we are using PKCS#7, not CMS ver 3 */
 	msg->version = 1;	/* 1 for [PKCS#7 or CMS ver 1] */
diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
index e163e16b9bc..181727e1eda 100644
--- a/lib/mbedtls/x509_cert_parser.c
+++ b/lib/mbedtls/x509_cert_parser.c
@@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 {
 	mbedtls_x509_crt mbedtls_cert;
 	struct x509_certificate *cert = NULL;
-	long ret;
+	int ret;
 
 	/* Parse DER encoded certificate */
 	mbedtls_x509_crt_init(&mbedtls_cert);
 	ret = mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datalen);
-	if (ret)
+	if (ret) {
+		debug("mbedtls_x509_crt_parse_der() failed: %x\n", ret);
+
+		/* MbedTLS error codes lie beyond MAX_ERRNO and are not
+		 * suitable for ERR_PTR. */
+		ret = -EINVAL;
 		goto clean_up_ctx;
+	}
 
 	/* Populate x509_certificate from mbedtls_x509_crt */
 	ret = x509_populate_cert(&mbedtls_cert, &cert);
-- 
2.47.3

