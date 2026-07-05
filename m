Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA749C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 12:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB01847C8;
	Sun,  5 Jul 2026 14:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mm.st header.i=@mm.st header.b="ZBbh82o6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRzoxKHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0517E846FD; Sun,  5 Jul 2026 08:46:36 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDD384659
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zaba@mm.st
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 242D014000B3;
 Sun,  5 Jul 2026 02:46:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Sun, 05 Jul 2026 02:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1783233991; x=1783320391; bh=RZBOtR7poCgQe4CBbpwnTjfkpXaBLZKl
 QRessntT/w4=; b=ZBbh82o6wAR1feviWZpA3acL/YQTVS19xNthTe0/GjrkTSWL
 Gp2npQF7HhsGxxP8nbBCWKZeOBzkiVgLq81zooBjRWNK6p2k3sC022/Py+azIQrO
 TltWK8QZvwG0ck2YOml5bIb7fwcoIswKCdYy73nV/YtmcfDk4VZTacl/N/OCsVoc
 VUxr3vL/AXVXYuxXpreS89yUGgz/0Gyl9qmHntgcxACE0I66Mhwa0HMBKFmcCmzk
 o3TDCN/y9V7FNonW35JurgfszplW1Waib/0S3dSLiVWMf4I7Y/ITKAnOBy6l6Mps
 eKayBnNXDygPaAB/zhx18Gr+6sCy8sTf70aDMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783233991; x=
 1783320391; bh=RZBOtR7poCgQe4CBbpwnTjfkpXaBLZKlQRessntT/w4=; b=R
 RzoxKHlWh0XyI6BiTM7vzyRnRg5lJU+/ak6kCitJY6XaKIDJe7WCUcQsBisWV5BV
 vAPJRq9APakIb753+3Y7P8aWq7mF+iFD4XSG09varxjfVHj8c4PYtJjdCxBFfTB+
 x55FcgiU6/EmFMT7uNmlXl9NKHDMDSunLRmeva21kuzaHBRfxOWU+2oesP3yqao5
 qfSycNGqygU+emnvohw55tUG/U0Wy71z1ZxCRuNybO6+RgAfMK6ZaCI4vPZbL4QT
 o293u1fru3pglK5Lbcm6wTmBH3lBtutSh4Jd4FXOO/jTVBule/A8GA9RreDo7vGc
 dU8cRzIvozP5Gno5jgnjg==
X-ME-Sender: <xms:x_1JataB-9rpLB3gkyQewgNVUwIAYpCPqSM8kaFRlhDRfA6VZo6fEA>
 <xme:x_1Jar2D1ip0PRNfkSyNOr4bXBgeajfrywSkSKZLCik9caq3oICYxyLcrSI1NKcrK
 llS2Zj9NqXl4Bv6vxhKJHgkbwOzYjnpqU-za22EVUSC3u2jMaFOTA>
X-ME-Received: <xmr:x_1JatXta4RvA4cMkF3EuQF731aPPRlT5rO_mauSpTmJGTFVGz8Z8Amcun7wDFPIdQ1OpvDTJEeu-CQm_Q>
X-ME-Proxy-Cause: dmFkZTGSIVwGzTASwP4HXOStqYOqsJz7nV7y7sy/ZUMdpAVewabSuTJcq5at8TIXp0E7YB
 qaTDsyX8Tu+1b7ZVHppdsu7+kgLmpnHgSK4PFbVMt8ey6hkKrpB3EQ3YrHQgjA+vjIIMl/
 YH/fXsHPY0pYGkzQ9NCNwLA2mF/JrR3cH5k559Lqi2zHLwO5pFNyGkeEdynhTOvzT2ySCW
 Skobwyf2qHFItmKjKQ1sGHhlYBrGdn3ASQ30FT8qLXCJ4PB/kpHUGkOx/LQ8lv6kH7Yooi
 EdBUNH1I3fmwtLghW5kTWpiOsQmZjVgQHjSaATOyU48oK0y9ij5Lum8mqqNzF8Nng9r4Ga
 Pg0/QxbbF8/eBC5WCOxy1R8T5vlS7hPGs1y4BFrTGdsraUCbfVv8l6JUW4HVO3VVk8EL+K
 cPAhQPGnxQq1XikX0/Pa/DygzdBflbNed0ku+kPlhDzx+az5A77LcIxRbWlLu3jYz9S+Hc
 1SrJqcFUKMnrPzmgXyx+wEQutQH60Bz7P1OpE2aYUzNZX6vOXNZJDNQv/aRv0X4D8VWazG
 YEouBjmY17qljCEMsB186jsVYN+7qDXO5WY0m2tMBBeGV9+gfP6Mk6mrVUqvhWJiv0h3lb
 6VLoV+TKxZq7eootBo9LfHvPWx+ynzZnjh/NGmAS7Z7iH+IznQTIiRZadv0A
