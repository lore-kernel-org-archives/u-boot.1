Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HOTg2qZn;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=d9eP/YP3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4051A81190;
	Thu, 26 Nov 2026 14:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsmGorL6qHea; Thu, 26 Nov 2026 14:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 857C581185
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795704259;
	b=Gun5/WiBKHbViilCxzGADbp4mCfT65Ys2iAtmmIqjfs2+hxxTE9lF0KSbVwolT1z/rNO
	 cBduinLXLOwpAJxdfi4hp50vBh7cSA8xNvMBQNuBRqGRBG7romnSGUgRx9HOJnncKMlb6
	 hbePVpqmzVrY+62+th4Dd82QPV5If/KEKJ0h6HfadZV/nouwJZLzsKgi2VHlKTgQHY1sJ
	 +VJb2IZS8M4KftN2mfvh0/WmN0fZrH6SvQngMuWVo3HJ/ttGiVCYePJYoh4M2yt1lTqgD
	 avI9vZWfkjFQkgZFOusobsfWKzdJyR1qa3bIRZFzXsoKIj5lJP+wB5H4t625IjphVeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795704259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x6pVn+rvyOX+j2fUvdqMqQK7MnOPxsUMMrtvsDWRhGI=;
	b=KX1E3jd9ms8K13w/bva0RSfO4UIcYjXbcl8APplxdfp33LVLM1S2v5o+Vuw2d04J51P3
	 Qj3QbJMmlJ5g6MclqFtss/m3jQ/5TcKqlBdQCzLVbNpfn2H6ET2cuXrpmQfL72QV0xY14
	 TPuEjyRGZNY/AWUpuyNzmr4lAKxzijG0/RcXEnsNJ8T8Sds2wKnsWUzUcyYVKR4lR2dSm
	 jUlTSUj5kuXU3eTLwgRyNczC08JGvje29JhN0kmqOjqXfF/bPEFFTqNiNoZe8V1MphoRL
	 a6OdrfPfTrvGig5YuFG0Udmh2+72aaX2pGkEiccUL39AevBB42O/3qtW1XbxBLCpr8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795704259;
	bh=x6pVn+rvyOX+j2fUvdqMqQK7MnOPxsUMMrtvsDWRhGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOTg2qZnDwi/7qQ30XLmXtMjIjpWFrQxt6FO9m1TdUHBksQmEHwBiczebYUdP/4/r
	 vZ2ZwutvdRbdSDo7v7LZDmGxUWrIoRS0erzeeHW0iBSEKyeoQTUHM7344am6/TzrTu
	 hCiUxTh+9xUADBqZlPM3JggaWVkPlObscHYjZegU+oF4uiZvCiqQVgTb8DpsG/1n/V
	 kehQigG0CXMTw4SDs63OKIYfd847TfS7V0GHLwuXlPcZ5G2ryxR7LDpxoCxsVZERaQ
	 JYIYQhQdF3HqTrLoO01NJyRg2gge5blu1IIEHgh2cN2lDdpfv9L/hjZ5G7D9+bsqSD
	 cxNI6/LFBDicA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 857C581185;
	Thu, 26 Nov 2026 14:44:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 146AE22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF000409A0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EY0426F2lXtz for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49B62404DC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d9eP/YP3
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49B62404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:13 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-483d290f398so3745040fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795704253; x=1796309053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6pVn+rvyOX+j2fUvdqMqQK7MnOPxsUMMrtvsDWRhGI=;
 b=d9eP/YP3pRBNC1q3G8EHxYx/hEhv+Rs8CrLB6EuikFPFBv62Y7KId5oVQBQgoTqwWi
 7NAhp7ISUd9mNbcQ4zenNokj5DCTLUhCBS6i3xGPYe1dLHeGLjDE7U2iewd/FExW9CaP
 jk9ANncC/SiB7JS942p5RZN0FbUcat0R1JVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704253; x=1796309053;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x6pVn+rvyOX+j2fUvdqMqQK7MnOPxsUMMrtvsDWRhGI=;
 b=vF5Q/pzg3q6j5V224jb280LUEtEc00rD5WkOmH35No/6LyNWtIwT6CPJsef8bwNSIV
 d0gOHURmN3J0vXEuggektZk+6UDXLpeoVwAFCuahJZcwDScIxS2drsQ5D5cmSYwiJy+Z
 P/dOrWOIfrMFYNVVo3ZcR1eYpvIiURPi4XHraYtsM15K2o/xdvQDcqh+MBY+AG5Qdyvf
 yvsXMGg2p61UizUM759v8nYUp+cs2b5up+pgHGlZsx53BPSJgTysdSxfYHZgNmvuH4hm
 bqQGYKYvRz3jVNqqGwkUSadm2fQdMZvSgzSE1gYw6Z97dimw7FS0NADxScydxqw3lxTc
 B4sg==
