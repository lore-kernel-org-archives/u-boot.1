Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02886CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 21:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C93407EE;
	Sat, 10 Oct 2026 21:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7X1JoB0xrItB; Sat, 10 Oct 2026 21:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A199740818
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791668791;
	b=ZMo1cRMMwTSP3e0b+3KGp0B6dcW3iTqafy2RG2j5gLn6uudNUnVh3NEXwMj4GYev6l2+
	 PUr4Uz5Q9G8uHy01bILkyIo4v0pSQZidgXsqeeK6VIWSuWgil8ldDT4mXzFoSjufsVKV8
	 yAr3Yp/UQ5ltlLaUSkllNPqHmS40tSfFSDXMqCh+5v3kzMYL5bEUy0JHYLIYfqmhTQSr3
	 a0CZ25a2b8S9RsUNrbNipibsJiHi0ZPtCZD2VJ8Aaicuqg40pPS/DxB7FwFFXO9sADrB1
	 oNLjbEQXLK88m5bPo+x6aSwfOSJmLFrfnP+kHWZEo0PPgvhbK6XaiCDYBq4Mm4fks9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791668791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3F+yZQ9cTtEh7HwY18AnLw/g4Ws/+EAIy01BwMR5jF4=;
	b=h9AgLWnupu87w52i+RTvP4gTOpq+caIV8t1W7dS5gwf175/V+KoTeV3bFSiOWeu789i5
	 A82lznMWpNApxhlPMi9tOgW0GpxgLK5jAuPNDB4IeRA2qtFj1WoCnBDLh5xq9oKJsjl1a
	 K1CbCufJirf9FNPrDFXXT3MdTnIG/ygPwNZcECY1+1XmFSmW1C8KcVLkY0UcrogWJyzCP
	 IWJm8ZG75ErlltJGu4e2q0y9Mv1MPhA6QR8XrALsk3J7jnvvL6bc2I6h/DppH4MZB5mGa
	 UmZxwd63lCeuSgDHRw9lSsTldsQoMb+Nrdygz/Dc9axRUD3mgHDQ83zEZ4R4tHECNUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791668791;
	bh=3F+yZQ9cTtEh7HwY18AnLw/g4Ws/+EAIy01BwMR5jF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KEZYsk2p4UT/ZRp51vCA1fjTGIyzEAr8SdVB8N94U3b0+/SB7nby4qEfvTELWuLvc
	 oApQ0CScM98vu7gxz5B4ziJcbpTjW2ByWJ0kkGnkT/AhbYrPgEbEVUNvIVOGFPtTYa
	 PnXUg/5XmmA6sDpMax3QBzrDF7l4UZL6aSCA000pp3vzdG2XdApqYme+Ijka+LIJVg
	 1lnuaKmqyFltWaS+X8MaHFCPU3YPiGxo52FPQ4ssgN8TpOifPJCBr8dOEd8WA/nDXx
	 gu1qOzwAhWrVZuhGX0uqGv1nZRgcjHPgwQ7uibpBmeTsoREwowS9JhJxQARcGsdRDA
	 uEVIVPi2aGXlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A199740818;
	Sat, 10 Oct 2026 21:46:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7838D1A6
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67DCC60677
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrfIlqSB31CV for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FCF760639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791668788;
 b=KxYzWzBw5UmMP2kGqP9MlHg5unI7noKgYDnHrY5c8T51Lr85AQir40R519ziYZhXAFez
 6rZxMGKquFXyp4SHIrENgRBoQYYDviDH95drlgWxFoWtOw8j3NUIwlJuHRHnkRdEKUwRz
 Nm5RIdxPuoESO8a66tXGU7+N94dnU+S72e2Nq0SuTqXmm3FpC4CTyBvYMvMTj3n6SYFRT
 n9v/2PZpvPM5RJCH4KMbA37AxnEzJE44f2HCy2WtECKsXdg5wy17pKwJRN3QGKBHlHmL/
 Q44U/SM/VsBW9rA6ENbbS5KKDlbdXp/npBGhG3U6HqNR3nz0abSZFGVef/9FfqkqUMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791668788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=3F+yZQ9cTtEh7HwY18AnLw/g4Ws/+EAIy01BwMR5jF4=;
 b=b9isV+oKqH1GrfpQUOs1oOivgoCXALULCp3Fbu/SCYrbZt1r1jM85ctyn6CWnyPzH4mP
 MKxg36lz2lTmqWiG4fD7ursD8popvqWrY/a7bO1LAX+QcgXzQaZSwbQrQvuWxUpOtU8XB
 rxONkIo3/2GfqqIfx3pK/Am7eXl3vROhrXz64vkhy4dFPAgWhiONp7vUISu/4gFBBfpKB
 4G6S/i8WX9b9mklxsNeZB+ml3Lwl1hnkiLj6CzpK5dRP3jSPlH/q2boztg8jfHsA7Z6R8
 ey9tWFcrlFODAZ9H2A6a+/rAVWd5z9rqQ3iMWXuDD4L3PUxWoXzwrQi4upDaIB8CP8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Yh3o2ivh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Yh3o2ivh
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FCF760639
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:46:27 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-82389e65a09so427743a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791668786; x=1792273586;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3F+yZQ9cTtEh7HwY18AnLw/g4Ws/+EAIy01BwMR5jF4=;
 b=Yh3o2ivhkI0Uu4ufQv+0/QGITivIc9jPk3AisY2wMw+M3cnnNm/UgXOSy2iTa1XncL
 eb/gRjihQUA3xwZgkdDzUhyMuzXLX54D5EnRARFmPE1pNSv05TafEz3WUYO91M+/G6+2
 so3CqcFREtgwZjZXXrZyT2MG9dVpDkMgCaX3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791668786; x=1792273586;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3F+yZQ9cTtEh7HwY18AnLw/g4Ws/+EAIy01BwMR5jF4=;
 b=OjwAcA/TYx81kQzhnfpQciJym4z0udZnk7sAgqJI/CvzvTBhf5hDQkU0xc9HyHSNRK
 qf9HTWgA1zwqqqiVGevebcxd8WMJnkGeaUVB+IfnnfhyACGpHYkgZjwhnoUTBe97X9zf
 fTb7ks+0FjNyxWrtqFExNTtSBhXCZfY55DbXLwFfrIQIzPn3dZlgx+2Xu+NtiRA+bSyz
 KD5ieWavEwMF2cOxbM7IwyyHEEi3OlS4je0f8+4KwkMJrFbXsznKj1VkQWCSNkri3xge
 JISJZttmHMCE83znHxL4lyAlHEHAGNdbtlf1K/C/wGr8xecn4ivfwtk8qXc1gprVRzxy
 ahVg==
