Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E666606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iOwemGsi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRw7Vu8Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7648080D16;
	Tue,  3 Nov 2026 07:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUcmvQxDjvKO; Tue,  3 Nov 2026 07:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6BE880D81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689983;
	b=ElK1L8S25RK+1w0SQRakirFVFC9FEfDNrjFdjw/MbPHh1a9Rt6Rm0fbtYji/P6KSHK4B
	 g2QGY7pcaY3wdKdhtuQqaqlZJ5eblx+KoeSHmkwZJlr+WGEPGSIqOrYmi8NF8UhRew3Ss
	 p4EYmmiwePm8XcQohTjTP26kQINrnHKhyVrPzFuwzxHMPjKFiCwxbl7qIOsbzq0bN/T9e
	 NnJuFL+CSpLgN7FZTNik/Cqu7nSKCYm3378Ruv0/c2YxawS2o0d6GnOUw2vfdQuRpYbut
	 6+wWtq5GhygNFxwqiNfidhhneE3ghPFTjz7rRTeKZwbeS1XZJQCSOVn2UOLvp2A6urg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dViYdR7gXYlv+KYej821undQOayaQ+HNLIUlby4h0wI=;
	b=ewHltJjqIOH0pBK1Cs2a1/QqGBEePrY4tzIqY5TzkV71IFx5mfagW/hdBCtvF7QnHPZ/
	 1fSUWJfUxgydT+tFBk8x/O10TpCE3WnfEfr8owzmCTgk2I4JpBxmdi0/q/oCEy1vZw4Qk
	 qhLQj5ID7otsZKJLM2suGcLNTnlAAvLWE1heV5XTIU5URHnkJ2ydKcOyTKFuRUIm2wR+2
	 wAkkotRoKuYSm4yHJ7t20Y/bLRCaWmj+JIknZ2J3o54C/lDkrved2zDN2N5Y5rqwJfqwb
	 ilIp2UVuRedxMi4lg490bTpNljvJ5WM7KFumO86rMeDgANuVUj3iIVIZphp1pYpKRGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689983;
	bh=dViYdR7gXYlv+KYej821undQOayaQ+HNLIUlby4h0wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iOwemGsi5n2nqSKieyhfjk4w6JXsT7pzcssE2Omx/1bRP28eKxIJVZVNKanK9F2gK
	 VNJLtr8Su+4iK7pAnHWULZ+dYZYluFLM0mtjmYIK3aERrOGFlgPx2y8zZBMeDl5T0K
	 TsIqbnbus44Y91035QKWYFn05Xwm7JEKlDQ7KPcmaVhxrATq7NP+5THTC6MItbSI7K
	 ONSnhKRHOgvhMYnGaiA2yexJUwyTd5oC7fdq5p015cJ91AqHu6fPjVmsB/UQfetIEO
	 gba3WvKYNlc5ixzvNgACaPV3Rp511d1FvqcfsR/OSLYk9uAoZTmjTaExmkuGh/g4CJ
	 qT5GdMgCMaoJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6BE880D81;
	Tue,  3 Nov 2026 07:13:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19A5B235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFFF260777
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olEEm5CYSGR7 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0986C60768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689982;
 b=VdVRLtf3gR8zvkbFsrMAkFlUtI1H1kpd67K/WWMMoBTwW+ATK0uxMkPY4VuR6GfEnjKC
 gWDYIR8JnWU/O7nTWMR1mSaf9NI4MrL9TvmhDTjqMqetL1NiqALbuwQhTtsEKrqUzfdTX
 sDFlPLsZqOgc+TJczDiR0pztcq/fvw0lZMZEj04e6Piktwre25L4teHJFUPog5rg3SLAd
 fhvag4qy2011C7sQBSzmxea++aJ2OaXnWA7lFeVrNj1iGy419III5JTlHhLruUYVD2LRQ
 pLptLG0g0tKQOALY7Q8RR9WUKFOw6+StiBjmd90kIkh61jjkgRqcQVJg8TzXaTmTuUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689982;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=dViYdR7gXYlv+KYej821undQOayaQ+HNLIUlby4h0wI=;
 b=I5jV0Wog/377KsE79CDN9n+xp9YrfhQ9IL9hqRbo/qOmR9/woNr8JjZtIp0m20gUGfh2
 D09i6A8zRwKPHxSyPA2conlNIaltrls6rwXWQs9Ee9bgGfYFU0l0ixuBqXbL8VnUFNgxM
 3NS2MWi3kdo3zKXOuaEjmnHed5I8WmisZv24JZNOGXbUKp3+LEJsf6KVlCE0y/9beDGoU
 BmlLlmNx02zm6aDeKpL1NTP4bM6Hq9BTljDDI0WXTsr+rD9Ct0mkWNubxPyIiquADaAYx
 JNMqU1GY+SjcApH5JQfk20Cis6BllZyfxvJJ2mgYMq92hhGTFPSLepaV3n3mQCNawYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bRw7Vu8Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bRw7Vu8Y
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0986C60768
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:13:01 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso26287105e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689979; x=1794294779;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dViYdR7gXYlv+KYej821undQOayaQ+HNLIUlby4h0wI=;
 b=bRw7Vu8YfLSnCThuYx6hlaS+0exVpj/we/N1+lR0AUkAFnvZ1eHbnTayYK0iC7uDFL
 1t8aseV+yaV/8+n5f/CC4ihCLU4UZE6dFHe18JLjBQWYalMz86kRpv5VtlmsyNkarnJi
 ru6WqSIzsSfrVfm+0DEh+MGdR4etPfCLAcumX/LavMWCKGD93KfZ+rPQgP4xgBAvJfqZ
 aiqdkic+vwkiuMQLm2llr+qTFAeUvRjRgrYTfIW/qNdv1Wkxtuj4laPHY8qOlEdOpOQN
 DG7Xfr+TjU2a9CYHGAZuntukQunvEoegkZMFYAz1P+qroIecScerUG/LUoD6+TsMrMiH
 iJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689979; x=1794294779;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dViYdR7gXYlv+KYej821undQOayaQ+HNLIUlby4h0wI=;
 b=Gs8qE3zzHv6aOLc4+syR1UuDEXPugnKwJW/ZAaDK3TiCtwo5fdrusA5oOwwsE+7iw9
 kA9JsFqiQaYp1etyU4YzyRCj5h2mFrSRwq3Or5vpZayA7YCyKOd4ICyK4i20mjxqsPH6
 Bccs28yrGgE9VRTFguOnuxUpPLWOjxpC/4I6NlLVm0nzqvKuA6HlEEaA1w+BTggwi4cX
 6asCyFlsKDzhZZm2cRcmiwOYRy9RD4ZfVAcINqud3yvK2oO6nMM/783jmG8ZTltM3gGi
 P6/1Md1AV9odbm0vRRicm4yC7n1eyD+55+SrTwRB6mAka2enmkWeUaotIU0ZP52P74Xr
 itCQ==
