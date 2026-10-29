Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EA606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u/Drc9eE;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=pyqvFn2X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9622A40512;
	Thu, 29 Oct 2026 15:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaarH9tZw8nq; Thu, 29 Oct 2026 15:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AD93404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286600;
	b=CDd79MpA+ATeZyl58XaezAv9xSrABOHVZgVxsDRwxHpKpBxltcHmU/x4MPLkvoLJzGC8
	 XNy+taorBMWgqagf6x5AVXtchBeJQQkKXJ+/rTA6QX5j3xnscGGsG2rw0N1vtuTEKJb4L
	 7P2eIbAtU5LB/+Il7Q73oo0Re8JVcZyMASt9sjeUAElxBCsryNRaLD1DAD3I8AH1uX5V3
	 2V9JNQ4x/RKiblmKlLfxnSdAJSZkGYFQpTFcnYCFMsQaGCHxmucbhX8JLk2JaVwXMdaSV
	 MhwdWYkxY5ekt3nsfiMAdZ7M5W0s071S4JcsZ+Jkbd1aoRLhloMh+Tarm+/6FGw96tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
	b=S9hQnjrEfPmLU0c02SMbs2afWFIhwHdxZ3Ei3l+1h7MRvt/idWUG8WJDaeh1LJ3oUKiA
	 XKyTht23lw/EMHHtFUm7+Hd3RHTzZRw1jfymtwNKMtqyl4JO9sN+EhIGQAPmnFzJeHDMI
	 nQKkV4ANC+wWFoOY4k2GDDBrZPPEHpMisqdH+OO0vfqQnc+WGy7ZB+fmzCjnzedxQK2Hc
	 ayjA66iBMOJJQmIaz7yG//OKaEjl9lpmSHG/x+TeYq7VXpVIgg5puaRB7PVvCIX5TCLh4
	 KjaaAXVboRGLs+P7+Xdmu1GlUtV6CRF9mbYniGKere+NIcR4+GAlgHOqLayxTEVz+8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286600;
	bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u/Drc9eEKnvuTN9ZELT2a4Kgxv6bnm3nPHjduOL8FPGeSdvXn5SMnorOKsLYO/FNh
	 1glSxJ0eD/c7FbHTvxI/AQmsJ503+Qfz7afe9D6FdwDjDhINwzIev42p23C/bAHZLQ
	 RYY6gmwJehHb1FuGFV8epbQPscLI5GtEZz6UKB+EaQ0fkY24P89EC8/QlhuLTK/P9G
	 h9w0fUSIa+YhMAJPUoyxQuDT5WXtHPV25YMM1Mt4snJxDVs/x4OkzSplySB9UvM2WU
	 tw8aGWUGrFMPgo6+asONC/uwCVLPeeML0i69B9ook6WfGzi55CWJJpOsYQF27mS9Gy
	 OV+ezzSogsi7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD93404F8;
	Thu, 29 Oct 2026 15:10:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39CB8972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BB0F400FF
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBUqNpVZYERX for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A0636400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286598;
 b=iP1C8vH9plQ7HOATCkW8wTDABmKtqBGNzfGb19zVmVww7QSK+oGNDEOgnN1eNngiryo5
 yL3Yd5/oXeKukm+N0Qt9c9j75LUtXzIPhbnxH/WLNhRzY4p+++A/1mhk9U+pb2pC/rAKf
 K+7SUOZRzPrYaFUutBwtCT3cw+nSDna/sgRlbR6XiMDTeQRzDU6wfDSfwTsMeVNO0mjfk
 LqLqXeGZO0zK3weFNOSQwXvaJhyVqROZ4c7lcs1nPEEInT+jdM3y4o4C4uLMF1eTDvQxC
 rm+aJ52XMmA9VRzKU5nitHhKY5eEYmRQXZr0Vd34b+yZpeEBrsS5kZ1FfigTVrE/lZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286598;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
 b=nDRQ8CuzELMWBy269xhcaQ2XvKZCLbmw75hDprzoxJnQx1RX4zMrxqZ4O6oIyMcE8oPC
 WzvQpupAhbbD/GnKj+JfjtzAU2tn1Lua2rTkmpaTY24lN4c6sYEVPmT+8duEPLKyQnYcr
 CrxnhHDZW0hjbxRxj1CpSVMoD9maeriyWH3tSmylVPeN/+xJBtGDL/eOmlhYRnp7dgluA
 E2Y9bLYOGq3h8yvbHrMf/9k5Iid5bAbKFodT6fAda6it8gMyJHg7VGqEXaxSedXk6v6LD
 RgA7PTsFbZumkOfQklRHVRISFDxBtY5BpIpD9eEUSmmxTMgOXibjmWHdUDwY1z5d8ew==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=pyqvFn2X; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=pyqvFn2X
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0636400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286580;
 bh=XzOaTVZHZYed+sSVBCP4tBfbmwMPuF52PyfFBf+nHAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pyqvFn2XcUV7ZIWtSxEg9i1aVCVyy3f8KAtalJ4rffXO1oS6FfRtFhGERzXtgfFEF
 MBWnWzGD6KlJKoqh2sG2dZeoakEHBsh9hJuOCnv3xVsoKQeumDdE+s9LYCxO/nuf+U
 sjl78EECU31m6XJBr8S2WQ1nCS17dCSH6jJBXSAEti1vJujS1NRqxotH1UffxMgJKk
 bNi8opg7lPNdcUVn5MEUkHwwWIUJrHa8ldSjyIvMUVGS5CWIKeHt817+SJE7LEok2Q
 sI4nQ3JAwUjvFBuKAAcLuBf1JUPhQYroaSdJroLxXUbVV+EXvP7AXOezMWvV1OesUq
 wt3duER6FguHA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 02C765FB27;
 Thu, 29 Oct 2026 16:09:40 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 3/5] tpm: detect active banks with algorithms unknown to U-Boot
Date: Thu, 29 Oct 2026 16:09:04 +0100
Message-ID: <20261029150906.1558380-4-tkirchner@emlix.com>
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

