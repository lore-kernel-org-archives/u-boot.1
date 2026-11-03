Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA10606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JgziEhZM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muUz+QOe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A68060778;
	Tue,  3 Nov 2026 07:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hn_bL9L2JgQv; Tue,  3 Nov 2026 07:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EBC4606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689998;
	b=CKP96kmoeJJSXRw+EFMQYV1f4yDN8vDuVenaCmH+TwZ9Pe7KC8OK80FV6p271Fz3rq5x
	 4deP5Qo0SJnvEf7sOEaFnJnEPSMtfVLiAGZfvxU1Rq2YRt+CMaPgewUeZRYBUXEnYiHzL
	 xJmpbD6Qo70bnSRuzp4i7bpIK2sxHcXSgdggfuNodbsS6imWWGmXVXSp8QjS3U6RUOYvV
	 B/9RXcT+u98tVdOwoA9pD9ljK/Lzv0U9rEjJrqHCJRtPcHUfPVQLa3pz7vwxHa7x9HebT
	 p5wkALmSoGonLP3dKFl+fxr0qr0ASh/S03ugSPIli41Vvl8esGXAkIWuNkXsJJGtozg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=S7xXajKJrC5YYlZTydYLb6n+WMAZzrk6FfXYchLrG94=;
	b=YGUxvTr18En3f39DTv4SoSezLDMp8YZviSgd4sfyzxchc2V54DATQpGROIf3O2MePjZR
	 7SIzaXNB/TrIfiyM9bSh0t4YIOcos7dqtp/+/TWW6kHfNCWqF/uDoEV7zExaZZIYonHrC
	 c/og88yPfcLSwjmTgaL+bEniKZ0spTRHx7b5z3S92UErShjIUIZI+xlLsgzmnL5P3kHzk
	 M/qZ94Y06NlYvPOELGiLtZh/b88igyI5lI22/KQ56iiceu1C7dEWAVp269CJ3E8NwUXqA
	 z9MoQr8EHNXX/TmRBCfmrK7jx0uJomXFX0YTcbiNQQcMc/VpMv9HGi56DNzx3k297qg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689998;
	bh=S7xXajKJrC5YYlZTydYLb6n+WMAZzrk6FfXYchLrG94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgziEhZMm1iEY7cE6x8tCz9XwSimw5ivl6rl+6Z/rICSTaedjw3m9nk/rYf9ZNZTW
	 4OxnaP5dyzou7/b3JcPbYfAG74l14EhKLdLdRF3ibuyYXh6/GFpRJ2mDRUxP6j71RD
	 s0f0XDjF/bI7eiKLprh5+46KKjK5oEqSe8Wz3VymZH+9/sYjgf9jlMcYwiI5p4h/zy
	 NhEY/wxmPELJTC6EJuFjM1UG5P7U9J7nqC4NnkOv9tNLt2jh3+ojNuv2TakV1GLLlb
	 G4vOBp1iRhDg+CfVtV5TGgW6MGcTWeHxrjU+A7CibXX8ztcPtdxiEADPw8FS/9nAsM
	 5z65m1wqIdAJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EBC4606E9;
	Tue,  3 Nov 2026 07:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9969F4BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C7D74058A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QcWi5FYZHrAb for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8538140589
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689995;
 b=PnCAqjP58JvcAczF4h/KwsuufN3eEHFEQGvmhf45pbxFoUEQ6V5qTzvlIVWgDcL14hcq
 J/jsGwTOJaGcOB19HX/BT/rcclyPrSv1ThMoFwSXFm+kPu9E+AAdMBdn4TFBGNFPPRi53
 wECzNXVnJOkmUEF51s28xZndx1hnHWl55NW3Df6hcLkzlLDjr3q+jX0W1pkrAbwRL5lA9
 84+buEpGEFuTnNBxWwLAyHRQQNxTMhqaHCnTMPHUccTuQW4xo/YnKEZk2ClPT6HHbHLnN
 IO5fbkPmgLYFz5ZjT7HhFfEsGUp1pTgEeumX+nk+fL/TzLqytdzZb5pJr35vKGCxStQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689995;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=S7xXajKJrC5YYlZTydYLb6n+WMAZzrk6FfXYchLrG94=;
 b=mao/mwuow/xU5bixl58ot+1IT+M5Amm9fS6ftWMLw1HHUjfkld+cGAzQz9Q7wh+Hj0jD
 P5xMS2UWiZVMac07H6uOaoZR1Ubrn80RCB9ip6l0hTvkifvzDw6Wl9wdjKSELiYdHUt9S
 +mgUFu8cu/CL1DaBQMrjnBcAilmnWBHfgpB7pYx8nSBHYL1w/vs/Rom4akZAcyumOs9jK
 jW4QOcKk4Dzh5k0YtdON3rN3EfCd0CPHg+N9s/492NqmrlITq4ZUUHmgSGA1Lvwnzsnmp
 0GA8IcFRC8lPgnq+4nSUCrCsmsUR8Kzra0mDGHHww20gn0MgjWv3NRSrctpSUKBzhfA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=muUz+QOe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=muUz+QOe
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8538140589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:15 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so33457385e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689993; x=1794294793;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S7xXajKJrC5YYlZTydYLb6n+WMAZzrk6FfXYchLrG94=;
 b=muUz+QOeeaNm7cxJK2Rr93h5PCMzb6A3Y3voG6UoKeA3P459ft52aGIm6tUn12Z5So
 ZYXxAUN5mAci/0elJZ6dQY59zpdpLR6O8B6A5KlNLQqKp6gRtj3BhsZQODF/b/E84TUr
 Q6t8vy0e7i9CwDP9I+a5QMyd6HTE2FRLmPW3hbQIEy3tlbZs041Adg463ADQ6ILk+0sQ
 DzAHdbkgwP4f9UABo8DFM+r4rS2vax7BKO/L33u+ld453jDNmL+PsTkdq8c//zJjaxGV
 EjQ+HkN2PROzf8BPiLdcEq75suEibb/XLbna9LGiN+hG3mLaY7hRDZC1Xk2QolWt3d8u
 LzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689993; x=1794294793;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S7xXajKJrC5YYlZTydYLb6n+WMAZzrk6FfXYchLrG94=;
 b=tL3+tN/6kmepNxYNNlMCZ2oWnjMiYPvW1V1IwgR5UVhRH0LTAQJPbrzpmdEzw5qHJz
 oqtZRPiZ9Iv3CBNdwvWNg6Ejx3cljEKADQ7CXyWRnJl/gIojiMALAbo3EbpahYg19h5V
 vN3sFyk+RMxpZVdxZeyG6aOstM8duXFgGzgK86r910vrg6sJZVT21d01Vt/xFQVz2+oX
 kN3AqOot6l1daT3/j/7NMBBzn65OWU6RXQz+Uin/3dC3Rw5c2u+SaKTowewhxi5yvYAd
 BuG65I42NKqe+Z9vCpLX7T6yIW52PQ5dOEcfps7GbHFRpR+nTHLtOhRnCbXoQA5s/fp5
 VO/w==
