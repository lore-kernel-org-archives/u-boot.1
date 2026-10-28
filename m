Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72627606A33B
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cfAaxl0S;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X2TExiK7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A64402B2;
	Wed, 28 Oct 2026 19:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svfNN11Hoe7q; Wed, 28 Oct 2026 19:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D0CC40368
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793214809;
	b=I5Ofn5SI582MnvK53q2yA4dAaM9Kc992x5fKlOwDM1Oqozv1gJq+YMxYmYIrpwN0PBNF
	 +d8ROfAQy611XA/yIkdXApbLQEQpwXVIE/C8lch9LT9FpQXH6tWrnZ29H85JUgYdyMBFE
	 F6ZG7auMFt6d90yDX1+alp3m14d9bRHa8XG+22/nSv34Lq473ujhzO0lBPzRnSLX1ZfN7
	 YCEjPPDvL9tL+bEd3vD3uyF19KPwE43uLdROf0VDsWnL/vS6TSyxHQzn6chCh6fIqA1aU
	 1u3WMwOtmtG946TmT50JvQjdvYmuSMRGUzO7ng6ZK8N9pmLCqSUtAxfanR0QUPgxmhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793214809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nlM/dfJiRSRGnkPUP3nOP1l5FpaJ/iqhk9gHAdmUdvg=;
	b=VuodLDvyrWkRqK9+L6Wm0WBM8Jq4zoSfupgRkZKuusWuMp83G0VoWDfsCKCrLXCWCV8K
	 tZjg5WaLTTLYtGa3mJTxdDg3QhZORyl4SAZ04odneomcaZmmFe3vGGXewwX26Tb8HtHeL
	 +QF3QpNoc8kghkikzXR2HcfDRYcaYaA1U/NeLZKxXn0FJZ/0+a74soSmNCQP4g45KU5v3
	 kaLd4LztKidBvTwOx8IKNcACptylNHQRU1ld55/iwGO0iV8H4D/EmH6GjZ/zZXIxSguq9
	 fFtmhbqDLQ+C3ZkQlyqtcOlaDg1hEsdbBdkJs59+VdidrDg5F59P886ly+reJQb5iPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793214809;
	bh=nlM/dfJiRSRGnkPUP3nOP1l5FpaJ/iqhk9gHAdmUdvg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cfAaxl0SGV8/F3sFlwinikOUE+X3dlP+oApyZe0vh3zaYZmTq8SWQ2E7eZF+pUc/d
	 Gt+/x7WnIgXQAHFnZvRswZtabXkTIubLjCqNhWH7Ulb17hW+yzutBKLKytGnH42Xlw
	 wEGKHsMD5j0AQ+TDfPF1HVuwsc+vX7kxFLrBnQbhgsvvOqHlj4IMFqzYb9HDx6s8h1
	 32by01VUWWlNvePAuaWd+/lfQCEn+Cilgg/VV3w1yB3Lh0+QrBrmA3O/aSujgHp8zw
	 j/PlodxMFoSKZeoQu777/663WLAepuZBW61cNOUnSRkeWbbLNAkoEGlyChAeBgUqeZ
	 lzQLiozfOd1Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D0CC40368;
	Wed, 28 Oct 2026 19:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB7C4120
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 19:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A15C9813FB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 19:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jMd3DdIknAZs for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 19:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EB72813F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793214807;
 b=dW/ap3ao+hZXsII+R6svPtrwGl9e2g01doG9WLT1v0cbSfyVQkmLDnNVjV1Ac0/k0gZK
 5SPoYAGYlZS29oMRm3BLgB8IINMqBO19nlPibkWjUGU7XVPvZuHUv2pt/S54UEXXUNA8e
 RpKCtnxrNOwqeyMW5+SqEZLA/PjMo6dZ9i/2XRJ8QcEhq2MmDH0cMFEFPi/bcZi2bJIOb
 /Gym8W2kjauE9rrWCejfg982u+gKrYAePx2OD0cnTmjppFU6zEDkIHSCYXfbsZVaMhfxF
 ARL4eMWKuqYIoWMD5liFz1NCPF7z2E8sc6dG9b7Y6lQTdhVJMwR0VLqblEZ6siPhkqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793214807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=nlM/dfJiRSRGnkPUP3nOP1l5FpaJ/iqhk9gHAdmUdvg=;
 b=h+x0iLUAJKyQbsAzCdWZp3Vc0/SVpCsoAymCJujVblJzAV+iAp6UxzLqWBrY/gT6qels
 VwQ/tnzgmu7iDzehJJSFuMjcZaR2mp1ioD1zscTnQzY6kGw5UoqYxqZiPqhTBjbdA3f1C
 zYJ9o373oA/+89wsG+r6i7ahj8GF0afnWUUoopb1hFECJv0D53E2OQ3XhPSXs7rOufzl6
 r4KBdlwQv2L4W2cepdmdFBDohOqhbmisX7D5r+l1iTxAHIaGOIqMKXBtA+dclFQ5qLeLO
 rPv7nW92bVN0/x5n1pijR5x5emBfHv6D8qtlIKjLUMYJx87Jgqjc3bwRSSu1sE3QACw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X2TExiK7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X2TExiK7
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EB72813F5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 19:13:25 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91791ec1b83so11409796d6.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793214804; x=1793819604;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nlM/dfJiRSRGnkPUP3nOP1l5FpaJ/iqhk9gHAdmUdvg=;
 b=X2TExiK7XIMfd4A44vzo75A2+/P/fQZDeINxedJMNn/UHS8PYBVXui6FCieGHkMijH
 PboGh5xg9BF8Wpv9c7tsP9Mmgw10U1LkHGW7CT5nhWjisCiZ60OrXRbPevk8QqNC5HRA
 0bictC6fmwyw0auEkOYKBRImscWsfY4zWZq+Dj5BD4o7ppTiAkEhFQprjtfTaXemSghN
 I8Y9ybrLUhc46lGpkz7nzzUKtdYYU8x8KKry3urPrFVPoRsGUuxXbjVKw20UFixjxI96
 LedycBsqgd/1hMyOZOFWTXpSGiNyPt3MtMs21XOuOkG3/vZ/rYuMnWsDbj/mOzfvxVj0
 jFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214804; x=1793819604;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nlM/dfJiRSRGnkPUP3nOP1l5FpaJ/iqhk9gHAdmUdvg=;
 b=SOgVO71AYywPEUtyRumgIf+3msBKW8smvQVKPJAFZf8uwo7sbux+FdWy/MfJJl7t2v
 zvaU4d1v4OoTfgziypUdrhMoxkZ/eO+GVzgLG1guyf2D+Movzq6WYHndDT/37bKY078f
 7mBqyIzG1sJW31qNwd21N3byfhbGb8a2bx3ohLQU1wMUoYotz1YIfmueUQhsQcHrMqGt
 kVokZHx8iYPu08cbBNWxuqW05SRIbsR+hmtsbUw+cQ2SZplkP6fKVxWAHb/P5h/i5Rbz
 ijXwH87tV6AN87kv9fi1q5baY9rV+YAEzvgkxgZIo038D54fSAfvn6oHMkzl1FbE9DXt
 0oMg==
