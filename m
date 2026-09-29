Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62625CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 124FB6072A;
	Tue, 29 Sep 2026 04:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1b58hfSqFfS; Tue, 29 Sep 2026 04:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D276A60720
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790655471;
	b=DaiZw4MThFMm/sr1spGHg9E4XR43qMVCSOn80OijqAKropksH3OaCfEWLQU9cCujd/6k
	 /0CjI3UqsYBYkiTfana0pPZ20mRMWRHcSE8iRvglxf7Wfk8qyFUXggKq5Elle9E00Pz9Q
	 qApr7hwyYn5UXi02WEYcdXzn2pd4AawNvuNQoPG4sV42lhdWzplt0m2CXmm7SdQi4rxOs
	 d5oFX8ZyKLegzj3oWRyx1n/HAn8PIBVP6w2498JdeRBB896DAun6VSRH8V54RiK6dHa+X
	 WdRMfNNjVYnoMRXoxokAgR+fF+WJWt4BLWX0LF0zUCvsaqJUJOiEGITz3HKoCahvNpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790655471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=buCuZwwNRCx3kAWcZY/5xFNW48Bbm6s3WTN5tA1GztQ=;
	b=fYnNyQ57+sWbNoqc6RyUSdfQCraq7RzOw1So52kDzY9b88xuiiIbqC4eTB1SGlVv/Puk
	 2FnDtK5GEV8JrTlgTgrY87zLegTpFcHU5GNNiFIBpWDDSYZE/gi2w0atCKLGuN5vFUokP
	 3jFVxcAG7XlP34rQ8TP7mctrfcEVMv3VGQYWqJNCXOio/z0V1HcvqdZWSg4mGMUOiN/Z0
	 2bForSZ6YAUcQLLECprfK+8t1Qx96G/p0aEWCEf3x6iTlSjCClsHnKulTgR205B1ik7As
	 9G/RZDSIt4mo7VJyNq/IsVoYjdiPoKALhlb1HNiiN3H10r6bEZME4jbHsu0sSI8WiDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=UKLhlFIe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790655471;
	bh=buCuZwwNRCx3kAWcZY/5xFNW48Bbm6s3WTN5tA1GztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BUaV425gdpiRVfmU7vKVyQXhTofyiNn990UPAJo5BA7B4hmZPQ2tHFUHgX7EmE8LW
	 kV3UvuYo7EKkkGKqE+ZOsvXzb4HUliVOb9LMm9GAQfTi3cyemM5j8g3lneSXEGUz/B
	 tKv0BetEEFaE1+FeknzTFa3D1ETaL6dqdQ59zSctjJiQYkUso71u1D0CSDGi+40o2D
	 t3MO3DPmJiHXROiBpFa9V/QJn4iq9xb9lgFcr6izAxlK8H7jYskfbs26hOlMUPn+rE
	 pkDSBCr2dvHYHiBcqYlSKr9kdMHSFOznTeVUyWEdKwf+I6rPBQs8Kz3QOawRdprE5u
	 DYs3D35nDlJjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D276A60720;
	Tue, 29 Sep 2026 04:17:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46306335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37D0D6071A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39dZbvYwY-sr for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5414E6070F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790655468;
 b=Oxzn4byY06v7tdEM1EypXmmlH/Bhy3b/+hnbvyfZC2dY7xjKKtw33d7g2VFXjdlbDoCr
 G+zEmzqnFNgHWvxcmfbPRNTRgSWzBo2Ru46lTiL6iGmRbAutippHzL02l9jVMm0/Wlhg6
 BAdV/ieamL2Rn4j0cIOyuO6TSdqqVBYIP+k7MsHVNwrh0rR4lu+jrdES923z0j/hlW3iW
 YFWfVEKPmzVqnTj1WFnrL4E8StS8S1p4yUu5I20SzZzoYgYXInh0qs4QwVPeQGNp5XRBZ
 jGmlVWbOqOpv7XhaSODbpIjhHeVohkzM5CgzpkH0xOvvtjaMgZnXO2eIoEvdSPgFSFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790655468;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=buCuZwwNRCx3kAWcZY/5xFNW48Bbm6s3WTN5tA1GztQ=;
 b=gQLr4BLwHxYixKkWyrsS43WeRQUnqQi81aYVzXaXNo9aWZnNyVTL4TEjUL/KaA+/5z8d
 i4yvslG8QWb3+H1u1wD0ruB1bNqDqW6Nvl1kQZA4eLwM69RbBebuFCxXez+9VQz5Z+YT2
 vOAo/0hDrcokNt9PV6vs2vbshdsdA7OsVvgQsavXGAB0pPy+uakiw7zN/QygdHrlpsuvy
 7rRzRfYrL7cMdQ38qxm7OwKfSq8+RI6iDH23E5edS+H8jeiijV2QhcptKWYypNCMMoFWs
 nqwnS1Dm2Jn5rYmZN2YmzEzmPk7zdEiIk4+DDbME0o9qNdE3iIle+vpfojNae7i5BEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UKLhlFIe; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UKLhlFIe
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5414E6070F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:17:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A6A091066D0; Tue, 29 Sep 2026 06:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790655462; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=buCuZwwNRCx3kAWcZY/5xFNW48Bbm6s3WTN5tA1GztQ=;
 b=UKLhlFIe7a339Sk+Jv6miXNFQNupiIbpvXK1dkUFVTvdP4TuY13TQ/8zZYDwIflGD8soSU
 IkNMjaYuSKw6G8zKBHlj33nIBPnOjwv9WuYy8exz3TZjqaw2Y2sQoSb6QIPVdUp5DaTaWC
 yOa3yx0h8JSQC7iIXXLE6H8i6Op7iY1pu62Q73S1+N5Wi9lH3jLzsGu0yHJ5bsBea3jVcs
 lVOtMkpyYFSE2pN+XUa7x+Nl7CeMJz4y2bh/bnD+pUWjq3Fp2akJEF0jZsa7QhPdqhYTXF
 fbF8Jwe7wbQm1mCsjjADn6Y1XZCgwhdWEFMe1qot8SuQKVtIQTxHwRQ6j9ZQMg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Schocher <hs@nabladev.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] imx: hab: name the event left behind by the boot ROM
 RNG self test
