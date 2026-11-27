Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75C606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pBfU3jfa;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YZp0EicN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B330560D5F;
	Fri, 27 Nov 2026 16:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UcdQuGl62FQm; Fri, 27 Nov 2026 16:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FA4660A54
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796978;
	b=TQ74ZJ0+FLB0tpxLNl1OQJzvByfXIWX/i186ZayYii6zkTDmXTUiDS7nAOgScjPrI89C
	 4slhFQ9+zNBya0XSDzqI37XbVFbeSVfUZ5c1w/o+I6/n3Ce914NCuNzbMjX98mVwhaPNK
	 wXllUn4MVYEK6rHJ6v/slYZqQw4E286oqFdUV+qtEqNiEQCnFCNiDP31ZlAIM1GuY1Xsj
	 w0oCMM3MOPjoD8MpKKXoMn07J9SsbChHcAs2+TXJqOPSAZC7mYr22FevGWwvEfpvboCyp
	 harOP1Mhnqo/xUxyBs2kCFIYqaHKKAU3hiIQQ3VQePUgymO05K3kLPjeRO8a5ODrzAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nHDe7Co1SIQj6+jF6MZ5Mn7AYruq5yM4inucGkmaMZo=;
	b=Dp/Ac4hCX4K9VfrfKQysTa1TThrlWoIstc6m/kV+8WowCBgVGl5N/6ylc8+zKE7ZqmGO
	 LI8x2OUKJSnKNp/vDJT/AeVTd5SJMPnyfx6grn5AE2hVzskopdp3w3lumEuIOkhhdHq+b
	 WYfZ8u0q9nENcf/6du5ORKhKd0S9mpXqD6kouG5+umnIeHzENxE9D13Ga96Z9O7YEgqIN
	 2dMXEREadj/NG42HbNQWKsCdBlIXVxShEm5pRLDtLWNc8LWsEO4zkwmDycrM/cGUS4kxf
	 dbV2dgdHeqw8zBHQ1E1Vr+xg30wwW6RI2UeHRx75E4XB83j6bqYBVsIyLDGFvwMIlsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796978;
	bh=nHDe7Co1SIQj6+jF6MZ5Mn7AYruq5yM4inucGkmaMZo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBfU3jfarUTDEU9noDv6W6OQM6RvM0W2khi37ViIHy/w/i4nGtzxEZOl/JBhhQih3
	 EUfw8qyDkNvpMVNEVBLwW4Wu41HJJnS17IQhUAPEG+/BVoeH1iknFP2zjmzT+qj6d4
	 GcbWVpq+TYVNk8hT67wGtTF5Jw5MIBcbmn1IFtsGuJjFuaLItBG9rro9pJg1pa9Hqd
	 5zzzsVKsfJRMdZ7Xi/gKcwjGHjnCh7xSfRPcxBRl+0/Dkxc4kP9Fij3kU1jLl2oq15
	 th5nDm9HYddxR64/nXjbVoWiPjN6E1+Np8RXFoW5PRK3+h044gt8OzGkxdDSDDyVVG
	 nw3eJMTvFiKsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FA4660A54;
	Fri, 27 Nov 2026 16:29:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0FA11C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE3BB40623
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEKHfmz0WLLq for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:29:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 20C44405CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YZp0EicN
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20C44405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:33 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-717080a2d50so7562951eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795796972; x=1796401772;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nHDe7Co1SIQj6+jF6MZ5Mn7AYruq5yM4inucGkmaMZo=;
 b=YZp0EicNlNqwvw/4bBkEyvwQy5DYqOdMuP5T5QpUVRcR3RwRW3x0CZnb7a9U/dUVyr
 327VrCr7rkrCUS/5/hapmb75WOJHlSgMUDehe69lEaBSsO835HmhC+ls7G5qQIenVhqq
 WnfS+odibIDIxFD7zkidJYDSu+V5vIEvN3Izw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796972; x=1796401772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nHDe7Co1SIQj6+jF6MZ5Mn7AYruq5yM4inucGkmaMZo=;
 b=MpOciMDSjAOTiLgTIVfF59iKQEd8U+ktJ24TkI2clkaIvYOsAPE6Sg/n9+oakKGNZ0
 MrZu/NWILF5TjFq4myhkh9Y/EraLaW4sozRjBo4T1Hs4eMpex/5UItkyfMZp/cU4G0of
 +XOMBDuUtO0bUa/Q4gqEe9MlfQyFo9CyzTvIIdX0gvy8tsfFo+upBFEOm0TH3RBmv8ev
 VhrljH95dN9A493P58UBM7yWwTUttYGOj7trQF+qbVaWO1XM5ayzNF6mxNLNzYcR+mfy
 U3u+mGQ1VvuPAqR35jYMljNUorTTOXXMgy451Qs/1FN9eaLOITud8PN95r4hAU8NBbCE
 5fWA==
