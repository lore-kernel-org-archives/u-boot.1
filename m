Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB270CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E609606FA;
	Mon, 12 Oct 2026 19:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnVJCs9fScuV; Mon, 12 Oct 2026 19:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F69560680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832580;
	b=S/Kk9YQvplLQGZTnTKdPJXGGqtzsteCdLL8kxwpkEwEUmd6Zo7tjhRCTR8pwiGPg5+NO
	 7I00O9WCzFtcTfgy7zy3pMg1e8/ShRd2+qegUwlGi8RclGHJsWfepW1tfWtS//40rkuuC
	 vKLIAtC/mAbZLU4hCiq7N1MtovGsXhMsbwxsebDBHA7VDrzkckouWqKgQr+vPdOQu8fOP
	 AL5U7MWLTdPV2GikoK7wo+NABwPi96hkKN2oUJ17A+NzL/g19r0Nh6CcAtZv2ppBAxHJ/
	 Hq9+lQNIidQtkdJWyH1cEYRLxjCSwqCZVHmLhrmC+/NPWa3+7hDRfoxr57xZMWFA97w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CecCnpQyPEsiUWlfKDeN+LyZV5skoG2VcPq9DxLt2j8=;
	b=tUWouIDFXF0znwY94gpdTNyv8okph/sHa2PM0eA1Lswv5pvxyVp1BvwjF7xcYD12ex0j
	 anEUBZMYwpPSGIdS+rCe1v+XKa8qvtNAsSGjyGtmthdLlrflk/VmqimwT38AytUQOD8M5
	 DxzgRW4S+BIqMgh+D2ICEeFg1Q8bgVn15isZKx8+5IxGL4hKouS9Hbdnwttf0dR5YBqc/
	 rG0HwTy+9//Kxj9HhY7AuJmqIKILB1ad82J4W+2qSmcJZCHcId13Iimz3cpSUl6RVH2so
	 bjNJozlEvFVJQ45M2DrjHJxLJThEc/TjstwMBRZfTVlKOsXYJc2smF9oxAYkXtUUiAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LcZAC0hn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832580;
	bh=CecCnpQyPEsiUWlfKDeN+LyZV5skoG2VcPq9DxLt2j8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OE+2LqqVz1jE8E2to1rluA4B8UP67zf1PHdr+fyWszHrlxxuWLbAoHx/sACTcjo8U
	 +Kl0qU+ahhSw0os/nTx4BBQZoC/ljQhEojb0n2uaSDR4Ix71G9XoW5Jpc35xOeAuk1
	 B/I44j6jKKvLVFjBtfpXrMm4gbK/zNh/N+MrnQ9uriF6ZnO7Vs+lt1PsxurAQJlGs3
	 0VYTBHICgzPLF9h70GA9j4eXOIHV47sjCtPJT0OZy4yxViYPJbyn7RV/4FRRO/hxiQ
	 HFq7wRoRygc4LDnBQxA06xPVHTfU/DWETA9aDYR4ODDlrkqsHZXY1t65VynPhEUwpM
	 2e5enapnCx5pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F69560680;
	Mon, 12 Oct 2026 19:16:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A70552A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CBD360670
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zw850KyOMNU0 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DC6460667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832578;
 b=tefhkeFTVhwuAkzsS3FjfHoGKlpJcV0EbvvAU1ESsgp2aHZpxCabBL7RyHSU4ewXlP6D
 iuDbK1Y7ySezB3SQ2FNh8jGAiQDjd70S7s2qYAdt+McZIL8ZqymrRxQysPndzQD0T0G+e
 lj8Y6/3n5bcWVbHso5ClKj7JS3b0XrsuGcU0w24+I5uRqNsUuuut8DXcLllo5XV4Tko+3
 nqf7/X3u0YGGAWf7FUCowavE3puEq4GcXGj0VzaNA1OilXEqjQL3ZBjuRiELqqvdlvo4e
 UAw69CawqpD0XH9o8a1dHzJoMx+Kxff0iJut90Ds4vinPk8C8q3ktdIAL+dMZiobLmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=CecCnpQyPEsiUWlfKDeN+LyZV5skoG2VcPq9DxLt2j8=;
 b=eokJzeT/PFjcffOOagFTj/Hg9Gs+89StNIwI+oZnxYLY3ImZZPJKgS7EQ/QLv+MJrHxc
 9RcwyUBGt5KBL2vvM4PtwFAWe+8MGT8Y71sbDda6A057bBwcYqgl1K//zQeQN2UI+4k+5
 VyVFp6qSJL08xEUhrkQ5rQWEdCnClYYD5P6MhbQWek0+9V/yh5Bp+0W/wXkFQli67jl9X
 cyUU2H3my/ck3p1scaIIoAutsBUDpNHhM7X8s4NJ9hjcnAfVFrILL50BDWR1voMActaD7
 mHXNQ2lRdxcPrWBLvSmNy2q4WTS9U/D6z4rNkenXGQtm8Kx6FOde2rYLCJtSQLb0C+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LcZAC0hn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LcZAC0hn
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DC6460667
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:18 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-515166dfd77so896455b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791832577; x=1792437377;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CecCnpQyPEsiUWlfKDeN+LyZV5skoG2VcPq9DxLt2j8=;
 b=LcZAC0hnQJC4c8zxs7ucK2kT6iY5h+wtj/3j8EdsJ1ueYmgilm7bCzKYy26Zoxe/vz
 4XQIun8as4NoCwgWbZ/w4ls2t3D2IWPX/fDdMNs0RZ3YD+dSwmCQwQbO9JEQs2NiKx8v
 TFO/7E6vVi+WdKBTDbCzfqrb61Y7rekM5SvK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791832577; x=1792437377;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CecCnpQyPEsiUWlfKDeN+LyZV5skoG2VcPq9DxLt2j8=;
 b=ojMFBcP6c5gYICfuWpcM2rKK7FLErFsr1HKJMxVWtRwv9nKd5EwQjfRkzBj6zcaSUW
 GcqDYYa/gcML5ZVlvVfixCEpImMYkSXGBsNZ135HVDRw8j9V63KJO1wv0pG+wkKsou+L
 2G829NDtF8omMCwdZxUwVo0+98ypegm6X1dCtddPh69xOakPxleSea91lBYcxyE9iF/f
 g0k7Pp0ipBrNQHgXBWU94aOJwWOHnqF6BTxEudLxEYGNa44sDHo5/LjNk6ygpcxr4J3q
 SEDIM/L82LMdaJU57NdpQfkQnNuCjO8ZIAjXogKVulVq6iqzMvgBqMfAOb+MVCABDiMP
 eeVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMid0YzRWyFUc0eOFOEAaDWb4QJ5EtZS66S6ZOax9C7QcoerMq8YKruqzwwheRqwovCj1ArD0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKh5G8fScUeNhvXEQZi/G1Y1RE5B3DOCUNXCLfwBZZniPudp3DB
 Px8GK6c/qzhEGxFzRTVaQkowsQw6feaIzmqNpYH2z6FSRScEUDYcZefnvFHlirKN1eX9LpyPlFG
 TPBMaqJEjE/GcU/o=
