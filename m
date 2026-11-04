Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D9606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OpKnx1DG;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=AfNmSr20
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1D958101F;
	Wed,  4 Nov 2026 09:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3MWPwDUHuEGm; Wed,  4 Nov 2026 09:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EABFC8107E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785409;
	b=k8mHNCfGOJCumnyY5GDzGTwaIUjaGVjcfMNjgVgDTCFs/yxdwnjepnowvODMk3QJ+FgM
	 pxLJifqe4So8SrUgJBrXwPWieU0GuTuz/iKlNzWpvHQzdhY3RBcfIGcHvW0ah2Ugftuos
	 kUz6zoyshLIBmS7qWze5qmTTxf9ahfXuG7PJp6o9h/MglcLenfbieXMs0BDbta9hbLw9q
	 v8PqE5aatCwvs9QEEtvPL9ZuQvlKDQjiWSoQfP6O8C0fIfimjXI+aAjJ2DgjLL8Vs1L3s
	 OQUt2GO47uAjcoTikgwtUWHupWoxoZx9o5jIb5dOHfO+3vfFknTjBueKn3haQ1ZOOHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
	b=XZNxbSJtWz26uh1e3as11LWggIzkI/kWHsMLtp5SWUNr9Fnimh697Rx3+GAlg8XY6EeP
	 9i4uP9eviV0AvQgDTaOuPSES5f+xIfwjObgXVFApv237akHW/NMWdK4N5IEU6mJEqdz9s
	 Uyq5uMBY4JnqfREpu7iQcNh+9fFGZ9tejJIVqHcHi8L2knG8o1Eudzqucn6XJu7rwVFm9
	 MmQ8qjNOufZH31DiLfGSnUBpl04s41cLGeWKHq2vQqRqNJdsmqGhSPjlxtBdZi4ytQ8hn
	 EsxIzROOqD9Ktnipw2prfY5q0CrDbBYc80XQkPed6ZyRvGbbvaZJdJWtYx3H+kjeWCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=AfNmSr20;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785409;
	bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OpKnx1DGJlcPkZexXlWcHvD1UXkS3YoYpgzkSQ66/sCtE2N7CVXT/5bgpEjwq47u2
	 HnHVU/hswq2Pr8U9B0usI/0q8vRIEw0qmL8Z9CvcqxvkuClFPDmOr6gRuSzrlgKzLm
	 I+HkJULtFBgUpOxVT0XDlUsrKhcUJA2Hm1c2LePFVEiF3s3EjpyCwWXl2YOAbYfug4
	 ANpb60gltJrdwrGSl6wX/EjP1Lzo+DJOCIYDoyF8UvjrNE1kgujY7fyluwsRNuMM0U
	 Yu6RkUReR0arACaDdg4tWPXBCrfPt3sM+lVYHA90B/NPsNwFaPQivQ9r6yCBTlWDxO
	 ags5sRT5Tp6hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EABFC8107E;
	Wed,  4 Nov 2026 09:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DEED337B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4BBA8107E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKwygmOPeU0e for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 000EB8101F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785407;
 b=I5OnJeaUS36kJS/+7BfAhWwaiYr2DVhv1a4cpV2m5aoio7nj0WmFHbNkNQ8LfYiXX/ia
 xVqJOg1/u8seozh2i+1IRqBPdXvyJ2Hv+eS4BiInwaStjzGNmFfbQMiRgum8DHHb82dvw
 rwf330nMBF1f916PVaAcXy9qOnTG+6oMoxmy7B4UVqqlQnp04gj8hcRoe+uHczLbZWhnE
 3c5LTuADH6fxmUVTe1fD7DbfWDStBLFwOXVI5g29vCsA865p0CX7rvvAmpY2Zwaz2ACYm
 2Ub2ddNLa4kWGT34oQsnRxoCAL/ljhySB2FOPonx2/cVQpjZw3CZE+ghCRkj30QfT8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785407;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
 b=c0Q/DjZ4my/QFtFJwgP3cIbeBd6b7yMYiGMhKXVbVk+q6PMHWXHRjYGJUKNM9THAKnUw
 3nGXBdZSl0Q5+jh/OtwAR5JYIZoIHolXeUnDjZwDmKFwbQE84ewf3V8L1CGtwOI+6yKT+
 DOKSq+n4nVc2orL0oI2OigVQjDg4xfLBzmQMdZwSXjjHzFyxPX0yO2RvGoU06aI4XchvK
 ngTMaB7CPT5RpsmQjPQ+5xqOp5Whg1wGglsrbX+eNXDGNQbcgxulpENHU7BfxMEmc4jpQ
 gYRyEFZX3tZHVuELxqOiSMHOTNrxttDHlDSMmM+x70PLDJOXaXKhcJAJk/pTwPvgcLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=AfNmSr20; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=AfNmSr20
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 000EB8101F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785378;
 bh=Ohmiirdb4u44X9HBkMzu+YTntbARk76RoqcCB7yd21Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AfNmSr20wZ57SdMHSffPw7YGuXE3lBjOpCpk5EMmuLTIe1XQXC+9nQCeqbE4gY3YB
 xHEUpjeZgH06zvuD7/VhSCwMj7Nc2zFJHqMXPUHC6MWo8rs/Yqtnm7wI8rk9Gf6vh+
 5IEC54N/kcwT3R2pr51w054f6EGs56Ns6k1O9W0Du+5tFp0xW8nkbBa/A+ohTi2BPF
 QM7gpzxTWucPfggRaik0huZK6GtVgSeAuvrfddZDrf1aiPXV06+iqNp7V8yzEiAjJM
 wbNzC3B81YbwQ+af1iXZ5BYmXyW0wqcg6ns3hzUrK9LmIioUV3e87/P8knNpRfW9AM
 zC3fwJIZIHtGg==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 91AC65F8C0;
 Wed, 04 Nov 2026 10:42:58 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 4/5] tpm: deactivate only unsupported banks before PCR
 extend
Date: Wed,  4 Nov 2026 10:42:37 +0100
Message-ID: <20261104094238.519111-5-tkirchner@emlix.com>
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

