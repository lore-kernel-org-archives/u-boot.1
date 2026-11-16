Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FD606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lzS2vovY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHqW6Qlp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEB5D80F4A;
	Mon, 16 Nov 2026 14:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bF66tX3F9bHk; Mon, 16 Nov 2026 14:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0953F80F40
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794840677;
	b=mudEdS8WKsipkCV+uwlXTI07/plBuwA/F8HAO8ok8QBu3UUS0Alk7K5159irSd9peWBV
	 fs8LHWlg/72HN4fa3mz6NaU/NmYyi1kSqDWeYQixGRLafQCRlOnEWZScaydTIQXbZTm9c
	 H1q8Krg2ReoSMI5E1anDRO3EC/VKKCBm7gq86HQogCvulQxv9Xa67t+aVBEl1gefGmMu5
	 Y8umifLyHZB3RtineRXMFhK9FRyGl7P09XirfSbuSEJwYnbyaPFF2Ae1m36iFuwPdJCF6
	 j45K1PaWTN6CIAPXTkAn74kOOqCZKfd2wtNTnpvplKX3rmv4FBS3ib4HDXO5P4x9Cww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794840677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y/SQ1zUB+Y06U26c7Jq71AsFeBYt/r0kmzCHknIA1B4=;
	b=a2EPnijEkvn9w5xPPhglCSFl/1Km0105kV5OXAQjPbuFUkjpbVnP0lMM0Dzw8ME01uRj
	 TkHUbXlYN16xK3/mUleYzv/9HpCtiWz88EEgk9+ZBa+wnG8rjlfO7Ysv43VJl4GUIh7F/
	 xTFAwgsP27Evxhx/mSKhKIXQgbc2hxrUQ1v7r4cv34m2ZqO57eddn5zoz0DcemblptKgg
	 q48NhoeeqFXS5VPSb8z/dho30/pLQ4MHlscK1hK292uuvQ22gbOWNs9O1f72VquOsUsaj
	 Itjw9BYDkDkgS8VlS7dl+t7dfNcSBBkCa9cNukx3vlvxoEMwZ6soLg1GFpHrfKWfj0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794840677;
	bh=Y/SQ1zUB+Y06U26c7Jq71AsFeBYt/r0kmzCHknIA1B4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lzS2vovYcQYFQTIL+3JsbB+VOqjF+GM4aX3KpCxmnMKicmN76+zgXH1bvj2QaBcgp
	 EgbGkXKQGtn1NHTpLfekW2adWuw3cEaS3L7fBvz/JDB0uBR95ryVingzqL3XgVBo+C
	 GaIHLPYuRQ3kLPgQNbFkr3VLGYCAksSPVWgcJmm4ZwPNpY8ZBL604kAa2apMGgVwFA
	 ZNJ8z6KlT89oi399RaYY5Z70i4If64XvvRmK5MPTYfk7WUN6ZXnl+AGNb/Y7ftm47H
	 OAzkUxvJ4ad3qVy+DsP0wacnfUkEqbSUIf/GENXmTBDPKDUm8z6Zs00zT9byWXjRqZ
	 Lu7Svb/Kk/FLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0953F80F40;
	Mon, 16 Nov 2026 14:51:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05ABF260
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBC514029F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCloxbGPK2z8 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:50:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2B3B840288
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=wilcox101@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rHqW6Qlp
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B3B840288
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:50:10 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso3462306b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794840610; x=1795445410;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/SQ1zUB+Y06U26c7Jq71AsFeBYt/r0kmzCHknIA1B4=;
 b=rHqW6QlpJP4T3sYVNfPL1fZL82Lh5IwHA3uI0M6Ubj061+C++isUUWvtFALiIj3VtA
 resssTWSRhfQU4nLObQhU8UxYPiq+7Nx2WMWLZ+eVzqvG1rBZ5C6wRHClPLDYNOtB5wX
 Dt4zW/0bzcCnzzWTRgnMdli54bZdvAhq2KXo4w3dkvf81pBk5w0ofxD7nSAw2/OsAAHH
 HbQuiER7STKtZI5BSnB38Z7OmnLlfhdX1xiBuHWXROb61PGv/5yR6IoW3QKJPLagq5pY
 kwaPJjaaEp2Pep8AfuXcpyctXzqNg0f3AWmqLToVcTnYwk5G4GceB3vNvCJJCOgKOjp4
 YzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840610; x=1795445410;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y/SQ1zUB+Y06U26c7Jq71AsFeBYt/r0kmzCHknIA1B4=;
 b=R229ekmXFYyI97Jk6oj6JGfN5DE/SUr+s1QYgiZgLEuohpLloQBb+JvwZSMdGNnVgC
 0CfbFySO0byBRrTR57p8iTx9vmCjL71JRj0rSHmmy80fQ4F5nIVqIBWNle9CENllao8C
 TIdZJEtMOYZIZhsQ/J60nzjLBhHD5C+8nAQCNkjlAYdkNHmYnPK+t886mw7l6t/0kJkK
 Pud4052l8oZpt23vLo7sUeOfajrfTV4pN5VuNLdc22SI3ktiAl2kBCniyggMb+mO2bbI
 D36utw5TsTTwEhHVPNLhtkWzlVW5UrmCiaFEp60mEAH6TzwNea8ORtsENpfchky8fgo0
 2xpQ==
X-Gm-Message-State: APuU4Z/L+nBTMwJ+F5IBOUbKUf4DKAs3sW0c7CYcQXMOr7S8kF4QQOE5
 zu85zukHa9zVZkY0MxRBAPqlQ/AKbo3t7oEdbLma5+iOdncuoOMQLOEIAuQyaxhUH3TJRQYPPrR
 uwLFCdHlhMmR9sQp51TOP7XlfY22ZsOR5bFgL
