Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AB606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M0Ri05D5;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=khgkcW81
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8913460677;
	Thu, 22 Oct 2026 15:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOdRbsYrmO7o; Thu, 22 Oct 2026 15:58:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2AAF60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792684693;
	b=HctyJJjroD3VV1OCGbSni/nlN16J7ZAoPMTFFfsIBN9+gx2IikqJzorfc1EkrH6CLVFY
	 SXeSLBXLz+FFCRizKum6L2fQnS2CsDFnWq62461Am0FcaXFTFMZt1hsSUgjSRj+3OuK2+
	 N6Z/We9PeNy7Y/7/qV14KV/UZvhUMxn42WpkMO9oPCavCIT7J9xA22LDMInP7YgtXqo8x
	 9EmsGCZXw7AakRqvZpx6c+wf4mhC/BkwTCoUr9ZKzknbkbw5EahqYpu5JOyNqF8AHYn/J
	 3Hpatpo6kcRbb42dhPsosJdDTE60bre96TmIha+TL0ea+ztMElLO5fElZBWab50iGSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792684693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sf3gFMXxnNdbM6iCuqQK2AyT408uW7K68NVD3R/xQxQ=;
	b=Pd3VaO/EgrWjsxQAjNSGgwgxJD/DcbjkjlvxJw3nEgjy/S06NREI/qCqQLesAYfl+iXE
	 +bCG0WHPIziAaf61D61oFdC5LBd8OrXj1HbPdNDHYbk/IMNhAoYzjHA3yejCgwqEGxbMt
	 ZdZLn5ivatj9KHgVLnGx3jRVpLXkSX5ttajDq/FHZn0/sOzENtPJ2jC/2alc6EMj3tXyn
	 XRSFoPUl2dJ0+bMD8WKkshoh6Z7H3hwsdUuqDol0nAGdfgT6ZY/fcKfrlcyr2Als/CjGO
	 8QWl0gnjPIiSHeqZcw1iZZCphHUsfVbKzoGMpRQcPqwHh15MzBB6VyvobDQtkAKutMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792684693;
	bh=Sf3gFMXxnNdbM6iCuqQK2AyT408uW7K68NVD3R/xQxQ=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M0Ri05D5CI/ZnWcNe3VmhAA716fPSC2d4aHwxy6o1GvNJTqD3nF0ImtLMcPQI3J9A
	 ov+MntV0gM2otxTglWfhE1qF+QhN6kFcauVGIvTcWtltst+wIpyBWzVoJNSYEcjdHv
	 VJ0uwmUlsUqx1H5hBlRWaZw9pjD9EFcWuxu9nbFqQZ/X27WKCnh7SQlzeT42JlQSdx
	 pnj+kpIEiEKtZhbj9+ZYpSsri93U2qyom+8zIYUXg/yYwfVepnOBDQ1wCVlhbxSWZD
	 bYMvNXys7bPjysnAk+yc/YvY6kbf+JxYnMk2tMAFozuyHKrtHk8JfYyd8ztw4gE43u
	 vvlw5BSFICxpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2AAF60680;
	Thu, 22 Oct 2026 15:58:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CE6F95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6309E80BF3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Usn08qyAIC1 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 15:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A00780BE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::448"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792684689;
 b=gqXvo7ki5VK1QHJDo4gf/IQBB9EtfRvcZueTLT6GHmQ+vDb2HwAyVYQ8wHgjJOaK466z
 Xd+ysSYtCOmYveCXXtpnwRYWkECiJVC3Lx5h2D6xGNjIWiEW7zVNj9blTB5swlFMepyb3
 gBhLRn39xbd+clF8RYxrMorla1yVMpivu21zhZC27nH2QzHXRCbguwb/L8JG7L3lCXQ4K
 aiKYNs7r5tAv6Ly17q5WkgudugCt2xLExHmjD1v2/OpaLy2p9DozfaTL6biUmB461SF+A
 RLEprgjxzqHnzdQNjnT4jmRlop8VDjvMWGVeRfeNJk97mFUvD77FM4Jqve09R2sXs+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792684689;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
 Subject:From:To:Cc:Content-Type;
 bh=Sf3gFMXxnNdbM6iCuqQK2AyT408uW7K68NVD3R/xQxQ=;
 b=XMzJ4V9L5AhmIfUdCzuDlrKP6FPgBojT5wQeTTMYJrkfR72sCnHE3JWf2jDcW3qwqvbs
 He70a3PZS4oXt6G07J9yS/0YF8CHjepkBpZqaFLjcGzreYcZzMOZZhg3Wov8dOG+K0Kde
 uJyvVeEhK4VYny3dy5Yp0oH7xxbRlvzbEhTtnnTpOh3MYY6SlFdeiK8rgNwpxFBTforZB
 Zrk5ZU5B/poL6v9CwwwqpezhTIb5MXBJJnES7zHeJrlnD2rdb0PfShkf6yJh6+THMnC0H
 TZ62EfDF2ddDuU8949jnJE/oLH8L1TgNuhVxmq5XwqE2xmDaDfscqH+ALtMklCEEM1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=khgkcW81; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::448"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::448; helo=mail-wr1-x448.google.com;
 envelope-from=3jjlaagkkbrkchlnqhmmxfnnfkd.bnlt-annskhrsr.t-anns-oqnidbs.nqf@flex--dimorinny.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=khgkcW81
