Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4792606B2F1
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tocII/EG;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ozNzL+NH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 491B960820;
	Wed,  4 Nov 2026 21:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ngG0UWX2PYj; Wed,  4 Nov 2026 21:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34A03607BE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793827424;
	b=TgsaRuxWUiLuMyatZaUU4nWHFcUjKnFceR9DAyUkGMtuW1cYFXkkzxQAuz9BvhSwmjTa
	 N/PNHKsLedK36dJc04cVurgQ9yIqrOGz+7lqdjJeNfgMSNPuhtO4QMxBlPEOjZFkPkg+U
	 W5iVWGi2Gy7uVh9L4VO4bBxLPABmlOIdV9e3ufZhYNw1jd63F1b/2z7b2wdEJkkcTHdNW
	 z1c+u2dT4tuCd/LbmrFQifPkqmxuLIAWQ22N8kcwXVmNh0wtrXqca+RVgxPObmcT7TQK7
	 uMHKnspMRBbu8REgTqGfTVO8ypBXFYtWD2ESkTYxPl+YFUqpS+BMHuFRHv7SAke9lcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793827424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OPHgPKSO9q8pbh04e2Euz8sOVZQfN1ns8TuYkOtruV0=;
	b=neg7b4GDYoZ5iTgg7FX+QPs8ZcnncPsmR0M919M7v5+C6uYL4LjTt65qkwmi+nddfiGW
	 1YNyjYXdf3KnYqY+IeMruAGGf3si8RbX0CL2E9g5TIl9n+u+wyeeQQWQLcZ55GIJsT1UV
	 v0R9hi11wjdrQkBbQKyqK9zf4lGFPq0mgvVDf7x3coXUvoR80MYWBUydtNp17ytmDxMvF
	 ey4uJdq5KleHNPuxK0g7jmJ6jMBMAAAj8bjlpKHvD/LUSJU38MJz4tccDbPYbeYK7hQC6
	 MMZK6dWesZGt3GqoT6hpNmiFQmP72aQ2DGe6plMYtpbRufu5enNqx3z2wfxrtgKBv6Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793827424;
	bh=OPHgPKSO9q8pbh04e2Euz8sOVZQfN1ns8TuYkOtruV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tocII/EGX5WY5VekqxUxWu+5123SUm1nTVyerbo3ZtskgYN0GIAO/oLQltAdkM3UW
	 BoSGbApdwmvZcsaPJKZ5uQhjXpA8MaC3omC68anaEVT3FOWuqFiWgQhrtHP558onLz
	 RY58UjKIsQWz4+Km632E3RBt/Xg5rqA3WdTQ3XNygXru2a5bj3IWodVhLAimalvqtG
	 9c87gtScbre+5Vl+wxO28Hypr8ULHIKmgQTECOfExuj6aoiGp0a1ab/yYo3rWFhvAu
	 gbK655rzQXzNIXXryp4sp653faGje9mYbUlvpDmRXRIcwkaM/gF2L7f1cH7ia1mMf7
	 4C84le0wK/P2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34A03607BE;
	Wed,  4 Nov 2026 21:23:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA086B00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBD8A4098A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poFgVbw5csqj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C43E40967
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ozNzL+NH
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C43E40967
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:41 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so705344fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793827420; x=1794432220;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OPHgPKSO9q8pbh04e2Euz8sOVZQfN1ns8TuYkOtruV0=;
 b=ozNzL+NHpf+2pLdtFd4FvO3LmNvy0GvrBg8hzsg78tmOpS5mZ6yWAEDLli/8yprK1A
 YD+X/3gjsLLLlhB1XwujrM/a425ejnK7w69DPE2ZOLpGg7vM+ftV/XSb9ekt+HfHPPge
 lGHhZuXQCBkihxvFmhXKM6YskpUpcUcjvdBOL/cfcKUGmM7P5whzhtZ+X5xh0c80Dm8g
 e3J+KQJy9vv2mv/NYnyinEUijvfWUP0JJtK6KYyZChnMbdQPWv5t2iHDNIvLNKQGFFss
 5c4Zjzn/IpROWx74bief+COEhmr3hhK8QAQfG+nhIpPVcKIe5a4WypwdzHlY+OLUEAYg
 eA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827420; x=1794432220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OPHgPKSO9q8pbh04e2Euz8sOVZQfN1ns8TuYkOtruV0=;
 b=h5TXnRsvBsA4KhTpi9/AU0nz5eyc9no+cxG+qJ1847B4M7CUu15GcFr4jwH2Tz1mPg
 X/kDNGc0EGFnkKAgezFYDzPMg81MIF17qAe8AjLZTagVjgaIxv39WvQf+B4Fxyv43v1y
 SJDzNUkJBvWuUpJPos6a9i8AT8wULVVvDuOURfJvbqPRp9daYG4aLqoAb559dytqZRUN
 Ydj4mCRtXYhTKwByt0srGjHfKOyDHlTwkJg+AQMgxRx+xxp5RZAmLy9O2SI5/ceIQMn/
 kls5bDzOWm7gyTNwhYl4VJX0rZQZaMiDazbjs/SVrwUnmOVGIk7urSiYZHtOUgRSZgfM
 Csfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMTX0Ctbr7reahWgFTGAeE8D8//fhhor7M9uzjHUK2ttd46BN8cAVvXwWlIEMauBLoQ//y6tE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8kQf9L/ovce1bfFJFz7nla0Rn8tqMmjT0vkk4knjBYj1o8uLqo
 KbD2S+3tRgk0T9MnVDEejh4dN14H8Z7FhPeLzHi/4XmTiLSAsCq9h3IDmIct1UqdQts=
