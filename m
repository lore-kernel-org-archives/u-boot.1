Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A14C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5081605E8;
	Sat,  8 Aug 2026 17:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7LmMVCiU5AR; Sat,  8 Aug 2026 17:23:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD6E4605F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209791;
	bh=po0vKgsoDl60AH/cMVWlKZxuttFXCHs3VFOTaDEPYlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jEYGuJUYercbYyU796WHMIjZCNcd6Dug4x669mmDUYDvH5Hx/755DzsJd/yD/2HXu
	 K9TWWk8dOq09K8F1Rgj7JlRwE2Tdl6G2zWtaGibnLdrPmoapzbpFxY0L2b7nq90zAo
	 wfMGo5trybqub5cDXkk89rNDe5w2yqdzy7ejxZKaGOeWGXyhfwH1Y3TCa26z0hJFxP
	 2mrkJhYHXYggFwnDYO5YsP2xYC3ipZfudB4gVqyhEM9mfh60N5URc5W5Gha6z/OhDQ
	 Y0B+pUohvgOTlgYIAbzqCxEQF9sBJb4BX5DRku5bTum//wDfZqWESvaaf+Vspn59Mv
	 33YaY6epN6ywg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD6E4605F9;
	Sat,  8 Aug 2026 17:23:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2E081AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C258D400A9
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUm8z_OW6aiQ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:23:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 841D94007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 841D94007A
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 841D94007A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:07 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso650300a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209785; cv=none;
 d=google.com; s=arc-20260327;
 b=kAgAA989vo5WsCMCN1KGowP3E0xxefLDHUmopTL5oy76o5TSE0qIilFun/K9OAVOkF
 cbUqpOvFyALvYVG+Gv9unnEP9sjOx9VQjzWTE158d0Dr4ZsiT/j3IZhOoZ9DomBlhgnw
 9BA4Xa2Dh60z2ay8/+/Na67+DNY4vnHBqb7iRFX/a9BuZMoJBqevqalMcmP45/HDyTCh
 ofl65yaSRNStc4hlK0Qh3xkx8Y2rp5KLfM2JvZtPAmTsKGDFuUrQOv8qtBiQ8h47Gmen
 vKy8Rd+1XOKX3GZF4Xp5MRt4D6nYsOQNOxwLDJOtDRGaNo/2LQcGbqpkrin4OaQZOTcU
 WMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=po0vKgsoDl60AH/cMVWlKZxuttFXCHs3VFOTaDEPYlQ=;
 fh=H7zZ5EKeDsnWFK/zbKL1JvKpjX1flL5/8rUVRa/bMgo=;
 b=R4WpCig0wSB4unNPvoB6u1lReOCbKYPoTqFwUNYE4HiCniSZZRcQKgJRrnoo9hJJMV
 1iUWul9yFBzmlkgJdFjegRmDZ3UOCffBr6YVxlrFA4KO9yCQyPHl5d4ORsT1q6eGwB0W
 LYivvFAEMbRwRbWngrZdVCOkcrkHxdRyxhjAIFGilmytyAOVIImDjSvUJpQLNPeig/mN
 1KVidD/EJvgJ1H1gk5LWH67/r8JDafjM3oYQUj6C/shXTPex9C2ByIW1NS8G2ndjhpDv
 PLc68YpbhkB310im8LocGUzcUfuVIASVYgLwGOMBYP5QehqkqvIIdrQB6JWYmiZTRgx4
 I2SQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209785; x=1786814585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=po0vKgsoDl60AH/cMVWlKZxuttFXCHs3VFOTaDEPYlQ=;
 b=C5YO7d9E3cbx6plUtCAaRNhWNWrVa57hEqMfDQeJAxbvNDNvVV9XSAovBFiGt5zkpk
 /YMS+Delhlozbb+AmEfKAnNpDLZcb5b8M/TgonCn1zdJP0WIEGuF6Xw/RjwcWnWzgbmz
 VGMZn5nJe0E13ZJWIyab5iecCUcdKp3AcHRFAsexh4n00sXZAO7KWnQum2l+Ia/CtPfR
 ZgG+SLHGiA+HD4mFHFybsyyBtpYBNpPqu05ILXi5A6EIje2y5iD4W0PG9DH7RzKMUTPo
 Ac8OXdhtqA4xxst3ebFP8scEo9jrYs3gI8b4FwwnkDC7AYfJvn91dp0nkJpKGK0gAgo9
 Fufw==
