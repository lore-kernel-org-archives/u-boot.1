Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CBFFA1FEB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5288432A;
	Wed, 22 Apr 2026 21:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xm0szHUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5E584372; Wed, 22 Apr 2026 21:38:58 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35AC8426E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-506362ac5f7so47922551cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776886735; x=1777491535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jh5OoNNlrmBk4Gdyaib9lGhu1BCpzlL08gEtEipXNGU=;
 b=Xm0szHUxzW/hrU9/BVcwFUzAEWsQAXnk9pyQEuUj84EGmrOpF5qnrvupoDv7sMQOsW
 rXrL49ZNr68gOJ3gRHqIDiZO0FIYPSfo6RWJUACPhkHz0OvpGpIojiWqwroeU3ettvLY
 /PJMUslRz8CAb6G/7jLonehLsjfps7XpHgAEwGXEviOOyRM48ssUXjZ2Hz3TiVQGcw1X
 931Ftrt4aJ8dS7Hlo0PbmuN57QEXUHvEkgvPcorpOovvRIseFiAA+fs8HWPV4cuDVYwu
 rrU8c6tiIBW6t/8xM5FNibKNzQBeT8cBmDoWvHuMkD+Kpq394xYDWDBYbJTDnYC4NL2y
 ZAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776886735; x=1777491535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jh5OoNNlrmBk4Gdyaib9lGhu1BCpzlL08gEtEipXNGU=;
 b=NmHkXS1hjyEIykOVcQXQ7K/XwDlsnaMuznBlfyCZUcMOGUTmlzP1ssydVCpEQGE30g
 fMkg1emYSq10ZSOhVdf0Gb1MsNlwi5TWu3YIpghqW63OKZJmj++UdQYud/4u1xxMyMkH
 z7E8gcoF2xnR03KNR26/tvlFymY9LtMbO6e8HnbO9TAthQ8B//79ysLw21/5WEEBU8fP
 EindjzlXv10bC8atAgI+tm+6ZUFStWIvoik/dGH45fC9wCA/4u2uFAuR1/7npm97bf6u
 rnm2RjG2wSN1ORQNDLhM0vy8aP4vD3dIenSqbncDxVGMyjgfiFKtdqeBHJaw6Tolkbns
 3sbg==
X-Gm-Message-State: AOJu0YyKiTHt02yOHJIIlVwOIFs7N83tdRrj+QMTqZ6LAf9uPabcGZdc
 mGt2EZhe1fQSL+niL7M2KaRMoymxZEsFNTMUzJjMrN+9+j1SARpABMh85d0LQlJUq0U=
X-Gm-Gg: AeBDiesi/PP/DT2qUQRgEDAfsRvD/4546l8i9kxe/hUHrUROEHWBsLZ091bpgPFHa+R
 83nFImYpVpMZRq4IleFvk7CUjsthP7KijhSZcaTG8xnXHvFY19Ob3gtgc+/rj81KpM7byRiKtIB
 UA69+LsWNhnm0rXgLuih00GJcmEQABQDe0tsC+LrparoBdmMu+/TJuvPQq+npwzrB2ftwKdJfCP
 mzh8wmhmFYweZrqgiPi1eh6qmSCFI3ihGGiWphhmZD56JlbUXLRNkZeZXu9LxWgwF0ODxnTBAVg
 6jr91i8A2RiZuHMVPbLBzCmJqGbdktQjbvGyqXLvraNuBk1fw2aalNfPrKN1L+osjUWV06wAzCT
 HBeVGv8s3Wx6IKY8NCKPWdQYl4SpDiaDc1Tn5H97s8F6S3Ahi29gaHuZN41sXB60NzAQeiphRkA
 /Bv3DjYaZd1jkGkm2PiifZLQ2Zzk6ZQ+q3Kr99aqJPhoc+AUCKH5zUAQwPvFho2N6TF9pEc978t
 qCM7VhJnqz29pIjtJjmQvl/stMiVKwT
X-Received: by 2002:ac8:5807:0:b0:50d:7c44:e144 with SMTP id
 d75a77b69052e-50e36b3ecaamr406794901cf.11.1776886735006; 
 Wed, 22 Apr 2026 12:38:55 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b205cc0353sm23382586d6.10.2026.04.22.12.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:38:54 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@riscstar.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] smbios: Add an explicit bounds check for Type 9 length
Date: Wed, 22 Apr 2026 15:38:45 -0400
Message-Id: <20260422193846.1333146-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Raymond Mao <raymond.mao@riscstar.com>

Fix Coverity Scan defect on Type 9 length.
Type 9 formatted length is built dynamically from peer_grouping_count.
Although peer_grouping_count is a byte, the resulting formatted area
still must fit in the SMBIOS header length field (u8).
Add an explicit bounds check before extending len, so the size used by
map_sysmem() and memset() is guaranteed to be valid and consistent
with hdr.length.

Fixes: a8442c226635 ("smbios: add support for dynamic generation of Type 9 system slot tables")
Addresses-Coverity-ID: CID 645487: Insecure data handling (TAINTED_SCALAR)
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v2:
- return len 0 for errors to align with the existing convention of the
  file. 
 
 lib/smbios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index d5f18c8bd69..fdab5948aad 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -1093,6 +1093,9 @@ static int smbios_write_type9_1slot(ulong *current, int handle,
 	 * TODO:
 	 * peer_groups = <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
 	 */
+	if (len + pgroups_size > U8_MAX)
+		return 0;
+
 	len += pgroups_size;
 
 	t = map_sysmem(*current, len);
-- 
2.25.1

