Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584C606A32E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VpchkmaJ;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=VNI26RCS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F55860828;
	Wed,  4 Nov 2026 09:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BVogBGvV5y7k; Wed,  4 Nov 2026 09:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A32F6074A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785392;
	b=a0U6noREoc1xiXnBnq5o29AJ62rmLX3og2qm+XjcZQXycMwQEMilDUbN3NQ9khWfK8Nj
	 UFTWpbp45IRyk9YsxSVLvaL4VuMqZFWbk1G5qed81MlHhLnwotvklLLhuCUrCcunKammn
	 qnbBUOS7KsiYCInPSHmhhLmdIL5z9UaWICs8619mi0TX3Ch1KSg5pNzgG0lRTRkx7NmO4
	 sIZBK28pH3FkafV4UR1beVbQZf1o5fCjgnOM6wHO8MLZANRjg1u4wuhzSREbraKIkVeJR
	 7pvlzq8GNeWIpqKMDCMU7XMvpzCO2I6PUhjQpv/FSlEX4WnSmD96WH8OHc4C1DgAqgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
	b=kHOBsESOkUmH55X5Bx0l4ZlYcFKdA5GLvnaV9m7WslpuhPFu6VQKq7VdC02u1ajzf/yD
	 0H0eJyWQ1nCn5aBLSe6T1GhrdIL04vzN7eBJENGHRgvy/dXk76CRjSTUjrOxGz9SnwH7Q
	 sRKrbF+5+SYjaJhAVWHful066fR0i7maplpHkjE9P2knOKPN4uLTcYCIhFIKMz4ut1ry5
	 JEGIS7QkS8fJIC16Yffj46vgonG4+XPE3jCw0XXeC5C19ip3Db1yOtRjNCA4BYdAtFJ6a
	 ApcCEtdAiEmGDA8eFcZyuiwNNP04FcqXITdWK6ArlNCB1hz4rmj4qoNNbGe5M3Sr7jg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=VNI26RCS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785392;
	bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpchkmaJiKNdsogui7TUuY/t9WcJh3fRQjqg519ejS/J2a1f+k6/OMdAYRI9IJed3
	 rL4UDTkGOAWbkCA5Z+obhT5adw5xAa/bnwUrmroDAmtUjd6rolocV6nyfmp0C5oAAe
	 Wcnw6CXa6u3TXy7x3t65WcrW0dZuNj0L7+u34zsF1F6ehpLduK6QUMjmDSvSlX76K3
	 iPsjl0VAbeHdt1VFrQd7tuM2bYelZz+9WlCwo9HzJofdqnl6O6fOVSoLiQqGQhteDi
	 Hh2FK6VBbwfgk+LauX8OTgPCustG98/bCFj/a6lnobHU2GQOWYdCj6l7PDSoNqLqSe
	 lXDCz86dosTJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A32F6074A;
	Wed,  4 Nov 2026 09:43:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC85B2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B26626074A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n01xQJGkjbgb for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4A956067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785391;
 b=kjfB6VyJA8jX5sIdagtsmdJJUKKz4Pgd4SoDykOkif67h5v9YyLlZgNzGavFGUV1j2pB
 Ry0lVGmO/MlrxoNoNaaJQd1s/c+ShC0tnX7Im+Ekqc3Ow6561UspkfmOakCVzRxib7hE+
 PjHw+SowZdZn20xisYyKK7muVaW+rSCAN7z1B/8I9JBjWJnTkK5/SzRfMUozPLJwws9F4
 Tre43vbjoLb+20JlIz0wMK1cZlU1oL+wbc7RTEM/Zy9PngLHYvDcgjr0ak2YiCQsfI7iZ
 poV+ZLeiVR/ignq+tPU9iVrvas+Bx1MzOkFX050sbihODUHk+G+/RCkW9Ikq61uNpAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785391;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
 b=rnC6dHoT7sh5bHyx7oM7xUIG9loocBpY81IwjJy/D4eTfBWi9eDVrytSGuEk6jBVWEDR
 ktYnlAdKpLRs/VJiw0nsHJ/yijKa+yx+iCDvbFgaAstoai0fXdpISsw+ca7Dpm2dQsXO+
 2JZsLRcfiVJyqGdPOFOpihC/gfeFmoWWy7VWWljZtRz5/8zcVtb5zS5QP4Gax7ia1o90G
 NBje4QuZW+Kzxd2kmZNM1KDHvMYhno1k4dyUuxzeLIZmAerBX3c8iNWeElviE4GGCNB6/
 lRMAq7EHDXIt7s3LIn7KPRhrUA5DkB5pFJixqb+UDfyUv+lP4tiSlP2fdLQe9JQFaQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=VNI26RCS; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=VNI26RCS
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4A956067D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785376;
 bh=LLtyKZWJuUVuzxEmLFyJZj25ui8uyUZThOvc8XZkNjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VNI26RCSJbkPZQ7fw3mD364y+49d7dwJxtifw7opjpBQWgD06OM+r5yg1gI08BgIV
 0ItfvgVcpRIyYP2kgT1kqjjNHGU1RpMteZTAYSlIRHzkjuQA77mIuTfvvDIklP4NPQ
 yhw6+Ib53brkYlBle4T0n/XK+sei6euaWkzKsyaRY0Y40w9oyIuhANMwtVSW/tWw/2
 c+HFAM4M/Ih9tTj9KUE23CiKtuxYLVOOjzye7B09bj1kZe4yGRwAMdDZERTQXgsotv
 NZJBr/85V+0L8m6llQfUgkrCC/QRxRNg3Sp2DfmgiZXIbm2rWP2NuxODUZPW8SnyJm
 sVxGC82zjLc4w==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id EA6555F8A2;
 Wed, 04 Nov 2026 10:42:56 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 2/5] tpm: allow TPMs with more banks than U-Boot knows
 algorithms for
Date: Wed,  4 Nov 2026 10:42:35 +0100
Message-ID: <20261104094238.519111-3-tkirchner@emlix.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tpm2_get_pcr_info() rejects a TPM that implements more PCR banks than
U-Boot has entries in hash_algo_list. A TPM with six banks, for
instance, fails with

  tpm2_get_pcr_info: too many pcrs: 6
  Error: -90

even if all banks with an algorithm unknown to U-Boot are inactive.

Each bank corresponds to one hash algorithm, but only the *active*
banks need to be supported for measured boot. This is already checked
elsewhere: tpm2_check_active_banks() and tpm2_scan_masks() detect active
unsupported banks and, with CONFIG_TPM_PCR_ALLOCATE, deactivate them.
These checks are never reached, however, because tpm2_get_pcr_info()
fails beforehand.

Only limit the number of banks to the size of the selection array
(TPM2_NUM_PCR_BANKS), which is what the parsing code requires.

Fixes: 97707f12fdab ("tpm: Support boot measurements")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 137bbbd9593..43ca54621d8 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -702,10 +702,12 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 
 	pcrs->count = get_unaligned_be32(response);
 	/*
-	 * check against the supported algorithms in hash_algo_list,
-	 * instead of TPM2_NUM_PCR_BANKS
+	 * The TPM may implement banks with algorithms unknown to U-Boot.
+	 * Only the active ones must be supported, which is checked by
+	 * tpm2_check_active_banks() and tpm2_scan_masks(), so accept up to
+	 * TPM2_NUM_PCR_BANKS here.
 	 */
-	if (pcrs->count > ARRAY_SIZE(hash_algo_list) || pcrs->count < 1) {
+	if (pcrs->count > ARRAY_SIZE(pcrs->selection) || pcrs->count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
-- 
2.47.3

