Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E02606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d4PmUEFN;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nstWF0go
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4475F606A0;
	Thu, 29 Oct 2026 06:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcgD7BFMpJX8; Thu, 29 Oct 2026 06:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DA626068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793255269;
	b=Tc5Fw6JOjT0iuQPwfYOavEWMBSaJ/2TU+MBE3O2O74OhgejSAIWVFiYhKXaMFt8W4xAB
	 fOKYAOcOaXQx21jSxbesxYNwOY5g1CBwMlS4/eRwGHBsInqoTTsbma1WpRYDdkVEK2UZ4
	 GH2ni39n7LqO2n3pbyqluWdhgvzBh3Zem5taSRPhElv2Oq+1tvOI46ZlC7SqikuHFDT03
	 jUsIN2zKw5nOoaHUl3lfgB+uEl6JKT5y7Ueqo8j8xuIif50ab7Q6D8avJj7K6PXTFOv5W
	 GOKNMXkR004GOo2nZ2M8xoKasSURoIH0rqy04lv9gEEH/PCPxHMA2yjLyrmDr8J7wjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793255269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2BuPgpWCH5zvf2y/MTxfTOA99u6uXeX/lOzSk5ZsG8Y=;
	b=BaPLhmk9vJO0OXP3SfSPnxDI/vqe/JVJi8okBU9L7juxrwaIGQOawMoo+yofJwQ8Ehav
	 qfeZ86c6OoPhj0zWMM8baeklFIuMezoh2gXk8U+j3QCQXgVY+E3j0VrROdTVbsuAuOssK
	 1UwBvrdHoFoIHGkSWnZK6ZTg2ePfzekb5zTbIeFA043i4gsrNRB+RWS9EWfb2ubHSS7wL
	 68RBxvCuC+LC/4H1c0nBmyCs62EtKFvaUrSHC5QL1dv3bKRAgEJ3XziDS64OeKXGqRz2w
	 Kb+E7H4T1V2hNYa1CFHL1CzFhcv1fLzrqhjwDE3Kye4E7gWY2oVOXKsxFp9/1Bc4d5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793255269;
	bh=2BuPgpWCH5zvf2y/MTxfTOA99u6uXeX/lOzSk5ZsG8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d4PmUEFNGeqHfG8aSCjlxFOLYgSujWuBoho+1CMLveZLeqd764H2pT5Norx89EH35
	 00VVQwrDvI1FgleWc7u68+hyplqOEP8rXZT4i72CYf0ndgmsASJRPPEEL2HekGcjUg
	 qMJTSnDyhHeP4MIJCGb0At0waMyeUcKIn1fY0fCBO/gJL401mbs6hMGkt2r+V39EWB
	 xQ7xNMVB14Q6f9OQTWjzpNdM9EcB7UB0kXZSPdqMitZ1X/pTMNal1i3ygwclKfCC+x
	 A2vPahhuchtoC0RoPCXYs921sfzCUjy7vYA79WQm/l18Hw1zLMfpaVNZ57znXF2bkC
	 ecHKFCf95H0ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DA626068D;
	Thu, 29 Oct 2026 06:27:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4340D380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34F8480F75
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29I7EZ-qPAC5 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 06:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D98180F74
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793255264;
 b=rT8WlCvngJXY5jO4iZlPShe9by0dmyn+200wpfuXk75p/Yyvc4P71Hjyqu0mJ86tRafb
 PbIP4ec97GcKc+O2j8O6Wkb5JFPtgRep7QMVwsxpbV6VMSqiKgjtbCb8/LItdmcysNBpL
 2mpVsFrNhvlxCyRKw9ZFjGVccWc3z3DCAHzUGBCTauJlANcPe92hJ5XI2Qfr/x+ZvcL8c
 GgM7IgTCJtJcWwt0NB5e6DloNv47tGdRWA6zp9S5SwVb0ZqQTqVBRqP7lGm4zZ0uHd1ZH
 uqOvsPY2nz3+uRNgGwz25TqSkdXSFTZ+/ycCUNonZK4ebnPMCBlJpDT5LwmpEjLZSZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793255264;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=2BuPgpWCH5zvf2y/MTxfTOA99u6uXeX/lOzSk5ZsG8Y=;
 b=W/WnNzjl34jMbu/hdcF/7x+UlKQkZSjs8gsxGTDG/OjmyW4WRu7Ic1xgyCJWy1fSIkkh
 Tz9xrvW4x9CQtLytzaCmszJOv3wR7TTUxgg+NA0JdovM7qNltyOubg40POOI+fQuTpg03
 DALOtbI/EHSGbKFrEM8shqbT+tOLrTdfwMFOiE6P7ZuJwda7b5t8whJre1msvP88eRSmS
 s0R2XnEdJNJMq/h1/LTrrEh0H2BqBKeTQXVfF5iRl0VWZvY4VEynChBenWAvcYMwzDaBv
 Qh9GG3eiQ2p4Y673ouNLYod+NH3NH/BkTHYk6dshoLJbiJ95sZy28fwhguaet80bsxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nstWF0go; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nstWF0go
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D98180F74
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:27:43 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jFZ641j0rzMlcF;
 Thu, 29 Oct 2026 07:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793255260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BuPgpWCH5zvf2y/MTxfTOA99u6uXeX/lOzSk5ZsG8Y=;
 b=nstWF0go2Kyuvuuefqs9oYJiTS7Eqpi5OWoN3LHvhl11HUc04bkWgyAvjVbq8wIkYMQ6sr
 nmOq0mE+ij8qhga3AdabF498YuYkV8mplz88wd2h1zSOfvB2PSJekNodXf/aBfDihuRyAp
 yBFyfIW0/HI5UdfjO3H5QKYjFVjXuo6SsskKTqr7QYYCbgICQxipovMh9iHViBjXQhrhl4
 jrD5gcry3waWRbn+73Lx9ymjZ1FKDqOpsAw10Vz+5Q6MU5V/ekOLRtUgeT+9IBAn6bSkmH
 6tYgljbB0nXuAQtiwgE2QMlj2W98jph4EoMa5NKXb3xcJvAYroLN4WTDB0Vk2Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] tools: mkimage: Fix discarded const qualifier warning
Date: Thu, 29 Oct 2026 07:27:28 +0100
Message-ID: <20261029062735.898715-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029062735.898715-1-marek.vasut+renesas@mailbox.org>
References: <20261029062735.898715-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7f65jo1rryq389dyy8qgcrarrgffumxp
X-MBO-RS-ID: 0ab00e08f23128e6ec7
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GCC 16.1 defaults to C23 and glibc 2.43 added const qualifiers to
several functions. In particular strchr() will now return a const
char * when a const char * is given as input, and a char * when
given a char * as input.

Fix the following build warning by aligning the data types:
"
tools/image-host.c: In function ‘fit_pre_load_data’:
tools/image-host.c:1797:14: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
 1797 |         name = strchr(algo_name, ',');
      |              ^
"

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
V2: Add RB from Simon
V3: No change
---
 tools/image-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4874c33a01c..b7f3ed826f2 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1763,7 +1763,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 	int pre_load_noffset;
 	const char *algo_name;
 	const char *key_name;
-	char *name;
+	const char *name;
 	int ret;
 
 	if (!keydir || !keydest || !fit)
-- 
2.53.0