X-Gm-Message-State: APuU4Z+JUsOlzU8LzWkaF9QsKm9s5b33xAQJVYERe63IU8MuDhbbEAkO
 RTkqstN9G8Z9V8xHeahvlGpVcxKC9zR2PjgbG5JKXfw8AJgNjKIcQU1LLm1zmgjWh3w=
X-Gm-Gg: AZFdTZehIyVxB/AaFjpzXRmhiFoC1onfIDZ62jNBkM0V1O5SEEH47wRgiRXhl3ooiVZ
 c4ru8XjOkp8NBFR+naJ0eRT8wXs/miUwKiwfTWsA+jSidn9loFMhDtXKwGKIX8Ftz/MyrHiuKLM
 90kKcYGQBB1sCYj7X29LWYYKxP/Qe/Z4TzCxMRyf4SQCGeUGnVw5HSs6NoDdedNfOBuyGvfRWEr
 jXvg1B6GPX6MrpN75mFhehmUVSfHFz142NCg1RE0BF8iPKeylPiO0cDnixyRgcHYaWeHMf6cEQn
 5HPUC/bee6jf6lNJ9TwF9OAkb2CbXWuEmtOnNpIwm16tj9+Zuu1i0CdgIFDpd4wLj+T+Z1JHX+P
 79BHARqAHtG74tVM7qtCBGBMmey7qoHc9dUktmmsMwclgNcNEXwh0qqQfmBAqTLZIn9Udj9c48d
 /TUeFtOXIa35Q0MXMwQCoqc1je1DJreNBHWdkqHBZc7rwjriOpxggMw0Icxl4LeJod0736xUHT0
 mPeLPM1ql50Xq0xU1MeiXf9AtdlUUJx75SmpHrxB2A6aa7SNQvjjX6SBdw65b0FIZfPW1a4oTIC
 jax5kFCAMGhzCogu9OAAAWFozsLBsQMYy2myey7mdQWmBV/tfsqXYO47SAB1WZO88WRrXhr4JV6
 LEwbcoXBhwQeRD88wSlkZaYpzGeyRqAYKWivBlj/fAJpn3KEa69qIUtrD2zs85PTgi6R24c0drv
 XtltA+xD2kpF7bOAJhhfW2vIjarhzHQA==
X-Received: by 2002:a05:6808:3193:b0:4cb:f21c:a794 with SMTP id
 5614622812f47-57a0ac257d3mr22825745b6e.28.1795704252987; 
 Thu, 26 Nov 2026 06:44:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdc0bbsm18198036fac.6.2026.11.26.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:44:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, linux@analog.com, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
Subject: Re: [PATCH 0/4] mach-sc5xx: Generate LDR artifacts only if ldr
 tool is available
Message-Id: <179570425143.3223933.1436437216070383010.b4-ty@konsulko.com>
Date: Thu, 26 Nov 2026 08:44:11 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 18:46:56 +0100, Massimo Pegorer wrote:

> The ldr tool, used to package artifacts in LDR format, is neither part
> of toolchains nor available as a utility in common host distributions.
> When missing, all of the builds of Analog Devices SC5XX SoC defconfigs
> fail, including buildman ones when testing these platforms.
> 
> Indeed, the LDR format artifacts (u-boot.ldr and spl/u-boot-spl.ldr) are
> final ones and not prerequisites for other targets. Therefore, consider
> them optional and generate only if the ldr tool is available, silently
> skipping if it is not, without raising any errors.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] Makefile: Drop $(CROSS_COMPILE) prefix from LDR variable definition
      commit: 4b0ee21c408d880d776da85b7ab571be4f1edff7
[2/4] CI: Dockerfile: Drop $(CROSS_COMPILE) prefixed symlinks to ldr
      commit: f5ef4dd0b12ef99fea687377b1d837e61a4043ca
[3/4] CI: Dockerfile: Install ldr and clean instead of just build
      commit: f0e28eb125b112ec21c6085a0b46c80f908cdb9e
[4/4] mach-sc5xx: Generate LDR artifacts only if ldr is available
      commit: 943998e33366c311c03c48913e01270a514f48b1
-- 
Tom


