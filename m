Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F86CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330D7846A7;
	Thu, 21 May 2026 07:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qqzowIgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C24B847C4; Thu, 21 May 2026 04:35:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9D38460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 04:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 506673F94E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779330923;
 bh=3w3OY7QJle7eQTaO0EPaKBxaSiWYDkDiTJuQueXG1ag=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qqzowIgG/BTCsucWiLF4LEWP+6DKZgimL5qTEO6qC/3IzET7OfaTdbFdKlsM0SUZV
 yPHvLrma8L8h6/EAatZ0EpltliuJb0S84cnD39lMydzDY/f4czOMhoPilxqd41763e
 XdwIz/unD3FoMFkAfDNJomc6RSsCUFBQ+gUzpxogcPoi+fFa2sXujrMChgbLLkOm2Z
 1bK0N8aRcMLZxMtbJbGAnxcQ7bvrXkb3UzGpjgnnijy+oqLn8P9syTJLwSTSrWhClD
 KL3Wt0f1zu+CyV062PwwFcaTKFH47C5r2QLxQQTocWmfkGeB+YtTkM9jJC2MsWufXV
 vnpVy2Fw5Kp9BiJCVeTb0HFpowoM1scKzZ9tmxXFt6gJxl1iRToba9YVdhwffXGHA3
 tyesqt45yix2yP3FBhtxgZsXaJ5Uk1zIa5cErmZhi5e3IcF6jUhsEH4SVHyWj2etog
 /TtSEjDx0j/NTDMPin2i8x6Z4TlgXWuyX+DVg8eXGfLUSTAprvxnsiZO1mx0xN2MXi
 TJbmFoDwh6KytxmhuDf4KTYaClnS5PkABssqbohesGMnpg5yeKSKeINkzS2sKWpri9
 /K0ddVDr4KkfQMv6xT77pzb/kTkR95zaog3qu9IMRrDeeeqNRM7MEl2lQrLAPwg/S5
 61ryb5tLAMOYYLW0MNHjaVEg=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-368b68a33adso8743819a91.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 19:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779330922; x=1779935722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3w3OY7QJle7eQTaO0EPaKBxaSiWYDkDiTJuQueXG1ag=;
 b=JDhgYPc5q1ptp9RFotv5cJs/b/gBoBqaEDTAfdnT5y5u9lZAKERT2CEu6fKrls50Qi
 PCS2y8BnhjSZpidD4UPWzG09YAa/Q/QZmRMH3NQjA81JPhg7IV8wPi9Sr665gu23D7pA
 fIkV8jVsGgGdpmnl3dLyKDaJoRbMUgspygYET6d5TSjKCgCFR+1CuGPx8Qf49DUWRnqW
 TNVBhLmNb/ZZsxjrgflD1NxBljaWntXyixCSWmPqU7feimTNIEv++EWDhYc4vgB+eMTN
 R1Uvy7xrcvwUJZQWs130KLLNQHO9g1z4n5votfka4QF4gXsY7cM0qfJL8m9wjGD0c5fj
 Y4bA==
X-Gm-Message-State: AOJu0Yxw/C7gu4QpyEtuIIaAs67VSwWqmi3d9VQab8CeufeWYzXCt6bQ
 lEXu3rTso+c5nvjPmcd2TErUX0y4q+K28vX0KZROV+pWIjA/4t0oQ4H1YyUoBEoFLiPpfe8uB08
 BRyF+2W0oBtWdGkWR4ggtvecY3Ks39S73JjVTKN+wz2gUNoyY1iV5o/1+fBiISWrQoxKwD8rj/z
 Pt4HgokA==
X-Gm-Gg: Acq92OH7gISkR+DJ2mJKHJw/1qa0sfgjWZi/g0CvAFa7a9ZXBI33MN/36UVK+E3onOd
 J9jtRZ0wOuE4L9DHTTTIgWXGx3t5AK0nwUsIaIsVxIeeqevYL7l6Vvqe5Yal4N5Y1aZPdCs6LYT
 3dhIRlx/R/fv0c2JNj2+KkWoPbNhI1l8uTOR7gtRYoK7h6ClXefwFSXX1JfXW8PIFh0mr0fv5U6
 YS/Y7qPAviyDvJROByTsn6LQrE425Yho4sJ5KAcHjgo3TugfX/rjcZFDW3eQlzmuwK5qlo+787i
 QFBactGcLOLSVq+911myc6m/sENt6NV+NmNrLGn5Vm24ubSxcijdrYrYI2MdMCX28hUoUepYXu5
 SwV5kaokRZcI128tlZb47dFjYg3JYqU/THYd+QiduDWF/ZekzpJP5+own+0NovXvYe3sdwb5Wx2
 KOskXe9kg2kN9MyU1RFYUGEDMReQ==
X-Received: by 2002:a17:90b:4d90:b0:369:a359:b192 with SMTP id
 98e67ed59e1d1-36a45182255mr894506a91.10.1779330921773; 
 Wed, 20 May 2026 19:35:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4d90:b0:369:a359:b192 with SMTP id
 98e67ed59e1d1-36a45182255mr894459a91.10.1779330921381; 
 Wed, 20 May 2026 19:35:21 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb3aedfsm958899a91.4.2026.05.20.19.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 19:35:20 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths with
 dotted directories
Date: Thu, 21 May 2026 02:34:59 +0000
Message-ID: <20260521023503.29315-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:44 +0200
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

The get_basename() helper in tools/fit_image.c searches the entire input
path for the last '/' and the last '.' independently. When the last '.'
falls at an offset earlier than the last '/' (for example "./mydt",
"a.b/c", or "sub.d/leaf"), 'end' points before 'start' and the computed
length is negative. The subsequent size check uses signed comparison so
the negative value passes through unchanged, and memcpy() is then called
with that length implicitly cast to size_t, which segfaults.

Restrict the dot search to the substring that follows the last slash so
that only an extension in the filename component can become the end of
the basename. This matches the function's stated intent of stripping an
extension from the leaf, and keeps the existing behaviour for typical
inputs such as "arch/arm/dts/foo.dtb".

Reproducer that previously segfaulted and now produces a valid image:

  echo dummy > kernel.bin
  echo dummy > ./mydt
  ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
                  -a 0x80000000 -e 0x80000000 -n test \
                  -d kernel.bin -b ./mydt out.itb

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 1dbc14c63e4..6c129117297 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -265,8 +265,14 @@ static void get_basename(char *str, int size, const char *fname)
 	 */
 	p = strrchr(fname, '/');
 	start = p ? p + 1 : fname;
-	p = strrchr(fname, '.');
-	end = p ? p : fname + strlen(fname);
+	/*
+	 * Search for the extension dot only within the basename. Searching
+	 * the whole path would let a dot in the directory part (for example
+	 * "./mydt" or "a.b/c") place 'end' before 'start' and produce a
+	 * negative length, which the size check below does not catch.
+	 */
+	p = strrchr(start, '.');
+	end = p ? p : start + strlen(start);
 	len = end - start;
 	if (len >= size)
 		len = size - 1;
-- 
2.43.0