X-Gm-Gg: AYBFou12GBaxNcDE9I/rGut8A/RjQsbqc4pfKsCQp7IqxLMHIF86dDJaFGzawKmiX6n
 vOonQETmtvLSUhwVkNRUnVaFEH6dZNubeGDeR9S25QgMdiEkpijRVIW80EFF04ChfJe+HNz518b
 trPhV/2EvvA8dTa78GGNdrXgWRgjxKOmlkA4Jb+ns/Ju/scWL/EQuMRTvq6Cb/DcAG8gJ6esSbQ
 XiMj1tx5gQxg2i9L40TW9CfIJVWMQXmKCbXcMobdduqkZjhaIPyc00D2c8sKYc4rrDki2tJJbrA
 aDQaIjMqOFG2S5oE91pgEaG6Fmm0u9CGoEurD2i+pw2f45+pmU7R98GTU81jocdI1eRRG7335ku
 feSDcraiilluX+qCAgmnb1FGiWGlFckCGDTapzBqM4I5O6AH/RfM53JFhyWHN9MzbuoUDrjS/Oy
 V/oI0BmEkFy7dA5Z0ujs9QlwgkKscnCrlb9NRWRBwVVeknng1vjj6j4PuhkYvxeavHY220hBLD6
 C6694FySUEZCd1kTsgX8rhzERo1qBBN6M52AFmtJ7fhmXRxXxTUCnFhSZozXvQAZtkLIY8z/2zJ
 QBq2VkCoucwQ0GjOLC8ptKdNKHDGmokP
X-Received: by 2002:a05:6871:e78b:b0:492:1de3:785f with SMTP id
 586e51a60fabf-4a9077982a0mr11134186fac.46.1793827420036; 
 Wed, 04 Nov 2026 13:23:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad6840797dsm845548fac.9.2026.11.04.13.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:23:37 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:23:09 -0600
Subject: [PATCH 2/2] bloblist: move to version 2 of the transfer list
 header
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bloblist-tl-fixes-v1-2-477121908257@baylibre.com>
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
In-Reply-To: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4663; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0DrGpo8TjDNKtqfl2If83vMDmNXUTYWX6AV8BAFPQhQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66JLb8SCLMB354zae9HuYQWUVgPA+JlMVNNrV
 AEfb7w4ytqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauuiSxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHw4H/0KyggTH+Ntos+4qJ1nkOw3hUOHu/jEatoDXdph
 K1m9r7lRutyMd3KmjgrRt1A35UP2WiNdWrtECVjpnZNU/Irrk+AOjduicFvWvMxlsfn6t+eZDqs
 A8luQ/QsnoEXyTA+7N7zF4RKAyj94bG67ovVSyms7PoFMMHkQ8LQatoP5P86v7wNGGCSnNHdA8c
 TToeM/0cpI6WaOiQv3B7aoHREtikGg1WaxambktxLSryVSshyNgMg3MZzViIyYPKTKSeVfO++xF
 Z3J8b/k1YEr5CvLvIr7Z06a5fLzxxjClo+kBx77/9dWkx6b8k4SQmHALLnumxbAjoI+tExdCCmA
 qNDo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Create transfer lists with header version 2, and accept lists with
