Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8802FE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044278021D;
	Thu, 19 Dec 2024 19:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="BCnZ192o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678588022B; Thu, 19 Dec 2024 19:33:03 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5021E8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so495195f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1734633181; x=1735237981; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+JyA8BpT1obLkzblJtZcgJZjZv0skxIPDPrDAXQ8qiQ=;
 b=BCnZ192on2Wr/Bqb8X/P/xi9+vRFtFqcdrjvLBj7IDhf68UKYAgpBP4EkbH5bdFL0/
 2ZxLBb/nIMG37W5oioWwxcKIihPuVK8UdAOBJOIio0DFSUFkZ+3UzTNQUd2bwKW3IgFj
 Xe/MhmjPNJSx1NBT1K/+y3jxbUq5IXTOLDuqb7mdNAs6VXA7EluJHkDBUapTY38kLxe2
 EELmnPF9aSrANmkNnVjx03kComQ3n8aLei5IpXiyqmq+VvGckfZT8qnKxVu13hrug3ZD
 rzJIeeMJj4pN/EIDfWFeUTJ87+gVD1hL+mwPvFYvYqJGwWmfjFNBrSD0R7Li2Y+TxqYt
 a13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633181; x=1735237981;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JyA8BpT1obLkzblJtZcgJZjZv0skxIPDPrDAXQ8qiQ=;
 b=IIbvmEWxewcD4hzIH9O6m8FHW9Sirsf7kcj/xpE/dbwnC03egEXPxbdyEV8/KRrjHg
 hqMsWe8/nSpGmb+4WJ+1OQcDy9ExCxNCEOtXmP3Ye54YbZtsLUI9c14Q7dCvpesLthmL
 8tFNXHdZjFnI1RZ/BYV6CeaIU8H3KKlqrpjdWkFd28ORTCPQIRaKzMeHNL5tWgB79wjh
 rOlfg91JG9vErt+zDK0TgcQRiDCDzloXY9FvmrogaT7HXW6X6NWG73mNIsVwv3W6LlIk
 E8UCyidEe4rJffWL3wJ3wc44cYSBQYRmLu2WTmQcAqJ28ZCI043oXa1xJKAednZ2h8GA
 sv4w==
X-Gm-Message-State: AOJu0YxPqie8AffXHkM2d1+bLjQ0zpSiOo8eG/kX5JlFXAQQhqCf4a31
 1BsOq1DY1gdPB5UvLqHACFgUw6D5PS8tLJz/MIV+7WjgGAKo24Sk
X-Gm-Gg: ASbGncvFnCAXwNeIkjr4KQoCVrDaTwHYkjljiylV641bgtv5aTATITBYrMj6bzMcDgI
 HEP70fWRD2BTdjTV4IlaDDFiRbLhcIdPBuTJ73V862mhn1g0i6ioT6WYsmCLp5fQS0dGrq77bXE
 cn1l8XX4ahT4K8SSFTwnT3fB6coU9Un9z1DsBmbfbZL8/2D1P0FPnfn4Ux9eE8Nreydi09f2iTf
 rswjTqzs+MQlspqMMEZKxfPoVTfyx2RSanWo7KWXCHlNnW/qPJldODPcW1joADsgoQ9VaU=
X-Google-Smtp-Source: AGHT+IHpatqE9Xwckfv79tMTNxG5LFn8x7PrjZuQeyvigqqmUVUdt7PYhncEXMpTIW1aNXZHdtEpng==
X-Received: by 2002:a05:6000:1562:b0:382:4a4e:25bb with SMTP id
 ffacd0b85a97d-38a223ff9f0mr97658f8f.46.1734633180482; 
 Thu, 19 Dec 2024 10:33:00 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828f8fsm2117513f8f.12.2024.12.19.10.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:32:59 -0800 (PST)
Message-ID: <1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com>
Subject: [PATCH] crypto: fsl_hash: fixup alignment if necessary
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Gaurav Jain
 <gaurav.jain@nxp.com>
Date: Thu, 19 Dec 2024 19:32:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
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
Reply-To: chf.fritz@googlemail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Trying to boot a fitImage on an i.mx7ulp results in alignement issue:

   ## Checking hash(es) for FIT Image at 90000000 ...
      Hash(es) for Image 0 (kernel-1): sha256
   CACHE: Misaligned operation at range [90000108, 906d9b08]
   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
   CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
    error!
   Bad hash value for 'hash-1' hash node in 'kernel-1' image node
   Bad hash in FIT image!

