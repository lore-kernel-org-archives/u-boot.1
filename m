Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791F6C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9420582BF6;
	Wed, 30 Apr 2025 18:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QILBs1uE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799028215F; Wed, 30 Apr 2025 17:14:03 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DD682BAA
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30c2d427194so61997881fa.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746026039; x=1746630839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xNWBp0VVobOUyluR/uRWWniSG9nfLHNeTPMQR60D5tk=;
 b=QILBs1uESmTiHLewQFmD6lyJ2LV+bDEf/ljfg/afaixdAeV0jn5GPR9zxv2rZXvCr8
 8gisjJOnTUODWZ04dUnIVSMQSsONLeDRV0WNQhJFs+rBp2hD1OD67bHSkzvKHC2lQ+w+
 ZWPTD5mAVr8Pz4+uD7g8bOkqsGScQsquh85IqUsETVw/kJWbIV1c6ljITTkurUfgx+dW
 gHeSYj2TG9a6RNoHgH7B/Xp50hxetJrCQOt5exNnAT6mdD9EmbJrmkGHSWzqN3sv1zWv
 4hFnQtqv0h7syey68VX87wsHAszTwgSK/6zcCqlIekUTNJw82RddtRp6UaGcVv75wS7n
 mXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746026039; x=1746630839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNWBp0VVobOUyluR/uRWWniSG9nfLHNeTPMQR60D5tk=;
 b=babpr59aRSyKAshKn1HrmWy3/63WMoXqQC2jhOaK0erGyos9LqeJe4bL5VCpRfqj3E
 MkJpZWd8qjZ9+j5C/ChuaHvI0KN4E1dsUufLkYtBshIVBm4/FKMmGmRtPwwIcXA6hcbS
 ZFNZR+t+BGMDg3yug655uKjCpwbrkOoSjDmi6QrvbRni5NqHvrb9VF8DhX9E5CKd3mYl
 QhW8KJXgzfRIdZlB7I6ZfFu0pig7Kx57dTPyq0ZhHO+HVoSCQqI8ixWsHYLUO/5TvUlB
 RMQFDx+0zJPeGcO/Mc4OyV0dGVfEk95A5Dt89ZVS0iT77W7p+K6EXBvXyvC8MSDPyD6K
 vz1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDNHNl/dq/DqQ0yQOQDEMHTaeM3Wbel4pnOcfgYwaeMHX8eoa1A5v2l5uFjqZ83/E5jPHPXSA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5DOGmPdo7BjyhZZ7npSWcfce2yMs6TyKkz5Ut+YvEq0Y4eG7z
 KW56pMcQhPMb3E+rkNxa3oHpCq3F9XA2WwVmfVIuyRD2tl0cjmHA04o8fQwbdiN8sy74OtpBrU1
 m08ojbyxR65QSigqDMt0E7Tpxsmg=
X-Gm-Gg: ASbGnctLNtoetYHWmfYDz1iuHreov1TeFjFHYjD9ThyTsbX04dS7EcEbsGdaM+fBSEb
 UgKyM8z2z71lYykTLOQf1wLxqbTljA/AC9F3jh+V8JCy/bIoqDyF6LPFtwfcHnxduViZ9w6KgXV
 Lih795Tj8Y6dMi8uYy6CxWo90=
X-Google-Smtp-Source: AGHT+IFxU7dMmki4aqMy8EbFWevB4EGmmQCQxFT7Qy2X25Q9H7bJtb+/aMaGIqVV39iLa5PT+9Ecr6lOOzB2haB5H1A=
X-Received: by 2002:a2e:a99e:0:b0:30b:ecd6:b9d1 with SMTP id
 38308e7fff4ca-31e6bb78d87mr14441261fa.25.1746026038618; Wed, 30 Apr 2025
 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
 <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org> <87v7qnwesw.fsf@kernel.org>
 <CADgMGSt5gRFymqX3mtpiAx77b3a_cH0_2kR+8-Y5SwT25XpeQg@mail.gmail.com>
 <87v7qlrh55.fsf@kernel.org>
In-Reply-To: <87v7qlrh55.fsf@kernel.org>
From: george chan <gchan9527@gmail.com>
Date: Wed, 30 Apr 2025 23:13:46 +0800
X-Gm-Features: ATxdqUGkA9ArKVGBraTpfHpGIy2w4-zh9L0uPtlTkIvqhzYymIlhRmBIS_6rsnU
Message-ID: <CADgMGSt9xvWndKthrdMd+FSig6W=Kq3wnKw+ZTtg1mCHgFjSAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
To: Mattijs Korpershoek <mkorpershoek@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailman-Approved-At: Wed, 30 Apr 2025 18:36:59 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Mattijs,

Thx for reply. I like your attitude and appreciate it. There are many topic
get silent in the end.


> >> It's a bit unclear to me why it's impractical to repack the boot.img and
> >> specify the appropriate address. Could you elaborate ?
> >
> >
> > It is hard to ask less experience people to modify the boot img....I do
> > prefer no mod is the best. Why get life so complicated, my friend?
>
> Sorry, In my opinion this is not a valid argument. Why is patching the
> bootloader more complicated than repacking the boot.img ?
>

No, i mean repacking or modding boot.img is a very complicated thing for
less experience(not me! well, lazy, in other words, thats me!) people.
Sorry to get you confused.

Lets get it clear, for not going back and forth, in case of typo.

If you are talking about modding/repacking is easier than changing uboot
logic. Or there is already a similar logic exists, only make a small mod
for bootimg will solve the chain loading kind of thing. And then my opinion
is, it might be a short term solution for engineer and as the shorter the
better. I prefer to make "uboot for dummy" in mind. And it benefits those
lineage os phone user (including me) who also wanted to dual boot other os.
And easily update official los bootimg without any modding for every time;
that's why I hate dtbo partition.

If you agreed making uboot change is easier than modding bootimg then we
are same side, man.

Btw my proposed change of the loadaddr and kernel_addr_r conflict issue can
work like a band-aid short term solution and easily get reverted. I forsee
the proper fix is hard to get ready in short term.

Thx for letting me explain how I thought. Appreciated!

Regards,
George