X-Gm-Message-State: AFq9FYIwBxY9wfzk6POpbuUl4Kwr/UeiIk7zOWgk9Ufw1fWkXcbUlphJ
 CSGkQWlb+pCERPpCFzJe9pm/NNH46s8RWRTmpreO3xphrNmvjiHnzC96c/5sGrw9JKb786eLpeZ
 YpUSPJGc=
X-Gm-Gg: AYBFou0kk7rR1iuVG89JHs6TiojNmp6pE0g7UFKmm8Qw5fQYw8Qs5RpqD/lUEv6usWj
 eO+2LfId14nCTBURKbrVb7/x24NPQwc7uC6f2T+jvxHBwQwPkrHFi+Pl2kMlYgis1bLv9Bbr7gR
 9dhOB1t8XlPuejSs3hIOW8X6n4ayuwVU8xGvOsxvhWaGPKX/GAwLRkXi6ZYBb2O9Me3qc96LdHZ
 6kqvcSi3m5+9/sFgSOEmzd0Fn6RWG/2lqavMEBy8q+geCPR3XWm06bvdpJo4kB47G9dH/yyPK8U
 bPN7N/VNpNa410RY8zrI1C21MjNMvEotR8CQIEyHXKhCO2o8FTvGw/GdlD3VsqCzOJjgJzWNDgk
 xXvJvZyM6nyKoYm9BFxVe1k0Rnks4LovCkYdBkOQknE1+/jB4j9rKDlojRjoAFH34aXBb5Vyz2T
 Z75cGA6wZjpUdXadBG+L07Rfj7tbLTTLfH5ZMX2sT+rHovyV3jdtjnUHloeOeZ1ZxP4hnFsaiq0
 ViSfBhFlDJg81sZrdUb3fD75AZO4HDhfS99WqXkG88crppZ7p0E0y94yvPcwJKdwZ/beBD7mhhE
 0SkN+24QK3aXnwZk98xJLKwciRFempI2zCKJHGsZBUkVYLN+ggcQxPJ6/yEXqJ4mtwcoyHMcXZ2
 pF5C2EGb1seW45W1ehpsr2qVV