X-Gm-Message-State: APuU4Z85v2SeAzNUtldQ+oD8CHAh0qI49wRpRVsHRTyrw8O5b4QGHvtA
 QrDYluqzEjFqzPYrw3d+BFkSz4TXTlPY/03yPYLyfHXWTIRzrShvCd6EH5l2sBsUS2d9k20y
X-Gm-Gg: AYBFou0NNsLc76yddEvUz4QnExqnhVNfqdWhoKPMF8Kngik4Qsxan4RW5X3Oa/Nk0D+
 3IO3K1vEZgEhNW5+pFkO66wPjSWj8dR0UUVtaaM67Lepmc7gQjY5ScDIQl84Jxf75asFzSkpqKB
 KoiZKHEL93UfRNn+4M1f/4glf+D74KzK2NXl8Gn8DUT4UFEiD1HI9lngXkHdOfF7QgikXkzXIlu
 Fxw4PWucN6vko504KgS8wAA9yZwXi8jPg4l+aVj/JbnPJ3URo5NKIZU2Rfs30On9eQOrxFt9K23
 JghAwGqKvnQHRQgCcdZp8rx/ejbsLjedRzt2qR1gznFSKWPX1c/8pKsp31jeisyvhNIbyCrZR5+
 3LhDQdin+O69rACEDEii7lQ4csb6GDEobjS8f7xJl49DVY65mJ9NFVzcf1sj7kT3PMqpLbrBPEa
 W1IIzhM9NeRUJkq9M9BsCU+aeHI9/dJwRPhsZa6OblG6DyZeK8GHqEse4mgcXtHejMot+sfpQL4
 7TNWJjTTQZlgRfMmO5m6+uUxVCJMbxEV0iT/iZG4nTe/BCdsEA8yNWRkNKDS5c+sAAvupv8t8Ei
 jh21RXPTLpoc5Y1xmguT/ZJVmNXJZD4=
