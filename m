Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69361606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aWafjmfS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VOrjUJ84
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF5DC60DA6;
	Wed, 11 Nov 2026 20:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8sGzkj5lc3l; Wed, 11 Nov 2026 20:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3D2260DBB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427891;
	b=V9TYCTDdbiMgzH0xF1LawPBKFfOgAHP36C68KBLiHTDZfOi4EaGA7ln4URxWzh4DTiHI
	 nZIl6FR3/durpl6v8XlPxOMP+VvKicb5hNMcamNP00E6qlfUMZlUy/wY3IXGFZnA9W4zc
	 H79KgAl8OMiMvdrE7xUd83HscIjodrA271fjYQfO/Doz2ZQxwIvl6QqdGD5D9calDVCP/
	 IzfA38hEE2hH+16s4+ObniphbCYc7ryD+WkU44Voo//bMpfJLtxzyfA/5QmzIoRrX4y0B
	 1UJRYSVb8lJTQ0FAXsANpcfM61B9bhgjKSC0HxRKD8f+YpeavuP7AblGIKdwiB0kS8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JCHxpdCBV8A4aLlZe7yjcVC3gB/I7sjSAMBf19dJazE=;
	b=nToEGw8cLl1v6gG76/R4NhYNyEV42SRS/Hfb+m6GNeKo7g5ByfUOC1xR2gXgbVayYiHD
	 /etrt2CXYMmRz7goh5TEnTnfO4BKbqlkdExy/Vkcgr+YulxjGQ8wGWyLmvjUrcVMujxOT
	 K4mazE2B5XJ5q0p8yEmuUJprS4dSr1J2K/L02Acfia7pzbL9xvuQ9NjQ7XjzP9MfmbOTC
	 OoQ+OfRisSZ5o/Bb8hQYp9v3eFM/+RNFBVnHQaCU6rJ1tdFCAK/BZ1hHnGSegPrBZry11
	 +VsrEwY123eS0OA4mAz1dIT1cpwdlqAa33xXJuJ/hjcE34kFzh1k0Q3fAFglgWPslGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427891;
	bh=JCHxpdCBV8A4aLlZe7yjcVC3gB/I7sjSAMBf19dJazE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWafjmfSwfUiu1lCkWRAWY5IGv65kwy7JzMuBpGmlfhr79bDUrkQJz+bvdhJTB6ll
	 P9zhTlpyTShdBXPvE7hYwXTCKvC8o3V3YRWLL2MsKy2mUZP4uqEfq2/9C0xVekQpIg
	 v64Vgv2e+RuR97GWyXXLMtpNdNMlK/QabQETQf48wg+vzWpq82pgjxTGNTrGJEBP3P
	 NE+N9UZQqt/TskJC1ipwWAAl43Era8J8L/0uAPUKkCYv/5PLfaYC+8DF4FMndT+o4n
	 TjMWgjPfeYKVw42ug8vA336tPYCrRiAfC7Uj5PshDWxl7XeRDlzQCVwUjTEHG1PgkB
	 38DXO0t72jOjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3D2260DBB;
	Wed, 11 Nov 2026 20:11:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60BD8EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 525AA408F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufrXmZ-34Z0M for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A308740920
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VOrjUJ84
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A308740920
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:23 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4ad587ba293so2140585fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427882; x=1795032682;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCHxpdCBV8A4aLlZe7yjcVC3gB/I7sjSAMBf19dJazE=;
 b=VOrjUJ84377U68ll/QsEyIbp+RA9OPCkrLXBy1gzMlCeLHc0HjCfd26+0RXwvTJjNS
 Oe36Co1H8870mV6/MKjKjbC7T4JqpnrnA58l4LzdFKk7lK0DP7keLQxt01qH7woduw7C
 Zhym5+BBJibn9K+ZzwwW/9pxc5R/T+uIrhUfio1qnzJXvSJpgXT2au0ghrqF2vdq7/x0
 GvBqq0XQJvhEIi9w0jigGMZ8fBZ359QM2LMbQqEKyLUdSwDJLsL0nXhaATHY8zvGDHqv
 Zz90DegOKE6apGnzpUEjLs9WhEwiiU3AMUcJU5WlfaCUUXgcdZTXOUGSp3UusHUk+Y0o
 0TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427882; x=1795032682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCHxpdCBV8A4aLlZe7yjcVC3gB/I7sjSAMBf19dJazE=;
 b=SxPm3cuExWoSvBsPWxwlnoidwGg/p3uvzw72qVgbdX3R72Ad2HjyF0r2E0wOdeDLW6
 +NNkFO4vQPnZLNByZJ7PeR0cv8iLwFr+/vS5uXNYCA6xzerpQmJfOTNDMJBtRRhFzWzO
 D6lpx+KjHnmpwkW+1IvxLCEpZ2QJGxvFLW3hTn+OuMHBMZQY+ICybkagBBpnKCbW9DvM
 qcv5wIbgBkaShwE7F6KqKNPLx4U01RhQPOOSLsdjQ7hmiabVlqzgQ72GpO2B7+jR8C3F
 tBrzhbZ32DjUL4BFdI1Yn5bvgYasz6t7o4Yt70q9bYr4BjpGOJdmrrKb54wiSNTYBhXc
 DEdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEuva7lKKQsxSa4B6/9f1vmkRfMk5jyOmprhyGB8ZGhsajyxp2auFml5Mk2N4PffuzZ4IOly0U=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+UhqyngD5dSvgHFe9oMjEFHVXIlTSSAI4dssdak/mtNwQEs8Cs
 Fd+Kca+gSJhqNcXH/UVflUyUHBudVfTSfZIYqjPDEzcWnn8vIZ8VrSAS
