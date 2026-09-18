Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37FAC982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A90160C31;
	Fri, 18 Sep 2026 20:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QQXRjiIHrGy; Fri, 18 Sep 2026 20:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A23A960D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764657;
	b=QoFjE7JNFxhhpoaz5vWv6P90Ioh2oMtBoH6m6HYmlcnLlFlaL5quUEjn3Konu1D7srRA
	 D2I0IkoY3RMNK7CMoIFVZufFVxuVJV6tStVKwFbzf4Er0Z4/tbiSUG/3J/v/kjW41Mgw4
	 epHwLPUfzDiA9qBYUCUJoUyKpKfU6eIr2V8gWRhefqOdBsQXs5gDFor0zxbwW9rDrph3k
	 THIxXlE8jAhdvlUSd18/xPIN4/j8lnlVFz+ZnI91cwSJNhHFJ1FCFGVwjtZbTgkH/rbKK
	 0XmMrQ3Rd+WnRORgejx3Q0eknmCL6Qz07RgRzqN4DFF7PgxYPqLx9yNnk31d5wDccaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
	b=HwO7AJysuhPxKSusTbtfYJlcr2bFhZ2kNEGYxkFUSprmfT0UGACgWI5Fsv9fX89sWDP1
	 6w1W2rmf9M24rFMV58rBnMRYw5K8NK4TEpWD+qLV5xHHOVSU0RgauAhQuXAUJtqt5OrzD
	 TOs58fq0+ge5TvHfz11daeY7uPBGZgfzl3LBTuWWDvHJ83EwjEAi45C1mpLtG4/MLJU4s
	 IxQfa8oxH0JOYfveFbdNl3C7PVEWreVZhS/BM+H5hCgSLwxQnBru4tA0eaGZhN2krrDFl
	 ejbENnpBDZ0nW6FkTQTEj7PqYa+yEqC+LvX6rUY4rY53w+oxhzGiqIhN2AIx2PQI76w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764657;
	bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJL3psbhQddxcibtcslPF5t/n0SKXnXeQ96BgTKzCM7cW6p6LZhJVdRTc1Pl63/hb
	 EOzjU2AJF8PfoJHww3kWefFlSZxDczuxuXcwiReoOq0jri/x7bVv1FMYSgg9rwfhH7
	 ozAv5OeVel0peS7WgFwArQ+QFFdm5zj4c6Bsv8NWyStaiQM2ez560COOXm1G/JuGim
	 9qaI1Ndpg0IGjaKFuRxirTjcXyXhDt0K/9mA0cx40c4wRdvU1csxz7dxhhmQukrwa2
	 QFi7H58zKihjQ45DBA+jMNoZH+X0q4APIjI8iJ8XtwGoEZ0F4b0PdkOEtXXe2h9jcr
	 srziG++7wXofw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A23A960D6A;
	Fri, 18 Sep 2026 20:50:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EC8313D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4058A812FA
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOTE11C6Jdoz for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 00B50812D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764655;
 b=LzCKJl6HNAVmsZZygNw7268BZ0P7RGJPFAXTkqercsCSbBL1uJYNcGgbhN+BFylGiI+X
 zzHdn/qDPVZNdGPppnYidSPNmWQMVEFr6ApLdiudtFqr0emV2xLgXCRflNdqodw5XMA1Z
 /R2+sXAFi5laZvIBJMNbrg5vYYBhxO5NrrkeeJV1CpazJYzJ3utlj1EE0PGmxgEb9Hs6Y
 xzTCOL8/bCGcCzUa3i8LKhCPlKzfpsyx0n+mxq152zNzJ9E2w3buXztRz8hs4Pexn7tGU
 9jvi3xlXW2KOyKcicwnexBLeyUbLz6s5BFFPqOa8UDdb4uAzauDcYhKqebBr8v7UoEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764655;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
 b=as7TL2sj0u0PuBAosZKFjpe8eJYviEsvQtnyirfLuxqZHRyZ3E5gfW9Z3jXXFrnkmVwa
 wiw0pW+74gHcA6bublVT9AQG568kuPAjPhOx+AToY0mPDMwXTrbizH1Y0vZMJDOtzhbHp
 1khuwIeh46h6zlIxH+HwNqybyBDS53q9I2lQKql4gc0p/n+0uI4cHcnISvjYCd3gvSatf
 yxCoW81YkXlGvy29S/7m//YkVR5LQ1efa9VwLztP8/QxKhFvRIswj1kIZmleqLXObNp9g
 g64XZDiW0WUmM3K5wgeZ8VIHof5yKASZNzOBzC/BQd6uaiPMzAAtlzA3LwwR02NyUnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ia2UWzvc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ia2UWzvc
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00B50812D8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:50:54 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7daaso1641803a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764652; cv=none;
 d=google.com; s=arc-20260327;
 b=UmwnQKhoDPbOJd9laPKs7H4Sjp016HYxGzg3muELAxwu4gVh4dMbui24BP+SQC7yA8
 RS96sH4AWQ9BAkLsjZK8dyKDio/g0A9RX2kvGZNZEKzKftRxqxliWCYVuLcBf8VKmngE
 nGnrhr2iibECTOG6AzGByS7yba5nPX9RO0mZuOS1mC6E54sQmLViN5EsADrkpKkSM54G
 GHu3VIhJz7GJPdtWpVPRf4Hc8k4669PcUk4xHgi2HmynHiYZeDcPSEOQMU5ONOd+dhKN
 Vtf18XoJBl6HRw6dJFwI4/PBtEw85JzM1F1T3DbatYKePimJQs4C+A+Ua+2NsNE7ziNg
 lJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
 fh=h+ZGT7hRsnp81E3nID37UWoZK7pFJV//oJpSBu4B/tg=;
 b=PfWNmg3qV9dKLTC5Zl295QzCHss4paz2GBeiDLKfh1fiim+lgQ/Xo9p9QNthgsNTqB
 ++cS+bECzeCA79tEI1p3w+ixQ9/C0B4mBFR8k+KyXlTdJIvQ9H+ogtxzJHKtnD2GpBYd
 Y0S4kMJmfeuzAvK/bgD20v9mnX5cG/g+y4fJhjLRc3a9yFmIplsFCDU2+nAOU+yQ8p/k
 GVRZP3nZjlrFZcTnBsvzazCGIfGmiK96q/1xfivhRqUb/gzMvUbp93dnWw3gVIYERsD0
 BgpkNVUqJMOhx6shn8RpQmelJHIXATZ5xQXBHsnOgsWy4jL/foZHI7r6wet9s7hbceKx
 butA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764652; x=1790369452;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
 b=ia2UWzvcUwMzKea0gVQoYFFmKF8c+0NSP9Pae2yqoLNCKKJ7LGmzgWNZUntKkPTaBw
 /oM1fxxeM1szOxiIxiuRwZNo/xzrsCfgeecN1KL6EJz9+Q6atdy0f4dnsokQvJwzUwDL
 gLFEG8yM7LUoLBzTzR6TVKsa49uWokXhpDshk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764652; x=1790369452;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YHrC6f3RWLefgsP5nRI1zbB6NHPFPo6Kdb8GIQ1mPss=;
 b=AE98XwGd/A2ULbZViX/XIfFDtvocwMVRpDBeutxgKMBsVjjb+j9GuVHfLVUNvtRGYc
 D1kVCYjr9VpnGJkUT0K5Rzlaf+txU0InGxgChCKTVpZujXPAH4vMAlix12yKDmTCrd5E
 xTXwNcaiGRawQwv01BnSgoLwm2/HrQz6We7jplGMUfkm+IKK8nAjdh14aYTlfRM98kcL
 cyq7Q37/WohNWHjWvdmOoqqNcJIqbexBYDyc/lQ6UGaYOJn15JCrfcrontC2h7JTUPvY
 3w94/AC3JVjsN9508sMVhYlPCgPqXjVrKv9sw6Dxu43zh3ONs2ja8MWJ7dMtvJ9faASA
 UKXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByxUD4m6uoE4UY/K0ULQau7JHXRsP2UW2oCs7XmXusaPSjU6j13QpYzo0V7dGXjl0kc/lnv3M8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/H4Lf2Dh8PUsbRsBuw/iRNsYn85A+6I/bBlpwhff1+S/ShoO9
 YFTkg1MGNDSxN4bbYzRe/qjbEyPe6UmZihUBXDY73UR+GUlzey5/KIwosNtZ0KaQe9r8+cajSXE
 dWQidHWCem5pI2nB/rlLJjDS1sqi1Vw/4Iu28i7SF
