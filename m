Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dPsN7bRv;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DyI+fzbG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5F7A60671;
	Fri, 23 Oct 2026 11:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajbq-UkgE_mH; Fri, 23 Oct 2026 11:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E395A60672
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755469;
	b=XUN9IgfnUQstm3PNTmwPdCCFnitbVMp20wBaBNgNOZHq7DUtp2UkTdR529xcuh2de3vr
	 oLhaHfvI7u/LTX9xiVg7HDKAR55x2B4KlV5k0JSKFI8dUCGNm5+RFFZq+zI8XhXChhriw
	 /E8/Uqe1RfISSFKHb0aP3yCHK+5ixY9+hjX0WIhmYeMCd6CCH82lcIFZVsV4cWduFm4WN
	 ETAxa/Kz4LlyjegRzU4ApPX7ACLy/Sy0g2Ei2f/bvrKWksFogJ++42f6z2puGI3Dk1JIq
	 ui8R5dH+K+plGDk5RJomym6vD91oyzJ/tRF0lSFD9+b2pC3F5HNrQr7IaWHUFNKsaUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
	b=SUr1aaeFEE/5MW9kA08b6mzzuKjyM+1/v3PlB9c+NPeu2MVv2/J6Y895G1VunNq17hip
	 2RXHaZe7skznT07xUAaZbJOD8gJ1BloA67IylHxt8PGd5gflK6oAWx0rqX4KIVOWPRwhM
	 jt4oo96miv4qWBh0IzlJhQQKJ/xmdCaX24eu8xNZI5E8iW+q5/O9tN0cAbkDabFLEntzu
	 V3Bd3Rc4REzB2kEGT+PBVStOXbSSBsJglrl2KgcIG6/ABXsOjBlu5k9NVb4DK9eDJtAmO
	 bL0HnO1TOXsQSYGjGvZ92TJChfn4IqeFzxQLUpdYE6HtZ/u4zHfhDgHYEoO6xSS2BhA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755469;
	bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dPsN7bRvUnwQklmHv5ta6RB1jYCVCN4nqpWFxZDj6DqjdjBnwnuifUxAjMiZ332Qa
	 msO/r9tO4yb6ro/1RCBlWyzTBfAKuAJk+kSnsn1sHf73SIqHKrvHpGKXqQquXjQtQG
	 ZgdXitQYSwF9FMfiilx0zD78wWyIvxdIj+jmtGcBRolfT9HLjgbBp9DDf1jUuhxS9+
	 rsE6PIdlOCduqodj2rDLNbCI6hvcJ80NRDo0zSUEDvzzGn/BILaL2rG2fw5QgHYpJB
	 YKasXd2ffbCHYccg+a7RTIj3fYqLa2erSsJ0ZGF/Z7BlrP6sIjIEJHK8jeNnVdE1SF
	 HVgzufSNXggMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E395A60672;
	Fri, 23 Oct 2026 11:37:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD5513AF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EF444008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJ8kbiJMUliq for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 95D5640064
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755464;
 b=Cptry2HpkA3tgGwYC9w0WglbQDL337CVKf2bRON5DcEE32xI2nJ94IOjGuRtBQ6VDn8Y
 PZpNwBMycue52dbxTvlTV6SYD6/e/Uvvw3Oe+jL3w0LRBdHR72ORHySLpuCRp+a7ReCme
 TlKLEeoJRzUrKwAIFaXx9WgU9wU0jIby3Gpkp9y9cRk5SdNI6IHDWsVgBQ4Yw+abBmjWi
 xi7SnTDrLQrbuiERsizTTqvu0HPS8mKf5Ajbzo97mgKiXF8D9ReakZVfhDHlaTn3ZLBhN
 9sAIfzJ8zGlr1bNq+4W5BI+jtieTSjrr6yWIp6OKdVjnuUNV66m8/qclYYOuBs6CS4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
 b=C5GcFqE1HPYLrlhtTU/Cr0/Aydczq+ACqEcLTd2u40FEWlzRPDxUo0aM37W6htSvknIG
 JRqaENI1ybsgwM8kiwM8uM9B73u92AuopMfrHniPxvAH2FqyghUIH75dU1ZDUhiDIuuXl
 Ar+PBTAHHV8c7QUhTkWXtT8nN/wIk8OnpOeFihlO4F8azKG97hTf5P+G7VBXmHFJSbksM
 bG1OLGCLlLjEyhSUegsaZeCloeJAQIH+uv8NVf8ycmuEYCdKn8wtMx35UX0DQCy268OSf
 GeU+jjmNT5cmzGkklxj2gkH6bLJMRgl3UNNVW/0u0hZw+b8SlpzJ08h95KaNoAMIUtg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DyI+fzbG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DyI+fzbG
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95D5640064
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:43 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso106854066b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755461; cv=none;
 d=google.com; s=arc-20260327;
 b=OkRyT+1Egy5ol5arS0IWxbW4r6UJELgidSahOV+j9X3uKTBsUg87xCGk0Bk7YHpE8T
 maPGIvnWo8MojeTJ9ZIMXu5r7WXshGJx+QVd/l6eMGwMeZMPMwg47buCY4xyZ0n4NhHV
 3hkFfovwNhaEU6eYnZW8hBzwkoWRiCuwU9OPqkwyVAm2t6/ApTJU8NKTXapuVP321Vni
 atszStRIXRGXTD2hMi7zoSXGiKvNUu48Uyz63OU+BksaPEvPEi/htejzNDIZOQPlC6EF
 uufnYJ9vKBdBA/a+RbGRNnYh8AW2dK6tgL1ULjZJ+hJw6yrInthL1wajKAA7sEcSTbsK
 z/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
 fh=mllJCE18KUW/VUdMkiuwKXLFZxyLKuGg0deYbU6cb90=;
 b=O77dac0egv4VN1lpWuzsUnO0HyozGTT0GFIc/ffYDhbQHmTns2aJgrCoQakxt50xCi
 w/5SjlJjImmvMPfsbAPh6s7nQIa+ZHn4mo9fEl9K7LwMfaIG8KpzemPNsEqjDqMydISD
 k57tQPYNR7LFuLGxFT4fZfaATOsCVZ5OoEQv1uerg9WRl59OH5L+k9CDAOwNio7Ec+40
 NN+tFoI1Aam5n5kky1sK/w0iMeuKn4HgPNMQJSaobtBrOoh3FU/ETDzDfet5bMy/6zux
 1e1b5w50KRvEUGaXYc1CWHzObJi+D26tN0D5XKDHAJpadx7qCu/jsblP90pm/ACH1Cm5
 Av0g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792755461; x=1793360261;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
 b=DyI+fzbGfxOf7UO7Sqq1v5HhMI1S34ZFeJzakTXmiAEm+6TQy9O3DxtQODSwfG5nw0
 W+yVgky2zeDHXH0hQRWGVW4JC98rZP2PTYZlivrAFtNCPcyQDkWw+jFBQNSAkqphiYHm
 QzffRbNK8715r+aFbhvURq9Ko1kkYv4cGO/BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755461; x=1793360261;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6ynIh1p9PqPfh94Q8J/xVpOI50mdRZcY7ptg7nzOKE0=;
 b=XwzmdrhuOReVG/3gjuIltOWOFV5B31++6jE7kjNEUViqI+/SKHLg5kMhuoATF8wJLv
 rchtQvCqXzn0r8ibp89mk1+JUl5K5iBFsBlRE+Jr4oKGl6AGSrwztuiGmffLy1Py/KY6
 R+fT4f7A3mCi/zwC1OHIiB/RSgyX2Nc7BE84FDpsjwT4RAVJUsfTCPzBw81P+QH6UJU0
 MVvcDPu9tXSx/fnO3jQQHtdmaqkvoks7DeO0bViCYtZN4+mxn9hbrQIkDuSKMoDJftJr
 kJwJZvx3221TNao+0nhGJXySCCcPOAEpJhDFNFvJNUw/sN/90lzE11NYHRDfAyysRDBP
 0q4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByPXv+WSK2JgQpqJqH1aZDbQZ9GIorOaK9xqBQS+Lt1/oOsTkvveL6t0WhTw/zrO0fKBU286MA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGc+byvWjgRsSHHMENbl031ntSaqRmqhlbA+5amjfguXKVdZhU
 QH/X2SclVMhXNG0f5QzQ3hakTlJWEpCF+jVzPSg1PVWhESs+o3+lWJ6iYpKxQ0IW5eZkTbDTZBB
 n8xi/y08+upKDiEZw0/qahGdXHd8d392V2e8nrG6D
