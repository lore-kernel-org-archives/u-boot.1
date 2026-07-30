Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67614C5516E
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EE3140C96;
	Thu, 30 Jul 2026 18:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8NdL6Ijsf_Z; Thu, 30 Jul 2026 18:33:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0D1D40C70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436410;
	bh=TiziaUWzJrqJ3YbQT9nd/SPH70E86SHDBEvdAm9CV10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eb1xilyJJFNCfun4YqVZt8Q5BQAKBOZB+4DXuje+bnnyAo20VkclTZy45+9CbwO8j
	 94+M2KWwEP9llvK4MqPRme/TrnjORYEytpGG1DQADBKYr5RjtZNcyUZkEwP81+Edex
	 cdyGxJjtVb7R56/jVc9hjvm8aVeCxVflP3u5VSMjbwui2QwLUtSwetee0ddINdHHFZ
	 GUNVpr0niN+J7s9Mxyxs4SBaRupb3rrPfPSCIq2W50rxiP0UHYiawqoGGsGc4ZlHbx
	 r+J+Ejap3cddqpYqrkWFpaqKu1MFijDBGlehdmCWjQJnU+zfhPKNx6xK/udR8o2sk9
	 HJ1nj0vPPezLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0D1D40C70;
	Thu, 30 Jul 2026 18:33:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98DC442A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A83E60A5C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:33:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crGXs5trAlc1 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:33:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86DA160611
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86DA160611
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86DA160611
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:33:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E35084A0A; Thu, 30 Jul 2026 20:33:25 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD060849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 20:33:22 +0200 (CEST)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso892375ad.3
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 11:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785436401; cv=none;
 d=google.com; s=arc-20260327;
 b=IPshlfmau1uLEfkmZUO5S+31hTLwnHHT/J3A49/aMs8oWvex0uVlFfZD0bLVQqaLhP
 JPaTfcqihHjhzpmvq+QmFOGy2w3ESQ4BbmiqyMCeYM6hVAs1MJIkkoSwnZC4ZcxHxAeq
 +U9DPPQWpt5fE9qW3MVPTkfWCBIRDrMZQUpdGJ4iWDmzyU6rcZ/hYhm2npVZOuaP8RZZ
 +uzByxx1WSdkczeepU2Eg4Rtn5P7Vt5WD+CoIprLZvXGMPdAyirQiL7Vm6F4eS9JzYAb
 xh3VLW36uQ9n7fzUqutKc7dxikMFE9D4Wq7sTRluYDIpt48lu4e1TuFuZ1Ie6nLr/vtp
 pk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TiziaUWzJrqJ3YbQT9nd/SPH70E86SHDBEvdAm9CV10=;
 fh=atTARv8+jqAFE05we6bsnVR9FdTstuBMVDiHQube0c8=;
 b=ig6Exwjzj1AG9vZ6hUdF+EQya+LASxxL5V757uuEl0PFK+Tb4AZG81d1x/KrR+7ZrL
 wR5n+0zZLfksNtHaCE37apECPp3iP1lrDVFB22v/O9/Rr3biCnYPRgvx0opsKMuIM4/T
 qluRyIHNBQpTVYhHQOvNykZNkTWWdS0Ob5X80HNkdEzCGrnsWmTHdVLBrOrHUqZU9EMH
 UJYSc8D1vRWp7DRm6SJ11Vbe8qiluZkF2DvKCCqJ6dEGlzqjD56FZjZtGUwXeACMc1Ly
 IWIlhb1nXga3WxxPT85sctrJ8c4RrSRHoAK5qsVZF/Vst82hoZF0gINqAFROEfV88nhA
 bM0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436401; x=1786041201;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TiziaUWzJrqJ3YbQT9nd/SPH70E86SHDBEvdAm9CV10=;
 b=aeuyu6QdXpdrzuiF9JmfL++9zKExF7GqsY41XjPkCU+pFvNZG3yZAUhcZ3iMgRPUDZ
 IUsWCDroFg/PXO9rlxvK8krgTciwldBkd2ESOSOap5ichNUvAUQS5TFiKFYgYhjF4vjm
 yn0ttMB/9d1UMf0mD3FSl7FhWxpc3yIzawbUHFKR8J0KQkDg4LjdIM2RTqVNHLh3ayvP
 zeq0CNKDPAe6/ou8SLcWULh7oqzR3jnzvg295mpw8znFNf+pf9YCwImkcaAgdm6/1jVb
 +A1llrxdwWeIzjDVylM1668VRe1Rx4baBTt7uquTuUfr1NY7ursVbg5S6Md8GPq8Gz3L
 kaag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqFVNnGHLkxMRk6sCFph5b2a1IQyCUprw8eXQWhpOTfA7M54j/hE5EJsJLp10koK6qdGOOV7I=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9g/bFn/47rFI7jpkXM4mFp+dqevgT7O0q2UtcVueEpDSE4e5b
 k5BvM6hID+r016/6a5K4zGsJ4E3KLqQv7o4leMxUMv09emqaJp+EX54Hv39d7/N2QbYFdTm1a8j
 UakN7yjak6dcO7BI7bnUWlpysSyOqxw==
