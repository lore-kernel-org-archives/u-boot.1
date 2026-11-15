Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9488606A32F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dNHPlMuS;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=N923Zg5A
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B651240505;
	Sun, 15 Nov 2026 21:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXcHfA_FyT4G; Sun, 15 Nov 2026 21:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA5B740540
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794778975;
	b=JRGH7QX9Sp0NULcD19BXQ0D5unfC2gKEQojtpwB+Lfpw+ZpsQkJB4AZxf9pNsnYCfgoi
	 G+n/7bg2S0zhf43Yjf9s0OWG18/x//aDn0faW3IXytww/FjQzgnU8thkX/6BGhTHcVuVw
	 D/Igx3K65/IT4ApQfa9BcbKM8EpZfcJ1g0OQxSGoiKfWPc+nh46BT21vnUUcna73NFTh6
	 dC0FQUPGdHlY/4Vpug/+psFhDqX9IOPJr9cku/XmXmOnR99qlzBobaL2qfxW0MlcLeOlF
	 3Trw+0UZxsEEWfTbT5i9Y1+fhw95dpWA4rL9i0dJPdlDhwmJQs8yUgPoiYjBnWrebZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794778975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P/DwbQV6RTKVpF5afwAuXTX6HHAhZRzSCShbRnHE0Zo=;
	b=XRXl7Z+c+X4i0lvJzowB11jhW0UtZsm6PURf4Vn+c8K+e224el+Fd7/SIei5TDg1U1EP
	 MslNB6hoswHn/skOgUcp0pIg7ca22yOB9p/DHkfkT7zu+a5TD8WRfulI6xRd1vhCU+0OW
	 hBokjas34zXtUzP8lTvrGjXzjQEqYX1F4C1rJSSEoPmXIoE1mKDnN8pYT4GO2eTn5cq4j
	 KhZ3eSECDqEU2zYDdzRfmutgpUe1dvgs+bHgntH9hCrEVGyzIhAf6aoMHtjYl0CDSElm3
	 zyg5FusgPF7fM7JCRXDkbJ8UsYgXfR+d11kTgOsEHXYPzrkMkOazhZl+z2GzFzNhu/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794778975;
	bh=P/DwbQV6RTKVpF5afwAuXTX6HHAhZRzSCShbRnHE0Zo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dNHPlMuSs+rYL9W/+qQcKJhPENj1Tjfubo6acklfE5aM1cVK/sCYr9fHX5HRBImyZ
	 vR0QC1is3PC3wRss/rqUAe0oUb6/a+ZCGBkGXAXzFcIydsA5B5+KKCqTvalV8mFmPe
	 OdcbPEDoYX4EfIc24AsUxxSWBPWP1h3BnXUG6WE6WuUyFA2ud4QgYkzK76IDEdPy57
	 q+Y5OJKsXdii0ga1icjIFUKbK4HcVGejuppz8FUt2DwVOhW/ZTnavs5CJtZmQSmM0t
	 NjD7Z2hbrrGmREjRGUasydKJoA1oO7UebIEQzZSJzgC9SZCOir8iM+Gjand++eAYXC
	 /3hXU95DYbQ6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA5B740540;
	Sun, 15 Nov 2026 21:42:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D43A170B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC2FB40080
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdRwO9Wsxn-m for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 21:42:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6766D40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=N923Zg5A
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6766D40048
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:42:50 +0000 (UTC)
Received: from LT03 (dynamic-176-006-073-112.176.6.pool.telefonica.de
 [176.6.73.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EA0AB40B08; 
 Sun, 15 Nov 2026 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794778968;
 bh=P/DwbQV6RTKVpF5afwAuXTX6HHAhZRzSCShbRnHE0Zo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=N923Zg5AJQ40rA5rTu57QFlPLKhShUKWfwX4+WSZp+iHscIiqT44EF7LM+9zswUKk
 OFzPbsbosqf2pSLKSwluEwnT/a+XhrUCgnC0MC1XtRt0Fxvj0bOs/oHN/Z6kMiCPum
 q7h72l922qaf410plm74noSD69GHehPKDwIaRKDSJDXp7kqTyO0dT02n4MVqV6H36J
 lRL9nEcqbxtpl+epxARoNjU4p3R9KCQcaBWKtfsBQTQOV0JpSfHLh4XvLKI8dBkark
 AVCM2BvTlvOMRQksm+Fxf+ANI9e0IizAUQDEHj9qtJKuHU0oW2iRucTLju8zz3OJdN
 w1vb5e0RAGW4X8JfL3ysMOxSvftFgi/wvt6Y8A1zspQhb0Ln68pSuPqq0HeZo01OWO
 gaZgqHbN5Ii8UU0ILil5CCXy1N63mLr5ndaDwiK6QerFV4tjyvZK8mK0NncvOxvNmR
 mja5EU+cTCz86xlKAItTP9l3nCSpcfQz68hKZ978z4Jh2CzZ0NSN5Oxd31VuFImAJ8
 N2pNxYeoJqgKUiyWBNE7o94zJxSMQfAr0JYHsZZ5q2F9zSymcWcSEnqk0yqck80nsw
 24x52zC3WAkaZG8lMYNtpZhkl+Mvlx2d+umsR62UXfaZdxqljLYKlB4BqKSHW9JrcM
 RkV4obeLYtxkH4LqT/hefBDQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: avoid discarded qualifier in fit_pre_load_data()
Date: Sun, 15 Nov 2026 22:42:44 +0100
Message-ID: <20261115214244.43117-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Building with gcc 15.2 results in a warning

    tools/image-host.c:1797:14: warning:
    assignment discards 'const' qualifier from
    pointer target type [-Wdiscarded-qualifiers]
     1797 |         name = strchr((const char *)algo_name, ',');
          |              ^

Add the missing const qualifier to variable 'name'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 03c4a07cf28..73572f11438 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1765,7 +1765,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	int pre_load_noffset;
 	const void *algo_name;
 	const void *key_name;
-	char *name;
+	const char *name;
 	int ret;
 
 	if (!keydir || !keydest || !fit)
-- 
2.53.0