X-Gm-Gg: AYBFou2iqJKpMkBXi9p3CcnhHBJxHuhGZZTmAnIRquCzsd+kEvSdlsEbcEQxghJFsJD
 i93RQZWtvabYVoSXDb/LXlo+FpIeZzkCwQj5JQaXCYe19+qNAikM1KbYubwLH014zOHCOwIyRZh
 dlg4sa+sPRVmzDp4pNHNiXm6kAa7ZlpYkM4dEKUZX0QVOIpqErBYHexg91PvpDPZdFlIbUJ1H8q
 BLSgnrMmKefEHyW6zfVMWmWtr9TjqSxbTYFQlfKW7kvF+OLkPy4mT2C17/uuUqzWcyYW8V1susU
 SglCBV9F0ublvbU4xAwn8lns9yWR9QzCEK38IawYwmqVoc4Joq2DqcEtzG2V5HY/y5/+SVR5BvQ
 bKLiy9km9L7nKvnEKWP523Zal7BbJ9yZN0EYcfU9LiF8urPaIjjMvEEyvKH62PVLPl9AHYlIWIb
 M/cnuo35BOKdZG9clmjk93InG1EmO3pE0BvGv2HAj0nVYaqq1L3OHFthnO6m2V54H0GdJdbQc7J
 zyj6zbDyVO3KJUAaF1GDI70rz2si0mtpdX3tTyNFlsy9lDp1JzVKGAHAkAAQj7+cHuqb+torgxr
 Fu9nKI7P3Z3v8vqSTAcr1uBAEf38BNHJqMiCcFR0GwTCzPbFUJmox+Xqf+76Y1dCiVUirWb5fPA
 90o6FXhyead7mR00eKD8jolVDw4e+/RD/utOwdv5A+EERnZURVMATy+9fo3zDqGb2yCm8IU6tjj
 tD8yHV9WifjIMCDQJnsXFak5r5uBfHMBmwDZAyX4s4jNB4jThNjiI=
X-Received: by 2002:a05:6808:6f86:b0:567:d689:9b62 with SMTP id
 5614622812f47-56b8f7b4966mr3126623b6e.0.1794427882146; 
 Wed, 11 Nov 2026 12:11:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:11 -0700
Subject: [PATCH 04/19] net: lwip: recognize wget URL schemes only at the
 beginning
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-4-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

parse_url() validates the URL prefix but then searches the entire string
for http:// before checking for https://. If an HTTPS path or query
contains an HTTP URL, the embedded URL supplies both the scheme and the
host. This silently switches the download to cleartext HTTP, bypassing
the HTTPS authentication settings.

Select the scheme at the validated start of the URL and parse the
authority immediately after that prefix. Embedded URLs remain part of
the request target.

Fixes: 5907c8164705 ("net: lwip: Enable https:// support for wget")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/wget.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 96ee600c5e1..ecbac188f70 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -98,9 +98,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path,
 	*is_https = false;
 	*port = HTTP_PORT_DEFAULT;
 	prefix_len = strlen("http://");
-	p = strstr(url, "http://");
-	if (!p) {
-		p = strstr(url, "https://");
+	p = url;
+	if (strncmp(p, "http://", prefix_len)) {
 		prefix_len = strlen("https://");
 		*port = HTTPS_PORT_DEFAULT;
 		*is_https = true;

-- 
2.53.0