X-Gm-Message-State: APuU4Z+r20pyvDwjZlaqC3/lRrevHokuciHJbwMuE7nU4Orcg90E2UFI
 oCTN96jtMWL7hf0CtBTRgj3eYUYJqBTf4/v8Kua4kjOaC/ittIdypuLsjAdwlkiICydmBd5y
X-Gm-Gg: AYBFou2ZJ9kbzQCM8EpW2a6YsCiIvFhabslkYzSTJsq39TKvY2HTd1tmg0Kpnv6qmHX
 /M8dNZuYDV01WijiJIuISjR+yJXrq/Sxrycz5neTMeVX1bWOn0bhjEZOSy9wfGo2cez78sGAR+M
 mCt8clxMsuA+L1k+EyN2J5BW2BWikCllknY2bQ4fB+wCGge6SCKRlHXDz/7dxuujWeMW3nwGsdl
 RRE/zScXmRhJucZz6/nM/tRG5GhLqVw7wspOH3BmeanmK/QVXiiKvGgXXm82C39wbSVFmGdFadY
 fWhO23Khu8nE16KlY9yKvC1idv9ia0mSiXxSHfpqqkHamF+aoXqgrl9OLViuiDK/cm9ORxJNWY0
 qcFCTNYKtvoUcAgmf5OTR1K3eOXyDiYthVDAfTlshlN/kQkay/89PpUv+9n0gzKZTv9i8/m140e
 XMTZm+9///qA8tk89xAokSYxBPZoBBYrmllY1lpZfCeMCgzUU0afECUkRBHEgUq3VbcaiW0rI3d
 mLObzgPW977mfMBydCn5Pv8Fc3SZrLl7ap1bLI2gMRz7IjBL5k52l+plH1I0jc5YQVjQBD1+7lI
 1has681XTtdo7GcKuupG06DKrdh8PFY=
