Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DACC5AE49
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93EF883D0F;
	Fri, 20 Feb 2026 21:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="ClnJDEah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A3D83CEE; Fri, 20 Feb 2026 20:49:14 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8BB83A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=trailofbits.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.kilmer@trailofbits.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8c70b5594f4so272309285a.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1771616950; x=1772221750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlLIF754pnaCZp78SyusltbFEvrL7rEhMMzqksfH5w0=;
 b=ClnJDEahLQQaV/sVoCquASCBz/pCOohg+i42f+L8AsbgrKCxy+5ODiF8UeL4esY794
 JCSOfSHZ8/uE9dV1A8bksNWFZcb1XxBDsZFByRF423CGEdkLwkvSs9sNmRGn7rpXr1Cl
 NzAVhkm9j17183AEaF2GPvh6dzOD82+tNobs+oFdI82+coY8T+IGY2s7ri6jhrfDSq4M
 DUZI+J8wt3yrZKcg6ZEhQVhg4XeGJ+ssKbafhHlXYHYSgaPSHiIKQFHoN566J6DEc+B7
 r2oHzoL3ATe4xM2I2sirbOC7k/q5ooVewK662RszUZm2B5i3H/UBe9fKd/KYAUaOno+X
 yJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616950; x=1772221750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vlLIF754pnaCZp78SyusltbFEvrL7rEhMMzqksfH5w0=;
 b=A9zOFjk8SfLZWqdwFWXqPlvU5h3R0JinIPcwJv4oLd1y7GJr8F4WSCaswIoXUdLrc1
 xXmHWdaziTy5G36W1tZVfIxw7P2yux3eR/or/Af7SkSsy7CKuCyrQSG5uBwYW5r9IlKN
 VJnrZfY41T0DFPn4OF6owGfVh65qHDPPI5OGe7DUmUfcbt2EZLIuNAkyOEOj4ga1P9Qv
 nSBd3bP3SgXv/jHTPV0oeu5ZsC8Jz85F/txXDxenCUf0OqygNBoZg+fTJ9gD6LgJClw1
 MCwCXbEW+sc+eDDxly1TznaLCsGou0mxCczBkG4jNCT7UtaoHKaYHpu7NtJn1+L2dmeD
 fpEg==
X-Gm-Message-State: AOJu0YyLv5RIcla0WfeW0EuREk+SWzcNSV9mExR0mKt1wfXKA9weAhJ6
 XybmtbaXa3zUEyEK6+G4z1sJBDubJjqOHdAAhb48eqe63jFFmHJKAN10nJZIEUV9xKZbNS5Ch3D
 PXFl+k10=
X-Gm-Gg: AZuq6aIn/Wsz+u5GYgZp8mFCehSvNUXa1Wgf+/YL+YfjEKI9zpczCaqfBrTmmR4PDLW
 /vlOzgNa4AbeYZb2stcOUkHcJ3dCKb5E2QMIEFdvR+ZOjnYVFKlkxenSRk97OZI/jbMeourGmLN
 a1zRUi2TAQ0hFddExlfYhmmf/us9AhWs5mC5ux7LQjZ8I0nCNB5VHC4rkl5WyCsqGCuTuiGzUjO
 sI2WkT4kdrdJfEk6wXNvdMQiIKjiqlRLKP2LUCr6Y0FZ5KBIMPt11RVetjOl54z9PMYPkXZlzEy
 hJpsB1MMj7M8EvFEuPYPQfZxVAOAbCiPDZL7NVOulgXRYiX3t1XcIEoNjhzLj7cxAOVhi2TkAjk
 Av6Ie03RW8+E7nplydFIOBUTLMFB7GAvnyNNP4sEX2qxTH26KKIxgBRWc6xkJRhJJ5u0Nr+74ER
 Tpz9rFeip0lxzEdv9ss1XPmqLBfsmpvDqf/dk=
X-Received: by 2002:a05:620a:4611:b0:88e:1be9:cf65 with SMTP id
 af79cd13be357-8cb7c0049dfmr760672385a.39.1771616950398; 
 Fri, 20 Feb 2026 11:49:10 -0800 (PST)
Received: from localhost ([2600:4040:5493:a900:ac9a:2022:5331:c80f])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-8cb8d103084sm28405285a.33.2026.02.20.11.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 11:49:09 -0800 (PST)
From: Eric Kilmer <eric.kilmer@trailofbits.com>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 Eric Kilmer <eric.kilmer@trailofbits.com>
Subject: [PATCH 1/1] fs/squashfs: fix heap buffer overflow in
 sqfs_frag_lookup()
Date: Fri, 20 Feb 2026 14:48:08 -0500
Message-ID: <20260220194808.1146082-2-eric.kilmer@trailofbits.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220194808.1146082-1-eric.kilmer@trailofbits.com>
References: <20260220194808.1146082-1-eric.kilmer@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 21:38:16 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

sqfs_frag_lookup() reads a 16-bit metadata block header whose lower
15 bits encode the data size. Unlike sqfs_read_metablock() in
sqfs_inode.c, this function does not validate that the decoded size is
within SQFS_METADATA_BLOCK_SIZE (8192). A malformed SquashFS image can
set the size field to any value up to 32767, causing memcpy to write
past the 8192-byte 'entries' heap buffer.

Add the same bounds check used by sqfs_read_metablock(): reject any
metadata block header with SQFS_METADATA_SIZE(header) exceeding
SQFS_METADATA_BLOCK_SIZE.

Found by fuzzing with libFuzzer + AddressSanitizer.

Signed-off-by: Eric Kilmer <eric.kilmer@trailofbits.com>
---
 fs/squashfs/sqfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index f668c26472e..9cb8b4afcdd 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -178,6 +178,11 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 		goto out;
 	}
 
+	if (SQFS_METADATA_SIZE(header) > SQFS_METADATA_BLOCK_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	entries = malloc(SQFS_METADATA_BLOCK_SIZE);
 	if (!entries) {
 		ret = -ENOMEM;
-- 
2.53.0

