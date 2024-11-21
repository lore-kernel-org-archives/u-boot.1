Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07148D78782
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 15:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25AA0894A7;
	Thu, 21 Nov 2024 16:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DNTKkV2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AD189426; Thu, 21 Nov 2024 16:53:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF3389658
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso12383405e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732204422; x=1732809222;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=osO/4iK97X1YmUEeqSjhTR2QzbxZx4YWrk0nbnyY4QI=;
 b=DNTKkV2PL35nTX5RwjT9gOrPs+8YwqIwLRV46n1Qdjo7MkjEtULbLCyWzUvswU92Dc
 CZxNJg/VmUSAp43IgiO8Mrr1CYwZEGTNRT2QS5HvdS1Jw0jB6XBydBv7R8cjDpLl+jXH
 IfLnGDMv6LI27tPfUrvu8USyOr3IoI6oC2GAVpb3HNd6ZL3vpAEaDPWsH9xSu56/ufNW
 7Yb2coOKiLY32MSH/9vQMc2BTLMGVLyFUU/wlZnSca4MdC3aNn80iQUxZwvhInliPzDB
 Iv2LAukAJDHAgpdIlVFi7nB5YN2ty1v519Af8g+Vw1rZZOsUt4VFHWtLjt+5SmnOQchb
 ldzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732204422; x=1732809222;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osO/4iK97X1YmUEeqSjhTR2QzbxZx4YWrk0nbnyY4QI=;
 b=mPlPDO10sIjJ/r9OVcvFjs0tN3bXxcU7sh65oNIlBTEgKYlN4hRcV4jjbIjRgrdZlX
 cEi05GQj24L9X6MaJIz6TSJIbg/ehywtvWpADqF8RHhs3Tv2Hwsqd6u1tnX6uTrFHkEH
 ts5MK7HnbCS/NTCUIX291KPwKhHbatPAI6m4pOco/oBfnNLmpw/4g5UVw6gjg5aBWBTE
 8KlhqNrzWuC59yvQ/A7FeKStYP2/sNyUfyZK1KrNOwrd2ozon1hPb1fBL1IVe24J38VD
 GLKoUefmjrIQaJ/PgkBhRg6ufCiy6F8vmZezqHUMcOTP7v7buish1Bo8lPTVwP0NGD3Y
 RDXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUj+NOb93nzpQodY3Ek6J0mATkp3+7JqNvcrFEl8PvsVrQn7cHDSt3UcbuOLiqe3If2QF1fRY=@lists.denx.de
X-Gm-Message-State: AOJu0YxlDzd3BwbMcNF4kSPQJys8AYvu0jwxWS/PjUj20ndub+4O3bEt
 z/ivyKSSg2gL+sHb+gq8sRtnoSAFvxymS7VvlTkJRTMMX8IJ4yr2DN5ay7mw8Ec=
X-Gm-Gg: ASbGncumcemulwtOmJT1f/2a0tXFxzrYJaGjF73t50hsG0RfUCLVpMjysDyRsjZqR3l
 LJGOBTRGBm/vH8kjBpHxaDaytJd9fGj+AvPf4+pWSK42bxBRfao5sIhsoo52xmbSqvqTpUoDKis
 q1k8iKXb8A0y2834Njt+8JDSEeVJmY2V8BeAKtfgpiwX+XVFAa9qOOStY0Lk29ykLxyZpiRme8m
 Gb1jdDUGA5kwrB3S9SbWlu7tyX4KPYQ6kUYaz8hejWXWjauvhGpcQ==
X-Google-Smtp-Source: AGHT+IGVcmQQamiK+Scv9JjnE69CLRoZpLt5BXPBrXyKKuE/LsNtZd8z8oBORajZjf/EvYXpQR5FlQ==
X-Received: by 2002:a05:600c:1e10:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-4334f015482mr68016055e9.22.1732204422068; 
 Thu, 21 Nov 2024 07:53:42 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e117bsm63527995e9.8.2024.11.21.07.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 07:53:41 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Simon Holesch <simon@holesch.de>, Ion Agorria
 <ion@agorria.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <CAPVz0n00AoaUV45kM__ADe=jA9XxqWzJiOP8UrOtaAG4TsCZtg@mail.gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
 <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
 <CAPVz0n1F043u8HNvmm-cU=oUjk17tR17Em+g2o+Z8idqq5NM4Q@mail.gmail.com>
 <87y11cltzg.fsf@baylibre.com>
 <CAPVz0n00AoaUV45kM__ADe=jA9XxqWzJiOP8UrOtaAG4TsCZtg@mail.gmail.com>
Date: Thu, 21 Nov 2024 16:53:37 +0100
Message-ID: <87jzcwlh1a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On jeu., nov. 21, 2024 at 13:15, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

[...]

>> > If no other comments were proposed, may this patch be applied?
>>
>> Ah, sorry, i've been waiting for a v2 patch that includes a link to the
>> related kernel commit as asked in [1].
>>
>> Do you want me to fixup the commit message locally or will a v2 be send?
>>
>> Thanks!
>> Mattijs
>>
>> [1] https://lore.kernel.org/all/87sesxzo2o.fsf@baylibre.com/
>
> Both options are acceptable, it is up to you, what to choose.

Please send a v2 then. Thanks