X-Gm-Gg: AYBFou2kM/4ZFdL7LlRZQbcmGskHq/GIz/jOQcNUW7QxH6gmBq76CDug0Q0MuPphiCT
 vSVIs/RiGR4uPoG0L9PabI+mmvYifrWSIG4JD+1nN4kjZrkewl/zbhIKCYwI5j2KmQi+fCnTuBv
 DyFB5gMBjiX5QZGeiEGuwOl28y2SNUIeLowjMzN9/09MsGytpFouydbjfpKSXNg46S8BRpncw4s
 3u7yJQi4cg/jo8EIP7FODFn5OKBVLBD4CnNcuxk1dpwNDenLdPfMlMbPosn+ShqijuldzDL7czj
 6sTeMu2HQFTEEC1AYUAmUt8mNiWjsEhLD9Y0WmlVXkfQHqnWDHQ7iOZp
X-Received: by 2002:a05:6402:2790:b0:6a6:757d:6311 with SMTP id
 4fb4d7f45d1cf-6aa5783b5c2mr4533426a12.9.1789764652392; Fri, 18 Sep 2026
 13:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <beqmeygt36o4pcvilrea27o6a4vwjdslo2wiz2ubzq5thupyd3@75i6ozh5sj5k>
In-Reply-To: <beqmeygt36o4pcvilrea27o6a4vwjdslo2wiz2ubzq5thupyd3@75i6ozh5sj5k>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:50:38 -0500
X-Gm-Features: AcwNN1WvqdAHcXp8a1Sp9lUoQEsjX9kD4OmAVmL30b1DYDxuWEDG793m6rwJtC8
Message-ID: <CAFLszTjHi+1AO-aCtpWjsoBndkJbqEgJnt=6jUPxWw7X46wMLA@mail.gmail.com>
Subject: Re: [PATCH] bootstage: guard against NULL record names during
 relocation/sizing