X-Received: by 2002:a05:620a:84c8:b0:93c:62c4:e2e2 with SMTP id
 af79cd13be357-94408939a88mr490373785a.12.1793214804304; 
 Wed, 28 Oct 2026 12:13:24 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.141.188])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f066731esm1341192985a.9.2026.10.28.12.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 12:13:23 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 28 Oct 2026 15:13:16 -0400
Subject: [PATCH] doc: develop/sending_patches: add tips for series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEtJ4moC/yXMQQqDMBBG4avIrDugUcT2KqWLmPzR6SJKRkUQ7
 25sl9/ivYMUSaD0Kg5K2ERlihnVoyA32jiAxWeTKU1blaZjPzlWRC9x4NkuboSyr23TNgEhPDv
 K5ZwQZP9d35+/de2/cMu9ovO8AHiEfh13AAAA
X-Change-ID: 20261028-doc-sending-patches-d3a464feff98
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1793214803; l=2617;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=3tlxdxH3815SH+IqxIx9t+9rS7swsUTSn7opEUzlkT4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFyF8on8IOix311f5vPYc6iEfHDSThBQLZsc5nh56r11KokjIdDEkoXgtQorB8pM80qonnXYIj9
 ccrk3oSYhAAc=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Related patches can be grouped into a "patch series". Add some tips on
how to decide how much belongs into a "patch series".

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 doc/develop/sending_patches.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index b4f82eb18e1..b6c2a865928 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,38 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+Tips for creating patch series
+------------------------------
+
+A series of related patches can be sent as a "patch series", as described
+above. Individual patches should be small and self contained. Likewise,
+this also applies to each "patch series". Keep the following in mind:
+
+* large series are harder to review. Maintainers are busy and may postpone
+  large reviews, whereas smaller reviews can be "squeezed in" more easily
+
+* tools like ``b4`` and ``patman`` will collect reviewers for each patch,
+  but then send the entire series to all reviewers found. This is not ideal
+  since it floods maintainers with patches they might not care about.
+
+A better approach is to break up a large series into smaller sub-series,
+for example by subsystem (clock, pinctrl, reset, etc.). This allows better
+targeting of only the relevant reviewers for each sub-series.
+
+Of course there are sometimes cases where a large patch series is okay:
+
+* when the changes are all in a specific area: for example when fixing a bug
+  in a driver, but also doing some refactoring or cleanup in the same code
+
+* when there are unavoidable dependencies between patches: keeping them
+  together avoids having to explain how multiple series are dependent
+
+In a nutshell, the goal should be to break up changes into smaller pieces,
+so the change can be more easily understood by reviewers. Combining multiple
+patches into a series makes sense as a way of grouping related changes, but
+if this results in a very large number of reviewers (eg. 25 or more) then
+the series should probably be split into smaller sub pieces.
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261028-doc-sending-patches-d3a464feff98

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

