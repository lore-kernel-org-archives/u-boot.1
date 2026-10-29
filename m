Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C59606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KzoC1Nik;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=kVj+ZSln
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 958194051F;
	Thu, 29 Oct 2026 15:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UD6r5kVfQkWO; Thu, 29 Oct 2026 15:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9E75407F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286608;
	b=ge5YMHR0buBd4XdF2ROdgkBLWv+goggGfMZENG4dG8bk5kXwOXIFuscFiGX6HOVr0POe
	 2P+THHr89uy+0QHO6D69yPBYffLfVqeds8wHCMYrzNTKy+zMK55qF1HeXoF/+6SWshAf1
	 AJ2oFxGQWHqaF+yTsDVWuk9mGezF2VHfKvnkFij+s0hrXYxABWs+e8Ng1FJge8nJiFRTH
	 Oi9nm/RrAfB07Hp1b60iEeThb+nmDKTh09Nzmp8g40pxMxK8sqa4tEftFSf9+E/SxSATh
	 xV9V9miOTSJ1uZdz9klhM04q6HzQ+Nap3UPTBXwrlgh48W7JRO8IeTY6WZzZHLDvnwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
	b=kJC7dHoz6BE8p3fp/My3myk9OyINrC/TRuJHBBzkvzgmHjAaU1EJb+6sckhlN3Y18BcO
	 YbgHLi3+IBieqMrnu2Ola2YbjnhLpi/iYGf7uWinJVPKfYAzh2lxxi5dEDR/da4ZprSpP
	 FKnd8bOVPsVKYLN6MY3MtT3tIwRNxVUS4sc5o4RQiFk30g/oGu5sDUXS2ssfjCO0WjdyE
	 rcaElO3Mq32Lz8R5rbfYcqds5wcf+hIpwSqDpLwRI585qfWRK7q6utZaQrbE9hb1nSB3G
	 beLOcCvYxd70audeiW2B5TCF0NOohyzG2Cyv8boeXF82f/wNKKRAxsth9jR0uWRYxfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286608;
	bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzoC1NikeGuIUD0g5Zx1LptSFFvMHDiGM/PmhDvWLeUeZFBlYZlcS1jHO3RaDBv0c
	 jbD56yokx6fyIFqNikNKohrq3BBt4fpijmnVuQJHl+VVEzAdYl0uVW0sPhPvRFMUzs
	 jKWx02wyR/Kbyx4KV4f8kgW37jFCKCUexQscAEr2pLRlymVmT01E/QBc0+KlD0VJIP
	 mIuhK4deoAp9xgpMnu7IbpQqKchPfBocn+v5XBtvEgcbrtKDIwfrLmva8QygvLtnlc
	 m0+kpy8NRYm/8paqgccXh6pbfghad3bnZ23mYIeIWYpIuTkjd8Xh7oa0khXqoKrnDX
	 +gWmO5QTZSEWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E75407F5;
	Thu, 29 Oct 2026 15:10:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A92D2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0082580DA2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUAZBcb9K4O9 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4815980D8F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286605;
 b=dXE7yJouh4WTgbW41BdoDcEfZ+K6OKVPoasfULn2wbuhWy0TuB4mCbkh4hul9GpSEeZa
 JSkXsUutnmav05KStZ3NrXhKAhWhMJK22ky9SqCbacbyyH+AVzyl+XAVZD4XeqMFgyWPl
 nCnF1ZPNy9L/+Phs04GNZ1UNaiuVuJoEVHC4qiIdcoSLWfvz8jbHGU1+iFng7VJwYhSI1
 XS8nnOK/T3ZyhFtBjGu8VfJ3FXLWBhKgX3FFBRs+b5g/Kw790Pn2QuJ/4/ldCaA+ctdjz
 GIUAX7kAPH4zR7BtKHGP5CE5XEeZ/Ijx1/uoev+sz6FJ4OCdJWKUo+J3oVUM0Ajvmvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286605;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
 b=Ry5lQq72kxfHv66MRvBvyPtx5gNL7lSsz72C/we/ZlgPAlS1mxOT3lVf/Coydb1Ag7RH
 ENmi/29knBJZZKs6BF53bMMrV7kKY0D6/t2cbPN7GfjnFLVMqfDL82y8W+1qI/hcaXplp
 wMdbM99xVYiapYGOpE7Os4AFmDjCaOPNqI4mu1DPk6GPaN0fr8/MAntj03mf6auCF9hIx
 vrrQFyPEkNMR+P4aCrNaGnGj/+PW9ng5vpWFpVQ1dNetBietyJgooq+pGiE9dDM4n7Z/B
 BHtHAaXDsWD7S8WfTcJxKOb9/6PLbEY/PIoNE4ILAahP7cPak0GYjD9ywF5td2VBZFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=kVj+ZSln; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=kVj+ZSln
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4815980D8F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793286582;
 bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kVj+ZSln9ClF4TzI9uYFUGpM8+TF3yVGr3jGoC1nqa4A1T3Vp6y0dg+apDo7bxEW9
 7e2xQkgfQ+a08gcoVbNVrydmNYU4NMpUfV1RNzi/W5owsW4m8iMxSorapiQxpAPCd2
 h6YguglsQ7nvOOr3fEnlyrpR09Ne4QUe1saTzNGmODXTrWK/LCCz+cQYSu7V8XXVSh
 FqB/w6n2UcUd4tJmn+xRQk7l8JypKnMje0pu0OOXirp01O24Kz70H9P3pu8LaG6yPD
 7JcGwY+CpXKlabL4cCj+2lw7BZpuy9ueug47/kbZQiK2I5aBiBT2tGjOXWRMFXgO3b
 GuCYNdXhV/CmA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id B96115F8FF;
 Thu, 29 Oct 2026 16:09:42 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 4/5] tpm: deactivate only unsupported banks before PCR extend
Date: Thu, 29 Oct 2026 16:09:05 +0100
Message-ID: <20261029150906.1558380-5-tkirchner@emlix.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable
the unsupported algorithms") intends to deactivate active banks with
unsupported algorithms when extending a PCR. However, it calls
tpm2_pcr_allocate() with an algorithm mask of 0, which deactivates
*all* banks, including the supported ones:

  set bank[0] sha1 off
  set bank[1] sha256 off
  ...

If the TPM refuses this allocation, nothing changes, and the same
happens again on every boot. If the TPM accepts it, no bank is active
after the next TPM2_Startup, so nothing can be measured on any later
boot either. Moreover, the allocation is changed regardless of
CONFIG_TPM_PCR_ALLOCATE.

Instead, if CONFIG_TPM_PCR_ALLOCATE is enabled, call
tpm2_activate_banks(), which keeps the supported active banks,
deactivates the others and resets the board. Otherwise, leave the
allocation untouched. In both cases, the extend fails while unsupported
banks are active.

Fixes: e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable the unsupported algorithms")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 lib/tpm-v2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index b727c645d73..18ec9eb960d 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -362,9 +362,15 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
 
-		ret = tpm2_pcr_allocate(dev, 0);
-		if (ret)
-			return -EINVAL;
+		/*
+		 * Deactivate the unsupported banks. On success this resets
+		 * the board, since the new allocation only takes effect after
+		 * the next TPM2_Startup.
+		 */
+		if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
+			tpm2_activate_banks(dev, 0);
+
+		return -EINVAL;
 	}
 	/*
 	 * Fill the command structure starting from the first buffer:
-- 
2.47.3