To: naveen.osdev@gmail.com
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Naveen,

On 2026-09-01T10:24:03, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> bootstage: guard against NULL record names during relocation/sizing
>
> Bootstage records may legitimately have a NULL name (for example an id
> turned into an accumulator via bootstage_accum() without a preceding
> bootstage_start(), whose record is zero-initialised). bootstage_relocate()
> called strcpy() on rec->name and bootstage_get_size() called strlen() on
> it directly, both dereferencing NULL and crashing during relocation.
>
> Skip records with no name in both functions. They are handled identically
> so the size reported by bootstage_get_size(true) still matches the bytes
> written by bootstage_relocate().
>
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> common/bootstage.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/common/bootstage.c b/common/bootstage.c
> @@ -75,6 +75,8 @@ int bootstage_relocate(void *to)
>       for (i = 0; i < data->rec_count; i++) {
>               const char *from = data->record[i].name;
>
> +             if (!from)
> +                     continue;
>               strcpy(ptr, from);
>               data->record[i].name = ptr;
>               ptr += strlen(ptr) + 1;

Note that I fixed this in my tree[1] - my fix routes both
bootstage_relocate() and bootstage_get_size() through
get_record_name(), which synthesises a name for accumulator records (a
decimal id) rather than dropping them. Silently skipping the record
means it survives relocation without a name and later readers (report,
stash, show) see a NULL where they used to see the generated string,
which is a regression. It also leaves accumulator ids anonymous in
bootstage_report() after relocation.

> diff --git a/common/bootstage.c b/common/bootstage.c
> @@ -523,7 +525,8 @@ int bootstage_get_size(bool add_strings)
>               int i;
>
>               for (rec = data->record, i = 0; i < data->rec_count; i++, rec++)
> -                     size += strlen(rec->name) + 1;
> +                     if (rec->name)
> +                             size += strlen(rec->name) + 1;
>       }

I also suggest adding a 'size' parameter so relocation cannot exceed
what was reserved.

Regards,
Simon

[1] https://concept.deinde.dev/u-boot/u-boot/-/commit/d109c45267e1ce953aec3dc3980761f8ea6bcecf