Date: Tue, 29 Sep 2026 06:17:17 +0200
Message-ID: <20260929041723.1383361-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929041723.1383361-1-hs@nabladev.com>
References: <20260929041723.1383361-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The boot ROM of a few i.MX6 revisions runs its RNG self test
incorrectly and logs an event for it on every boot. An event that reads
HAB_ENG_FAIL on the CAAM and nothing further sends the reader looking
for a fault in their own image, which is not where it is.

Print from where that event comes.

Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

(no changes since v1)

 arch/arm/mach-imx/hab.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index f92f77670a8..35c497619d6 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -421,6 +421,19 @@ static inline u32 get_idx(u8 *list, u8 tgt, u32 size)
 	return idx;
 }
 
+/*
+ * The boot ROM of a few i.MX6 revisions runs the RNG self test
+ * incorrectly and leaves this event behind on every boot. Say so, so
+ * that the reader does not go looking for a fault that is not there.
+ */
+static bool is_rng_self_test_event(struct record *rec)
+{
+	return rec->contents[0] == HAB_WARNING &&
+	       rec->contents[1] == HAB_ENG_FAIL &&
+	       rec->contents[2] == HAB_CTX_ENTRY &&
+	       rec->contents[3] == HAB_ENG_CAAM;
+}
+
 static void process_event_record(uint8_t *event_data, size_t bytes)
 {
 	struct record *rec = (struct record *)event_data;
@@ -433,6 +446,9 @@ static void process_event_record(uint8_t *event_data, size_t bytes)
 	       ARRAY_SIZE(hab_contexts))]);
 	printf("%s", eng_str[get_idx(hab_engines, rec->contents[3],
 	       ARRAY_SIZE(hab_engines))]);
+
+	if (is_rng_self_test_event(rec))
+		puts("\nknown to come from the RNG self test of the boot ROM, harmless\n");
 }
 
 static void display_event(uint8_t *event_data, size_t bytes)
-- 
2.55.0

