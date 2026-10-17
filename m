Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952ABCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43AAF812EC;
	Sat, 17 Oct 2026 13:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbnUErArzfVZ; Sat, 17 Oct 2026 13:01:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 969A5812F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242077;
	b=T85meYUSQzZ2RJHzzfZf/8IyagiNUWpsF/hnzsqwSdz0UaBgMBmDrOJL+fjWkgHRiltn
	 jkCMaSiJdfA20lwfn85cOez0lKSvYSD76B/3KGPlEIemjzbKcMJ7dXxyct987h57tZ29z
	 C883Plzh3zyzsTS5/d2v6UdSYQbptUDLYczziDY/xsoIffydKL5O6+MZk3QU993sBqwI3
	 rUmr7202luZeSJBb3R6nVXHJnH2/440EH8zQusI3vjAMwXPn3bw8EwXpLi6dQdE4aQA7q
	 DSI7VaaFKWKth+wbKds7gh3vxj2tn6juq/DWb3tpp5B5+hNRz+h9Ik4N9RM89a9oCAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LIbSUWLCftbijzgHtUrG6bUsNepMpDim1QsXcDILwMY=;
	b=oXnJZs6GIIlzTb6KyGotOgkQXFfsX4Nhexo5PCfr+S7spwfIMUZWxqMAAs6c80E92pc1
	 V/hrT6juWZTkfcseX/3GQ5Dc+e/3J6ruEz1I6X7alhPP1Dd+3LCeMmTEBpZXuZVjy6Kdj
	 PwbfrJzMWJBECNT2CalEJIUluAh7287uBvkWZ4IlOjjGC9E1Q4cJCzVfOYakN1zIADS8F
	 9NoFMW6wDr4TdvMCTMD1AbxZ4xp3db7NQjjCzw4WhyjGpV9fjTAm1H/qXWbSgqFt74lAt
	 iOUe0nCW8aeZkZ8fJ9SzhEJBrNNnTNP3s42V6e9ZWMlbNcHZwH8681Z2Rmtyt3RZMGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242077;
	bh=LIbSUWLCftbijzgHtUrG6bUsNepMpDim1QsXcDILwMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vpf1/700V4ntXLoazcNPaCX/ehp2xcg8M3kCvp99rMyDJZQWPN9Xz9WUbQVRb7BUn
	 8AlPLKEkdktu7lodIwBmrHF9rlHb+lV/pS/3Dlo8M2CeAixyZV8L6Lip4VQ76ifPE3
	 f/ohsV4PpbE62eod3GRTuS4eXwWYbv7i/Xkc47xEodj4NDrrqjhSAnc3AzaZ7xKBHw
	 pwAHTgyvLqEFqhpogsyv0GjXDPsPPFlXfyepEGbf3DBizE5qPkyXlV8yR+3WFQfYEa
	 UqiJzvzOM9V5Qd3vKtYxBhgd52LARpxEJUY8+2QvZULTTDU7eAAJ9ie6aqK8sU7YkC
	 PeDWqXKeIvE5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 969A5812F6;
	Sat, 17 Oct 2026 13:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8728A977
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7790340082
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSAKR8iY7WDL for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CA13840024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240590;
 b=LBMLqXB3lNz5jD8ZfP1+WgA2vvWVtq/ZsGRa/tiES6PV2aXfRyKeN0XeXWiuh/ZSJVhp
 GV47zw2EvYRanGsb09CZGIUoTatN+zMFfUdL5r7N5JqfQ+n8iJUznr3mjnhgnY2ip2pxk
 eW6MAh3sGXxeXaThzStceeWEOx7P4oTg4OLuphG6lAk0xeHoIvo73jGZZ32TmkwNGNM/f
 hHn2pnJYddQRwizJTRsYo2QpJHTLkfUUDq+e839EMr+n1RFrWQZOnJLZ3cNM4A5eJ4r1f
 ziuTtSI7bW66fPhzJIEoL0Fcx7RXHghDGVkqYVBacMKlFWxhHV/BQGzjjb8MEtAsD5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240590;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=LIbSUWLCftbijzgHtUrG6bUsNepMpDim1QsXcDILwMY=;
 b=qo8/Nk/dUwZMPeqIPKaZUkNzcWSCvJUX8ZPMck272KhUCpotoFzG8WMBEGREj5fTRPp2
 YeCk+skXbivHNQqMS8I0b/Ho+IiTVDGI3AXpyKpPp5sQRpC9pwRj9Z8A6wAkmpWPNE56b
 O5aDWKsyhGxKzQ8AGzFySxNBTmF9wbIw4A1Lon8Bd+6enOPKXoQ/8iyhsrWxx8M9xisRY
 PnWE60LIpWB16mPRRoJ/jT9u0XRR+Lq06Bvwxcc7nJuKbIEvdSa0oRCPCbKcusE94A5BC
 SiuQE2sBOtKDc++8qLyfrUxefbdxZsdl+Swmz3aKcB7cz7JeyhIK8jp6LCrpD8BD7SA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=BeN2Q2tF; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BeN2Q2tF
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA13840024
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:29 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 043773F125
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240588;
 bh=LIbSUWLCftbijzgHtUrG6bUsNepMpDim1QsXcDILwMY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BeN2Q2tFHhu7T2zD5H4WDaX15sK9txzPwpQQkj8nVZl7oNIKvgDTCRCkS4Gi+qIxW
 k27Oi6cB6fIg0OuZ0auesl0FVttnA4/5at8O60SFDyNFg9XnnjgzeklqtIXh+TSfeD
 iojh8JIxXjwlsYp9lsRTvWifyFsVB+apJtkRgvxiwodohqmAgNI89/UXPrx147TOaR
 Sf1+4l3RiiWIAL8bkFk1tkxz0Bs9sHNzEBFPTcWGBFXjB2BZ4AXCsUcif8tGk8UFGa
 hLHCdgvYgE8/fbmOBPAD6q05TF+eRkhRXruGUnzsqKcBsxDmYEcZ/9sz/Jje4H9Vp5
 DHJtncn3Kfcs4U+b2xEJr+qyy3+G95clhzqoIeJx5He5uHI8CvzrWq2Ab2cxexuByS
 WhQlWazDc3VQm+39uW0LCSwkgCUTk9MDki+TmGk1+ALdQfcb3YcLhNu2FKtsO1kmVQ
 JRh2yKS6HKwMLyyOiTTvHXE4QAIqYDtzF+zKTIgGjRnX9JeK/bOpbINxfCjPUB2sWV
 khrbZ4VOUZALpid9d6WjkdbOb2IJ2GLeBHyKwKxzi03UkVIvdVav83lgOQWV+eS0Sr
 D6tq/BhoMlMZFFHBbf8eLOcIXAsuG1Q+C88jEVsEc3V/5x5IeVhlSz5xNOFsTRUIw6
 s9sigzvTEJeDHITmjkU6ANZ8=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso651032a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240586; x=1792845386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LIbSUWLCftbijzgHtUrG6bUsNepMpDim1QsXcDILwMY=;
 b=Pb5i//5P0xZ58288LYoM2JW5xyWdWJe5iFi+VaartzoneyQEw02jyj88L1bpjTqnN/
 psa0MZszXAeiiQLrH8gv9OUK6aA08QylFUdbys+9CMU2RtPdylVOnPaZLzIpRRI9pvhO
 +z8FI/Whr7fPC7D28yg3Ovh/wSQTgeuZMAQYOXr6tHu62FjEaNSkT50/3/MClyKxoLMK
 DulMaFugOW6cnPTke8ho9UOm+40fHrHqfV432iwGjiGfnWJEiiXjD0/ERRFfjwRMVQP1
 /x9sBKrPLPEUOHVdDyxRYPsGDR3zyYCcYm0SFOHDopUkDA25s2nqEFNZ7+M6ekuN9Aye
 1B5Q==