X-Gm-Message-State: AFq9FYKC3y+8I49b5LVJoL76DRXd1/gdyuhyzSEd1dA2Vk8XxIE988E8
 v1TvMuRkJJdL+JngV/IOrOy2yghp/wCK5zuMnT12UbCTFHaH3LD+pP42KZP9Bi4MMW4Esa7CS7g
 nZJgeVOZ7uPAJn0k=
X-Gm-Gg: AYBFou1zmKyc1H0O2Su1e+s1s/KRPWYARAZsha2AxJTsVVbkqhEJBkEb4goXCOyLx8v
 fCHmt401QxhBUGupUCNQUg2li7X3c4N9MRtGw9kbGdSGL5YVoZs35qdBTCSthuqrkP1u/5kTPzG
 Uv4KNnUR7MwLcZqTE13Qn2GHnDq6S73x6TRRXG1JovNI2H0XYgoSW4gEXYrMwJf69+emyYv6/8h
 ruYOU0saBG64vdHYEsS+nq7YXX+004Bz+m3uY7qUmtbEnaxnfnmN/sQ5cHJBEZT+Js5Ah4sOVTw
 NpvAqZgiky3ZVgn9ivluQ/+JoOw/te/OWzlX4871A5rqSARYpXPE1h2fC26CcAChszgI9VYjyDU
 c2QzyY05NLjQva1BYDWUTNM8dWBrj/nfObwC03WXAnQdVByIBS5OdEV10WyyXZlgpeGalk7F0J8
 Fy5c07lm+AXWnNurhCKx2SsN1vFlv7G1vyiw/b3WLNUBWmoskvvvk23vWND+DCu1QrlB5qYp+ZJ
 +Ob3bK+RKi4ZR6uuIG9kF4Kg7moGiuqr0Ji5D1xzKGYbZiP0xXmh4wzjtmrObwdndkRMADEJbZB
 eKEQCIwPB93FFyc+BQ==
X-Received: by 2002:a05:6808:c056:b0:515:7cf6:24d2 with SMTP id
 5614622812f47-5157d14e250mr1022579b6e.42.1791668786489; 
 Sat, 10 Oct 2026 14:46:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50bfe56242bsm6295903b6e.0.2026.10.10.14.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 14:46:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>
In-Reply-To: <20261010043056-GKA26088@kernel.org>
References: <20261010043056-GKA26088@kernel.org>
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-main-20261010
Message-Id: <179166878504.3219985.15506887187282237548.b4-ty@konsulko.com>
Date: Sat, 10 Oct 2026 15:46:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 10 Oct 2026 04:30:56 +0000, Yixun Lan wrote:

> Please pull from u-boot-spacemit into main, thanks.
> 
> CI for this pull request is available here:
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1535
> 
> 
> The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


