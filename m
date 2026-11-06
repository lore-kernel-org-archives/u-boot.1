Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAB606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S2DmWJzM;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=aK/jxj5k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A918107C;
	Fri,  6 Nov 2026 07:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKEM6lUxZlPP; Fri,  6 Nov 2026 07:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F54780FB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950080;
	b=Yj6WSpw90YY7TK+SyIDmcSaZHJwke1lUK1sWS0SBrbnH9frA5ZKB+MvSev2JgjyT2Bm9
	 GgZhz/pwd4mdBbAMCR0LUs/6uAZDovC1RP8xOydy8OdJGDJeqfXSYU+BrcuZ2HVfkXhfq
	 5WJugHnY34Xr3teKABNKjS+q+H4T0EAP4m4kKS1OY+sSuNcDjHJehKDDjzKXP7eRRJd1C
	 9YZOU/VZt8nPcoFcWuKq3sJ1T8SRPh6Pz8RM7bYCqCTcp2ZggD95DRyKJPvjqwREPO8iV
	 0Fuhi0sNTzYvpHqzoMvh9MNpObl9zHlmrJdrbu2Ps/3FM6SjqzM7luJpBhE54FsSxkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SCFAed1603q1yFV0F0VuebQW0TAPP0lHkyczm8g+JkQ=;
	b=DNtC8jdAf5mOjBA2H6yTiDCqNvttNR/EnJR0VmuZ1ivTKGqS4R6mxcTvl3yPDT7N5Xag
	 rqbrn9QsT26RyIFcRxKTXxPnvaulyiiFnlK3qllywh98C0zogAPuN/PfbEscm02qPjm0b
	 BURgRBy9afIW9P5J1D3bHcdK7USK4f0cg0MgAVq1CPGcB6AvDtD0UrTGGB2kjHJTG+JZH
	 VnVq8XjgX95dqK/Vr7j/+kQVo50qFc2s8sXQwQP4pfVHSYNgV2v+1ixvEVKkPLOeNAQ+5
	 2n5f5QyQ6ooVyCNA/yhlFN2rhA1aiqucMnKfxGi9diMn76Tat04kCqfpjn+j/yFyMEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950080;
	bh=SCFAed1603q1yFV0F0VuebQW0TAPP0lHkyczm8g+JkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S2DmWJzM7YzDeicyycAA8rQzCkyGLK6z4XNtv4wCwke0wj3mncHx9HVswufLxbpta
	 FwHoA98+zDORb6RDVuDrgBMCy2OutiN/JGGoEWqro6nvOQNWWkf9lHqimc5Rp8qz8G
	 I9ORGDjgmpt02XO5n24N2xAukPFHswHXaO1CVMKosYmJYAtAEkI9Y9VaalO+3Crn1U
	 dr5eDHcvqwaiQnUsqoeaY+SqKRlWufesb4BlmGmxkQtLvvNnV2I51PoRkarTKj7s+l
	 aTp51688t/7yiBAPppw6OQ/5nZu1Z8R/nqPi9Nqr6DibvxPixLCHybiNcXrM+EBqjz
	 ui6XKG0GZQskw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F54780FB2;
	Fri,  6 Nov 2026 07:28:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67302235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 646B440694
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tatgas5_hNBo for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08DE1405E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=aK/jxj5k
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08DE1405E9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950060;
 bh=SCFAed1603q1yFV0F0VuebQW0TAPP0lHkyczm8g+JkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aK/jxj5kqGkgE4Vfy69opfCob0Taz6qqr/6/SEf8/jgnslvvuC87UIYcqrw2wCSOr
 mVq4c0jP7ozl5Ev7csr4gnMxn88joDTbuUdAJAPZd8MNP7LxDND7nSOCUOHwt35pT8
 PQAxZ31BtLXq8dRRhUxhKpT0DTO3IrtnS4KIDLmiLIae+nqluf2sWDWQTyV0ujfDKK
 vPr+1MjbzxN50JqfeoKSAnODmuIllRq6wWorvOthQcZWWEJui2eyfG9uvtU8LtujBo
 nH//N8iDorABFxN5e5ceh029ySlN2yHZDgtllbgpSJKxYTDvccfeEa6J0R/uiKO6xb
 lQFvrH5YwxJuw==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 960135F8CF;
 Fri, 06 Nov 2026 08:27:40 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 2/5] tpm: allow TPMs with more banks than U-Boot knows
 algorithms for
Date: Fri,  6 Nov 2026 08:27:26 +0100
Message-ID: <20261106072729.1714418-3-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106072729.1714418-1-tkirchner@emlix.com>
References: <20261106072729.1714418-1-tkirchner@emlix.com>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

