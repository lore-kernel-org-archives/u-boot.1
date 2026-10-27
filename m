Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC160A2605
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kRGnlIps;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N7urGjvZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51AA040562;
	Tue, 27 Oct 2026 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0J4THASbEkA; Tue, 27 Oct 2026 14:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 836DD4053E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109850;
	b=S8bae2Pwf/6BoaGM7uH1T55yYBiIlHVdd8atkd+zbxQLLEDKR7Fr0zUecUkcj7DpeKea
	 u+e5fUEew3Z7nYHU4bV/sBoBHFVe3YhUFausqweSk5UzZNnPw6e+btQzTph4iy42aCPKE
	 J7lHRu6oEHtKADbttt57gfJ8yh0lrIrhjClXZPMk2eRgUPomboNHvKyRxQIlUWWs4bUZr
	 GyWhCVL4Ia1rRMic0L3bePU7z91n/390JcPbUmdAM5ZG8wrzbwL5z/JzZdUBeluPY28Bo
	 dlqhAtLuBsreKta/Glc9Q0AsI0j2ASn7ESVAOMCK5zvITku5Hu80GRn+/cPm4L0JqLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793109850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FY6eo9IwZtogNVL1j2u2TKOcsHM+FdgCtqeQBd1tEUw=;
	b=pYBLjBG4ph4L4Qtfx61pahBrMl1rOrmb4crRH3b6EK4qckMsACnpJttsb8WbWpyfa5+C
	 X6G+bxVvvrkRJX8a183KXuVeH5Uuh+cqLGMWQh2P7rYKKOvs8uwtJL80D3xgQMVTQ5rMJ
	 S9M2hspZCiOSCWJbf09h7xksWZW/rYyh9ZSeFD2sBsaowgf1CTVsJEktXnxOirhXAWR7O
	 5oWVl+q4sYA3rDYSJ91zbu2l14zG5ONTbHHZ+qAAoRVg2cd7o/i7Gx/DP9DMiO2ZA/O3J
	 lq/7R6nIgBscSx+WP9Rutx+U+Z3cyAOHfs6uACQCBjoMYBmdMo/uh/MK0KNQAmO2cgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793109850;
	bh=FY6eo9IwZtogNVL1j2u2TKOcsHM+FdgCtqeQBd1tEUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kRGnlIpspMUGe6D2GfkPg53UdXrFYnB6lxX6HdVHQ3LUwt8ovRE+q+XPcFlPC1hNJ
	 ApKv0qeA3UPlsz0+zBRCGfdKRzpPYSawwaOtqQJ/EwwSpDqeStJs79KyzNE2jMKrVS
	 EJv517u2FYJHY08WJ6IzTIFOZXpXKyrd2zdvTgkOARniWmZgqdS/F5kvPvEZKL1Hi8
	 U7C2+STFA4NXi6hZiwC0PF1Y3fD5SGtRHJj1/598xiwfY36Xi2PlXBikfXPcRL4Chc
	 hCrtAjOUSS1NRih2cRxHe1LwXHkOAcyoybpnWuiKImUy1rA3pjZ14Y/bIG31uER/Ci
	 dTIYRGSvPzJsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 836DD4053E;
	Tue, 27 Oct 2026 14:04:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC6813D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDE7460725
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CbypqfDBSNL3 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDF75605D5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793107134;
 b=nPIry7hbc5K8STkTsMFe96J5kFSbbU2B1VFHIAeyd+3wFxqwQSJSl/qapiSSsCSwQ/ci
 eleAq5N48YsVlUTdLWMGRZGha8Ef38ysF15LBZwDs1ueded0YGDsQXIrkM/ScZnoY2bXJ
 6nOJNdMk4jDUoKMjZzWgzxtHWerSGbJHLXafaCsQAdzoHkWaGAXHI/ObxyodAJ3KLXx5F
 B5ssxT7AfzBmWfSbjKEQIHC2GyNkoyp2LidpNeXKpMkO8gzUuF9wP0A6tdU7KA9mwa0qt
 VRhpogOZtaFE3RjeOIOQCwuv219FLR1okXpWzsew/6lvHn7AR2wcpW/8BlL2nxOqwSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793107134;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=FY6eo9IwZtogNVL1j2u2TKOcsHM+FdgCtqeQBd1tEUw=;
 b=czpLRliJl45OxbcV0D5mHNDQ2Y4IW/pnTVS8wIar02jUFT2HDR4xkx7fwsaq3ySkHufR
 uJbwzrGKS2CgJ60Zc3P3sA1lrqvKIFzGVVnlf5Cx0MJ8pGDuojQ34vuHAXBvUPVxkLPZs
 8SmjbKz4a50J54dZfl00rECch0MGr6j+z5BS3wTYUFZF+dSxEQYF5tayInHaYkGEGIy4g
 Qn8sPGoMmBL5SlqztkKLxfng6lt2+vfkLyqXVEbiBws5NLEuIA5CaICpiplvwkqrqSuqH
 3hkerRBsjpgk2v2gbHiNTGbH6agGHks2aynscni5F3+6CpQgKiKM9ZCJfl6gziC3NSA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N7urGjvZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=odeschamps.mail@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=N7urGjvZ
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDF75605D5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:18:53 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2630121f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793107131; x=1793711931;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FY6eo9IwZtogNVL1j2u2TKOcsHM+FdgCtqeQBd1tEUw=;
 b=N7urGjvZu6R5XNHEDiMUoUGoYKGUvAge6lzMnPxss/khiFC98ocqOus7PqZRZSzuc6
 dyGNdMQK5hOORY/OqwNYcUJxIpG+YNiIUb3k8M8LCrS4ZkWWtw5oZda67iG4wkFAl74U
 l5tn8+gZLl538MJ+nX/LpQBYqZH4iotPlQZ/tiTH96eMwAcmJe4VmpHMvQjekZYNQlxF
 QxRftJsMu9MXWsDUd1dcYMfWbvNu9/ryspU0kLHXS2yGxEbE3GnT9GvHE2rWiRW15q3Y
 sJaoYMafVvHY0fhURyGTfSzS85U4+qZiDio876mnCkhE6d9HKosr6s0k1oP5gwUxDmZG
 rPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107131; x=1793711931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FY6eo9IwZtogNVL1j2u2TKOcsHM+FdgCtqeQBd1tEUw=;
 b=gcyx37u5syCcnda/cxBopp+FETFIgLfwwoLw4y7yG6dH59LksUYjgNFCx4KKCnhSJm
 /5w32C34jscFh8snmLZNvoNvtlnL8nzkPaYbpmAcEridgKu/2v4KhQL75yINjhj6FAtH
 GQ/qlSy395W5adP4GGtEjqYxiLdi5yi/mJzFgthNADtRc2B3hMhGctX/uSwWmcw7ytTW
 n+ZG3gnL4vVLW5YRIVruFazVVfeDmpt62ZKAh7C8GUCsyM72tkt9Ol9RhvJqmOSDHLZn
 3vkdMJG/Vr56tIadnDt6sSIr+6RhdylwCmERvFoMp/3fr0glSyEWY5cA5NVyKWYn0Fu5
 OrMQ==
