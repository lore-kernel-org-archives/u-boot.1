Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B515606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W3cYTO+8;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=eyYXSP+a
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8A20407F5;
	Thu, 29 Oct 2026 15:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlpNDkVQqT8N; Thu, 29 Oct 2026 15:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2645440735
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286582;
	b=YPItm5+b0O2Qt6hpttFWrU4jneLABY8FylFg+SpuAz3Rf/nV3kO6THKHJniHepRhyvSB
	 tJrfeKnh1RcoDO2VCCOzRbcSGO/Aj3Nfx9kMYKTEt1DcMp7YFNPreinDZ6Wt2M0LSAk84
	 dpq1TFJwr2BbSm4wd3clXvAGhV0xAMgs4saBNzNh0ksCS1cPX+W+qPNmvVMOEXxwBZShT
	 lVrjX/99ZSFvp6k0SdB45NOqy5huRfLvqnP8bw29djSspC1VWvjHuDvvRQkWno+yL+GyM
	 Sj/GQ9C/xgCbmRe5gwIZvhG1ftTYWfePdvTehbl/wnH6K2iEDVoesN+xi3mh4LmsJJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
	b=mmGNWxVlSEektBqskqYQAQTyGrARZlr5DVQ8QhDZudzlIo4k8+xHkh1VOmC/pgX4eiVK
	 QPN/eOuqMQF9x02FokUkzAhItkLX/MRFdaaN7s7O+xsGQpY/OWof5G02qiYuqpAPKRMvY
	 QbgdzD19GrqEfGwAshADLZjvckL362ahYLxvkQjVzBgDwGwlqCFDC9zRlOh9F5+ozS6+Q
	 s3vGVpp2PrqIU1qv88pGJJjeGqFQ5aiBxvUS5+YA360rqpG2yummZRAAKq6FYnyBzkh5n
	 h7rfl4x5ilLzzegxmRlmPhBWdLiVAhxWmXRmGixQi4NOaiIpQK1bp7rVfq1TZq7ig1A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286582;
	bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W3cYTO+8D7lH8tJTuMmVtknCocDq5aB+i/x1TzhXChtwBZwSaOCywYXZG5PXtKfTD
	 Tx/hrlRVoLzXvLxqQ3h8I+nUzgHB+REuz+ThHXV1lYULGGZerNmY4poi3+barQWTQr
	 PNiokwTn1daIyGPqZVGuwHdADcTnc0j2X694padEpKsUTZxBf0BZyRSXy0A6N6/bZm
	 JuclwwTQOKnqTkS9Eps3p1kBo9q5UlUjS13VNm5LnB+u8OtCkZU9QbgN9Knfuv8tPZ
	 XZJJp77BdE1PM7ChpENBh4suJd59eJf815PWWAS900CVq8I6AyoHZjCv6keNkMIUfy
	 3Ev49anBBTF4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2645440735;
	Thu, 29 Oct 2026 15:09:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62B9F2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48DC680845
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BiRbn8eH6W3T for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:09:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 689AE8081B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286580;
 b=p4Sfa5X+ort7lbHTGNBkXybKBPrFd4eslznxi92KymSI+5ubc6zRbVgofJTddUtImJq9
 WVrB/S5yBw4yIz+oGXgr0MXZ4ZQD+P1mJPxMqGBauwIImgJn77L+HPHT/ORMuRKHoPdU8
 ePd7ssgUL3BHI+wivbg8GGnhwYyIzstSVFutKBb0fAVO6WmiZCPBhS00trst3pgDYRy8+
 2ZELDxMhWrp8NifAgNvvjxlsAZxhTj56L7sf16z7wc1E0c8NbvGyyNOarLfQA0uQi1uSP
 zU5X5EUj6hEn4BKUSmcasSXKFyOsh9xMPP21q9g8/z92lihhnnvGzyUOz0Rj+9XPL6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286580;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
 b=ocp/qHbm+LsYXJFRecbl4YHFp4cLuD/1uJQkuv+Hu21ssZooJV9LQqxtWqNkIk1L0cBh
 LvJYlbxOGtU1oAp2/gETEntgZOM4xGGHvnXR4QM8D6KH2QNdB/N6+B2m4MLhrvJ3baZpz
 vT7FZBQ0W3yQfWPV43l0nzwFXluPUFqyDBX0ztek3gFpjbl8HGsS4u4H6hIJQ4CeMeoSz
 w/gM7jY3Sob0cSCrW3Hn+xPFgkbyMMASbS3o2QclqDPlG+D82We3hkWyncpuFAtSbfcgt
 Z5IJtDusoo6ECnfwO2/CW9xg7DAC/K8zxxKCWL5ADLU2chNWQNCiP0BgxvtzfpQjXZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=eyYXSP+a; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=eyYXSP+a
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 689AE8081B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286573;
 bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eyYXSP+a1xDSsNiQYVT+l5pCXK48002Oy9eoy5YNWJYFWYbGsSwC57Y7GBvm5h4i4
 gw2VP0n7zkeHCoeRctKGKfjoGIoXMj6AsC56lwkLX/I9z6VFkVg4doEQFbSoG0WabD
 kGeuQs+Gejr351FZLFZCQAq8MlXZ3PBepAf/KnDm9bX/HB2fhBvPIFyd2DEroZholV
 2jIpE/cS+93PqsSdT/QfXe/bnZr9j79j5ypSDu9Zemfz+skjBH/4W7BNUOfUx9hkHz
 p3Bpu9d+isA0xTRnj/4QJ/YkWoyZbCTGhW+/3/VGfVjhfmegFOUTVYEfDnmtghyHbH
 QrHg8+xbNDP7w==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 955DC5F8FF;
 Thu, 29 Oct 2026 16:09:33 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 1/5] tpm: check allocationSuccess of TPM2_PCR_Allocate
Date: Thu, 29 Oct 2026 16:09:02 +0100
Message-ID: <20261029150906.1558380-2-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029150906.1558380-1-tkirchner@emlix.com>
References: <20261029150906.1558380-1-tkirchner@emlix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TPM2_PCR_Allocate may return TPM_RC_SUCCESS without performing the new
allocation, e.g. if the TPM lacks the memory for it. This is only
reported in the allocationSuccess field of the response, see the
TPM 2.0 Library Specification, Part 3: Commands, TPM2_PCR_Allocate.
U-Boot ignores this field, so a refused allocation goes unnoticed and
the board reboots into the unchanged allocation over and over again.

Check allocationSuccess and return an error if the TPM refused the
allocation.

Fixes: 9d2bc92ba7bb ("tpm: add TPM2_PCR_Allocate command")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 4c7dfc55650..137bbbd9593 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -596,6 +596,7 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 	};
 	u8 response[COMMAND_BUFFER_SIZE];
 	size_t response_len = COMMAND_BUFFER_SIZE;
+	u8 success;
 	u32 i;
 	int ret;
 
@@ -642,10 +643,25 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 	}
 
 	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
-	if (!ret)
-		tpm_init(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TPM may refuse the new allocation without returning an error
+	 * code, e.g. if it lacks the memory for it. Check allocationSuccess,
+	 * located after the response header and the parameterSize field.
+	 */
+	if (unpack_byte_string(response, response_len, "b",
+			       TPM2_HDR_LEN + sizeof(u32), &success))
+		return TPM_LIB_ERROR;
+	if (success != TPMI_YES) {
+		log_err("TPM refused the PCR allocation\n");
+		return TPM_LIB_ERROR;
+	}
 
-	return ret;
+	tpm_init(dev);
+
+	return 0;
 }
 
 static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
-- 
2.47.3