X-Gm-Gg: AYBFou2cVke41FDyxvNinbpVLm86KpGCxrp5iRpcDNhm/lbaNIMQrJz6sCz793DYi+8
 1q1dt+Wpcqpa0GdRw/bh06Y7sSLm+jJQc2LOV2O4W63C/aYspyQpI/3g2c3kkHlpU+0VIUHjXxM
 vPi6UzyXqahlri52n9tQ7GU/N6cNCn/RAz5fFWviZJeiTKqpDDxil6ujhMTLJ61Eu9yPLthrS/r
 JH9JHMgtpv4D9ALQ2nKe/O3tsYkS2Ne08E2jy49rvsriwVOB7d2hVZ7a8jftOjlQeEDoKqBTxfI
 E4nsipbJc9rtgUkYVhjkevZs5UlnwOH8T4GM20zPWqyCmRv2p2UaLLdfPtsV4SZRCUiBaquqYpR
 Xk9+yLN+RFoUIqai5MDU+pknKb8s74q8mOXVE3KMvkP1GsPsbD0jhksvYwFuu9kd99JY4FGkf/f
 bUkb6/MfpQfjTu445zPDsuVVzWa5ypmYb97Igu3dKX1E3CmiFp8kDnoc0AUHvLWDkbMa0bme2YL
 1Y7U3dDZtdueGn5H5U14q7Ba1eBi+Dflf/vlLA9eAldaK5I/zoqqTD21OHOeVjq1hRMTcNBKQqU
 hoP5Mop3gIxmjWh+Pw==
X-Received: by 2002:a05:6808:13d6:b0:4d6:9283:1dec with SMTP id
 5614622812f47-50c5a30c452mr8450773b6e.58.1791832577133; 
 Mon, 12 Oct 2026 12:16:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm12237824b6e.3.2026.10.12.12.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:16:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <412f97a2-e7cc-4959-86d1-e473212959b4@gmx.de>
References: <412f97a2-e7cc-4959-86d1-e473212959b4@gmx.de>
Subject: Re: Pull request efi-2027-01-rc1
Message-Id: <179183257594.3787216.5907883812036530137.b4-ty@konsulko.com>
Date: Mon, 12 Oct 2026 13:16:15 -0600
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

On Sun, 11 Oct 2026 12:28:45 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363:
> 
>    Merge tag 'spacemit-main-20261010' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit
> (2026-10-10 08:30:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