X-Gm-Gg: AR+sD10zdtWWKfwdd5XToICyf4StVJmUKbQ+FB8vSqYhh8OH+x3c68yIKvCICsupAnE
 u3745nqKLjxAPMdcSVQd7GXQ3mhSyvOLv9itX271drki82zuzz/qRgQaw0uXHkRCRlfyig5G1GU
 0j4VxWmwfdPC+bYrbIN8iMbiGT2HEdtQgLhV2+WbSpE7TEQIJyZsgokg6gtL9udn6lsLHv28DAg
 9L6W+EQ3L0hest3LqLIhugIA0zmiCdqks5lOGvyurnNfro9WTU6O5JmMWjmB3vjiKo2pOY7Mfu5
 S8fp58C2ovGEl8KkqQ+KbUaN8YlVRMRW/bxoxfNFMTZdEg37Mchyi7FvOdqJjMsW5TAYEFwp+/V
 oqZCYkmA01Mc=
X-Received: by 2002:a05:6a21:6f88:b0:3c6:3c5b:f301 with SMTP id
 adf61e73a8af0-3c9009c3b22mr3798291637.68.1785436401042; Thu, 30 Jul 2026
 11:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260730163621.83050-1-ozndrgt@gmail.com>
 <CABdDSeXFiL-aw5BRdH6QSm85L13tCzOEQrri99HOTOpromQpzw@mail.gmail.com>
 <CAB6uNiVu31Fq0muZg-3KmquNDJy3r7fUc_PNGY-YfgkN-66Ptg@mail.gmail.com>
In-Reply-To: <CAB6uNiVu31Fq0muZg-3KmquNDJy3r7fUc_PNGY-YfgkN-66Ptg@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 30 Jul 2026 14:32:41 -0400
X-Gm-Features: AUfX_mz_b7mCwvsvZzus2BMOV3-nmuHIAJCK5i4IOMiKF4Moj49vqnEHcMqVlew
Message-ID: <CABdDSeWjCaX5uCGWTMsMBQ=3Q39PCnfU9e+SwFjJ7s2QtH76gg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: adi_wdt: get SEC fault source ID from DT
To: Ozan Durgut <ozndrgt@gmail.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, u-boot@lists.denx.de,
 linux@analog.com, 
 Tom Rini <trini@konsulko.com>, UtsavAgarwalADI <utsav.agarwal@analog.com>, 
 Ozan Durgut <ozan.durgut@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785436401; x=1786041201; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TiziaUWzJrqJ3YbQT9nd/SPH70E86SHDBEvdAm9CV10=;
 b=tHgburos8+QoX6+F8Huv2vER/3yB1Bmqa5R8/fKueY9YQYHH6mVHbQG575udjB29Lk
 uyC0dvLZbmL5hFnkGuCar8+/j7HwAQ6dSc+JwO8mTsafCjOHSTsvO9wwwSwGmU/xsd72
 TLA8ynX/hqbPNg2sOcZfaeNTAi+jj37QOJ04nHm4s6flC7x6M3WQRPi+qT5lDGfAsXr2
 9fgvkRjwssFRUgZY4BXnf5wquxUe6SmD0uZoPZ2+0wYBt9u9O8NsQYtxduVGh0U3dGqR
 eIp48dF7KkCsqdrZ7dBEDBI2Q+urnFL1DtLZBg30Nnx7eRReHRz/pXOVSddu7OwKXZKf
 yaow==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tHgburos
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=malysagreg@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHgburos"; 
 dkim-atps=neutral
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

Hi Ozan,

>
> > Also, what do you think about using dev_read_u32_default() with a
> > default of 3 (appropriately documented) so that any users with
> > modified or custom board device trees will not be surprised by this if
> > they update to the latest?
>
> Fair point on not surprising existing users. My only hesitation is that
> the SEC ID isn't really a value with a sensible universal default. It's
> a fixed per-SoC hardware constant. It's 3 on the current SC5xx parts, but
> on the upcoming ADSP SoC the watchdog maps to different SEC ID, for example.
>
> Defaulting to 3 keeps existing SC5xx device trees working (they all want
> 3 anyway), so it does address the custom-DT case you raise. The trade-off
> is that a future SoC whose DT omits the property would then probe
> "successfully" while programming the wrong SEC source and silently
> breaking the watchdog->reset path, rather than failing at probe.
>
> I'd lean slightly towards keeping it required so a misconfiguration is caught
> early. But I don't feel strongly, if you'd prefer the default for the
> custom-DT case,
> I'm okay to use dev_read_u32_default() with a comment documenting that 3 is
> the SC5xx value. Which would you prefer?
>

I think you make a good point. Keep it as is, no default value. I
would suggest adding a print statement describing the problem in that
case, so that it is easy to find the issue with a custom DT from
before this change.

Thanks,
Greg
