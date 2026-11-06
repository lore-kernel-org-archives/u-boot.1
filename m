Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4AD606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JzcxKd3p;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=IbG+4opa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04547810CD;
	Fri,  6 Nov 2026 07:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e86JyqkNMnTU; Fri,  6 Nov 2026 07:28:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48A55810B7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950103;
	b=J/SVhZdlm+J25mh7/BK/lPL+OkTiiVjIVU+Ls8QIdR9Op2DTXQvurP7TUOfL/IXBXitr
	 j4Apt46PtncR2cG+nM2YfdDzAtxVu/ll5Kdn8EJRJbVdRfrX9kQftHtMZghWyxxRy+G1i
	 oZFbPv+KiPPKBiaRC3WJOxGfYVl2pRAbaZsSJkffcH1X0/48oaPr2zJciNpaZNtL1Ph2k
	 +iQbN0+dudQRFszi2xolNqOZulWXm0NwGIAgIB19TTnSyDQburehQLZw0LHjuH8CQOE87
	 20MvODrhEPZ4isHU8610LWiuY+gFL7nHTSxmO1U5rryB7V2+m0ahyWrR/9MJJG6YuTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
	b=VTm11QJxTCTeV9Jg3MDh0hjcx8kIEkZ5Bv3SfnTnufQaf3tJqwuxPM+oa7ez0YdvUWwp
	 pqJ0LgjfDnb+mTYm2jmpnSL24boxtRt6O5TAQZsstKRkhSjAGBqrNnjUsQeC8tYk07EvU
	 LHN+z0/WXfTTq924euB4jsfcyoUkedxjCMNvmHJB9NUM9XmyEwrkSJaxfpaE1r+KillpG
	 6gUn6iILkHeLlUricceAB3/BwPJSOa871vtYM4kX+DOF4oEY8qY6eVoaIwK5Zbn8Ljyws
	 TsJi6YzN+zPfph+bV6BwTewh3FfxddsUxPxi9UsvOF9HJ0HnWrXqsPmFydhc5Y6HSBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950103;
	bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JzcxKd3ptV1XAIpBIgtMtE1qmOULQp//aAeBMESNBgMJ0Q6/cHahlhB+y+JoPxSla
	 mzDLGNExNR7cZLFiZtlXlUwJxWrEn5M1iEou77Bu6GNezAR7VKvf7fr9VlywnTeznl
	 HTTYutGgNSqs9mTZFzP8KHk1MlwTTz5C4c05ll299ElkYO/F+RgJSyv+Um4C+9c8Hd
	 xWLMts/VCQ49Hi3E7wxQSHHNSA3Ymkj5KMUeT6/gw0m+s2fwDJ3sfPMEC4KyNt/Maw
	 W63fECh8+lh+84ate5enu9u2ScUnhkrsK8gOvaUiflmhHD7JKpYGq+eaHgu/cW0Xo8
	 WU8TlczLDjOxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48A55810B7;
	Fri,  6 Nov 2026 07:28:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 609821E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52CAF401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RXGlQfxCD7b for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98AF140070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=IbG+4opa
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98AF140070
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950063;
 bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IbG+4opaREOSY58XbG6zP8YBm48Vkr/91n0M1TbpYDfv1aqy+ZJYDxiIfTM63xKlz
 M7wRY+8NTyU1Emhsaadxxk0yhAiwz/9CWFl2nO+Tb0tqdOQeyAtQC3CBPNN2D+YSFX
 nMfX+eGxUS7aomlFvGuH8NQyFShuNUpy+yfaV5UOU3I+nyiM+i/Lv7f+ova+XnAoQ+
 xOyOcs3vEV8ObkEEvIqYY/7SbrF/lbP3bgGJvWUW2L0Bh6IkQ2eAgsEk1PN8xMW4HT
 kBITpwKSOS95ANeWhxbBREKZ21f9E9/+MZlyb/b8KC+estNlDGClDxm5QYBO8EhstU
 l6I8kvA62HCvA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id B15E05F8F9;
 Fri, 06 Nov 2026 08:27:43 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 5/5] tpm: deactivate unsupported banks in tpm2_startup()
Date: Fri,  6 Nov 2026 08:27:29 +0100
Message-ID: <20261106072729.1714418-6-tkirchner@emlix.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_TPM_PCR_ALLOCATE, active banks with unsupported algorithms
are only deactivated by tcg2_log_prepare_buffer() or, as a fallback,
when a PCR is extended. Users of the TPM which do not go through
tcg2_measurement_init() or the EFI TCG2 protocol therefore only notice
the unsupported banks when measuring, e.g.

  tcg2_create_digest: unsupported algorithm 28
  Cannot extend PCRs if all the TPM enabled algorithms are not supported

Deactivate them in tpm2_startup() already, before anything gets
measured, but only if the TPM was actually started there, i.e.
TPM2_Startup(TPM2_SU_CLEAR) succeeded. This also covers
tpm2_auto_start(), which calls tpm2_startup() if the TPM was not
started yet.

If TPM2_Startup returns TPM2_RC_INITIALIZE, an earlier boot stage (e.g.
SPL or TF-A) has already started the TPM and is expected to take care
of the banks. With an event log, tcg2_log_prepare_buffer() still aligns
them afterwards. The fallback in tpm2_pcr_extend() remains for the case
that the earlier stage supports more algorithms than U-Boot.
TPM2_SU_STATE, used by tpm_resume(), is left alone.

If the deactivation fails, e.g. because the TPM refuses the allocation
or no supported bank would remain active, return an error. With
CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to manage the banks,
so fail early instead of at the first PCR extend.

Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 18ec9eb960d..6370b97a7d4 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -201,6 +201,19 @@ u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
 	if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
 		return ret;
 
+	/*
+	 * Only the boot stage which actually starts the TPM deactivates active
+	 * banks with unsupported algorithms. On success, this resets the board.
+	 */
+	if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE) && !ret &&
+	    mode == TPM2_SU_CLEAR) {
+		ret = tpm2_activate_banks(dev, 0);
+		if (ret) {
+			log_err("TPM: failed to deactivate unsupported banks\n");
+			return ret;
+		}
+	}
+
 	return tpm2_update_active_banks(dev);
 }
 
-- 
2.47.3

