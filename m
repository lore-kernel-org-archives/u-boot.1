Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2451606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nWXFzxhR;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=c5arrWg0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DFA560831;
	Wed,  4 Nov 2026 09:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HoYwlFlEI0l; Wed,  4 Nov 2026 09:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B363A606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785417;
	b=Pr3F+0RPsvh9UFnuBs05LvtAGhqcMmUZSWPsXgZqPid26zpfHVJzX7IrVJdSPoaVlnp3
	 Wd+LxM5rTLQHBhtHhlKCmpvfGDziYAQLqJ1d1OXPb+U39g5ZcvcFuaFL7ue+lisaWB2+B
	 OUhLpm4oZtRsmedE4PprWpVHiVgAr2rP/vL3bUb/1NZyInYSEThwJgWp2oksoaZCxG0/i
	 1zDKo0/z539c4QIR9ZM0fSVPgpOo20tcfvNdSacAcpJv/otYn6g1dzv4O0A3/7zH9Sfm4
	 ViyEiVeIuerIE/d/UV6jZAnLYRD8vF1p/r2Iw1h4Lj++ODDB9IjGqNrwhBrcuJDaMXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
	b=GaQMpK2bCvdBeeG+PSsy0XjrYIzOF9MI4w9ijbrp8J+a3IZrb8u1uNlN/WIE6HAI8kfg
	 PkuHrLdM7YwaJeJjDo1OsLl2c591L0Q4OKeL40+XFQ4h+DLMteobJNhR6PaX4RtVXeX2D
	 9zdRiHt3dA84Hg1db8rOsboTExkwQ42eBMWE9hC3hArfsIvW2prBhZ8AJZGDrch9V/D4p
	 iC9xJusketC7g9ventcmYycD2Xuerhq5GfK9TQh+/PCmgkbbcdzlyMYRYPz/7jEzwjf60
	 D6XmR3OwsO+yuPNCkU/XV366b3/evCdFStcKFrbz6VEr7jZRYlV3irHnzkRBch3xWsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=emlix.com;
	dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=c5arrWg0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785417;
	bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWXFzxhRD8nt4gmO5B0fYNURJ9wSOF1HL1NNrmzEwtqybwgfOj7cEnbcrFsmYwXAA
	 8CropvBjEbINBeGhpvk6ml+3KngKaspW4KbOGrEoZMUy+bEMhzD98A8x/sC2qCdAoE
	 ie69FyI4hSbOruPjYQhB3me85cOhUF0ViFKH3nRRPVzsRfTUfIZ8/o/Qk/opL5eXhG
	 pCWQDk+1q9o1HK5vKADnpoMM2IG9KO+u33mKyPODy6wLu5wAEb6SLdbArAGePFxLTj
	 v4NxBSmqzKeKWYxG1BeDsw0zfn5zfio6IkI507qRJv53ovJigqNrh7z5YCvEkPIW3A
	 fCru+xcB8Rxcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B363A606F2;
	Wed,  4 Nov 2026 09:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 683E02B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5948E606F2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OdegrDzgJItb for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:43:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97F21606EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785415;
 b=Xm3SLhMxFcsmQMZ03+d/QP5QZAXgVwmo+hz0LXWtRkph33lXnAESOnz+SMozcr/DsxHa
 EXUF2d6oqyJaCmz+S03hai6JBVh1FDA7uxPL/Ofxaq6G5JM7ig2V6CRkVWZd8VUaBAB8+
 IKlrK4ttIixlk5Tswpm9HKTqMlA+rfvI3Dv2ZA+KvyzpNU3VsWx7czlurPiCpQtV9qUX/
 eIS4wN7ZnK9GayvAA4YVDYQWe90N0uPdkhRlBACiUiKJlbCWTzvp/xj+jJmdFRoOEXupU
 gdYY9VoAlzkR1IhANtU7FA11q2UAltH4T+2wsTZsf2sXlHNVHis5l94BLX7Kh9Qkxbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785415;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
 b=pVQzjq4iXutFM7pLgFL5c44RoL/wFcQ+T3uSAxH60Wn5oAtnlDm+3cTgtslB12rh8gAa
 Wcru64VtP8tLTVhuZrw/OSLyfjotC2QBeYTO+rkVUsmQHMZJGZ6tIvgtS51X8kco+FPJx
 q1rwtKm7PuO5dh6ELopAN0ENA5m7Q/mboTKA4kowCf1aFy7H5smNJSgsUOdHUft7hBxaf
 XAptYSa7Td1n/FU5otIb5LSBVVGmeH24mq7f4i50N5Pzr42ETQQvviIkBgcNvgz5FKcRe
 xwPSXAPKFy/PkG3SruE16713APQ7VH9GAaTgsmHafX3fQWzyaKXwDZJuiUrOUKijk4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=c5arrWg0; 
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=c5arrWg0
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97F21606EC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793785379;
 bh=iL2p74MrSwDKciZ33jwXiA22TBZ+9n8t6qHYQVVFo6I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c5arrWg0ESCcBJHHdo+KHsJM19PyBKGEPaGk4IhTmns0lSFJbeg+eh/u2HZNffHFA
 uOSEBl6jpzR/vrNO/oUflbXmSgoHVC+saZHodOhGZPHAywC1BRDt+Xqw+cd0jhY8qa
 zzSeFYZK0EVwRz22Rrj62pZUMQSIE1lfX2em/0MOmroeCrSFS3SQ1ea1KMoRBHZjc1
 PlMk8TBgQZMS8hjwf2BOEF/KYZQaZGw0km//UdhUwMwzxOGRtbm5q5Vh53ecBd7J9Y
 AoxF9KfyK9Sr8XGVxqjQBAO+mYl4Gnw0tJyD855XCHwKCdt64dVe3BxdOg2fhzNHam
 kipS1QC1Fo1TA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 85FDE5F8CF;
 Wed, 04 Nov 2026 10:42:59 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v2 5/5] tpm: deactivate unsupported banks in tpm2_startup()
Date: Wed,  4 Nov 2026 10:42:38 +0100
Message-ID: <20261104094238.519111-6-tkirchner@emlix.com>
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

