Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A1606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KX4o3/9p;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=YRi5T17L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF00E810CC;
	Fri,  6 Nov 2026 07:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIt9BI1gjI9F; Fri,  6 Nov 2026 07:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F40BE81083
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950088;
	b=YC6f+wXnXuJuOM7PXHjWwNb8bK4vb25apQkEeT+Ql8AEIB6cHjFT9APt2McAiUMz7spN
	 qZ650eGkqxDa0no4BooQ1Z+zWFdoCtiR/iQCMuvs/3wgCbBKmjopn5EpBBdoHQQH/hBTd
	 ITPOYhKYv5602pX1AFCDGLGK7QbqRZro59oBJXt+opSuU0fgUdmnD0IdKrU2uPjIIhGo0
	 o6/OiKAjYfthig7/598OrEA/ghOo2uCPn2nK/jVPoKgR5vJBzyZ9tDoimEBnAH2WYMqpH
	 RYntgBByTVkk+X6jkbwax99CIjMv8juFUFYdyw58Irdy83fhNtwfmSF1mB5IWp3NP9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FTSGpShlcpuag+yk/Wlc1CQDT95H+yLlwup7enExaCg=;
	b=i5TZHjmE2Kt1z4PS+wrA00jFSmEYAlplxzSYKP2cqlTEEwU5gXtqY2VYdoSP62XejZD8
	 fZ/xjqFN89+v3qtCh8Cn/VziKpfka9sU7MenJD6LL61VME0e0lZ3eOziDLI6F4n0rBdza
	 r+6ic6ymIwOHKr+983hDlY4ejvoHiOc3fQvlx9MUtAwuGlE9hJukyPBlKXe7MQHnbrygp
	 7fZ29htKkaq+8NTwoBD2dnuU939CsBy5q/Fzhdsv0x6LAWU7fbAKnR8SBkm0FgC2wQM9Z
	 6ASNtVxGbn8h9I7O+2y3SzvFYT3LJAVZ9UYXeDtOeXPpsRfvs9YBdEV5X0UskgSUn7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=YRi5T17L;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950088;
	bh=FTSGpShlcpuag+yk/Wlc1CQDT95H+yLlwup7enExaCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KX4o3/9pOrmSpZe91BRuPHPpZu2ykz4oTw7S4ASsXg1kVdyDSllvEXEguN0kjzmTX
	 cqLZg6ciJJ8QAFx9p+nEmSxzcFnRJgDmkW4kZwb/5FvTWgrSRZUTKpYQ1f8ZeZsoOQ
	 Rd23hpX4PnG0K3Rroi+h0fLWXFdQitqpRHZof3Uq0Rgux/XhHQixmTubV82eC+0nrw
	 4fVSQvnFElTZNNjLhLOZY9LyYtqccTwoFoLG0uCoJXxPW6qEB4ILVtv21AcAHV0LG5
	 a8gcOtWxV1JzdJEU25iMu7m9El7168yum5vT5hj+h91rCw/zKSDOK6udJVKewDL8+x
	 W8KsGRLKN3v+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F40BE81083;
	Fri,  6 Nov 2026 07:28:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC98D2FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9C478109E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fk_mdOEPzBWT for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBDAF81064
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=YRi5T17L
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBDAF81064
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950061;
 bh=FTSGpShlcpuag+yk/Wlc1CQDT95H+yLlwup7enExaCg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YRi5T17Lgp5EIHRnE2c0Tf/GzaUFyhArTFVWMuXwWAC8CqGmjpbR8NV/eYap70i8L
 UMI34i2Bo5dIzSgzMqJVAUGYRUhmtekl5o5fPmNis5hRl6nx1FTodBrThdqqSoa2o+
 ak9QEkNxCS5z3h6xAdBiG/uXo1l98cSg6aDjvU8k28pC02w9Spi9Hx4BN5TJJc+gW2
 7dM01g4vYUcNzbSlz2EmCdVKWe9g29tZTqY3K2Xhdy9Af+2NDkoE+gLtmxHrVLEWhc
 tygo9P++0iauPcgWyGpPSr9OrkndWDXWJEgTULBl7JDFIGkW5vOui2T3NubF9l/Lbn
 Uq7fnpRQMkN9Q==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id C5E8D5F87C;
 Fri, 06 Nov 2026 08:27:41 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 3/5] tpm: detect active banks with algorithms unknown to
 U-Boot
Date: Fri,  6 Nov 2026 08:27:27 +0100
Message-ID: <20261106072729.1714418-4-tkirchner@emlix.com>
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

tpm2_scan_masks() detects active banks with unsupported algorithms by
comparing bitmasks taken from hash_algo_list. Algorithms which are not
listed there at all, e.g. SHA3, have no bitmask, so active banks using
them are never detected and never deactivated. Measured boot then fails
later on when the digest for such a bank cannot be created:

  tcg2_create_digest: unsupported algorithm 28

Track active unsupported banks with a separate flag instead. Also return
an error if no supported bank would remain active: nothing could be
measured with such an allocation, and TPMs may refuse it anyway, as
observed with our model.

Fixes: b6228b2e785d ("tpm: add wrapper and helper APIs for PCR allocate")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 43ca54621d8..b727c645d73 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -66,6 +66,7 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
 	struct tpml_pcr_selection pcrs;
 	u32 active = 0;
 	u32 supported = 0;
+	bool unsupported_active = false;
 	int rc, i;
 
 	*mask = 0;
@@ -87,8 +88,19 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
 		if (tpm2_algorithm_supported(sel->hash))
 			supported |= hash_mask;
 
-		if (tpm2_is_active_bank(sel))
+		if (tpm2_is_active_bank(sel)) {
 			active |= hash_mask;
+			/*
+			 * Algorithms unknown to U-Boot have no hash_mask, so
+			 * track unsupported active banks separately
+			 */
+			if (!tpm2_algorithm_supported(sel->hash)) {
+				unsupported_active = true;
+				if (!hash_mask)
+					log_warning("TPM active algorithm 0x%x unknown to U-Boot\n",
+						    sel->hash);
+			}
+		}
 	}
 
 	/* All eventlog algorithm(s) must be supported */
@@ -104,13 +116,18 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
 	}
 
 	/* Any active algorithm(s) which are not supported must be removed */
-	if (active & ~supported) {
+	if (unsupported_active) {
 		log_warning("TPM active algorithm(s) unsupported by u-boot\n");
 		tpm2_print_selected_algorithm_name(active & ~supported);
 		if (*mask)
 			*mask = active & supported & *mask;
 		else
 			*mask = active & supported;
+
+		if (!*mask) {
+			log_err("No supported TPM algorithm would remain active\n");
+			rc = -EOPNOTSUPP;
+		}
 	}
 
 	return rc;
-- 
2.47.3

