Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AD606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eEYDCqW1;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=J/M4iTVX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D117407ED;
	Thu, 29 Oct 2026 15:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qPpaXbG8BGiH; Thu, 29 Oct 2026 15:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91BA240798
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286614;
	b=K48WFlE9YdEHPe5F4LKi47mw1lypqt/AjORinVJRYthRJn9+h5iW8TWrr/C2FT86DYFR
	 fygA1RwKV2Ug4vVE6eXwVJuKPeRbQNgeoAClKI7vIo4gKtXcJlVln8LghIHqoMyLZTomZ
	 yMCGlU+6BoXwNnwrUfYhBMzVUeTJL/lmeMJ9Dw1AF1SvtoPRDEuaMkjLjP1O7FTqkKAJn
	 R1QBa2E3i/o3lnUpWreNthYPk9aLTXnip69NqbCj1bTcg7eGD+9sA+JmvbceQxn/NJWa9
	 qinm1YcM28COd9fyD116TyZgw60MwgE71xP/BoeQJovsi69pVagz6Lyxj4R0cPLPuGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ivnd+5Ub+KhQLnwA/JWTIfvhdhmYPK0vPAJfSWTilgI=;
	b=MxFzt/RUmfkutj4FXSZ9v06ZfgG4+MsyxIM69F6OaGJrtzPWrZWYWrtxraXY4b56L6DQ
	 XJYp5ZftsZmD0x+lwX004OmIKjp5bYr80E5A6m2BY0sh2pGtKmoKg0P1dXf71ezWYpDn8
	 Cf93rRxyVSZKPnbrMBK3SCJ1hWIMKv8IWWut/7vVLiSmLpy2kffYGuT4X20p3TD/FNS9n
	 yrE46sm/AKP4bNKL+3hnLZjqjTdhL7czLpFKLomztab4YGBfFnqTM5TgBU10ljWEapSB7
	 y91T1jWD5JMsRX/v/zM2+/Nu0bQu4fjJ2YavjiQOr6CUvl0KnydT7X4N/gpb/9V0Niw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286614;
	bh=Ivnd+5Ub+KhQLnwA/JWTIfvhdhmYPK0vPAJfSWTilgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEYDCqW1/idSb740W1dfCm7d8/GSoAmCj5ePROSx9B7uYZ/Xijj210x8Lr+KwQlX/
	 uU7kulZx/h5kNxIxvSHBvi6rnAStbn8CNuN1CvIJ/HQXK9TwxAN4smcYti4SOmKV0O
	 MRAAf00pJ/sqEPiAXIAjQsqEyDqbibPhxwRFVpo+ixc+XjSMDWCuRwB8gzrhlDiAJI
	 Rq5kfw27vIOXnbl33/r9SwBItDeKu/uDw3dF0EZN0QIGgeR4fzytQkZz6U+gp4X1Ql
	 DACt4kZ8SANAdfmcRVbiIN3QwogJjWILOjm/EM7pdKZ/FWWTfHlcSHZh8iFMgA/ZN+
	 JEsuantzayACg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91BA240798;
	Thu, 29 Oct 2026 15:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE335D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABA9680DBF
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCVI0XTTiVdc for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1A6A80DBC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286613;
 b=i6UrV0LQkmFw3bWAkHbnqy864th+p/axtyk7zeyxt7fjFd4uR+SOowZs9EHMTyaelg/Q
 k1cHKf3p5c3/Kzwlm3txUTG6RJHN1PKL2z3HCI4eOLmKitSmS9ZRKFSOCkpBnRAZ51iQ9
 FfBMXoLZJfkqJs0b0hDb38p5swvvjsGDGJrWpysNIIrZen2UGmL7yo0rpSSMlabL7SQsO
 rQqgp3kkdv65UpvbM8bzN3wx8Orm2laz4gAzMvzNgCWVZIM4xD2QqDiYAVkbdHb+Emtpp
 UiE+5agHoXbstobIm1iG3e1mT5E3BFEQWgNiHybKB6bHUMPl0ammuT7/1bBM/JMCvaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286613;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=Ivnd+5Ub+KhQLnwA/JWTIfvhdhmYPK0vPAJfSWTilgI=;
 b=PxYsxN6/3qCurjQl4huxisPOb/MhdMNw7cgzA2WXRxzzVaU/XdXlPTcWJDG4d4Pg7qqm
 wGdZSRBpG95Mu9ol+UAO8v2//Cq+bmN1jBj0f2Ifun1HplLVkh6JdChchJQlEf+g0a1bW
 nU2sHbTQDJFcMMYk3YL3jSlmHladGSd43uDB1zZ3oqy/0Rl2C4xhtMfee4StbY27QbVYk
 O6dTCGyv4eG35Ucmh8w5yidnO+nq0DFVgN+qrz4A7zUEKshW/Uh8xm/b5Wi0fUnO9hyT1
 f79ljl3YkA1jX/+QCW44f34MlrhFV3QIFuwAdZz006atskxu5wIg05YfY6dB8tSYnLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b="J/M4iTVX"; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=J/M4iTVX
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1A6A80DBC
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286584;
 bh=Ivnd+5Ub+KhQLnwA/JWTIfvhdhmYPK0vPAJfSWTilgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J/M4iTVXvlcsm/yNi+VtZdQ80ZqNlnpi1vu3cL0cBtEMF9PgUJ3bAaYWiTkC9s5bs
 AQFvOA/YLcHPwQAM92bb3ixlX9OL2cLDcXAAxNeNng47KQaD24DPh9tHVSp688np8w
 +VX7ENarjx915j5p3oUv2wLsEQEA7Nhtv+ENXxkX3dkhvFUtfwefAlCChCV595xfn7
 AmczNCy8wuEU0lo//di/HffD36lvhGvAX8Iucn1Lh6AFvrNdlqUM87JDyALd3L79rn
 og8bWW2nI/yvd8QOaNSHRT0wpCdN0lonaNXGV5/s4WFn3U282oL/po1L7//9fl03JI
 BG8Q7Wf1mLYHg==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 8D2B15FBA1;
 Thu, 29 Oct 2026 16:09:44 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 5/5] tpm: deactivate unsupported banks in tpm2_auto_start()
Date: Thu, 29 Oct 2026 16:09:06 +0100
Message-ID: <20261029150906.1558380-6-tkirchner@emlix.com>
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

With CONFIG_TPM_PCR_ALLOCATE, active banks with unsupported algorithms
are only deactivated by tcg2_log_prepare_buffer() or, as a fallback,
when a PCR is extended. Users of the TPM which do not go through
tcg2_measurement_init() therefore only notice the unsupported banks
when measuring, e.g.

  tcg2_create_digest: unsupported algorithm 28
  Cannot extend PCRs if all the TPM enabled algorithms are not supported

Deactivate them in tpm2_auto_start() already, before anything gets
measured. If this fails, e.g. because the TPM refuses the allocation or
no supported bank would remain active, return an error. The rationale
is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
manage the banks, so fail early instead of at the first PCR extend.
This is in line with the TPM_PCR_ALLOCATE help text, which does not
specify at which point during boot the allocation takes place.

Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 18ec9eb960d..bd049fed748 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
 	if (rc)
 		return rc;
 
+	/*
+	 * Early deactivate active banks with unsupported algorithms. On success,
+	 * this resets the board.
+	 */
+	if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
+		rc = tpm2_activate_banks(dev, 0);
+		if (rc) {
+			log_err("TPM: failed to deactivate unsupported banks\n");
+			return rc;
+		}
+	}
+
 	return tpm2_update_active_banks(dev);
 }
 
-- 
2.47.3