X-ME-Proxy: <xmx:x_1JalUlyDhACSgzRgbGUM-O1hecGdIwnVaggAuxiBGVNP_XvBnwQA>
 <xmx:x_1Jase-f4lqmvUEyKnw594GJRB-N2hl46wQnOt9dQZ6Wuffn7gkBw>
 <xmx:x_1JauWF0MwDQG6BW8bJwnsA7cUGIBnymelHjJVrx3YMVH4KqjRcuw>
 <xmx:x_1JalfKAwB2auM_LgonYzcaDGltsMdhKZ8_iXXnwEGSubIWFJEx-Q>
 <xmx:x_1JauQKW4j_HKTecrvGZbiYWdQAPJbgk_uNU5qZElX5HdZ69LcF_Zix>
Feedback-ID: i4e034308:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 02:46:30 -0400 (EDT)
Date: Sun, 5 Jul 2026 09:46:28 +0300
From: Vsevolod Kozlov <zaba@mm.st>
To: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] lib/mbedtls: Do not use ERR_PTR with mbedTLS error codes
Message-ID: <akn9xLl9CGrLtvYb@Vsevolods-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 05 Jul 2026 14:56:04 +0200
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
pass the IS_ERR check and lead to crashes. Substitute them with a
fixed error code to avoid problems.

Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
---
 lib/mbedtls/pkcs7_parser.c     | 5 +++++
 lib/mbedtls/x509_cert_parser.c | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
index bf8ee17b5b8..2c85dcc9699 100644
--- a/lib/mbedtls/pkcs7_parser.c
+++ b/lib/mbedtls/pkcs7_parser.c
@@ -495,6 +495,11 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
 parse_fail:
 	mbedtls_pkcs7_free(&pkcs7_ctx);
 	pkcs7_free_message(msg);
+
+	/* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
+	 * for ERR_PTR, but can be useful for debugging. */
+	debug("mbedtls returned error: %x\n", ret);
+	ret = -EINVAL;
 out_no_msg:
 	msg = ERR_PTR(ret);
 	return msg;
diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
index e163e16b9bc..1c70a8fcdcb 100644
--- a/lib/mbedtls/x509_cert_parser.c
+++ b/lib/mbedtls/x509_cert_parser.c
@@ -425,7 +425,7 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 {
 	mbedtls_x509_crt mbedtls_cert;
 	struct x509_certificate *cert = NULL;
-	long ret;
+	int ret;
 
 	/* Parse DER encoded certificate */
 	mbedtls_x509_crt_init(&mbedtls_cert);
@@ -443,5 +443,9 @@ clean_up_ctx:
 	if (!ret)
 		return cert;
 
+	/* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
+	 * for ERR_PTR, but can be useful for debugging. */
+	debug("mbedtls returned error: %x\n", ret);
+	ret = -EINVAL;
 	return ERR_PTR(ret);
 }
-- 
2.47.3