X-Received: by 2002:a05:600c:1c23:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4ac180f2addmr320570885e9.32.1793689979248; 
 Mon, 02 Nov 2026 23:12:59 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm34819795e9.15.2026.11.02.23.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:12:58 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 3/6] mtd: ubispl: check the PEB numbers read from the fastmap
Date: Tue, 03 Nov 2026 07:12:57 +0000
Message-ID: <be19d210-ddde-4cbc-b991-a299db0e58dc@gmail.com>
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

ubi_attach_fastmap() sets a bit in the fm_used bitmap for each PEB of
the fastmap's used list and tests and clears one for each PEB of a
volume's EBA table, using the PEB numbers as read from the fastmap.
fm_used has room for CONFIG_SPL_UBI_MAX_PEBS bits: a larger PEB number
in either list reaches past its end, and a used-list entry of 2^31 or
more becomes a negative index before its start.

Check both against the PEB count with ubi_io_is_bad(), as scan_pool(),
assign_aeb_to_av() and ubi_scan_fastmap() already do for the PEBs they
take from the fastmap, and reject the fastmap if one is out of range:
the loader then falls back to a full scan.

Fixes: 6f4e7d3c75a8 ("spl: Lightweight UBI and UBI fastmap support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/mtd/ubispl/ubispl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index 0466cc72c9e..c3b964b64dd 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -558,12 +558,20 @@ static int ubi_attach_fastmap(struct ubi_scan_info *ubi,
 
 	/* read EC values from used list */
 	for (i = 0; i < be32_to_cpu(fmhdr->used_peb_count); i++) {
+		int pnum;
+
 		fmec = (struct ubi_fm_ec *)(fm_raw + fm_pos);
 		fm_pos += sizeof(*fmec);
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		generic_set_bit(be32_to_cpu(fmec->pnum), ubi->fm_used);
+		pnum = be32_to_cpu(fmec->pnum);
+		if (ubi_io_is_bad(ubi, pnum)) {
+			ubi_err("FM: Bad PEB in fastmap used list! %d", pnum);
+			goto fail_bad;
+		}
+
+		generic_set_bit(pnum, ubi->fm_used);
 	}
 
 	/* read EC values from scrub list */
@@ -623,6 +631,11 @@ static int ubi_attach_fastmap(struct ubi_scan_info *ubi,
 			if ((int)be32_to_cpu(fm_eba->pnum[j]) < 0)
 				continue;
 
+			if (ubi_io_is_bad(ubi, pnum)) {
+				ubi_err("FM: Bad PEB in fastmap EBA! %d", pnum);
+				goto fail_bad;
+			}
+
 			if (!__test_and_clear_bit(pnum, ubi->fm_used))
 				continue;
 