X-Gm-Gg: AYBFou1fT9bnHfoZjDQAi3JeYTpKzP7huTO4HdY3FjsNx+/rH34Tu4umAEywXZFg5gs
 QRBvqvgmvSjRTWWgTv6jC86OvkfoE4y8RIu7Gl5JUV9vguSEkFPoPIKlVnZjSuBd97B0P+GakKP
 VoHbhaPh4o+Xrx3jmoduAezSdNKApXKJPl22Ln47lsUqZoJe1CB+4hVonXfoyEU8wCVnzZeFe9E
 h9tilzrSvks5PH55m2sfknB0jiaiPHpZrROfGvZbSilBhdGWlCfNOLfzeqqKdj63j89m3XWBb6e
 L9Sk2s/7d8Xek5Sb8ExraHTdmI/iN58BQ9tsFnQhiAvhV5hM5dn0c/nl4dU8qkWzxwLptu7Ux57
 8GffbbKfisGKPwHcUUz0NUuMdV3WRpCfCGGo=
X-Received: by 2002:a17:907:968d:b0:c41:4d5:e97c with SMTP id
 a640c23a62f3a-c46a93f90a4mr252107266b.37.1792755461179; Fri, 23 Oct 2026
 04:37:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:37:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 19:30:51 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <18ba08d92985d340aed6dd006b99321f0c443f17.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
 <18ba08d92985d340aed6dd006b99321f0c443f17.1792591479.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 04:37:37 -0700
X-Gm-Features: AclHuK8srnq1PEOjmv69xDqL0Z4GDpw50DS8NVgjsKUK9MSRx9FYFqz720nVQYY
Message-ID: <CAFLszTjTZs8Pg-Nryf0RmxeYC5__c+tqTim46HdDqXu8oi_m6g@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] test: boot: imagemap: caller-owned region not
 resized
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Vincent Jardin <vjardin@free.fr>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T14:08:59, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: imagemap: caller-owned region not resized
>
> Add a unit test that locks down the fix in imagemap_map(): a larger
> request against a region recorded by imagemap_map_to() (which the
> caller owns and is not LMB-reserved) falls through to a fresh LMB
> allocation instead of resizing the caller's memory.
>
> The test reserves a caller-owned buffer inside the LMB-managed RAM,
> records a 64-byte region there via imagemap_map_to() with a guard
> pattern beyond the payload, then issues a 256-byte imagemap_map() at the
> same base. It verifies the returned pointer differs from the caller's
> buffer, the guard tail is unchanged, and the new region is LMB-reserved.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  test/boot/imagemap.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