X-Gm-Message-State: AFq9FYIO9VP8cmQ+4d68iS4A4owDD+rEZzbiLScx+ATJTis5hKmOfQCs
 ReXQU+pjZm6cMjoZjqdwXpBkKiBDT6+g8v1jpDm1NS+oxSLyYtECiHspfZ09ed6kyv0Atm5G8dJ
 zJrU0S9DOH6cWfllUhEccjq2d3a4ydlNBxHGsrRvZRLVJ1036FpkN1Dznbx/uxUqOLvW1pC6tsT
 A340Z5ZMeSakOPMuQwzQ==
X-Gm-Gg: AYBFou1T2oPuvVMwrr709/gUbGP4xSzfApkFTlEdWVCyShsGkiy90PTmm6HWEWP5bXv
 6X7plWZhwfORFCT/mXgTEwUewRljDDjWNRIj7H9NnqCSgMzQ9JnYxTOE+KejCIAAueMabslsy9t
 ZwfKGFc8o8vtwfsugVdmFdAAOO0mAZsj6FHjjvCuetOQCYk12fv6SoTtv78NPaBJ3WPO/C6nGTT
 Lfyk29o/tbcQH3QZQAsCovqR6LeSGu/iNq2LE8FP1Q9BT5sI9AJ0NGkK7rqSvgyB/nKSi4cvdnD
 hZyQgh+W1GvhKZtu/SAYKG2JNFBQaGd0QL3up3HOxZrJ02cVx6M2dDxSb0CtdAL9JRiU5mXOrHu
 wHCAbqhwxmTjTwDnI7r2JFOF4j2ymqHp6EGU8qAkjpn+y2Z8=