Received: from mail-wr1-x448.google.com (mail-wr1-x448.google.com
 [IPv6:2a00:1450:4864:20::448])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A00780BE9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:58:09 +0000 (UTC)
Received: by mail-wr1-x448.google.com with SMTP id
 ffacd0b85a97d-48e0af48c18so1710632f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792684687; x=1793289487;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sf3gFMXxnNdbM6iCuqQK2AyT408uW7K68NVD3R/xQxQ=;
 b=khgkcW81GjMhJSTL+9IDVL97ptwpJPPk4kbYhB/mWF4Bn0BIebpnBIatkMMiAruWCS
 ZKwMd5nS/2IdXcsUYwoHRMzUsIKXDBW1zvq3D81wWWA52PhYrSbc6gOL2ilKzlkY+7tK
 lZX3BsdNJbwibMmiy9fvklmAIY0EzD8g9NiuL8tcwCtW4Q9k7twsMjqtrxPnWnXwnnv+
 Q0IvBWeojkaW4X3/E1WORHp//H4e+OmPRE1X36MnjVILZr5hVs2dXI5AzUkcu7dRrVNU
 j8lQzyoBwNX29qJ/DyVU4+WCsSmqPDHPLShWGo8hSMaHraQieSPbIc5ZxZ+VBqlAIGl4
 +YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684687; x=1793289487;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sf3gFMXxnNdbM6iCuqQK2AyT408uW7K68NVD3R/xQxQ=;
 b=obXkUDjpNduZQNi7AkrjMRSm+qgLKM0tn7NxdmH9hko6/GLL0B8cGn8Yv6woXko+X9
 D2STTvzuqnK/XFs6lqkh/XJ6QCulIyBKce7zWvCPcApKq0a57+MLKyj97csXFaNBANzs
 6dlkVOd3iDBIwlV5QPhjnviHasF0iByMwgiVAi6qIBLV9xYCrENpAl1mlCSVdukMVMmJ
 GJghHLRHc+pc6Wk8v/E1q4DKTe/2kBjvP4FD2MvrCOiH/LW6xKhR0GAX0iU5DflKvEYu
 jkxXucYpWMCTOqzaUeqFGC/ThF/S8q5jcEKBWXRDLoPzoysueTjiGfQa9r7VDkQqvImG
 KENA==
X-Gm-Message-State: AFq9FYLG91QOYVnrH5iRsxReGZPx+b8k07TXa7WseSUNWijLFabHMTyx
 9f/qow2+Qfid7Cz33DHTDpli7wqiEA464zPPv5wvsLArd/uHLXVvCzQ60wF8m7kXmTmgIbUPoZu
 QFsZJmGR6EsvQ5a/B0cFOJKtaIw58fS57PoU1uo0SigkYZLdKGJ6SGkZ01bltqxYn5jn1FEEVtr
 XW+V2P5yeAC3x/M9ATrehWL6J+Dm0L2jhHuWm+92oiD7bGi1x7msYEi7nC7mYZA5Sx
X-Received: from wrmc6.prod.google.com ([2002:adf:e706:0:b0:48b:11e3:e6b0])
 (user=dimorinny job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2612:b0:48e:7fb:aed3 with SMTP id
 ffacd0b85a97d-48e264a5a5bmr12152558f8f.17.1792684686896; 
 Thu, 22 Oct 2026 08:58:06 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:58:06 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022155806.115031-1-dimorinny@google.com>
Subject: [PATCH] x86: tsc: Read the base frequency from CPUID leaf 0x16
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Bin Meng <bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cpu_mhz_from_cpuid() should return the base frequency in MHz from CPUID
leaf 0x16 EAX. Commit ecf31113f178 ("x86: Sync up tsc_timer with
Linux") changed it to read leaf 0x15 instead, while still checking that
leaf 0x16 exists. Leaf 0x15 EAX is the denominator of the TSC / crystal
clock ratio, typically 2.

The function is used when native_calibrate_tsc() fails on an Intel CPU
that reports this ratio but not the crystal frequency:

- in 32-bit U-Boot, for models missing from its table, e.g. Skylake-X,
  Ice Lake-SP or Comet Lake
- in 64-bit U-Boot proper, always, because gd->arch.x86_model is never
  set there

U-Boot then assumes a 2 MHz TSC, so delays and timeouts are about 1000
times too short. For example, a Core i9-10900K reports 2 in leaf 0x15
EAX and 3700 in leaf 0x16 EAX.

Read leaf 0x16 again, as cpu_khz_from_cpuid() does in Linux.

Fixes: ecf31113f178 ("x86: Sync up tsc_timer with Linux")
Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
---
QEMU reports zero in both leaves, so I tested qemu-x86_64 with a debug
change that makes the timer code see the leaf 0x15 and 0x16 values of
the host, a Core i9-9900K: the TSC rate goes from 2 MHz to 3600 MHz and
'sleep 2' takes 2.0 s instead of 0.008 s.

 drivers/timer/tsc_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
index dd16ab320b..fe1888eb2c 100644
--- a/drivers/timer/tsc_timer.c
+++ b/drivers/timer/tsc_timer.c
@@ -83,7 +83,7 @@ static unsigned long cpu_mhz_from_cpuid(void)
 	if (cpuid_eax(0) < 0x16)
 		return 0;
 
-	return cpuid_eax(0x15);
+	return cpuid_eax(0x16);
 }
 
 /*

base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
2.34.1