header version 1 or 2.

Version 1.0 of the Firmware Handoff specification is withdrawn, because
it specified an XOR checksum while implementations used an additive one.
Version 2.0 went back to the additive checksum, which U-Boot already
uses, and changed the header version to 2 without changing the layout
of the header or the entries. Since TF-A v2.15, its transfer list
library creates version 2 lists, which U-Boot rejects, so it loses
everything that the earlier boot stage passed in the list.

Lists with version 1 are still accepted, since existing firmware creates
them.

Link: https://github.com/FirmwareHandoff/firmware_handoff/commit/dfb62d83c735064291a249d802aabcf48bffb8a0
Link: https://github.com/TF-Shared/transfer-list-library/commit/81d7f820853aa117a0458ada3b9892c619233db1
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/bloblist.c      | 10 +++++++++-
 include/bloblist.h     |  8 ++++++--
 test/common/bloblist.c | 21 ++++++++++++++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 4ddb4a56944..90b70b06826 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -467,7 +467,15 @@ int bloblist_check(ulong addr, uint size)
 	hdr = map_sysmem(addr, sizeof(*hdr));
 	if (hdr->magic != BLOBLIST_MAGIC)
 		return log_msg_ret("Bad magic", -ENOENT);
-	if (hdr->version != BLOBLIST_VERSION)
+	/*
+	 * Lists of version 1 and 2 are implemented the same way. Version 1.0
+	 * of the Firmware Handoff specification was withdrawn because it
+	 * specified an XOR checksum while implementations used the additive
+	 * checksum that version 2.0 specifies. Both are accepted for backwards
+	 * compatibility.
+	 */
+	if (hdr->version != BLOBLIST_VERSION &&
+	    hdr->version != BLOBLIST_VERSION_WITHDRAWN)
 		return log_msg_ret("Bad version", -EPROTONOSUPPORT);
 	if (!hdr->total_size || (size && hdr->total_size > size))
 		return log_msg_ret("Bad total size", -EFBIG);
diff --git a/include/bloblist.h b/include/bloblist.h
index fcd290eeb16..f368a6acb85 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -76,7 +76,10 @@
 #include <linux/errno.h>
 
 enum {
-	BLOBLIST_VERSION	= 1,
+	/* Version of the lists supported here */
+	BLOBLIST_VERSION	= 2,
+	/* Withdrawn version 1.0 of the specification, still accepted */
+	BLOBLIST_VERSION_WITHDRAWN = 1,
 	BLOBLIST_MAGIC		= 0x4a0fb10b,
 
 	BLOBLIST_REGCONV_SHIFT_64 = 32,
@@ -179,7 +182,8 @@ enum bloblist_tag_t {
  *	blobs can be altered after being created, this checksum is only valid
  *	when the bloblist is finalized before jumping to the next stage of boot.
  *	This is the value needed to make all checksummed bytes sum to 0
- * @version: BLOBLIST_VERSION
+ * @version: BLOBLIST_VERSION, or BLOBLIST_VERSION_WITHDRAWN when created by
+ *	another boot stage
  * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
  *	first bloblist_rec starts at this offset from the start of the header
  * @align_log2: Power of two of the maximum alignment required by this list
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index ef410ca62fc..3ae5eef3859 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -69,7 +69,10 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
-	hdr->version++;
+	hdr->version = BLOBLIST_VERSION + 1;
+	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
+						     TEST_BLOBLIST_SIZE));
+	hdr->version = 0;
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
@@ -92,6 +95,22 @@ static int bloblist_test_init(struct unit_test_state *uts)
 }
 BLOBLIST_TEST(bloblist_test_init, UFT_BLOBLIST);
 
+/* Test that a list of the withdrawn version is still accepted */
+static int bloblist_test_version(struct unit_test_state *uts)
+{
+	struct bloblist_hdr *hdr;
+
+	hdr = clear_bloblist();
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
+	hdr->version = BLOBLIST_VERSION_WITHDRAWN;
+	ut_assertok(bloblist_finish());
+	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_assertnonnull(bloblist_add(TEST_TAG, TEST_SIZE, 0));
+
+	return 0;
+}
+BLOBLIST_TEST(bloblist_test_version, UFT_BLOBLIST);
+
 static int bloblist_test_blob(struct unit_test_state *uts)
 {
 	struct bloblist_hdr *hdr;

-- 
2.53.0

