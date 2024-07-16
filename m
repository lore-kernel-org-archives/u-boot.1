Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF909C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 14:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D970889A2;
	Tue, 16 Jul 2024 16:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H+1lEFVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F89C88980; Tue, 16 Jul 2024 16:35:52 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6E6889D4
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c1d2f7ab69so3110163eaf.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721140548; x=1721745348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RebBoiNqgl1c5ZlTeehIitU9F9CHR8JZTygUiT2+8uc=;
 b=H+1lEFVffwCjKZeY1o65xwPbNUG03ut8xk5lWuO4r1QUZ6Hoi7+8SGF+5cheatS2gX
 wN2eepba/5GgSX2HfT3AbWB72E5UzyrmgF0o4gHZC4CHhPx36/xY5jTfOTXW+PU9yEPd
 VIIxWP3KstJk2ILD6LwZBnT4LkIkrXKtXELGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140548; x=1721745348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RebBoiNqgl1c5ZlTeehIitU9F9CHR8JZTygUiT2+8uc=;
 b=H0/1G3hSIOmHU/F4Gk9+lmaXz1oFWBeMNNrG3kZGC8sUIm33OmbEdUTxbEJpfFVZzl
 s6hgRgi8GJ77PAy5U/hH8TPLX+ZZQIT58xiKss52GfY/go+c7Kwf1TVFZH7MGSsT20bI
 wagwHYABGCaFAHi9BDLxq2rDsr5N7adMfd3UnlmCOsKsCYtRWSaoYKTSnF4Wh4qZkbME
 0991Me0d4PZ2y9cFgjP38z+aEyRpRkV1hnruW9OmvsW882qXD+JinSWuiBMfOJacoKvM
 p8AmPWPtzIEBtzlM6iG/awxmea6LN68rJRPNnf4EaLyoikDviu92soi60iknhcwVSK+P
 GmPQ==
X-Gm-Message-State: AOJu0YzhrFk0LK9ACGeZvtG0P4ed74xPDNAXZaKRhLFP4+030pUpHOLU
 UtjmPhPkmXvcRoUddKzzfxUutoO4uoxBvPE1m4p40M/zt93L24uOickkiZt/yd79HnTFCf/cBbC
 c
X-Google-Smtp-Source: AGHT+IGbinNl4UtNMhfERGyyygZfrLzz0zN/0qZMqE1yA54L+THZWW74iDFYAla7e9/yI7p18hpyxQ==
X-Received: by 2002:a05:6820:2612:b0:5c4:3f91:7e14 with SMTP id
 006d021491bc7-5d289416881mr2612007eaf.3.1721140548617; 
 Tue, 16 Jul 2024 07:35:48 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce770ed2a2sm1193664eaf.34.2024.07.16.07.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:35:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michal Simek <michal.simek@amd.com>
Subject: [v2] zlib: Fix big performance regression
Date: Tue, 16 Jul 2024 08:35:46 -0600
Message-Id: <20240716143546.647604-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
brings a big performance regression in inflate_fast(), which leads
to watchdog timer reset on powerpc 8xx.

It looks like that commit does more than what it describe, it
especially removed an important optimisation that was doing copies
using halfwords instead of bytes. That unexpected change multiplied
by almost 4 the time spent in inflate_fast() and increased by 40%
the overall time needed to uncompress linux kernel image.

So partially revert that commit but keep post incrementation as it
is the initial purpose of said commit.

Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
[trini: Combine assorted patches in to this one, just restoring the
        performance commit]
Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Given that in master we now have Michal's series un-reverted, I have
collapsed Christophe's series down to a patch that is just fixing the
performance issues, while not regressing other platforms.

Cc: Michal Simek <michal.simek@amd.com>
---
 lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++----------
 lib/zlib/zlib.h    |  1 -
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index 5e2a65ad4d27..b5a0adcce69f 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -236,18 +236,47 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                     }
                 }
                 else {
+		    unsigned short *sout;
+		    unsigned long loops;
+
                     from = out - dist;          /* copy direct from output */
-                    do {                        /* minimum length is three */
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        len -= 3;
-                    } while (len > 2);
-                    if (len) {
-                        *out++ = *from++;
-                        if (len > 1)
-                            *out++ = *from++;
-                    }
+                    /* minimum length is three */
+		    /* Align out addr */
+		    if (!((long)(out - 1) & 1)) {
+			*out++ = *from++;
+			len--;
+		    }
+		    sout = (unsigned short *)out;
+		    if (dist > 2 ) {
+			unsigned short *sfrom;
+
+			sfrom = (unsigned short *)from;
+			loops = len >> 1;
+			do
+			    *sout++ = get_unaligned(sfrom++);
+			while (--loops);
+			out = (unsigned char *)sout;
+			from = (unsigned char *)sfrom;
+		    } else { /* dist == 1 or dist == 2 */
+			unsigned short pat16;
+
+			pat16 = *(sout - 1);
+			if (dist == 1)
+#if defined(__BIG_ENDIAN)
+			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
+#elif defined(__LITTLE_ENDIAN)
+			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
+#else
+#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
+#endif
+			loops = len >> 1;
+			do
+			    *sout++ = pat16;
+			while (--loops);
+			out = (unsigned char *)sout;
+		    }
+		    if (len & 1)
+			*out++ = *from++;
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
diff --git a/lib/zlib/zlib.h b/lib/zlib/zlib.h
index 560e7be97d3a..f9b2f69ac027 100644
--- a/lib/zlib/zlib.h
+++ b/lib/zlib/zlib.h
@@ -10,7 +10,6 @@
 /* avoid conflicts */
 #undef OFF
 #undef ASMINF
-#undef POSTINC
 #undef NO_GZIP
 #define GUNZIP
 #undef STDC
-- 
2.34.1

