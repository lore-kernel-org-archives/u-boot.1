Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A4606D801
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=luLGJazV;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=mxuVuxYG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8383080FD8;
	Wed,  4 Nov 2026 09:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHfG2MiWQvJ7; Wed,  4 Nov 2026 09:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB4CC80F6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785386;
	b=n2tzSo+AeB5kT9nMSLP18b+RS+LGYcYhzOV3EbxBWEl2GtjbCr/LKWr4CU/r8mvpO/BO
	 3qYGMZgZjXm2NEXuAdzNWovtuAWO73zv639RK9UIP7UwOTu5QOWNn8sV96i2DF9FnmtgS
	 dlfg88vLoRiY0Nr0HFydL2qKbLvwwsKdA0+BP4HLhoGHkspLkmLxM+5ZZdYSf2F96tiRb
	 tBKtjOQHZpHPjGvTxLtg1Ca1OR7t2D99nywvFOrD5DpJraYhPIMn7iwfltqQVbScA/u4Y
	 1dv4Ho05jcbVELyJv+bDS+GLtczmq5B1cY8zFVaQQQzbzRvByjsCjcqYIk/fHN2gNIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
	b=YrTUKfbAQpYyex8/99NFS9N3/kHhh1DzjulkpTPMtrJTz7I6ChmbhslvBDlysYU9abaw
	 YN1lNb6uCtPAxc/vAhnYx+Hz1IkSPoTBznqxuPkKq1q7TTc70FTcYUWQjZpaJOS4XfYmo
	 4G2f3RiUt02YUQDY370NJnVOJA5F+8DwAObauAXjNuB6/P3AB2DvI2c2V9QVfZZK4wzr1
	 EbrqVFc2E0BO/GF6cD22Ejv/CvHVDXYfjXnguIS0KBUuqzkKxhD3f3B9PgMHIj9Hy2VeK
	 uX+UlTbjDyFJf7RnUJDejuupm/+aFxp7XlyIlGkOOt/WumscURfFaeD9xtSc1aUJcSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=mxuVuxYG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785385;
	bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=luLGJazVpT/5HqvPKDGiLEuSIuFavoYn73xNLfhHW7+HSipNQ6j+vaBo0PVYviHw5
	 CxtlmNJj3ioqD/D8iy29ve4PZ1KeZC4+qLLiSPfxlbGAwjc0s6q6Teug7NJfFxn4ck
	 ieXmSzmd7CliwSQgu4N/iAlRYOf6ig8mC2+QaDpuYBBluZ+U9sf7jBQKb/LJisI8bq
	 x8L0uFML3CfYUC/u7oDZiiDtnJU368ZqdUuy/I4YiBGu4lu3KeMMfmlcHyAiP9rvj2
	 I3+kty1OCr31FmVlbD285/RDSkxztCR0UgV6zJ0RlOgVZ3idet3w547TmgFKhNK2fU
	 C70q9hr79FCXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB4CC80F6B;
	Wed,  4 Nov 2026 09:43:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A823BA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A04580F6B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvGD1VmLk-ky for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:43:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0744D80F49
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785383;
 b=ktSewLuR3LkqvdSCMO/zgFtQnGjHPptopBsc18kDcw7G5Lzy0omGYJCIVhTejA7w7qn3
 qRHonV1HC82ye9vUsozGn2/X4T/q0ev2UZJglYJ8nQbb+tYOMU7DD927+zZJ7P/zf3yrc
 5DwPNiWCNGEY8U7l5omT4PwW8BpTjpvXoYVrNPzk+DgKgeJvWn5E3MDP05FoxL/9HjGy3
 Yfr/FiZ/I4d+94XMg+lAtGjjGZuVZAheQES4WfCz9b2jmt+HqBb3dFZTOiHtyoc1AEKrp
 VM5dNoSrRS413pFopizR8y/jJpIsD7BdkYMu1xX/P9ypZEnIzF+eHTWCX5RAbFIklng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785383;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
 b=DsmEC9B9IwVpYN5nhwpVNw7BCClW9/Y71sNTXDn5xnJNhAE+q6qg9ZlB06cohif6kaXF
 Ny+qBZkLCrRQreuxIBAC5Le8UzCjDA9o3chBvn4lLNLQFjuPlWrrdq35nmXJnV3JBBL21
 kBYgwFJrSj313zCAiqL4QrzZGtV64pWK+9w07h3l4mQoXcygiPoQ7/oOa+B4/BzmAUZjv
 i8wtJG6J/Zk40Ysom3jJtH73/KbWSPTpcFxL8AqbKxP3Ni2i0sWQnDuJAE3aFNVeERuxF
 Z/tklV/YaragtGMLB0+VY+c5Qhv4rnQhS5BzgET+rBKjaKooRPCViqJaoVGPCn1ra5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=mxuVuxYG; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=mxuVuxYG
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0744D80F49
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785375;
 bh=uPB979bbmle5U5uh7sG3xAqjEON8ViXmzpn/18MkUE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mxuVuxYGBL3ZvTaSC7ZM/cZlk43CXc/MSGWgkIdA1dcDr7XEZQ8PpGaeqyqBLnqid
 A03V9mwalCJc3oGqkcA+xE+WJY0S26I0WYXfeeN+nelKRwYmrJExY3ch7PR+psiv2K
 kx/bExoslTTTeluNFVCImziByMY2ZSe8rFBSa8n/h8suPpjZHEYB9CiSlkYHaZErUz
 Flm51IXpTC9x+6cPTOfceeUldFZr5xcrzFPXkngJFec8/w/vKxbMulD/wUNPgY/Ioi
 5W/BxbhyPdbQzJTfjVs4SIzDOeK/RYOI0OcdHrZ/cJoTuLDxqgDCwxyF5uLk8J/KP5
 pL0ELlD08L2cA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id E8B885F7D7;
 Wed, 04 Nov 2026 10:42:55 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 1/5] tpm: check allocationSuccess of TPM2_PCR_Allocate
Date: Wed,  4 Nov 2026 10:42:34 +0100
Message-ID: <20261104094238.519111-2-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104094238.519111-1-tkirchner@emlix.com>
References: <20261104094238.519111-1-tkirchner@emlix.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