X-Gm-Gg: AYBFou0untcZjiA7ZVZqQbaYo+LhbfeC+oUt2WikL7lVCgqeziSHzs2fw24RelWenWB
 iONP0Xg6j+Hc/6eCFliT523veCc6KU944JHL+SxTCL6ZeJLkh/0Cl6d+DbtbnAJ0Jt+SN8j0i63
 fwIyU4ma0ORhrpNfUkv3l/cUZPwZbghNVPdUSITrdiOP1Qk/diil/lJK2NPONuEJqff6LbP81lZ
 2X6zonHjEF8btWb9dupWzDPg/II32JFn2XJDqgB8cgPjm6GmuH+X3UWpo9qXQV5+UcQZfrQ6W6h
 sEqXCjndVHecbMqBlLlNII3zMbHHuCUaLFqpBM8hLJ8bqOwFB3eE/ujl27x1U0jkkHXZ6HjpvF8
 26LGpQeuxRD2IvAZlwOBK0lcXlOlW5zioYS3qws6gvoU2U6O9e7kN2c3ILhvJjOcNoZrNeH5nmW
 HWTaAr4hWlhocIBY3MbYO7FuA=
X-Received: by 2002:a05:6808:138c:b0:4d6:9133:cfe4 with SMTP id
 5614622812f47-56cd8dce91bmr8551143b6e.41.1794840609766; Mon, 16 Nov 2026
 06:50:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dale Wilcox <wilcox101@gmail.com>
Date: Mon, 16 Nov 2026 09:49:58 -0500
X-Gm-Features: AclHuK9jZyuvX40Hg97dBt44dcSRN45qKHCzwYWUJWW-bMc-xhGEVlWiDYzW7Xc
Message-ID: <CAKtUr1Uu3rg9KMAYtqOnYNo=ONu=X9XpDbEvn0tcEyZFzP5=iw@mail.gmail.com>
Subject: [PATCH] binman: Fix SPDX licence tag in lib/binman.c and
 include/binman.h
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000f942d1066065e405"
X-Mailman-Approved-At: Mon, 16 Nov 2026 14:51:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f942d1066065e405
Content-Type: text/plain; charset="UTF-8"

Both files have carried "SPDX-License-Identifier: Intel" since they were
added (between v2020.01 and v2020.04), although their headers say
"Copyright 2019 Google LLC, Written by Simon Glass" and the rest of binman
is GPL-2.0+. "Intel" is not an SPDX list identifier and has no text in
Licenses/; it looks like a copy-paste slip. Simon agreed on the list that
the tag is a mistake and offered to ack a fix, so use GPL-2.0+, matching
the rest of binman.

This patch was prepared with an AI assistant (Claude).

Signed-off-by: Dale Wilcox <wilcox101@gmail.com>
---
include/binman.h | 2 +-
lib/binman.c | 2 +-
2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/binman.h b/include/binman.h
index 62a522ea..dd370f15 100644
--- a/include/binman.h
+++ b/include/binman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: Intel */
+/* SPDX-License-Identifier: GPL-2.0+ */
/*
* Access to binman information at runtime
*
diff --git a/lib/binman.c b/lib/binman.c
index a594fe4c..589dfd5e 100644
--- a/lib/binman.c
+++ b/lib/binman.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: Intel
+// SPDX-License-Identifier: GPL-2.0+
/*
* Access to binman information at runtime
*
-- 
2.43.0

--000000000000f942d1066065e405
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"auto">Both files have carried &quot;SPDX-=
License-Identifier: Intel&quot; since they were<br>added (between v2020.01 =
and v2020.04), although their headers say<br>&quot;Copyright 2019 Google LL=
C, Written by Simon Glass&quot; and the rest of binman<br>is GPL-2.0+. &quo=
t;Intel&quot; is not an SPDX list identifier and has no text in<br>Licenses=
/; it looks like a copy-paste slip. Simon agreed on the list that<br>the ta=
g is a mistake and offered to ack a fix, so use GPL-2.0+, matching<br>the r=
est of binman.<br><br>This patch was prepared with an AI assistant (Claude)=
.<br><br>Signed-off-by: Dale Wilcox &lt;<a href=3D"mailto:wilcox101@gmail.c=
om" target=3D"_blank">wilcox101@gmail.com</a>&gt;<br>---<br> include/binman=
.h | 2 +-<br> lib/binman.c     | 2 +-<br> 2 files changed, 2 insertions(+),=
 2 deletions(-)<br><br>diff --git a/include/binman.h b/include/binman.h<br>=
index 62a522ea..dd370f15 100644<br>--- a/include/binman.h<br>+++ b/include/=
binman.h<br>@@ -1,4 +1,4 @@<br>-/* SPDX-License-Identifier: Intel */<br>+/*=
 SPDX-License-Identifier: GPL-2.0+ */<br> /*<br>  * Access to binman inform=
ation at runtime<br>  *<br>diff --git a/lib/binman.c b/lib/binman.c<br>inde=
x a594fe4c..589dfd5e 100644<br>--- a/lib/binman.c<br>+++ b/lib/binman.c<br>=
@@ -1,4 +1,4 @@<br>-// SPDX-License-Identifier: Intel<br>+// SPDX-License-I=
dentifier: GPL-2.0+<br> /*<br>  * Access to binman information at runtime<b=
r>  *<br>-- <br>2.43.0<br></div></div></div>

--000000000000f942d1066065e405--