X-Gm-Message-State: APuU4Z+zR7EUlFQkV6U8wmyPhLUymLSwoM7TW9IZT+gS8FKk5+D3ciCE
 q6CtmtcYBhXx/YaNDwA8SBThzwqQgRJSuTwuYwNaYXE9sGPX23mNK77dwwd1j0Ozx+8aEPN/hdF
 ruLr7KbgGX9pk
X-Gm-Gg: AZFdTZem8Z13CVONk1Gvw9Gocj+Noy6A98sZssKIIV0LKonIrGsniJMPSjc1M9arh9t
 YhJ+3L47ESotEZ3UswyTmaKsXtnommzwCRq1TpFWKmb85lAt4KT72cd5RY8RHaHiA96ngRXRU/4
 yU6jVUy1pvSJ5fFpSCYwn5TTTfW9ZRITeAWKNXQ2Ll7R5wRRWjX3UUXBKWrT5v3+tJCpSInJAOd
 SufupMugYDwinbkeJqdd6P+OmDnf/cLVe4jEdRLIV7fLD82f6fvV6FFBRDp+vHfQJNfR7MJ9wPL
 C1RcQ8gFs5MgmbSjhUKLm1XJLeWcIR7je2kl1CKm5Lwy6FxdlQ5vI65ocAoQgZXJKMCzjeiIvaK
 KqtuawQYnnQuUzsPLs6nUeuQ+zb3jepg3IfOARMOtroAprmxTnV9r6GJuhyLryoS7mwgIbEzQzv
 wyrbkMRuuOnkdV9jotl/1ctxMpstfuWEinhXMauOVT66kLcC4/U4bvys3rF/K7XS7tUdS3fKtqq
 3A4BynayxkO8UAjl+BOmLKz+0h1Gx5QCwDjesg/we47QaAbs9V9DaWMJo3Rk7oastpsJKwZhX97
 DKFOHzeqRCzJxh20+cKop1QAp/wyo6OuEIOA9Cc0TgotOKB1CeZMESfUXK41hov7JmrV3crims4
 6iu3Nia4HHXKhVnvTDQRrWy9bw1kWRVEo9YioSB7xAbV8+QXq3G0UiQ7dmk6iL5e86DPMXkNP4Y
 eUsrVIcAFV/WOoH/mb3XdZAMY4eEN5Qair6MVDmjUx1quikxP2jvr18Uo=
X-Received: by 2002:a05:6820:7083:10b0:70d:7aa9:8618 with SMTP id
 006d021491bc7-71b395250fdmr15151434eaf.63.1795796972515; 
 Fri, 27 Nov 2026 08:29:32 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b865900ccsm4746056eaf.6.2026.11.27.08.29.31
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:29:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/4] Dockerfile: Set SHELL to in turn set pipefail
Date: Fri, 27 Nov 2026 10:26:26 -0600
Message-ID: <20261127162927.3545062-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127162927.3545062-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The default behavior of a Dockerfile means that pipefail is not set and
so errors of that class lead to successful builds but incomplete
containers. Change our SHELL to bash and set pipefail so that all of
that class of error is caught.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None
---
 tools/docker/Dockerfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index e666714f0490..48d9de7ab4a6 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -6,6 +6,9 @@ FROM ubuntu:noble-20251013
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
+# Ensure we have pipefail set in all steps
+SHELL ["/bin/bash", "-o", "pipefail", "-c"]
+
 # Used by Docker to set the target platform: valid values are linux/arm64
 # and linux/amd64
 ARG TARGETPLATFORM
-- 
2.43.0