X-Gm-Message-State: AFq9FYLtLwXen/R/YBdMmHQgDScUZ+Z/FtsHo9nFiNR9UzhDKqilgvUq
 86YQRd+/VWVpaU8Wvr9YgA8GzmPTHo+doCHkVWXnk9Eghdv6F9diDMrWnwgKKEpYNA5P5Q==
X-Gm-Gg: AYBFou1rmjX6LZjjjAAzNv88v76mJ8GYu/6x53iP4FkPa0TMT/x95nE5bXLndHW/RKB
 48ADHMUpo53fxzfnvQVDTKLwkFn847UfrsMmhlbWDqQjzZHXubjOM4Lggr73xg+z6CY6/KAiGL6
 Hft+wGfwphnUXxykstLcEgr3tj7B8A1zqMwDlBN8QRQJs1gYLh/mrl0LVDJ5dglynuGVe1M+Bvd
 brfPjfZZeTd7v1AC6lI6yJEnSWF/InCc0DTvkdYvp65PhWe4zIwtHWhiwGbLdVKASig/9CkblRQ
 HqiEVX550ay7hcKtmoRgHyMQhMJeKuxnU70BFujV0xgXU8Wk6NE3CATREDcWF0ABYMg/miGQtIb
 w40oj6vYsiIJxmI+hPeLQgOhQFemUvCGmD+1h1tObRRQ4La886Z1NCjR0qK/An6KvSRfxZroyHv
 hHht14tndXIiiH3nlaJurbwDXi8aIGi6a762Wf0VFvu8Sch/RoqJkdyidpZdRFNG37PSGMtljEW
 x2KfJy/Jw7p6vidu0zmP8gzfmFtAsmiM1MTFD7gpGYfNPTVNOfuPck9nb1eTmyKF197uPAD8bvy
 Z5HRAkle
X-Received: by 2002:a05:600c:1d0f:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4a35acc76d6mr194950265e9.32.1793107131047; 
 Tue, 27 Oct 2026 06:18:51 -0700 (PDT)
Received: from test-Standard-PC-i440FX-PIIX-1996..
 ([2a01:e0a:ee9:fa60:be24:11ff:fed1:a152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f4f20dsm185525665e9.0.2026.10.27.06.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:18:50 -0700 (PDT)
From: Oscar Deschamps <odeschamps.mail@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Oscar Deschamps <odeschamps.mail@gmail.com>
Subject: [PATCH] lib: date: reject out-of-range month in rtc_calc_weekday()
Date: Tue, 27 Oct 2026 14:18:37 +0100
Message-ID: <20261027131837.177854-1-odeschamps.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 14:04:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rtc_calc_weekday() indexes the 12-entry month_offset[] array with
tm->tm_mon - 1 but never checks that tm_mon is in 1..12. A caller that
derives the month from untrusted data can pass a larger value, causing an
out-of-bounds read of month_offset[].

fs/fat reaches this with on-disk data: fat_readdir() calls fat2rtc() on
each directory entry's cdate/date/adate fields, and fat2rtc() does

    tm->tm_mon = (date & 0x1e0) >> 5;

The month is a 4-bit field, so it can be 0..15. A directory-entry date
word with a month of 13..15 (which a compliant filesystem never writes,
but a crafted or corrupted image can contain) makes rtc_calc_weekday()
read past month_offset[]. This happens while merely listing a FAT volume
(fatls / ls), i.e. on attacker-controlled media before it is validated.

The impact is limited to an out-of-bounds read (a wrong weekday, or on a
sanitizer build an abort); there is no write. Reject an out-of-range
month, as is already done for the year. This also hardens the other
callers (mc146818, efi_runtime, cmd/date).

Found with a libFuzzer harness over the FAT parser (test/fuzz/fat.c).

Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>
---
 lib/date.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/date.c b/lib/date.c
index 0deac8a1bee..7ac257fcb21 100644
--- a/lib/date.c
+++ b/lib/date.c
@@ -32,6 +32,8 @@ int rtc_calc_weekday(struct rtc_time *tm)
 
 	if (tm->tm_year < 1753)
 		return -1;
+	if (tm->tm_mon < 1 || tm->tm_mon > 12)
+		return -1;
 	last_year = tm->tm_year - 1;
 
 	/* Number of leap corrections to apply up to end of last year */
-- 
2.43.0