X-Gm-Message-State: AOJu0YyIQNHQ5qoFLeAZNH4LPacKBPqdbyvm5B9BkCfnk6fa9BPHtJJ5
 MHKGHQEiRKI/ah1PR3qhbytCavoj3CChV7zM4kLtJgxqBPZm0fHYS6vUvCvuKFc1x7OkJVS3kom
 PIvCrzpc+seB28RvRoj2orI9vIYCn5rq/o14L1VpD
X-Gm-Gg: AR+sD12DnrZqJCSk5OoHBl2OA7/lGPMR1Ztp7kkQKdQ3x6G9N+PEJ7M6Ixu3zy4rmtV
 LyrDI0w6qKdSN6YuO/KNVqe23RgYDKpsx0iE/rCF7eB6nu0K/7KebTu+Jmt+lQMxU5WXXbOoJT3
 9qbAZSm/b4vr3YnmiHZtMWWTgegYjOMNrQiiXvRjQczD/VxzM+oKRA2UeuXZfL00Ox8RFmIVrrF
 YL79lpYR3eR4QgotKCyu5XiZEWr9x4/AfUIXsYDBkrljUmmZv+yWB2vEuKpBFLlyOnwJjxcTS92
 rXtFw/a0T27HlPHv4e0C50S8ebTIaQftExmQ+eMHRow=
X-Received: by 2002:a05:6402:444a:b0:6a0:a4ce:1b8e with SMTP id
 4fb4d7f45d1cf-6a1b49ea41emr8531404a12.0.1786209785295; Sat, 08 Aug 2026
 10:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-binman-docstring-dedent-v1-1-3ca69d1c97f3@flipper.net>
In-Reply-To: <20260730-b4-binman-docstring-dedent-v1-1-3ca69d1c97f3@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:22:52 -0600
X-Gm-Features: AUfX_mw1gtXQnM6FvjW3fFCT3oQ_sq2eI8fRaqJOQUmzZ6NC4loS-pQw9jpXtTQ
Message-ID: <CAFLszTgGzA5AHN5kMvLF0dD-xPhKDOR+bxrDiDc9KG5E8dBE2A@mail.gmail.com>
Subject: Re: [PATCH] binman: Do not dedent docstrings twice on Python 3.13+
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209785; x=1786814585;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=po0vKgsoDl60AH/cMVWlKZxuttFXCHs3VFOTaDEPYlQ=;
 b=ZbEtDmWVXcHlVsDCcZOUP5adwbtVFaMqFksJ9C2ZUcPjtCMUS8ppCnV+K1FMDAQsTG
 FTYqdouMYzHpH3fh6VCdLGnSU7fnKNeRU7xA72BSC9VfrPgIBPxvdiWv2S0O4K4cxX61
 pcUN8DAmw9GzVG2FJLPv5wXty53pu2s9mPuBs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZbEtDmWV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T11:59:04, Alexey Charkov <alchark@flipper.net> wrote:
> binman: Do not dedent docstrings twice on Python 3.13+
>
> WriteDocs() and write_bintool_docs() strip four characters from the start
> of every docstring line but the first, to undo the indentation the source
> file gives them. Since Python 3.13 the compiler already removes the common
> indentation from docstrings [1], so this removes four characters of actual
> text from every line of every entry and bintool description:
>
>   $ binman entry-docs | head
>   ...
>    that an image node whose only content is an optional entry which was
>    is an example showing ATF, TEE and a device tree all combined::
>
> Use inspect.cleandoc() instead, which produces the same result on both
> older and newer interpreters.
>
> The existing tests only checked that some output was produced, so they
> missed this entirely; make them also confirm that a known line of a known
> description survives intact.
>
> Link: https://github.com/python/cpython/issues/81283 [1]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/binman/bintool.py |  6 ++++--
>  tools/binman/entry.py   |  9 +++++++--
>  tools/binman/ftest.py   | 19 +++++++++++++++++--
>  3 files changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