X-Received: by 2002:a05:600c:138c:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4ac18c740c5mr265582705e9.25.1793689993062; 
 Mon, 02 Nov 2026 23:13:13 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm250885255e9.4.2026.11.02.23.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:13:12 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 5/6] mtd: ubi: fastmap: bound the size of a volume's EBA table
Date: Tue, 03 Nov 2026 07:13:11 +0000
Message-ID: <5d9e42d6-506b-4046-8df1-a1ccc11721da@gmail.com>
In-Reply-To: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
References: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

ubi_attach_fastmap() reads each volume's EBA table header, then advances
fm_pos by four bytes for each of its reserved_pebs entries and checks
that the result is still within the fastmap. Two things are missing:

- The header itself is read without checking that it fits into the
  fastmap first.
- On 32-bit builds, fm_pos is 32 bits wide, so a large enough
  reserved_pebs makes the multiplication wrap around and the check
  pass. The loop that follows then reads up to reserved_pebs entries
  past the end of the fastmap buffer.

Check fm_pos after the header, and reject a volume that reserves more
PEBs than the device has before using the count, which also keeps the
multiplication from wrapping.

The SPL loader's ubi_attach_fastmap() in drivers/mtd/ubispl parses the
EBA tables the same way, and most boards that use it are 32-bit, so
make the same change there.

Fixes: ff94bc40af34 ("mtd, ubi, ubifs: resync with Linux-3.14")
Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/mtd/ubi/fastmap.c   | 14 ++++++++++++++
 drivers/mtd/ubispl/ubispl.c | 17 +++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index bbf4247d1f4..ed9adfa5209 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -806,6 +806,20 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 
 		fm_eba = (struct ubi_fm_eba *)(fm_raw + fm_pos);
 		fm_pos += sizeof(*fm_eba);
+		if (fm_pos >= fm_size)
+			goto fail_bad;
+
+		/*
+		 * A volume cannot reserve more PEBs than the device has, and
+		 * bounding the count first keeps the multiplication below
+		 * from wrapping around on 32-bit builds.
+		 */
+		if (be32_to_cpu(fm_eba->reserved_pebs) > ubi->peb_count) {
+			ubi_err(ubi, "bad fastmap EBA reserved PEBs: %u",
+				be32_to_cpu(fm_eba->reserved_pebs));
+			goto fail_bad;
+		}
+
 		fm_pos += (sizeof(__be32) * be32_to_cpu(fm_eba->reserved_pebs));
 		if (fm_pos >= fm_size)
 			goto fail_bad;
diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index c3b964b64dd..9293dd489a5 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -612,7 +612,21 @@ static int ubi_attach_fastmap(struct ubi_scan_info *ubi,
 
 		fm_eba = (struct ubi_fm_eba *)(fm_raw + fm_pos);
 		fm_pos += sizeof(*fm_eba);
-		fm_pos += (sizeof(__be32) * be32_to_cpu(fm_eba->reserved_pebs));
+		if (fm_pos >= fm_size)
+			goto fail_bad;
+
+		/*
+		 * A volume cannot reserve more PEBs than the device has, and
+		 * bounding the count first keeps the multiplication below
+		 * from wrapping around on 32-bit builds.
+		 */
+		reserved = be32_to_cpu(fm_eba->reserved_pebs);
+		if (reserved > ubi->peb_count) {
+			ubi_err("bad fastmap EBA reserved PEBs: %u", reserved);
+			goto fail_bad;
+		}
+
+		fm_pos += sizeof(__be32) * reserved;
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
@@ -623,7 +637,6 @@ static int ubi_attach_fastmap(struct ubi_scan_info *ubi,
 			goto fail_bad;
 		}
 
-		reserved = be32_to_cpu(fm_eba->reserved_pebs);
 		ubi_dbg("FA: vol %u used %u res: %u", vol_id, used, reserved);
 		for (j = 0; j < reserved; j++) {
 			int pnum = be32_to_cpu(fm_eba->pnum[j]);