X-Received: by 2002:a17:90b:43:b0:3a4:b8dd:1447 with SMTP id
 98e67ed59e1d1-3acef1483demr2099319a91.34.1792240586508; 
 Sat, 17 Oct 2026 05:36:26 -0700 (PDT)
X-Received: by 2002:a17:90b:43:b0:3a4:b8dd:1447 with SMTP id
 98e67ed59e1d1-3acef1483demr2099300a91.34.1792240586095; 
 Sat, 17 Oct 2026 05:36:26 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:25 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 1/6] cmd: pstore: check the record header before using it
Date: Sat, 17 Oct 2026 12:34:16 +0000
Message-ID: <20261017123554.211799-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017123554.211799-1-aristo.chen@canonical.com>
References: <20261017123554.211799-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
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

pstore_get_buffer() only rejects a record whose size is 0 or larger
than its zone, then copies size - start bytes from offset start. A
start beyond the size makes that length wrap around, and pstore
display or pstore save crash. The ftrace records are read without
checking their signature, so leftover data in RAM is enough to get
there. Also, as the zone holds the 12-byte header too, a record can be
read up to 12 bytes past the end of its zone.

Reject the record, as Linux does in persistent_ram_post_init(), when
its size does not fit in the zone after the header or its start is
beyond its size. Skip a zone that is not larger than the header, so
that this bound cannot wrap around either.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index f2c0034abbe..6a98a5c006b 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -92,13 +92,16 @@ static u32 pstore_get_buffer(u32 sig, phys_addr_t buffer, u32 size, char *dest)
 		(struct persistent_ram_buffer *)map_sysmem(buffer, size);
 	u32 dest_size;
 
+	if (size <= sizeof(*prb))
+		return 0;
+
 	if (sig == 0 || prb->sig == sig) {
 		if (prb->size == 0) {
 			log_debug("found existing empty buffer\n");
 			return 0;
 		}
 
-		if (prb->size > size) {
+		if (prb->size > size - sizeof(*prb) || prb->start > prb->size) {
 			log_debug("found existing invalid buffer, size %u, start %u\n",
 			          prb->size, prb->start);
 			return 0;
-- 
2.43.0

