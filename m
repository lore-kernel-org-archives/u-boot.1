Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DAB606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OcU0k3Zn;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=HgbPvYj7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F1C060850;
	Wed,  4 Nov 2026 09:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSYAHrAHL8-7; Wed,  4 Nov 2026 09:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50CFB6080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785401;
	b=I9qWPZR5ysAOxIwR4RcvB2lOAMHrfnjZx/uYi8ZttvOvByD/vWR1FJq79q1hOXn4Pdmb
	 DXUi8UKlfRPxMZVoHCE+J/+9Fcc5z0pYEUAwi4f2v1acdsG++K574OLfr/oyvsvdvlIzS
	 CAPHzdNZOW1wUesabtWToq/pRH/Jh4bdXGlW4BL7IM2cOrq69U+AkzZWAioy4zPk1toWv
	 qhBASShZYv9NI4jCoHYpARuuDNMCtuZ3VJShWcW/t99RnSitn8MkLkTrroXmxctscIIOw
	 i0asCpe7rJhZtdJvraAKgWD883RFsosv21xMWbhTqJ7JUPTi6jQjAlPHpfbbYN7QdOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
	b=cGPpg8FzBQlrM/pys/15ItMwPDbI6z4j+nQ5pI6oASGIkp+K0cESxCavPrRj0ErvXckY
	 AVCdUOzf3ZqGQ4U/bmRTtnlEVtR1Z1dHuS5WYVZhvgcSCkKHT7UFHNXADYbK5FvmqW5XU
	 wcTbTZwS43h1FPbZXLmky1/gheo+ZdXe/Aqj62z+36sxjGFRwMObJWH3CRACwuS018MiX
	 uLJ7JkbHrFjzpCGAkUjPUH3fb6egnmiFO/Vzuh0K1AMVKLSyym0JNjbfj6kJxEkRzFRyE
	 /KugwrMtCRTx4u3BQkZDTSsPmjsfuuSsfOl7QaSX9ognz9qGLpLRJuaR9Mr6DrtSwbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785401;
	bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OcU0k3ZnWIv7zSTUvk6JbxPyBn3rVxeH9crW62DWPcmJX172eE+SE4NDk6HP7vS2x
	 6x4FjoVn2doxe7jGizfVLQmKX8yv8FhNMTQdXPsj++pAomU9MqsQBapFQIHPibxGD3
	 JvHb0L9+0k3KPrL6Sip9yI83IPa8GHKPtDQ/S6yCDsUKDLVrQUCE4iFQvayWYIBJTJ
	 BuDieBK6tDKVsM3QbzI/9kvJN6+o8LjKFpZ+rXeF57QrcnZhJR0We4kim+qhV+81iD
	 irnTg9zrB4DUiGA9MlYyfQOs/xEu9pvmboKrzNe0youWLictBeOqSzjIlyiSmfJTWt
	 cfzrjA608Z/bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50CFB6080C;
	Wed,  4 Nov 2026 09:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 885C6A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E773400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMBk76c2xPaK for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 65E7B4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785399;
 b=hR8qgDgPN7MHq6qEGZGXL6wdUp+9WGTi3NJ8ycWpzdZHcHftKVARB7dfe6VmHrCNjFyw
 Q7knt2TQ6BwCgOSH2oWYEJ74K83OjuBUDKZQvhAx4nqVoZ7qZyJTvTnXJwYWcD+nzM+ID
 yHOBqhszKIq8JKY5tIOwdew/LZuviCoLnZmBoyEZAAWReFyNqJQr4QSVJpsKVVhumi8CQ
 Alp9MlzMWgk0eqiWw8cEBz1/HyzczuSbVfQF2jM8Cwib1QglZ8YILECewxyyYlGP7nYu1
 nRm5gvwkLNAFTGIvUlMz97NCgmZGQlGS5BhgBn9KjLWJeIT82QdmCIC04IqtD2v3SMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785399;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
 b=VW2FkQTyimXc71i4M2724b5Aq4nyWiVsl3mJ57lHXIFbcKBRgdXkgwKNOiuK9f7jmF1r
 y1NvrheXfx4zLN/pjrGFQ+RUY7oKcHlqaM3CwLGUXNJCFp7YCDiUg03oqi8X0SARluwe+
 uVlLnfVt5qh6hNdY66iwuDZByBLMW0yObf04r0TQHsClh1hTEWnicg/+8CBiiELBSyqCn
 4IwRsusl3cxVrp6Muri0qkddwXTm9XMB24JXEczaRqt709ygmK155gaR3oLIDzB+4cwS2
 Mgow+40aYRuJy/s5RG1PkpKcfmHVJn5+PmtXMXdvZQwnT6aK6xcJzM69wdLrTIuds4Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=HgbPvYj7; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=HgbPvYj7
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65E7B4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785377;
 bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HgbPvYj7kBOGImJjsXu1Z4MoRB3DEyOJxATo/ojGTJEc7KkAGDvwkXs1WIFx060MC
 tea9Za8/kCDk5G1o/lBNCM0DRzU5InyB6UcsLcDfulFEhQ7NK89fW3FNXcnDO8hv45
 W7Idr96BngJ7O+XVe1RsFSTHR6hXlnPGnxh1EqXlcxbNLMQ/wmAcUvwLHsg6vza6g0
 BsMlwTmaVjqczT1MMBbGjp1YnPugmeu6ZWeEo2W/BReSKcuZCr5ISqPapOYRYNJWNV
 yx7YGqbmlSSwELoxFLrx00SSrzPRbf0PRH+VIqtPPSmXGCQBVe3vM31Y6cuKkQqgIi
 HAVbBvxOsUwDA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id CB4065F8BE;
 Wed, 04 Nov 2026 10:42:57 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 3/5] tpm: detect active banks with algorithms unknown to
 U-Boot
Date: Wed,  4 Nov 2026 10:42:36 +0100
Message-ID: <20261104094238.519111-4-tkirchner@emlix.com>
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