Commit 41b2182af73e ("crypto: fsl_hash: Remove unnecessary alignment
check in caam_hash()") removed a specific check which is not necessary
for a Layerscape LX2160A but would have catched this directly in
caam_hash().

The actual root cause is currently unknown, so fix up input and output
buffers if not aligned.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/crypto/fsl/fsl_hash.c | 87 +++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.c
index 79b32e2627c..ad8b5640f6f 100644
--- a/drivers/crypto/fsl/fsl_hash.c
+++ b/drivers/crypto/fsl/fsl_hash.c
@@ -178,17 +178,78 @@ static int caam_hash_finish(void *hash_ctx, void *des=
t_buf,
 	return ret;
 }
=20
+static int fixup_input_buffer(const unsigned char **ppbuf, unsigned int le=
n)
+{
+	unsigned int aligned_size =3D ALIGN(len, ARCH_DMA_MINALIGN);
+	unsigned char *aligned_buf =3D malloc_cache_aligned(aligned_size);
+
+	if (!aligned_buf) {
+		debug("Not enough memory for aligned input buffer\n");
+		return -ENOMEM;
+	}
+
+	memcpy(aligned_buf, *ppbuf, len);
+
+	if (aligned_size > len)
+		memset(aligned_buf + len, 0, aligned_size - len);
+
+	*ppbuf =3D aligned_buf;
+	return 0;
+}
+
+static int fixup_output_buffer(unsigned char **ppbuf, unsigned int len)
+{
+	unsigned int aligned_size =3D ALIGN(len, ARCH_DMA_MINALIGN);
+	unsigned char *aligned_buf =3D malloc_cache_aligned(aligned_size);
+
+	if (!aligned_buf) {
+		debug("Not enough memory for aligned output buffer\n");
+		return -ENOMEM;
+	}
+
+	memset(aligned_buf, 0, aligned_size);
+
+	*ppbuf =3D aligned_buf;
+	return 0;
+}
+
 int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
 	      unsigned char *pout, enum caam_hash_algos algo)
 {
-	int ret =3D 0;
-	uint32_t *desc;
+	unsigned int digest_size =3D driver_hash[algo].digestsize;
+	bool pbuf_fixed =3D false, pout_fixed =3D false;
+	const unsigned char *orig_pbuf =3D pbuf;
+	unsigned char *orig_pout =3D pout;
 	unsigned int size;
+	int ret =3D 0;
+	u32 *desc;
+
+	/* fix up input buffer if needed */
+	if (!IS_ALIGNED((uintptr_t)pbuf, ARCH_DMA_MINALIGN)) {
+		debug("Fix up pbuf Address alignment\n");
+		ret =3D fixup_input_buffer(&pbuf, buf_len);
+		if (ret)
+			return ret;
+		pbuf_fixed =3D true;
+	}
+
+	/* fix up output buffer if needed */
+	if (!IS_ALIGNED((uintptr_t)pout, ARCH_DMA_MINALIGN)) {
+		debug("Fix up pout Address alignment\n");
+		ret =3D fixup_output_buffer(&pout, digest_size);
+		if (ret) {
+			if (pbuf_fixed)
+				free((void *)pbuf);
+			return ret;
+		}
+		pout_fixed =3D true;
+	}
=20
 	desc =3D malloc_cache_aligned(sizeof(int) * MAX_CAAM_DESCSIZE);
 	if (!desc) {
 		debug("Not enough memory for descriptor allocation\n");
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto out;
 	}
=20
 	size =3D ALIGN(buf_len, ARCH_DMA_MINALIGN);
@@ -196,21 +257,29 @@ int caam_hash(const unsigned char *pbuf, unsigned int=
 buf_len,
=20
 	inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
 				  driver_hash[algo].alg_type,
-				  driver_hash[algo].digestsize,
-				  0);
+				  digest_size, 0);
=20
 	size =3D ALIGN(sizeof(int) * MAX_CAAM_DESCSIZE, ARCH_DMA_MINALIGN);
 	flush_dcache_range((unsigned long)desc, (unsigned long)desc + size);
-	size =3D ALIGN(driver_hash[algo].digestsize, ARCH_DMA_MINALIGN);
+
+	size =3D ALIGN(digest_size, ARCH_DMA_MINALIGN);
 	invalidate_dcache_range((unsigned long)pout, (unsigned long)pout + size);
=20
 	ret =3D run_descriptor_jr(desc);
=20
-	size =3D ALIGN(driver_hash[algo].digestsize, ARCH_DMA_MINALIGN);
-	invalidate_dcache_range((unsigned long)pout,
-				(unsigned long)pout + size);
+	invalidate_dcache_range((unsigned long)pout, (unsigned long)pout + size);
+
+	if (ret =3D=3D 0 && pout_fixed)
+		memcpy(orig_pout, pout, digest_size);
=20
 	free(desc);
+
+out:
+	if (pbuf_fixed)
+		free((void *)pbuf);
+	if (pout_fixed)
+		free((void *)pout);
+
 	return ret;
 }
=20
--=20
2.39.5


