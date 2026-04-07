Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86CEFF5134
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473A58404A;
	Tue,  7 Apr 2026 21:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ORzJxxqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E72C840AB; Tue,  7 Apr 2026 21:13:42 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC5383936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-688c2235cd4so309168eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775589219; x=1776194019;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l7uH2cF50hbvfco73InGqxpV7CDGFo/gzJl2I/lTw40=;
 b=ORzJxxqJUFw6yy45bahePL+YX8y02LGv5qPjDBIQDqjEBeOWvDNDjTlLcbrUH9loy8
 o5o+CurCxV74IdhXQP1pGNzuSqW6LO4HCzBlVoy+GO0H1KDPlLllK2AVK4ELmmV7nPl9
 iy1YUCc7urDtz4Rq7Pd00JSQBckIt+yqDuazAvjUsNikdJfLdOOEcTSx44DBLKKpCF+i
 ryAba1VGZnFvuwI2xt9wHy5JO+4KA1Tz3nVREdNwm/0KIWzaeg9zQLmCK5chR2xPPHrw
 WhrWmeAn2pmTMi7LdLWZ2ndz8BTjKRApEds49eAZIuLIW2+wxPfxtmOWxdN5brt4BdX2
 1UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589219; x=1776194019;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7uH2cF50hbvfco73InGqxpV7CDGFo/gzJl2I/lTw40=;
 b=ZUs3K35nrnu76VD7kNey+mRuJ46z8Y3f//JKcuR4nwdE8K38dPUn+Wv3vjQ1bf+QqS
 n0zAor5Toxzrc/wHa66WfhsxThGyIL/oz8iQbNBMKjJt0emRsibcyT+QVb8fXVifi/03
 OpHcjB5ACxkWQNRQFJP7WNZidejz57xB+Re85FARmC65VMtVFL/kapJLKMsd0RAY4bvY
 +qYU1rup46hkVDnEJ2qetxg51UaXesU8BvPV8FCBoARTDbYadLM6ZwpiRpV3nQ1tjRel
 FJeo+sF/kZyaIWjl3Xf37jXxBgHdsFtNmAS/mGxQoJVrxps2Y7OJ3zht6DGj0CndOKpD
 K58A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDTfcDMUw1N1NOFq+tMAWE08LlkwsZMV7BoTNyw6Oipd9+q7SRHu1KaxREjkGugc14Sd8snWs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy06prsTTngyN+vvayS6kKkvgrb4lo37dgyx4+21xPc4el/pZ/5
 ymBzrGTaLH3Q00dtzfJQTf1h8fc1vJx4ofaV20Bo4mN/KbonkpYOF+pyUCbSYmwjgr49NUPdSR9
 bBsN0
X-Gm-Gg: AeBDievMQJs2K5qGWElxm3V9rjswgPqPFsqTRbCA8jf6PFB9D7XcB4IJXRCcbMnhtaX
 sy/1jhJTOXNVegqggusKHiisN5dsfAci1mDpJnURhTmxqztRbc/o7jCG/Swga3KTarHChQod7jq
 YLUZor1rCWi+1dZlNzw2vJ3ryqazCPq0NQMjkOn+aGwhY4oQY+bc2rG7v8yxh9BDxasQFEdv4c6
 DxCETuEF8KM+Ty3WLX68D4S9iR0i3USEpBoBZ8iUpGYqIH3HrIBdumZ3m68nzU7qUbINghcQk1C
 RdVzNdGKqUDs/5le8spmaLbwaVpEqv+9qmpjnhSg8EORv7FOiDNDci2ObmdogBmzAAzD8PoFqmd
 qtYLQIk6SwJvODufsQm+sylXmArhqSqRAINss21LzuaOUmYCS4zsqwCm4N3ukK56eQF/fuEHn30
 depw7XOlUO6EOqoehzuF0w6+EnbL7q
X-Received: by 2002:a05:6820:4716:b0:688:29ff:2de6 with SMTP id
 006d021491bc7-68829ff3130mr1139481eaf.40.1775589218794; 
 Tue, 07 Apr 2026 12:13:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6874bdf0f3esm2214990eaf.4.2026.04.07.12.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:13:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Apr 2026 14:13:25 -0500
Subject: [PATCH] doc: release cycle: fix 2026.04 stats link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-doc-fix-stats-link-v1-1-1b53b54f816b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1IQjDQq0gXaTLqWIklE6Ug3
 r2xLj947z9AKDMJPJoDMu0svKYK3TYQJp9GQo7VYJTplFUO4xpw4C9K8UVw4fRGR8YZr72NSkM
 9fjLVxT/aP2/L9poplKsE5/kDG1AeTnYAAAA=
X-Change-ID: 20260407-doc-fix-stats-link-7e272a1a4d01
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=EGDOBW0DFRpDLg99zf5ytQsuePQkYOjTsqeo2XxeyQs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1VdbimLdcsKTcDdEDIe5fqmVSH5R6rCT/Hoe0
 b7ugLMhMZ6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadVXWxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiYgIAJeD+agTVsYEOULslWbQpZUJMiOAUAeZskcgQ33
 rWP7+ZURFDSXJE26VL3L7O8y5gDoVQs5mvNFZXICOxONarWyYFGLqOwS3GuEayUzO+AOobfyGeZ
 vC1Yvbc5UEszXoclY1FRNS02Ft09phUtf6TvMb/RGNKDkB0Sh0Ijonfw/Nc0lViGgHEr94ueI2r
 jNeWDfn2/wn7M6FBQj/F43IsprIypBAK/5aQbBdnCssGV++FCzh4RaLPJQTJ5iL9miG62VfVj/F
 9XMfGxCCndglB2te/RFgjj5WNmiCyQAezsk0MkHhyPv0p/alkZTScRjnJa5SW4NKkDXsK3lSE8w
 BuXU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Fix the link to the 2026.04 stats page. It was likely copied from the
2026.01 line below and not updated.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/release_cycle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index 8f5496f477e..69678f2897a 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -97,7 +97,7 @@ Note: these statistics are generated by our fork of `gitdm
 <https://source.denx.de/u-boot/gitdm>`_, which was originally created by
 Jonathan Corbet.
 
-* :doc:`statistics/u-boot-stats-v2026.01` which was released on 06 April 2026.
+* :doc:`statistics/u-boot-stats-v2026.04` which was released on 06 April 2026.
 
 * :doc:`statistics/u-boot-stats-v2026.01` which was released on 05 January 2026.
 

---
base-commit: 93f84ee022a8401421cdaab84fe7d106d83fdb4a
change-id: 20260407-doc-fix-stats-link-7e272a1a4d01

Best regards,
--  
David Lechner <dlechner@baylibre.com>

